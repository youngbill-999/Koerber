#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@inventory @chasc  @defaultdatabased


Feature: IM.013-005: inventory/transaction/chasc - Inventory CHASC check Melting with GR data 
  
Background: 	
	Given set global: idSite = "RL1", idClient = "RK2"

 @Melting @GRdata
###########################- 1 -#####################################
	Scenario: IM.013-005-0001:
	    On a location are 2 quanta A and B with the same attributes. They differ in their artvar. 
      Quantum A has GR data (GR receipt, item, date); quantum B has no GR data
      The artvar is changed for all quantity of quantum A to match artvar of quantum B. 
      Quantum B has no GR data.
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 1, tsGoodsReceipt = 2025/05/02
		  And CREQU is called
	Then CREQU was successful, saved as "Qu1"; transaction saved as "Transaction1"
		  And transaction "Transaction1" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
 	    And transaction "Transaction1" has: tsGoodsReceiptTgt = 2025/05/02
		  
		  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
		  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction2"
		   
  When CHASC is used to change quantum = "Qu1" with artvar = "2"  and qtyMoved = 100.00
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
	Then transaction "CHASC-Transaction" has: typTransaction = "CHASC"
	    And transaction "CHASC-Transaction" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
	  	And transaction "CHASC-Transaction" has: tsGoodsReceiptTgt = 2025/05/02
	Then quantum "Qu2" has: idTransaction = key:CHASC-Transaction
	    And quantum "Qu2" has: goods receipt = "GR-0001"-1 and GR-Date = 2025/05/02 
	  	
	  	
	#Clean-Up
	Then delete quantum "Qu1"	
	And delete quantum "Qu2"
	
	
	 @Melting @GRdata
	###########################- 2 -#####################################
	Scenario: IM.013-005-0002:
	    On a location are 2 quanta A and B with the same attributes. They differ in their artvar. 
      Quantum A has no GR data (GR receipt, item, date); quantum B has GR data
      The artvar is changed for all quantity of quantum A to match artvar of quantum B. 
      Quantum B has no GR data.
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU is called
	Then CREQU was successful, saved as "Qu1"; transaction saved as "Transaction1"
		  
		  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 1, tsGoodsReceipt = 2025/05/02
		  And CREQU is called
	Then CREQU was successful, saved as "Qu2"; transaction saved as "Transaction2"
		  And transaction "Transaction2" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
 	    And transaction "Transaction2" has: tsGoodsReceiptTgt = 2025/05/02
		   
  When CHASC is used to change quantum = "Qu1" with artvar = "2"  and qtyMoved = 100.00
		  And CHASC is called
		  #TransactionHelper.transactionSuccessful
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
		  # com.inconso.bend.inwmsx.it.inventory.TransactionHandler.verifyTransactionHasTypTransaction
	Then transaction "CHASC-Transaction" has: typTransaction = "CHASC"
	    And transaction "CHASC-Transaction" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
	  	And transaction "CHASC-Transaction" has: tsGoodsReceiptTgt = 2025/05/02
	#Clean-Up
	Then delete quantum "Qu1"	
	And delete quantum "Qu2"
	
	
	 @Melting @GRdata
	###########################- 3 -#####################################
	##okay
	Scenario: IM.013-005-0003:
	    On a location are 2 quanta A and B with the same attributes. They differ in their artvar. 
	    Quantum A has GR data (GR receipt, item, date); quantum B has the same GR data
	    The artvar is changed for all quantity of quantum A to match artvar of quantum B. 
	    Quantum B has the original GR data.
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
	And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 1, tsGoodsReceipt = 2025/05/02
		  And CREQU is called
	Then CREQU was successful, saved as "Qu1"; transaction saved as "Transaction1"
	    And transaction "Transaction1" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
 	    And transaction "Transaction1" has: tsGoodsReceiptTgt = 2025/05/02
		  
		  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		  And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 1, tsGoodsReceipt = 2025/05/02
		  And CREQU is called
	Then CREQU was successful, saved as "Qu2"; transaction saved as "Transaction2"
		  And transaction "Transaction2" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
 	    And transaction "Transaction2" has: tsGoodsReceiptTgt = 2025/05/02
		   
  When CHASC is used to change quantum = "Qu1" with artvar = "2"  and qtyMoved = 100.00
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
	Then transaction "CHASC-Transaction" has: typTransaction = "CHASC"
		  And transaction "CHASC-Transaction" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
	  	And transaction "CHASC-Transaction" has: tsGoodsReceiptTgt = 2025/05/02
		  And quantum "Qu2" has: idTransaction = key:CHASC-Transaction
		  And quantum "Qu2" has: goods receipt = "GR-0001"-1 and GR-Date = 2025/05/02
	#Clean-Up
	Then delete quantum "Qu1"	
	And delete quantum "Qu2"
	
	
	 @Melting @GRdata
	###########################- 4 -#####################################
	
	Scenario: IM.013-005-0004:
	    On a location are 2 quanta A and B with the same attributes. They differ in their artvar. 
      Quantum A has GR data (GR receipt, item, date); quantum B has different GR data. (The data may differ in any value of the 3 mentioned ones)
      The artvar is changed for all quantity of quantum A to match artvar of quantum B. 
      Quantum B has the no GR data.
						
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
	And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 1, tsGoodsReceipt = 2025/05/02
		  And CREQU is called
	Then CREQU was successful, saved as "Qu1"; transaction saved as "Transaction1"
	    And transaction "Transaction1" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
 	    And transaction "Transaction1" has: tsGoodsReceiptTgt = 2025/05/02
		  
	##新创建的quantum就没有问题，但是上一次的没有删掉留到下依稀	一次就要报错
 Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 100 pieces of article "WT-XP3" has to be created
		  And the target location is "A01-EMPTY"-"A-001"
		  And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
	And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 2, tsGoodsReceipt = 2025/05/02
		  And CREQU is called
	Then CREQU was successful, saved as "Qu2"; transaction saved as "Transaction2"
	    And transaction "Transaction2" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 2
 	    And transaction "Transaction2" has: tsGoodsReceiptTgt = 2025/05/02
		   
  When CHASC is used to change quantum = "Qu1" with artvar = "2"  and qtyMoved = 100.00
		  And CHASC is called
		  And CHASC was successful; transaction saved as "CHASC-Transaction"
	Then transaction "CHASC-Transaction" has: typTransaction = "CHASC"
		  And transaction "CHASC-Transaction" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
	  	And transaction "CHASC-Transaction" has: tsGoodsReceiptTgt = 2025/05/02
		  And quantum "Qu2" has: idTransaction = key:CHASC-Transaction
		  And quantum "Qu2" has: goods receipt = "GR-0001"-1 and GR-Date = 2025/05/02
	#Clean-Up
	Then delete quantum "Qu1"	
	And delete quantum "Qu2"