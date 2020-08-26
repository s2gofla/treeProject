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
import org.tree.domain.ReviewVO;
import org.tree.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/review/*")
@AllArgsConstructor
@Log4j
public class ReviewController {
		
	private ReviewService service;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		
		
		log.info("controller list.....");
		model.addAttribute("list", service.getList(cri));
		log.info(service.getList(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(total, cri));
		System.out.println(total);
		
		
	}
	
	@GetMapping("/write")
	public void write() {
		
	}
	
	@PostMapping("/write")
	public String Write(ReviewVO board, RedirectAttributes rttr) {
		
		log.info("write완료:" + board);
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getRev_code());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/read", "/update"})
	public void read(@RequestParam("b_code")int b_code, @ModelAttribute("cri")Criteria cri, Model model) {
		
		log.info("read or update....");
		model.addAttribute("board", service.get(b_code));
		
		
	}
	
	@PostMapping("/update")
	public String update(ReviewVO review, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("update: " + review);
		
		if (service.update(review)) {
			
			rttr.addFlashAttribute("result", "updateSuccess");
		}

		return "redirect:/board/list" + cri.getListLink();
	}
	
	@GetMapping
	public String delete(@RequestParam("b_code")int b_code, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove");
		if (service.delete(b_code)) {
			rttr.addFlashAttribute("result", "deleteSuccess");
		}

		
		return "redirect:/board/list" + cri.getListLink();  
	}
	
}
