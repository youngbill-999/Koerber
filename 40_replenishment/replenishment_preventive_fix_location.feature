#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :

@replenishment  @rep_fixLocation
Feature: Replenishment - Preventive replenishment for fixed locations


  Background:
  Given set global: idSite = "RL1", idClient = "RK1"
    
  ###################################################################-1-###################################################  

  Scenario: replenishment with picking - job "REP_FIX_LOCS_ENT_H1_04"
  This test used job "REP_FIX_LOCS_ENT_H1_04" to identify the required replenishment in the store out zone "ENT_H1_04", where consists with a set of Fachboden Flatz
  In this senario, the target quantum will not be fully booked, so there is a picking process to pick up partial of it.
  When run job "REP_FIX_LOCS_ENT_H1_04"
      And 10 sec is passed 
  
  Then there is a replenishment request has: stat = "00", typReplenishment = "FIX_LOC", storageArea = "H01-FACH", storageLocation = "109-1-004-01", save as "Rep"
      And replenishment request "Rep" has: typReplenishment = "FIX_LOC", stat = "00", idArticle = "40067114", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_04", cntResAttemptActual = 0, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 0.0, qtyTarget = 72.0
      
  When RELEASE_REP_REQUESTS is called for:
             |Rep|
      And WEBSERVICE succeeds
      And 8 sec is passed
      And reload replenishment request "Rep"
      And replenishment request "Rep" has: typReplenishment = "FIX_LOC", stat = "20", idArticle = "40067114", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_04", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 0.0, qtyTarget = 72.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"
      
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067114", artvar = null, qty = 72.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null       
       
   ##crelu lu1 
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
  ##crequ qu1 in lu1
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 75.0 pieces of article "40067114" has to be created
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu" is the target
      And BBD is 2020/01/01 and batch is null
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	 	  
	 Given the load unit "Lu" has to be booked to target location "H02-HRL"-"203-1-008-01-2" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
      And Load unit "Lu" is at storage Area and Location "H02-HRL"-"203-1-008-01-2"
   
  When RESERV_REP_REQUESTS is called for:
             |Rep|
      And WEBSERVICE succeeds
      And 10 sec is passed
      Then reload replenishment request "Rep"
      And replenishment request "Rep" has: typReplenishment = "FIX_LOC", stat = "20", idArticle = "40067114", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_04", cntResAttemptActual = 2, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 72.0, qtyTarget = 72.0
      And quantum "Qu" has available quantity 3.0
      And quantum "Qu" has reserved quantity 72.0
      Then reload bps record "RepBpsRecord[0]"
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu", loadUnitSrc = "Lu"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H02-HRL", locationSrc = "203-1-008-01-2"
      And bps record "RepBpsRecord[0]" has: areaTgt = "H01-FACH", locationTgt = "109-1-004-01"

    #GiBaseFieldVerifier
  Then there is a picking item has idRef2 indicates replenishment request "Rep", save its picking order as "PO"
      And PICKING_TRIP_CREATION_EP is called with: idTerminal = "IPC7301" for: 
              |PO|
              
         
          
  Then MDT RESTART "Mdt" is called with: idTerminal = "IPC7301"
      #And MDT USER_INPUT result has: graphName = "MAIN_MENU", stateName = "START", dynamicSubgraph = null and:
     #    ||
      And MDT USER_INPUT "Mdt" is called with: event = "ENTER", menue = "MENU_GI", inputparameter =
         ||
      And MDT USER_INPUT "Mdt" is called with: event = "ENTER", menue = "PICKING", inputparameter =
         ||            
      #And MDT USER_INPUT result has: graphName = "PICKING", stateName = "INFO_CARRIER_LU_TYPE", dynamicSubgraph = null and:
       # |sessionParameter.idTerminal|IPC7301|
       # |outputparameterDialog.oIdTrip|42000000007|# 要改
       # |outputparameterDialog.oType|EURO|   
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||            
               
  
 
     #And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_LOCATION", dynamicSubgraph = null and:
      #   |outputparameterDialog.oLocation|H02-HRL / 203-1-008-01-2|
      #   |outputparameterDialog.oTripID|42000000007|
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|203-1-008-01-2|    
         
     #And MDT USER_INPUT result has: graphName = "PICKING", stateName = "CONFIRM_QTY", dynamicSubgraph = null and:
      #   |outputparameterDialog.oLocation|H02-HRL / 203-1-008-01-2|
      #   |outputparameterDialog.oLabel|Körber Makeup|
      #   |outputparameterDialog.oQtyTarget|72,000 PCS|
      #   |outputparameterDialog.oTripID|42000000007|
      #   |outputparameterDialog.oIdLu|021000000041|
      And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
     #And MDT USER_INPUT result has: graphName = "PICKING", stateName = "FINISHED_PICKING_TRIP", dynamicSubgraph = null and:
      #   ||
      And 8 sec is passed
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||
      And 8 sec is passed
     #And MDT USER_INPUT result has: graphName = "DISTRIB_SUB", stateName = "INFO_DISTRIB_TRIP", dynamicSubgraph = null and:
      # |outputparameterDialog.tIdDistib|42000000007|
    
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
          ||    
     #And MDT USER_INPUT result has: graphName = "DISTRIB_SUB", stateName = "SCAN_DISTRIB_QUANT", dynamicSubgraph = null and:
         #|outputparameterDialog.tIdDistib|42000000007|
         #|outputparameterDialog.tArea|<topStorageLocation.storageArea:AndreaLocation> / <topStorageLocation.storageLocation:AndreaLocation>|
         #|outputparameterDialog.tNextCont|<lu.id:AndreaLuTarget[0]> / KOMB|
         #|outputparameterDialog.tPosition|B|
         #|outputparameterDialog.tIdLu|<lu.id:LuPiTrip[0]> / EURO|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iContainer|40067114|
         
       #And MDT USER_INPUT result has: graphName = "DISTRIB_SUB", stateName = "CONFIRM_TARGET_LOCATION", dynamicSubgraph = null and:
         #|outputparameterDialog.tIdDistib|42000000007|
         #|outputparameterDialog.tArea|<topStorageLocation.storageArea:AndreaLocation> / <topStorageLocation.storageLocation:AndreaLocation>|
         #|outputparameterDialog.tActualCont|<lu.id:AndreaLuTarget[0]> / KOMB|
         #|outputparameterDialog.tIdLu|<lu.id:LuPiTrip[0]> / EURO|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|109-1-004-01|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||
       And 5 sec is passed
       And MDT "Mdt" exit
       And reload replenishment request "Rep"
       And replenishment request "Rep" has: stat = "90"
       
   Then quantum "Qu" has available quantity 3.00 
       And there is a new quantum allocated on area "H01-FACH" location "109-1-004-01", save as "Qu2"  
       And quantum "Qu2" has available quantity 72.00 
       
   #Clean up
  Then delete quantum "Qu"   
  Then delete quantum "Qu2" 
  Then delete load unit "Lu"
