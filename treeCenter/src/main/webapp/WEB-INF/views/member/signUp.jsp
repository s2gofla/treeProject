<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2>회원가입</h2>
<div class="box">
<form action="/member/signUp" method="post">
	<div class="username">
	<label>ID : <input type="text" name="username" /></label>
	<span><button>중복확인</button></span>
	</div>
	<div class="password">
	<label>password : <input type="password" name="password" /></label>
	</div>
	<div class="nickname">
	<label>nickname : <input type="text" name="name" /></label>
	</div>
	<div class="phone">
	<label>phone : <input type="text" name="phone" /></label>
	</div>
	<div class="email">
	<label>email : <input type="email" name="email" /></label>
	</div>
	<input type="hidden" name="enabled" value="1"/>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="submit" value="회원가입완료" />
</form>
</div>