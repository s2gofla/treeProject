package org.tree.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardCommentVO {
	
	private int bc_code;
	private int b_code;
	private String username;
	private String bc_content;
	private Date bc_regdate;
	private int bc_ref;
	private int bc_step;
	private int bc_depth;
}
