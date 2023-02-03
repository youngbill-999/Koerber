#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
@replenishment 
@rep_highlevel
@rep_fixLocation
@defaultdatabased
Feature: Replenishment - Replenishment of High Level Reservation
 If a order entered into status 32 for some shortage, it creates a high level reservation in dialog IM130
 run job REPU_RES_HIGH_LVL will find all the high level reservation and create related high level replenishment
  Background:
    Given set global: idSite = "RL1", idClient = "RK1"
######################################################################################################################################   

  Scenario: Job REPU_RES_HIGH_LVL
  Create an quantum in the store out zone ENT_H1_02
  Create an order to reserve same article
  Reserve the order it will enters status 32
  Run job REPU_RES_HIGH_LVL to generate high level replenishment
  
  ##crelu lu1 
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
  ##crequ qu1 in lu1
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "55534013" has to be created
      And the artvar is null and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
  ##move lu1 to H01-02
  Given the load unit "Lu" has to be booked to target location "H01-HRL"-"102-1-006-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu" is at storage Area and Location "H01-HRL"-"102-1-006-04"
  
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order" with: numConsec = 1, idArticle = "55534013", qty = 3.0
   
  When OPP_LIST_ORDER is called for:
        | Order |
     And WEBSERVICE succeeds
     And 10 sec is passed   
     And order "Order" is in status "10"
      
  When SAC_LIST_ORDER is called for:
        | Order |
     And WEBSERVICE succeeds
     And 3 sec is passed   
     And order "Order" is in status "20"
     
  When RES_LIST_ORDER is called for:
        | Order |
     And WEBSERVICE succeeds        
     And 5 sec is passed
     And order "Order" is in status "30"  
     
     
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order |
     And WEBSERVICE succeeds
     And 3 sec is passed  
     And order "Order" is in status "32"

  
  Then there is a high level reservation with qtyReserved = 3.0, idArticle = "55534013", idStoreOutZone = "ENT_H1_01" generated, save as "HL1" 
  
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed  
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "55534013", save as "Rep"
      #And replenishment request "Rep" has: qtyReserved = 10.0
      #And replenishment request "Rep" has: typReplenishment = "SO_ZONE", stat = "20", idArticle = "40067007", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 3, cntLuTarget = 3, qtyActual = null, qtyReserved = null, qtyTarget = null
     
      
  Then high level reservation "HL1" has the id equals ref2 of replenishment request "Rep"
      And reload replenishment request "Rep" 
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "55534013", artvar = null, idBatch = null, idCre = "REP_REPLENISHMENT", tsCre = now, idUpd = "BPS_SCHEDULER", tsUpd = now, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 10.0, qtyTarget = 3.0
      And quantum "Qu" has available quantity 0.0
      And quantum "Qu" has reserved quantity 10.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "55534013", artvar = null, qty = 10.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu", loadUnitSrc = "Lu"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-006-04"
     
  Then load unit "Lu" has 1 transport task, saved as collection "Tcs"
     And COMPLETE_TASK_EP is called with transport task "Tcs[0]"
     And 10 sec is passed    
     And reload replenishment request "Rep"  
     And replenishment request "Rep" has: stat = "90"
     And high level reservation "HL1" was deleted
     And order "Order" is in status "38"  
     And quantum "Qu" has available quantity 7.0
     And quantum "Qu" has reserved quantity 3.0  
     
  #Clean up
  Then CANCEL_ORDERS_EP is called for:
       | Order |
     And WEBSERVICE succeeds
     And 3 sec is passed  
  Then delete quantum "Qu"
      
  #########################################################################################################################     
 
  Scenario: Advanced Test1a
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order1"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order1" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order1" with: numConsec = 1, idArticle = "40067005", qty = 100.0
  
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order2"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order2" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order2" with: numConsec = 1, idArticle = "40067005", qty = 100.0
     
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order3"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order3" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order3" with: numConsec = 1, idArticle = "40067005", qty = 100.0
  
  
  
 ##Create Stock1
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu1" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
  
  Given the load unit "Lu1" has to be booked to target location "H01-HRL"-"102-1-004-02" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu1" is at storage Area and Location "H01-HRL"-"102-1-004-02" 
  
  ##Create Stock2
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu2"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu2" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
  
  Given the load unit "Lu2" has to be booked to target location "H01-HRL"-"102-1-004-03" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu2" is at storage Area and Location "H01-HRL"-"102-1-004-03" 
 ##Create Stock3
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu3"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction"
  
  Given the load unit "Lu3" has to be booked to target location "H01-HRL"-"102-1-004-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu3" is at storage Area and Location "H01-HRL"-"102-1-004-04" 
      
      
  When OPP_LIST_ORDER is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order1" is in status "10"
     And order "Order2" is in status "10"
     And order "Order3" is in status "10"
      
  When SAC_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order1" is in status "20"
     And order "Order2" is in status "20"
     And order "Order3" is in status "20" 
     
   When RES_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order1" is in status "30"
     And order "Order2" is in status "30"
     And order "Order3" is in status "30" 
     
     
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order1" is in status "32"
     And order "Order2" is in status "32"
     And order "Order3" is in status "32" 
  
  Then there is a high level reservation with qtyReserved = 300.0, idArticle = "40067005", idStoreOutZone = "ENT_H1_01" generated, save as "HL1" 
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed  
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "40067005", save as "Rep"
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 300.0, qtyTarget = 300.0
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 300.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"
      
   Then load unit "Lu1" has 1 transport task, saved as collection "Tcs"
     And COMPLETE_TASK_EP is called with transport task "Tcs[0]"
     And 10 sec is passed    
     And reload replenishment request "Rep"  
     And replenishment request "Rep" has: stat = "90"
     And high level reservation "HL1" was deleted
     And order "Order1" is in status "38"
     And order "Order2" is in status "38"
     And order "Order3" is in status "38"
     And quantum "Qu1" has available quantity 0.0
     And quantum "Qu1" has reserved quantity 300.0  
  
  #Clean up
   Then CANCEL_ORDERS_EP is called for:
       | Order1 |
       | Order2 |
       | Order3 |
     And WEBSERVICE succeeds
     And 3 sec is passed
     And delete quantum "Qu1"
     And delete quantum "Qu2"
     And delete quantum "Qu3"  
     
