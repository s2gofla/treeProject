<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.comboBox {
	background: white;
	list-style: none;

}

.comboBox:hover {
	
	background-color: green;
	color:white;
	cursor: pointer;
	
	
}
</style>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		
		$('#writeBtn').on("click", function(){
			self.location = "/board/write";
		});
		
		//글작성 완료 후 완료창 띄우기
		var result = '<c:out value="${result}"/>';
		
		

	if(!(result === '' || history.state)) {
			
			if (result === 'updateSuccess') {
				alert("글 수정이 완료 되었습니다.");
			}else if(result===  'deleteSuccess') {
				alert("글 삭제 완료 되었습니다.");
			}else{
				
			alert("글 등록이 완료 되었습니다.");
			}
			
		}
			
		history.replaceState({},null, null);
		
		
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
			actionForm.append("<input type='hidden' name='b_code' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action","/board/read");
			actionForm.submit();
			
		});
			
		//검색버튼 이벤트 처리
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function (e) {
		
			if (!searchForm.find("option:selected").val()) {
				alert("검색 종류를 선택하세요");
				return false;
			}
			
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("검색어를 입력하세요");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
		});
		
		
		//자동완성 ajax
		$("#query").autocomplete({
			
			
			source : function(request, response) {
				
				$.ajax({
					type : 'post',
					url: "/searchJson",
					dataType : "json",
					data : {"keyword" : $("#query").val()},
					success : function(data) {
						response (
						$.map(data, function(item){
							
							console.log(data);
							console.log(item);
							
							return {
							
								label : item,
								value : item
							};
						})
						
					  );
					},
					error: function () {
						alert("통신 실패");
					}
					
				});
				
				
			}
			, minlength : 1
			, autoFocus : true
			, select : function(evt, ui) {
	            console.log("셀렉 이벤트 발생");
	        }
	        , focus : function(evt, ui) {
	            return false;
	        }
		}).autocomplete( "instance" )._renderItem = function( ul, item ) {    //요 부분이 UI를 마음대로 변경하는 부분
            return $( "<li class='comboBox'>" )    //기본 tag가 li로 되어 있음 
            .append(item.value)    //여기에다가 원하는 모양의 HTML을 만들면 UI가 원하는 모양으로 변함.
            .appendTo( ul );
     };
     
     
     //ajax 토큰 처리
     
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$(function() {
		    $(document).ajaxSend(function(e, xhr, options) {
		         xhr.setRequestHeader(header,token);
		    });
		});
     
     

    
     //axios crsf토큰 처리
    if (token) {
    window.axios.defaults.headers.common['X-CSRF-TOKEN'] = token;
    console.log(token);
	} else {
    console.error('CSRF token not found: https://laravel.com/docs/csrf#csrf-x-csrf-token');
	}
     
    //정렬 axios처리 
    /*
     $("#sort").on('change', function () {
		
    	 var sortValue = $(this).find("option:selected").val();
    	 console.log("sort값" + sortValue);
    	 var params = new URLSearchParams();
         params.append('sortValue', sortValue);

    	 axios.post('/board/listAjax', params).then(function (response) {
			console.log(response);
			console.log("성공");
		}).catch(function(error) {
			console.log(error);
		});
    	 
	});
     
	*/
		
	//목록형 이미지형 구분
	
	var option = $(".selectBox option:selected").val();
	
	if (option === 'thumnail') {
		$(".listBox").hide();
		$(".imageBox").show();
		$("input[name=optionType]").val("thumnail");
		
	}else {
		
		$(".listBox").show();
		$(".imageBox").hide();
		$("input[name=optionType]").val("list");
		console.log($("input[name=optionType]").val());	
	}
	
	
	
	//목록 옵션 선택할때
	$(".selectBox").on("change", function() {
		var option = $(".selectBox option:selected").val();
		option === 'thumnail' ? console.log("yes") : console.log("no");
		
		if (option === 'thumnail') {
			$(".listBox").hide();
			$(".imageBox").show();
			$("input[name=optionType]").val("thumnail");
			console.log($("input[name=optionType]").val());
		}else {
			
			$(".listBox").show();
			$(".imageBox").hide();
			$("input[name=optionType]").val("list");
			console.log($("input[name=optionType]").val());
			
		}
		
	});
	
		
	});
	
</script>
<!-- Table -->
<h2>자유게시판</h2>

<h4>자유롭게 글을 쓰세요</h4>

<!-- sort -->

<div class="selectBox" style="margin-bottom: 20px; width: 30%;">
	<select name="sort" id="sort">
    <option value="list" <c:out value="${option eq 'list' ? 'selected' : '' }"/>>목록형</option>
    <option value="thumnail" <c:out value="${option == 'thumnail' ? 'selected' : '' }"/>>이미지형</option>
</select>
</div>


<!--board  -->
<table class="listBox">
	<thead>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list }" var="board">
		<tr>
			<td>${board.b_code }</td>
			<td><a  class='move' href='<c:out value="${board.b_code }"/>'>${board.b_title }</a></td>
			<td>${board.username }</td>			
			<td><fmt:formatDate pattern="yyyy-MM-dd"
				value="${board.b_regdate }" /></td>
			<td>${board.b_hit }</td>
		</tr>
	</c:forEach>	
	</tbody>	
</table>

<!-- board image -->
<div class="flex imageBox" style="flex-flow : wrap; display: none;">
	<c:forEach items="${list }" var="board">
		<div class="margin" style="margin: 20px; width: 200px">
			<div style="width: 100%"><img  src="/resources/images/pic01.jpg" style="width: 100%"></div>
			<div>${board.b_code }</div>
			<div><a  class='move' href='<c:out value="${board.b_code }"/>'>${board.b_title }</a></div>
			<div>${board.username }</div>			
			<div><fmt:formatDate pattern="yyyy-MM-dd"
				value="${board.b_regdate }" /></div>
			<div>${board.b_hit }</div>
		</div>
	</c:forEach>		
</div>



	<button class="button primary small" id="writeBtn">글쓰기</button>
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

	<form id="searchForm" method="get" action="/board/list">
	<select name="type">
		<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>--</option>
		<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
		<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
		<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
		<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>제목+내용</option>
		<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목+작성자</option>
		<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected' : '' }"/>>제목+내용+작성자</option>		
	</select>
		<input type="text" name="keyword" id="query" placeholder="Search" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
		<button class="button primary icon solid fa-search">Search</button>
		<div class="instance">
		</div>
		<input type="hidden" name="optionType" value="list" />
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"/>' />
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }"/>' />
	</form>
	
	<form id="actionForm" action="/board/list" method="get">
		<input type="hidden" name="optionType" value="list" />
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }"/>' />
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }"/>' />
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"/>' />
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }"/>' />
	</form>
