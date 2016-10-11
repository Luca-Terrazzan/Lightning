({
	createAccount : function(component, event, helper) {
		var validAccount = true;

		var nameField 			= component.find('accName');
		var slaExpDateField 	= component.find('slaExpDate');
		var accountNumberField 	= component.find('accountNumber');
		if ( helper.validateField(nameField) &&helper.validateField(slaExpDateField) && helper.validateField(accountNumberField) ){
			helper.createAccount(account);
		}	
	},
	doInit : function(component, event, helper){
		console.log('test');
		var action = component.get("c.getAccountContacts");
		action.setCallback(this, function(response){
			var state = response.getState();
			if( component.isValid() && state === "SUCCESS" ){
				component.set("v.AccountContacts", response.getReturnValue());
			} else console.log("fail: " + state);
		});
		$A.enqueueAction(action);
	}
})