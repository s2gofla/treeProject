package org.tree.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	
	private int rev_code;
	private int res_code;
	private String rev_img;
	private int rev_hit;
	private String rev_title;
	private Date rev_regdate;
	private String rev_content;


	
	
}
