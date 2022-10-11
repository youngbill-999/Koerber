@defaultdatabased
@goodsissue @picking @mop
Feature: Goods Issue Picking MDT MOP: 1 order in 1 picking trip and distribution

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"
  Scenario: Picking in ENTGR_01/ENTGR_04-ENT_H1_04 - one order, one picking trip, with distribution trip
    # Collegeblock
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 3.0 pieces of article "40067005" has to be created
  		And the target location is "H01-FACH"-"106-2-008-02"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu1"; transaction saved as "Transaction"

    # Shopping Bag
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.0 pieces of article "40067024" has to be created
  		And the target location is "H01-FACH"-"106-2-010-02"
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And CREQU is called
 			And CREQU was successful, saved as "Qu2"; transaction saved as "Transaction"

    # Kunde Jonas Probst = 12445
    Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "Order"
     When PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order" with: addressRef2 = "12445"
     Then WEBSERVICE succeeds
      # Collegeblock
      And order item is added to order "Order" with: numConsec = 1, idArticle = "40067005", qty = 3.0
      # Shopping Bag
      And order item is added to order "Order" with: numConsec = 2, idArticle = "40067024", qty = 2.0
     # Abschluss Erfassung (10 = Ende AVV)
     When OPP_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds          
      And 10 sec is passed
      And order "Order" is in status "10"
      And order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "10", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "10", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Versandart zuordnen
     When PLAN_LOADING_FOR_ORDER is called for "Order" with: typShipment = "DHL_PAKET"
     Then WEBSERVICE succeeds
     # Packplatz zuordnen
     When CREATE_ASSIGNMENT GI_ORDER is called with: idWorkcenter = "P-401", priority = 500 for:
        | Order |
     Then WEBSERVICE succeeds
     # Bereitstellfläche zuordnen
