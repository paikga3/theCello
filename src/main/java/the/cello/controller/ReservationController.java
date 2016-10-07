package the.cello.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import the.cello.reservation.dao.RevTokenDao;
import the.cello.reservation.entity.Reservation;
import the.cello.reservation.entity.Token;
import the.cello.reservation.service.RevService;

@SessionAttributes("info")
@Controller
public class ReservationController extends BaseController {

	
	@Autowired
	private RevService revService;
	
	@Autowired
	private RevTokenDao tokenDao;
	
	@RequestMapping("/reservation")
	public String reservationMain() {
		return "reservation/reservation";
	}
	
	@RequestMapping("/revconfirm")
	public String revConfirm() {
		return "reservation/confirm";
	}
	
	
	@RequestMapping(value="/reservation/cal", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> calPrice(@RequestBody Map<String, Object> params, Model model, HttpServletRequest request) {
		request.getSession(true);
		Map<String, Object> result = revService.getPrice(params);
		model.addAttribute("info", result.get("info"));
		return result;
	}
	
	@RequestMapping(value="/reservation/doRev", method=RequestMethod.POST)
	public void doReservation(@ModelAttribute("info") Reservation info, HttpServletRequest request, HttpServletResponse response) {
		try {
			if(info.getRevPrice() == 0) {
				response.sendRedirect(request.getContextPath() + "/reservation");
				return;
			}
			
			while(revService.getItem(info.getId()) != null) {
				info.setId(System.currentTimeMillis());
			}
			revService.saveOrUpdate(info);
			revService.sendSms(info);
			response.sendRedirect(request.getContextPath() + "/revconfirm");
			return;
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/reservation/getinfo", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getInfo(@RequestParam long id) {
		Reservation rev = revService.getItem(id);
		return revService.itemToMap(rev);
	}
	
	@RequestMapping(value="/reservation/regToken", method=RequestMethod.POST)
	@ResponseBody
	public void regToken(@RequestParam String key, @RequestParam(required=false) String token) {
		if(key.equals("TOKEN_REG")) {
			Token tokenEntity = new Token();
			tokenEntity.setId(1L);
			tokenEntity.setToken(token);
			tokenDao.saveOrUpdate(tokenEntity);
		} else if(key.equals("TOKEN_DEL")) {
			List<Token> list = tokenDao.getList();
			if(list.size() != 0) {
				Token tokenEntity = list.get(0);
				tokenDao.delete(tokenEntity.getId());
			}
			
		}
	}
	
	@RequestMapping(value="/reservation/receiveSms", method=RequestMethod.POST)
	@ResponseBody
	public void receiveSms(@RequestParam String msg) {
		revService.sendConfirmMessage(msg);
	}
}
