package the.cello.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import the.cello.notice.dto.NoticeDto;
import the.cello.notice.entity.Record;
import the.cello.notice.service.NoticeService;

@Controller
@SessionAttributes("noticeDto")
public class NoticeController extends BaseController {
	
	@Autowired
	private NoticeService noticeService;
	
	
	@RequestMapping("/notice")
	public String list(Model model,
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
		
		NoticeDto noticeDto = noticeService.getList(currentPage);
		model.addAttribute("noticeDto", noticeDto);
		
		return "notice/notice";
	}
	
	@RequestMapping("/notice/write")
	public String write_form() {
		return "notice/notice_write";
	}
	
	@RequestMapping("/notice/add")
	public void add_record(@ModelAttribute Record record, HttpServletRequest request, HttpServletResponse response) { 
		noticeService.saveOrUpdate(record);
		try {
			response.sendRedirect(request.getContextPath() + "/notice");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/notice/read/{id}")
	public String read_record(@PathVariable("id") long id, @RequestParam(value="read", required=false) boolean isRead, Model model, HttpServletRequest request, HttpServletResponse response) {
		try {
			Record record;
			if(isRead) {
				record = noticeService.getSimpleItem(id);
			} else {
				record = noticeService.getItem(id);
			}
			model.addAttribute("record", record);
		} catch(Exception ex) {
			try {
				response.sendRedirect(request.getContextPath() + "/notice");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "notice/notice_read";
		
	}
	
	@RequestMapping("/notice/modify/{id}")
	public String modify_form(@PathVariable("id") long id, Model model, HttpServletRequest request, HttpServletResponse response) {
		try {
			Record record = noticeService.getSimpleItem(id);
			model.addAttribute("record", record);
		} catch(Exception ex) {
			try {
				response.sendRedirect(request.getContextPath() + "/notice");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "notice/notice_modify";
	}
	
	@RequestMapping(value="/notice/modify/complete", method=RequestMethod.POST)
	public @ResponseBody void modify_record(@RequestParam int id, @RequestParam String content) {
		Record record = noticeService.getSimpleItem(id);
		record.setContent(content);
		noticeService.saveOrUpdate(record);
	}
	
	@RequestMapping("/notice/remove")
	public @ResponseBody void remove_records(@RequestParam(value="list[]") long[] removeList) {
		noticeService.delete(removeList);
	}
}
