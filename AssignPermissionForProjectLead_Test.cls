@isTest
public class AssignPermissionForProjectLead_Test
{
    static testmethod void beforeInsert()
    {
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        User DummyUser1 = new User();
        DummyUser1.LastName = 'xyz';
        DummyUser1.FirstName = 'xyz';
        DummyUser1.Alias = 'xyz';
        DummyUser1.Email = 'b@b.a';
        DummyUser1.Username = 'b@b.a.adc';
        DummyUser1.CommunityNickname = 'b';
        DummyUser1.IsActive = TRUE;
        DummyUser1.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser1.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser1.LocaleSidKey = 'en_US';
        DummyUser1.EmailEncodingKey = 'ISO-8859-1';
        DummyUser1.LanguageLocaleKey = 'en_US';
        insert DummyUser1; 
        
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'adc adc';
        con.Email__c = 'a@a.a';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        con.ownerId = DummyUser.Id;
        insert con;
        
        QIPP_Contacts__c con1 = new QIPP_Contacts__c();
        con1.Name = 'test test';
        con1.Email__c = 'b@b.a';
        con1.Contact_State__c = 'Active';
        con1.NSN_ID_Text__c = '1879511';
        con1.ownerId = DummyUser1.Id;
        insert con1;    
                
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio1';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.CPVi_Composite__c = 25.0;
        portfolio.CPVi_Past__c = 29.0;
        portfolio.CPVi_Future__c = 55.0; 
        portfolio.CPV_Trend__c  = 'Up';
        portfolio.Portfolio_Business_Unit__c = 'CEF Central Functions';
        portfolio.X8D__c = true;
        insert portfolio;
        
        QIPP_Portfolio__c portfolio1 = new QIPP_Portfolio__c();
        portfolio1.Name = 'Test Portfolio2';
        portfolio1.Portfolio_Owner__c = con.id;
        portfolio1.ownerId = DummyUser.Id;
        portfolio1.CDT_Lead__c = con.id;
        portfolio1.CPVi_Composite__c = 25.0;
        portfolio1.CPVi_Past__c = 29.0;
        portfolio1.CPVi_Future__c = 55.0; 
        portfolio1.CPV_Trend__c  = 'Up';
        portfolio1.Portfolio_Business_Unit__c = 'CEF Central Functions';
        insert portfolio1;
        
        insert new Trigger_Control__c(Run_Triggers__c = True);        
            
        QIPP_Project__c project = new QIPP_Project__c();
        project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: 8D').getRecordTypeId();
        project.Portfolio_Name__c = portfolio.id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser1.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Portfolio_BU__c = 'CEF Central Functions';
        //project.Implementing_BL__c = '3GCore';
        insert project;
  
        /*
        QIPP_Project__c project1 = new QIPP_Project__c();
        project1 = project.clone();
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Name_Succinct__c = 'Test Project1';
        project1.Primary_QLT_Function__c = 'CO';
        project1.Project_State__c = 'On hold';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con1.id;
        project1.ownerid = DummyUser1.Id;
        project1.Report_Name__c = 'Executive Dashboards';
        project1.Report_Type__c = 'Summary of Projects by Project Type ';
        project1.Portfolio_BU__c = 'CEF Central Functions';
        insert project1;
        */
               /* 
         QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 01, 01);   
         Date enddate = Date.newInstance(2013, 03, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Planned_Operational_Manual_Amount__c = 500;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Achieved_Operational_Manual_Amount__c = 500;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 04, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 04, 31);         
         benifit.Future_Operational_Manual_Amount__c = 500;
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         insert benifit;
        
        QIPP_BU_Reporting__c obj1 = new QIPP_BU_Reporting__c();
        obj1.Benefit_ID__c  = benifit.id;
        obj1.Project_ID__c = project.id;
        obj1.Quarters__c = 'Q1';                           
        obj1.Years__c = '2014';
        obj1.Months__c = '2';        
        insert obj1;   
        */ 
        /*
        Test.startTest(); 
        project.Project_Name_Succinct__c = 'Test Project3';
        update project;
        delete project;
        delete project1;
        Test.stopTest();
        */
    }
    
