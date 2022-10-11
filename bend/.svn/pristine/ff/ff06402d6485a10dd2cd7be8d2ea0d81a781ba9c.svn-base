#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @crequ @defaultdatabased
Feature:  IM.003-004: inventory/transaction/crequ - Inventory CREQU Occupation Management

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


Scenario:IM.003-004-0001: CREQU with 1440 college blocks (est. 80kg) exceeds maximal weight of location (50kg)
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 1440.0 pieces of article "40067005" has to be created
	#Max weight is 50kg
   	And the target location is "H01-FACH"-"107-2-001-04"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And CREQU is called
 	Then WEBSERVICE fails: error = "OM-0009"
 	
Scenario: IM.003-004-0002: CREQU on location with remaining capacity type NONE leaves location empty
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
   	And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And CREQU is called
 	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	Then location "H01-KLAER"-"K-101" is empty
 	#Clean-Up
  Then delete quantum "Qu"
 
@h01klear_is_occupied
Scenario: IM.003-004-0003: CREQU on location with remaining capacity type NONE leaves location empty
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 1440.0 pieces of article "40067005" has to be created
   	And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And CREQU is called
 	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	Then location "H01-KLAER"-"K-101" is empty
 	#Clean-Up
  Then delete quantum "Qu"
 		
Scenario: IM.003-004-0004: CREQU on location with remaining capacity type CNTLU is not allowed
	OM-0002: One or more quanta were found on location RL1/H01-BL/101 without load units, relocation not allowed!
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
   	And the target location is "H01-BL"-"101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And CREQU is called
 	Then WEBSERVICE fails: error = "OM-0002"
 
 Scenario: IM.003-004-0005: CREQU on location with remaining capacity type PCTLU is not allowed
   OM-0002: One or more quanta were found on location RL1/H04-AKL/401-1-001-01-1 without load units, relocation not allowed!
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
   	And the target location is "H04-AKL"-"401-1-001-01-1"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And CREQU is called
 	Then WEBSERVICE fails: error = "OM-0002"
 	
Scenario: IM.003-004-0006: CREQU on location with remaining capacity type PCTLQ changes status but no percentage
	IM-XXXX: 
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"107-2-002-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And CREQU is called
 	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	Then location "H01-FACH"-"107-2-002-02" is occupied
 	Then location "H01-FACH"-"107-2-002-02" has occupied percentage 0.0
 	   #Clean-Up
  Then delete quantum "Qu"

@allowEmptyLuForLocationAreaH01FACH
Scenario: IM.003-004-0007: CREQU on location with remaining capacity type PCTLQ with LU changes nothing
	IM-XXXX:   	
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-FACH"-"107-2-002-04" has to be created
    And the load unit type is "LBOX1"
 	And CRELU is called
 	And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 	And location "H01-FACH"-"107-2-002-04" is occupied
 	And location "H01-FACH"-"107-2-002-04" has occupied percentage 25.0
	And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"107-2-002-04"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And CREQU is called
 	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And location "H01-FACH"-"107-2-002-04" is occupied
 	And location "H01-FACH"-"107-2-002-04" has occupied percentage 25.0
  #Clean-Up
  Then delete load unit "Lu"
  Then delete quantum "Qu"

@allowEmptyLuForLocationAreaH01FACH
Scenario: IM.003-004-0008: CREQU on location with remaining capacity type PCTLQ with LU changes nothing
	IM-XXXX:   	
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-FACH"-"107-2-002-05" has to be created
    And the load unit type is "LBOX1"
 	And CRELU is called
 	And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 	And location "H01-FACH"-"107-2-002-05" is occupied
 	And location "H01-FACH"-"107-2-002-05" has occupied percentage 25.0
	And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"107-2-002-05"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And CREQU is called
 	And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
 	And location "H01-FACH"-"107-2-002-05" is occupied
 	And location "H01-FACH"-"107-2-002-05" has occupied percentage 25.0
 	And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"107-2-002-05"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And CREQU is called
 	And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
 	And location "H01-FACH"-"107-2-002-05" is occupied
 	And location "H01-FACH"-"107-2-002-05" has occupied percentage 25.0
 	#Clean-Up
  Then delete load unit "Lu"
  Then delete quantum "Qu1"
  Then delete quantum "Qu2"
 	