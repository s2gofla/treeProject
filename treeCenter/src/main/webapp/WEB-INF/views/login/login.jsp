<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	
	$(function() {
	
		$("#login").on("click", function(e) {
			
			e.preventDefault();
			// $("form").submit();
		});
		
	});
	

</script>
 <h2>로그인 페이지</h2>
 
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
 		<input type="submit" value="로그인" />
 		<a href="/" class="button primary" id="login">로그인</a>
 	</div>
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 </form>
 </div>