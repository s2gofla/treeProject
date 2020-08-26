package org.tree.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.tree.domain.Criteria;
import org.tree.domain.ReviewVO;

public interface ReviewMapper {
	
	//목록가져오기
	public List<ReviewVO> getList(Criteria cri);
	
	//글쓰기
	public void insertSelectKey(ReviewVO review);
	
	//글보기
	public ReviewVO read(int rev_code);
	
	//글수정
	public int update(ReviewVO review);
	
	//글삭제
	
	public int delete(int rev_code);
	
	//페이지 총갯수
	public int getTotalCount(Criteria cri);
}
