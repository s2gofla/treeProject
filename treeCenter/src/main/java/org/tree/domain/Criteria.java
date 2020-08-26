package org.tree.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum; //기본값
	private int PerPage; //보일 블럭갯수
	private int amount; //보일 페이지
	
	private String type; //검색타입
	private String keyword; //키워드
	
	public Criteria() {
		this(1, 10, 10);
	}
	

	public Criteria(int pageNum, int amount, int PerPage) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
		this.PerPage = PerPage;
	}
	
	public String[] getTypeArr() {
		
		return type == null ? new String[] {} : type.split("");
		
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
			.queryParam("pageNum", this.getPageNum())
			.queryParam("amount", this.getAmount())
			.queryParam("keyword", this.getKeyword())
			.queryParam("type", this.getType());
			
		return builder.toUriString();
	}
	
	
}
