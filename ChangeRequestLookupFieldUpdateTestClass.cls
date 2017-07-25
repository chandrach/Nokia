@isTest
public  class ChangeRequestLookupFieldUpdateTestClass
{
public static testmethod void ChangeRequestLookupFieldUpdateTestMethod()
{
MCAR_Change_Request__c CR = new MCAR_Change_Request__c();
    cr.MCAR_CR_Manufactuerer_Site__c = 'test';
    //cr.Planned_MCAR_Activity__c =MCAR_Change_Request__c.Planned_MCAR_Activity__c.getDescribe().getPicklistValues()[0].getValue();
    cr.Line_Manager_Name__c = 'test2';
    cr.Internal__c ='testi';
        cr.Internal_Contact_Role__c='testit';
        cr.Organization__c ='testo';
    
insert CR;
   update cr; 
   }
}