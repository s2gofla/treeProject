 package org.tree.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.tree.domain.BoardVO;
import org.tree.domain.Criteria;
import org.tree.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	
	private BoardMapper mapper;
	
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
			
		log.info("service-getList......");
		
		return mapper.getList(cri);
	}


	@Override
	public int getTotal(Criteria cri) {
		log.info("service-getTotal......");
		
		return mapper.getTotalCount(cri);
	}


	@Override
	public void register(BoardVO board) {
		
		log.info("service register...");
		
		mapper.insertSelectKey(board);
		
	}


	@Override
	public BoardVO get(int b_code) {
		log.info("service get...");
		
		return mapper.read(b_code);
	}


	@Override
	public boolean update(BoardVO board) {
		log.info("update service...");
		return mapper.update(board) == 1;
	}


	@Override
	public boolean delete(int b_code) {
		log.info("delete service...");
		return mapper.delete(b_code) == 1;
	}

}
