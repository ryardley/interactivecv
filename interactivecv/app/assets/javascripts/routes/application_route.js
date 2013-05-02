Interactivecv.ApplicationRoute = Ember.Route.extend({
    setupController: function() {
        this.controllerFor('skills').set('model', Interactivecv.Skill.find());   
    }
});