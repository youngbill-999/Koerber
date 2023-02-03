#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary : replenishment
#@defaultdatabased
@replenishment 

Feature: Replenishment input validation

  Background:
    Given set global: idSite = "RL1", idClient = "RK2"
    
    
  ############################################- 1 -########################################################
  Scenario: input validation test for web service CREATE_MANUAL_REP_REQUEST
  Given create a replenishment request of type MANUAL
      And CREATE_MANUAL_REP_REQUEST has:
         |priorityOrig|500|
         |idArticle|9A-0A1|
         |storageLocation||
         |storageArea||
         |idStoreOutZone||
         |qtyTarget|1|
         |cntLuTarget||
         |artvar||
         |typStock|AV|
         |typLock|------|
         |typSpecialStock||
         |idSpecialStock||
         |idBatch||
         |statQualityControl||
         |statCustoms||
       #And CREATE_MANUAL_REP_REQUEST has: "idClient" = null
       And CREATE_MANUAL_REP_REQUEST is called 
       And WEBSERVICE succeeds
       And 5 sec is passed
       
       
         ############################################- 2 -########################################################
#  @run
  Scenario: input validation test for web service CREATE_MANUAL_REP_REQUEST
  Given create a replenishment request of type MANUAL
       And CREATE_MANUAL_REP_REQUEST has:
         |priorityOrig|500|
         |idArticle|555-OBJ01|
         |storageLocation|104-1-002-01|
         |storageArea|H01-HRL|
         |qtyTarget|1|
       And CREATE_MANUAL_REP_REQUEST is called 
       And WEBSERVICE succeeds
       And 5 sec is passed 
       And there is a replenishment request has: stat = "20", typReplenishment = "MANUAL", storageArea = "H01-HRL", storageLocation = "104-1-002-01", save as "Rep"
       #And replenishment request "Rep" has: typReplenishment = "MANUAL", stat = "20", idArticle = "9A-0A1", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_01", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 0.0, qtyTarget = 1.0
       #And replenishment request "Rep" has: priorityOrig = 500
       
       #And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"  
      # And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
       #And bps record "RepBpsRecord[0]" has: priorityOrig = 500
       #And bps record "RepBpsRecord[0]" has: priority = 500 
  Then UPDATE_REP_REQUESTS is called to set priority = 50000 for:      
         |Rep|
       And WEBSERVICE fails: error = "BEND-0001"
       ##value larger than specified precision allowed for this column return from sql
       
   #Clean up
   Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
       And WEBSERVICE succeeds
       And 3 sec is passed
       And reload replenishment request "Rep"
       And replenishment request "Rep" has: stat = "80"
       
             
############################################- 2 -########################################################
  #@run
  Scenario: input validation test for web service CREATE_MANUAL_REP_REQUEST
  Given create a replenishment request of type MANUAL
       And CREATE_MANUAL_REP_REQUEST has:
         |priorityOrig|500|
         |idArticle|555-OBJ01|
         |storageLocation|104-1-002-01|
         |storageArea|H01-HRL|
         |qtyTarget|1|
       And CREATE_MANUAL_REP_REQUEST is called 
       And WEBSERVICE succeeds
       And 8 sec is passed 
       And there is a replenishment request has: stat = "20", typReplenishment = "MANUAL", storageArea = "H01-HRL", storageLocation = "104-1-002-01", save as "Rep"
   #Cancel the replenishment request
  Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
       And WEBSERVICE succeeds
       And 3 sec is passed
       And reload replenishment request "Rep"
       And replenishment request "Rep" has: stat = "80"
  Then UPDATE_REP_REQUESTS is called to set priority = 600 for:      
         |Rep|
       #And WEBSERVICE fails: error = "BEND-0001"
       And WEBSERVICE succeeds
    #it is different from front end, after canceled the replenishment, in dialog rep100, the button for modifying the priority is hidden, but in the back end the system still allow to modify the peiority
       
 