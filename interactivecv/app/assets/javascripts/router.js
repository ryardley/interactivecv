Interactivecv.Router.map(function(){
	this.resource('jobs');
	this.route('job',{path:'/jobs/:job_id'});
	this.route('welcome');	
});
