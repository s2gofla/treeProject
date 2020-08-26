package org.tree.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	
	private int n_code;
	private String n_title;
	private Date n_regdate;
	private int n_hit;
	private String n_img;
	private String n_content;
}
