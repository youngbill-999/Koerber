#Author: skaya@inconso.de
#Keywords Summary :
@inventory @relqu @defaultdatabased

Feature: IM.004-001: inventory/transaction/relqu - Inventory - RELQU Input Validation

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario Outline: IM.004-001-0001: RELQU fails if reference type and reference ID do not match.
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
      | typ-ref  | id-ref-1  | id-ref-2 |
      | "EURO"   |  ""  	 	 | ""       |
      | ""  	   | "RL1"  	 |  "12345" |
      
      
  Scenario: IM.004-001-0002: RELQU fails, if no suitable situation (IM010) can be determined
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
  		And the target location is "H01-FACH"-"106-2-007-02"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
    	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
    	And the quantum "Qu" has to be booked to location "SENKE-LAG"-"S-001"
    	And the situation parameters for RELQU are: creQu = key:Qu, clProcess = "DIALOG", typProcess = "TEST", stepProcess = "*"
 		When RELQU is called
 		Then WEBSERVICE fails: error = "IM-0032"
 		

	Scenario: IM.004-001-0003: RELQU fails, if target location is empty
		IM-0802: The target storage area has to be filled!
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067005" has to be created
  		And the target location is "H01-FACH"-"106-2-007-02"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
    	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
# -----------------------------------------------------------------------------
		Given the quantum "Qu" has to be booked to location ""-""
		When RELQU is called
		Then WEBSERVICE fails: error = "IM-0802"

 		
 	Scenario: IM.004-001-0004: RELQU fails, if quantum ID is empty.
 		IM:0806: The quantum Id has to be filled!
  	Given the input with empty quantum ID has to be booked to location "SENKE-LAG"-"S-001"
		When RELQU is called
    Then WEBSERVICE fails: error = "IM-0806"
 			

	Scenario: IM.004-001-0005: RELQU fails, if target load unit is empty
		IM-0802: The target storage area has to be filled!
		Given the input without target load unit for transaction type RELQU
		When RELQU is called
		Then WEBSERVICE fails: error = "IM-0802"

		
	Scenario: IM.004-001-0006: RELQU fails, if target location and target load unit are filled
		Given the input with quantum ID "42000000041", target location "H01-FACH"-"106-2-007-02" and load unit "012000000042"
		When RELQU is called
		Then WEBSERVICE fails: error = "IM-0046"