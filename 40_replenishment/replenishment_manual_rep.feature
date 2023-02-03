#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :

@replenishment  @manual_rep 

Feature: Replenishment - Manual Replenishment 
This feature invokes webservice CANCEL_REP_REQUESTS to manually generate replenishment request 

  Background:
  Given set global: idSite = "RL1", idClient = "RK2"
  
####################################### 1 #############################################################

   Scenario: Manually create Repleniushment without source quantum - CREATE_MANUAL_REP_REQUEST
   Given create a replenishment request of type MANUAL
       And CREATE_MANUAL_REP_REQUEST has:
         |priorityOrig|500|
         |idArticle|9A-0A1|
         |storageLocation|101-2-002-01|
         |storageArea|H01-HRL|
         |idStoreOutZone||
         |qtyTarget|1|
         |cntLuTarget|0|
         |artvar||
         |typStock|AV|
         |typLock|------|
         |typSpecialStock||
         |idSpecialStock||
         |idBatch||
         |statQualityControl|00|
         |statCustoms|00|
       And CREATE_MANUAL_REP_REQUEST is called 
       And WEBSERVICE succeeds
       And 5 sec is passed 
   Then there is a replenishment request has: stat = "20", typReplenishment = "MANUAL", storageArea = "H01-HRL", storageLocation = "101-2-002-01", save as "Rep"
       And replenishment request "Rep" has: typReplenishment = "MANUAL", stat = "20", idArticle = "9A-0A1", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 0.0, qtyTarget = 1.0
       And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"  
       And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
       And bps record "RepBpsRecord[0]" has: idArticle = "9A-0A1", artvar = null, qty = 1.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
       And bps record "RepBpsRecord[0]" has: areaTgt = "H01-HRL", locationTgt = "101-2-002-01"
   #Clean up
   Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
       And WEBSERVICE succeeds
       And 3 sec is passed
       And reload replenishment request "Rep"
       And replenishment request "Rep" has: stat = "80"
       
####################################### 2 #############################################################       
        
Scenario: Manually create Repleniushment with source quantum - CREATE_MANUAL_REP_REQUEST
     ##crelu lu1 
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
  ##crequ qu1 in lu1
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "9A-0A1" has to be created
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu" is the target
      And CREQU is called
      And CREQU was successful, saved as "Qu"; transaction saved as "Transaction2"
  Given the load unit "Lu" has to be booked to target location "H01-HRL"-"101-2-011-04" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction3"
      And Load unit "Lu" is at storage Area and Location "H01-HRL"-"101-2-011-04"

   Given create a replenishment request of type MANUAL
       And CREATE_MANUAL_REP_REQUEST has:
         |priorityOrig|500|
         |idArticle|9A-0A1|
         |storageLocation|101-2-002-01|
         |storageArea|H01-HRL|
         |idStoreOutZone||
         |qtyTarget|1|
         |cntLuTarget|0|
         |artvar||
         |typStock|AV|
         |typLock|------|
         |typSpecialStock||
         |idSpecialStock||
         |idBatch||
         |statQualityControl|00|
         |statCustoms|00|
       And CREATE_MANUAL_REP_REQUEST is called 
       And WEBSERVICE succeeds
       And 5 sec is passed 
   Then there is a replenishment request has: stat = "20", typReplenishment = "MANUAL", storageArea = "H01-HRL", storageLocation = "101-2-002-01", save as "Rep"
       And replenishment request "Rep" has: typReplenishment = "MANUAL", stat = "20", idArticle = "9A-0A1", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 10.0, qtyTarget = 1.0
       And quantum "Qu" has available quantity 0.0
       And quantum "Qu" has reserved quantity 10.0
       And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"  
       And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
       And bps record "RepBpsRecord[0]" has: idArticle = "9A-0A1", artvar = "1", qty = 10.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
       And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu", loadUnitSrc = "Lu"
       And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "101-2-011-04"
       And bps record "RepBpsRecord[0]" has: areaTgt = "H01-HRL", locationTgt = "101-2-002-01"
   
   Then load unit "Lu" has 1 transport task, saved as collection "Tcs"    
       And COMPLETE_TASK_EP is called with transport task "Tcs[0]"
       And 10 sec is passed    
       And reload replenishment request "Rep"  
       And replenishment request "Rep" has: stat = "90"
  
  #Clean up
   Then delete load unit "Lu"
   
   ####################################### 3 #############################################################       
      
