Interactivecv.JobController = Ember.ObjectController.extend({
	isShowing:false,
	transition:null,
	positionDetails:null,
	pictureThumb:function(){
		var obj = this.get('content_images').findProperty('id',this.get('lead_image_id').toString());
		return (obj)?obj.get('picture_thumb'):null;
	}.property('content_images.@each'),
	truncatedDescription:function(){
		var wa = this.get('description').split(' ');
		var was = wa.slice(0,20);
		return (was.length < wa.length)? was.join(' ') + ' ...' : this.get('description');
	}.property('description'),
	startDateFormatted:function(){
		return this.formatDate(this.get('startDate'))
	}.property('startDate'),
	endDateFormatted:function(){
		return this.formatDate(this.get('endDate'))
	}.property('endDate'),
	startToEndDateFormatted:function(){
		var sdf = this.get('startDateFormatted');
		var edf = this.get('endDateFormatted');
		if(edf!=null){
			return sdf + ' - ' + edf;
		}else{
			return sdf;
		}

	}.property('startDate','endDate'),
	formatDate:function(theDate){
		var d = theDate;
		var m_names = new Array("January", "February", "March", 
		"April", "May", "June", "July", "August", "September", 
		"October", "November", "December");

		var curr_date = d.getDate();
		var curr_month = d.getMonth();
		var curr_year = d.getFullYear();
		return (m_names[curr_month] + " " + curr_year);
	}
});