<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<script
  src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>

	//원본이미지 보여주기
	function showImage(fileCallPath) {
	//alert(fileCallPath);
	
	$(".bigPictureWrapper").css("display","flex").show();
	
	$(".bigPicture").html("<img src='/display?fileName="+encodeURI(fileCallPath)+"'>").animate({width: "100%", height: "100%"}, 1000);
	

	}
	
$(function() {
	
	$(".bigPictureWrapper").on("click", function(e) {
		$(".bigPicture").animate({width: "0%", height: "0%"}, 1000);
		setTimeout(() => {
			$(this).hide();
		}, 1000);
	});
		
	
	
	//파일 특정확장자 제외
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880;
	
	function checkExtension(fileName, fileSize) {
		if (fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		
		if (regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드 할 수 없습니다.")
			return false;
		}
		
		return true;
	}
	
	 
	//csrf처리
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function (e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	 
	var cloneObj =$(".uploadDiv").clone();
	 
	$("input[type='file']").change(function(e) {
	
		
	
		var formData = new FormData();
		
		
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files)
		
		for (var i = 0; i < files.length; i++) {
			
			if ( !checkExtension(files[i].name, files[i].size) ) {
				return false;
			}
			
			formData.append("uploadFile", files[i]);
			
		}
		
		
		$.ajax({
			url :'/uploadAjaxAction',
			processData: false,
			contentType: false,
			data : formData,
			type : 'POST',
			dataType: 'json',
			success : function(result) {
				console.log(result);
				showUploadedFile(result);
				$(".uploadDiv").html(cloneObj.html());
			}
		});//ajax
		
	})
		
	//파일 목록 보여주기
	var uploadResult = $(".uploadResult ul");
	
	 function showUploadedFile(uploadResultArr) {
		var str = "";
		$(uploadResultArr).each(function (i, obj) {
		
			if (!obj.image) {
			
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
			str += "<li>"+"<a href='/download?fileName="+fileCallPath+"'>"
			+"<img src='/resources/images/document.png'>" + obj.fileName + "</a></li>";
			}else {
				//str += "<li>" + obj.fileName + "</li>";
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				var orignPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				orignPath = orignPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li>"+"<a href=\"javascript:showImage(\'"+orignPath+"\')\"><img src='/display?fileName="
						+fileCallPath+"''></a><li>";
			}
			
		});
		
		uploadResult.append(str);
	}
			

	
});
	
	

</script>
<!-- Table -->
<h2>글쓰기</h2>

<!--board  -->
<form role="form" action="/board/write" method="post" enctype="multipart/form-data">
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="form-group">
			<div>
				<label>title</label>
				<input name="b_title"/>
			</div>
		<div>
				<label>writer</label>
				<input name="username" value='<sec:authentication property="principal.username"/>' readonly="readonly"/>
			</div>			
			<div>
				<label>text area</label>
				<textarea rows="3" name="b_content"></textarea>
			</div>
			<div class="uploadDiv">
				<input type="file" name="uploadFile" multiple />
			</div>	
			
			<div class="uploadResult">
				<ul class="box uploadBox">
				</ul>
			</div>
			<button type="submit">작성완료</button>
			<button type="reset">초기화</button>
		</div>
			
	</form>
	
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		</div>
	</div>
