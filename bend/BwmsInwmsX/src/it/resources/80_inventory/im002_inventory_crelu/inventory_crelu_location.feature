#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @crelu @defaultdatabased
Feature: IM.002-002: inventory/transaction/crelu - Inventory CRELU with location configuration


  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

 Scenario: IM.002-002-0001: CRELU fails, if source location is not configured as "SOURCE".
 	IM-0061: The type of the storage area RL1/H01-KLAER is not configured as SOURCE!!	
 	Given a load unit from storage location "H01-KLAER"-"K-102" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0061"
 	
 Scenario: IM.002-002-0002: CRELU fails, if target location has no load unit management.
 	IM-0008: Target storage area {0}/{1} should be configured with load unit management!
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "SENKE-LAG"-"S-001" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0008"
 	
 Scenario: IM.002-002-0003: CRELU fails, if target location has no empty load unit management.
 	IM-0009: Target storage area {0}/{1} should be configured with empty load unit management!
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-HRL"-"101-2-001-01" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0009"
