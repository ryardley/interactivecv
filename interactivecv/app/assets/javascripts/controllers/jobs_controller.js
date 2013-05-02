Interactivecv.JobsController = Ember.ArrayController.extend({
    itemController:'job',
    filterObjects:[],
    addFilterItem:function(item){
        if(!this.get('filterObjects').contains(item.get('title'))){
            var filterObjs = this.get('filterObjects');
            filterObjs.addObject(item.get('title'));
            this.set('filterObjects',filterObjs);
        }
    },
    removeFilterItem:function(item){
        if(this.get('filterObjects').contains(item.get('title'))){
            var filterObjs = this.get('filterObjects');
            filterObjs.removeObject(item.get('title'));
            this.set('filterObjects',filterObjs);
        }
    },
    filteredJobs:function(){
        var filterObjs = this.get('filterObjects');
 		return this.filter(function(job, index, enumerable){   
 			// display all if filter is empty
			if(filterObjs.length==0){
	            return true;
	        }
			// find all skills that match in filterObjs
            var found = false;   
            job.get('skills').forEach(function(jobSkill){
                found = found || filterObjs.contains(jobSkill.get('title'));
            });
            return found;
        });
    }.property('filterObjects.@each','@each')
});