package org.tree.service;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.tree.domain.AuthVO;
import org.tree.domain.MemberVO;
import org.tree.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class MemberSeriveImpl implements MemberService {
	
	
	private MemberMapper mapper;
	

	private BCryptPasswordEncoder pwEncoder;
	
	@Transactional
	@Override
	public int joinMember(MemberVO vo) {
		
		log.info("member Service..." + vo);
		int result = 0 ;
		try {
			AuthVO authVo = new AuthVO();
			
			String pwd = vo.getPassword();
			vo.setPassword(pwEncoder.encode(pwd));
		
			
			result = mapper.insertMember(vo);
			System.out.println(result);
			
			
			authVo.setAuthority("ROLE_MEMBER");
			authVo.setUsername(vo.getUsername());
			
			log.info("auth ... " + authVo);
			result = mapper.insertAuth(authVo);
			
			log.info("end...");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return result;
	}

}
