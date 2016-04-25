$(document).ready(function(){
	// News divs start empty
	// One Ajax request to get all the news in JSON
	var newsColumns = [];
	var newsIndex = 0;
	var request = $.ajax({
		url: "/posts",
		dataType: "json"
	});
	request.done(function(responseData){
		// Render news into 300px columns
		while (responseData.length > 0) {
			var $element = $("#news-left");
			while ($element.height() < 300 && responseData.length > 0) {
				var post = responseData.shift();
				$element.append(postToLI(post));
			};
			newsColumns.push($element.children());
			$element.children().detach();
		};
		// Start with two most recent columns visible
		$("#news-left").append(newsColumns[0]);
		$("#news-right").append(newsColumns[1]);
		// If only one/two columns of news, disable the Next button
		if (newsColumns.length < 3) {$("#news-next").addClass("disabled");};
	});
	// If user clicks the next button...
	$("#news-next").on("click", function(event){
		$button = $("#news-next");
		event.preventDefault();
		if ($button.hasClass("disabled")) return; // is it active?
		$("#news-prev").removeClass("disabled");
		// clear the contents of the left column
		$("#news-left").children().detach();
		// move contents from right column to left column
		var newsRight = $("#news-right").children();
		$("#news-right").children().detach();
		$("#news-left").append(newsRight);
		newsIndex += 1; // increment newsIndex
		// if newsIndex is newsColumns.length -1, then disable the next button
		if (newsIndex == newsColumns.length - 2) {$button.addClass("disabled");};
		// put next column of content into right column
		$("#news-right").append(newsColumns[newsIndex+1]);
	});

	// Same logic for the previous button
	$("#news-prev").on("click", function(event){
		$button = $("#news-prev");
		event.preventDefault();
		if ($button.hasClass("disabled")) return; 
		$("#news-next").removeClass("disabled");
		$("#news-right").children().detach();
		var newsLeft = $("#news-left").children();
		$("#news-left").children().detach();
		$("#news-right").append(newsLeft);
		newsIndex -= 1; 
		if (newsIndex == 0) {$button.addClass("disabled");};
		$("#news-left").append(newsColumns[newsIndex]);
	});

});

function postToLI(post) {
	var contents;
	contents = "<li><small class='text-muted'>"+post.created_at+"</small><p>"
	if (post.url) {contents += "<a href='"+post.url+"'>"+post.short_message+"</a>"}
	else {contents += post.short_message;};
	contents += "</p></li>";
	return contents;
};
