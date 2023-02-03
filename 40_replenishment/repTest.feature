@replenishmentTEST  @test
#@defaultdatabased
#@cleanHLReservation
Feature: Replenishment -TEST
 
 Background:
  Given set global: idSite = "RL1", idClient = "RK2"
    ##Create Stock1
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu1"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 18.0 pieces of article "9A-0A1" has to be created
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
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
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 18.0 pieces of article "9A-0A1" has to be created
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
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
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 18.0 pieces of article "9A-0A1" has to be created
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu3" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu3"; transaction saved as "Transaction"
  
  Given the load unit "Lu3" has to be booked to target location "H01-HRL"-"102-1-004-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu3" is at storage Area and Location "H01-HRL"-"102-1-004-04" 
 ##Create Stock4
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu4"; transaction saved as "Transaction"
  
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 18.0 pieces of article "9A-0A1" has to be created
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu4" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu4"; transaction saved as "Transaction"
  
  Given the load unit "Lu4" has to be booked to target location "H01-HRL"-"102-2-005-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu4" is at storage Area and Location "H01-HRL"-"102-2-005-04"       
   

############################################################################################################################################
@test
Scenario: Advanced Test1a
#Create Order
Given order is created with: numPartialOrder = 0, idCustomer = "22358", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "Order1"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order1" with: addressRef2 = "22358"
     And WEBSERVICE succeeds
     And order item is added to order "Order1" with: numConsec = 1, idArticle = "9A-0A1", qty = 6.0
  
Given order is created with: numPartialOrder = 0, idCustomer = "22358", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "Order2"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order2" with: addressRef2 = "22358"
     And WEBSERVICE succeeds
     And order item is added to order "Order2" with: numConsec = 1, idArticle = "9A-0A1", qty = 13.0
     
Given order is created with: numPartialOrder = 0, idCustomer = "22358", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "Order3"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order3" with: addressRef2 = "22358"
     And WEBSERVICE succeeds
     And order item is added to order "Order3" with: numConsec = 1, idArticle = "9A-0A1", qty = 7.0
     
Given order is created with: numPartialOrder = 0, idCustomer = "22358", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "Order4"
     And PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order4" with: addressRef2 = "22358"
     And WEBSERVICE succeeds
     And order item is added to order "Order4" with: numConsec = 1, idArticle = "9A-0A1", qty = 15.0

When OPP_LIST_ORDER is called for:
        | Order1 |
        | Order2 |
        | Order3 |
        | Order4 |
     And WEBSERVICE succeeds
     And 12 sec is passed   
     And order "Order1" is in status "10"
     And order "Order2" is in status "10"
     And order "Order3" is in status "10"
     And order "Order4" is in status "10"
      
 When SAC_LIST_ORDER is called for:
         | Order1 |
         | Order2 |
         | Order3 |
         | Order4 |
     And WEBSERVICE succeeds
     And 5 sec is passed   
     And order "Order1" is in status "20"
     And order "Order2" is in status "20"
     And order "Order3" is in status "20"   
     And order "Order4" is in status "20"
     
  When RES_LIST_ORDER is called for:
         | Order1 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order1" is in status "25"
     
  Then run job "REPU_RES_ERR_QTY"
      And WEBSERVICE succeeds
      And 10 sec is passed
      And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_ERR_QTY", idArticle = "9A-0A1", save as "Rep1"     
      And quantum "Qu1" has available quantity 0.0
      And quantum "Qu1" has reserved quantity 18.0
      And replenishment request "Rep1" has: typReplenishment = "RES_ERR_QTY", stat = "20", idArticle = "9A-0A1", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 18.0, qtyTarget = 6.0
      And replenishment request "Rep1" has 1 bps records, saved as collection "Rep1BpsRecord"  
      And bps record "Rep1BpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep1"
      And bps record "Rep1BpsRecord[0]" has: idArticle = "9A-0A1", artvar = "1", qty = 18.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "Rep1BpsRecord[0]" has: quantumSrc = "Qu1", loadUnitSrc = "Lu1"
      And bps record "Rep1BpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-02" 
      
      
      
   When RES_LIST_ORDER is called for:
         | Order2 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order2" is in status "25"
     
  Then run job "REPU_RES_ERR_QTY"
      And WEBSERVICE succeeds
      And 10 sec is passed
      #And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_ERR_QTY", idArticle = "9A-0A1", save as "Rep1"     
      And a new replenishment request is generated, which has stat = "20", typReplenishment = "RES_ERR_QTY", idArticle = "9A-0A1", save as "Rep2"
      And quantum "Qu2" has available quantity 0.0
      And quantum "Qu2" has reserved quantity 18.0
      And replenishment request "Rep2" has: typReplenishment = "RES_ERR_QTY", stat = "20", idArticle = "9A-0A1", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 18.0, qtyTarget = 1.0
      And replenishment request "Rep2" has 1 bps records, saved as collection "Rep2BpsRecord"  
      And bps record "Rep2BpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep2"
      And bps record "Rep2BpsRecord[0]" has: idArticle = "9A-0A1", artvar = "1", qty = 18.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "Rep2BpsRecord[0]" has: quantumSrc = "Qu2", loadUnitSrc = "Lu2"
      And bps record "Rep2BpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-03"
      
   When RES_LIST_ORDER is called for:
         | Order3 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order3" is in status "25"
     
  Then run job "REPU_RES_ERR_QTY"
      And WEBSERVICE succeeds
      And 10 sec is passed
      #And a replenishment request is generated, which has stat = "80", typReplenishment = "RES_ERR_QTY", idArticle = "9A-0A1", save as "Rep1"     
      #And a new replenishment request is generated, which has stat = "20", typReplenishment = "RES_ERR_QTY", idArticle = "9A-0A1", save as "Rep1"
      And there is no new replenishment request generated, which has stat = "20", typReplenishment = "RES_ERR_QTY", idArticle = "9A-0A1"
      
  When RES_LIST_ORDER is called for:
         | Order4 |
     And WEBSERVICE succeeds        
     And 8 sec is passed
     And order "Order4" is in status "25"
     
  Then run job "REPU_RES_ERR_QTY"
      And WEBSERVICE succeeds
      And 10 sec is passed
      #And a replenishment request is generated, which has stat = "20", typReplenishment = "RES_ERR_QTY", idArticle = "9A-0A1", save as "Rep1"     
      And a new replenishment request is generated, which has stat = "20", typReplenishment = "RES_ERR_QTY", idArticle = "9A-0A1", save as "Rep3"
      And quantum "Qu3" has available quantity 0.0
      And quantum "Qu3" has reserved quantity 18.0
      And replenishment request "Rep3" has: typReplenishment = "RES_ERR_QTY", stat = "20", idArticle = "9A-0A1", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 18.0, qtyTarget = 5.0
      And replenishment request "Rep3" has 1 bps records, saved as collection "Rep3BpsRecord"  
      And bps record "Rep3BpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep3"
      And bps record "Rep3BpsRecord[0]" has: idArticle = "9A-0A1", artvar = "1", qty = 18.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
      And bps record "Rep3BpsRecord[0]" has: quantumSrc = "Qu3", loadUnitSrc = "Lu3"
      And bps record "Rep3BpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "102-1-004-04"
      