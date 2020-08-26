<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function() {
	
		
		var operForm = $("#operForm");
		
		$("button[data-oper='update']").on("click",function(e) {
			
			operForm.attr("action","/board/update").submit();
		})
		
		$("button[data-oper='delete']").on("click", function(e) {
			operForm.attr("action","/board/delete").submit();
		})
		
		$("#listBtn").on("click",function(e){
			operForm.find("#b_code").remove();
			operForm.attr("action","/board/list");
			operForm.submit();
		});
		
	});
	
</script>
<!-- Table -->
<h2>글보기</h2>

<!--board  -->

		<div class="form-group">
			<div>
				<label>title</label>
				<input name="b_title" value='<c:out value="${board.b_title}"/>' readonly="readonly"/>
			</div>
			<div>
				<label>regdate</label>
				<input name="b_regdate" value='<fmt:formatDate pattern="yyyy-MM-dd"
				value="${board.b_regdate }" />' readonly="readonly"/>
			</div>
			<div>
				<label>hit</label>
				<input name="b_hit" value='<c:out value="${board.b_hit}"/>' readonly="readonly"/>
			</div>
			<div>
				<label>writer</label>
				<input name="username" value='<c:out value="${board.username}"/>' readonly="readonly"/>
			</div>			
			<div>
				<label>text area</label>
				<textarea rows="3" name="b_content" readonly="readonly"><c:out value="${board.b_content}"/></textarea>
			</div>		
			<button data-oper='update' class="button primary">글 수정하기</button>
			<button data-oper='delete' class="button primary">글 삭제하기</button>
			<button id="listBtn" class="button primary">글 목록</button>
		</div>
		
	<form id="operForm" action="/board/update" method="get">
		<input type="hidden" id="b_code" name="b_code" value='<c:out value="${board.b_code }"/>' />
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>' />
		<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' />
		<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>' />
		<input type="hidden" name="type" value='<c:out value="${cri.type }"/>' />
	</form>	