#########################################################################################################################################

  Scenario: Advanced Test1b

##Create Stock1
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu1" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
  
  Given the load unit "Lu1" has to be booked to target location "H01-HRL"-"102-1-004-02" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu1" is at storage Area and Location "H01-HRL"-"102-1-004-02" 
  
  ##Create Stock2
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu2"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu2" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
  
  Given the load unit "Lu2" has to be booked to target location "H01-HRL"-"102-1-004-03" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu2" is at storage Area and Location "H01-HRL"-"102-1-004-03" 
 ##Create Stock3
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu3"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction"
  
  Given the load unit "Lu3" has to be booked to target location "H01-HRL"-"102-1-004-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu3" is at storage Area and Location "H01-HRL"-"102-1-004-04" 
      
  ##Create Order
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order1"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order1" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order1" with: numConsec = 1, idArticle = "40067005", qty = 100.0
  
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order2"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order2" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order2" with: numConsec = 1, idArticle = "40067005", qty = 100.0
     
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order3"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order3" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order3" with: numConsec = 1, idArticle = "40067005", qty = 100.0 
     
     
   When OPP_LIST_ORDER is called for:
        | Order1 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order1" is in status "10"
    
  When SAC_LIST_ORDER is called for:
         | Order1 |      
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order1" is in status "20"
   
   When RES_LIST_ORDER is called for:
         | Order1 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order1" is in status "30"
  
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order1 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order1" is in status "32"
  
  Then there is a high level reservation with qtyReserved = 100.0, idArticle = "40067005", idStoreOutZone = "ENT_H1_01" generated, save as "HL1" 
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed    
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "40067005", save as "Rep"
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 300.0, qtyTarget = 100.0
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 300.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"   
     
   When OPP_LIST_ORDER is called for:
        | Order2 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order2" is in status "10"
    
  When SAC_LIST_ORDER is called for:
         | Order2 |      
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order2" is in status "20"
   
   When RES_LIST_ORDER is called for:
         | Order2 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order2" is in status "30"
  
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order2 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order2" is in status "32" 
     And high level reservation "HL1" has: qtyReserved = 200.0
     
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed    
      And reload replenishment request "Rep" 
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 300.0, qtyTarget = 100.0
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 300.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"
  
     
   When OPP_LIST_ORDER is called for:
        | Order3 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order3" is in status "10"
    
  When SAC_LIST_ORDER is called for:
         | Order3 |      
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order3" is in status "20"
   
   When RES_LIST_ORDER is called for:
         | Order3 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order3" is in status "30"
  
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order3" is in status "32"   
     And high level reservation "HL1" has: qtyReserved = 300.0
  
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed    
      And reload replenishment request "Rep" 
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 300.0, qtyTarget = 100.0
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 300.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"   
        
  Then load unit "Lu1" has 1 transport task, saved as collection "Tcs"
     And COMPLETE_TASK_EP is called with transport task "Tcs[0]"
     And 10 sec is passed    
     And reload replenishment request "Rep"  
     And replenishment request "Rep" has: stat = "90"
     And high level reservation "HL1" was deleted
     And order "Order1" is in status "38"
     And order "Order2" is in status "38"
     And order "Order3" is in status "38"
     And quantum "Qu1" has available quantity 0.0
     And quantum "Qu1" has reserved quantity 300.0  
  
  #Clean up
   Then CANCEL_ORDERS_EP is called for:
       | Order1 |
       | Order2 |
       | Order3 |
     And WEBSERVICE succeeds
     And 3 sec is passed
     And delete quantum "Qu1"
     And delete quantum "Qu2"
     And delete quantum "Qu3"  
     
     
