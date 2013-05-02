Interactivecv.SkillView = Ember.View.extend({
    templateName: 'skill',
	tagName: 'li',
	classNameBindings: ['controller.isSelected:active:']
});