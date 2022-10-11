#Author: skaya@inconso.de
#Keywords Summary :
@inventory @relqu @defaultdatabased

Feature: IM.004-005: inventory/transaction/relqu - Inventory RELQU Target LU

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario:IM.004-005-0001: RELQU on empty target load unit
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And the third separation criterion is "1,0"
    	And CREQU is called
    	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    	And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "EURO"
    	And the reasons are "Test RELQU 1"-"Test RELQU 2"
    	And CRELU is called
    	And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
    	And the quantum "Qu" has to be booked to target load unit "Lu"
    	And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
    	And the target load unit is "EURO"
    	And the target location is "H02-KLAER"-"K-201"
    	And target load unit "Lu" is 0.0 percent occupied
    	And verify that the weight of the load unit "Lu" is 33400.00
    	And transaction "Transaction" has: typTransaction = "RELQU"
    	And transaction "Transaction" has: stat = "90"
    	And transaction "Transaction" has: situation = "IM400"
    	And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067005"
    	And transaction "Transaction" has: qtyMoved = 10.000
    	And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
    	And transaction "Transaction" has: storageAreaTgt = "H02-KLAER", storageLocationTgt = "K-201"
    	And transaction "Transaction" has equal idQuantumSrc and idQuantumTgt
    	And transaction "Transaction" has target load unit data
    	And transaction "Transaction" has: reasonTransaction1 = "Test RELQU 1", reasonTransaction2 = "Test RELQU 2"
    #Clean-up
 		Then delete quantum "Qu"


 			
 	Scenario: IM.004-005-0002: RELQU on target load unit without merging
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And the third separation criterion is "1,0"
    	And CREQU is called
    	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    	And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "EURO"
    	And the reasons are "Test RELQU 1"-"Test RELQU 2"
    	And CRELU is called
    	And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
    	And the quantum "Qu" has to be booked to target load unit "Lu"
    	And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
 		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.000 pieces of article "40067007" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 4"-"Test CREQU 5"
    	And CREQU is called
    	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    	And the quantum "Qu" has to be booked to target load unit "Lu"
    	And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
    	And the target load unit is "EURO"
    	And the target location is "H02-KLAER"-"K-201"
    	And target load unit "Lu" is 0.0 percent occupied
    	And verify that the weight of the load unit "Lu" is 37220.00
    	And transaction "Transaction" has: typTransaction = "RELQU"
    	And transaction "Transaction" has: stat = "90"
    	And transaction "Transaction" has: situation = "IM400"
    	And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067007"
    	And transaction "Transaction" has: qtyMoved = 20.000
    	And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
    	And transaction "Transaction" has: storageAreaTgt = "H02-KLAER", storageLocationTgt = "K-201"
    	And transaction "Transaction" has equal idQuantumSrc and idQuantumTgt
    	And transaction "Transaction" has target load unit data
    	And transaction "Transaction" has: reasonTransaction1 = "Test RELQU 1", reasonTransaction2 = "Test RELQU 2"
    #Clean-up
 		Then delete quantum "Qu"
 		Then delete load unit "Lu"
 			
 			
 	Scenario: IM.004-005-0003: RELQU on target load unit with merging
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And the third separation criterion is "1,0"
    	And CREQU is called
    	And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    	And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "EURO"
    	And the reasons are "Test RELQU 1"-"Test RELQU 2"
    	And CRELU is called
    	And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
    	And the quantum "1" has to be booked to target load unit "Lu"
    	And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
 		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.000 pieces of article "40067005" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And the third separation criterion is "1,0"
    	And CREQU is called
    	And CREQU was successful, saved as "2"; transaction saved as "Transaction"
    	And the quantum "2" has to be booked to target load unit "Lu"
    	And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
 		  And reload quantum "2"
    	And verify quantum "2" is deleted
    	And reload quantum "1"
    	And quantum "1" has available quantity 15.000
    	And target load unit "Lu" is 0.0 percent occupied
    	And verify that the weight of the load unit "Lu" is 36100.00
    	And transaction "Transaction" has: typTransaction = "RELQU"
    	And transaction "Transaction" has: stat = "90"
    	And transaction "Transaction" has: situation = "IM400"
    	And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067005"
    	And transaction "Transaction" has: qtyMoved = 5.000
    	And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
    	And transaction "Transaction" has: storageAreaTgt = "H02-KLAER", storageLocationTgt = "K-201"
    	And transaction "Transaction" has not equal idQuantumSrc and idQuantumTgt
    	And transaction "Transaction" has target load unit data
    	And transaction "Transaction" has: reasonTransaction1 = "Test RELQU 1", reasonTransaction2 = "Test RELQU 2"
     #Clean-up
 		Then delete quantum "1"
 			
 			
  Scenario: IM.004-005-0004: RELQU with a quantum on load unit, where the quantum already is
  IM-0073: Quantum ... is already on storage location ...
		Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
 			And the load unit type is "LBOX1"
    	And the reasons are "Test RELQU 1"-"Test RELQU 2"
 			And CRELU is called
 			And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
    	And the load unit "Lu" is the target
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
 			And CREQU was successful, saved as "1"; transaction saved as "Transaction"
 			And 2 sec is passed
 			And the load unit "Lu" has to be booked to target location "H01-FACH"-"106-2-007-03" with transaction type RELLU
 			And RELLU is called
 			And RELLU was successful; transaction saved as "Transaction"
 			And the quantum "1" has to be booked to target load unit "Lu"
 			And RELQU target load unit is "Lu"
 			And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then WEBSERVICE fails: error = "IM-0073"
 		#Clean-up
 		Then delete load unit "Lu"