    static testmethod void beforeInsert1()
    {
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        User DummyUser1 = new User();
        DummyUser1.LastName = 'xyz';
        DummyUser1.FirstName = 'xyz';
        DummyUser1.Alias = 'xyz';
        DummyUser1.Email = 'b@b.a';
        DummyUser1.Username = 'b@b.a.adc';
        DummyUser1.CommunityNickname = 'b';
        DummyUser1.IsActive = TRUE;
        DummyUser1.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser1.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser1.LocaleSidKey = 'en_US';
        DummyUser1.EmailEncodingKey = 'ISO-8859-1';
        DummyUser1.LanguageLocaleKey = 'en_US';
        insert DummyUser1; 
        
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'adc adc';
        con.Email__c = 'a@a.a';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        con.User_License__c = DummyUser.Id;
        con.ownerId = DummyUser.Id;
        insert con;
        
        QIPP_Contacts__c con1 = new QIPP_Contacts__c();
        con1.Name = 'test test';
        con1.Email__c = 'b@b.a';
        con1.Contact_State__c = 'Active';
        con1.NSN_ID_Text__c = '1879511';
        con1.ownerId = DummyUser1.Id;
        insert con1;    
                
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio1';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.CPVi_Composite__c = 25.0;
        portfolio.CPVi_Past__c = 29.0;
        portfolio.CPVi_Future__c = 55.0; 
        portfolio.CPV_Trend__c  = 'Up';
        portfolio.Portfolio_Business_Unit__c = 'CEF Central Functions';
        portfolio.X8D__c = true;
        insert portfolio;
        
        QIPP_Portfolio__c portfolio1 = new QIPP_Portfolio__c();
        portfolio1.Name = 'Test Portfolio2';
        portfolio1.Portfolio_Owner__c = con.id;
        portfolio1.ownerId = DummyUser.Id;
        portfolio1.CDT_Lead__c = con.id;
        portfolio1.CPVi_Composite__c = 25.0;
        portfolio1.CPVi_Past__c = 29.0;
        portfolio1.CPVi_Future__c = 55.0; 
        portfolio1.CPV_Trend__c  = 'Up';
        portfolio1.Portfolio_Business_Unit__c = 'CEF Central Functions';
        insert portfolio1;
        
        Portfolios_Owner__c po = new Portfolios_Owner__c();
        po.QIPP_Contact__c = con.Id;
        po.QIPP_Portfolio__c = portfolio.id;
        po.Email__c = 'a@a.a';
        insert po;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: 8D').getRecordTypeId();
        project.Portfolio_Name__c = portfolio.id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser1.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Portfolio_BU__c = 'CEF Central Functions';
        //project.Implementing_BL__c = '3GCore';
        insert project;
  

        QIPP_Project__c project1 = new QIPP_Project__c();
        project1 = project.clone();
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Name_Succinct__c = 'Test Project1';
        project1.Primary_QLT_Function__c = 'CO';
        project1.Project_State__c = 'On hold';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con1.id;
        project1.ownerid = DummyUser1.Id;
        project1.Report_Name__c = 'Executive Dashboards';
        project1.Report_Type__c = 'Summary of Projects by Project Type ';
        project1.Portfolio_BU__c = 'CEF Central Functions';
        insert project1;
        
                
         QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 01, 01);   
         Date enddate = Date.newInstance(2013, 03, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Planned_Operational_Manual_Amount__c = 500;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Achieved_Operational_Manual_Amount__c = 500;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 04, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 04, 31);         
         benifit.Future_Operational_Manual_Amount__c = 500;
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         insert benifit;
        
