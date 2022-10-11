#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @resst @defaultdatabased

Feature: IM.005-002: inventory/transaction/resst - Inventory RESST With LU

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario: IM.005-002-0001: RESST with a quantum on load unit to increase the reserved quantity
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "LBOX1"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
   		And CRELU is called
 		And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
   		And a quantum from storage location "QUELLE-LAG"-"Q-001" with 25.0 pieces of article "40067007" has to be created
   		And the target location is "H01-KLAER"-"K-101"
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
    	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    	And the quantum "Qu" has to be booked to target load unit "Lu"
		And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
		And 17.000 "AVAILABLE" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
		When RESST is called
		Then RESST was successful; transaction saved as "Transaction"
     	And reload quantum "Qu"
     	And quantum "Qu" has available quantity 8.000
     	And quantum "Qu" has reserved quantity 17.000
     	And transaction "Transaction" has: qtyMoved = 17.000
     	And transaction "Transaction" has: typQuantity = "AVAILABLE"
     	And transaction "Transaction" has: qtyAvailableSrc = 25.000
     	And transaction "Transaction" has: qtyReservedSrc = 0.000
     	And transaction "Transaction" has: qtyAvailableTgt = 8.000
     	And transaction "Transaction" has: qtyReservedTgt = 17.000
        And transaction "Transaction" has: reasonTransaction1 = "Test RESST reason 1", reasonTransaction2 = "Test RESST reason 2"
     	And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
     	And all transactions within "Transaction" transaction group have target quantum
     	And all transactions within "Transaction" transaction group have source quantum
     	And transaction "Transaction" has source load unit
     	And transaction "Transaction" has target load unit
     	And transaction "Transaction" has source gross weight
     	And transaction "Transaction" has target gross weight
     	
     	
  Scenario: IM.005-002-0002: RESST with a quantum on load unit to decrease the reserved quantity
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    	And the load unit type is "LBOX1"
    	And the reasons are "Test CRELU 1"-"Test CRELU 2"
   		And CRELU is called
		And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
   		And a quantum from storage location "QUELLE-LAG"-"Q-001" with 25.0 pieces of article "40067007" has to be created
   		And the target location is "H01-KLAER"-"K-101"
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
    	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    	And the quantum "Qu" has to be booked to target load unit "Lu"
		And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
 		When RELQU is called
 		Then RELQU was successful; transaction saved as "Transaction"
		And 17.000 "AVAILABLE" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
		When RESST is called
		Then RESST was successful; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
    Given 11.000 "RESERVED" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
		And 1 sec is passed
		When RESST is called
		Then RESST was successful; transaction saved as "Transaction"
     	And reload quantum "Qu"
     	And quantum "Qu" has available quantity 19.000
     	And quantum "Qu" has reserved quantity 6.000
     	And transaction "Transaction" has: qtyMoved = 11.000
     	And transaction "Transaction" has: typQuantity = "RESERVED"
     	And transaction "Transaction" has: qtyAvailableSrc = 8.000
     	And transaction "Transaction" has: qtyReservedSrc = 17.000
     	And transaction "Transaction" has: qtyAvailableTgt = 19.000
     	And transaction "Transaction" has: qtyReservedTgt = 6.000
     	And transaction "Transaction" has: reasonTransaction1 = "Test RESST reason 1", reasonTransaction2 = "Test RESST reason 2"
     	And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
     	And all transactions within "Transaction" transaction group have target quantum
     	And all transactions within "Transaction" transaction group have source quantum
     	And transaction "Transaction" has source gross weight
     	And transaction "Transaction" has target gross weight
     	
