package org.tree.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import org.tree.domain.Criteria;
import org.tree.domain.PageDTO;
import org.tree.service.BoardService;
import org.tree.service.NoticeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping("/notice/*")
@AllArgsConstructor
@Log4j
public class NoticeController {
		
	private NoticeService service;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		
		
		log.info("controller list.....");
		model.addAttribute("list", service.getList(cri));
		log.info(service.getList(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(total, cri));
		System.out.println(total);
		
		
	}

	
	@GetMapping("/read")
	public void read(@RequestParam("n_code")int n_code, @ModelAttribute("cri")Criteria cri, Model model) {
		
		log.info("read....");
		model.addAttribute("notice", service.get(n_code));
		
		
	}
	
	
}
