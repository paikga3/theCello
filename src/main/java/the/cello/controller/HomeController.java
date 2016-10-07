package the.cello.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController extends BaseController {
	
	@RequestMapping("/home")
	public String home() {
		return "home/home";
	}
	
	@RequestMapping("/room")
	public String room() {
		return "room/room";
	}
	
	@RequestMapping("/price")
	public String price() {
		return "price/price";
	}
	
	@RequestMapping("/map")
	public String map() {
		return "map/map";
	}
	
}
