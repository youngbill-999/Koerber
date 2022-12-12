#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@inventory @chasc @defaultdatabased


Feature: IM.013-001: inventory/transaction/chasc - Inventory CHASC input validation
         This feature file verify the input of the CHASC booking (Change Separation Criteria)
         Different flawed inputs are entered and the corresponding error massage code need to be checked
         
Background: 	
	Given set global: idSite = "RL1", idClient = "RK2"

###########################- 1 -#####################################

	Scenario: IM.013-001-01: CHASC fails, if the idSite is empty.
						The Error Code "BEND-0005":Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"

  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: idSite = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
###########################- 2 -#####################################

	Scenario: IM.013-001-02: CHASC fails, if the clProcess is empty.
						The Error Code "BEND-0005":Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: clProcess = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	###########################- 3 -#####################################
	
	Scenario: IM.013-001-03: CHASC fails, if the typProcess is empty.
						The Error Code "BEND-0005":Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: typProcess = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	

###########################- 4 -#####################################

	Scenario: IM.013-001-04: CHASC fails, if the stepProcess is empty.
						The Error Code "BEND-0005":Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: stepProcess = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
	###########################- 5 -#####################################
	
	Scenario: IM.013-001-05: CHASC fails, if the key is empty.
						The Error Code "BEND-0005":Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: key = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
	
	###########################- 6 -#####################################

	Scenario: IM.013-001-06: CHASC fails, if the idUser is empty.
						The Error Code "BEND-0005":Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: idUser = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
 ###########################- 7 -#####################################
	Scenario Outline: IM.013-001-07: CHASC fails, if the  references are filled inconsistently
						1.when idRef null and any of the idRef1 to idRef6 is filled
						The Error Code "BWM-0008":Combination reference type and id not correctly filled: if type is filled at least one Id must be filled, too.
            2.when idRef = GI_ORDER and idRef1 = null (but other idRef filled)
            The Error Code "BWM-0008":Combination reference type and id not correctly filled: if type is filled at least one Id must be filled, too.
            3.when idRef = ABC (idRef1-6 irrelevant)
            The Error Code "BWM-0008":Combination reference type and id not correctly filled: if type is filled at least one Id must be filled, too.
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has References: typRef = <typRef>, idRef1 = <idRef1>, idRef2 = <idRef2>, idRef3 = <idRef3>, idRef4 = <idRef4>, idRef5 = <idRef5>, idRef6 = <idRef6>
		  And CHASC is called
	Then WEBSERVICE fails: error = "BWM-0008"
	#Clean-Up
	Then delete quantum "Qu"	
	
	Examples:
	|typRef    |idRef1|idRef2|idRef3|idRef4|idRef5|idRef6|
	#1.when idRef null and any of the idRef1 to idRef6 is filled
	|null      |"test"|null  |null  |null  |null  |null  |
	|null      |null  |"test"|null  |null  |null  |null  |
	|null      |null  |null  |"test"|null  |null  |null  |
	|null      |null  |null  |null  |"test"|null  |null  |
	|null      |null  |null  |null  |null  |"test"|null  |
	|null      |null  |null  |null  |null  |null  |"test"|
	#2.when idRef = GI_ORDER and idRef1 = null (but other idRef filled)
	|"GI_ORDER"|null  |"test"|"test"|"test"|"test"|"test"|
	#3.when idRef = ABC (idRef1-6 irrelevant)
	|"ABC"     |null  |null  |null  |null  |null  |null  |  
	
	
	###########################- 8 -#####################################
	Scenario: IM.013-001-08: CHASC fails, if the class-type-step-process combination is invalid
						The Error Code "IM-0032":No situation can be determined by parameters: transaction type {0}, process class {1}, process type {2}, process step {3}, client {4}, key {5}
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: typProcess = "DIALOG"
		  And CHASC input has: clProcess = "IM100"
		  And CHASC input has: stepProcess = "BOOK"
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0032"
	#Clean-Up
	Then delete quantum "Qu"	
	
	###########################- 9 -#####################################
	Scenario: IM.013-001-09: CHASC fails, if idQuantum is empty 
	          The Error Code "BEND-0005":Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: idQuantum = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
	
	###########################- 10 -#####################################
	Scenario: IM.013-001-10: CHASC fails, if qtyType is null
	          The Error Code "IM_0804":The quantity type has to be filled!
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: qtyType = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0804"
	#Clean-Up
	Then delete quantum "Qu"	
	
	###########################- 11 -#####################################
	Scenario Outline: IM.013-001-11: CHASC fails, if qtyMoved  is -1 or 0
	                  The Error Code "IM_0810":The quantity must be greater than 0! 
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: qtyMoved = <qtyMoved>
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0810"
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|qtyMoved|
	|-1      |
	|0       |
	
	###########################- 12 -#####################################
	Scenario Outline: IM.013-001-12: CHASC fails, if typStock is null or invalid(e.g. "TST")
	             1.InventoryChascInput is filled correctly, except for typStock which is null
	             The Error Code "IM_0814":The stock type has to be filled!
               2.InventoryChascInput is filled correctly, except for typStock which is invalid (for example "TST") 
               The Error Code "BWM-0002":Invalid value {0} for list {1}!
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: typStock = <typStock>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|typStock|exception-code|
	|null    |"IM-0814"     |
	|"TST"   |"BWM-0002"    |
	
	###########################- 13 -####################################
	Scenario Outline: IM.013-001-13: CHASC fails, if typLock is null or invalid(e.g. "TST")
	                  1.InventoryChascInput is filled correctly, except for typLock which is invalid (for example "TST") 
	                  The Error Code "BWM-0002":Invalid value {0} for list {1}! 
                    2.InventoryChascInput is filled correctly, except for typLock which is null
                    The Error Code "IM-0813":The lock type has to be filled!
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: typLock = <typLock>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|typLock|exception-code|
	|null   |"IM-0813"     |
	|"TST"  |"BWM-0002"    |
	
	###########################- 14 -####################################
	Scenario Outline: IM.013-001-14: CHASC fails, if statQualityControl is null or invalid(e.g. "XX")
	             1.InventoryChascInput is filled correctly, except for stat quality control which is null
	 	             The Error Code "IM_0811":The QC status has to be filled!
               2.InventoryChascInput is filled correctly, except for stat quality control which is invalid (for example "XX") 
                 The Error Code "BWM_0002":Invalid value {0} for list {1}!
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: statQualityControl = <statQualityControl>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|statQualityControl|exception-code|
	|null              |"IM-0811"     |
	|"XX"              |"BWM-0002"    |
	
	###########################- 15 -####################################
	Scenario Outline: IM.013-001-15: CHASC fails, if statCustoms is null or invalid(e.g. "XX")
	                  1.InventoryChascInput is filled correctly, except for stat customs which is null
	                    The Error Code "IM_0812":The customs status has to be filled!
                    2.InventoryChascInput is filled correctly, except for stat customs  which is invalid (for example "XX") 
                      The Error Code "BWM_0002":Invalid value {0} for list {1}!
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
 When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: statCustoms = <statCustoms>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|statCustoms|exception-code|
	|null       |"IM-0812"     |
	|"XX"       |"BWM-0002"    |
	
	
	###########################- 16 -###################################
	Scenario Outline: IM.013-001-16: CHASC fails, if special stock type and ID combination are not allowed
	                  1.special stock type is not null, ID is null
	                    The Error Code "IM_0013":Invalid data: Special stock type or id are empty: {0} / {1}!
                    2.special stock type is invalid, for example "XX", ID is not null 
                      The Error Code "BWM_0002":Invalid value {0} for list {1}
                    3.special stock type is null, ID is not null
                      The Error Code "IM_0013":Invalid data: Special stock type or id are empty: {0} / {1}!
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: specialTypStock = <specialTypStock> and idSpecialTypStock = <idSpecialTypStock>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|specialTypStock|idSpecialTypStock|exception-code|
	|"CUST"         |null             |"IM-0013"     |
	|"SUPP"         |null             |"IM-0013"     |
	|"XX"           |"456789"         |"BWM-0002"    |
	|null           |"456789"         |"IM-0013"     |
	
	###########################- 17 -###################################
