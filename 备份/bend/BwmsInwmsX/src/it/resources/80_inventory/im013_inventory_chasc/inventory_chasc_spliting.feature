#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@inventory @chasc @defaultdatabased


Feature: IM.013-003: inventory/transaction/chasc - Inventory CHASC check splitting 
 
Background: 	
	Given set global: idSite = "RL1", idClient = "RK2"



	 @Splitting  
	Scenario: IM.013-002-0001: Splitting
	         On a location is one quantum.
	         The artvar is changed for a part of quantum A.
	         The transaction references the correct source quantum A and a new target quantum
	         The transaction quantities are filled correctly. 
	         Quantum A has a new quantity (original quantity - changed quantity).
	         Quantum B has a new quantity (changed quantity).
	         Quantum B has the correct artvar (respectively batch typLock etc.)
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction1"
		   
  When CHASC is used to change quantum = "Qu1" with artvar = "2"  and qtyMoved = 50.00
		  And CHASC is called
		  #TransactionHelper.transactionSuccessful
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
		  # com.inconso.bend.inwmsx.it.inventory.TransactionHandler.verifyTransactionHasTypTransaction
	Then transaction "CHASC-Transaction" has: typTransaction = "CHASC"
	    And transaction "CHASC-Transaction" has: idQuantumSrc = key:Qu1
	    And transaction "CHASC-Transaction" has a new target quantum
	    And save target quantum as "Qu2" for transaction "CHASC-Transaction"   
  Then quantum "Qu2" has QtyAvailble with 50.00
      And quantum "Qu2" has artvar = "2"
	#Clean-Up
	Then delete quantum "Qu1"	
	And delete quantum "Qu2"
	