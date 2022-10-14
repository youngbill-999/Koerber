#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@inventory @chasc @TEST @defaultdatabased


Feature: IM.013-007: inventory/transaction/chasc - Inventory CHASC successful execution 
         This feature file tests the successful execution of the CHASC booking (Change Separation Criteria)
         
Background: 	
	Given set global: idSite = "RL1", idClient = "RK2"
	
	
###########################- 1 -#####################################

Scenario: IM.013-007-0001: CHASC Success, if qtyMoved -1 for current location is at source area
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 2500 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with qtyType = "AVAILABLE" and qtyMoved = 2499
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
	#Clean-Up
	Then delete quantum "Qu"	

###########################- 2 -#####################################

Scenario Outline: IM.013-007-0002: CHASC Success if InventoryChascInput is filled correctly without artvar for an article without artvar management
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10 pieces of article <ArticleNr> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is null and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: artvar = null
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
	#Clean-Up
	Then delete quantum "Qu"	
	
	Examples:
	|ArticleNr|
	|"555-OBJ01"|
	|"555-PRT08"|
	|"555-SEL07"|
	|"CO-01A"|
	|"UP-E63"|
	
###########################- 3 -#####################################

Scenario Outline: IM.013-007-0003: CHASC Success if InventoryChascInput is filled correctly without batch for an article without batch management
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10 pieces of article <ArticleNr> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: batch = null
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
	#Clean-Up
	Then delete quantum "Qu"	
	
	Examples:
	|ArticleNr|
	|"WT-XP3"|
	|"WL-BG2"|
	|"V5-I68"|
	|"LSK-25"|
	|"9A-0A1"|
	
 
	
	###########################- 4 -#####################################
	Scenario: IM.013-007-0002: CHASC Success with condition: 
	InventoryChascInput is filled correctly with a decimal quantity for an article that allows decimals (Site Parameter ART_UNIT_STOCK_WITH_DECIMALS)
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10 pieces of article "LSK-25" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with qtyType = "AVAILABLE" and qtyMoved = 0.2
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
	
	