Scenario: IM.013-001-17-01: CHASC fails, if separation criteria is invalid
             1.separation criterion has invalid value
             The Error Code "BEND-0005":Field {0} must not be null
             2.mandatory separation criterion is not filled in the input(see inventory_chasc_input_validation_SepCriteria.feature for IM.013-001-17-02)
              The Error Code "BWM_0004":Invalid separation criterium, no value for {0}!
             3.value for separation criterion that is not configured(see inventory_chasc_input_validation_SepCriteria.feature for IM.013-001-17-03)
              The Error Code "BWM_0021":Separation Criterion {0} can not be updated! 
            
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 1, tsGoodsReceipt = 2025/05/02
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
		  And CHASC input has: sepCrit01 = "@#1"
		  And CHASC is called
	Then WEBSERVICE fails: error = "BWM-0005"
	#Clean-Up
	Then delete quantum "Qu"
	

	
	###########################- 18 -###################################
	Scenario: IM.013-001-18: the moved quantity-AVAILABLE is greater than the available quantity of the quantum 
	                          The Error Code "IM-0036":Booking quantity {0} is greater than available quantity {1}!
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with qtyType = "AVAILABLE" and qtyMoved = 100000.00
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0036"
	#Clean-Up
	Then delete quantum "Qu"
	
