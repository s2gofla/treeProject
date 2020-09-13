package org.tree.mapper;

import org.tree.domain.AuthVO;
import org.tree.domain.MemberVO;

public interface MemberMapper {
	
	
	
	public MemberVO read(String username);
	
	//회원가입
	public int insertMember(MemberVO vo);
	
	//인증권한
	public int insertAuth(AuthVO authVo);
}
