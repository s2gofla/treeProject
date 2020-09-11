package org.tree.domain;

import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String username;
	private String password;
	private String name;
	private String phone;
	private String email;
	private int enabled;
	
	private List<AuthVO> authList;
	
}
