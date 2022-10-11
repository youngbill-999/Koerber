#Author: skaya@inconso.de
#Keywords Summary :
@inventory @relqu @defaultdatabased

Feature: IM.004-002: inventory/transaction/relqu - Inventory RELQU Occupation Management

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario: IM.004-002-0001: RELQU on target location diffrent to Source location
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And the quantum "Qu" has to be booked to location "H01-FACH"-"107-2-008-06"
 			And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
 			And location "H01-FACH"-"107-2-008-06" is occupied
 			And verify that the remaining weight of location "H01-FACH"-"107-2-008-06" is 44600.00
 		#Clean-up
 		Then delete quantum "Qu"
 		
 			
 	Scenario: IM.004-002-0002: RELQU on target load unit diffrent to Source load unit
 		Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
 			And the load unit type is "LBOX1"
    	And the reasons are "Test RELQU 1"-"Test RELQU 2"
 			And CRELU is called
 			And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1.000 pieces of article "40067222" has to be created
 			And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
 			And the load unit "Lu" has to be booked to target location "H01-FACH"-"107-2-008-05" with transaction type RELLU
 			And RELLU is called
 			And RELLU was successful; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1.000 pieces of article "40067005" has to be created
 			And the target location is "H01-KLAER"-"K-101"
 			And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 			And CREQU is called
 			And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
 			And location "H01-FACH"-"107-2-008-05" is occupied
 			And verify that the weight of the load unit "Lu" is 1400.00
 			#Clean-up
 		  Then delete quantum "Qu1"
 		  Then delete quantum "Qu2"
