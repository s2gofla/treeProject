package org.tree.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/login/*")
@Log4j
public class LoginController {

	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {

		if (error != null) {
			model.addAttribute("error", "login Error Check your Account");
		}
		
		if (logout != null) {
			model.addAttribute("logout", "logout!!");
		}
	
	} 
	
}
