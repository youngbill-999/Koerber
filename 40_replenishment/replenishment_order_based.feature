#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :

@replenishment
#@defaultdatabased
#@cleanHLReservation
Feature: Replenishment - Order based Replenishment
It starts from an order based reservation error, according to the type of reservation the jobs are different

  Background:
    Given set global: idSite = "RL1", idClient = "RK2"
    
##########################################################################################################################    
 @rep_orderbased 
  Scenario: Job REPU_RES_ERR_QTY
  This job will identify and generate replenishment request for oder with reservation error on quantity level
  ##crelu lu1 
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
  ##crequ qu1 in lu1
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "555-OBJ01" has to be created
      And the artvar is null and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu" is the target
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
  ##move lu1 to H01-02
  Given the load unit "Lu" has to be booked to target location "H01-HRL"-"101-2-011-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu" is at storage Area and Location "H01-HRL"-"101-2-011-04"
  
   Given order is created with: numPartialOrder = 0, idCustomer = "21245", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "Order"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order" with: addressRef2 = "21245"
     And WEBSERVICE succeeds
     And order item is added to order "Order" with: numConsec = 1, idArticle = "555-OBJ01", qty = 3.0
     
     
   When OPP_LIST_ORDER is called for:
        | Order |
     And WEBSERVICE succeeds
     And wait until the order "Order" is in status "10"
     And order "Order" is in status "10"
     And 10 sec is passed    
        
        
         
  When SAC_LIST_ORDER is called for:
        | Order |
     And WEBSERVICE succeeds
     And wait until the order "Order" is in status "20"
     And order "Order" is in status "20"
     And 10 sec is passed   
     
  When RES_LIST_ORDER is called for:
        | Order |
     And WEBSERVICE succeeds        
     And wait until the order "Order" is in status "25"
     And order "Order" is in status "25"  
     And 10 sec is passed    
     

  Then run job "REPU_RES_ERR_QTY"
      And WEBSERVICE succeeds
      And 10 sec is passed
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_ERR_QTY", idArticle = "555-OBJ01", save as "Rep"     
      And quantum "Qu" has available quantity 0.0
      And quantum "Qu" has reserved quantity 10.0
      And replenishment request "Rep" has: typReplenishment = "RES_ERR_QTY", stat = "20", idArticle = "555-OBJ01", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 10.0, qtyTarget = 3.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"  
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "555-OBJ01", artvar = null, qty = 10.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu", loadUnitSrc = "Lu"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "101-2-011-04"
     
  
  Then load unit "Lu" has 1 transport task, saved as collection "Tcs"
     And COMPLETE_TASK_EP is called with transport task "Tcs[0]"
     And 5 sec is passed
     And reload transport task "Tcs[0]"
     And transport task "Tcs[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-HRL", storageLocation = "101-2-011-04", clProcess = "REP", typProcess = "REPL", stepProcess = "FINISH"
     And quantum "Qu" has available quantity 10.0
     And quantum "Qu" has reserved quantity 0.0
     And reload replenishment request "Rep"  
     And replenishment request "Rep" has: stat = "90"
     
  #Clean up
  Then CANCEL_ORDERS_EP is called for:
       | Order |
     And WEBSERVICE succeeds
     And 3 sec is passed  
  Then delete load unit "Lu"   
 ###################################################################################################################################################################    

  Scenario: Job "REPU_RES_ERR_LU" for load unit level replenishment
   This job will identify and generate replenishment request for oder with reservation error on load unit level
    ##crelu lu1 
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction1"
  ##crequ qu1 in lu1
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 648.0 pieces of article "WT-XP3" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu" is the target
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction2"
      
  Given the load unit "Lu" has to be booked to target location "H02-HRL"-"201-2-006-05-1" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction3"   
      
   
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu2"; transaction saved as "Transaction1"

  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 648.0 pieces of article "WT-XP3" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu2" is the target
      And CREQU is called
      And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction2"
      
  Given the load unit "Lu2" has to be booked to target location "H02-HRL"-"202-1-001-05-1" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction3" 
      
         
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu3"; transaction saved as "Transaction1"

  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 650.0 pieces of article "WT-XP3" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
      And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction2"
      
  Given the load unit "Lu3" has to be booked to target location "H02-HRL"-"202-1-002-02-1" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction3"  
  
  Given order is created with: numPartialOrder = 0, idCustomer = "21245", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "Order"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order" with: addressRef2 = "21245"
     And WEBSERVICE succeeds
     And order item is added to order "Order" with: numConsec = 1, idArticle = "WT-XP3", qty = 1944.0
     
     
  When OPP_LIST_ORDER is called for:
        | Order |
     And WEBSERVICE succeeds
     And wait until the order "Order" is in status "10"
     And order "Order" is in status "10"
     And 10 sec is passed 
   
  When SAC_LIST_ORDER is called for:
        | Order |
     And WEBSERVICE succeeds
     And wait until the order "Order" is in status "20"
     And order "Order" is in status "20"
     And 10 sec is passed
     
  When RES_LIST_ORDER is called for:
        | Order |
     And WEBSERVICE succeeds        
     And wait until the order "Order" is in status "25"
     And order "Order" is in status "25"  
     And 10 sec is passed   
     
  Then run job "REPU_RES_ERR_LU"
      And WEBSERVICE succeeds
      And 10 sec is passed
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_ERR_LU", idArticle = "WT-XP3", save as "Rep"  
      And replenishment request "Rep" has: typReplenishment = "RES_ERR_LU", stat = "20", idArticle = "WT-XP3", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 650.0, qtyTarget = 648.0
        
    #    
      And quantum "Qu" has available quantity 0.0
      And quantum "Qu" has reserved quantity 648.0
      And quantum "Qu2" has available quantity 0.0
      And quantum "Qu2" has reserved quantity 648.0
      And quantum "Qu3" has available quantity 0.0
      And quantum "Qu3" has reserved quantity 650.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"  
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "WT-XP3", artvar = "2", qty = 650.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu3", loadUnitSrc = "Lu3"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H02-HRL", locationSrc = "202-1-002-02-1"
    #  
      
  Then load unit "Lu3" has 1 transport task, saved as collection "Tcs"
     And COMPLETE_TASK_EP is called with transport task "Tcs[0]"
     And 5 sec is passed
     And reload transport task "Tcs[0]"
     And transport task "Tcs[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H02-HRL", storageLocation = "202-1-002-02-1", clProcess = "REP", typProcess = "REPL", stepProcess = "FINISH"
     And quantum "Qu3" has available quantity 650.0
     And quantum "Qu3" has reserved quantity 0.0
     And reload replenishment request "Rep"  
     And replenishment request "Rep" has: stat = "90"    
      
    #clean up
    #Clean up
  Then CANCEL_ORDERS_EP is called for:
       | Order |
     And WEBSERVICE succeeds
     And 3 sec is passed  
     And delete load unit "Lu" 
     And delete load unit "Lu2" 
     And delete load unit "Lu3"  