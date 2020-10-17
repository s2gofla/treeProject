package org.tree.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.tree.domain.BoardVO;
import org.tree.domain.Criteria;
import org.tree.domain.PageDTO;
import org.tree.service.BoardService;



import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
public class BoardController {
		
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri, @RequestParam(value = "optionType", required = false, defaultValue = "list" )String option) {
		
		model.addAttribute("option", option);
		
		log.info("option값" + option);
		
		log.info("controller list..... ");
		model.addAttribute("list", service.getList(cri));
		log.info(service.getList(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(total, cri));
		System.out.println(total);
		
		
	}
	
	/*
	@RequestMapping("/listAjax")
	public ResponseEntity<String> list(Model model, Criteria cri, @RequestParam("sortValue")String sortValue ) {
		

		log.info("controller listAjax..... ");
		if (sortValue.equals("list")) {
			
			model.addAttribute("list", service.getList(cri));
			log.info(service.getList(cri));
			int total = service.getTotal(cri);
			model.addAttribute("pageMaker", new PageDTO(total, cri));
			System.out.println(total);
		 
			
			
		}
		
		
		
		return new ResponseEntity<String>("success",HttpStatus.OK);
		
		
	}
	*/
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/write")
	public void write() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/write")
	public String Write(BoardVO board, MultipartFile[] uploadFile ,RedirectAttributes rttr) {
		
		log.info("write완료:" + board);
		
		//첨부파일이 존재할때
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getB_code());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/read", "/update"})
	public void read(@RequestParam("b_code")int b_code, @ModelAttribute("cri")Criteria cri, Model model) {
		
		log.info("read or update....");
		model.addAttribute("board", service.get(b_code));
		
		
	}
	
	
	@PostMapping("/update")
	public String update(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("update: " + board);
		
		if (service.update(board)) {
			
			rttr.addFlashAttribute("result", "updateSuccess");
		}

		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #username")
	@GetMapping("/delete")
	public String delete(@RequestParam("b_code")int b_code, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove");
		if (service.delete(b_code)) {
			rttr.addFlashAttribute("result", "deleteSuccess");
		}

		
		return "redirect:/board/list" + cri.getListLink();  
	}
	
	
	
	
	
}
