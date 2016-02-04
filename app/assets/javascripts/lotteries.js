function changeRounds() {
	$.ajax({
		url: window.location.origin + '/home/change_rounds',
		dataType: "script",
		data: {
			lottery: $("#category").val()
		}
	});
};
