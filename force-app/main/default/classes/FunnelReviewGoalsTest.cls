@isTest
public class FunnelReviewGoalsTest{

    static testmethod void testReviewGoals(){
    
          FunnelDataFactory.FunnelTestWrapper fw1 = new FunnelDataFactory.FunnelTestWrapper();
          fw1.index = 1;   
          fw1.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
          
         
          UserRole r1 = new UserRole(DeveloperName = 'MyCustomRole0A'+fw1.index , Name = 'My Role'+fw1.index);
          insert r1;
          
          fw1.userRoleId = r1.id;
           
          List<User> userList1 = FunnelDataFactory.createUser(fw1,1);
          insert userList1;
          
          PermissionSet ps = [SELECT ID From PermissionSet WHERE Name = 'Funnel_Sales_Profile_Company_Level_access'];
          insert new PermissionSetAssignment(AssigneeId = userList1[0].id, PermissionSetId = ps.Id );
          
          System.runAs ( userList1[0] ) {
          
              date d = date.newinstance(date.today().year(), Date.Today().Month(), 1);
              Fiscal_Year_Setting__c fiscalYr = FunnelDataFactory.setFiscalYear(d);
              insert fiscalYr;
             
              FunnelDataFactory.FunnelTestWrapper fw = new FunnelDataFactory.FunnelTestWrapper();
              fw.index = 1;   
              fw.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;          
             
              UserRole r = new UserRole(DeveloperName = 'MyCustomRole'+fw.index , Name = 'My Role'+fw.index);
              insert r;
              
              fw.userRoleId = r.id;
               
              List<User> userList = FunnelDataFactory.createUser(fw,1);
              insert userList;
              system.debug(userList);
             
              List<Sales_Rep_Profile__c> sp = FunnelDataFactory.createSalesReplist(userList);
              insert sp;
              system.debug('SP0'+sp[0]);
              
              List<Opportunity > op= FunnelDataFactory.createopplist(userList);
              insert op;
              system.debug('OP0'+op[0]);
              
              List<Lead> l= FunnelDataFactory.createLeadlist(userList);
              insert l;
              system.debug('L0'+l[0]);
              
              List<Task> e = FunnelDataFactory.createTasklist(userList);
              insert e ;
              system.debug('E0'+e[0]);
              system.debug('E'+e);
              
              List<event> e1 = FunnelDataFactory.createEventlist(userList);
              insert e1 ;
              
              Test.startTest();
              Application_Setting__c ase = new Application_Setting__c (Enable_Manger_Goal_Update__c  = true); 
              insert ase;  
              
              Yearly_goals_by_Role__c yg = new Yearly_goals_by_Role__c();
              yg.Year__c = 2020;
              insert yg;
              
                  
              FunnelReviewGoals_Controller c = new FunnelReviewGoals_Controller();
              c.recordId = yg.id;
              system.debug(' record id '+yg.id);
              c.adminPer = true;
              c.isMgr =true;
              c.applyAll = true;
              c.displayModal();
              c.saveUpdate();
              c.onEdit();
              
              c.activedeactiveUpate();
              c.navigateToCertification();
              c.navigateToDashboard();
              c.navigateToCalculator();
              c.navigateToHomePage();
              c.navigateToReportsPage();
              c.navigateToAppSetup();
              c.navigateToCertificateReports();
              c.navigateToAssignRole();
              c.navigateToCustomMetric();
              c.navigateToNotifications();
              c.navigateToAnalytics();
              c.navigateToFunnelAnalyticQualitative();
              c.navigateToFunnelAnalytic();
              c.navigateToFunnelEvaluationGuidelines();
              c.navigateToAnnualizationDashboard();
              c.navigateToFunnelSetup();
              c.navigateToFunnelReviewGoals();
              c.navigateToFunnelManagerUpdate();
              c.navigateToRatings();
              c.navigateToHelpMenu();
              c.navigateToGoals();
              c.navigateToFunnelAddEditSRP();
              c.navigateToSalesPipeline();
              c.navigateToTrendingByRep();
              c.navigateToTrendingBySkill();
              
              PageReference p = c.navigateToFunnelAnalytic();
              system.assert(true,p.getUrl().contains('FunnelAnalytic'));
              p = c.checkThemeAndNavigate();

              Test.stopTest();
                        
        }
      
    }
}