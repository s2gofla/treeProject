package org.tree.domain;

import java.util.Date;

import lombok.Data;

@Data
public class LectureVO {
	
	private int l_code;
	private String l_title;
	private Date l_date;
	private String l_time;
	private String l_loc;
	private String lecturer;
	private int limit;
	private String c_name;
	private String l_img;
	private String l_content;

	
	
}
