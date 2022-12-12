#Author: skaya@inconso.de
#Keywords Summary :
@inventory @stalu @defaultdatabased

Feature: IM.006-002: inventory/transaction/stalu - Inventory STALU SLAA
STALU with SLAA restriction

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

  Scenario: IM.006-002-0001: STALU fails, if the location with single article is not assigned to the selected article
  SLAA-0006: The storage location {0}/{1} with fixed location configuration is not assigned to article {2}/{3}.
   
    #Load unit 3
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "3"; transaction saved as "Transaction"
021000000173


		#Load unit 4
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "4"; transaction saved as "Transaction"
025000000174


    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.000 pieces of article "40067114" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And BBD is 2021/03/12 and batch is null
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "2"; transaction saved as "Transaction"

42000000037

    And the quantum "2" has to be booked to target load unit "4"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"


    And the load unit "4" has to be stacked on the load unit "3"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"
  	And the load unit "3" has to be booked to target location "H01-HRL"-"105-1-004-01" with transaction type RELLU
    When RELLU is called
   
    Then WEBSERVICE fails: error = "SLAA-0006"

		
		Scenario: IM.006-002-0002: STALU on location with single article where the selected article is assigned
	
    #Load unit 3
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "3"; transaction saved as "Transaction"
    #Load unit 4
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "4"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.000 pieces of article "40067005" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "4" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "2"; transaction saved as "Transaction"
    And the quantum "2" has to be booked to target load unit "4"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "4" has to be stacked on the load unit "3"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"
  	
    
    Scenario: IM.006-002-0003: STALU fails, if the fixed location is not assigned to the selected article
    SLAA-0006: The storage location {0}/{1} with fixed location configuration is not assigned to article {2}/{3}.
    #Load unit 1
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    #Load unit 2
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067114" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And BBD is 2022/03/12 and batch is null
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    And the quantum "1" has to be booked to target load unit "2"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "2" has to be stacked on the load unit "1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"
    And the load unit "1" has to be booked to target location "H01-HRL"-"105-1-006-01" with transaction type RELLU
    When RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"
    #Load unit 3
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "3"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.000 pieces of article "40067005" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "2"; transaction saved as "Transaction"
    And the quantum "2" has to be booked to target load unit "3"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "3" has to be stacked on the load unit "1"
    When STALU is called
    Then WEBSERVICE fails: error = "SLAA-0006"
    
    Scenario: IM.006-002-0004: STALU on fixed location where the two selected articles are assigned
    #Load unit 1
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    021000000215


    #Load unit 2
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    025000000216


    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.000 pieces of article "40067005" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    42000000039  



    And the quantum "1" has to be booked to target load unit "2"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"



    And the load unit "2" has to be stacked on the load unit "1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"



    And the load unit "1" has to be booked to target location "H01-HRL"-"105-1-007-01" with transaction type RELLU
    When RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"



    #Load unit 3
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "3"; transaction saved as "Transaction"
025000000220 


    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "2"; transaction saved as "Transaction"
    42000000040

    And the quantum "2" has to be booked to target load unit "3"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"



    And A record in SLAA100 for location "H01-HRL"-"105-1-007-01", "40067005", "1" has been created
    And A record in SLAA100 for location "H01-HRL"-"105-1-007-01", "40067024", "1" has been created

    
    And the load unit "3" has to be stacked on the load unit "1"
    When STALU is called
   Then STALU was successful; transaction saved as "Transaction"