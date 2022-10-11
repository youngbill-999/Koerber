#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @crelu @defaultdatabased
Feature: IM.002-004: inventory/transaction/crelu - Inventory CRELU Occupation Management
Including respecting 'load unit type' <-> 'storage location type' relations.

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


Scenario: IM.002-004-0001: CRELU in location without occupation management leaves storage location empty
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-PACK"-"P-101" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 	And storage location "H01-PACK"-"P-101" is 0.0 percent occupied
 	#Clean-Up
  Then delete load unit "Lu"
 
 Scenario: IM.002-004-0002: CRELU succeeds, if storage type needs no load-type-storage-assocation and there is none.
	"H01-PACK"-"P-102" has location type B1: Blockplatz Typ ohne Belegtverwaltung.
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-PACK"-"P-102" has to be created
    And the load unit type is "INDU"
    And the load unit ID is "012012345680"
 		When CRELU is called
 	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 	#Clean-Up
  Then delete load unit "Lu"
 	
@allowEmptyLuForLocationAreaH01BL
Scenario: IM.002-004-0003: CRELU fails, if storage type needs load-type-storage-assocation and there is none.
  "H01-BL"-"101" has location type B2: Blockplatz Typ 2, max 10 LEen
  OM-0005: LU Type (RL1/LBOX1) - Location Type Assignment (for B2) not found!
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-BL"-"101" has to be created
    And the load unit type is "LBOX1"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "OM-0005"
 	
Scenario: IM.002-004-0004: CRELU in location without occupation management leaves storage location empty
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-PACK"-"P-101" has to be created
    And the load unit type is "EURO"
 		When CRELU is called
 	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 	And storage location "H01-PACK"-"P-101" is 0.0 percent occupied
 	#Clean-Up
  Then delete load unit "Lu"
 
@allowEmptyLuForLocationAreaH01BL
Scenario: IM.002-004-0005: CRELU in location with remaining capacity type CNTLU: 10%, 20%, 100%
  	Given storage location "H01-BL"-"101" is empty
  	And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-BL"-"101" has to be created
    And the load unit type is "EURO"
 		  When CRELU is called
 	    Then CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
 	    And storage location "H01-BL"-"101" is 10.0 percent occupied
 	    And storage location "H01-BL"-"101" has remaining capacity 9.0
 	  #next load unit on location
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-BL"-"101" has to be created
    And the load unit type is "EURO"
 		  When CRELU is called
    	Then CRELU was successful, saved as "Lu2"; transaction saved as "Transaction"
 	    And storage location "H01-BL"-"101" is 20.0 percent occupied
 	    And storage location "H01-BL"-"101" has remaining capacity 8.0
    #next load units on location
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-BL"-"101" has to be created
    And the load unit type is "EURO"
 		#3.
 		  When CRELU is called
 		  Then CRELU was successful, saved as "Lu3"; transaction saved as "Transaction"
 		#4. 
 		  And CRELU is called
 		  Then CRELU was successful, saved as "Lu4"; transaction saved as "Transaction"
 		#5. 
 		  And CRELU is called
 		  Then CRELU was successful, saved as "Lu5"; transaction saved as "Transaction"
 		#6.
 		  And CRELU is called
 		  Then CRELU was successful, saved as "Lu6"; transaction saved as "Transaction"
 		#7.
 		  And CRELU is called
 		  Then CRELU was successful, saved as "Lu7"; transaction saved as "Transaction"
 		#8.
 		  And CRELU is called
 		  Then CRELU was successful, saved as "Lu8"; transaction saved as "Transaction"
 		#9.
 		  And CRELU is called
 		  Then CRELU was successful, saved as "Lu9"; transaction saved as "Transaction"
 		#10.
 		  And CRELU is called
 	    Then CRELU was successful, saved as "Lu10"; transaction saved as "Transaction"
 	    And storage location "H01-BL"-"101" is 100.0 percent occupied
 	    And storage location "H01-BL"-"101" has remaining capacity 0.0
 	
    # CRELU in location with remaining capacity type CNTLU: Too much!
    # OM-0003: Maximum capacity of storage location {0}/{1}/{2} exceeded ({3} > {4})!
  	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-BL"-"101" has to be created
    And the load unit type is "EURO"
 		#11.
 		  When CRELU is called
 	    Then WEBSERVICE fails: error = "OM-0003"
 	  #Clean-Up
 	    Then delete load unit "Lu1"
 	    Then delete load unit "Lu2"
 	    Then delete load unit "Lu3"
 	    Then delete load unit "Lu4"
 	    Then delete load unit "Lu5"
 	    Then delete load unit "Lu6"
 	    Then delete load unit "Lu7"
 	    Then delete load unit "Lu8"
 	    Then delete load unit "Lu9"
 	    Then delete load unit "Lu10"