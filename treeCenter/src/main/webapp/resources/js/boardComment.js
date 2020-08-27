/**
 * 
 */
 
 var commentService = (function(){
 
 	function add(reply, callback, error) {
 		console.log("list..")	
 	}
	
	function getList(param, callback, error) {
		var b_code = param.b_code;
		console.log(b_code);
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
	
	return {
		
		getList : getList
	};
 
 })();