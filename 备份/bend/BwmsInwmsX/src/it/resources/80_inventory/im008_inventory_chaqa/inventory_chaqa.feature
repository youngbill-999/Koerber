#Author: aaikharia@inconso.de
#Keywords Summary :
@inventory @chaqa @defaultdatabased


Feature: IM.008-001: inventory/transaction/chaqa - Inventory CHAQA


Background: 	
	Given set global: idSite = "RL1", idClient = "RK1"

	Scenario: IM.008-001-0001: CHAQA changes the BBD of a quantum
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"	
	When CHAQA is used to change quantum "Qu" with BBD = 2042/05/02				
		And CHAQA is called
		And CHAQA was successful; transaction saved as "CHAQA-Transaction"
	Then transaction "CHAQA-Transaction" has: typTransaction = "CHAQA"
		And transaction "CHAQA-Transaction" has equal idQuantumSrc and idQuantumTgt
		And transaction "CHAQA-Transaction" has: BBDSrc = 2025/05/02
		And transaction "CHAQA-Transaction" has: BBDTgt = 2042/05/02
		And quantum "Qu" has: idTransaction = key:CHAQA-Transaction		    
		And quantum "Qu" has: BBD = 2042/05/02
	#Clean-Up
	Then delete quantum "Qu"	


	Scenario: IM.008-001-0002: CHAQA changes the BBD of a quantum to null
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	And for article = "40067114" typBdd is set to "NO_BBD"
	When CHAQA is used to change quantum "Qu" with BBD = null and GR-Date = 2042/05/02
		And CHAQA is called
		And CHAQA was successful; transaction saved as "CHAQA-Transaction"
	Then transaction "CHAQA-Transaction" has: typTransaction = "CHAQA"
		And transaction "CHAQA-Transaction" has equal idQuantumSrc and idQuantumTgt
		And transaction "CHAQA-Transaction" has: BBDSrc = 2025/05/02
		And transaction "CHAQA-Transaction" has: BBDTgt = null
		And quantum "Qu" has: idTransaction = key:CHAQA-Transaction
		And quantum "Qu" has: BBD = null
	#Clean-Up
	Then delete quantum "Qu"			
	Then for article = "40067114" typBdd is set to "QUANTUM"


	Scenario: IM.008-001-0003: CHAQA changes the BBD of a quantum from null to 2042/05/02
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	And for article = "40067005" typBdd is set to "QUANTUM"
	When CHAQA is used to change quantum "Qu" with BBD = 2042/05/02 
		When CHAQA is called
		Then CHAQA was successful; transaction saved as "CHAQA-Transaction"
	Then transaction "CHAQA-Transaction" has: typTransaction = "CHAQA"
		And transaction "CHAQA-Transaction" has equal idQuantumSrc and idQuantumTgt
		And transaction "CHAQA-Transaction" has: BBDSrc = null
		And transaction "CHAQA-Transaction" has: BBDTgt = 2042/05/02
		And quantum "Qu" has: idTransaction = key:CHAQA-Transaction
		And quantum "Qu" has: BBD = 2042/05/02
	#Clean-Up
	Then delete quantum "Qu"		
	And for article = "40067005" typBdd is set to "NO_BBD" 


	Scenario: IM.008-001-0004: CHAQA changes goods receiving, item and date of a given quantum
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 1, tsGoodsReceipt = 2025/05/02
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0002"-2
		And CHAQA is called
		And CHAQA was successful; transaction saved as "CHAQA-Transaction"	
	Then transaction "CHAQA-Transaction" has: typTransaction = "CHAQA"
		And transaction "CHAQA-Transaction" has equal idQuantumSrc and idQuantumTgt
		And transaction "CHAQA-Transaction" has: idGoodsReceiptSrc = "GR-0001", numGoodsReceiptItemSrc = 1
		And transaction "CHAQA-Transaction" has: idGoodsReceiptTgt = "GR-0002", numGoodsReceiptItemTgt = 2
		And transaction "CHAQA-Transaction" has: tsGoodsReceiptSrc = 2025/05/02
		And transaction "CHAQA-Transaction" has: tsGoodsReceiptTgt = 2042/05/02
		And quantum "Qu" has: goods receipt = "GR-0002"-2 and GR-Date = 2042/05/02
		And quantum "Qu" has: idTransaction = key:CHAQA-Transaction
	#Clean-Up
	Then delete quantum "Qu"


	Scenario: IM.008-001-0005: CHAQA changes goods receiving dates of a quantum with given reasons, references and key values
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0002"-2
		And CHAQA input has: reason1 = "IM.008-001-004", reason2 = "CHAQA"
		And CHAQA input has: typRef = "GI_ORDER", idRef1 = "REF-1", idRef2 = "REF-2", idRef3 = "REF-3", idRef4 = "REF-4", idRef5 = "REF-5", idRef6 = "REF-6"
		And CHAQA input has: clProcess = "DIALOG", typProcess = "IM400", stepProcess = "*", client = "RK1", bookingKey= "DEF" 
		And CHAQA is called
		And CHAQA was successful; transaction saved as "CHAQA-Transaction"
	Then transaction "CHAQA-Transaction" has equal idQuantumSrc and idQuantumTgt
		And transaction "CHAQA-Transaction" has: reason1 = "IM.008-001-004", reason2= "CHAQA"
		And transaction "CHAQA-Transaction" has: typRef = "GI_ORDER", idRef1 = "REF-1", idRef2 = "REF-2", idRef3 = "REF-3", idRef4 = "REF-4", idRef5 = "REF-5", idRef6 = "REF-6"
		And transaction "CHAQA-Transaction" has: situation = "IM400_DEF"
		And transaction "CHAQA-Transaction" has: idGoodsReceiptTgt = "GR-0002", numGoodsReceiptItemTgt = 2
		And transaction "CHAQA-Transaction" has: tsGoodsReceiptTgt = 2042/05/02
		And quantum "Qu" has: idTransaction = key:CHAQA-Transaction
		And quantum "Qu" has: goods receipt = "GR-0002"-2 and GR-Date = 2042/05/02
	#Clean-Up
	Then delete quantum "Qu"
	
	
	Scenario: IM.008-001-0006: CHAQA changes the projectspecific attributes of a quantum
	Given client "RK1" has the following attribute configuration
	| attribute1 | a01 | | DEF | 1 | 1 | 0 |  |
	| attribute2 | a02 | | DEF | 1 | 1 | 0 |  |
	| attribute3 | a03 |  | DEF | 1 | 1 | 0 |  |
	| attribute4 | a04 |  | DEF | 1 | 1 | 0 |  |
	| attribute5 | a05 |  | DEF | 1 | 1 | 0 |  |
	| attribute6 | a06 |  | DEF | 1 | 1 | 0 |  |
	| attribute7 | a07 |  | DEF | 1 | 1 | 0 |  |
	| attribute8 | a08 |  | DEF | 1 | 1 | 0 |  |
	| attribute9 | a09 |  | DEF | 1 | 1 | 0 |  |
	| attribute10 | a10 |  | DEF | 1 | 1 | 0 |  |
	| attribute11 | a11 |  | DEF | 1 | 1 | 0 |  |
	| attribute12 | a12 |  | DEF | 1 | 1 | 0 |  |
	| attribute13 | a13 |  | DEF | 1 | 1 | 0 |  |
	| attribute14 | a14 |  | DEF | 1 | 1 | 0 |  |
	| attribute15 | a15 |  | DEF | 1 | 1 | 0 |  |
	| attribute16 | a16 |  | DEF | 1 | 1 | 0 |  |
	| attribute17 | a17 |  | DEF | 1 | 1 | 0 |  |
	| attribute18 | a18 |  | DEF | 1 | 1 | 0 |  |
	| attribute19 | a19 |  | DEF | 1 | 1 | 0 |  |
	| attribute20 | a20 |  | DEF | 1 | 1 | 0 |  |
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067007" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"	
		And the CREQU input has attributes: "x01", "x02", "x03", "x04", "x05", "x06", "x07", "x08", "x09", "x10", "x11", "x12", "x13", "x14", "x15", "x16", "x17", "x18", "x19", "x20"	
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with attribute values: "a01", "a02", "a03", "a04", "a05", "a06", "a07", "a08", "a09", "a10", "a11", "a12", "a13", "a14", "a15", "a16", "a17", "a18", "a19", "a20"
		And CHAQA is called
		And CHAQA was successful; transaction saved as "CHAQA-Transaction"
	Then transaction "CHAQA-Transaction" has: typTransaction = "CHAQA"
		And transaction "CHAQA-Transaction" has: idQuantumTgt = key:Qu
		And transaction "CHAQA-Transaction" has: attributesSrc = "x01", "x02", "x03", "x04", "x05", "x06", "x07", "x08", "x09", "x10", "x11", "x12", "x13", "x14", "x15", "x16", "x17", "x18", "x19", "x20"
		And transaction "CHAQA-Transaction" has: attributesTgt = "a01", "a02", "a03", "a04", "a05", "a06", "a07", "a08", "a09", "a10", "a11", "a12", "a13", "a14", "a15", "a16", "a17", "a18", "a19", "a20"
		And quantum "Qu" has: attributes = "a01", "a02", "a03", "a04", "a05", "a06", "a07", "a08", "a09", "a10", "a11", "a12", "a13", "a14", "a15", "a16", "a17", "a18", "a19", "a20"
		And quantum "Qu" has: idTransaction = key:CHAQA-Transaction	
	#Clean-Up	  
		Then delete quantum "Qu"	
		Then delete attribute configuration for client "RK1"