        QIPP_BU_Reporting__c obj1 = new QIPP_BU_Reporting__c();
        obj1.Benefit_ID__c  = benifit.id;
        obj1.Project_ID__c = project.id;
        obj1.Quarters__c = 'Q1';                           
        obj1.Years__c = '2014';
        obj1.Months__c = '2';        
        insert obj1;    
        
       
        insert new Trigger_Control__c(Run_Triggers__c = True);              
        project.Project_Name_Succinct__c = 'Test Project3';
        project.Portfolio_BU__c = 'Chief innovation and Operating office';
        project.Project_BL__c = 'Multiple BLs';
        project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BUs';
        project.Project_Lead_Business_Grp__c = 'CFOO111';
        project.Project_Lead_Business_Unit__c = 'CFOO211';
        project.Project_Lead_Business_Line__c = 'CFOO311';
        project.DI_State__c = 'Not Started';
        project.Belt_Project_Type__c = 'BB: 1 of 1 Certification Project';
        update project;
       
    }
    
    static testmethod void beforeInsert2()
    {
        User DummyUser = new User();
        DummyUser.LastName = 'adc';
        DummyUser.FirstName = 'adc';
        DummyUser.Alias = 'adc';
        DummyUser.Email = 'a@a.a';
        DummyUser.Username = 'a@a.a.adc';
        DummyUser.CommunityNickname = 'a';
        DummyUser.IsActive = TRUE;
        DummyUser.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser.LocaleSidKey = 'en_US';
        DummyUser.EmailEncodingKey = 'ISO-8859-1';
        DummyUser.LanguageLocaleKey = 'en_US';
        insert DummyUser;
        
        User DummyUser1 = new User();
        DummyUser1.LastName = 'xyz';
        DummyUser1.FirstName = 'xyz';
        DummyUser1.Alias = 'xyz';
        DummyUser1.Email = 'b@b.a';
        DummyUser1.Username = 'b@b.a.adc';
        DummyUser1.CommunityNickname = 'b';
        DummyUser1.IsActive = TRUE;
        DummyUser1.ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%System Administrator%' LIMIT 1].Id;
        DummyUser1.TimeZoneSidKey = 'Asia/Kamchatka';
        DummyUser1.LocaleSidKey = 'en_US';
        DummyUser1.EmailEncodingKey = 'ISO-8859-1';
        DummyUser1.LanguageLocaleKey = 'en_US';
        insert DummyUser1; 
        
        QIPP_Contacts__c con = new QIPP_Contacts__c();
        con.Name = 'adc adc';
        con.Email__c = 'a@a.a';
        con.Contact_State__c = 'Active';
        con.NSN_ID_Text__c = '12234345';
        con.ownerId = DummyUser.Id;
        insert con;
        
        QIPP_Contacts__c con1 = new QIPP_Contacts__c();
        con1.Name = 'test test';
        con1.Email__c = 'b@b.a';
        con1.Contact_State__c = 'Active';
        con1.NSN_ID_Text__c = '1879511';
        con1.ownerId = DummyUser1.Id;
        insert con1;    
                
        QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
        portfolio.Name = 'Test Portfolio1';
        portfolio.Portfolio_Owner__c = con.id;
        portfolio.ownerId = DummyUser.Id;
        portfolio.CDT_Lead__c = con.id;
        portfolio.CPVi_Composite__c = 25.0;
        portfolio.CPVi_Past__c = 29.0;
        portfolio.CPVi_Future__c = 55.0; 
        portfolio.CPV_Trend__c  = 'Up';
        portfolio.Portfolio_Business_Unit__c = 'CEF Central Functions';
        portfolio.X8D__c = true;
        insert portfolio;
        
        QIPP_Portfolio__c portfolio1 = new QIPP_Portfolio__c();
        portfolio1.Name = 'Test Portfolio2';
        portfolio1.Portfolio_Owner__c = con.id;
        portfolio1.ownerId = DummyUser.Id;
        portfolio1.CDT_Lead__c = con.id;
        portfolio1.CPVi_Composite__c = 25.0;
        portfolio1.CPVi_Past__c = 29.0;
        portfolio1.CPVi_Future__c = 55.0; 
        portfolio1.CPV_Trend__c  = 'Up';
        portfolio1.Portfolio_Business_Unit__c = 'CEF Central Functions';
        insert portfolio1;
        
        QIPP_Project__c project = new QIPP_Project__c();
        project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: 8D').getRecordTypeId();
        project.Portfolio_Name__c = portfolio.id;
        project.Project_Completion_Date_Target__c = Date.Today();
        project.Project_Name_Succinct__c = 'Test Project1';
        project.Primary_QLT_Function__c = 'CO';
        project.Project_State__c = 'On hold';
        project.Last_Review_Type__c = 'Final';
        project.Project_Lead__c = con.id;
        project.ownerid = DummyUser1.Id;
        project.Report_Name__c = 'Executive Dashboards';
        project.Report_Type__c = 'Summary of Projects by Project Type ';
        project.Portfolio_BU__c = 'CEF Central Functions';
        //project.Implementing_BL__c = '3GCore';
        insert project;
  

        QIPP_Project__c project1 = new QIPP_Project__c();
        project1 = project.clone();
        project1.Project_Completion_Date_Target__c = Date.Today();
        project1.Project_Name_Succinct__c = 'Test Project1';
        project1.Primary_QLT_Function__c = 'CO';
        project1.Project_State__c = 'On hold';
        project1.Last_Review_Type__c = 'Final';
        project1.Project_Lead__c = con1.id;
        project1.ownerid = DummyUser1.Id;
        project1.Report_Name__c = 'Executive Dashboards';
        project1.Report_Type__c = 'Summary of Projects by Project Type ';
        project1.Portfolio_BU__c = 'CEF Central Functions';
        insert project1;
        
                
         QIPP_Benefit_Conversion_Table__c conversions = new  QIPP_Benefit_Conversion_Table__c(); 
        conversions.Name = 'NCDR';
        conversions.Benefit_Type__c = 'Operational Savings';
        conversions.Monetization_Calculation_Method__c = 'Manual';
        INSERT conversions;
        
        QIPP_Benefit_Conversion_Rate__c obj = new QIPP_Benefit_Conversion_Rate__c();
        obj.Conversion_Rate__c = 9.0;
        obj.Fiscal_Quarter__c = 'Q1';
        obj.Fiscal_Year__c = '2013';
        obj.Improvement_Measure__c = conversions.id;
           
        QIPP_Benefit__c benifit = new QIPP_Benefit__c();
         benifit.Baseline_Rate_N__c = 100;
         benifit.Financial_Type__c = 'Operational Savings';
         benifit.Business_Line__c = 'GSM';
         benifit.Improvement_Measure_KPI__c = conversions.id;         
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Baseline_Period_weeks__c = 4.35;
         benifit.Directional_Indicator__c = 'Higher is Favorable' ;
         Date startdate = Date.newInstance(2013, 01, 01);   
         Date enddate = Date.newInstance(2013, 03, 31);
         benifit.Baseline_Quantity__c = 15;
         benifit.Type_of_Measure__c = 'Weekly Rate' ;
         benifit.Planned_Quanity__c = 500;
         benifit.Planned_Benefit_Period_Weeks__c = 4.33;
         benifit.Planned_Start_Date__c = startdate  ;
         benifit.Planned_End_Date__c = enddate ;
         benifit.Planned_Operational_Manual_Amount__c = 500;
         benifit.Achieved_Quantity__c = 50;
         benifit.Achieved_Start_Date__c = startdate  ;
         benifit.Achieved_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Achieved_End_Date__c = enddate  ;
         benifit.Achieved_Operational_Manual_Amount__c = 500;
         benifit.Future_Quantity__c = 50;
         benifit.Future_Start_Date__c = Date.newInstance(2013, 04, 01);
         benifit.Future_Benefit_Period_Weeks__c = 4.33 ;
         benifit.Future_End_Date__c = Date.newInstance(2013, 04, 31);         
         benifit.Future_Operational_Manual_Amount__c = 500;
         benifit.Unit_of_Measure__c = 'Each';
         benifit.Project_ID__c = project.id;
         insert benifit;
        
        QIPP_BU_Reporting__c obj1 = new QIPP_BU_Reporting__c();
        obj1.Benefit_ID__c  = benifit.id;
        obj1.Project_ID__c = project.id;
        obj1.Quarters__c = 'Q1';                           
        obj1.Years__c = '2014';
        obj1.Months__c = '2';        
        insert obj1;    
        
         
        project.Project_Name_Succinct__c = 'Test Project3';
        update project;
        insert new Trigger_Control__c(Run_Triggers__c = True);                
        delete project;
        delete project1;
       
    }    
     
   /* public testMethod static void testCase4(){

        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            User DummyUser = new User(LastName = 'adc',FirstName = 'adc',Alias = 'adc',Email = 'a@a.a',
                Username = 'a@a.a.adc',CommunityNickname = 'a',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Project Lead%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser;
            
            
                Trigger_Control__c   setting = new Trigger_Control__c   ();
                //setting.Name = 'Test Setting';
                setting.Run_Triggers__c = true;
                insert setting;
                    
                QIPP_Contacts__c con = new QIPP_Contacts__c();
                con.Name = 'Abhishek';
                con.Email__c = 'a@a.a';
                con.Contact_State__c = 'Active';
                con.NSN_ID_Text__c = '12234345';
                con.Belt_Certification__c='Nokia-Green Belt';
                con.Contact_BU__c='CFOO346';
                con.Contact_BL__c='CFOO3';
                con.Contact_L4_Org__c='CFOO5';
                con.User_License__c = DummyUser.id;
                con.CoPQ_Role_1__c='Business Unit Master Black Belt';
                con.CoPQ_Role_2__c='BL Transformation Lead';
                con.CoPQ_Role_3__c='Finance Approver';
                con.CoPQ_Role_4__c='Business Owner Delegate';
                insert con;
    
                QIPP_Portfolio__c portfolio = new QIPP_Portfolio__c();
                portfolio.Name = 'Test Portfolio1';
                portfolio.Portfolio_Owner__c = con.id;
                portfolio.ownerId = DummyUser.Id;
                portfolio.CDT_Lead__c = con.id;
                portfolio.CPVi_Composite__c = 25.0;
                portfolio.CPVi_Past__c = 29.0;
                portfolio.CPVi_Future__c = 55.0; 
                portfolio.CPV_Trend__c  = 'Up';
                portfolio.Portfolio_Status__c = 'Active';
                portfolio.A3__c = true;
                portfolio.Lean_including_Kaizen__c = true;
                portfolio.Portfolio_Business_Unit__c = 'Human Resources';
                insert portfolio;
                
                QIPP_Project__c project = new QIPP_Project__c();
                project.Portfolio_Name__c = portfolio.id;
                project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: A3').getRecordTypeId();
                project.Project_Completion_Date_Target__c = Date.Today();
                project.Project_Completion_Date_Forecast__c = Date.Today();
                project.Project_Description_Detailed__c = 'asdasd';
                project.Project_Name_Succinct__c = 'Test Project1';
                project.Portfolio_BU__c = 'Human Resources';
                project.Project_BL__c = 'Multiple BUs';
                project.Benefitting_Project_BL_Level_4_Org__c = 'Multiple BLs';
                project.CEMT_ID__c = 'sda';
                project.Primary_QLT_Function__c = 'CO';
                project.Last_Review_Type__c = 'Final';
                project.Project_Lead__c = con.id;
                project.Project_Sponsor__c = con.id;
                project.ownerid = DummyUser.Id;
                project.Project_Document__c = 'https://www.tset.com';
                project.Project_State__c = 'In Progress';
                project.Finance_Approver__c = con.Id;
                insert project;
                system.debug('@@Project insert:'+project);
            
        }
    }  */  
    
}