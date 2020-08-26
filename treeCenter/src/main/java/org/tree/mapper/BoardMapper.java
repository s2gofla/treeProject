package org.tree.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.tree.domain.BoardVO;
import org.tree.domain.Criteria;

public interface BoardMapper {
	
	//목록가져오기
	public List<BoardVO> getList(Criteria cri);
	
	//글쓰기
	public void insertSelectKey(BoardVO board);
	
	//글보기
	public BoardVO read(int b_code);
	
	//글수정
	public int update(BoardVO board);
	
	//글삭제
	
	public int delete(int b_code);
	
	//페이지 총갯수
	public int getTotalCount(Criteria cri);
}
