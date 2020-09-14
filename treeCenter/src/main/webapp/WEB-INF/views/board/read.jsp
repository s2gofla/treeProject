<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="/resources/js/boardComment.js?var=1"></script>



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
					
					
				str += '<li id="list'+list[i].bc_code+'">';
				str += '<div class="flex-col">';
				str += '<div class="head">';
				str += '<strong class="left">'+list[i].username+'</strong>';
				str += '<small class="right">'+commentService.displayTime(list[i].bc_regdate)+'</small></div>';
				str += '<div class="body-text"><p>'+list[i].bc_content+'</p></div>';
				str += '<div class="body-button flex justify-right" data-bc_code="'+list[i].bc_code+'">';
				str += '<div class="small button-none commentDelete">삭제</div>';
				str += '<div class="small button-none commentUpdate" data-toggle="modal" data-target="#myModal">수정</div>';
				str += '</div></div></li>';
				}
			
				commentUl.html(str);
				
			});//end getList
		}//end showList
		
		//댓글버튼 처리
		$("#commentBtn").on("click", function() {
			
			var btnText = $(this).html();
			
			$(".new-comment").slideToggle();
			if (btnText == "댓글취소") {
				
				$(this).html("댓글쓰기");
			}else {
			
				$(this).html("댓글취소");
				$("textarea[name='bc_content']").val("").focus();
							
			}
			
		})
		
	
		
		//새댓글추가
		$("#commentRegisterBtn").on("click", function(e) {
			var newComment = $(".new-comment");
			var username = newComment.find("input[name=username]");
			var bc_content = newComment.find("#bc_content");
			
	
			var comment = {
					username : username.val(),
					bc_content : bc_content.val(),
					b_code : b_codeValue
			};

			
			commentService.add(comment, function(result) {
				
				alert(result);
				
				$(".new-comment").hide();
				$("#commentBtn").html("댓글쓰기");
				
				showList();
				
			})
			
		});
	
		//댓글 삭제
		
		$(".chat").on("click",".commentDelete",function() {
			var bc_code = $(this).parent().data("bc_code");
			
			commentService.remove(bc_code, function(result) {
				alert(result);
				showList();
			})
			
		});
		
		//댓글 수정 클릭시, 수정창 보이기
		$(".chat").on("click",".commentUpdate", function() {
			
	
			var bc_code = $(this).parent().data("bc_code");
			var username = $("#list"+bc_code).find("strong").text();
			var content = $("#list"+bc_code).find("p").text();	
			$(".modal").find("input[name=bc_code]").val(bc_code);
			$(".modal").find("input[name=username]").val(username);
			$(".modal").find("textarea").val(content);

		})
		
		$("#updateModal").on("click", function(e) {
			
			var bc_code = $("input[name=bc_code]").val();
			var content = $("#Comment_content").val();
			
			var comment = {bc_code:bc_code, bc_content:content};
			
			
			
			
			commentService.update(comment, function(result) {
				alert(result);
				$(".modal").modal("hide");
				showList();
			
			});
			
			
		});
		
	}); //function end
	
	
</script>
	
<script>



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
			<sec:authentication property="principal" var="pinfo"/>
			<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.username eq board.username }">
			<button data-oper='update' class="button primary">글 수정하기</button>
			<button data-oper='delete' class="button primary">글 삭제하기</button>
			</c:if>
			</sec:authorize>		
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
		<sec:authorize access="isAuthenticated()">
		<button class="right button small" id="commentBtn">댓글쓰기</button>
		</sec:authorize>
	</div>
	<div class="new-comment box" style="display: none;">
			<div>
				<label>writer</label>
				<input name="username" value='<c:out value="${board.username}"/>' readonly="readonly"/>
			</div>
			<div>
				<label>text area</label>
				<textarea rows="3" name="bc_content" id="bc_content"></textarea>
			</div>
			<button class="right button primary small" id="commentRegisterBtn">댓글등록</button>	
	</div>
	
	<div class="commentBody">
		<ul class="chat alt">
			<!-- start comment  -->
			<li class="">
				<div class="flex-col">
					<div class="head">
					
					</div>
					<div class="body-text">
						
					</div>
					<div class="body-button">
						
					</div>
				</div>
			</li>
			<!-- end comment  -->
		</ul>

	</div>
	
</div>

	
	<!-- Modal -->

	<div class="modal" tabindex="-1" role="dialog" id="myModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" style="line-height: 2">댓글 수정하기</h5>
					<button type="button" class="small primary" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true" style="font-size: 2em">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input type="hidden" name="bc_code" value="" />
					<div>
						<label>writer</label> <input name="username" value=""
							readonly="readonly" />
					</div>
					<div>
						<label>text area</label>
						<textarea rows="3" name="bc_content" id="Comment_content"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="primary small"
						data-dismiss="modal">취소</button>
					<button type="button" class="primary small" id="updateModal">댓글 수정등록</button>
				</div>
			</div>
		</div>
	</div>