Scenario: Reserve stock on existing replenishment request - RESERV_REP_REQUESTS
 Given create a replenishment request of type MANUAL
       And CREATE_MANUAL_REP_REQUEST has:
         |priorityOrig|500|
         |idArticle|9A-0A1|
         |storageLocation|101-2-002-01|
         |storageArea|H01-HRL|
         |idStoreOutZone||
         |qtyTarget|1|
         |cntLuTarget|0|
         |artvar||
         |typStock|AV|
         |typLock|------|
         |typSpecialStock||
         |idSpecialStock||
         |idBatch||
         |statQualityControl|00|
         |statCustoms|00|
       And CREATE_MANUAL_REP_REQUEST is called 
       And WEBSERVICE succeeds
       And 5 sec is passed 
       And there is a replenishment request has: stat = "20", typReplenishment = "MANUAL", storageArea = "H01-HRL", storageLocation = "101-2-002-01", save as "Rep"
       And replenishment request "Rep" has: typReplenishment = "MANUAL", stat = "20", idArticle = "9A-0A1", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 0.0, qtyTarget = 1.0
       And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"  
       And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
       And bps record "RepBpsRecord[0]" has: idArticle = "9A-0A1", artvar = null, qty = 1.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
       And bps record "RepBpsRecord[0]" has: areaTgt = "H01-HRL", locationTgt = "101-2-002-01"
    
     ##crelu lu1 
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
       And the load unit type is "EURO"
       And CRELU is called
	     And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
  ##crequ qu1 in lu1
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "9A-0A1" has to be created
       And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
       And the load unit "Lu" is the target
       And CREQU is called
       And CREQU was successful, saved as "Qu"; transaction saved as "Transaction2"
  Given the load unit "Lu" has to be booked to target location "H01-HRL"-"101-2-011-04" with booking type "BOOKING"
       And RELLU is called
       And RELLU was successful; transaction saved as "Transaction3"
       And Load unit "Lu" is at storage Area and Location "H01-HRL"-"101-2-011-04"    
      
    
  Then RESERV_REP_REQUESTS is called for:
       |Rep|
       And WEBSERVICE succeeds
       And 5 sec is passed
       And reload replenishment request "Rep"
       And replenishment request "Rep" has: typReplenishment = "MANUAL", stat = "20", idArticle = "9A-0A1", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 2, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 10.0, qtyTarget = 1.0
       And reload bps record "RepBpsRecord[0]"
       And quantum "Qu" has available quantity 0.0
       And quantum "Qu" has reserved quantity 10.0
       And bps record "RepBpsRecord[0]" has: idArticle = "9A-0A1", artvar = "1", qty = 10.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null
       And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu", loadUnitSrc = "Lu"
       And bps record "RepBpsRecord[0]" has: areaSrc = "H01-HRL", locationSrc = "101-2-011-04"
       And bps record "RepBpsRecord[0]" has: areaTgt = "H01-HRL", locationTgt = "101-2-002-01" 
      
  Then load unit "Lu" has 1 transport task, saved as collection "Tcs"    
       And COMPLETE_TASK_EP is called with transport task "Tcs[0]"
       And 10 sec is passed    
       And reload replenishment request "Rep"  
       And replenishment request "Rep" has: stat = "90"    
  #Clean up
   Then delete load unit "Lu"
   
#################################################################################################################################   
 