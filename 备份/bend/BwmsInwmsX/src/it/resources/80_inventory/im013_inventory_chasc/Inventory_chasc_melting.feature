#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@inventory @chasc @defaultdatabased


Feature: IM.013-002: inventory/transaction/chasc - Inventory CHASC check melting 
  
Background: 	
	Given set global: idSite = "RL1", idClient = "RK2"

@basic
###########################- 1 -#####################################
	
	Scenario: IM.013-002-0001: Melting
	         On a location are 2 quanta A and B with the same attributes - they only differ in their artvar.
           The artvar is changed for a part of quantum A to match artvar of quantum B. 
           The transaction references the correct source quantum A and target quantum B.
           The transaction quantities are filled correctly. 
           Quantum A has a new quantity (original quantity - changed quantity).
           Quantum B has a new quantity (original quantity + changed quantity).
           Quantum B has the correct artvar (respectively batch typLock etc.)
           Same situation is verified for changing: 
           typLock
           typStock
           stat quality control
           stat customs
           special stock type and ID
           separation criteria
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction1"
		  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction2"
		   
  When CHASC is used to change quantum = "Qu1" with artvar = "2"  and qtyMoved = 50.00
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
	Then transaction "CHASC-Transaction" has: typTransaction = "CHASC"
	    And transaction "CHASC-Transaction" has: idQuantumSrc = key:Qu1
	    And transaction "CHASC-Transaction" has: idQuantumTgt = key:Qu2     
  Then quantum "Qu1" has decreased by 50.00 and quantum "Qu2" has increased by 50.00
      And quantum "Qu2" has artvar = "2"
      And quantum "Qu2" has stock type "AV"
      And quantum "Qu2" has lock type "------"
      And quantum "Qu2" has QC status "00"
      And quantum "Qu2" has customs status "00"
      
	#Clean-Up
	Then delete quantum "Qu1"	
	And delete quantum "Qu2"
	
	@basic
###########################- 2 -#####################################
	
	Scenario: IM.013-002-0002: Melting with deletion
           On a location are 2 quanta A and B with the same attributes - they only differ in their artvar.
           The artvar is changed for all quantity of quantum A to match artvar of quantum B. 
           The transaction references the correct source quantum A and target quantum B.
           The transaction quantities are filled correctly. 
           Quantum A is deleted
           Quantum B has a new quantity (original quantity + changed quantity).
           Quantum B has the correct artvar (respectively batch typLock etc.)

						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction1"
		  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction2"
		   
  When CHASC is used to change quantum = "Qu1" with artvar = "2"  and qtyMoved = 100.00
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
  Then transaction "CHASC-Transaction" has: typTransaction = "CHASC"
	    And transaction "CHASC-Transaction" has: idQuantumSrc = key:Qu1
	    And transaction "CHASC-Transaction" has: idQuantumTgt = key:Qu2
	Then quantum "Qu1" was deleted and quantum "Qu2" has increased by 100.00
      And quantum "Qu2" has artvar = "2"
	#Clean-Up
	And delete quantum "Qu2"
		
	
	