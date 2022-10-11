#Author: skaya@inconso.de

@inventory @corst @defaultdatabased
Feature: IM.001-001: inventory/transaction/corst - Inventory CORST Input Validation
The Inventory CORST feature is a booking type offered by the inventory component. 
It allows the correction of stock of a given quantum
and takes care of possible side effects - for example the deletion of empty load units
and contains different plausibility checks concerning amounts to be altered or weight restrictions.

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

	
  Scenario: IM.001-001-0001: CORST to decreases available quantity fails, if booking quantity is higher than available quantity.
  	IM-0036: qty to decrease (8.0) is bigger than available qty (5.0)!
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.0 pieces of article "40067005" has to be created
  		And the target location is "H01-FACH"-"106-2-007-05"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
    	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    	And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 8.0 pieces with location "SENKE-LAG"-"S-001"
		When CORST is called
    Then WEBSERVICE fails: error = "IM-0036"


	Scenario: IM.001-001-0002: CORST to decreases reserved quantity fails, if booking quantity is higher than reserved quantity.
		IM-0037: qty to decrease (4.0) is bigger than reserved qty (7.0)!
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
  		And the target location is "H01-FACH"-"106-2-007-06"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
     	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
     	And 4.0 pieces of quantum "Qu" have to be reserved
     	And RESST is called
     	And RESST was successful; transaction saved as "Transaction"
    	And the "RESERVED" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 7.0 pieces with location "SENKE-LAG"-"S-001"
		When CORST is called
    Then WEBSERVICE fails: error = "IM-0037"
    
    
  Scenario: IM.001-001-0003: CORST to increases available quantity fails, if booking quantity exceeds the remaining capacity of location.
  	OM-0009: Max weight of storage location RL1/H01-FACH/106-2-008-04 exceeded!
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 80.0 pieces of article "40067005" has to be created
      And the target location is "H01-FACH"-"106-2-008-04"
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
      And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "INCREASE" by 20.0 pieces with location "QUELLE-LAG"-"Q-001"
     When CORST is called
     Then WEBSERVICE fails: error = "OM-0009"
    
  
  Scenario Outline: IM.001-001-0004 - 0007: CORST fails if reference type and reference ID do not match.
  	If no reference type, but reference IDs are set, the error "BWM-0008" is thrown.
 	If a reference type, but no reference IDs are set, the error "BWM-0008" is thrown.
 	BWM-0008: Combination reference type and id not correctly filled: if type is filled at least one id must be filled, too.
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		And the CREQU reference type is <typ-ref> with id <id-ref-1>-<id-ref-2>
   	When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0008"
 	    Examples: 
      | typ-ref  | id-ref-1  | id-ref-2 |
      | "EURO"   |  ""  	 	 | ""       |
      | ""  	   | "RL1"  	 |  "12345" |
    
    
  Scenario: IM.001-001-0008: CORST fails, if no suitable situation (IM010) can be determined.
  	IM-0032: No situation can be determined by parameters: process class DIALOG, process type TEST, process step *, client RK1, key *
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
      And the target location is "H01-FACH"-"106-2-008-05"
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
      And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 4.0 pieces with location "SENKE-LAG"-"S-001"
      And the situation parameters for CORST are "DIALOG", "TEST", "*"
     When CORST is called
     Then WEBSERVICE fails: error = "IM-0032"
    
    
  Scenario: IM.001-001-0009: CORST fails, if type of quantity is missing.
  	IM-0804: The quantity type has to be filled!
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
      And the target location is "H01-FACH"-"106-2-008-05"
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
      And the quantum "Qu" has to be changed without type of quantity and with correction type "INCREASE" by 20.0 pieces with location "QUELLE-LAG"-"Q-001"
     When CORST is called
     Then WEBSERVICE fails: error = "IM-0804"
    	
  Scenario: IM.001-001-0010: CORST fails, if correction type is missing.
  	IM-0807: The correction type has to be filled!
  	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
      And the target location is "H01-FACH"-"106-2-008-05"
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
      And the quantum "Qu" has to be changed with type of quantity "AVAILABLE" and without correction type by 20.0 pieces with location "QUELLE-LAG"-"Q-001"
     When CORST is called
     Then WEBSERVICE fails: error = "IM-0807"
      
    Scenario: IM.001-001-0011: CORST fails, if quantum ID does not exists
    IM-0019: Quantum RL1 / ABC not found!
  	Given the "AVAILABLE" quantity with a nonexistent quantum ID "ABCD" has to be changed with correction type "DECREASE" by 4.0 pieces with location "SENKE-LAG"-"S-001"
    When CORST is called
    Then WEBSERVICE fails: error = "IM-0019"
        
      
 	Scenario: IM.001-001-0012: CORST fails, if quantum ID is empty.
 		IM-0806: The quantum Id has to be filled!
    Given the "AVAILABLE" quantity with empty quantum ID has to be changed with correction type "DECREASE" by 4.0 pieces with location "SENKE-LAG"-"S-001"
    When CORST is called
    Then WEBSERVICE fails: error = "IM-0806"
    
    
  Scenario: IM.001-001-0013: CORST fails, if quantity is zero.
  	IM-0810: The quantity must be greater than 0!
  	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
      And the target location is "H01-FACH"-"106-2-008-05"
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
  	Given the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 0.0 pieces with location "SENKE-LAG"-"S-001"
	 When CORST is called
     Then WEBSERVICE fails: error = "IM-0810"
    
    
  Scenario: IM.001-001-0014: CORST with correction type INCREASE fails, if source storage area is missing.
  	IM-0800: The source storage area has to be filled!
  	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
      And the target location is "H01-FACH"-"106-2-008-05"
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
  	Given the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "INCREASE" by 4.0 pieces with location ""-""
    When CORST is called
    Then WEBSERVICE fails: error = "IM-0800"
    
    
  Scenario: IM.001-001-0015: CORST with correction type DECREASE fails, if target storage area is missing.
  	IM-0802: The target storage area has to be filled!
  	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
      And the target location is "H01-FACH"-"106-2-008-05"
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
  	Given the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 5.0 pieces with location ""-""
    When CORST is called
    Then WEBSERVICE fails: error = "IM-0802"
    
    
  Scenario: IM.001-001-0016:CORST fails, if the location is not a destination.
  	IM-0061: The type of the storage area RL1/H01-KLAER is not configured as DESTINATION!
  	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
      And the target location is "H01-FACH"-"106-2-008-05"
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
  	Given the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 4.0 pieces with location "H01-KLAER"-"K-101"
    When CORST is called
    Then WEBSERVICE fails: error = "IM-0061"
    

# Scenario is not applicable for current configuration. No target place fits. 
# Background: Rise of IM-0026 is stronger restricted now.

  #Scenario: CORST fails, if the location is quantum managed.
  #IM-0026: Consistence check violated: storage area H01-LEER is configured with load unit management - but without quantum management!
  	#Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
  	#And the target location is "H01-FACH"-"106-2-008-05"
    #And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    #And CREQU is called
    #And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
  	#Given the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 5.0 pieces with location "H01-LEER"-"L-101"
    #When CORST is called
    #Then WEBSERVICE fails: error = "IM-0026"
    
    