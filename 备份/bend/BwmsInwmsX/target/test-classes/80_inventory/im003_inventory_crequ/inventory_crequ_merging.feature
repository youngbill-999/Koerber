#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @crequ @defaultdatabased
Feature: IM.003-003: inventory/transaction/crequ - Inventory Inventory CREQU Merging
Merging new quantum to existing with same criteria

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


Scenario: IM.003-003-0001: CREQU merges existing quanta and increases quantity
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-05"
    And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the third separation criterion is "2,0"
 	And CREQU is called
 	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-05"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the third separation criterion is "2,0"
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    And quantum "Qu" has article "40067005"
    And quantum "Qu" has available quantity 15.000
    And quantum "Qu" has reserved quantity 0.0
   #Clean-Up
   Then delete quantum "Qu"