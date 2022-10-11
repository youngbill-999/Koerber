#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@inventory @chasc @input @defaultdatabased


Feature: IM.013-001: inventory/transaction/chasc - Inventory CHASC input validation
         This feature file tests the input validation of the CHASC booking (Change Separation Criteria)
         Different flawed inputs are entered and the resulting error message is verified.
         
Background: 	
	Given set global: idSite = "RL1", idClient = "RK2"


########################- Failure -##################################
###########################- 1 -#####################################
	Scenario: IM.013-001-0001: CHASC fails, if the idSite is empty.
						BEND-0005: Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
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
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
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
	
	###########################- 3 -#####################################
	Scenario: IM.013-001-0003: CHASC fails, if the typProcess is empty.
						BEND-0005: Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: typProcess = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	

###########################- 4 -#####################################
	Scenario: IM.013-001-0004: CHASC fails, if the stepProcess is empty.
						BEND-0005: Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: stepProcess = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
	###########################- 5 -#####################################
	Scenario: IM.013-001-0005: CHASC fails, if the key is empty.
						BEND-0005: Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: key = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
	
	###########################- 6 -#####################################
	Scenario: IM.013-001-0006: CHASC fails, if the idUser is empty.
						BEND-0005: Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: idUser = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
 ###########################- 7 -#####################################
	Scenario Outline: IM.013-001-0007: CHASC fails, if the  references are filled inconsistently
						when idRef null and any of the idRef1 to idRef6 is filled → BWM_0008
            when idRef = GI_ORDER and idRef1 = null (but other idRef filled)→ BWM_0008
            when idRef = ABC (idRef1-6 irrelevant) → BWM_0008
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has References: typRef = <typRef>, idRef1 = <idRef1>, idRef2 = <idRef2>, idRef3 = <idRef3>, idRef4 = <idRef4>, idRef5 = <idRef5>, idRef6 = <idRef6>
		  And CHASC is called
	Then WEBSERVICE fails: error = "BWM-0008"
	#Clean-Up
	Then delete quantum "Qu"	
	
	Examples:
	|typRef|idRef1|idRef2|idRef3|idRef4|idRef5|idRef6|
	|null|"test"|null|null|null|null|null|
	|null|null|"test"|null|null|null|null|
	|null|null|null|"test"|null|null|null|
	|null|null|null|null|"test"|null|null|
	|null|null|null|null|null|"test"|null|
	|null|null|null|null|null|null|"test"|
	|"GI_ORDER"|null|"test"|"test"|"test"|"test"|"test"|
	|"ABC"|null|null|null|null|null|null|
	
	
	###########################- 8 -#####################################
	Scenario: IM.013-001-0008: CHASC fails, if the class-type-step-process combination is invalid
						IM-0032: No situation can be determined by parameters: transaction type {0}, process class {1}, process type {2}, process step {3}, client {4}, key {5}
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: typProcess = "ABC"
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0032"
	#Clean-Up
	Then delete quantum "Qu"	
	
	###########################- 9 -#####################################
	Scenario: IM.013-001-0009: CHASC fails, if idQuantum is empty 
	             BEND-0005: Field {0} must not be null
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: idQuantum = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "BEND-0005"
	#Clean-Up
	Then delete quantum "Qu"	
	
	
	
	###########################- 10 -#####################################
	Scenario: IM.013-001-0010: CHASC fails, if qtyType is null
	              IM_0804
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: qtyType = null
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0804"
	#Clean-Up
	Then delete quantum "Qu"	
	
	###########################- 11 -#####################################
	Scenario Outline: IM.013-001-0011: CHASC fails, if qtyMoved  is -1 or 0
	              IM_0810
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: qtyMoved = <qtyMoved>
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0810"
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|qtyMoved|
	|-1|
	|0|
	
	###########################- 12 -#####################################
	Scenario Outline: IM.013-001-0012: CHASC fails, if typStock is null or invalid(e.g. "TST")
	             IM_0814->null ################issue
	             BWM_0002->"TST"
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: typStock = <typStock>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|typStock|exception-code|
	|null|"IM-0814"|
	|"TST"|"BWM-0002"|
	
	###########################- 13 -####################################
	Scenario Outline: IM.013-001-0013: CHASC fails, if typLock is null or invalid(e.g. "TST")
	             IM_0813->null ################issue
	             BWM_0002->"TST"
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: typLock = <typLock>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|typLock|exception-code|
	|null|"IM-0813"|
	|"TST"|"BWM-0002"|
	
	###########################- 14 -####################################
	Scenario Outline: IM.013-001-0014: CHASC fails, if statQualityControl is null or invalid(e.g. "XX")
	             IM_0811->null ################issue
	             BWM_0002->"XX"
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: statQualityControl = <statQualityControl>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|statQualityControl|exception-code|
	|null|"IM-0811"|
	|"XX"|"BWM-0002"|
	
	###########################- 15 -####################################
	Scenario Outline: IM.013-001-0015: CHASC fails, if statCustoms is null or invalid(e.g. "XX")
	             IM_0812->null ################issue
	             BWM_0002->"XX"
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: statCustoms = <statCustoms>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|statCustoms|exception-code|
	|null|"IM-0812"|
	|"XX"|"BWM-0002"|
	
	
	###########################- 16 -###################################
	Scenario Outline: IM.013-001-0016: CHASC fails, if special stock type and ID combination are not allowed
	             type is not null, ID is null → IM_0013
               type is invalid, for example "XX", ID is not null → BWM_0002
               type is null, ID is not null → IM_0013
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK"
		  And CHASC input has: specialTypStock = <specialTypStock> and idSpecialTypStock = <idSpecialTypStock>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|specialTypStock|idSpecialTypStock|exception-code|
	|"CUST"|null|"IM-0013"|
	|"SUPP"|null|"IM-0013"|
	|"XX"|"456789"|"BWM-0002"|
	|null|"456789"|"IM-0013"|
	
	###########################- 17 -###################################
	##See inventory_chasc_input_validation_SepCriteria.feature
	##because here need to switch to Client PK1 who's SAPP is required
	
	
	###########################- 18 -###################################
		
	Scenario: IM.013-001-0018: the moved quantity-AVAILABLE is greater than the available quantity of the quantum 
	                            → IM_0036
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with qtyType ="AVAILABLE" and qtyMoved = 100000
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0036"
	#Clean-Up
	Then delete quantum "Qu"
	
