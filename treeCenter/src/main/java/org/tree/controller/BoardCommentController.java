package org.tree.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	
	@PostMapping(value="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> insert(@RequestBody BoardCommentVO boardCom)  {
		log.info("insert ....  boardCom VO:" + boardCom);
		int insertCount = service.register(boardCom);
		
		log.info("insertCount" + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success",HttpStatus.OK) :
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="/{bc_code}", produces = {"application/text; charset=utf8"})
	public ResponseEntity<String> remove(@PathVariable("bc_code")int bc_code) {
		
		log.info("remove.....");
		
		return service.delete(bc_code) == 1 ? new ResponseEntity<>("글 삭제 성공",HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{bc_code}", consumes = "application/json",
			produces = {"application/text; charset=utf8"})
	public ResponseEntity<String> update(@RequestBody BoardCommentVO boardCom, @PathVariable("bc_code")int bc_code) {
		boardCom.setBc_code(bc_code);
		
		log.info("bc_code:"+ bc_code);
		log.info("update :" + boardCom);
		
		return service.update(boardCom) == 1 ? new ResponseEntity<>("글 수정 성공", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