#########################################################################################################################################

  Scenario: Advanced Test2a
##Create Stock1
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu1" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
  
  Given the load unit "Lu1" has to be booked to target location "H01-HRL"-"102-1-004-02" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu1" is at storage Area and Location "H01-HRL"-"102-1-004-02" 
  
  ##Create Stock2
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu2"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu2" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
  
  Given the load unit "Lu2" has to be booked to target location "H01-HRL"-"102-1-004-03" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu2" is at storage Area and Location "H01-HRL"-"102-1-004-03" 
 ##Create Stock3
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu3"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction"
  
  Given the load unit "Lu3" has to be booked to target location "H01-HRL"-"102-1-004-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu3" is at storage Area and Location "H01-HRL"-"102-1-004-04" 
      
  ##Create Order
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order1"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order1" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order1" with: numConsec = 1, idArticle = "40067005", qty = 100.0
  
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order2"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order2" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order2" with: numConsec = 1, idArticle = "40067005", qty = 100.0
     
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order3"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order3" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order3" with: numConsec = 1, idArticle = "40067005", qty = 200.0 
     
   When OPP_LIST_ORDER is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order1" is in status "10"
     And order "Order2" is in status "10"
     And order "Order3" is in status "10"
      
  When SAC_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order1" is in status "20"
     And order "Order2" is in status "20"
     And order "Order3" is in status "20" 
     
   When RES_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order1" is in status "30"
     And order "Order2" is in status "30"
     And order "Order3" is in status "30" 
     
     
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order1" is in status "32"
     And order "Order2" is in status "32"
     And order "Order3" is in status "32" 
  
  Then there is a high level reservation with qtyReserved = 400.0, idArticle = "40067005", idStoreOutZone = "ENT_H1_01" generated, save as "HL1" 
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed  
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "40067005", save as "Rep"
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 600.0, qtyTarget = 400.0
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 300.0
      And quantum "Qu2" has available quantity 0.0
      And quantum "Qu2" has reserved quantity 300.0
      
      And replenishment request "Rep" has 2 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"
      And bps record "RepBpsRecord[1]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[1]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[1]" has: quantumSrc = "Qu2", loadUnitSrc = "Lu2"
      And bps record "RepBpsRecord[1]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-03"
   
   Then load unit "Lu1" has 1 transport task, saved as collection "Tcs1"
      And COMPLETE_TASK_EP is called with transport task "Tcs1[0]"
      And 10 sec is passed
   Then load unit "Lu2" has 1 transport task, saved as collection "Tcs2"
      And COMPLETE_TASK_EP is called with transport task "Tcs2[0]"
      And 10 sec is passed    
      And reload replenishment request "Rep"  
      And replenishment request "Rep" has: stat = "90"
      And high level reservation "HL1" was deleted
      And order "Order1" is in status "38"
      And order "Order2" is in status "38"
      And order "Order3" is in status "38"
      
  #Clean up
   Then CANCEL_ORDERS_EP is called for:
       | Order1 |
       | Order2 |
       | Order3 |
      And WEBSERVICE succeeds
      And 3 sec is passed
      And delete quantum "Qu1"
      And delete quantum "Qu2"
      And delete quantum "Qu3"  
     
  ####################################################################################################################################
 
  Scenario: Advanced Test2b