###########################- 19 -###################################
	Scenario: IM.013-001-0019: the moved quantity-RESERVED is greater than the available quantity of the quantum 
	                            → IM_0036
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with qtyType ="RESERVED" and qtyMoved = 101
		  And CHASC is called
	Then WEBSERVICE fails: error = "IM-0037"
	#Clean-Up
	Then delete quantum "Qu"
	
	
	###########################- 20 -###################################
	
	Scenario Outline: IM.013-001-0020: Invalid Batch Input
	
InventoryChascInput is filled correctly, but a batch is entered for an article without batch management → IM_0040

              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article <artcle> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK" 
      And CHASC input has: batch = <batch>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|artcle|batch|exception-code|
	|"WT-XP3"|"456789"|"IM-0040"|
	|"WL-BG2"|"456789"|"IM-0040"|
	|"V5-I68"|"456789"|"IM-0040"|
 
 
 	###########################- 21 -###################################
  
	Scenario Outline: IM.013-001-0021: Invalid Batch Input
	
InventoryChascInput is filled correctly, but no batch is entered for an article with batch management → IM_0015

              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article <artcle> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And create batch "789456" for idArticle = <artcle> saved as "Batch[0]" with tsBbd null
      And BBD is 2025/01/01 and batch is "Batch[0]"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK" 
      And CHASC input has: batch = <batch>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|artcle|batch|exception-code|
	|"WR-211E"|null|"IM-0015"|
	|"DC-270"|null|"IM-0015"|
	
	
	
###########################- 22 -###################################
	
	Scenario Outline: IM.013-001-0022: Invalid Artvar Input
	
InventoryChascInput is filled correctly, but no artvar is entered for an article with artvar management → IM_0816
InventoryChascInput is filled correctly, but an invalid artvar is entered → IM_0816
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article <artcle> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with stock type ="AV" and lock type ="MALOCK" 
      And CHASC input has: artvar = <artvar>
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|artcle|artvar|exception-code|
	|"WT-XP3"|null|"IM-0816"|
	|"WL-BG2"|null|"IM-0816"|
	|"V5-I68"|null|"IM-0816"|
#	|"WT-XP3"|"0"|"IM-0816"|
#|"WL-BG2"|"0"|"IM-0816"|
#	|"V5-I68"|"0"|"IM-0816"|
 
  

		
###########################- 23 -###################################
	@Test
	Scenario Outline: IM.013-001-0023: the quantity is a decimal number and the article only allows integers → IM_0079
              
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article <artcle> has to be created
		  And the target location is "H01-KLAER"-"K-101"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		  
  When CHASC is used to change quantum ="Qu" with qtyType = "AVAILABLE" and qtyMoved = 0.2
		  And CHASC is called
	Then WEBSERVICE fails: error = <exception-code>
	#Clean-Up
	Then delete quantum "Qu"
	
	Examples:
	|artcle|exception-code|
	|"WT-XP3"|"IM-0079"|
	|"WL-BG2"|"IM-0079"|


 
  
	