##########################################################################-2-###################################################    

  Scenario Outline: replenishment-full Lu - job "REP_FIX_LOCS_ENT_H1_04" and "REP_FIX_LOCS_SITE"
  This test used job "REP_FIX_LOCS_ENT_H1_04" or "REP_FIX_LOCS_SITE" to identify the required replenishment in the store out zone "ENT_H1_04", where consists with a set of Fachboden Flatz
  In this senario, the target quantum exactly matches the required quantity of replenishment so the full LU will be directly transport to the target area.
  When run job <jobId>
      And 10 sec is passed 
  
  Then there is a replenishment request has: stat = "00", typReplenishment = "FIX_LOC", storageArea = "H01-FACH", storageLocation = "109-1-004-01", save as "Rep"
      And replenishment request "Rep" has: typReplenishment = "FIX_LOC", stat = "00", idArticle = "40067114", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_04", cntResAttemptActual = 0, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 0.0, qtyTarget = 72.0
      
  When RELEASE_REP_REQUESTS is called for:
             |Rep|
      And WEBSERVICE succeeds
      And 8 sec is passed
      And reload replenishment request "Rep"
      And replenishment request "Rep" has: typReplenishment = "FIX_LOC", stat = "20", idArticle = "40067114", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_04", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 0.0, qtyTarget = 72.0
      And replenishment request "Rep" has 1 bps records, saved as collection "RepBpsRecord"
      
      And bps record "RepBpsRecord[0]" has: typRef = "REP_REPLENISHMENT_REQUEST", matches "Rep"
      And bps record "RepBpsRecord[0]" has: idArticle = "40067114", artvar = null, qty = 72.0, typStock = "AV", typLock = "------", typSpecialStock = null, idSpecialStock = null, statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null       
       
   ##crelu lu1 
  Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
      And the load unit type is "EURO"
      And CRELU is called
	    And CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
  ##crequ qu1 in lu1
  Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 72.0 pieces of article "40067114" has to be created
      And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
      And the load unit "Lu" is the target
      And BBD is 2020/01/01 and batch is null
      And CREQU is called
	 	  And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
	 	  
	 Given the load unit "Lu" has to be booked to target location "H02-HRL"-"201-2-010-01-2" with booking type "BOOKING"
      And RELLU is called
      And RELLU was successful; transaction saved as "Transaction"
  Then Load unit "Lu" is at storage Area and Location "H02-HRL"-"201-2-010-01-2"
  
  
  
  When RESERV_REP_REQUESTS is called for:
             |Rep|
      And WEBSERVICE succeeds
      And 10 sec is passed
      And reload replenishment request "Rep"
      And replenishment request "Rep" has: typReplenishment = "FIX_LOC", stat = "20", idArticle = "40067114", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_04", cntResAttemptActual = 2, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 72.0, qtyTarget = 72.0
  
  And replenishment request "Rep" has: typReplenishment = "FIX_LOC", stat = "20", idArticle = "40067114", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_04", cntResAttemptActual = 2, cntResAttemptMax = 10, cntLuActual = null, cntLuReserved = null, cntLuTarget = null, qtyActual = 0.0, qtyReserved = 72.0, qtyTarget = 72.0
      And quantum "Qu" has available quantity 0.0
      And quantum "Qu" has reserved quantity 72.0
      Then reload bps record "RepBpsRecord[0]"
      And bps record "RepBpsRecord[0]" has: quantumSrc = "Qu", loadUnitSrc = "Lu"
      And bps record "RepBpsRecord[0]" has: areaSrc = "H02-HRL", locationSrc = "201-2-010-01-2"
      And bps record "RepBpsRecord[0]" has: areaTgt = "H01-FACH", locationTgt = "109-1-004-01"
  
  Then load unit "Lu" has 1 transport task, saved as collection "Tcs"
      And COMPLETE_TASK_EP is called with transport task "Tcs[0]"
      And reload transport task "Tcs[0]"
      And transport task "Tcs[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H02-HRL", storageLocation = "201-2-010-01-2", clProcess = "REP", typProcess = "REPL", stepProcess = "FINISH"
     
      And 10 sec is passed    
      And reload replenishment request "Rep"  
      And replenishment request "Rep" has: stat = "90"
      
      And quantum "Qu" has available quantity 72.0
      And quantum "Qu" has reserved quantity 0.0
  
 #cleanup
 Then delete quantum "Qu"
 Then delete load unit "Lu"
  
 
 Examples:
 |jobId|
 |"REP_FIX_LOCS_SITE"| 
 |"REP_FIX_LOCS_ENT_H1_04"|   

#############################################################################################################################    


    
    
    