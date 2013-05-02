Interactivecv.SkillController = Ember.ObjectController.extend({
    needs:['jobs'],
    isSelected:false,
	jobCount:function(){
		return this.get('jobs').get('length');
	}.property('jobs.@each'),
	
    toggleSelected:function(){
        var jobsController = this.get('controllers').get('jobs');
        var isSelected = this.get('isSelected');
        if(!isSelected){
            jobsController.addFilterItem(this);
        }else{
            jobsController.removeFilterItem(this);
        }
        this.set('isSelected',!isSelected);
    }
});