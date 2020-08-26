<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- Table -->
<h2>글쓰기</h2>

<!--board  -->
<form role="form" action="/board/write" method="post">
		<div class="form-group">
			<div>
				<label>title</label>
				<input name="b_title"/>
			</div>
			<div>
				<label>writer</label>
				<input name="username" value="admin"/>
			</div>			
			<div>
				<label>text area</label>
				<textarea rows="3" name="b_content"></textarea>
			</div>		
			<button type="submit">작성완료</button>
			<button type="reset">초기화</button>
		</div>
			
	</form>