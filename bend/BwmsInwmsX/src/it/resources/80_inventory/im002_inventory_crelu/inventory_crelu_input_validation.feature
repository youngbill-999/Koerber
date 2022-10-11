#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @crelu @defaultdatabased
Feature: IM.002-001: inventory/transaction/crelu - Inventory CRELU input validation
 
  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

      
Scenario Outline: IM.002-001-0001 - 0002: CRELU fails if reference type and reference ID do not match.
 	If no reference type, but reference IDs are set, the error "" is thrown.
 	If a reference type, but no reference IDs are set, the error "" is thrown.
 	BWM-0008: Combination reference type and id not correctly filled: if type is filled at least one id must be filled, too.s
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is "EURO"
    And the reasons are "Test CRELU 1"-"Test CRELU 2"
    And the reference type is <typ-ref> with id <id-ref-1>-<id-ref-2>
 		When CRELU is called
 	# IllegalArgumentException: TypRef / IdRef not completely filled
 	Then WEBSERVICE fails: error = "BWM-0008"
 	    Examples: 
      | typ-ref  | id-ref-1    | id-ref-2|
      | "EURO"   |  ""  	   | ""      |
      | ""  	 | "RL1"	   |  "12345"|

Scenario: IM.002-001-0003: CRELU fails, if no suitable situation (IM010) can be determined.
 	IM-0032: No situation can be determined by parameters: Process class {}, Process type {}, Process step {}, Client {}, Key {}
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the situation parameters are "DIALOG", "TEST", "*"
    And the load unit type is "EURO"
    And the reasons are "Test CRELU 1"-"Test CRELU 2"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0032"

Scenario: IM.002-001-0004: CRELU fails, if source area is missing.
	IM-0800: The source storage area has to be filled!
 	Given a load unit from storage location ""-"" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0800"
 	
Scenario: IM.002-001-0005: CRELU fails, if source location is missing.
	IM-0801: The source storage location has to be filled!
 	Given a load unit from storage location "QUELLE-LAG"-"" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0801"
 	
Scenario: IM.002-001-0006: CRELU fails, if target area is missing.
	IM-0802: The target storage area has to be filled!
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location ""-"" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0802"
 	
Scenario: IM.002-001-0007: CRELU fails, if target location is missing.
	IM-0803: The target storage location has to be filled!
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0803"

Scenario: IM.002-001-0008: CRELU fails, if load unit ID already exists
	IM-0003: Load unit already exists, creation not possible!
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit ID is "029012445678"
 		When CRELU is called
 		And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 		And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit ID is "029012445678"
    	And CRELU is called
 	Then WEBSERVICE fails: error = "IM-0003"

@virtualizeEuro
Scenario: IM.002-001-0009: CRELU fails, if load unit type is virtual
	IM-0025: LU Type {0} is configured as "virtual", creation of a load unit is not possible!
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0025"
 	
@deactivateEuro
Scenario: IM.002-001-0010: CRELU fails, if load unit type is inactive
	IM-0038: LU Type {0} is configured as "not active", creation of a load unit is not possible!
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0038"
 	