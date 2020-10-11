package org.tree.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.tree.domain.AttachFileDTO;
import org.tree.domain.BoardVO;
import org.tree.mapper.BoardMapper;
import org.tree.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;


@Controller
@Log4j
@AllArgsConstructor
public class SearchController {
	

	private BoardService service;
	private BoardMapper mapper;
	
	//자동완성
	@RequestMapping(value = "/searchJson", produces = "application/json")
	@ResponseBody
	public ResponseEntity<List<String>> searchWord(@RequestParam("keyword")String term) {
		log.info("자동완성 controller....접속");
		
		log.info("입력된 값:" + term);
		log.info(mapper.getWord(term));
		log.info(service.getAuto(term));
		
		return new ResponseEntity<List<String>>(service.getAuto(term), HttpStatus.OK);
		
	}
}
