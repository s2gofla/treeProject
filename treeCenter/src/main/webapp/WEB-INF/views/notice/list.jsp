<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		
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
			actionForm.append("<input type='hidden' name='n_code' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action","/notice/read");
			actionForm.submit();
			
		});
			
		
	});
	
</script>
<!-- Table -->
<h2>공지사항</h2>


<!--notice  -->
<table>
	<thead>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list }" var="notice">
		<tr>
			<td>${notice.n_code }</td>
			<td><a  class='move' href='<c:out value="${notice.n_code }"/>'>${notice.n_title }</a></td>		
			<td><fmt:formatDate pattern="yyyy-MM-dd"
				value="${notice.n_regdate }" /></td>
			<td>${notice.n_hit }</td>
		</tr>
	</c:forEach>	
	</tbody>	
</table>

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
	
	<form id="actionForm" action="/notice/list" method="get">
		
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }"/>' />
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }"/>' />
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"/>' />
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }"/>' />
	</form>
