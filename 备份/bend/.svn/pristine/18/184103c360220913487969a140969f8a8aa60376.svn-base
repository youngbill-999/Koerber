#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :

@inventory @LU_CODED @defaultdatabased
Feature: IM.019-001: inventory/isLuCoded - Checks on load unit type for coded ID

				Returns true if load unit type is configured with coded ID, otherwise false.
				Throws an exception if the load unit type does not exist.
  
  Background:
      Given set global: idSite = "RL1", idClient = "RK1"

  Scenario Outline: IM.019-001-001: LU_CODED returns true for load unit type with coded ID (dialog IM040). 
  For every CRELU the load unit ID has to be entered.
   
When LU_CODED is called with <Lu-Type> should return <result>
    Examples: 
      | Lu-Type  | result |
      | "EINWEG" | "true" |
      | "INDU"   | "true" |  
      | "KOMBA"  | "true" |
      | "RACKM"  | "true" |
      | "RCKMA1" | "true" |
      | "VBOX2"  | "true" |
      | "VIRTLU" | "true" |
      
      

      
  Scenario Outline: IM.019-001-002: LU_CODED returns false for load unit type with ID from sequence (dialog IM040). 
  For every CRELU the load unit ID is created automatically.
   
When LU_CODED is called with <Lu-Type> should return <result>
    Examples: 
      | Lu-Type  | result |   
      | "EUKAB" | "false"|
      | "EURO" | "false"|
      | "GBOX" | "false"|
      | "KOMB"  | "false"| 
      | "KOMW"  | "false"|
      | "LBOX1"  | "false"|
      | "LBOX2"  | "false"|
      | "LBOX3"  | "false"|
      | "ORIG"  | "false"|
      | "ROLL" | "false"|
      | "TUETE" | "false"|
      | "VBOX1"  | "false"|
      | "VBOX3"  | "false"|

      
  Scenario Outline: IM.019-001-003: LU_CODED throws an Exception if the load unit type does not exist.
   
  When LU_CODED is called with <Lu-Type> throws an exception <exception-id>
    Examples:
       | Lu-Type  | exception-id|
       | "VBO"  |  "BEND-0010"|
       | "sss"  |  "BEND-0010"|
       | "xxx"  |  "BEND-0010"|
      