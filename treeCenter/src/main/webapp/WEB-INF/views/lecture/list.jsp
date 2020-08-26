<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
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
			actionForm.append("<input type='hidden' name='l_code' value='"+$(this).attr("href")+"'>");
			actionForm.append("<input type='hidden' name='c_name' value='"+$(this).next().val()+"'>");
			actionForm.attr("action","/lecture/read");
			actionForm.submit();
			
		});
		
	});

</script>
<h2>강연 목록</h2>

<div class="col-12">
	<select name="demo-category" id="demo-category">
		<option value="">-Category-</option>
 		<c:forEach items="${category }" var ="ct">
			<option value='<c:out value="${ct.c_code}"/>'><c:out value="${ct.c_name }"/></option>
		</c:forEach> 
	</select>
</div>

<div class="posts">
	
	<c:forEach items="${list }" var="lec">
	<article>
		<a href="<c:out value="${lec.l_code }"/>" class="image move"><img src="/resources/l_img/${lec.l_img }" alt="" /></a>
		<input type="hidden" name="c_name" value='<c:out value="${lec.c_name }"/>' />
		<h3>강연제목 : <c:out value="${lec.l_title }"/></h3>
		<p>강연분류 : <c:out value="${lec.c_name }"/></p>
		<p>강연날짜 : <fmt:formatDate pattern="yyyy-MM-dd" value="${lec.l_date }" /></p>
		<p>강연시간 : <c:out value="${lec.l_time }"/></p>
		<p>강연장소 : <c:out value="${lec.l_loc }"/></p>
		<p>강연자명 : <c:out value="${lec.lecturer }"/></p>
	</article>
	</c:forEach>
</div>


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

<form id="actionForm" action="/lecture/list" method="get">
		
	
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }"/>' />
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }"/>' />
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"/>' />
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }"/>' />
</form>