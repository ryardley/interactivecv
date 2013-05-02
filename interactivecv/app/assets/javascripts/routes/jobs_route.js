Interactivecv.JobsRoute = Ember.Route.extend({
	setupController: function() {
        this.controllerFor('jobs').set('model', Interactivecv.Job.find());
    }
});