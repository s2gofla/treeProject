<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/resources/js/boardComment.js"></script>
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
		
		//댓글 목록 처리
		var b_codeValue ='<c:out value="${board.b_code}"/>';
		var commentUl = $(".chat");
		
		showList();
		
		function showList() {
			commentService.getList({b_code : b_codeValue}, function(list){
				var str = "";
				
				if (list == null || list.length ==0) {
					commentUl.html("");
				
					return;
				}
				
				for (var i = 0, len = list.length||0; i < len; i++) {
					
					
				str += '<li class="" data-bc_code="'+list[i].bc_code+'">';
				str += '<div class="flex-col">';
				str += '<div class="head">';
				str += '<strong class="left">'+list[i].username+'</strong>';
				str += '<small class="right">'+commentService.displayTime(list[i].bc_regdate)+'</small></div>';
				str += '<div class="body-text"><p>'+list[i].bc_content+'</p></div></div></li>';
				}
			
				commentUl.html(str);
				
			});//end getList
		}//end showList

		
		
	}); //function end
	
	
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

<div class="commentBoard flex-col">
	<div class="commentHead">
		<h3 class="left">댓글보기</h3>
		<button class="right button small">댓글쓰기</button>
	</div>
	<div class="commentBody">
		<ul class="chat alt">
			<!-- start comment  -->
			<li class="" data-bc_code=''>
				<div class="flex-col">
					<div class="head">
						<strong class="left">username</strong> <small class="right">날짜</small>
					</div>
					<div class="body-text">
						<p>내용</p>
					</div>
				</div>
			</li>
			<!-- end comment  -->
		</ul>

	</div>
</div>
