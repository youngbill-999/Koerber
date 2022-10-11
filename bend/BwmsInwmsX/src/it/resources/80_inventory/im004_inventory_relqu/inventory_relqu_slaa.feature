#Author: skaya@inconso.de
#Keywords Summary :
@inventory @relqu @defaultdatabased

Feature: IM.004-003: inventory/transaction/relqu - Inventory RELQU SLAA

Background:
	Given set global: idSite = "RL1", idClient = "RK1"

Scenario: IM.004-003-0001: RELQU on Location without fixed location
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		And prepare target location "H01-FACH"-"106-2-005-03" for SLAA verification
		And create single article config for client location type "F5" with flags artvar = "1", qty = "0", lu type = "0", stock type = "0", lock type = "0", special stock type = "0", special stock ID = "0", customs = "0", qc = "0", batch = "0", sepCrits = "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"
		And the quantum "Qu" has to be booked to location "H01-FACH"-"106-2-005-03"
		And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
	When RELQU is called
		And RELQU was successful; transaction saved as "Transaction"
	Then A record in SLAA100 for location "H01-FACH"-"106-2-005-03", "40067005", "0" has been created
		And in this record the fixed location is not flagged
		And initial is not flagged
		And the stock criteria are filled according to SLAA010
#Clean-up
	Then delete quantum "Qu"
	Then delete single article config for client location type "F5"
	
	
Scenario: IM.004-003-0002: RELQU on load unit without fixed location
	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
		And the load unit type is "LBOX1"
		And the reasons are "Test CRELU 1"-"Test CRELU 2"
		And CRELU is called
		And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
		And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1.000 pieces of article "40067222" has to be created
		And the load unit "Lu" is the target
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		And the load unit "Lu" has to be booked to target location "H01-FACH"-"106-2-004-03" with transaction type RELLU
		And RELLU is called
		And RELLU was successful; transaction saved as "Transaction"
		And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1.000 pieces of article "40067024" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
		And prepare target location "H01-FACH"-"106-2-004-03" for SLAA verification
		And create single article config for client location type "F5" with flags artvar = "1", qty = "0", lu type = "0", stock type = "0", lock type = "0", special stock type = "0", special stock ID = "0", customs = "0", qc = "0", batch = "0", sepCrits = "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"
		And the quantum "Qu" has to be booked to location "H01-FACH"-"106-2-004-03"
		And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
	When RELQU is called
	Then WEBSERVICE fails: error = "SLAA-0002"
#Clean-up
	Then delete quantum "Qu"
	Then delete single article config for client location type "F5"

			