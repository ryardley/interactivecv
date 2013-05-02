Interactivecv.jobTransition = Interactivecv.ViewTransitionManager.create({
	viewClass:'Interactivecv.JobThumbView',
	removeAnimation : function($jq){
		$jq.animate({opacity:0},500,function(){
			$jq.remove();
		});
	},
	createAnimation : function($jq){
		$jq.css({opacity:0});
		$jq.animate({opacity:1},500,function(){
		});
	},
	transitionAnimation : function($old,$new){
		var pos = $new.position();
		var width = $new.width();
		var height = $new.height();
		$new.css({opacity:0});
		$old.animate({
			top:pos.top+'px',
			left:pos.left+'px',//(pos.left - parseInt($new.find(">:first-child").css('paddingLeft')))+'px',
			width:width+'px',
			height:height+'px',
		},500,function(){
			$new.css({opacity:1});
			$old.remove();
		});
	}
});