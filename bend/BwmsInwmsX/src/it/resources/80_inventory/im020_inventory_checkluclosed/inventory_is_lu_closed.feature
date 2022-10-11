#Author: michael.nkongho@koerber-supplychain.com
#Keywords Summary :

#Update tags
@inventory @LU_CLOSED @defaultdatabased
#Update naming
Feature: IM.020-001: inventory/isLuClosed - Checks on load unit type for closed, not closed or not exist
Returns true if load unit type is closed, otherwise false.
				Throws an exception if the load unit type does not exist.

 Background:
    Given set global: idSite = "RL1", idClient = "RK1"


 Scenario Outline: IM.020-001-001: Check if LU_CLOSED returns true when load unit is closed
   
   When LU_CLOSED is called with <Lu-Type> to check for closed load units should return <result>
    Examples: 
      | Lu-Type  | result |  
      | "EUKAB"  |  "true"|
      | "GBOX"   |  "true"|
      | "LBOX1"  |  "true"|
      | "LBOX2"  |  "true"|
      | "LBOX3"  |  "true"|
      | "VBOX1"  |  "true"|
      | "VBOX2"  |  "true"|
      | "VIRTLU" |  "true"|
      
      
   
  Scenario Outline: IM.020-001-002: Verify that LU_CLOSED returns false when load unit is not closed
   
   When LU_CLOSED is called with <Lu-Type1> to check for not closed load units should return <result1>
    Examples: 
      | Lu-Type1  | result1  |
      | "EURO"   | "false" |  
      | "INDU"   | "false"   | 
      
      
    Scenario Outline: IM.020-001-003: Verify that LU_CLOSED throus an error if load unit type doesnot exist
      
   
   Scenario Outline: IM.020-001-003: Verify that LU_CLOSED returns an exception when lu type doesnot exist
   
   When LU_CLOSED is called with <Lu-Type2> should return <exception-id>
    Examples: 
      | Lu-Type2 | exception-id|
      | "xxx"   | "BEN-0010"  |  
  
     
