({
	validateField : function(field) {
		if(!field.get('v.value')){
			field.set('v.errors', [{message:'Mandatory Field!'}]);
			return false;
		} else {
			field.set('v.errors', null);
			return true;
		}
	},

	createAccount : function(account){
		
	}
})