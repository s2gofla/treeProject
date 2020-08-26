package org.tree.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.tree.domain.BoardCommentVO;
import org.tree.mapper.BoardCommentMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardCommentServiceImpl implements BoardCommentService {

	private BoardCommentMapper mapper;
	
	@Override
	public int register(BoardCommentVO boardCom) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardCommentVO> getList(int b_code) {
		
		log.info("boardComment Service..list");
		
		
		return mapper.read(b_code);
	}

	@Override
	public boolean update(BoardCommentVO boardCom) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(int bc_code) {
		// TODO Auto-generated method stub
		return false;
	}

}
