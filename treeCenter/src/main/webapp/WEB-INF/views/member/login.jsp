<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<script>
	
</script>
 <h2>로그인 페이지</h2>

 <h3><c:out value="${error }"></c:out></h3>
 <h3><c:out value="${logout }"></c:out></h3>
 
 <div class="box flex">
 <div> 
 	<img  class="image" src="/resources/images/pic03.jpg" alt="" />
 </div>
 <form action="/login" method="post">
 	<div>
 		<div>id</div>
 		<input type="text" name="username"/>
 	</div>
 	<div>
 		<div>password</div>
 		<input type="password" name="password" />
 	</div>
 	<div>
 		<input type="checkbox" id="remember-me" name="remember-me"/>
 		<label for="remember-me">자동로그인</label> 	
 	</div>
 	<div>
 		<input type="submit" value="로그인" />
 	</div>
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 </form>
 </div>