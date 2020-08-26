<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		$('#writeBtn').on("click", function(){
			self.location = "/board/write";
		});
		
		//글작성 완료 후 완료창 띄우기
		var result = '<c:out value="${result}"/>';
		
		

	if(!(result === '' || history.state)) {
			
			if (result === 'updateSuccess') {
				alert("글 수정이 완료 되었습니다.");
			}else if(result===  'deleteSuccess') {
				alert("글 삭제 완료 되었습니다.");
			}else{
				
			alert("글 등록이 완료 되었습니다.");
			}
			
		}
			
		history.replaceState({},null, null);
		
		
		//페이지 넘기기
		var actionForm = $("#actionForm");
		$(".pagination a").on("click", function(e) {
			e.preventDefault();
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		//제목 클릭했을때, 값 넘겨서 글조회 이동
		$(".move").on("click", function(e){
			
			e.preventDefault();
			actionForm.append("<input type='hidden' name='b_code' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action","/board/read");
			actionForm.submit();
			
		});
			
		//검색버튼 이벤트 처리
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function (e) {
		
			if (!searchForm.find("option:selected").val()) {
				alert("검색 종류를 선택하세요");
				return false;
			}
			
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("검색어를 입력하세요");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
		});
		
	});
	
</script>
<!-- Table -->
<h2>자유게시판</h2>

<h4>자유롭게 글을 쓰세요</h4>
<!--board  -->
<table>
	<thead>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list }" var="board">
		<tr>
			<td>${board.b_code }</td>
			<td><a  class='move' href='<c:out value="${board.b_code }"/>'>${board.b_title }</a></td>
			<td>${board.username }</td>			
			<td><fmt:formatDate pattern="yyyy-MM-dd"
				value="${board.b_regdate }" /></td>
			<td>${board.b_hit }</td>
		</tr>
	</c:forEach>	
	</tbody>	
</table>
	<button class="button primary small" id="writeBtn">글쓰기</button>
<!-- 페이징 -->


<ul class="pagination">
	<c:if test="${pageMaker.prev}">
	<li><a href="${pageMaker.startPage -1 }" class="button">Prev</a></li>	
	</c:if>
	
	<!-- class active 효과 있음 -->
	<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
	<li><a href="${num }" class='page ${pageMaker.cri.pageNum == num ? "active" : "" }'>${num}</a></li>
	
	</c:forEach>
	
	<c:if test="${pageMaker.next}">
	<li><a href="${pageMaker.endPage +1 }" class="button">Next</a></li>
	</c:if>
</ul>

	<form id="searchForm" method="get" action="/board/list">
	<select name="type">
		<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>--</option>
		<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
		<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
		<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
		<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>제목+내용</option>
		<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목+작성자</option>
		<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected' : '' }"/>>제목+내용+작성자</option>		
	</select>
		<input type="text" name="keyword" id="query" placeholder="Search" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
		<button class="button primary icon solid fa-search">Search</button>
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"/>' />
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }"/>' />
	</form>
	
	<form id="actionForm" action="/board/list" method="get">
		
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }"/>' />
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }"/>' />
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"/>' />
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }"/>' />
	</form>