##Create Stock1
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu1" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
  
  Given the load unit "Lu1" has to be booked to target location "H01-HRL"-"102-1-004-02" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu1" is at storage Area and Location "H01-HRL"-"102-1-004-02" 
  
  ##Create Stock2
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu2"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu2" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
  
  Given the load unit "Lu2" has to be booked to target location "H01-HRL"-"102-1-004-03" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu2" is at storage Area and Location "H01-HRL"-"102-1-004-03" 
 ##Create Stock3
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu3"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction"
  
  Given the load unit "Lu3" has to be booked to target location "H01-HRL"-"102-1-004-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu3" is at storage Area and Location "H01-HRL"-"102-1-004-04" 
      
  ##Create Order
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order1"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order1" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order1" with: numConsec = 1, idArticle = "40067005", qty = 100.0
  
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order2"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order2" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order2" with: numConsec = 1, idArticle = "40067005", qty = 100.0
     
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order3"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order3" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order3" with: numConsec = 1, idArticle = "40067005", qty = 200.0 
     
     
   When OPP_LIST_ORDER is called for:
        | Order1 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order1" is in status "10"
    
  When SAC_LIST_ORDER is called for:
         | Order1 |      
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order1" is in status "20"
   
   When RES_LIST_ORDER is called for:
         | Order1 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order1" is in status "30"
  
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order1 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order1" is in status "32"
  
  Then there is a high level reservation with qtyReserved = 100.0, idArticle = "40067005", idStoreOutZone = "ENT_H1_01" generated, save as "HL1" 
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed    
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "40067005", save as "Rep"
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 300.0, qtyTarget = 100.0
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 300.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"   
     
   When OPP_LIST_ORDER is called for:
        | Order2 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order2" is in status "10"
    
  When SAC_LIST_ORDER is called for:
         | Order2 |      
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order2" is in status "20"
   
   When RES_LIST_ORDER is called for:
         | Order2 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order2" is in status "30"
  
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order2 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order2" is in status "32" 
     And high level reservation "HL1" has: qtyReserved = 200.0
     
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed    
      And reload replenishment request "Rep" 
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 300.0, qtyTarget = 100.0
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 300.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"
  
     
   When OPP_LIST_ORDER is called for:
        | Order3 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order3" is in status "10"
    
  When SAC_LIST_ORDER is called for:
         | Order3 |      
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order3" is in status "20"
   
   When RES_LIST_ORDER is called for:
         | Order3 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order3" is in status "30"
  
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order3" is in status "32"      
     And high level reservation "HL1" has: qtyReserved = 400.0
  
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed  
   
      And reload replenishment request "Rep" 
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 300.0, qtyTarget = 100.0
      And a new replenishment request is generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "40067005", save as "Rep2"
      And replenishment request "Rep2" has 1 bps records, saved as collection "Rep2BpsRecord"
      And bps record "Rep2BpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep2"
      And bps record "Rep2BpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "Rep2BpsRecord[0]" has: quantumSrc = "Qu2", loadUnitSrc = "Lu2"
      And bps record "Rep2BpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-03" 
      And quantum "Qu2" has available quantity 0.0
      And quantum "Qu2" has reserved quantity 300.0
       
        
  Then load unit "Lu1" has 1 transport task, saved as collection "Tcs1"
      And COMPLETE_TASK_EP is called with transport task "Tcs1[0]"
      And 10 sec is passed
   Then load unit "Lu2" has 1 transport task, saved as collection "Tcs2"
      And COMPLETE_TASK_EP is called with transport task "Tcs2[0]"
      And 10 sec is passed    
      And reload replenishment request "Rep"  
      And replenishment request "Rep" has: stat = "90"
      And high level reservation "HL1" was deleted
      And order "Order1" is in status "38"
      And order "Order2" is in status "38"
      And order "Order3" is in status "38"
  
  #Clean up
   Then CANCEL_ORDERS_EP is called for:
       | Order1 |
       | Order2 |
       | Order3 |
     And WEBSERVICE succeeds
     And 3 sec is passed
     And delete quantum "Qu1"
     And delete quantum "Qu2"
     And delete quantum "Qu3" 
     
 ####################################################################################################################################

