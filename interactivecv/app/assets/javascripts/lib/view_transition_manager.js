Interactivecv.ViewTransitionManager = Ember.Object.extend({
	
	//	vars
	viewClass:null,
	viewsToInsert:null,
	viewsToDestroy:null,
	
	//	methods
	init:function(){
		this._super();

		//	Run once the view properties have been set
		Ember.run.schedule('actions',this, function(){
			var viewClass,
				transitionManager=this;
			
			//	Convert string to class
			if(Ember.typeOf(this.viewClass)=='string'){
				//viewClass = eval(this.viewClass); //## DEPRECATED
				//trying not to use eval because AIR doesnt like it
				var parts,i,obj,len;
				parts = this.viewClass.split(".");
				for (i = 0, viewClass = window; i < parts.length; ++i) {
				    viewClass = viewClass[parts[i]];
				}
			}
				
			if(!viewClass){
				console.log('ERROR: no viewClass Set');
				return;
			}
				
			//	Crack open instance and force 
			//	 callbacks for creation and destruction.
			
			viewClass.reopen({
				init:function(){
					this._super();
					transitionManager.viewInit(this);
				},
				willDestroyElement:function(){
					transitionManager.viewDestroy(this);				
				}
			});			
			
		});
	},
	viewInit:function(view){
		this.registerView(view);
		Ember.run.scheduleOnce('afterRender', this, this.afterRender);
	},
	viewDestroy:function(view){
		this.deregisterView(view);
		Ember.run.scheduleOnce('afterRender', this, this.afterRender);
	},	
	deregisterView:function(view){
		var cont,
			view;
		
		cont = view.get('controller');
		
		if(this.viewsToInsert){
			
			view = this.viewsToInsert.get(cont);
			
			if(!this.viewsToDestroy)
				this.viewsToDestroy = Ember.Map.create();

			this.viewsToDestroy.set(cont, Ember.A([ 
				view, 
				this.getJQClone(view) 
			]));
			
			this.viewsToInsert.set(cont,null);
		}

	},
	getJQClone:function(view){

		var $holder	 = $('.vtm-anim-holder'),
			$orig 	 = view.$(),
			$clone 	 = $orig.clone(),
			position = $orig.position();

		if( $holder.length == 0 ){
			$holder = $('<div class="vtm-anim-holder"/>');
			$holder.css({
				position	: 'absolute',
				padding		: 0,
				margin		: 0,
				top			: 0,
				left		: '-8px',
				width		: '100%',
				height		: '100%',
				pointerEvents : 'none'
			}).appendTo($('body'));
		}
		
		return $clone.css({
			position	: 'absolute',
			listStyle	: 'none',
			top			: position.top+'px',
			left		: position.left+'px',//(position.left-parseInt($orig.find(">:first-child").css('paddingLeft')))+'px',
			width		: $orig.width()+'px',
			height		: $orig.height()+'px'
		}).appendTo($holder);
	},
	registerView:function(view){	
		
		var cont = view.get('controller');
		
		if( !this.viewsToInsert )
			this.viewsToInsert = Ember.Map.create();
		
		if( !this.viewsToInsert.get(cont) )
			this.viewsToInsert.set(cont,view);
			
	},
	afterRender:function(){
		
		//	Declare variables
		var itemsToRemove 		= Ember.A(),			
			itemsToCreate 		= Ember.A(),				
			itemsToTransition 	= Ember.A();
		
		// Run through all registrations
		if(!this.viewsToDestroy){
			return;
		}
		
		//	Cycle through the views being destroyed
		this.viewsToDestroy.forEach(function(cont,viewOldObj){
			
			var viewOld 		= viewOldObj[0],
				$viewOld 		= viewOldObj[1],
				viewNew 		= this.viewsToInsert.get(cont),
				$viewNew	 	= (!viewNew)?null:viewNew.$();
			
			if(!viewNew){			
				//	If the new view doesnt exist remove the old view
				itemsToRemove.addObject($viewOld);
			}else{						
				//	If the new view exists then transition from the old to it
				itemsToTransition.addObject(Ember.A([
						$viewOld, 
						$viewNew
				]));
			}
			
		},this);
		
		//	Cycle through the refreshed views
		this.viewsToInsert.forEach(function(cont, viewNew){
			
			var viewOldObj 	= this.viewsToDestroy.get(cont),
				$viewNew	= (!viewNew)?null:viewNew.$();
			
			//	if the old view doesnt exist and the 
			//	 new view exists add it to the create pile
			if( !viewOldObj && viewNew ){
				itemsToCreate.addObject( $viewNew );
			}
			
		},this);
		
		//	Clear all the deregistered views
		this.viewsToDestroy = Ember.Map.create();
		
		//	Run the remove animations
		itemsToRemove.forEach(function($item){
			this.removeAnimation($item);
		},this);

		//	Run the create animations		
		itemsToCreate.forEach(function($item){
			this.createAnimation($item);
		},this);

		//	Run the transition animations				
		itemsToTransition.forEach(function(itemArray){
			var $old = itemArray[0];
			var $new = itemArray[1];
			this.transitionAnimation($old,$new);
		},this);
		
	},
	removeAnimation : function($old){
		$old.remove();
	},
	createAnimation : function($new){
		
	},
	transitionAnimation : function($old,$new){
		$old.remove();
	}
	
});