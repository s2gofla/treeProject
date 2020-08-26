package org.tree.mapper;

import java.util.List;


import org.tree.domain.Criteria;
import org.tree.domain.LectureCategoryVO;
import org.tree.domain.LectureVO;


public interface LectureMapper {
	
	//목록 가져오기
	public List<LectureVO> getList(Criteria cri);
	
	//페이지 총갯수
	public int getTotalCount(Criteria cri);
	
	//강의 카테고리 가져오기
	public List<LectureCategoryVO> getCategory();
	
	//한 강의정보 가져오기
	public LectureVO read(int l_code);
}
