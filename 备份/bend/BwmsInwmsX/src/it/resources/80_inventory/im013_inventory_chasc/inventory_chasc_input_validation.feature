#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@inventory @chasc @input @defaultdatabased


Feature: IM.013-001: inventory/transaction/chasc - Inventory CHASC input validation
         This feature file tests the input validation of the CHASC booking (Change Separation Criteria)
         Different flawed inputs are entered and the resulting error message is verified.
         
Background: 	
	Given set global: idSite = "RL1", idClient = "RK1"


########################- Failure -##################################
###########################- 1 -#####################################
	Scenario: IM.013-001-0001: CHASC fails, if the idSite is empty.
						BEND-0005: Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 2500 pieces of article "40067005" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: idSite = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
###########################- 2 -#####################################
	Scenario: IM.013-001-0002: CHASC fails, if the clProcess is empty.
						BEND-0005: Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 2500 pieces of article "40067005" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: clProcess = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
########################- Success -##################################
###########################- 1 -#####################################
@notSuccess
Scenario: IM.013-001-0031: CHASC Success, if qtyMoved -1 for current location is at source area
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 2500 pieces of article "40067005" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC is called
	#Clean-Up
	Then delete quantum "Qu"	

###########################- 2 -#####################################
@Success
Scenario Outline: IM.013-001-0031: CHASC Success with condition: InventoryChascInput is filled correctly without artvar for an article without artvar management
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10 pieces of article <ArticleNr> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is null and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: artvar = null
		  And CHASC is called
	#Clean-Up
	Then delete quantum "Qu"	
	
	Examples:
	|ArticleNr|
	|"40067008"|
	|"55534011"|
	|"55534012"|
	|"55534013"|
	
	
	
	
	
	
