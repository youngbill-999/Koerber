#Author: anruppel@inconso.de
#Keywords Summary :
@inventory @crequ @defaultdatabased
Feature: IM.003-001: inventory/transaction/crequ - Inventory CREQU Input Validation

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

   	
 Scenario Outline: IM.003-001-0001: CREQU fails if reference type and reference ID do not match.
  	If no reference type, but reference IDs are set, the error "BWM-0008" is thrown.
 	If a reference type, but no reference IDs are set, the error "BWM-0008" is thrown.
 	BWM-0008: Combination reference type and id not correctly filled: if type is filled at least one id must be filled, too.
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 	And the CREQU reference type is <typ-ref> with id <id-ref-1>-<id-ref-2>
   	When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0008"
 	    Examples: 
      | typ-ref  | id-ref-1    | id-ref-2|
      | "EURO"   |  ""  	   | ""      |
      | ""  	 | "RL1"	   |  "12345"|
      
      
Scenario: IM.003-001-0002: CREQU fails, if no suitable situation (IM010) can be determined.
 	IM-0032: No situation can be determined by parameters: Process class {}, Process type {}, Process step {}, Client {}, Key {}
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU situation parameters are "DIALOG", "TEST", "*"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0032"
 	
Scenario: IM.003-001-0002: CREQU fails, if client is missing
 	IM-0817: The client has to be filled!
 	Given set global: idSite = "RL1", idClient = ""
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0817"
 	
 Scenario: IM.003-001-0003: CREQU fails, if client does not exist
 	BWM-0003: Invalid idClient "ABC" - no data found! 
 	Given set global: idSite = "RL1", idClient = "ABC"
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0003"
 	
Scenario: IM.003-001-0004: CREQU fails, if sep crit not configured for client is set
 	BWM-0006: Separation criterium HUGO is not configured in client, input not allowed!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the sep crit 10 is "HUGO"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0006"

@rk1_sepcrit1_regexp_number 	
Scenario: IM.003-001-0005: CREQU fails, if sep crit does not match the reg exp
 	BWM-0005:Invalid value for separation criterium SAPP: LETTERS fails validation against ^[0-9]*$!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the sep crit 1 is "LETTERS"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0005"
 	
@rk1_sepcrit1_no_default 	
Scenario: IM.003-001-0006: CREQU fails, if sep crit is null and has no default
 	BWM-0004: Invalid separation criterium, no value for SAPP!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0004"
 		
Scenario: IM.003-001-0007: CREQU fails, if article is missing
 	IM-0818: The article has to be filled!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0818"
 	
Scenario: IM.003-001-0008: CREQU fails, if article does not exist
 	ART-0001: Article RK1/123 not found!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "123" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "ART-0001"

@rk1_collegeblock_inactive	
Scenario: IM.003-001-0009: CREQU fails, if article is inactive
	IM-0017: Article RK1/40067005 in wrong state: should be 10, but was 90!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0017"
 	
Scenario: IM.003-001-0010: CREQU fails, if article needs batch and no batch is set
 	IM-0015: Article RK1/40067022 is configured with lot management, but lot is empty!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067022" has to be created
   	And the target location is "H01-FACH"-"106-2-001-0"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And BBD is 2020/01/01 and batch is ""
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0015"
 	
Scenario: IM.003-001-0011: CREQU fails, if article needs bbd and no bbd is set
 	IM-0016: Article RK1/40067022 is configured with BBD management, but "best before date" is empty!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067022" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And create batch "123456" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
   	And BBD is null and batch is "BatchDessert[0]"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0016"

Scenario: IM.003-001-0012: CREQU fails, if quantity is missing
 	IM-0809: The quantity has to be filled!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with no pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0809"

Scenario: IM.003-001-0013: CREQU fails, if quantity is 0
 	IM-0810: The quantity must be greater than 0!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 0.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0810"

Scenario: IM.003-001-0014: CREQU fails, if source location is missing.
 	IM-0800: The source storage area has to be filled!
 	Given a quantum from storage location ""-"" with 20.0 pieces of article "40067005" has to be created
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0800"
 	
Scenario: IM.003-001-0015: CREQU fails, if target location and target load unit are missing.
 	IM-0802: The target storage area has to be filled!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0802"

Scenario: IM.003-001-0016: CREQU fails, if target location and target load unit are set.
 	IM-0046: when a target LU is entered the fiel 'Target Location' must be empty!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And the target load unit is "12345678"	
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0046"
 	
Scenario: IM.003-001-0017: CREQU fails, if artvar does not exist
 	IM-0024: Artvar 99 of Article 99/RK1 not found!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "99" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the target location is "H01-FACH"-"106-2-001-06"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0024"
 	
Scenario: IM.003-001-0018: CREQU fails, if stock type does not exist
 	BWM-0002: Invalid value NOT_EXISTING for list IM_TYP_STOCK!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "99" and stock type is "NOT_EXISTING" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the target location is "H01-FACH"-"106-2-001-06"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0002"

Scenario: IM.003-001-0019: CREQU fails, if lock type does not exist
 	BWM-0002: Invalid value NOT_EXISTING for list IM_TYP_LOCK!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "99" and stock type is "AV" and lock type is "NOT_EXISTING" and QC status is "00" and customs status is "00"
   	And the target location is "H01-FACH"-"106-2-001-06"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0002"
 	
 Scenario: IM.003-001-0020: CREQU fails, if qc status does not exist
 	BWM-0002: Invalid value NOT_EXISTING for list IM_STAT_QC!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "99" and stock type is "AV" and lock type is "------" and QC status is "XX" and customs status is "00"
   	And the target location is "H01-FACH"-"106-2-001-06"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0002"
 	
Scenario: IM.003-001-0021: CREQU fails, if customs status does not exist
 	BWM-0002: Invalid value XX for list IM_STAT_CUSTOMS!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "99" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "XX"
   	And the target location is "H01-FACH"-"106-2-001-06"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "BWM-0002"
 	
Scenario Outline: IM.003-001-0022: CREQU fails, if special stock type and ID mismatch
 	IM-0013: Invalid data: Special stock type or id are empty: CUST / !
 	IM-0013: Invalid data: Special stock type or id are empty:  / 123456! 
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "99" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the target location is "H01-FACH"-"106-2-001-06"
   	And special stock type is <typ-special-stock> and ID special stock is <id-special-stock>
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0013"
 	 	    Examples: 
      | typ-special-stock  | id-special-stock    	| 
      | "CUST"   		   |  ""  	   				|
      | ""				   | "123456"				| 

 Scenario: IM.003-001-0023: CREQU fails, if source location is not configured as SOURCE.
 	IM-0061: The type of the storage area RL1/H01-KLAER is not configured as SOURCE!
 	Given a quantum from storage location "H01-KLAER"-"K-101" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the target location is "H01-FACH"-"106-2-001-06"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0061"
 	
Scenario: IM.003-001-0024: CREQU fails, if target location has no quantum management.
 	IM-0012: Storage area RL1/QUELLE-LAG should be configured with quantum management!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the target location is "QUELLE-LAG"-"Q-001"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0012"
 	
Scenario: IM.003-001-0025: CREQU fails, if target load unit does not exist.
 	IM-0018: Load unit RL1/12345678 not found!
 	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
   	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   	And the target load unit is "12345678"
 		When CREQU is called
 	Then WEBSERVICE fails: error = "IM-0018"
      