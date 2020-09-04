package org.tree.service;

import java.util.List;

import org.tree.domain.BoardCommentVO;

public interface BoardCommentService {

	
	public int register(BoardCommentVO boardCom);
	public List<BoardCommentVO> getList(int b_code);
	public int update(BoardCommentVO boardCom);
	public int delete(int bc_code); 
}
