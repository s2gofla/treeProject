<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function() {
	
		
		var operForm = $("#operForm");
		
		$("#listBtn").on("click",function(e){
			operForm.find("#n_code").remove();
			operForm.attr("action","/notice/list");
			operForm.submit();
		});
		
	});
	
</script>
<!-- Table -->
<h2>공지사항 보기</h2>

<!--board  -->

		<div class="form-group">
			<div>
				<label>title</label>
				<input name="n_title" value='<c:out value="${notice.n_title}"/>' readonly="readonly"/>
			</div>
			<div>
				<label>regdate</label>
				<input name="n_regdate" value='<fmt:formatDate pattern="yyyy-MM-dd"
				value="${notice.n_regdate }" />' readonly="readonly"/>
			</div>
			<div>
				<label>hit</label>
				<input name="n_hit" value='<c:out value="${notice.n_hit}"/>' readonly="readonly"/>
			</div>			
			<div>
				<label>text area</label>
				<textarea rows="30" name="b_content" readonly="readonly">
				<c:out value="${notice.n_img}"/>
				<c:out value="${notice.n_content}"/>
				</textarea>
			</div>		
			<button id="listBtn" class="button primary">글 목록</button>
		</div>
		
	<form id="operForm" action="/notice/update" method="get">
		<input type="hidden" id="n_code" name="b_code" value='<c:out value="${notice.n_code }"/>' />
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>' />
		<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' />
		<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>' />
		<input type="hidden" name="type" value='<c:out value="${cri.type }"/>' />
	</form>	
