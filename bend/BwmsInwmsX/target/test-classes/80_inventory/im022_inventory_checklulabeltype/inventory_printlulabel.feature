#Author: michael.nkongho@koerber-supplychain.com
#Keywords Summary : Labels inventory management
@inventory @LU_LABEL_TYPE @defaultdatabased
Feature: IM.021-001 Labels inventory management-checks LU label type
Background:
    Given set global: idSite = "RL1", idClient = "RK1"
    
    
      
   
   Scenario Outline: IM.021-001-01: LU_LABEL_TYPE call checks whether LU are assigend the correct labels as configured in the PRT050. verify that printing is successful.
   Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
	 And the load unit type is "EURO"
	 When CRELU is called
	 Then CRELU was successful, saved as "Mi"; transaction saved as "Tr"
   When LU_LABEL_TYPE is called with LU type <lu-type>
   #Clean-Up
    Then delete load unit "Mi"
    Examples: 
         |lu-type|    label   |
         |"EURO"| "IM_LU_LBL" |