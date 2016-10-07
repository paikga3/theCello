package the.cello.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.ConversionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import the.cello.admin.service.AdminService;
import the.cello.reservation.entity.Reservation;

@Controller
public class AdminController extends BaseController {
	
	@Autowired
	AdminService adminService;
	@Autowired
	ConversionService conversionService;
	
	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		dataBinder.setConversionService(this.conversionService);
	}
	
	@RequestMapping("/adminlogin")
	public String adminLogin() {
		return "/admin/admin_login";
	}
	
	@RequestMapping("/admin")
	public String admin() {
		return "admin/admin";
	}
	
	@RequestMapping(value="/admin/revList", method=RequestMethod.POST)
	public String revList(Model model) {
		List<Reservation> list = adminService.getList();
		model.addAttribute("list", list);
		return "admin/admin_revList";
	}
	
	@RequestMapping(value="/admin/revDetail", method=RequestMethod.GET)
	public String revDetail(@RequestParam long id, Model model) {
		Reservation detail = adminService.getItem(id);
		model.addAttribute("detail", detail);
		model.addAttribute("from", adminService.getString(detail.getRevFromTime()));
		model.addAttribute("to", adminService.getString(detail.getRevToTime()));
		return "admin/admin_revDetail";
	}
	
	@RequestMapping(value="/admin/revUpdate", method=RequestMethod.POST)
	@ResponseBody
	public void revUpdate(Reservation item) {
		adminService.saveOrUpdate(item);
	}
	
	@RequestMapping(value="/admin/revDelete", method=RequestMethod.POST)
	@ResponseBody
	public void revDelete(long id) {
		adminService.delete(id);
	}
	
	@RequestMapping(value="/admin/cleanExpired", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> revCleanExpired() {
		int count = adminService.revCleanExpired();
		Map<String, String> jsonRes = new HashMap<String, String>();
		jsonRes.put("count", count + "");
		return jsonRes;
	}
	
}
