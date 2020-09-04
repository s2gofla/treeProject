package org.tree.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.tree.domain.BoardCommentVO;
import org.tree.mapper.BoardCommentMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class BoardCommentServiceImpl implements BoardCommentService {

	private BoardCommentMapper mapper;
	
	@Override
	public int register(BoardCommentVO boardCom) {
		log.info("comment register..");
		return mapper.insert(boardCom);
	}

	@Override
	public List<BoardCommentVO> getList(int b_code) {

		log.info("boardComment Service..list");
		
		
		return mapper.read(b_code);		
	
	}

	@Override
	public int update(BoardCommentVO boardCom) {
		
		log.info("update");
		
		return mapper.update(boardCom);
	}

	@Override
	public int delete(int bc_code) {
		
		log.info("delete .... ");
		
		return mapper.delete(bc_code);
	}

}
