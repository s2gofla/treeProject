<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script>
$(function() {
	
	//파일 특정확장자 제외
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880;
	
	function checkExtension(fileName, fileSize) {
		if (fileSize >= maxSize) {
			alert("파일 사이즈 초과");
		}
		
		if (regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드 할 수 없습니다.")
			return false;
		}
		
	
	}
	
	let formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e) {
		
		e.preventDefault();
		
		console.log("submit click");
		
	
	});
	
	$("input[type='file']").change(function(e) {
		let inputFile = $("input[name='uploadFile']");
		let files = inputFile[0].files;
		
		for (var i = 0; i < files.length; i++) {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			
		}
		
	})
		

		
	

	
});
	
	

</script>
<!-- Table -->
<h2>글쓰기</h2>

<!--board  -->
<form role="form" action="/board/write" method="post" enctype="multipart/form-data">
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
			<div class="uploadDiv">
				<input type="file" name="uploadFile" multiple />
			</div>		
			<button type="submit">작성완료</button>
			<button type="reset">초기화</button>
		</div>
			
	</form>
