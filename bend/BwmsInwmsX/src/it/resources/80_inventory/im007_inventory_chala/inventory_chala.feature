#Author: aaikharia@inconso.de
#Keywords Summary :
@inventory @chala @defaultdatabased


Feature: IM.007-001: inventory/transaction/chala - Inventory CHALA
		This feature file tests the main purpose of the CHALA booking (CHAnges Load unit Attributes). 
		The SSCC (Serial Shipping Container Code) and the height of a given load unit are modified.

Background:
    				Given set global: idSite = "RL1", idClient = "RK1"
# --------------------------------------1---------------------------------------

Scenario: 	IM.007-001-0001: CHALA changes SSCC & height of a load unit.
 									
						Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created				
	 					  And the load unit type is "EURO" 						
					    And the CRELU input has: SSCC = "01200000000000000015"
					    And the CRELU input has: height = 99
					    When CRELU is called
	 					  Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
	 					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000
	 					  When CHALA is called
					    Then CHALA was successful; transaction saved as "CHALA Transaction"	
					  Then reload load unit "Lu"		
					    And transaction "CHALA Transaction" has: ssccSrc = "01200000000000000015"
					    And transaction "CHALA Transaction" has: heightSrc = 99.000    
					    And transaction "CHALA Transaction" has: ssccTgt = "01200000000000000012"
					    And transaction "CHALA Transaction" has: heightTgt = 50.000
					    And load unit "Lu" has SSCC "01200000000000000012" 
					    And load unit "Lu" has height 50.000
					  Then delete load unit "Lu"
# --------------------------------------2---------------------------------------

Scenario: IM.007-001-0002: CHALA changes only height of a load unit.
					
						Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created	
					    And the load unit type is "EURO"
					    And the CRELU input has: SSCC = "01200000000000000015"
					    And the CRELU input has: height = 99
					    When CRELU is called
 					    Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
 					    When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000015" and height = 50.000			  
					    When CHALA is called 
					    Then CHALA was successful; transaction saved as "CHALA Transaction"
					  Then reload load unit "Lu"	
					    And transaction "CHALA Transaction" has: ssccSrc = "01200000000000000015"
					    And transaction "CHALA Transaction" has: heightSrc = 99.000    
					    And transaction "CHALA Transaction" has: ssccTgt = "01200000000000000015"
					    And transaction "CHALA Transaction" has: heightTgt = 50.000
					    And load unit "Lu" has SSCC "01200000000000000015" 
					    And load unit "Lu" has height 50.000
					  Then delete load unit "Lu"			  
					
# --------------------------------------3---------------------------------------
		 
Scenario: IM.007-001-0003: CHALA changes only SSCC of a load unit.
					
					  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created	
					    And the load unit type is "EURO"
					    And the CRELU input has: SSCC = "01200000000000000015"
					    And the CRELU input has: height = 99
					    When CRELU is called
 					    Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction "
 					 When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = null
					    When CHALA is called
					    Then CHALA was successful; transaction saved as "CHALA Transaction"
					  Then reload load unit "Lu"	
					    And transaction "CHALA Transaction" has: ssccSrc = "01200000000000000015"
					    And transaction "CHALA Transaction" has: heightSrc = 99.000    
					    And transaction "CHALA Transaction" has: ssccTgt = "01200000000000000012"
					    And transaction "CHALA Transaction" has: heightTgt = 99.000
					    And load unit "Lu" has SSCC "01200000000000000012" 
					    And load unit "Lu" has height 99.000
					  Then delete load unit "Lu"				 
						   
# -------------------------------------4----------------------------------------	
	
Scenario: IM.007-001-0004: CHALA changes load unit attributes and transaction with given reasons, references and key values
						
					Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-LEER"-"L-101" has to be created	
						And the load unit type is "EURO"
						And the CRELU input has: SSCC = "01200000000000000015"
						And the CRELU input has: height = 99
						When CRELU is called
						Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
					When CHALA is used to change load unit "Lu" with SSCC = "01200000000000000012" and height = 50.000
						And CHALA input has: reason1 = "IM.007-001-005", reason2 = "CHALA"
						And CHALA input has: typRef = "GI_ORDER", idRef1 = "REF-1", idRef2 = "REF-2", idRef3 = "REF-3", idRef4 = "REF-4", idRef5 = "REF-5", idRef6 = "REF-6"
						And CHALA input has: clProcess = "DIALOG", typProcess = "IM400", stepProcess = "*", client = "*", bookingKey= "DEF" 
						When CHALA is called
				    	Then CHALA was successful; transaction saved as "CHALA Transaction"
				    Then reload load unit "Lu"	
				   		And transaction "CHALA Transaction" has: reason1 = "IM.007-001-005", reason2= "CHALA"			    
				   		And transaction "CHALA Transaction" has: typRef = "GI_ORDER", idRef1 = "REF-1", idRef2 = "REF-2", idRef3 = "REF-3", idRef4 = "REF-4", idRef5 = "REF-5", idRef6 = "REF-6"
						And transaction "CHALA Transaction" has: situation = "IM400_DEF"
						Then delete load unit "Lu" 