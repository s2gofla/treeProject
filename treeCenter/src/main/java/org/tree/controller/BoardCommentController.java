package org.tree.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import org.tree.domain.BoardCommentVO;

import org.tree.service.BoardCommentService;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;



@RestController
@RequestMapping("/comment/*")
@Log4j
@AllArgsConstructor
public class BoardCommentController {
	

	private BoardCommentService service;
	
	@GetMapping(value="/pages/{b_code}", produces = {MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE} )
	public ResponseEntity<List<BoardCommentVO>> list(@PathVariable("b_code")int b_code) {
	
		log.info("list....");
		return new ResponseEntity<>(service.getList(b_code), HttpStatus.OK);
	}
		
	

}
