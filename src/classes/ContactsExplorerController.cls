/**
 * Manage Account's contacts data fetching and manipulation
 */
public with sharing class ContactsExplorerController {
	/**
	 * Wrapper for contacts containing info on their closed\open tasks
	 */
	public class ContactWrapper {
		// All get/set merhods MUST be auraenabled
		@AuraEnabled
		Contact contact 	{get;set;}
		@AuraEnabled
		Integer openTasks 	{get;set;}
		@AuraEnabled
		Integer closedTasks {get;set;}

		/**
		 * standard constructor
		 *
		 * @param      cont  the contact
		 * @param      ot    open contact's tasks
		 * @param      ct    closed contact's tasks
		 */
		public ContactWrapper(
			Contact cont,
			Integer ot,
			Integer ct)
		{
			this.contact 		= cont;
			this.openTasks 		= ot;
			this.closedTasks 	= ct;
		}
	}

	/**
	 * Fetches actual data, for each account's contact it gets closed/open tasks
	 * in separated lists, then builds a map of contactwrappers custom class
	 * to contain each contact's open/closed tasks number
	 *
	 * @param      account  The id of the current account
	 *
	 * @return     A list of contact wrappers containing a reference to
	 * 				the contact and the number of open\closed tasks
	 */
	@AuraEnabled
	public static List<ContactWrapper> fetchData(Id account){
		List<Contact> contactsCompletedTasks = [SELECT Id, Name, 
			(SELECT Id, Status FROM Tasks WHERE Status = 'Completed') 
			FROM Contact WHERE AccountId =: account];

		List<Contact> contactsOpenTasks = [SELECT Id, Name, 
			(SELECT Id, Status FROM Tasks WHERE Status != 'Completed') 
			FROM Contact WHERE AccountId =: account];

		Map<Id, ContactWrapper> mappaContatti = new Map<Id, ContactWrapper>();
		for(Contact contatto : contactsOpenTasks) {
			System.debug('test' + contatto.Tasks);
			mappaContatti.put(contatto.Id, new ContactWrapper(contatto, contatto.Tasks.size(), 0));
		}
		for(Contact contatto: contactsCompletedTasks) {
			if(mappaContatti.get(contatto.Id) == null){
				mappaContatti.put(contatto.Id, new ContactWrapper(contatto, 0, contatto.Tasks.size()));
			} else {
				mappaContatti.get(contatto.Id).closedTasks = contatto.Tasks.size();
			}
		}
		System.debug('Mappa finale: ' + mappaContatti.values());

		return mappaContatti.values();
	}
}