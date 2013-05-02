Interactivecv.SkillsController = Ember.ArrayController.extend({
    itemController:'skill',
	searchFilter:'',
	allowSkill:function(skill){
		var filter = this.get('searchFilter').toLowerCase(),
			title = skill.get('title').toLowerCase();
			
		return (filter)?title.indexOf(filter)>-1:true;
	},
	groupsList:function(){
		var groupsList = Ember.A();
		this.get('model').forEach(function(item){
			var groupName,
				searchFilter = this.get('searchFilter'),
				that = this;
			
			if( this.allowSkill( item ) ){
				groupName = item.get('group');
				if(!groupsList.findProperty('title',groupName)){
					groupsList.addObject(Ember.Object.create({
						title:groupName,
						slug:groupName.decamelize(),
						idslug:'#'+groupName.decamelize(),
						skills:that.filter(function(skillItem,index,enumerable){
							return ( skillItem.get('group') == groupName ) && that.allowSkill( skillItem );
						})
					}));

				};				
			}
			
		},this);
		
		var groupsList = groupsList.sort(function(a,b){
			return (a.groupName > b.groupName);
		});
		
		return groupsList;
	}.property('@each.group','searchFilter')
});