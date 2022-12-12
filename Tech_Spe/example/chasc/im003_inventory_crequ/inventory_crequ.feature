#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @crequ @defaultdatabased @coolingClearing
Feature: IM.003-005: inventory/transaction/crequ - Inventory CREQU

Background: 	
  Given set global: idSite = "RL1", idClient = "RK1"
	Given storage location "H01-KLAER"-"K-101" is empty
	  And a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067022" has to be created
   	And the target location is "H01-KLAER"-"K-101"
   	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"


Scenario: IM.003-005-0001: CREQU creates quantum with correct article and quantities
   	And create batch "1234542A" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
	  And BBD is 2020/01/01 and batch is "BatchDessert[0]"
   	When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    And quantum "Qu" has article "40067022"
    And quantum "Qu" has available quantity 20.000
    And quantum "Qu" has reserved quantity 0.0
    And transaction "Transaction" has: qtyAvailableTgt = 20.000
 	  And transaction "Transaction" has: qtyReservedTgt = 0.0
    
Scenario: IM.003-005-0002: CREQU creates quantum with correct stock criteria
   	And create batch "1234542B" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
 	   	When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    And quantum "Qu" has artvar "1"
    And quantum "Qu" has stock type "AV"
    And quantum "Qu" has lock type "------"
    And quantum "Qu" has QC status "00"
    And quantum "Qu" has customs status "00"

Scenario: IM.003-005-0003: CREQU creates quantum with default separation criteria 1 and 2
   	And create batch "1234542C" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
       	When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    And quantum "Qu" has sep crit 1 "0011"
    And quantum "Qu" has sep crit 2 "0220" 

Scenario: IM.003-005-0004: CREQU creates quantum and transaction that reference one another
   	And create batch "1234542D" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
	   	When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    And quantum "Qu" has: idTransaction = key:Transaction
    And transaction "Transaction" has: idQuantumTgt = key:Qu
    And transaction "Transaction" has: stat = "90"
    
Scenario: IM.003-005-0005: CREQU creates quantum at target location that is not moving
   	And create batch "1234542E" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
	   	When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    And quantum "Qu" is at "H01-KLAER"-"K-101"
 	And quantum "Qu" is not moving
    
Scenario: IM.003-005-0006: CREQU creates a transaction with given reasons
   	And create batch "1234542F" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
	When the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
 	When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
   And transaction "Transaction" has: reasonTransaction1 = "Test CREQU 1", reasonTransaction2 = "Test CREQU 2"

Scenario: IM.003-005-0007: CREQU creates transaction with determined situation
   	And create batch "1234542G" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    And transaction "Transaction" has: situation = "IM400"
    
Scenario: IM.003-005-0008: CREQU creates transaction with specified source and target location
   	And create batch "1234542H" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And transaction "Transaction" has: storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001"
  And transaction "Transaction" has: storageAreaTgt = "H01-KLAER", storageLocationTgt = "K-101"
    
Scenario: IM.003-005-0009: CREQU creates transaction where source quantum data is empty
   	And create batch "1234542I" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And transaction "Transaction" has no source quantum data
  	
Scenario: IM.003-005-0010 CREQU creates transaction where target stock criteria is as requested
   	And create batch "1234542J" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And transaction "Transaction" has: artvarTgt = "1"
 	And transaction "Transaction" has: typStockTgt = "AV"
 	And transaction "Transaction" has: typLockTgt = "------"
 	And transaction "Transaction" has: statQualityControlTgt = "00"
 	And transaction "Transaction" has: statCustomsTgt = "00"
 	
Scenario: IM.003-005-0011: CREQU creates transaction where target BBD and batch is as requested	
And create batch "1234542K" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2042/01/01 and batch is "BatchDessert[0]"
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And transaction "Transaction" has: tsBbdTgt = 2042/01/01
 	#And transaction "Transaction" has: idBatchTgt = "BatchDessert[0]"

Scenario: IM.003-005-0012: CREQU creates transaction where target goods receiving is as requested	
   	And create batch "1234542L" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
 And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 1, tsGoodsReceipt = 2019/03/01
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And transaction "Transaction" has: idGoodsReceiptTgt = "GR-0001", numGoodsReceiptItemTgt = 1
 	And transaction "Transaction" has: tsGoodsReceiptTgt = 2019/03/01
 	
 Scenario: IM.003-005-0013:  CREQU creates transaction where source sep crit 1 & 2 are empty
    	And create batch "1234542M" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And transaction "Transaction" has no source separation criteria
 	
Scenario: IM.003-005-0014: CREQU creates transaction where target sep crit 1 & 2 are set as defined in default
   	And create batch "1234542N" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And transaction "Transaction" has: sepCrit01Tgt = "0011"
 	And transaction "Transaction" has: sepCrit02Tgt = "0220"

Scenario: IM.003-005-0015: CREQU creates transaction where load unit data is empty
   	And create batch "1234542O" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
And BBD is 2020/01/01 and batch is "BatchDessert[0]"
 		When CREQU is called
 	Then CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	And transaction "Transaction" has no source load unit data
 	And transaction "Transaction" has no target load unit data
    