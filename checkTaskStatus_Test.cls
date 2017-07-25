@isTest
public class checkTaskStatus_Test {

    public testMethod static void testCase1(){

        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            User DummyUser = new User(LastName = 'adc',FirstName = 'adc',Alias = 'adc',Email = 'a@a.a',
            Username = 'a@a.a.adc',CommunityNickname = 'a',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Portfolio Manager%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser;
            
            System.runAs (DummyUser) {
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
                portfolio.CIF__c = true;
                portfolio.Lean_including_Kaizen__c = true;
                portfolio.Portfolio_Business_Unit__c = 'Human Resources';
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
                portfolio1.Portfolio_Status__c = 'Active';
                portfolio1.CIF__c = true;
                portfolio1.Lean_including_Kaizen__c = true;
                portfolio1.Portfolio_Business_Unit__c = 'Global';
                insert portfolio1;
                
                QIPP_Project__c project = new QIPP_Project__c();
                project.Portfolio_Name__c = portfolio.id;
                project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
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
                project.CIF_Phase__c = 'ASA';
                project.Deployment_Date__c = Date.Today();
                project.Institutionalize_Date__c = Date.Today();
                project.ownerid = DummyUser.Id;
                project.Report_Name__c = 'Executive Dashboards';
                project.Report_Type__c = 'Summary of Projects by Project Type ';
                project.Project_Document__c = 'https://www.tset.com';
                project.Project_State__c = 'In Progress';
                project.Finance_Approver__c = con.Id;
                project.Improvement_Owner__c = con.Id;            
                insert project;
                system.debug('@@Project insert:'+project);
                
                QIPP_Task__c tsk = new QIPP_Task__c();
                tsk.Task_Name_Succinct__c = 'Test Task';
                tsk.Task_Type__c = 'Activity';
                tsk.ownerId = DummyUser.id;
                tsk.Task_State__c = 'On hold';
                tsk.Project_ID__c = project.id;
                tsk.Task_Initiator__c = con.id;
                tsk.Task_Percent_Complete__c = 0.2;
                insert tsk;
                system.debug('@@Project task:'+tsk);

                Test.startTest();
                try{
                    TriggerHelper.alreadyModified = true;
                    project.Project_State__c = 'Complete';
                    update project;
                }catch(Exception e){system.debug('@@Error:'+e);}

                Test.stopTest();
            }
        }
    }
    
    public testMethod static void testCase2(){

        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            User DummyUser = new User(LastName = 'adc',FirstName = 'adc',Alias = 'adc',Email = 'a@a.a',
                Username = 'a@a.a.adc',CommunityNickname = 'a',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Portfolio Manager%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser;

            //System.runAs (DummyUser) {
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
            portfolio.CIF__c = true;
            portfolio.Lean_including_Kaizen__c = true;
            portfolio.Portfolio_Business_Unit__c = 'Human Resources';
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
            portfolio1.Portfolio_Status__c = 'Active';
            portfolio1.CIF__c = true;
            portfolio1.Lean_including_Kaizen__c = true;
            portfolio1.Portfolio_Business_Unit__c = 'Global';
            insert portfolio1;
            
            QIPP_Project__c project = new QIPP_Project__c();
            project.Portfolio_Name__c = portfolio.id;
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
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
            project.CIF_Phase__c = 'ASA';
            project.Deployment_Date__c = Date.Today();
            project.Institutionalize_Date__c = Date.Today();
            project.ownerid = DummyUser.Id;
            project.Report_Name__c = 'Executive Dashboards';
            project.Report_Type__c = 'Summary of Projects by Project Type ';
            project.Project_Document__c = 'https://www.tset.com';
            project.Project_State__c = 'In Progress';
            project.Finance_Approver__c = con.Id;
            project.Improvement_Owner__c = con.Id;
            project.Business_Unit_Master_Black_Belt__c = con.Id;
            insert project;
            system.debug('@@Project insert:'+project);

            Test.startTest();
            try{
                TriggerHelper.alreadyModified = true;
                project.Portfolio_Name__c = portfolio1.id;
                //project.Check_Approval_Process_Status__c = 'CIF Recall/Reject';
                //project.WorkflowPortfolioReject__c = true;
                update project;
            }catch(Exception e){system.debug('@@Error:'+e);}

            Test.stopTest();
        //}
        }
    }
    
