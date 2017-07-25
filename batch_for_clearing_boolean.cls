global class batch_for_clearing_boolean implements Database.Batchable<sObject>,Database.Stateful , Schedulable {
     Set<Id> SPEID = new set<id>();
     global void execute(SchedulableContext sc) 
    {
        Database.executebatch(this,1);
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
         Date TODAYs = Date.today();
        
        string numberOfDays = Label.SPE_ScheduleDateModifier == null ? '0' : Label.SPE_ScheduleDateModifier;

        Integer addDay = integer.valueOf(numberOfDays) == null ? 0 : integer.valueOf(numberOfDays);
        
        TODAYs = TODAYs.addDays(addDay);
        
        String status = SPE_Constants.PUBLISHED_LIFECYCLESTAGE;
        
      String query = 'SELECT Id FROM SPE_SPEPlan__c WHERE StartDate__c <= : TODAYs AND  EndDate__c >=:TODAYs AND Stage__c =: status AND tracker_month__c= True';
      return Database.getQueryLocator(query);
                  
    }

    
    global void execute(Database.BatchableContext BC,List<SPE_SPEPlan__c> scope)
          { 
              for(SPE_SPEPlan__c s :scope)
              {
                  s.tracker_month__c= false;
              }
              update scope;
              
          }
     global void finish(Database.BatchableContext BC) 
    {
            }
    
    
}