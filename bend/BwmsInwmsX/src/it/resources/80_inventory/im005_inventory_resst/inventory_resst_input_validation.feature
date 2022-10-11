#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @resst @defaultdatabased

Feature: IM.005-001: inventory/transaction/resst - Inventory RESST Input Validation

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


 Scenario Outline: IM.005-001-0001: RESST fails if reference type and reference ID do not match.
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
      

      
 Scenario: IM.005-001-0002: RESST fails, if no suitable situation (IM010) can be determined
 	IM-0032: No situation can be determined by parameters: process class {0}, process type {1}, process step {2}, client {3}, key {4}
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-KLAER"-"K-101"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And CREQU is called
   	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
   	And 8.0 "AVAILABLE" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
   	And the situation parameters for RESST are: creQu = key:Qu, clProcess = "DIALOG", typProcess = "TEST", stepProcess = "*"
 	When RESST is called	
 	Then WEBSERVICE fails: error = "IM-0032"
 	
 	
 Scenario: IM.005-001-0003: RESST fails, if quantity type is empty.
 	IM-0804: The quantity type has to be filled!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-KLAER"-"K-101"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And CREQU is called
   	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
 	Given 8.0 "" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
 	When RESST is called
 	Then WEBSERVICE fails: error = "IM-0804"
 	

 Scenario: IM.005-001-0004: RESST fails, if quantity is zero.
 	IM-0810: The quantity must be greater than 0!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-KLAER"-"K-101"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And CREQU is called
   	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
 	Given 0.0 "AVAILABLE" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
 	When RESST is called
 	Then WEBSERVICE fails: error = "IM-0810"
 	
 	
 Scenario: IM.005-001-0005: RESST fails, if quantum ID is empty.
 	IM-0806: The quantum Id has to be filled!
 	Given 8.0 "AVAILABLE" pieces with empty quantum ID and reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved 
 	When RESST is called
 	Then WEBSERVICE fails: error = "IM-0806"
 	
 	
 Scenario: IM.005-001-0006: RESST fails, if quantum ID does not match.
 	IM-0019: Quantum {0}/{1} not found!
 	Given 8.0 "AVAILABLE" pieces with unknown quantum ID and reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
 	When RESST is called
 	Then WEBSERVICE fails: error = "IM-0019"