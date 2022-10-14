#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@inventory @chasc  @defaultdatabased


Feature: IM.013-006: inventory/transaction/chasc - Inventory CHASC check complete change 

Background: 	
	Given set global: idSite = "RL1", idClient = "RK2"



	@complete_change   
	Scenario: IM.013-006-0001: Complete Change
	         On a location is one quantum.
           The artvar is changed for all quantity of quantum A.
           The transaction references the correct source quantum A and also the target quantum A
           The transaction quantities are filled correctly. 
           Quantum A still has the original quantity and the correct artvar (respectively batch typLock etc.)
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100.00 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction1"
		   
  When CHASC is used to change quantum = "Qu" with artvar = "2"  and qtyMoved = 100.00
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
	Then transaction "CHASC-Transaction" has: typTransaction = "CHASC"
	    And transaction "CHASC-Transaction" has equal idQuantumSrc and idQuantumTgt
	    
	Then quantum "Qu" has: idTransaction = key:CHASC-Transaction
      And quantum "Qu" has QtyAvailble with 100.00
      And quantum "Qu" has artvar = "2"
	#Clean-Up
	Then delete quantum "Qu"	
	