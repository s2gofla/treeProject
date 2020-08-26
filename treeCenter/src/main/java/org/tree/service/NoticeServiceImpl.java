 package org.tree.service;

import java.util.List;


import org.springframework.stereotype.Service;

import org.tree.domain.Criteria;
import org.tree.domain.NoticeVO;

import org.tree.mapper.NoticeMapper;

import lombok.AllArgsConstructor;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService {
	
	
	private NoticeMapper mapper;
	
	
	@Override
	public List<NoticeVO> getList(Criteria cri) {
			
		log.info("service-getList......");
		
		return mapper.getList(cri);
	}


	@Override
	public int getTotal(Criteria cri) {
		log.info("service-getTotal......");
		
		return mapper.getTotalCount(cri);
	}


	@Override
	public NoticeVO get(int n_code) {
		log.info("service get...");
		
		return mapper.read(n_code);
	}

}
