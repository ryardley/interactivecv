Interactivecv.JobsRoute = Ember.Route.extend({
	setupController: function() {
        this.controllerFor('jobs').set('model', Interactivecv.Job.find());
        this.controllerFor('content_images').set('model', Interactivecv.ContentImage.find());
    }
});