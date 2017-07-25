global with sharing class CampaignSearch_Controller {

    public CampaignSearch_Controller() {}

    @AuraEnabled
    public static List<Project_Campaign__c> getCampaignsList(String keyword, Integer itemsNumber) {
        List<Project_Campaign__c> campaigns = Database.query('SELECT Id, Name FROM Project_Campaign__c WHERE Name LIKE \'%' + keyword + '%\' OR Description__c LIKE \'%' + keyword + '%\' LIMIT ' + itemsNumber);
        return campaigns;
    }
}