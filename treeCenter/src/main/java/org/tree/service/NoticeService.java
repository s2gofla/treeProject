package org.tree.service;

import java.util.List;


import org.tree.domain.Criteria;
import org.tree.domain.NoticeVO;



public interface NoticeService {
	
	public List<NoticeVO> getList(Criteria cri);
	public NoticeVO get(int n_code);
	public int getTotal(Criteria cri);
	
}
