#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :

@inventory @chasc  @defaultdatabased

Feature: IM.013-004: inventory/transaction/chasc - Melting with BBD

Background: 	
	Given set global: idSite = "RL1", idClient = "RK2"

###couldn't find any article has more than 1 atrvars and need to enter the BBD at the same time 

@Melting @BBD
###########################- 1 -#####################################
	Scenario: IM.013-004-0001: 
	On a location are 2 quanta A and B with the same attributes. They differ in their artvar. 
  Quantum A has a BBD; quantum B has a different BBD.
  The artvar is changed for all quantity of quantum A to match artvar of quantum B. 
  Quantum B has the worse BBD.	
  
	
						
@Melting @BBD
###########################- 2 -#####################################
	Scenario: IM.013-004-0002: 
	On a location are 2 quanta A and B with the same attributes. They differ in their artvar. 
  Quantum A has a BBD; quantum B has no BBD.
  The artvar is changed for all quantity of quantum A to match artvar of quantum B. 
  Quantum B has no BBD. 