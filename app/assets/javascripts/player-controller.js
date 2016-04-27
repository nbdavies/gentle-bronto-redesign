$(document).ready(function(){
	$(".list-group-item").on("click", function(event){
		event.preventDefault();
		var player = $(this).find("audio")[0];
		// if the audio element within is already playing...
		if ($(this).hasClass("active")){
			//   take off active class if it has one
			$(this).removeClass("active");
			// add a paused icon
			$(this).append("<span class='glyphicon glyphicon-pause' aria-hidden='true'></span>");
			//   pause it
			player.pause();
		}
		else {
			// else find the currently playing element 
			var $activeLI = $(".list-group-item.active");
			if ($activeLI[0]) {
				// pause the player
				$activeLI.find("audio")[0].pause();
				// take off active class
				$activeLI.removeClass("active");
				// add paused icon
				$activeLI.append("<span class='glyphicon glyphicon-pause text-right' aria-hidden='true'></span>");
			};
			// for just-clicked player...add active class
			$(this).addClass("active");
			//   remove pause icon
			$(this).find("span").remove();
			// ...and play this one
			player.play();
		};
	});
	// if an audio element finishes playing...
	$("audio").on("ended", function(){
		$activeLI = $(this).closest(".list-group-item");
		// take off active class
		$activeLI.removeClass("active");
		// find next LI (if there is one)
		$nextLI = $activeLI.next(".list-group-item");
		if ($nextLI[0]) {
			// add active class
			$nextLI.addClass("active");
			// remove paused icon
			$nextLI.find("span").remove();
			// start playing from the beginning
			var nextPlayer = $nextLI.find("audio")[0];
			nextPlayer.currentTime = 0;
			nextPlayer.play();
		};
	});
});