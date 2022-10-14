#Author: michael.nkongho@koerber-supplychain.com
#Keywords Summary :
@inventory @RELLU @defaultdatabased

Feature: IM.009-001: inventory/transaction/rellu - Inventory RELLU(BOOKING) without quantum

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

   
  Scenario:IM.009-001-0001: RELLU is called on a load unit without quantum. Verify load unit source and target location
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012396882152"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called
	 	  Then RELLU was successful; transaction saved as "Trasaction"
	 	  And load unit with transaction "Trasaction" is at target location "H03-PARK"-"PARK-301" 
	 	  And load unit with transaction "Trasaction" source location was "H01-WE"-"W-102"
	 	  And load unit with transaction "Trasaction" is not moving and has status "90"
	 	   #Clean-Up
      Then delete load unit "T"