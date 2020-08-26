<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function() {

	var formObj = $("form");
	
	$('#listbtn').on("click", function(e) {
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		
		
		if (operation === 'list') {
			
			formObj.attr("action","/board/list").attr("method","get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			formObj.empty();
			
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
			
		}
		
		formObj.submit();
		
	});
	
	
	
})


	
</script>
<!-- Table -->
<h2>글수정</h2>

<!--board  -->
<form role="form" action="/board/update" method="post">
		<div class="form-group">
			<div>
				<label>title</label>
				<input name="b_title" value='<c:out value="${board.b_title }"></c:out>'>
			</div>
			<div>
				<label>writer</label>
				<input name="username" value="<c:out value="${board.username }"></c:out>"/>
			</div>			
			<div>
				<label>text area</label>
				<textarea rows="3" name="b_content"><c:out value="${board.b_content }"></c:out></textarea>
			</div>		
			<button type="submit" data-oper="update">작성완료</button>
			<button type="submit" id="listbtn" data-oper="list">글목록</button>
		</div>
			
			<input type="hidden" name="b_code" value="<c:out value='${board.b_code }'></c:out>" />
			<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>' />
			<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' />
			<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>' />
			<input type="hidden" name="type" value='<c:out value="${cri.type }"/>' />
			
	</form>