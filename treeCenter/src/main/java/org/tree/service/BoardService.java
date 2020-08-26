package org.tree.service;

import java.util.List;

import org.tree.domain.BoardVO;
import org.tree.domain.Criteria;



public interface BoardService {
	
	public List<BoardVO> getList(Criteria cri);
	public void register(BoardVO board);
	public BoardVO get(int b_code);
	public int getTotal(Criteria cri);
	public boolean update(BoardVO board);
	public boolean delete(int b_code);
	
}
