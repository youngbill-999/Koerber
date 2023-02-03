#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :

@replenishment  #@defaultdatabased  @cleanHLReservation 
@run

Feature: Replenishment - Preventive replenishment for picking zone

  Background:
  Given set global: idSite = "RL1", idClient = "RK1"
  
######################################################################################################################
  
  Scenario: Replenishment process
  This test uses job REP_STORE_OUT_ZONE_CONFIGS to identify required replenishment in picking zone
  
  
  Given active the configuration of preventive replenishmen of article "40067222" 
  
   ##crelu lu1 
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction1"
  ##crequ qu1 in lu1
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 2500.0 pieces of article "40067222" has to be created
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu" is the target
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction2"
  ##move lu1 to H01-02
  Given the load unit "Lu" has to be booked to target location "H02-BLD"-"204" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction3"
      And Load unit "Lu" is at storage Area and Location "H02-BLD"-"204"
  
  
  When run job "REP_STORE_OUT_ZONE_CONFIGS"
      And 10 sec is passed 
      And there is a replenishment request has: idArticle = "40067222", stat = "00", typReplenishment = "SO_ZONE", idStoreOutZone = "ENT_H1_02", save as "Rep"
  Then RELEASE_REP_REQUESTS is called for:
             |Rep|
      And WEBSERVICE succeeds
      And 8 sec is passed
  Then reload replenishment request "Rep"
      And replenishment request "Rep" has: typReplenishment = "SO_ZONE", stat = "20", idArticle = "40067222", artvar = null, idBatch = null, idCre = "REP_REPLENISHMENT", tsCre = now, idUpd = "BPS_SCHEDULER", tsUpd = now, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 2500.0, qtyTarget = 5000.0
      
      And quantum "Qu" has available quantity 0.0
      And quantum "Qu" has reserved quantity 2500.0
      
      And replenishment request "Rep" has 2 bps records, saved as collection "RepBpsRecord"
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067222", artvar = "1", qty = 2500.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null       
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu", loadUnitSrc = "Lu"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H02-BLD", locationSrc = "204"
      And bps record "RepBpsRecord[0]" has one tcs task, saved as "Tcs"
      
      
   Then COMPLETE_TASK_EP is called with transport task "Tcs"
      And reload transport task "Tcs"
      And transport task "Tcs" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H02-BLD", storageLocation = "204", clProcess = "REP", typProcess = "REPL", stepProcess = "FINISH"
     
   
   Then RESERV_REP_REQUESTS is called for:
             |Rep|
     And WEBSERVICE succeeds
     And 5 sec is passed 
     And reload replenishment request "Rep"  
     And replenishment request "Rep" has: stat = "90"
     And quantum "Qu" has available quantity 2500.0
     And quantum "Qu" has reserved quantity 0.0
     
   #cleanup
   Then delete load unit "Lu"
   Then deactive the configuration of preventive replenishmen of article "40067222" 
 
################################################################################################################################
