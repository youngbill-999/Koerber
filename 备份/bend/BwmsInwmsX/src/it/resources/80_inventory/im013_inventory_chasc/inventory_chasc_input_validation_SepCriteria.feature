#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@inventory @chasc  @defaultdatabased


Feature: IM.013-001: inventory/transaction/chasc - Inventory CHASC input validation - Separation Criteria
         
Background: 	
	Given set global: idSite = "RL1", idClient = "RK1"



###########################- 17 -###################################
Scenario Outline: IM.013-001-0017-01: CHASC fails, if separation criteria is invalid
              mandatory separation criterion is not filled in the input → BWM_0004
              separation criterion has invalid value → BWM_0005####issue
              value for separation criterion that is not configured → BWM_0006####issue
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "40067005" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: sepCrit01 = <sepCrit01>, sepCrit02 = <sepCrit02>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|sepCrit01|sepCrit02|exception-code|
	|null|null|"BWM-0004"|
	|"0011"|null|"BWM-0004"|
	|null|"0220"|"BWM-0004"|
	

	
	
	 
	