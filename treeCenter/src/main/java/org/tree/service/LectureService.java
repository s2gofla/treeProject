package org.tree.service;

import java.util.List;

import org.tree.domain.Criteria;
import org.tree.domain.LectureCategoryVO;
import org.tree.domain.LectureVO;


public interface LectureService {
	
	public List<LectureVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	public List<LectureCategoryVO> getCategory();
	public LectureVO get(int l_code);
	
}
