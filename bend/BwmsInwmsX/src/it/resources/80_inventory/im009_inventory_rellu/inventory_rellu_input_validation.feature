#Author: michael.nkongho@koerber-supplychain.com
#Keywords Summary :
@inventory @RELLU @defaultdatabased

Feature: IM.009-002: inventory/transaction/rellu - Inventory RELLU (BOOKING) without quantum input validation

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

 
  Scenario:IM.009-001-0001: RELLU is called on a load unit without idSite, then RELLU throws exception BEND-0005
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with no idSite
	 	  Then RELLU throws id exception "BEND-0005"  
	 	   #Clean-Up
      Then delete load unit "T"
      
      
  Scenario:IM.009-001-0002: RELLU is called on a load unit without clProcess, then RELLU throws exception BEND-0005
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with no clProcess
	 	  Then RELLU throws id exception "BEND-0005"  
	 	   #Clean-Up
      Then delete load unit "T"
          
  Scenario:IM.009-001-0003: RELLU is called on a load unit without typProcess, then RELLU throws exception BEND-0005
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with no typProcess
	 	  Then RELLU throws id exception "BEND-0005"  
	 	   #Clean-Up
      Then delete load unit "T"
      
            
  Scenario:IM.009-001-0004: RELLU is called on a load unit without stepProcess, then RELLU throws exception BEND-0005
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with no stepProcess
	 	  Then RELLU throws id exception "BEND-0005"  
	 	   #Clean-Up
      Then delete load unit "T"
      
               
  Scenario:IM.009-001-0005: RELLU is called on a load unit without key. verify that RELLU throws exception BEND-0005
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with no key
	 	  Then RELLU throws id exception "BEND-0005"  
	 	   #Clean-Up
      Then delete load unit "T"
      
                  
  Scenario:IM.009-001-0006: RELLU is called on a load unit without idLu. verify that RELLU throws exception BEND-0005
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with no idLu
	 	  Then RELLU throws id exception "BEND-0005"  
	 	   #Clean-Up
      Then delete load unit "T"
      
                   
  Scenario:IM.009-001-0006: RELLU is called on a load unit without idUser. verify that RELLU throws exception BEND-0005
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with no idUser
	 	  Then RELLU throws id exception "BEND-0005"  
	 	   #Clean-Up
      Then delete load unit "T"
      
      
      Scenario:IM.009-001-0007: RELLU is called on a load unit with inconsistent filled references, idRef null and idRef1 filled. verify that RELLU throws exception BWM-0008
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with inconsistent references, dRef null and idRef1 filled
	 	  Then RELLU throws id exception "BWM-0008"  
	 	   #Clean-Up
      Then delete load unit "T"
      
      
      Scenario:IM.009-001-0008: RELLU is called on a load unit with inconsistent filled references,  idRef = GI_ORDER and idRef1 = null (but other idRef filled). verify that RELLU throws exception BWM-0008
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with inconsistent references, idRef = GI_ORDER and idRef1 = null, idRef2, idRef3, idRef4, idRef5 and idRef6 filled 
	 	  Then RELLU throws id exception "BWM-0008"  
	 	   #Clean-Up
      Then delete load unit "T"
     
      Scenario:IM.009-001-0009: RELLU is called on a load unit with inconsistent filled references,  idRef = ABC (idRef1-6 irrelevant). verify that RELLU throws exception BWM-0008
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815968"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with inconsistent references, idRef = ABC and others are irrelevant 
	 	  Then RELLU throws id exception "BWM-0008"  
	 	   #Clean-Up
      Then delete load unit "T"
      
      
      Scenario:IM.009-001-00010: RELLU is called with non-existing Lu. verify that RELLU throws exception IM-??
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333817178"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with non-existing Lu
	 	  Then RELLU throws id exception "IM-0018"  
	 	   #Clean-Up
      Then delete load unit "T"
      
      
      Scenario:IM.009-001-00011: RELLU is called with no target location or area. Verify that RELLU throws the exception IM-002
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012333815978"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H03-PARK"-"PARK-301" with RELLU type BOOKING
	 	  When RELLU is called with no target location
	 	  Then RELLU throws id exception "IM-0803"  
	 	   #Clean-Up
      Then delete load unit "T"
     @Test
      Scenario:IM.009-001-00012: RELLU is called with a target location having not enough capacity. verify that RELLU throws the exception QM-0003
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012337717938"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H01-HRL"-"101-2-003-02" with RELLU type BOOKING and location having 100.0% occupation
	 	  When RELLU is called with a target location having not enough capacity
	 	  Then RELLU throws id exception "QM-0003"  
	 	   #Clean-Up
      Then delete load unit "T"
      
      
      Scenario:IM.009-001-00013: RELLU is called with a target location that doesnot accept load unit type. verify that RELLU throws the exception OM-??
  	 Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-102" has to be created
	    And the load unit type is "INDU"
	    And the load unit ID is "012337537947"
	    And CRELU is called
	    And CRELU was successful, saved as "T"; transaction saved as "Transaction"
	 	  Given the load unit "T" has to be booked to target location "H04-AKL"-"401-1-001-01-2" with RELLU type BOOKING
	 	  When RELLU is called with a target location that doesnot accept load unit type
	 	  Then RELLU throws id exception "OM-0005"  
	 	   #Clean-Up
      Then delete load unit "T"
	 	  