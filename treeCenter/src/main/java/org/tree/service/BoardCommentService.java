package org.tree.service;

import java.util.List;

import org.tree.domain.BoardCommentVO;

public interface BoardCommentService {
		
	public int register(BoardCommentVO boardCom);
	public List<BoardCommentVO> getList(int b_code);
	public boolean update(BoardCommentVO boardCom);
	public boolean delete(int bc_code); 
}
