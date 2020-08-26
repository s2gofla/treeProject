package org.tree.mapper;

import java.util.List;


import org.tree.domain.Criteria;
import org.tree.domain.NoticeVO;

public interface NoticeMapper {
	
	//목록가져오기
	public List<NoticeVO> getList(Criteria cri);

	
	//글보기
	public NoticeVO read(int n_code);

	
	//페이지 총갯수
	public int getTotalCount(Criteria cri);
}
