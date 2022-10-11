#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @crelu @defaultdatabased
Feature: IM.002-004: inventory/transaction/crelu - Inventory CRELU

Background:
	Given set global: idSite = "RL1", idClient = "RK1"


Scenario: IM.002-005-0001: CRELU with given SSCC sets SSCC in load unit & transaction.
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
		And the CRELU input has: SSCC = "01200000000000000011"
		And the reasons are "Test CRELU 1"-"Test CRELU 2"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And load unit "Lu" has SSCC "01200000000000000011"
		And transaction "Transaction" has: sscc = "01200000000000000011"
#Clean-Up
Then delete load unit "Lu"

	
Scenario: IM.002-005-0002: CRELU without given SSCC sets new SSCC in load unit & transaction.
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And load unit "Lu" has empty SSCC
		And transaction "Transaction" has the same SSCC as the load unit "Lu" 	
#Clean-Up
	Then delete load unit "Lu"


Scenario: IM.002-005-0003: CRELU with given height sets height in load unit & transaction.
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
		And the CRELU input has: height = 100.000
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And load unit "Lu" has height 100.000
		And transaction "Transaction" has: heightTgt = 100.000
#Clean-Up
	Then delete load unit "Lu"


Scenario: IM.002-005-0004: CRELU without given height sets height in load unit & transaction according to load unit type height.
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And load unit "Lu" has height 15.000
		And transaction "Transaction" has: heightTgt = 15.000
#Clean-Up
	Then delete load unit "Lu"


Scenario: IM.002-005-0005: CRELU creates an empty load unit
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And load unit "Lu" is empty
#Clean-Up
	Then delete load unit "Lu"


Scenario: IM.002-005-0006: CRELU creates a not moving load unit
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And load unit "Lu" is not moving
#Clean-Up
	Then delete load unit "Lu"


Scenario: IM.002-005-0007: CRELU creates a load unit with same gross and tare weight (and in transaction)
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And gross weight of the load unit "Lu" is the same as the tara weight
		And transaction "Transaction" has the same gross and tara weight as the load unit "Lu"
#Clean-Up
	Then delete load unit "Lu"


Scenario: IM.002-005-0008: CRELU creates load unit and transaction that reference one another
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And load unit "Lu" has: idTransaction = key:Transaction
		And transaction "Transaction" has: idLu1Tgt = key:Lu
		And transaction "Transaction" has: stat = "90"
#Clean-Up
	Then delete load unit "Lu"


Scenario: IM.002-005-0009: CRELU creates load unit with correct source and target location
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And load unit "Lu" is at storage location "H01-KLAER"-"K-101"
		And transaction "Transaction" has: storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001"
		And transaction "Transaction" has: storageAreaTgt = "H01-KLAER", storageLocationTgt = "K-101"
#Clean-Up
	Then delete load unit "Lu"


Scenario: IM.002-005-0010: CRELU creates load unit and transaction with given reasons
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
		And the reasons are "Test CRELU 1"-"Test CRELU 2"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And transaction "Transaction" has: reasonTransaction1 = "Test CRELU 1", reasonTransaction2 = "Test CRELU 2"
#Clean-Up
	Then delete load unit "Lu"


Scenario: IM.002-005-0011: CRELU creates transaction with determined situation
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "EURO"
	When CRELU is called
	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And transaction "Transaction" has: situation = "IM400"
#Clean-Up
Then delete load unit "Lu"

