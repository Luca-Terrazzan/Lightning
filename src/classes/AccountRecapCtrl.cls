public with sharing class AccountRecapCtrl {
	@AuraEnabled
	public static String getString(String test) {
		if (test == 'capperi') throw new AuraHandledException('NSFW name detected.');
		return test + 'Success!';
	}
}