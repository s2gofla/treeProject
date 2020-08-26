package org.tree.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.tree.domain.Criteria;
import org.tree.domain.LectureCategoryVO;
import org.tree.domain.LectureVO;

import org.tree.mapper.LectureMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class LectureServiceImpl implements LectureService{
	
	private LectureMapper mapper;
	
	@Override
	public List<LectureVO> getList(Criteria cri) {
		
		return mapper.getList(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	} 

	@Override
	public List<LectureCategoryVO> getCategory() {
		
		return mapper.getCategory();
	}

	@Override
	public LectureVO get(int l_code) {
		
		return mapper.read(l_code);
	}

}
