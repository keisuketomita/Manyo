$(function(){
	$("#file_01").change(function(){
		$("#mask_file_01").val($("#file_01").val());
	});
	$("#mask_file_01").click(function(){
		var $elm = $('#file_01');
		if (document.createEvent) {
			var e = document.createEvent('MouseEvents');
			e.initEvent('click', true, true );
			$elm.get(0).dispatchEvent(e);
		}
		else {
			$elm.trigger("click");
		}
		return false;
	});
});
