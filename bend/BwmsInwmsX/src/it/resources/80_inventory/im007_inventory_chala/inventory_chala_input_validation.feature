#Author: aaikharia@inconso.de
#Keywords Summary :
@inventory @chala @defaultdatabased

Feature: IM.007-002: inventory/transaction/chala - Inventory CHALA input validation
		This feature file tests the input validation of the CHALA booking (CHAnge Load unit Attribute).	
		Different flawed inputs are entered and the resulting error message is verified.
				 
  Background:
    				Given set global: idSite = "RL1", idClient = "RK1"		
			  				
# ---------------------------------------1---------------------------------------------------------------  

Scenario: IM.007-002-0001: CHALA fails, if the idSite is empty.
					BEND-0005: Field {0} must not be null
				
					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000 
						And CHALA input has: idSite = null
						When CHALA is called
						Then WEBSERVICE fails: error = "BEND-0005"	
						Then delete load unit "Lu"

# ---------------------------------------2--------------------------------------  

Scenario: IM.007-002-0002: CHALA fails, if the clProcess (process class) is empty.
					BEND-0005: Field {0} must not be null
					
					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000 
						And CHALA input has: clProcess = null
						When CHALA is called
					Then WEBSERVICE fails: error = "BEND-0005"	
					Then delete load unit "Lu"

# ---------------------------------------3--------------------------------------  			

Scenario: IM.007-002-0003: CHALA fails, if the typProcess is empty.
					BEND-0005: Field {0} must not be null

					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000 					
						And CHALA input has: typProcess = null
						When CHALA is called
					Then WEBSERVICE fails: error = "BEND-0005"
					Then delete load unit "Lu"		

# ---------------------------------------4-------------------------------------- 	

Scenario: IM.007-002-0004: CHALA fails, if the stepProcess is empty.
					BEND-0005: Field {0} must not be null

					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000 
						And CHALA input has: stepProcess = null
						When CHALA is called
					Then WEBSERVICE fails: error = "BEND-0005"	
					Then delete load unit "Lu"

# ---------------------------------------5-------------------------------------- 	

Scenario: IM.007-002-0005: CHALA fails, if the booking key is empty.
					BEND-0005: Field {0} must not be null

					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
						When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000 
						And CHALA input has: bookingKey = null
						When CHALA is called
					Then WEBSERVICE fails: error = "BEND-0005"	
					Then delete load unit "Lu"

# ---------------------------------------6-------------------------------------- 	

Scenario: IM.007-002-0006: CHALA fails, if idLu is empty.
					BEND-0005: Field {0} must not be null

					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000
					And CHALA input has: idLu = null
						When CHALA is called
					Then WEBSERVICE fails: error = "BEND-0005"	
					Then delete load unit "Lu"

# ---------------------------------------7-------------------------------------- 	

Scenario: IM.007-002-0007: CHALA fails, if idUser is empty.
					BEND-0005: Field {0} must not be null

					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000 
						And CHALA input has: idUser = null
						When CHALA is called
					Then WEBSERVICE fails: error = "BEND-0005"
					Then delete load unit "Lu"

# ---------------------------------------8------------------------------------- 	

Scenario: IM.007-002-0008: CHALA fails, if combination of reference type and IDs is not correctly filled.

					if no reference type is set, but  	 from idRef1 to idRef6 is filled
					if idRef = GI_ORDER and idRef1 = null but the other idRefs are filled
					if idRef = ABC (idRef1-6 irrelevant)
				
					BWM-0008: Combination reference type and id not correctly filled: if type is filled at least one Id must be filled, too.

					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000
						And CHALA input has: typRef = <typ-ref>, idRef1 = <id-ref-1>, idRef2 = <id-ref-2>, idRef3 = <id-ref-3>, idRef4 = <id-ref-4>, idRef5 = <id-ref-5>, idRef6 = <id-ref-6>
						And CHALA is called
					Then WEBSERVICE fails: error = "BWM-0008"
					Then delete load unit "Lu"
					Examples: 
								| typ-ref    | id-ref-1| id-ref-2 | id-ref-3 |id-ref-4 |id-ref-5 |id-ref-6 |
								| ""         |  "1"  	 | ""       | ""       | ""      | ""      | ""      |
								| ""         |  ""  	 | "2"      | ""       | ""      | ""      | ""      |
								| ""         |  ""  	 | ""       | "3"      | ""      | ""      | ""      |
								| ""         |  ""   	 | ""       | ""       | "4"     | ""      | ""      |
								| ""         |  ""   	 | ""       | ""       | ""      | "5"     | ""      |
								| ""         |  ""   	 | ""       | ""       | ""      | ""      | "6"     |
								| "GI_ORDER" | ""        | "12345"  | "15248"  | "25174" | "15682" | "25863" |
								| "ABC"  	 | ""        | ""       | ""       | ""      | ""      | ""      |

# ---------------------------------------9-------------------------------------- 	

Scenario: IM.007-002-0009: CHALA fails, if no situation can be determined (IM010) by its parameters meaning the class-type-step-process combination is invalid.
					IM-0032: No situation can be determined by parameters: transaction type {0}, process class {1}, process type {2}, process step {3}, client {4}, key {5}

					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000
						And CHALA input has: typProcess = "ABC"
						And CHALA is called
					Then WEBSERVICE fails: error = "IM-0032"
					Then delete load unit "Lu"

# ---------------------------------------10-------------------------------------- 	

Scenario: IM.007-002-0010: CHALA fails, if no attribute value is entered.
					IM-0041: For changing LU attributes you must enter at least one attribute value
		
					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						And the CRELU input has: SSCC = "01200000000000000015"
						And the CRELU input has: height = 55.000
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = null and height = null
						And CHALA input has: SSCC = null
						And CHALA input has: height = null					
						Then CHALA is called
					Then WEBSERVICE fails: error = "IM-0041"
					Then delete load unit "Lu"	

# ---------------------------------------11-------------------------------------- 	

Scenario: IM.007-002-0011: CHALA fails, if load unit is locked. Booking is not possible.
					STM-0026: LU Type {0}/{1} is locked: the flag stock taking is set, booking not possible!
	
					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
						And set load unit "Lu" flag stock taking = "1"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000
						Then CHALA is called
					Then WEBSERVICE fails: error = "STM-0026"
					Then delete load unit "Lu"	 

# ---------------------------------------12--------------------------------------  

Scenario: IM.007-002-0012: CHALA fails, if the target Load unit is in transit.
					IM-0023: The target load unit {0} must not be in transit!

					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created
						And the load unit type is "EURO"
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
						And set load unit "Lu" flag transit = "1"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000						   					   
						When CHALA is called
					Then WEBSERVICE fails: error = "IM-0023"
					Then delete load unit "Lu"