#    When ASSIGN_STAGING_AREA_TO_ORDER is called with: idStagingArea = "V201", idLoading = null for:
#       | Order |
#    Then WEBSERVICE succeeds
     # Freigabe BVP
     When SAC_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 3 sec is passed
      And order "Order" is in status "20"
      And order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "20", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "20", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Freigabe Reservierung
     When RES_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 5 sec is passed
      And order "Order" is in status "34"
      And order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 3.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "30", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 2.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Freigabe Bearbeitung
     When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 3 sec is passed
     Then order "Order" has 2 bps record, saved as collection "BpsRecord"
      And bps record "BpsRecord[0]" has one picking order, saved as "PiOrder[0]"
      And bps record "BpsRecord[1]" has one picking order, saved as "PiOrder[1]"
      And picking orders are equal:
        | PiOrder[0] | 
        | PiOrder[1] |
     When PICKING_TRIP_CREATION_EP is called with: idTerminal = "IPC6491" for:
        | PiOrder[0] |
     Then WEBSERVICE succeeds
     Then reload picking order "PiOrder[0]"
     Then reload picking order "PiOrder[1]"
      And picking order "PiOrder[0]" has one picking trip, saved as "PiTrip[0]"
      And picking order "PiOrder[1]" has one picking trip, saved as "PiTrip[1]"
      And picking trips are equal:
        | PiTrip[0] |
        | PiTrip[1] |
      And picking trip "PiTrip[0]" has: stat = "10", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now

     Then MDT RESTART "Mdt" is called with: idTerminal = "IPC6491"
      And MDT USER_INPUT result has: graphName = "MAIN_MENU", stateName = "START", dynamicSubgraph = null and:
         ||
      And MDT USER_INPUT "Mdt" is called with: event = "ENTER", menue = "MENU_GI", inputparameter =
         ||
      And MDT USER_INPUT "Mdt" is called with: event = "ENTER", menue = "PICKING", inputparameter =
         ||
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "INFO_CARRIER_LU_TYPE", dynamicSubgraph = null and:
         |sessionParameter.typWorkcenter|PICGDL|
         |sessionParameter.idTerminal|IPC6491|
         |sessionParameter.wcPushedback||
         |sessionParameter.idWorkcenter|PMDT-000|
         |outputparameterDialog.oIdTrip|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oType|KOMW|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||         
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_ORDER_LABEL", dynamicSubgraph = null and:
         |outputparameterDialog.oIdTrip|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.iList|A  <piOrder.id:PiOrder[0]>  KOMB   =<piOrder.id:PiOrder[0]>#\|B|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iOrderLabel|A|
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "INFO_PICK_LU_TYPE", dynamicSubgraph = null and:
         |outputparameterDialog.oIdOrder|<piOrder.id:PiOrder[0]>|
         |outputparameterDialog.oType|KOMB|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_LOCATION", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H01-FACH / 106-2-008-02|
         |outputparameterDialog.oLabel|Körber Collegeblock|
         |outputparameterDialog.oTripID|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oIdLu||
         |outputparameterDialog.oIdClient|RK1 / 40067005|
         |outputparameterDialog.oCount|2|
       And reload picking order "PiOrder[0]"
       And save load unit of picking order "PiOrder[0]" as "LuTarget[0]"
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|40067005|
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "CONFIRM_QTY", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H01-FACH / 106-2-008-02|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oLabel|Körber Collegeblock|
         |outputparameterDialog.oQtyTarget|3.0 PCS|
         |outputparameterDialog.oOrderLabel|A|
         |outputparameterDialog.oTripID|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oIdLu||
         |outputparameterDialog.oIdClient|RK1 / 40067005|
       And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_TARGET_LU", dynamicSubgraph = null and:
         |outputparameterDialog.oIdTrip|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oOrderID|<piOrder.id:PiOrder[1]>|
         |outputparameterDialog.oOrderLabel|A|
         |outputparameterDialog.oIdLuTarget|<lu.id:LuTarget[0]>|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iIdLu|<lu.id:LuTarget[0]>|
       #add state CONFIRM_ZERO  
       And MDT USER_INPUT result has: graphName = "STMPG_CNT_ZERO", stateName = "CONFIRM_ZERO", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|106-2-008-02|
         |outputparameterDialog.oLU||
         |outputparameterDialog.oArticle|40067005|
         |outputparameterDialog.oLabel|Körber Collegeblock|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oTsBbd||
        And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_LOCATION", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H01-FACH / 106-2-010-02|
         |outputparameterDialog.oLabel|Körber Shopping Bag|
         |outputparameterDialog.oTripID|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oIdLu||
         |outputparameterDialog.oIdClient|RK1 / 40067024|
         |outputparameterDialog.oCount|1|
       And reload picking order "PiOrder[0]"
       And save load unit of picking order "PiOrder[0]" as "LuTarget[0]"
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|40067024|
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "CONFIRM_QTY", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H01-FACH / 106-2-010-02|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oLabel|Körber Shopping Bag|
         |outputparameterDialog.oQtyTarget|2.0 PCS|
         |outputparameterDialog.oOrderLabel|A|
         |outputparameterDialog.oTripID|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oIdLu||
         |outputparameterDialog.oIdClient|RK1 / 40067024|
       And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_TARGET_LU", dynamicSubgraph = null and:
         |outputparameterDialog.oIdTrip|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oOrderID|<piOrder.id:PiOrder[1]>|
         |outputparameterDialog.oOrderLabel|A|
         |outputparameterDialog.oIdLuTarget|<lu.id:LuTarget[0]>|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iIdLu|<lu.id:LuTarget[0]>|
        #add state CONFIRM_ZERO  
       And MDT USER_INPUT result has: graphName = "STMPG_CNT_ZERO", stateName = "CONFIRM_ZERO", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|106-2-010-02|
         |outputparameterDialog.oLU||
         |outputparameterDialog.oArticle|40067024|
         |outputparameterDialog.oLabel|Körber Shopping Bag|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oTsBbd||
       And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "FINISHED_PICKING_TRIP", dynamicSubgraph = null and:
         ||
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||
       # distribution trip
       And reload picking trip "PiTrip[0]"
       And save load unit of picking trip "PiTrip[0]" as "LuPiTrip[0]"
       And save distribution trip of load unit id key:LuPiTrip[0] as "DiTrip"
       And distribution trip "DiTrip" has: stat = "20", typDistribTrip = "LUSTAK", idLu = ignore, idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, idUserRelease = "basis", idTerminalRelease = "IPC6491", idWorkcenterRelease = "DMDT-000", tsRelease = now, tsStart = now, tsEnd = null, priority = ignore, idStoreInZone = null, idStoreOutZone = null
       
       And reload bps record "BpsRecord[0]"
       And save tgt location of bps record "BpsRecord[0]" as "Location"
       
       And MDT USER_INPUT result has: graphName = "DISTRIB_SUB", stateName = "INFO_DISTRIB_TRIP", dynamicSubgraph = null and:
         |outputparameterDialog.tIdDistib|<distribTrip.id:DiTrip>|
         |outputparameterDialog.tTyp|LUSTAK|
         |outputparameterDialog.tCntOpenPos|1|
