#Author: skaya@inconso.de

@inventory @corst @defaultdatabased 
Feature:  IM.001-003: inventory/transaction/corst - Inventory CORST Without load unit
	
  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

	
  Scenario: IM.001-003-0001: CORST increases available quantity of given quantum
  	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
  		And the target location is "H01-FACH"-"106-2-001-02"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And verify that the remaining weight of location "H01-FACH"-"106-2-001-02" is 39200.00
 			And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "INCREASE" by 5.000 pieces with location "QUELLE-LAG"-"Q-001"
 			And the CORST reasons are "Reason 1" and "Reason 2"
    When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
    	And transaction "Transaction" moved 5.000 pieces from "QUELLE-LAG"-"Q-001" to "H01-FACH"-"106-2-001-02" to increase the available quantity
    	And transaction "Transaction" has: reasonTransaction1 = "Reason 1", reasonTransaction2 = "Reason 2"
    	And reload quantum "Qu"
    	And quantum "Qu" has available quantity 25.000
    	And transaction "Transaction" has: situation = "IM400"
    	And transaction "Transaction" has: stat = "90"
      And transaction "Transaction" has: typQuantity = "AVAILABLE"
    	And verify that the remaining weight of location "H01-FACH"-"106-2-001-02" is 36500.00
    #Clean-Up:
    Then delete quantum "Qu"
    	
    			
			
	Scenario: IM.001-003-0002: CORST increases reserved quantitiy of given quantum
		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 30.0 pieces of article "40067007" has to be created
			And the target location is "H01-FACH"-"106-2-001-06"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 30.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
 			And RESST was successful; transaction saved as "Transaction"
 			And verify that the remaining weight of location "H01-FACH"-"106-2-001-06" is 44270.00
 			And the "RESERVED" quantity of the quantum "Qu" has to be changed with correction type "INCREASE" by 5.000 pieces with location "QUELLE-LAG"-"Q-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
    	And reload quantum "Qu"
    	And quantum "Qu" has available quantity 0.0
    	And quantum "Qu" has reserved quantity 35.000
    	And transaction "Transaction" has: typQuantity = "RESERVED"
    	And verify that the remaining weight of location "H01-FACH"-"106-2-001-06" is 43315.00
    #Clean-Up:
    Then delete quantum "Qu"
  
    		
  Scenario: IM.001-003-0003: CORST decreases available quantity of given quantum
   	Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 15.0 pieces of article "40067005" has to be created
			And the target location is "H01-FACH"-"106-2-013-04"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
     	And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
     	And verify that the remaining weight of location "H01-FACH"-"106-2-013-04" is 41900.00
     	And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 5.000 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
    	And reload quantum "Qu"
     	And quantum "Qu" has available quantity 10.000
     	And transaction "Transaction" has: typQuantity = "AVAILABLE"
     	And verify that the remaining weight of location "H01-FACH"-"106-2-013-04" is 44600.00
    #Clean-Up:
    Then delete quantum "Qu"
 				
 				
 	Scenario: IM.001-003-0004: CORST decreases reserved quantity of given quantum
 		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 30.0 pieces of article "40067007" has to be created
			And the target location is "H01-FACH"-"106-2-013-05"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"	
 			And 30.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
 			And RESST was successful; transaction saved as "Transaction"
 			And verify that the remaining weight of location "H01-FACH"-"106-2-013-05" is 44270.00
 			And the "RESERVED" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 5.000 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
    	And reload quantum "Qu"
 			And quantum "Qu" has available quantity 0.0
 			And quantum "Qu" has reserved quantity 25.000
 			And transaction "Transaction" has: typQuantity = "RESERVED"
 			And verify that the remaining weight of location "H01-FACH"-"106-2-013-05" is 45225.00	
 	  #Clean-Up:
    Then delete quantum "Qu"
 				
 				
 	Scenario: IM.001-003-0005: RESST reserves amount of available quantity and the rest of available quantity will be booked with CORST by correction type DECREASE
 		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 30.0 pieces of article "40067022" has to be created
			And the target location is "H01-FACH"-"106-2-014-01"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And create batch "KS12345" for idArticle = "40067022" saved as "BatchDessert[0]" with tsBbd null
    	And BBD is 2020/01/01 and batch is "BatchDessert[0]"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 25.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
 			And RESST was successful; transaction saved as "Transaction"
 			And verify that the remaining weight of location "H01-FACH"-"106-2-014-01" is 37850.00
 			And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 5.000 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
			And reload quantum "Qu"
 			And quantum "Qu" has available quantity 0.0
 			And quantum "Qu" has reserved quantity 25.0
 			And transaction "Transaction" has: typQuantity = "AVAILABLE"
 			And verify that the remaining weight of location "H01-FACH"-"106-2-014-01" is 39875.00
 		#Clean-Up:
    Then delete quantum "Qu"
 			
 			
 	Scenario: IM.001-003-0006: RESST reserves amount of available quantity and will be booked with CORST by correction type DECREASE
 		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 45.0 pieces of article "40067005" has to be created
			And the target location is "H01-FACH"-"106-2-014-02"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
			And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 32.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
 			And RESST was successful; transaction saved as "Transaction"
 			And verify that the remaining weight of location "H01-FACH"-"106-2-014-02" is 25700.00
 			And the "RESERVED" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 32.0 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
			And reload quantum "Qu"
			And quantum "Qu" has available quantity 13.0
			And quantum "Qu" has reserved quantity 0.0
 			And transaction "Transaction" has: typQuantity = "RESERVED"
    	And verify that the remaining weight of location "H01-FACH"-"106-2-014-02" is 42980.00
    #Clean-Up:
    Then delete quantum "Qu"   
    	
  Scenario: IM.001-003-0007: Location with available quantity will be booked to zero by CORST with correction type DECREASE and leaves location empty 
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 27.0 pieces of article "40067007" has to be created
			And the target location is "H01-FACH"-"106-2-014-05"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
			And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And verify that the remaining weight of location "H01-FACH"-"106-2-014-05" is 44843.00
 			And the "AVAILABLE" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 27.000 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
 			And transaction "Transaction" has: typQuantity = "AVAILABLE"
 			And reload quantum "Qu"
 			And verify quantum "Qu" is deleted
 			And location "H01-FACH"-"106-2-014-05" is empty
 			And verify that the remaining weight of location "H01-FACH"-"106-2-014-05" is 50000.00

 			
 	Scenario: IM.001-003-0008: Location with reserved quantity will be booked to zero by CORST with correction type DECREASE and leaves location empty 
 		Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 41.0 pieces of article "40067005" has to be created
			And the target location is "H01-FACH"-"106-2-014-06"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
			And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And 41.0 pieces of quantum "Qu" have to be reserved
 			And RESST is called
  		And RESST was successful; transaction saved as "Transaction"
  		And verify that the remaining weight of location "H01-FACH"-"106-2-014-06" is 27860.00
 			And the "RESERVED" quantity of the quantum "Qu" has to be changed with correction type "DECREASE" by 41.000 pieces with location "SENKE-LAG"-"S-001"
 		When CORST is called
    Then CORST was successful; transaction saved as "Transaction"
 			And transaction "Transaction" has: typQuantity = "RESERVED"
 			And reload quantum "Qu"
 			And verify quantum "Qu" is deleted
 			And location "H01-FACH"-"106-2-014-06" is empty
 			And verify that the remaining weight of location "H01-FACH"-"106-2-014-06" is 50000.00
