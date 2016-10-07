package the.cello.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ModelAttribute;

public class BaseController {
	protected Authentication getAuthentication() {
		return SecurityContextHolder.getContext().getAuthentication();
	}
	
	@ModelAttribute("isADMIN")
	public boolean getShowLoginLink() {
		for(GrantedAuthority authority : getAuthentication().getAuthorities()) {
			if(authority.getAuthority().equals("ROLE_ADMIN")) {
				return true;
			}
		}
		return false;
	}
	
	
}
