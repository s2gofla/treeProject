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
	
	//파일 등록
	$("input[type='file']").change(function(e) {
	
		console.log("change완료")
	
		var formData = new FormData();
		
		
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		
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
				showUploadedFile(result); //업로드 결과 처리 함수
				$(".uploadDiv").html(cloneObj.html());
			}
		});//ajax
		
	})
		
	//파일 목록 보여주기
	var uploadResult = $(".uploadResult ul");
	
	 function showUploadedFile(uploadResultArr) {
		 
		 if (!uploadResultArr || uploadResultArr.length == 0) {
			return;
		}
		 
		var str = "";
		$(uploadResultArr).each(function (i, obj) {
		
			if (!obj.image) {
			
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);			
			var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			
			str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"'";
			str += " data-type='"+obj.image+"'><div>";
			str += "<span>"+obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' style='box-shadow:0 0 black;'>";
			str += "<a href='/download?fileName="+fileCallPath+"'>";
			str += "<img src='/resources/images/document.png' style='width: 30t px'  ></a>";
			str += "</div></li>";
			}else {
				//str += "<li>" + obj.fileName + "</li>";
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				var orignPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				
				orignPath = orignPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'";
				str += " data-type='"+obj.image+"'><div>";
				str += "<span>"+obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' style='box-shadow:0 0 black'>";
				str += "<img src='/resources/images/remove.png' style='width:30px'></button><br>";
				str += "<a href=\"javascript:showImage(\'"+orignPath+"\')\"><img src='/display?fileName="
						+fileCallPath+"''></a>";
				str += "</div></li>";
			}
			
		});
		
		uploadResult.append(str);
	}
	
	 
	 //파일삭제
	 $(".uploadResult").on("click","button",function(e){
		
		 var targetFile = $(this).data("file");
		 var type = $(this).data("type");
		 var targetLi = $(this).closest("li");
		 console.log(targetFile);
		
		 $.ajax({
			 
			 url:'/deleteFile',
			 data:{fileName: targetFile, type:type},
			 dataType: 'text',
			 type:'post',
			 success: function (result) {
				alert(result);
				targetLi.remove();
			}
			 
			 
		 }); //ajax
		 
	 });
	
	 //파일 전송
	 var formObj = $("form[role='form']");
	 
	 $("button[type='submit']").on("click",function(e) {
			e.preventDefault();
			console.log("이벤트 막음완료");
			var str = "";
			
			$(".uploadResult ul li").each(function(i, obj) {
				
				var jobj = $(obj);
				
				console.dir(jobj);
				
				str +="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str +="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str +="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str +="<input type='hidden' name='attachList["+i+"].filetype' value='"+jobj.data("type")+"'>";
				
				console.log(str);
				
			});
			
			formObj.append(str).submit();
	 });
	 
	 //ckeditor 사용
	 
	 //var csrfHeaderName = "${_csrf.headerName}";
	 //var csrfTokenValue = "${_csrf.token}"
	
	 CKEDITOR.replace('ckeditor', {
		 
		 filebrowserUploadUrl : '/uploadAjaxAction?type=Images'

		 ,fileTools_requestHeaders: {
		            '${_csrf.headerName}': '{${_csrf.token}}',
		        }
	 });


	
	 
	 CKEDITOR.on('dialogDefinition', function (ev) {
			var dialogName = ev.data.name;
			var dialogDefinition = ev.data.definition;
			
			switch (dialogName) {
			case 'image': //이미지 속성
				dialogDefinition.removeContents('Link');
				dialogDefinition.removeContents('advanced');
				
				break;

			} 
			
	 });
	 
	 
	 
	 $(document).ready(function(){  
		   CKEDITOR.on('dialogDefinition', function(ev) {
		    var dialogName = ev.data.name;
		    var dialogDefinition = ev.data.definition;
		 
		    if(dialogName == 'image') {
		     var uploadTab = dialogDefinition.getContents('Upload');
		 
		     for (var i =0; i < uploadTab.elements.length; i++)
		     {
		      var el = uploadTab.elements[i];
		      if(el.type != 'fileButton') {
		       continue;
		      }
		 
		      var onClick = el.onClick;
		 
		      el.onClick = function(evt){
		       var dialog = this.getDialog();
		       var fb = dialog.getContentElement(this['for'][0], this['for'][1]);
		       var action = fb.getAction();
		       var editor = dialog.getParentEditor();
		       editor._.filebrowserSe = this;
		 
		       $(fb.getInputElement().getParent().$).append('<input type="hidden" name="<?= $this->security->get_csrf_token_name() ?>" value="<?= $this->security->get_csrf_hash() ?>" />');
		 
		       if(onClick && onClick.call(evt.sender, evt) === false) {
		        return false;
		       }
		       return true;
		      };
		     }
		    }
		   });
		  });

	 
})
	
	

</script>
<script src="/resources/ckeditor/ckeditor.js"></script>
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
				<textarea rows="3" id="ckeditor" name="b_content"></textarea>
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
