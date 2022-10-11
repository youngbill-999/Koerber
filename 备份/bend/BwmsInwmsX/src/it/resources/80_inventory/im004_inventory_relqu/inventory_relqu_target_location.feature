#Author: skaya@inconso.de
#Keywords Summary :
@inventory @relqu @defaultdatabased

Feature: IM.004-004: inventory/transaction/relqu - Inventory RELQU Target Location

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario: IM.004-004-0001: RELQU on target location with/without merging
    # without merging
 		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 50.000 pieces of article "40067024" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And the third separation criterion is "3,0"
    	And CREQU is called
    	And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    	And the quantum "1" has to be booked to location "H01-FACH"-"106-2-001-04"
    	And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
 		And location "H01-FACH"-"106-2-001-04" is occupied
 		And verify that the remaining weight of location "H01-FACH"-"106-2-001-04" is 47500.00
		And transaction "Transaction" has: typTransaction = "RELQU"
		And transaction "Transaction" has: stat = "90"
		And transaction "Transaction" has: situation = "IM400"
		And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067024"
		And transaction "Transaction" has: qtyMoved = 50.000
		And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
 		And transaction "Transaction" has: storageAreaTgt = "H01-FACH", storageLocationTgt = "106-2-001-04"
 		And transaction "Transaction" has equal idQuantumSrc and idQuantumTgt
		And transaction "Transaction" has: reasonTransaction1 = "Test RELQU 1", reasonTransaction2 = "Test RELQU 2"

    # with merging
		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 25.000 pieces of article "40067024" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And the third separation criterion is "3,0"
    	And CREQU is called
 			And CREQU was successful, saved as "2"; transaction saved as "Transaction"
 			And the quantum "2" has to be booked to location "H01-FACH"-"106-2-001-04"
 			And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
 		  And reload quantum "2"
 			And verify quantum "2" is deleted
 			And reload quantum "1"
 			And quantum "1" has available quantity 75.000
			And location "H01-FACH"-"106-2-001-04" is occupied
			And verify that the remaining weight of location "H01-FACH"-"106-2-001-04" is 46250.00
			And transaction "Transaction" has: typTransaction = "RELQU"
		And transaction "Transaction" has: stat = "90"
		And transaction "Transaction" has: situation = "IM400"
		And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067024"
		And transaction "Transaction" has: qtyMoved = 25.000
		And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
 		And transaction "Transaction" has: storageAreaTgt = "H01-FACH", storageLocationTgt = "106-2-001-04"
 		And transaction "Transaction" has not equal idQuantumSrc and idQuantumTgt
		And transaction "Transaction" has: reasonTransaction1 = "Test RELQU 1", reasonTransaction2 = "Test RELQU 2"
		#Clean-up
 		Then delete quantum "1"
			
		
	Scenario: IM.004-004-0002: RELQU on target location to remove quantum
		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 200.000 pieces of article "40067222" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And the quantum "Qu" has to be booked to location "SENKE-LAG"-"S-001"
 			And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
 		  And reload quantum "Qu"
 			And verify quantum "Qu" is deleted
			And transaction "Transaction" has: typTransaction = "RELQU"
			And transaction "Transaction" has: stat = "90"
			And transaction "Transaction" has: situation = "IM400"
			And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067222"
			And transaction "Transaction" has: qtyMoved = 200.000
			And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
 			And transaction "Transaction" has: storageAreaTgt = "SENKE-LAG", storageLocationTgt = "S-001"
 			And transaction "Transaction" has source quantum data
 			And transaction "Transaction" has no target quantum data
 			And transaction "Transaction" has: reasonTransaction1 = "Test RELQU 1", reasonTransaction2 = "Test RELQU 2"
