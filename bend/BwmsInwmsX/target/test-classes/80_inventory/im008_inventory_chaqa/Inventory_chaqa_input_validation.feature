#Author: aaikharia@inconso.de
#Keywords Summary :
@inventory @chaqa @defaultdatabased


Feature: IM.008-002: inventory/transaction/chaqa - Inventory CHAQA input validation
		This feature file tests the input validation of the CHAQA booking (Change Quantum Attributes).	
		Different flawed inputs are entered and the resulting error message is verified.
				 
Background:
	Given set global: idSite = "RL1", idClient = "RK1"		


	Scenario: IM.008-002-0001: CHAQA fails, if the idSite is empty.
						BEND-0005: Field {0} must not be null
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"	
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0001"-1
		And CHAQA input has: idSite = null
		And CHAQA is called
	Then WEBSERVICE fails: error = "BEND-0005"	
	#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0002: CHAQA fails, if the clProcess (process class) is empty.
					BEND-0005: Field {0} must not be null
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0001"-1
		And CHAQA input has: clProcess = null
		And CHAQA is called
	Then WEBSERVICE fails: error = "BEND-0005"	
#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0003: CHAQA fails, if the typProcess is empty.
					BEND-0005: Field {0} must not be null
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0001"-1
		And CHAQA input has: typProcess = null
		And CHAQA is called
	Then WEBSERVICE fails: error = "BEND-0005"	
#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0004: CHAQA fails, if the stepProcess is empty.
					BEND-0005: Field {0} must not be null
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0001"-1
		And CHAQA input has: stepProcess = null
		And CHAQA is called
	Then WEBSERVICE fails: error = "BEND-0005"	
#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0005: CHAQA fails, if the booking key is empty.
					BEND-0005: Field {0} must not be null
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"	
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0001"-1
		And CHAQA input has: bookingKey = null
		And CHAQA is called
	Then WEBSERVICE fails: error = "BEND-0005"	
#Clean-Up
	Then delete quantum "Qu"
						
Scenario: IM.008-002-0006: CHAQA fails, if the idQuantum is empty.
						BEND-0005: Field {0} must not be null
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"	
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0001"-1
		And CHAQA input has: idQuantum = null
		And CHAQA is called
	Then WEBSERVICE fails: error = "BEND-0005"	
#Clean-Up
	Then delete quantum "Qu"
						
						
Scenario: IM.008-002-0007: CHAQA fails, if the idUser is empty.
					BEND-0005: Field {0} must not be null
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"	
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0001"-1
		And CHAQA input has: idUser = null
		And CHAQA is called
	Then WEBSERVICE fails: error = "BEND-0005"	
#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0008: CHAQA fails, if combination of reference type and IDs is not correctly filled.	
					if no reference type is set, but  	 from idRef1 to idRef6 is filled
					if idRef = GI_ORDER and idRef1 = null but the other idRefs are filled
					if idRef = ABC (idRef1-6 irrelevant)
					BWM-0008: Combination reference type and id not correctly filled: if type is filled at least one id must be filled, too.	
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0001"-1
		And CHAQA input has: typRef = <typ-ref>, idRef1 = <id-ref-1>, idRef2 = <id-ref-2>, idRef3 = <id-ref-3>, idRef4 = <id-ref-4>, idRef5 = <id-ref-5>, idRef6 = <id-ref-6>
		And CHAQA is called
	Then WEBSERVICE fails: error = "BWM-0008"
#Clean-Up
	Then delete quantum "Qu"	

	Examples: 
		| typ-ref    | id-ref-1| id-ref-2 | id-ref-3   |id-ref-4 |id-ref-5 |id-ref-6 |
		| ""         |  "1"  	 | ""       | ""       | ""      | ""      | ""      |
		| ""         |  ""  	 | "2"      | ""       | ""      | ""      | ""      |
		| ""         |  ""  	 | ""       | "3"      | ""      | ""      | ""      |
		| ""         |  ""   	 | ""       | ""       | "4"     | ""      | ""      |
		| ""         |  ""   	 | ""       | ""       | ""      | "5"     | ""      |
		| ""         |  ""   	 | ""       | ""       | ""      | ""      | "6"     |
		| "GI_ORDER" | ""        | "12345"  | "15248"  | "25174" | "15682" | "25863" |
		| "ABC"  	 | ""        | ""       | ""       | ""      | ""      | ""      |	


Scenario: IM.008-002-0009: CHAQA fails, if no situation can be determined (IM010) by its parameters meaning the class-type-step-process combination is invalid.
					IM-0032: No situation can be determined by parameters: transaction type {0}, process class {1}, process type {2}, process step {3}, client {4}, key {5}
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0001"-1
		And CHAQA input has: typProcess = "ABC"
		And CHAQA is called
	Then WEBSERVICE fails: error = "IM-0032"	
#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0010: CHAQA fails, if the attribute values are all empty.
					IM-0043: No data entered!	
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = null and GR = ""-null
		And CHAQA is used to change quantum "Qu" with BBD = null
		And CHAQA is called
	Then WEBSERVICE fails: error = "IM-0043"
#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0011:  CHAQA fails, if GR-item (Gr-item) is filled and idGr (ID goods receipt) is NOT
					IM-0044: GR data must both be filled or both be empty!
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = ""-1
		And CHAQA is called
		And WEBSERVICE fails: error = "IM-0044"	
#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0012: CHAQA fails, if GR-item (Gr-item) is NOT filled and idGr (ID goods receipt) is filled.
					IM-0044: GR data must both be filled or both be empty!
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU input has: goodsReceipt = "GR-0001", goodsReceiptItem = 1, tsGoodsReceipt = 2019/03/01
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2025/05/02 and GR = "GR-0002"-null	
		When CHAQA is called
	Then WEBSERVICE fails: error = "IM-0044"	
#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0013: CHAQA fails, if BBD has to be set for article collegeblock, which is NOT configured with BBD.
					BM-0002: You must not change ts bbd of quantum {0}/{1}
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with BBD = 2025/05/02
		And CHAQA is called
	Then WEBSERVICE fails: error = "BM-0002"
#Clean-Up
	Then delete quantum "Qu"


Scenario: IM.008-002-0014: CHAQA fails, if BBD is empty for an article that requires BBD
					IM-0016: Article {0}/{1} is configured with BBD management, but "best before date" is empty!
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	When CHAQA is used to change quantum "Qu" with BBD = null and GR-Date = 2042/05/02
		And CHAQA is called
	Then WEBSERVICE fails: error = "IM-0016"
#Clean-Up
	Then delete quantum "Qu"	


Scenario: IM.008-002-0015: CHAQA fails, if the quantum is blocked for stocktaking
					STM-0027: Quantum {0}/{1} is locked: the flag stock taking is set, booking not possible!
	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067114" has to be created
		And the target location is "H01-KLAER"-"K-101"
		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
		And BBD is 2025/05/02 and batch is null
		And CREQU is called
		And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"  
		And set quantum "Qu" flag stock taking = "1"
	When CHAQA is used to change quantum "Qu" with GR-Date = 2042/05/02 and GR = "GR-0002"-2
		And CHAQA is called
	Then WEBSERVICE fails: error = "STM-0027"
#Clean-Up
	Then delete quantum "Qu"
