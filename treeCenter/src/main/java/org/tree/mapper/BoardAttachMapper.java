package org.tree.mapper;

import java.util.List;

import org.tree.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByB_code(int b_code);
	
}