    public testMethod static void testCase3(){

        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            User DummyUser = new User(LastName = 'adc',FirstName = 'adc',Alias = 'adc',Email = 'a@a.a',
                Username = 'a@a.a.adc',CommunityNickname = 'a',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Portfolio Manager%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser;
            
            User DummyUser1 = new User(LastName = 'adc1',FirstName = 'adc1',Alias = 'adc1',Email = 'a1@a.a',
                Username = 'a1@a.a.adc',CommunityNickname = 'a1',IsActive = TRUE,
                ProfileId = [SELECT Id FROM Profile WHERE Name LIKE '%Nokia QIPP Project Lead%' LIMIT 1].Id,
                UserRoleId = [SELECT Id FROM UserRole WHERE Name LIKE '%QIPP Portfolio Manager%' LIMIT 1].Id,
                TimeZoneSidKey = 'Asia/Kamchatka',LocaleSidKey = 'en_US',EmailEncodingKey = 'ISO-8859-1',LanguageLocaleKey = 'en_US');
            insert DummyUser1;
            
            //System.runAs (DummyUser) {
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
            
            QIPP_Contacts__c con1 = new QIPP_Contacts__c();
            con1.Name = 'Abhishek1';
            con1.Email__c = 'a1@a.a';
            con1.Contact_State__c = 'Active';
            con1.NSN_ID_Text__c = '122343451';
            con1.Belt_Certification__c='Nokia-Green Belt';
            con1.Contact_BU__c='CFOO346';
            con1.Contact_BL__c='CFOO3';
            con1.Contact_L4_Org__c='CFOO5';
            con1.User_License__c = DummyUser1.id;
            con1.CoPQ_Role_1__c='Business Unit Master Black Belt';
            con1.CoPQ_Role_2__c='BL Transformation Lead';
            con1.CoPQ_Role_3__c='Finance Approver';
            con1.CoPQ_Role_4__c='Business Owner Delegate';
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
            portfolio.Portfolio_Status__c = 'Active';
            portfolio.CIF__c = true;
            portfolio.Lean_including_Kaizen__c = true;
            portfolio.Portfolio_Business_Unit__c = 'Human Resources';
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
            portfolio1.Portfolio_Status__c = 'Active';
            portfolio1.CIF__c = true;
            portfolio1.Lean_including_Kaizen__c = true;
            portfolio1.Portfolio_Business_Unit__c = 'Global';
            insert portfolio1;
            
            QIPP_Project__c project = new QIPP_Project__c();
            project.Portfolio_Name__c = portfolio.id;
            project.RecordTypeId = Schema.SObjectType.QIPP_Project__c.getRecordTypeInfosByName().get('Methodology: CIF').getRecordTypeId();
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
            project.CIF_Phase__c = 'ASA';
            project.Deployment_Date__c = Date.Today();
            project.Institutionalize_Date__c = Date.Today();
            project.ownerid = DummyUser.Id;
            project.Report_Name__c = 'Executive Dashboards';
            project.Report_Type__c = 'Summary of Projects by Project Type ';
            project.Project_Document__c = 'https://www.tset.com';
            project.Project_State__c = 'In Progress';
            project.Finance_Approver__c = con.Id;
            project.Improvement_Owner__c = con.Id;
            project.Business_Unit_Master_Black_Belt__c = con.Id;
            insert project;
            system.debug('@@Project insert:'+project);

            Test.startTest();
            try{
                TriggerHelper.alreadyModified = true;
                project.Portfolio_Name__c = portfolio1.id;
                project.Business_Unit_Master_Black_Belt__c = con1.Id;
                update project;
            }catch(Exception e){system.debug('@@Error:'+e);}

            Test.stopTest();
        //}
        }
    }
    
    public testMethod static void testCase4(){

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
            
            System.runAs (DummyUser){
                Test.startTest();
                try{
                    TriggerHelper.alreadyModified = true;
                    project.Project_State__c = 'Closed';
                    update project;
                }catch(Exception e){system.debug('@@Error:'+e);}

                Test.stopTest();
            }
        }
    }
}