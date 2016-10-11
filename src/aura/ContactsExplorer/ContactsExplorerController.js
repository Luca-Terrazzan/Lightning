({
	doInit : function(component, event, helper) {
		var action = component.get("{!c.fetchData}");
		// action.setParams({ account: component.get("v.account") }); // to be enabled once the component is finished
		action.setParams({ account: "0010Y000002cXlW"}); // temp hardocding

		action.setCallback(this, function(response){
			var state = response.getState();
			var result = response.getReturnValue();
			result = result.sort(helper.compare);
			console.log("APEX controller SOQL result: " , result);
			if( component.isValid() && state === "SUCCESS" ){
				component.set("v.wrappedContacts", result);
			} else console.log("fail: " + state);
		});
		$A.enqueueAction(action);
	}
})