package org.tree.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.tree.domain.CustomUser;
import org.tree.domain.MemberVO;
import org.tree.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class UserDetailService implements UserDetailsService{
	
	
	@Setter(onMethod_ = {@Autowired} )
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.warn("user name =" + username);
		MemberVO vo = memberMapper.read(username);
		log.warn("memberMapper : " + vo);
		
		
		return vo == null ? null : new CustomUser(vo);
	}
	
	
}
