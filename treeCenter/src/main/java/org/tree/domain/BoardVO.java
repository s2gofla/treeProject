package org.tree.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardVO {
	
	private int b_code;
	private String b_title;
	private Date b_regdate;
	private int b_hit;
	private String b_img;
	private String username;
	private String b_content;
	
	
	
	
}
