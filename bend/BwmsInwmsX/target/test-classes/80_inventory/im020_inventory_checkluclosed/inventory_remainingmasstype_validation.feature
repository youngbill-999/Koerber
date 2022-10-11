#Author: michael.nkongho@koerber-supplychain.com
#Keywords Summary : LU Remaining Mass Type Volume
@inventory @LU_ClOSED @defaultdatabased
Feature: IM.020 check LU_ClOSED 
Background:
    Given set global: idSite = "RL1", idClient = "RK1"
    
   @luremainingmasstype
   Scenario Outline: LU_Closed Returns true if load unit is closed

When LU_Closed is called the <Lu-Type> should return true if load unit is closed
    Examples: 
      | Lu-Type |
      | "EUKAB" |  
      | "GBOX"  |  