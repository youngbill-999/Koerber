#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @resst @defaultdatabased

Feature: IM.005-003: inventory/transaction/resst - Inventory RESST Without LU

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario: IM.005-003-0001:  RESST to increase the reserved quantity
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And CREQU was successful, saved as "QuOld"; transaction saved as "Transaction"
 			And 2 sec is passed
 			And 8.000 "AVAILABLE" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
 		When RESST is called
	  Then RESST was successful; transaction saved as "Transaction"
	  	And reload quantum "Qu"
	  	And quantums "Qu" and "QuOld" have different tsUpd
	  	And quantum "Qu" has: idUpd = "basis"
     	And quantum "Qu" has available quantity 2.000
     	And quantum "Qu" has reserved quantity 8.000
     	And transaction "Transaction" has: qtyMoved = 8.000
     	And transaction "Transaction" has: typQuantity = "AVAILABLE"
     	And transaction "Transaction" has: qtyAvailableSrc = 10.000
     	And transaction "Transaction" has: qtyReservedSrc = 0.000
     	And transaction "Transaction" has: qtyAvailableTgt = 2.000
     	And transaction "Transaction" has: qtyReservedTgt = 8.000
     	And transaction "Transaction" has: reasonTransaction1 = "Test RESST reason 1", reasonTransaction2 = "Test RESST reason 2"
     	And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
     	And all transactions within "Transaction" transaction group have target quantum
     	And all transactions within "Transaction" transaction group have source quantum
     
     
  Scenario: IM.005-003-0002: RESST fails, if The transferred quantity is higher than the available quantity
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
    	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    	And 2 sec is passed
# -----------------------------------------------------------------------------
  	Given 11.000 "AVAILABLE" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
		When RESST is called
		Then WEBSERVICE fails: error = "IM-0030"
		
		
	Scenario: IM.005-003-0003: RESST to decrease the reserved quantity
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And CREQU was successful, saved as "QuOld"; transaction saved as "Transaction"
 			And 2 sec is passed
 			And 8.000 "AVAILABLE" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
 		When RESST is called
	  Then RESST was successful; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
		Given 5.000 "RESERVED" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
			And 1 sec is passed
		When RESST is called
		Then RESST was successful; transaction saved as "Transaction"
     	And reload quantum "Qu"
	  	And quantums "Qu" and "QuOld" have different tsUpd
	  	And quantum "Qu" has: idUpd = "basis"
     	And quantum "Qu" has available quantity 7.000
     	And quantum "Qu" has reserved quantity 3.000
     	And transaction "Transaction" has: qtyMoved = 5.000
     	And transaction "Transaction" has: typQuantity = "RESERVED"
     	And transaction "Transaction" has: qtyAvailableSrc = 2.000
     	And transaction "Transaction" has: qtyReservedSrc = 8.000
     	And transaction "Transaction" has: qtyAvailableTgt = 7.000
     	And transaction "Transaction" has: qtyReservedTgt = 3.000
     	And transaction "Transaction" has: reasonTransaction1 = "Test RESST reason 1", reasonTransaction2 = "Test RESST reason 2"
     	And transaction "Transaction" has: storageAreaSrc = "H01-KLAER", storageLocationSrc = "K-101"
     	And all transactions within "Transaction" transaction group have target quantum
     	And all transactions within "Transaction" transaction group have source quantum
     	
  Scenario: IM.005-003-0004: RESST fails, if The transferred quantity is higher than the reserved quantity
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
    	And the target location is "H01-KLAER"-"K-101"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 2 sec is passed
 			And 8.000 "AVAILABLE" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
 		When RESST is called
	  Then RESST was successful; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
  	Given 9.000 "RESERVED" pieces of quantum "Qu" with reason "Test RESST reason 1" and "Test RESST reason 2" have to be reserved
		When RESST is called
		Then WEBSERVICE fails: error = "IM-0031"