#         |outputparameterDialog.tPrio|500|
         |outputparameterDialog.tSIZ||
         |outputparameterDialog.tIdLu|<lu.id:LuPiTrip[0]>|
         |outputparameterDialog.tSOZ||
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "DISTRIB_SUB", stateName = "SCAN_DISTRIB_LU", dynamicSubgraph = null and:
         |outputparameterDialog.tIdDistib|<distribTrip.id:DiTrip>|
         |outputparameterDialog.tArea|<topStorageLocation.storageArea:Location> / <topStorageLocation.storageLocation:Location>|
         |outputparameterDialog.tNextCont|<lu.id:LuTarget[0]> / KOMB|
         |outputparameterDialog.tPosition|A|
         |outputparameterDialog.tIdLu|<lu.id:LuPiTrip[0]> / KOMW|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iContainer|<lu.id:LuTarget[0]>|
       And MDT USER_INPUT result has: graphName = "DISTRIB_SUB", stateName = "CONFIRM_TARGET_LOCATION", dynamicSubgraph = null and:
         |outputparameterDialog.tIdDistib|<distribTrip.id:DiTrip>|
         |outputparameterDialog.tArea|<topStorageLocation.storageArea:Location> / <topStorageLocation.storageLocation:Location>|
         |outputparameterDialog.tActualCont|<lu.id:LuTarget[0]> / KOMB|
         |outputparameterDialog.tIdLu|<lu.id:LuPiTrip[0]> / KOMW|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|<topStorageLocation.storageLocation:Location>|
       And MDT USER_INPUT result has: graphName = "DISTRIB_SUB", stateName = "FINISHED_DISTRIB_TRIP", dynamicSubgraph = null and:
         ||
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "EMPTY", dynamicSubgraph = null and:
         ||
       And MDT "Mdt" exit
       And save distribution trip of load unit id key:LuPiTrip[0] as "DiTrip"
       And distribution trip "DiTrip" has: stat = "90", typDistribTrip = "LUSTAK", idLu = ignore, idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, idUserRelease = "basis", idTerminalRelease = "IPC6491", idWorkcenterRelease = "DMDT-000", tsRelease = now, tsStart = now, tsEnd = now, priority = ignore, idStoreInZone = null, idStoreOutZone = null

      And reload picking trip "PiTrip[0]"
      And picking trip "PiTrip[0]" has: stat = "90", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now
      And order "Order" is in status "44"
      And order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 3.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "30", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 2.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now

      # check quantums
      And load unit "LuTarget[0]" has 2 quantums, saved as collection "LuTargetQu"
      And quantum "LuTargetQu[0]" has: idQuantum = ignore, idArticle = "40067005", qtyAvailable = 0.0, qtyReserved = 3.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "KOMB", storageArea = "H04-PUFFER", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, wtGross = 1620.0, vol = 1725.0
      And quantum "LuTargetQu[1]" has: idQuantum = ignore, idArticle = "40067024", qtyAvailable = 0.0, qtyReserved = 2.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "KOMB", storageArea = "H04-PUFFER", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, wtGross = 100.0, vol = 288.0

      # cleanup
      Then the load unit "LuTarget[0]" has to be booked to target location "SENKE-LAG"-"S-001" with transaction type RELLU
      When RELLU is called
      Then RELLU was successful; transaction saved as "Transaction"
      Then delete quantum "Qu1"
      Then delete quantum "Qu2"