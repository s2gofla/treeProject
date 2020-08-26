package org.tree.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.tree.domain.BoardVO;
import org.tree.domain.Criteria;
import org.tree.domain.PageDTO;
import org.tree.service.LectureService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/myPage/*")
@AllArgsConstructor
@Log4j
public class MyPageController {
		
	private LectureService service;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
	
		
	}
		
	@GetMapping("/read")
	public void read(@RequestParam("l_code")int l_code,@RequestParam("c_name")String c_name, @ModelAttribute("cri")Criteria cri, Model model) {
		
		log.info("read");
		model.addAttribute("lecture", service.get(l_code));
		model.addAttribute("c_name", c_name);
		
		
	}
	

}
