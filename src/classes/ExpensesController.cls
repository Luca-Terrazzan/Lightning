public with sharing class ExpensesController {
	@AuraEnabled
	public static List<Contact> getAccountContacts() {
		return [SELECT Id, Name FROM Contact];
	}
}