@config_40067005_ENT_H1_01
  Scenario: Advanced Test3
##Create Stock1
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu1" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
  
  Given the load unit "Lu1" has to be booked to target location "H01-HRL"-"102-1-004-02" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu1" is at storage Area and Location "H01-HRL"-"102-1-004-02" 
  
  ##Create Stock2
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu2"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu2" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
  
  Given the load unit "Lu2" has to be booked to target location "H01-HRL"-"102-1-004-03" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu2" is at storage Area and Location "H01-HRL"-"102-1-004-03" 
 ##Create Stock3
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu3"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction"
  
  Given the load unit "Lu3" has to be booked to target location "H01-HRL"-"102-1-004-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu3" is at storage Area and Location "H01-HRL"-"102-1-004-04" 
     
      
  ##Create Order
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order1"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order1" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order1" with: numConsec = 1, idArticle = "40067005", qty = 100.0
  
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order2"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order2" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order2" with: numConsec = 1, idArticle = "40067005", qty = 200.0
     
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order3"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order3" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order3" with: numConsec = 1, idArticle = "40067005", qty = 100.0 
     
  When OPP_LIST_ORDER is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order1" is in status "10"
     And order "Order2" is in status "10"
     And order "Order3" is in status "10"
      
  When SAC_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order1" is in status "20"
     And order "Order2" is in status "20"
     And order "Order3" is in status "20" 
     
   When RES_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order1" is in status "30"
     And order "Order2" is in status "30"
     And order "Order3" is in status "30" 
     
     
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order1" is in status "32"
     And order "Order2" is in status "32"
     And order "Order3" is in status "32" 
     
  Then there is a high level reservation with qtyReserved = 400.0, idArticle = "40067005", idStoreOutZone = "ENT_H1_01" generated, save as "HL1" 
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed  
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "40067005", save as "Rep"
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 600.0, qtyTarget = 400.0
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 300.0
      And quantum "Qu2" has available quantity 0.0
      And quantum "Qu2" has reserved quantity 300.0
          
      And replenishment request "Rep" has 2 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"
      And bps record "RepBpsRecord[1]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[1]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[1]" has: quantumSrc = "Qu2", loadUnitSrc = "Lu2"
      And bps record "RepBpsRecord[1]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-03"
           
  Given create the configuration of preventive replenishmen with: idArticle = "40067005", clArticles = "*", grpArticles = "*", idStoreOutZone = "ENT_H1_01", flagActive = "1", minQty = 301.0, maxQty = 600.0, minLu = null, maxLu = null
  Given RD_SINGLE_CONFIG is called, idArticle = "40067005", clArticles = "*", grpArticles = "*", idStoreOutZone = "ENT_H1_01"    
       And WEBSERVICE succeeds
       And 5 sec is passed
       And there is no new replenishment request generated, which has stat = "20", typReplenishment = "SO_ZONE", idArticle = "40067005"
  
  #Clean up
  Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
       And WEBSERVICE succeeds
       And 3 sec is passed
       And reload replenishment request "Rep" 
       
  Then CANCEL_ORDERS_EP is called for:
       | Order1 |
       | Order2 |
       | Order3 |
      And WEBSERVICE succeeds
      And 3 sec is passed
      And delete quantum "Qu1"
      And delete quantum "Qu2"
      And delete quantum "Qu3"  
      
 ####################################################################################################################################

