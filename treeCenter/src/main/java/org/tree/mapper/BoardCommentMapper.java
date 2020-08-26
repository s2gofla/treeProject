package org.tree.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.tree.domain.BoardCommentVO;

public interface BoardCommentMapper {
	
	//새댓글
	public int insert(BoardCommentVO boardCom);
	
	//댓글보기
	public List<BoardCommentVO> read(@Param("b_code") int b_code);

	//댓글삭제
	public int delete(int bc_code);
	
	//댓글수정
	public int update(BoardCommentVO boardCom);
}