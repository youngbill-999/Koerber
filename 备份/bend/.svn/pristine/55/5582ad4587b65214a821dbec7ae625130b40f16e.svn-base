#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :

@inventory @LABEL_PRINT @defaultdatabased
Feature: IM.021-001: inventory/printPidLbl - Prints the label configured for DIALOG/IM_PID_LBL/LU_Type

         Creates a new Load Unit and call Web Service printPidLbl to print its Label.
         
 Background:
    Given set global: idSite = "RL1", idClient = "RK1"
    
    
 Scenario: IM.021-001-001: Create a test Load Unit to Print
  
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
		When CRELU is called
		Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
    When the Load Unit "Lu" exist, print its label with configuration IM_PID_LBL
    
    #Clean-Up
    Then delete load unit "Lu"
   