@config_40067005_ENT_H1_01
  Scenario: Advanced Test4 
  Given create the configuration of preventive replenishmen with: idArticle = "40067005", clArticles = "*", grpArticles = "*", idStoreOutZone = "ENT_H1_01", flagActive = "1", minQty = 301.0, maxQty = 600.0, minLu = null, maxLu = null
  Given RD_SINGLE_CONFIG is called, idArticle = "40067005", clArticles = "*", grpArticles = "*", idStoreOutZone = "ENT_H1_01"    
       And WEBSERVICE succeeds
       And 5 sec is passed  
  Then a replenishment request is generated, which has stat = "00", typReplenishment = "SO_ZONE", idArticle = "40067005", save as "Rep"
       And replenishment request "Rep" has: typReplenishment = "SO_ZONE", stat = "00", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 0, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 0.0, qtyTarget = 600.0
   
  ##Create Stock1
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu1" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
  
  Given the load unit "Lu1" has to be booked to target location "H01-HRL"-"102-1-004-02" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu1" is at storage Area and Location "H01-HRL"-"102-1-004-02" 
  
  ##Create Stock2
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu2"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu2" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
  
  Given the load unit "Lu2" has to be booked to target location "H01-HRL"-"102-1-004-03" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu2" is at storage Area and Location "H01-HRL"-"102-1-004-03" 
 ##Create Stock3
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu3"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction"
  
  Given the load unit "Lu3" has to be booked to target location "H01-HRL"-"102-1-004-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu3" is at storage Area and Location "H01-HRL"-"102-1-004-04"  
   
   
      
  When RELEASE_REP_REQUESTS is called for:
             |Rep|
       And WEBSERVICE succeeds
       And 8 sec is passed
       And reload replenishment request "Rep"
       And replenishment request "Rep" has: typReplenishment = "SO_ZONE", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 600.0, qtyTarget = 600.0
       And replenishment request "Rep" has 2 bps records, saved as collection "RepBpsRecord"
       And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
       And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
       And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
       And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"
       And bps record "RepBpsRecord[1]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
       And bps record "RepBpsRecord[1]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
       And bps record "RepBpsRecord[1]" has: quantumSrc = "Qu2", loadUnitSrc = "Lu2"
       And bps record "RepBpsRecord[1]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-03"

   ##Create Order
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order1"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order1" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order1" with: numConsec = 1, idArticle = "40067005", qty = 100.0
  
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order2"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order2" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order2" with: numConsec = 1, idArticle = "40067005", qty = 200.0
     
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order3"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order3" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order3" with: numConsec = 1, idArticle = "40067005", qty = 100.0 
     
   When OPP_LIST_ORDER is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 15 sec is passed   
     And order "Order1" is in status "10"
     And order "Order2" is in status "10"
     And order "Order3" is in status "10"
      
  When SAC_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order1" is in status "20"
     And order "Order2" is in status "20"
     And order "Order3" is in status "20" 
     
   When RES_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order1" is in status "30"
     And order "Order2" is in status "30"
     And order "Order3" is in status "30" 
     
     
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order1" is in status "32"
     And order "Order2" is in status "32"
     And order "Order3" is in status "32" 
  
  Then there is a high level reservation with qtyReserved = 400.0, idArticle = "40067005", idStoreOutZone = "ENT_H1_01" generated, save as "HL1" 
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed
      And there is no new replenishment request generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "40067005"
  #Clean up
  Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
       And WEBSERVICE succeeds
       And 3 sec is passed
       And reload replenishment request "Rep" 
       And replenishment request "Rep" has: stat = "80"
  Then CANCEL_ORDERS_EP is called for:
       | Order1 |
       | Order2 |
       | Order3 |
      And WEBSERVICE succeeds
      And 3 sec is passed
      And delete quantum "Qu1"
      And delete quantum "Qu2"
      And delete quantum "Qu3"

 ####################################################################################################################################

  Scenario: Advanced Test5
  ##Create Stock1
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu1" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
  
  Given the load unit "Lu1" has to be booked to target location "H01-HRL"-"102-1-004-02" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu1" is at storage Area and Location "H01-HRL"-"102-1-004-02" 
  
  ##Create Stock2
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu2"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      
      And the load unit "Lu2" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
  
  Given the load unit "Lu2" has to be booked to target location "H01-HRL"-"102-1-004-03" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu2" is at storage Area and Location "H01-HRL"-"102-1-004-03" 
      
 ##Create Stock3
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu3"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction"
  
  Given the load unit "Lu3" has to be booked to target location "H01-HRL"-"102-1-004-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu3" is at storage Area and Location "H01-HRL"-"102-1-004-04"  
  
  
  ##Create Order
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order1"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order1" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order1" with: numConsec = 1, idArticle = "40067005", qty = 100.0
  
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order2"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order2" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order2" with: numConsec = 1, idArticle = "40067005", qty = 200.0
     
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order3"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order3" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order3" with: numConsec = 1, idArticle = "40067005", qty = 100.0 
     
   When OPP_LIST_ORDER is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 15 sec is passed   
     And order "Order1" is in status "10"
     And order "Order2" is in status "10"
     And order "Order3" is in status "10"
      
  When SAC_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order1" is in status "20"
     And order "Order2" is in status "20"
     And order "Order3" is in status "20" 
     
   When RES_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order1" is in status "30"
     And order "Order2" is in status "30"
     And order "Order3" is in status "30" 
     
     
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order1" is in status "32"
     And order "Order2" is in status "32"
     And order "Order3" is in status "32" 
  
  Then there is a high level reservation with qtyReserved = 400.0, idArticle = "40067005", idStoreOutZone = "ENT_H1_01" generated, save as "HL1" 
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "40067005", save as "Rep"
      And replenishment request "Rep" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 600.0, qtyTarget = 400.0
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 300.0
      And quantum "Qu2" has available quantity 0.0
      And quantum "Qu2" has reserved quantity 300.0
      
      And replenishment request "Rep" has 2 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02"
      And bps record "RepBpsRecord[1]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[1]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "RepBpsRecord[1]" has: quantumSrc = "Qu2", loadUnitSrc = "Lu2"
      And bps record "RepBpsRecord[1]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-03"
  
  When run job "REP_FIX_LOCS_SITE"
      And 10 sec is passed 
  Then there is a replenishment request has: stat = "00", typReplenishment = "FIX_LOC", storageArea = "H01-HRL", storageLocation = "105-1-002-01", save as "Rep2"
      And replenishment request "Rep2" has: typReplenishment = "FIX_LOC", stat = "00", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 0, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 0, cntLuTarget = 1, qtyActual = null, qtyReserved = null, qtyTarget = null
  When RELEASE_REP_REQUESTS is called for:
             |Rep2|
      And WEBSERVICE succeeds
      And 8 sec is passed
      And reload replenishment request "Rep2"
      And replenishment request "Rep2" has: typReplenishment = "FIX_LOC", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 1, cntLuTarget = 1, qtyActual = null, qtyReserved = null, qtyTarget = null
      And replenishment request "Rep2" has 1 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep2"
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu3", loadUnitSrc = "Lu3"
      
 #Clean up
  Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
       | Rep2 |
       And WEBSERVICE succeeds
       And 3 sec is passed
       
  Then CANCEL_ORDERS_EP is called for:
       | Order1 |
       | Order2 |
       | Order3 |
      And WEBSERVICE succeeds
      And 3 sec is passed
      And delete quantum "Qu1"
      And delete quantum "Qu2"
      And delete quantum "Qu3"

 ####################################################################################################################################

  Scenario: Advanced Test6
  
 ##Create Stock1
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu1" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"
  
  Given the load unit "Lu1" has to be booked to target location "H01-HRL"-"102-1-004-02" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu1" is at storage Area and Location "H01-HRL"-"102-1-004-02" 
  
  ##Create Stock2
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu2"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      
      And the load unit "Lu2" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"
  
  Given the load unit "Lu2" has to be booked to target location "H01-HRL"-"102-1-004-03" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu2" is at storage Area and Location "H01-HRL"-"102-1-004-03" 
      
 ##Create Stock3
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu3"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 300.0 pieces of article "40067005" has to be created
      And the artvar is "2" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction"
  
  Given the load unit "Lu3" has to be booked to target location "H01-HRL"-"102-1-004-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu3" is at storage Area and Location "H01-HRL"-"102-1-004-04"  
      
   When run job "REP_FIX_LOCS_SITE"
      And 10 sec is passed 
  Then there is a replenishment request has: stat = "00", typReplenishment = "FIX_LOC", storageArea = "H01-HRL", storageLocation = "105-1-002-01", save as "Rep2"
      And replenishment request "Rep2" has: typReplenishment = "FIX_LOC", stat = "00", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 0, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 0, cntLuTarget = 1, qtyActual = null, qtyReserved = null, qtyTarget = null
  When RELEASE_REP_REQUESTS is called for:
             |Rep2|
      And WEBSERVICE succeeds
      And 8 sec is passed
      And reload replenishment request "Rep2"
      And replenishment request "Rep2" has: typReplenishment = "FIX_LOC", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 1, cntLuTarget = 1, qtyActual = null, qtyReserved = null, qtyTarget = null
      And replenishment request "Rep2" has 1 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep2"
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      
       
   ##Create Order
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order1"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order1" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order1" with: numConsec = 1, idArticle = "40067005", qty = 100.0
  
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order2"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order2" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order2" with: numConsec = 1, idArticle = "40067005", qty = 200.0
     
  Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order3"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order3" with: addressRef2 = "12445"
     And WEBSERVICE succeeds
     And order item is added to order "Order3" with: numConsec = 1, idArticle = "40067005", qty = 100.0 
     
   When OPP_LIST_ORDER is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 15 sec is passed   
     And order "Order1" is in status "10"
     And order "Order2" is in status "10"
     And order "Order3" is in status "10"
      
  When SAC_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order1" is in status "20"
     And order "Order2" is in status "20"
     And order "Order3" is in status "20" 
     
   When RES_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order1" is in status "30"
     And order "Order2" is in status "30"
     And order "Order3" is in status "30" 
     
     
  When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order1 |
        | Order2 |
        | Order3 |
     And WEBSERVICE succeeds
     And 5 sec is passed  
     And order "Order1" is in status "32"
     And order "Order2" is in status "32"
     And order "Order3" is in status "32" 
  
  #Then there is a high level reservation with qtyReserved = 400.0, idArticle = "40067005", idStoreOutZone = "ENT_H1_01" generated, save as "HL1" 
  Then run job "REPU_RES_HIGH_LVL"
      And WEBSERVICE succeeds
      And 8 sec is passed
   And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_HIGH_LVL", idArticle = "40067005", save as "Rep1"
      And replenishment request "Rep1" has: typReplenishment = "RES_HIGH_LVL", stat = "20", idArticle = "40067005", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 300.0, qtyTarget = 100.0
      And quantum "Qu2" has available quantity 0.0
      And quantum "Qu2" has reserved quantity 300.0
      
      And replenishment request "Rep1" has 1 bps records, saved as collection "Rep1BpsRecord"
      And bps record "Rep1BpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep1"
      And bps record "Rep1BpsRecord[0]" has: idArticle = "40067005", artvar = "2", qty = 300.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "Rep1BpsRecord[0]" has: quantumSrc = "Qu2", loadUnitSrc = "Lu2"
      And bps record "Rep1BpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-03"

   #Clean up
  Then CANCEL_REP_REQUESTS is callede for:
       | Rep1 |
       And WEBSERVICE succeeds
       And 3 sec is passed
      
  Then CANCEL_REP_REQUESTS is callede for:
       | Rep2 |
       And WEBSERVICE succeeds
       And 3 sec is passed
       
  Then CANCEL_ORDERS_EP is called for:
       | Order1 |
       | Order2 |
       | Order3 |
      And WEBSERVICE succeeds
      And 3 sec is passed
      And delete quantum "Qu1"
      And delete quantum "Qu2"
      And delete quantum "Qu3"













 