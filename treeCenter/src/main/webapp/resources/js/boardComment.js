
 
 var commentService = (function(){
 
 	function add(reply, callback, error) {
 		console.log("list..")	
 	}
	
	function getList(param, callback, error) {
		var b_code = param.b_code;
		
		$.getJSON("/comment/pages/"+b_code+".json", function(data){
			if(callback) {
				callback(data);
			}
		}).fail(function(xhr, status, err){
		
			if(error) {
				error();
			}
		});
	}
	
	function displayTime(timeValue) { 
	var today = new Date();

	var gap = today.getTime() - timeValue;
	console.log(timeValue);
	var dateObj = new Date(timeValue);
			console.log(dateObj);
	var str = "";
	
	if (gap < (1000 * 60 * 60 * 24)) {
		
		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();
		
		return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' :'0') +mi, ':', (ss > 9 ? '' : '0')+ss].join('');
	} else {
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth();
		var dd = dateObj.getDate();
		
		return [yy, '/', (mm > 9 ? '': '0')+ mm, '/', (dd > 9 ? '':'0')+dd].join('');
	}

	};
	
	return {
		
		getList : getList,
		displayTime : displayTime
		
	};
 
 })();