package org.tree.controller;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.tree.domain.MemberVO;
import org.tree.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
@Log4j
public class LoginController {
	
	private MemberService service;
	
	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {
		
		log.info(error);
		log.info(logout);
		
		if (error != null) {
			model.addAttribute("error", "login Error Check your Account");
		}
		
		if (logout != null) {
			model.addAttribute("logout", "logout!!");
		}
	
	} 
	
	@GetMapping("/signUp")
	public void singUp() {
		
	}
	
	@PostMapping("/signUp")
	public String singUpInput(MemberVO vo, RedirectAttributes rttr) {
		
		log.info("singUp post..." + vo);
		try {
			
			int result = service.joinMember(vo);
			
			if (result == 1) {
				
				rttr.addFlashAttribute("success","회원가입 성공");
				return "redirect:/";
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return null;
	}
}
