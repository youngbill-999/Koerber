#Author: skaya@inconso.de

@inventory @corst @defaultdatabased
Feature: IM.001-002: inventory/transaction/corst - Inventory CORST with load unit

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario: IM.001-002-0001: CORST on location with load unit and given quantum increases available quantity
   	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "EURO"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
 			And CRELU is called
  		And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 78.0 pieces of article "40067005" has to be created
  		And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
     	And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "INCREASE" by 34.0 pieces with location "QUELLE-LAG"-"Q-001"
 		When CORST is called
  	Then CORST was successful; transaction saved as "Transaction"
    	And transaction "Transaction" has: typLu1Tgt = "EURO"
    	And reload quantum "Qu"
    	And quantum "Qu" has available quantity 112.000
    	And verify that the weight of the load unit "Lu" is 88480.00
    #Clean-Up
    Then delete load unit "Lu"
    	
    	
  Scenario: IM.001-002-0002: CORST on location with load unit and given quantum increases reserved quantitiy
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "EURO"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
 			And CRELU is called
 			And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
    	And a quantum from storage location "QUELLE-LAG"-"Q-001" with 24.0 pieces of article "40067007" has to be created
  		And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 24.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
 			And RESST was successful; transaction saved as "Transaction"
 			And the "RESERVED" quantity of the quantum "Qu" has to be changed with correction type "INCREASE" by 15.0 pieces with location "QUELLE-LAG"-"Q-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
    	And transaction "Transaction" has: typQuantity = "RESERVED"
    	And reload quantum "Qu"
    	And quantum "Qu" has reserved quantity 39.000
    	And verify that the weight of the load unit "Lu" is 35449.00
    #Clean-Up
    Then delete load unit "Lu"
    	
    	
  Scenario: IM.001-002-0003: CORST on location with load unit and given quantum decreases available quantity
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "LBOX3"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
 			And CRELU is called
 			And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 150.0 pieces of article "40067024" has to be created
  		And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 20.0 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
    	And transaction "Transaction" has: typQuantity = "AVAILABLE"
    	And reload quantum "Qu"
    	And quantum "Qu" has available quantity 130.000
    	And verify that the weight of the load unit "Lu" is 8900.00
    #Clean-Up
    Then delete load unit "Lu"
    	
    	
  Scenario:  IM.001-002-0004: CORST on location with load unit and given quantum decreases reserved quantity
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "GBOX"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
 			And CRELU is called
 			And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 110.0 pieces of article "40067222" has to be created
  		And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 110.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
			And RESST was successful; transaction saved as "Transaction"
 			And the "RESERVED" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 21.0 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
    	And transaction "Transaction" has: typQuantity = "RESERVED"
    	And reload quantum "Qu"
    	And quantum "Qu" has reserved quantity 89.000
    	And verify that the weight of the load unit "Lu" is 96700.00
    #Clean-Up
    Then delete load unit "Lu"
    	
    	
  Scenario: IM.001-002-0005: CORST on location with load unit and given quantum decreases the rest of available quantity to zero
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "EURO"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
 			And CRELU is called
 			And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 231.0 pieces of article "40067005" has to be created
  		And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 111.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
			And RESST was successful; transaction saved as "Transaction"
			And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 120.0 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
    	And transaction "Transaction" has: typQuantity = "AVAILABLE"
    	And reload quantum "Qu"
    	And quantum "Qu" has reserved quantity 111.000
    	And verify that the weight of the load unit "Lu" is 87940.00
    #Clean-Up
    Then delete load unit "Lu"
    	
  Scenario: IM.001-002-0006: CORST on location with load unit and given quantum decreases the rest of reserved quantity to zero
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "EURO"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
 			And CRELU is called
 			And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 220.0 pieces of article "40067007" has to be created
  		And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 90.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
			And RESST was successful; transaction saved as "Transaction"
			And the "RESERVED" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 90.0 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
    	And transaction "Transaction" has: typQuantity = "RESERVED"
    	And reload quantum "Qu"
    	And quantum "Qu" has available quantity 130.000
    	And verify that the weight of the load unit "Lu" is 52830.00
    #Clean-Up
    Then delete load unit "Lu"
    	
  Scenario:  IM.001-002-0007:CORST on location with load unit and given quantum decreases all available quantity
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "EURO"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
 			And CRELU is called
 			And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 110.0 pieces of article "40067005" has to be created
  		And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 110.0 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
 			And transaction "Transaction" has: typQuantity = "AVAILABLE"
 		  And reload quantum "Qu"
 			And verify quantum "Qu" is deleted
 			And location H01-KLAER K-101 with the load unit "Lu" is empty
 			And verify that the weight of the load unit "Lu" is 28000.00
 		 #Clean-Up
    Then delete load unit "Lu"
 			
 			
 	Scenario: IM.001-002-0008: CORST on location with load unit and given quantum decreases all reserved quantity
 		Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "EURO"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
 			And CRELU is called
 			And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 147.0 pieces of article "40067007" has to be created
  		And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 147.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
			And RESST was successful; transaction saved as "Transaction"
 			And the "RESERVED" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 147.0 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
 			And transaction "Transaction" has: typQuantity = "RESERVED"
 		  And reload quantum "Qu"
 			And verify quantum "Qu" is deleted
 			And location H01-KLAER K-101 with the load unit "Lu" is empty
 			And verify that the weight of the load unit "Lu" is 28000.00
 		#Clean-Up
    Then delete load unit "Lu"
 			
 			