#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @crequ @defaultdatabased @crelu
Feature: IM.003-002: inventory/transaction/crequ - Inventory CREQU LU

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

		
   	Scenario: IM.003-002-0001: CREQU creates quantum on a priory created load unit
	   	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012000000001"
	    And CRELU is called
	    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
	   	And a quantum from storage location "QUELLE-LAG"-"Q-001" with 96.0 pieces of article "40067005" has to be created
	   	And the target load unit is "012000000001"
	   	And the artvar is "1" and stock type is "LO" and lock type is "MALOCK" and QC status is "00" and customs status is "00"
	   	And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
	   	And the third separation criterion is "5,0"
	   		When CREQU is called
	 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	    And quantum "Qu" has available quantity 96.000
	    And quantum "Qu" has reserved quantity 0.0
	    And quantum "Qu" has article "40067005"
	    And quantum "Qu" has sep crit 1 "0011"
	    And quantum "Qu" has sep crit 2 "0220" 
	    And quantum "Qu" has: idTransaction = key:Transaction
	    And quantum "Qu" has artvar "1"
	    And quantum "Qu" has stock type "LO"
	    And quantum "Qu" has lock type "MALOCK"
	    And quantum "Qu" has QC status "00"
	    And quantum "Qu" has customs status "00"
	    And quantum "Qu" has: idTransaction = key:Transaction
	    And transaction "Transaction" has: idLu1Tgt = "012000000001"
	    And transaction "Transaction" has: typLu1Tgt = "INDU"
	    And transaction "Transaction" has: wtGrossTgt = 86840.00
	    And transaction "Transaction" has: qtyAvailableTgt = 96.000
	    And transaction "Transaction" has: qtyReservedTgt = 0.0
	    And transaction "Transaction" has: artvarTgt = "1"
	    And transaction "Transaction" has: typStockTgt = "LO"
	    And transaction "Transaction" has: typLockTgt = "MALOCK"
	    And transaction "Transaction" has: statQualityControlTgt = "00"
	    And transaction "Transaction" has: statCustomsTgt = "00"
	    And transaction "Transaction" has: idQuantumTgt = key:Qu
	    And transaction "Transaction" has: stat = "90"
	    And transaction "Transaction" has: situation = "IM400"
	    And transaction "Transaction" has: storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001"
	    And transaction "Transaction" has: storageAreaTgt = "H01-KLAER", storageLocationTgt = "K-101"
	    And transaction "Transaction" has no source quantum data
	    And reload load unit "Lu"
	    And load unit "Lu" does not reference transaction "Transaction"
	    And load unit "Lu" has gross weight 86840.00
	    #Clean-Up
	    Then delete load unit "Lu"
    
    
    Scenario: IM.003-002-0002: CREQU creates quantum on a load unit with a quantum
	   	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		    And the load unit type is "INDU"
		    And the load unit ID is "012000000001"
		    And CRELU is called
		    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 96.0 pieces of article "40067005" has to be created
		   	And the target load unit is "012000000001"
		   	And the artvar is "1" and stock type is "LO" and lock type is "MALOCK" and QC status is "00" and customs status is "00"
		   	And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
		   	And the third separation criterion is "5,0"
	    When CREQU is called
	 	  Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		   	And a quantum from storage location "QUELLE-LAG"-"Q-001" with 96.0 pieces of article "40067005" has to be created
		   	And the target load unit is "012000000001"
		   	And the artvar is "1" and stock type is "LO" and lock type is "MALOCK" and QC status is "00" and customs status is "00"
		   	And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
		   	And the third separation criterion is "5,0"
	    When CREQU is called
	     Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	    And quantum "Qu" has available quantity 192.000
	    And quantum "Qu" has reserved quantity 0.0
	    And quantum "Qu" has: idTransaction = key:Transaction
	    And transaction "Transaction" has: idQuantumTgt = key:Qu
	    And transaction "Transaction" has: stat = "90"
	    And transaction "Transaction" has: situation = "IM400"
	    And transaction "Transaction" has: qtyAvailableTgt = 192.000
	    And transaction "Transaction" has: qtyReservedTgt = 0.0
	    And transaction "Transaction" has: artvarTgt = "1"
	    And transaction "Transaction" has: typStockTgt = "LO"
	    And transaction "Transaction" has: typLockTgt = "MALOCK"
	    And transaction "Transaction" has: statQualityControlTgt = "00"
	    And transaction "Transaction" has: statCustomsTgt = "00"
	    And transaction "Transaction" has: idLu1Tgt = "012000000001"
	    And transaction "Transaction" has: typLu1Tgt = "INDU"
	    And transaction "Transaction" has: wtGrossTgt = 138680.0
	    And transaction "Transaction" has: storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001"
	    And transaction "Transaction" has: storageAreaTgt = "H01-KLAER", storageLocationTgt = "K-101"
	    And transaction "Transaction" has no source quantum data
	    And quantum "Qu" has idLu1, saved as "Lu"
	    And load unit "Lu" has gross weight 138680.0
	    #Clean-Up
	    Then delete load unit "Lu"
