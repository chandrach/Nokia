public class AllCampaign {

    Public List<Project_Campaign__c> allCampaign {set;get;}
    Public AllCampaign(){
        allCampaign = [select id,name from Project_Campaign__c ];
        allCampaign.sort();
    }
}