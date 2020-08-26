package org.tree.service;

import java.util.List;

import org.tree.domain.BoardVO;
import org.tree.domain.Criteria;
import org.tree.domain.ReviewVO;



public interface ReviewService {
	
	public List<ReviewVO> getList(Criteria cri);
	public void register(ReviewVO board);
	public ReviewVO get(int rev_code);
	public int getTotal(Criteria cri);
	public boolean update(ReviewVO board);
	public boolean delete(int rev_code);
	
}
