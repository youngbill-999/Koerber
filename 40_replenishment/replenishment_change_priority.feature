#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :

@replenishment
@rep_priority
Feature: Replenishment - Change Priority

  Background:
    Given set global: idSite = "RL1", idClient = "RK2"

#######################################################################################################################################

  Scenario: Change priority with Job REP_UP_RES_ERR_QTY
  
  create an order with reservatio error 25
  run job "REPU_RES_ERR_QTY" to create a rep request under the type RES_ERR_QTY
  change the priority oof order and then run REP_UP_RES_ERR_QTY
  verify the bps record of rep request
  
  
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
      And replenishment request "Rep" has: typReplenishment = "RES_ERR_QTY", stat = "20", idArticle = "555-OBJ01", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 10.0, qtyTarget = 3.0
      And quantum "Qu" has available quantity 0.0
      And quantum "Qu" has reserved quantity 10.0
  Then replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"  
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "555-OBJ01", artvar = null, qty = 10.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu", loadUnitSrc = "Lu"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "101-2-011-04"
      And bps record "RepBpsRecord[0]" has: priorityOrig = 500
      And bps record "RepBpsRecord[0]" has: priority = 500 
      
  Then change the priorityOrig of order "Order" to 600
 
  Then run job "REP_UP_RES_ERR_QTY"
      And WEBSERVICE succeeds
      And 10 sec is passed
      And reload bps record "RepBpsRecord[0]"
      And bps record "RepBpsRecord[0]" has: priorityOrig = 600
      And bps record "RepBpsRecord[0]" has: priority = 600 
  #Clean up
  Then CANCEL_ORDERS_EP is called for:
       | Order |
     And WEBSERVICE succeeds
     And 3 sec is passed  
  Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
     And WEBSERVICE succeeds
     And 3 sec is passed
  Then delete load unit "Lu"   



#######################################################################################################################################
   #@run
 Scenario: Change priority with Webservice - UPDATE_REP_REQUESTS
  
        create an replenishmenyt request and release it
        call UPDATE_REP_REQUESTS to change its priority
        verify the bps record of rep request

 Given create a replenishment request of type MANUAL
       And CREATE_MANUAL_REP_REQUEST has:
         |priorityOrig|500|
         |idArticle|9A-0A1|
         |storageLocation|104-1-001-01|
         |storageArea|H01-HRL|
         |qtyTarget|1|
       And CREATE_MANUAL_REP_REQUEST is called 
       And WEBSERVICE succeeds
       And 5 sec is passed 
       And there is a replenishment request has: stat = "20", typReplenishment = "MANUAL", storageArea = "H01-HRL", storageLocation = "104-1-001-01", save as "Rep"
       And replenishment request "Rep" has: typReplenishment = "MANUAL", stat = "20", idArticle = "9A-0A1", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 0.0, qtyTarget = 1.0
       And replenishment request "Rep" has: priorityOrig = 500
       
       And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"  
       And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
       And bps record "RepBpsRecord[0]" has: priorityOrig = 500
       And bps record "RepBpsRecord[0]" has: priority = 500 
  
  Then UPDATE_REP_REQUESTS is called to set priority = 600 for:      
         |Rep|
       And WEBSERVICE succeeds
       And 5 sec is passed
       And reload replenishment request "Rep"
       And reload bps record "RepBpsRecord[0]"
       And replenishment request "Rep" has: priorityOrig = 600
       And bps record "RepBpsRecord[0]" has: priorityOrig = 600
       And bps record "RepBpsRecord[0]" has: priority = 600 
       
  #clean up
   Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
       And WEBSERVICE succeeds
       And 3 sec is passed     
#######################################################################################################################################
#######################################################################################################################################
#Order based priority changing on load unit level reservation error       
#######################################################################################################################################
  
  Scenario: Change priority with Job REP_UP_RES_ERR_LU
  
  create an order with quantum reservation error 25
  run job "REPU_RES_ERR_LU" to create a rep request under the type RES_ERR_LU
  change the priority oof order and then run "REP_UP_RES_ERR_QTY"
  verify the bps record of rep request 
  
     ##crelu lu1 
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction1"
  ##crequ qu1 in lu1
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 650.0 pieces of article "WT-XP3" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu" is the target
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction2"
      
  Given the load unit "Lu" has to be booked to target location "H02-HRL"-"201-2-006-05-1" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction3"   
      
    
 
  Given order is created with: numPartialOrder = 0, idCustomer = "21245", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "Order"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order" with: addressRef2 = "21245"
     And WEBSERVICE succeeds
     And order item is added to order "Order" with: numConsec = 1, idArticle = "WT-XP3", qty = 648.0
     
     
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
      
  Then replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"  
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: priorityOrig = 500
      And bps record "RepBpsRecord[0]" has: priority = 500 
           
  Then change the priorityOrig of order "Order" to 600
  
  Then run job "REP_UP_RES_ERR_LU"
      And WEBSERVICE succeeds
      And 10 sec is passed
      And reload bps record "RepBpsRecord[0]"
      And bps record "RepBpsRecord[0]" has: priorityOrig = 600
      And bps record "RepBpsRecord[0]" has: priority = 600 
  #Clean up
  Then CANCEL_ORDERS_EP is called for:
       | Order |
     And WEBSERVICE succeeds
     And 3 sec is passed  
  Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
     And WEBSERVICE succeeds
     And 3 sec is passed
  Then delete load unit "Lu"    
  
  #######################################################################################################################################

  
  