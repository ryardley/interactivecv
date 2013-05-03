Interactivecv.JobView = Ember.View.extend({
	templateName: 'job',
	didInsertElement:function(){ 
		var $images = $('#picture_slider').find('img');
		if($images.length > 1){
			$('#picture_slider').css('display','none');
			$('#picture_slider_holder').append($images);			
			$('#picture_slider_holder').nivoSlider();		
		}else{
			$('#picture_slider_holder').parent().css({display:'none'});	
		}
	}
});