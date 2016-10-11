({
	/**
	 * Sorting function for a set of two ContactWrapper objects
	 * the order is based on the sum of open and closed tasks
	 * by the contact for a specific account
	 *
	 * @param      {ContactWrapper}  contact1  ContactWrapper 1
	 * @param      {ContactWrapper}  contact2  ContactWrapper 2
	 * @return     {number}  -1 if wrapper 1 is firt, +1 elsewhise
	 */
	compare : function(contact1, contact2) {
		var tot1 = contact1.closedTasks + contact1.openTasks;
		var tot2 = contact2.closedTasks + contact2.openTasks;
		if (tot1 > tot2) return -1;
		else return 1;
	}
})