###########################- 19 -###################################
	Scenario: IM.013-001-19: the moved quantity-RESERVED is greater than the available quantity of the quantum 
	                           The Error Code "IM_0037":Booking quantity {0} is greater than reserved quantity {1}!
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with qtyType = "RESERVED" and qtyMoved = 100000.00
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0037"
	#Clean-Up
	Then delete quantum "Qu"
	
	
	###########################- 20 -###################################
	
	Scenario Outline: IM.013-001-20: Invalid Batch Input
	InventoryChascInput is filled correctly, but a batch is entered for an article without batch management → IM_0040
  The Error Code "IM_0040":Article {0}/{1} does not have batch management, do not enter a batch for transaction!
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article <article> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
      And CHASC input has: batch = <batch>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	
	Examples:
	|article |batch   |exception-code|
	|"WT-XP3"|"456789"|"IM-0040"     |
	|"WL-BG2"|"456789"|"IM-0040"     |
	|"V5-I68"|"456789"|"IM-0040"     |
 
 
 	###########################- 21 -###################################
	Scenario Outline: IM.013-001-21: Invalid Batch Input
	InventoryChascInput is filled correctly, but no batch is entered for an article with batch management
  The Error Code "IM_0015":Article {0}/{1} is configured with lot management, but lot is empty!
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article <article> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And create batch "852753C" for idArticle = <article> saved as "Batch[0]" with tsBbd null
      And BBD is 2025/01/01 and batch is "Batch[0]"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
 When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK"
      And CHASC input has: batch = <batch>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	Then delete batch "Batch[0]" of article <article>
	
	Examples:
	|article  |batch|exception-code|
	|"WR-211E"|null |"IM-0015"     |
	|"DC-270" |null |"IM-0015"     |
	
	
	
###########################- 22 -###################################

	Scenario Outline: IM.013-001-22: Invalid Artvar Input
	
1.InventoryChascInput is filled correctly, but no artvar is entered for an article with artvar management → IM_0816
  The Error Code "IM_0816":The article variant has to be filled with a valid value!
2.InventoryChascInput is filled correctly, but an invalid artvar is entered → IM_0816
  The Error Code "IM_0816":The article variant has to be filled with a valid value!
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article <article> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
 When CHASC is used to change quantum = "Qu" with stock type = "AV" and lock type = "MALOCK" 
      And CHASC input has: artvar = <artvar>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|article |artvar|exception-code|
	|"WT-XP3"|null  |"IM-0816"     |
	|"WL-BG2"|null  |"IM-0816"     |
	|"V5-I68"|null  |"IM-0816"     |
	|"WT-XP3"|"3"   |"IM-0816"     |
  |"WT-XP3"|"XDE#"|"IM-0816"     |

		
###########################- 23 -###################################
	
	Scenario Outline: IM.013-001-23: the quantity is a decimal number and the article only allows integers → IM_0079
                    The Error Code "IM_0079":The Unit {0} is not applicable for decimal values.
                    
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article <article> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum = "Qu" with qtyType = "AVAILABLE" and qtyMoved = 0.2
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|article |exception-code|
	|"WT-XP3"|"IM-0079"     |
	|"WL-BG2"|"IM-0079"     |


 
  
	
