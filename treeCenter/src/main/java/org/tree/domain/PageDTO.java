package org.tree.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(int total, Criteria cri) {
	
		this.total = total;
		this.cri = cri;
		

		this.startPage = (cri.getPageNum()-1)/cri.getPerPage() * cri.getPerPage()+1;
		this.endPage = this.startPage + cri.getPerPage()-1;
		System.out.println(startPage + ": start값");
		System.out.println(endPage +": end값");
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		
	}
	
	
	
	
}
