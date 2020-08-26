<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<h2>강연 보기</h2>

<div class="content">
	<input type="hidden" name="l_code" />
	
	<div id="title">
		<div id="c_name">분류:<c:out value="${c_name}"/></div>
		<div id="l_title">제목:<c:out value="${lecture.l_title }"/></div>
	</div>
	
	<div id="l_date">날짜:<c:out value="${lecture.l_date }"/></div>
	<div id="lecturer">강연자:<c:out value="${lecture.lecturer }"/></div>
	<img src="/resources/l_img/<c:out value="${lecture.l_img }"/>" alt="" />
	<div id="l_content">내용:<c:out value="${lecture.l_content }"/></div>
	
	<div id="local">
		<div id="l_loc">장소 : <c:out value="${lecture.l_loc }"/></div>
		<div id="map"></div>
	</div>
</div>

<button id="reservation" class="button primary">예약하기<span>0/100</span></button>

<div>댓글</div>
