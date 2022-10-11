#Author: skaya@inconso.de
#Keywords Summary :
@inventory @stalu @defaultdatabased
Feature: IM.006-001: inventory/transaction/stalu - Inventory STALU Input Validation

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario Outline: IM.006-001-0001: STALU fails, if reference type and reference ID do not match.
  If no reference type, but reference IDs are set, the error "BWM-0008" is thrown.
 	If a reference type, but no reference IDs are set, the error "BWM-0008" is thrown.
 	BWM-0008: Combination reference type and id not correctly filled: if type is filled at least one id must be filled, too.
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 40.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    And the quantum "1" has to be booked to target load unit "2"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "2" has to be stacked on the load unit "1"
    And the STALU reference type is <typ-ref> with id <id-ref-1>-<id-ref-2>
    And STALU is called
		Then WEBSERVICE fails: error = "BWM-0008"
		
    Examples: 
      | typ-ref  | id-ref-1  | id-ref-2 |
      | "EURO"   |  ""  	 	 | ""       |
      | ""  	   | "RL1"  	 |  "12345" |


  Scenario: IM.006-001-0002: STALU fails, if no suitable situation (IM010) can be determined
  IM-0032: No situation can be determined by parameters: process class {0}, process type {1}, process step {2}, client {3}, key {4}
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 40.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    And the quantum "1" has to be booked to target load unit "2"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "2" has to be stacked on the load unit "1" with: clProcess = "DIALOG", typProcess = "TEST", stepProcess = "*"
    And STALU is called
		Then WEBSERVICE fails: error = "IM-0032"
		
		
    Scenario: IM.006-001-0003: STALU fails, if load unit ID is empty.
    IM-0815: The source LU has to be filled!
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    Given the input for STALU has to be prepared with target load unit "1" and without source load unit ID
    When STALU is called
    Then WEBSERVICE fails: error = "IM-0815"
	
	
    Scenario: IM.006-001-0004: STALU fails, if load unit ID is not found.
    IM-0018: Load unit {0}/{1} not found!
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    Given the input for STALU has to be prepared with target load unit "1" and an unknown source load unit ID
    When STALU is called
    Then WEBSERVICE fails: error = "IM-0018"
	
	
    Scenario: IM.006-001-0005: STALU fails, if target location and target load unit are not filled
    IM-0802: The target storage area has to be filled!
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
    Given the input for STALU has to be prepared with source load unit "Lu" and without a target storage area
    When STALU is called
    Then WEBSERVICE fails: error = "IM-0802"
	
	
    Scenario: IM.006-001-0006: STALU fails, if target location and target load unit are filled
    IM-0046: When a target LU is entered the fiel 'Target Location' must be empty!
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    Given the load unit "1" has to be stacked on the load unit "1" with target location "H01-WE"-"W-101"
    When STALU is called
    Then WEBSERVICE fails: error = "IM-0046"
	
	
	Scenario: IM.006-001-0007: STALU fails, if target load unit ID is not found
	IM-0018: Load unit {0}/{1} not found!
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
  And the load unit type is "EURO"
  When CRELU is called
  Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
  Given the input for STALU has to be prepared with source load unit "Lu" and an unknown target load unit ID
  When STALU is called
  Then WEBSERVICE fails: error = "IM-0018"
	
	
	Scenario: IM.006-001-0008: STALU fails, if target location is not found
	IM-0005: Storage area with value {0}/{1} does not exist
		Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
  	Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
		And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And the load unit "2" has to be stacked on the load unit "1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"
		And the input for STALU has to be prepared with target load unit "2" and an unknown target location
		When STALU is called
		Then WEBSERVICE fails: error = "IM-0005"
		
	
	Scenario: IM.006-001-0009: STALU fails, if source load unit is in transit
	IM-0027: The source load unit {0} must not be in transit!
		Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
		And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
		And the load unit "2" has to be relocated to "H01-KLAER"-"K-101"
		And verify that the load unit "2" is in transit
    And the load unit "2" has to be stacked on the load unit "1"
    When STALU is called
		Then WEBSERVICE fails: error = "IM-0027"
	
	
	Scenario: IM.006-001-0010: STALU fails, if target load unit is in transit
	IM-0023: The target load unit {0} must not be in transit!
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And the load unit "1" has to be relocated to "H01-KLAER"-"K-101"
    And verify that the load unit "1" is in transit
    And the load unit "2" has to be stacked on the load unit "1"
    When STALU is called
		Then WEBSERVICE fails: error = "IM-0023"
		
		
		Scenario: IM.006-001-0011: STALU fails, when trying to stack a two-level load unit on another two-level load unit
		IM-0048: Level of target LU {0}/{1} is neither 1 or 2, cannot be used as stacking target!
		Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 40.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    And the quantum "1" has to be booked to target load unit "2"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "2" has to be stacked on the load unit "1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "3"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 60.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "2"; transaction saved as "Transaction"
    And the quantum "2" has to be booked to target load unit "3"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "4"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.000 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 4"-"Test CREQU 5"
    And CREQU is called
    And CREQU was successful, saved as "3"; transaction saved as "Transaction"
    And the quantum "3" has to be booked to target load unit "4"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "4" has to be stacked on the load unit "3"
    When STALU is called
    Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
    And the load unit "3" has to be stacked on the load unit "2"
    When STALU is called
    Then WEBSERVICE fails: error = "IM-0048"
    
    
    Scenario: IM.006-001-0012: STALU fails, if the possible height is reached
    IM-0048: Level of target LU {0}/{1} is neither 1 or 2, cannot be used as stacking target!
    #Load unit 1
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    #Load unit 2
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 30.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    And the quantum "1" has to be booked to target load unit "2"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "2" has to be stacked on the load unit "1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"
    #Load unit 3
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "3"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.000 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 4"-"Test CREQU 5"
    And CREQU is called
    And CREQU was successful, saved as "3"; transaction saved as "Transaction"
    And the quantum "3" has to be booked to target load unit "3"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "3" has to be stacked on the load unit "2"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"
    #Load unit 4
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "4"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.000 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 4"-"Test CREQU 5"
    And CREQU is called
    And CREQU was successful, saved as "4"; transaction saved as "Transaction"
    And the quantum "4" has to be booked to target load unit "4"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "4" has to be stacked on the load unit "3"
    When STALU is called
    Then WEBSERVICE fails: error = "IM-0048"
    
    
    Scenario: IM.006-001-0013: STALU fails, if the load unit to be stacked off is in transit
    IM-0027: The source load unit {0} must not be in transit!
    #Load unit 1
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 30.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    And the quantum "1" has to be booked to target load unit "1"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    #Load unit 2
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.000 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 4"-"Test CREQU 5"
    And CREQU is called
    And CREQU was successful, saved as "2"; transaction saved as "Transaction"
    And the quantum "2" has to be booked to target load unit "2"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"   
    And the load unit "2" has to be stacked on the load unit "1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"
		And the load unit "1" has to be relocated to "H01-KLAER"-"K-101"
		And verify that the load unit "1" is in transit
		And the load unit "2" has to be stacked to location "H01-WE"-"W-102"
    When STALU is called
		Then WEBSERVICE fails: error = "IM-0027"
		
		
		Scenario: IM.006-001-0014: STALU fails, if the load unit to be stacked off is on level 1
		IM-0049: Level of source LU {0}/{1} is 1, cannot be used as unstacking source!
		Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    And the load unit "1" has to be stacked to location "H01-WE"-"W-102"
    When STALU is called
		Then WEBSERVICE fails: error = "IM-0049"
		
		
		Scenario: IM.006-001-0015: STALU fails, if the target area for un-stacking is drain or source
		IM-0047: Target area {0}/{1} for un-stacking must not be a drain/source!
		#Load unit 1
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 15.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    And the quantum "1" has to be booked to target load unit "1"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    #Load unit 2
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.000 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 4"-"Test CREQU 5"
    And CREQU is called
    And CREQU was successful, saved as "2"; transaction saved as "Transaction"
    And the quantum "2" has to be booked to target load unit "2"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"   
    And the load unit "2" has to be stacked on the load unit "1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"
    And the load unit "2" has to be stacked to location "SENKE-LAG"-"S-001"
    When STALU is called
		Then WEBSERVICE fails: error = "IM-0047"