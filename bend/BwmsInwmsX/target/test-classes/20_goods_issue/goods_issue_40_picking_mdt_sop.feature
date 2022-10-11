@defaultdatabased
@goodsissue @picking @sop

Feature: Goods Issue Picking MDT SOP

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

  Scenario: Picking SOP in ENTGR_01-ENT_H3_01 - one order, one picking trip
    # Collegeblock
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "LuCollegeblock-1"; transaction saved as "Transaction"
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "LuCollegeblock-2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuCollegeblock"; transaction saved as "Transaction"
    And the quantum "QuCollegeblock" has to be booked to target load unit "LuCollegeblock-2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "LuCollegeblock-2" has to be stacked on the load unit "LuCollegeblock-1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"   
    When the load unit "LuCollegeblock-1" has to be booked to target location "H03-SCHMAL"-"301-1-001-01" with transaction type RELLU
    And RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"

    # Shopping Bag
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "LuBag-1"; transaction saved as "Transaction"
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "LuBag-2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuBag"; transaction saved as "Transaction"
    And the quantum "QuBag" has to be booked to target load unit "LuBag-2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "LuBag-2" has to be stacked on the load unit "LuBag-1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"   
    When the load unit "LuBag-1" has to be booked to target location "H03-SCHMAL"-"301-1-002-01" with transaction type RELLU
    And RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"


     # Kunde Jonas Probst = 12445
    Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "Order"
     When PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order" with: addressRef2 = "12445"
     Then WEBSERVICE succeeds
      # Collegeblock
      And order item is added to order "Order" with: numConsec = 1, idArticle = "40067005", qty = 1.0
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
     When PLAN_LOADING_FOR_ORDER is called for "Order" with: typShipment = "DHL_BRIEF"
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
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 1.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
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
      And picking order "PiOrder[0]" has one picking trip, saved as "PiTrip[0]"
      And picking trip "PiTrip[0]" has: stat = "10", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now

     Then MDT RESTART "Mdt" is called with: idTerminal = "IPC6460"
      And MDT USER_INPUT result has: graphName = "MAIN_MENU", stateName = "START", dynamicSubgraph = null and:
         ||
      And MDT USER_INPUT "Mdt" is called with: event = "ENTER", menue = "MENU_GI", inputparameter =
         ||
      And MDT USER_INPUT "Mdt" is called with: event = "ENTER", menue = "PICKING", inputparameter =
         ||
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "INFO_PICK_LU_TYPE", dynamicSubgraph = null and:
         |sessionParameter.typWorkcenter|PICGDL|
         |sessionParameter.idTerminal|IPC6460|
         |sessionParameter.wcPushedback||
         |sessionParameter.idWorkcenter|PMDT-000|
         |outputparameterDialog.oIdOrder|<piOrder.id:PiOrder[0]>|
         |outputparameterDialog.oType|EURO|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_LOCATION", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-001-01|
         |outputparameterDialog.oLabel|Körber Collegeblock|
         |outputparameterDialog.oTripID|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuCollegeblock-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067005|
         |outputparameterDialog.oCount|2|
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|301-1-001-01|
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "CONFIRM_QTY", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-001-01|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oLabel|Körber Collegeblock|
         |outputparameterDialog.oQtyTarget|1.0 PCS|
         |outputparameterDialog.oOrderLabel|""|
         |outputparameterDialog.oTripID|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuCollegeblock-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067005|
      And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_LOCATION", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-002-01|
         |outputparameterDialog.oLabel|Körber Shopping Bag|
         |outputparameterDialog.oTripID|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuBag-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067024|
         |outputparameterDialog.oCount|1|
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|301-1-002-01|
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "CONFIRM_QTY", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-002-01|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oLabel|Körber Shopping Bag|
         |outputparameterDialog.oQtyTarget|2.0 PCS|
         |outputparameterDialog.oOrderLabel|""|
         |outputparameterDialog.oTripID|<piTrip.id:PiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuBag-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067024|
       And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_DEPOSITION_LOC", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|000-0-000-00|
         |outputparameterDialog.oArea|H03-SCHMAL|
         |outputparameterDialog.oTripID|<piTrip.id:PiTrip[0]>|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|000-0-000-00|
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "EMPTY", dynamicSubgraph = null and:
         ||
       And MDT "Mdt" exit

      And reload picking trip "PiTrip[0]"
      And picking trip "PiTrip[0]" has: stat = "90", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now
      And order "Order" is in status "44"
      And order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 1.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "30", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 2.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now

      And reload picking order "PiOrder[0]"
      And save load unit of picking order "PiOrder[0]" as "LuTarget[0]"
      And load unit "LuTarget[0]" has 1 transport task, saved as collection "LuTarget[0]Task"
      And COMPLETE_TASK_EP is called with transport task "LuTarget[0]Task[0]"
      And reload transport task "LuTarget[0]Task[0]"
      And transport task "LuTarget[0]Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H03-SCHMAL", storageLocation = "000-0-000-00", clProcess = "GI", typProcess = "PICKING", stepProcess = "FINISH"

      # check quantums
      And load unit "LuTarget[0]" has 2 quantums, saved as collection "LuTargetQu"
      And quantum "LuTargetQu[0]" has: idQuantum = ignore, idArticle = "40067005", qtyAvailable = 0.0, qtyReserved = 1.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H04-PUFFER", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, wtGross = 540.0, vol = 575.0
      And quantum "LuTargetQu[1]" has: idQuantum = ignore, idArticle = "40067024", qtyAvailable = 0.0, qtyReserved = 2.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H04-PUFFER", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, wtGross = 100.0, vol = 288.0

      # cleanup
      Then the quantum "QuCollegeblock" has to be booked to location "SENKE-LAG"-"S-001"
      When RELQU is called
      Then RELQU was successful; transaction saved as "Transaction"
      Then the quantum "QuBag" has to be booked to location "SENKE-LAG"-"S-001"
      When RELQU is called
      Then RELQU was successful; transaction saved as "Transaction"


  Scenario: Picking SOP in ENTGR_01-ENT_H3_01 - two orders, two picking trips
    # Collegeblock
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "LuCollegeblock-1"; transaction saved as "Transaction"
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "LuCollegeblock-2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067005" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuCollegeblock"; transaction saved as "Transaction"
    And the quantum "QuCollegeblock" has to be booked to target load unit "LuCollegeblock-2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "LuCollegeblock-2" has to be stacked on the load unit "LuCollegeblock-1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"   
    When the load unit "LuCollegeblock-1" has to be booked to target location "H03-SCHMAL"-"301-1-001-01" with transaction type RELLU
    And RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"

    # Shopping Bag
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "LuBag-1"; transaction saved as "Transaction"
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "LuBag-2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuBag"; transaction saved as "Transaction"
    And the quantum "QuBag" has to be booked to target load unit "LuBag-2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "LuBag-2" has to be stacked on the load unit "LuBag-1"
    When STALU is called
    Then STALU was successful; transaction saved as "Transaction"   
    When the load unit "LuBag-1" has to be booked to target location "H03-SCHMAL"-"301-1-002-01" with transaction type RELLU
    And RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"


     # Kunde Jonas Probst = 12445
    Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "JonasOrder"
     When PERSIST_ADDRESS_FROM_CUSTOMER is called for "JonasOrder" with: addressRef2 = "12445"
     Then WEBSERVICE succeeds
      # Collegeblock
      And order item is added to order "JonasOrder" with: numConsec = 1, idArticle = "40067005", qty = 1.0
      # Shopping Bag
      And order item is added to order "JonasOrder" with: numConsec = 2, idArticle = "40067024", qty = 2.0
     # Abschluss Erfassung (10 = Ende AVV)
     When OPP_LIST_ORDER is called for:
        | JonasOrder |
     Then WEBSERVICE succeeds          
      And 10 sec is passed
      And order "JonasOrder" is in status "10"
      And order "JonasOrder" has 2 order items, saved as collection "JonasOrderItem"
      And order item "JonasOrderItem[0]" has: stat = "10", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "JonasOrderItem[1]" has: stat = "10", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Versandart zuordnen
     When PLAN_LOADING_FOR_ORDER is called for "JonasOrder" with: typShipment = "DHL_BRIEF"
     Then WEBSERVICE succeeds
     # Packplatz zuordnen
     When CREATE_ASSIGNMENT GI_ORDER is called with: idWorkcenter = "P-401", priority = 500 for:
        | JonasOrder |
     Then WEBSERVICE succeeds
     # Bereitstellfläche zuordnen
#    When ASSIGN_STAGING_AREA_TO_ORDER is called with: idStagingArea = "V201", idLoading = null for:
#       | JonasOrder |
#    Then WEBSERVICE succeeds
     # Freigabe BVP
     When SAC_LIST_ORDER is called for:
        | JonasOrder |
     Then WEBSERVICE succeeds
      And 3 sec is passed
      And order "JonasOrder" is in status "20"
      And order "JonasOrder" has 2 order items, saved as collection "JonasOrderItem"
      And order item "JonasOrderItem[0]" has: stat = "20", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "JonasOrderItem[1]" has: stat = "20", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Freigabe Reservierung
     When RES_LIST_ORDER is called for:
        | JonasOrder |
     Then WEBSERVICE succeeds
      And 5 sec is passed
      And order "JonasOrder" is in status "34"
      And order "JonasOrder" has 2 order items, saved as collection "JonasOrderItem"
      And order item "JonasOrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 1.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "JonasOrderItem[1]" has: stat = "30", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 2.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Freigabe Bearbeitung
     When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | JonasOrder |
     Then WEBSERVICE succeeds
      And 3 sec is passed
     Then order "JonasOrder" has 2 bps record, saved as collection "JonasBpsRecord"
      And bps record "JonasBpsRecord[0]" has one picking order, saved as "JonasPiOrder[0]"
      And bps record "JonasBpsRecord[1]" has one picking order, saved as "JonasPiOrder[1]"
      And picking orders are equal:
        | JonasPiOrder[0] |
        | JonasPiOrder[1] |

     # Kunde Andrea Saenger = 12998
    Given order is created with: numPartialOrder = 0, idCustomer = "12998", typOrigin = "NORM", orderTyp = "NORM", priorityOrig = 500, priority = null, saved as "AndreaOrder"
     When PERSIST_ADDRESS_FROM_CUSTOMER is called for "AndreaOrder" with: addressRef2 = "12998"
     Then WEBSERVICE succeeds
      # Collegeblock
      And order item is added to order "AndreaOrder" with: numConsec = 1, idArticle = "40067005", qty = 1.0
      # Shopping Bag
      And order item is added to order "AndreaOrder" with: numConsec = 2, idArticle = "40067024", qty = 2.0
     # Abschluss Erfassung (10 = Ende AVV)
     When OPP_LIST_ORDER is called for:
        | AndreaOrder |
     Then WEBSERVICE succeeds          
      And 10 sec is passed
      And order "AndreaOrder" is in status "10"
      And order "AndreaOrder" has 2 order items, saved as collection "AndreaOrderItem"
      And order item "AndreaOrderItem[0]" has: stat = "10", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "AndreaOrderItem[1]" has: stat = "10", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Versandart zuordnen
     When PLAN_LOADING_FOR_ORDER is called for "AndreaOrder" with: typShipment = "DHL_BRIEF"
     Then WEBSERVICE succeeds
     # Packplatz zuordnen
     When CREATE_ASSIGNMENT GI_ORDER is called with: idWorkcenter = "P-401", priority = 500 for:
        | AndreaOrder |
     Then WEBSERVICE succeeds
     # Bereitstellfläche zuordnen
#    When ASSIGN_STAGING_AREA_TO_ORDER is called with: idStagingArea = "V201", idLoading = null for:
#       | AndreaOrder |
#    Then WEBSERVICE succeeds
     # Freigabe BVP
     When SAC_LIST_ORDER is called for:
        | AndreaOrder |
     Then WEBSERVICE succeeds
      And 3 sec is passed
      And order "AndreaOrder" is in status "20"
      And order "AndreaOrder" has 2 order items, saved as collection "AndreaOrderItem"
      And order item "AndreaOrderItem[0]" has: stat = "20", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "AndreaOrderItem[1]" has: stat = "20", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Freigabe Reservierung
     When RES_LIST_ORDER is called for:
        | AndreaOrder |
     Then WEBSERVICE succeeds
      And 5 sec is passed
      And order "AndreaOrder" is in status "34"
      And order "AndreaOrder" has 2 order items, saved as collection "AndreaOrderItem"
      And order item "AndreaOrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 1.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "AndreaOrderItem[1]" has: stat = "30", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 2.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Freigabe Bearbeitung
     When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | AndreaOrder |
     Then WEBSERVICE succeeds
      And 3 sec is passed
     Then order "AndreaOrder" has 2 bps record, saved as collection "AndreaBpsRecord"
      And bps record "AndreaBpsRecord[0]" has one picking order, saved as "AndreaPiOrder[0]"
      And bps record "AndreaBpsRecord[1]" has one picking order, saved as "AndreaPiOrder[1]"
      And picking orders are equal:
        | AndreaPiOrder[0] |
        | AndreaPiOrder[1] |

      And picking orders are unequal:
        | JonasPiOrder[0] |
        | AndreaPiOrder[0] |
     When PICKING_TRIP_CREATION_EP is called with: idTerminal = "IPC6491" for:
        | JonasPiOrder[0] |
        | AndreaPiOrder[0] |
     Then WEBSERVICE succeeds
     Then reload picking order "JonasPiOrder[0]"
      And picking order "JonasPiOrder[0]" has one picking trip, saved as "JonasPiTrip[0]"
      And picking trip "JonasPiTrip[0]" has: stat = "10", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now
     Then reload picking order "AndreaPiOrder[0]"
      And picking order "AndreaPiOrder[0]" has one picking trip, saved as "AndreaPiTrip[0]"
      And picking trip "AndreaPiTrip[0]" has: stat = "10", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now

      And picking trips are unequal:
        | JonasPiTrip[0] |
        | AndreaPiTrip[0] |

      # Picking for JonasOrder
     Then MDT RESTART "Mdt" is called with: idTerminal = "IPC6460"
      And MDT USER_INPUT result has: graphName = "MAIN_MENU", stateName = "START", dynamicSubgraph = null and:
         ||
      And MDT USER_INPUT "Mdt" is called with: event = "ENTER", menue = "MENU_GI", inputparameter =
         ||
      And MDT USER_INPUT "Mdt" is called with: event = "ENTER", menue = "PICKING", inputparameter =
         ||
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "INFO_PICK_LU_TYPE", dynamicSubgraph = null and:
         |sessionParameter.typWorkcenter|PICGDL|
         |sessionParameter.idTerminal|IPC6460|
         |sessionParameter.wcPushedback||
         |sessionParameter.idWorkcenter|PMDT-000|
         |outputparameterDialog.oIdOrder|<piOrder.id:JonasPiOrder[0]>|
         |outputparameterDialog.oType|EURO|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||         
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_LOCATION", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-001-01|
         |outputparameterDialog.oLabel|Körber Collegeblock|
         |outputparameterDialog.oTripID|<piTrip.id:JonasPiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuCollegeblock-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067005|
         |outputparameterDialog.oCount|2|
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|301-1-001-01|
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "CONFIRM_QTY", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-001-01|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oLabel|Körber Collegeblock|
         |outputparameterDialog.oQtyTarget|1.0 PCS|
         |outputparameterDialog.oOrderLabel|""|
         |outputparameterDialog.oTripID|<piTrip.id:JonasPiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuCollegeblock-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067005|
      And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_LOCATION", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-002-01|
         |outputparameterDialog.oLabel|Körber Shopping Bag|
         |outputparameterDialog.oTripID|<piTrip.id:JonasPiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuBag-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067024|
         |outputparameterDialog.oCount|1|
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|301-1-002-01|
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "CONFIRM_QTY", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-002-01|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oLabel|Körber Shopping Bag|
         |outputparameterDialog.oQtyTarget|2.0 PCS|
         |outputparameterDialog.oOrderLabel|""|
         |outputparameterDialog.oTripID|<piTrip.id:JonasPiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuBag-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067024|
       And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_DEPOSITION_LOC", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|000-0-000-00|
         |outputparameterDialog.oArea|H03-SCHMAL|
         |outputparameterDialog.oTripID|<piTrip.id:JonasPiTrip[0]>|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|000-0-000-00|

      # Picking for AndreaOrder
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "INFO_PICK_LU_TYPE", dynamicSubgraph = null and:
         |sessionParameter.typWorkcenter|PICGDL|
         |sessionParameter.idTerminal|IPC6460|
         |sessionParameter.wcPushedback||
         |sessionParameter.idWorkcenter|PMDT-000|
         |outputparameterDialog.oIdOrder|<piOrder.id:AndreaPiOrder[0]>|
         |outputparameterDialog.oType|EURO|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         ||         
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_LOCATION", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-001-01|
         |outputparameterDialog.oLabel|Körber Collegeblock|
         |outputparameterDialog.oTripID|<piTrip.id:AndreaPiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuCollegeblock-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067005|
         |outputparameterDialog.oCount|2|
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|301-1-001-01|
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "CONFIRM_QTY", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-001-01|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oLabel|Körber Collegeblock|
         |outputparameterDialog.oQtyTarget|1.0 PCS|
         |outputparameterDialog.oOrderLabel|""|
         |outputparameterDialog.oTripID|<piTrip.id:AndreaPiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuCollegeblock-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067005|
      And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_LOCATION", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-002-01|
         |outputparameterDialog.oLabel|Körber Shopping Bag|
         |outputparameterDialog.oTripID|<piTrip.id:AndreaPiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuBag-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067024|
         |outputparameterDialog.oCount|1|
      And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|301-1-002-01|
      And MDT USER_INPUT result has: graphName = "PICKING", stateName = "CONFIRM_QTY", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|H03-SCHMAL / 301-1-002-01|
         |outputparameterDialog.oBatch||
         |outputparameterDialog.oLabel|Körber Shopping Bag|
         |outputparameterDialog.oQtyTarget|2.0 PCS|
         |outputparameterDialog.oOrderLabel|""|
         |outputparameterDialog.oTripID|<piTrip.id:AndreaPiTrip[0]>|
         |outputparameterDialog.oIdLu|<lu.id:LuBag-2>|
         |outputparameterDialog.oIdClient|RK1 / 40067024|
       And MDT USER_INPUT "Mdt" is called with: event = "BF4", menue = null, inputparameter =
         ||
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "SCAN_DEPOSITION_LOC", dynamicSubgraph = null and:
         |outputparameterDialog.oLocation|000-0-000-00|
         |outputparameterDialog.oArea|H03-SCHMAL|
         |outputparameterDialog.oTripID|<piTrip.id:AndreaPiTrip[0]>|
       And MDT USER_INPUT "Mdt" is called with: event = "BENTER", menue = null, inputparameter =
         |iLocation|000-0-000-00|
       And MDT USER_INPUT result has: graphName = "PICKING", stateName = "EMPTY", dynamicSubgraph = null and:
         ||
       And MDT "Mdt" exit

      And reload picking trip "JonasPiTrip[0]"
      And picking trip "JonasPiTrip[0]" has: stat = "90", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now
      And reload picking trip "AndreaPiTrip[0]"
      And picking trip "AndreaPiTrip[0]" has: stat = "90", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now

      And order "JonasOrder" is in status "44"
      And order "JonasOrder" has 2 order items, saved as collection "JonasOrderItem"
      And order item "JonasOrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 1.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "JonasOrderItem[1]" has: stat = "30", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 2.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order "AndreaOrder" is in status "44"
      And order "AndreaOrder" has 2 order items, saved as collection "AndreaOrderItem"
      And order item "AndreaOrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 1.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "AndreaOrderItem[1]" has: stat = "30", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 2.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now

      And reload picking order "JonasPiOrder[0]"
      And save load unit of picking order "JonasPiOrder[0]" as "JonasLuTarget[0]"
      And load unit "JonasLuTarget[0]" has 1 transport task, saved as collection "JonasLuTarget[0]Task"
      And COMPLETE_TASK_EP is called with transport task "JonasLuTarget[0]Task[0]"
      And reload transport task "JonasLuTarget[0]Task[0]"
      And transport task "JonasLuTarget[0]Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H03-SCHMAL", storageLocation = "000-0-000-00", clProcess = "GI", typProcess = "PICKING", stepProcess = "FINISH"
      And reload picking order "AndreaPiOrder[0]"
      And save load unit of picking order "AndreaPiOrder[0]" as "AndreaLuTarget[0]"
      And load unit "AndreaLuTarget[0]" has 1 transport task, saved as collection "AndreaLuTarget[0]Task"
      And COMPLETE_TASK_EP is called with transport task "AndreaLuTarget[0]Task[0]"
      And reload transport task "AndreaLuTarget[0]Task[0]"
      And transport task "AndreaLuTarget[0]Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H03-SCHMAL", storageLocation = "000-0-000-00", clProcess = "GI", typProcess = "PICKING", stepProcess = "FINISH"

      # check quantums
      And load unit "JonasLuTarget[0]" has 2 quantums, saved as collection "JonasLuTargetQu"
      And quantum "JonasLuTargetQu[0]" has: idQuantum = ignore, idArticle = "40067005", qtyAvailable = 0.0, qtyReserved = 1.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H04-PUFFER", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, wtGross = 540.0, vol = 575.0
      And quantum "JonasLuTargetQu[1]" has: idQuantum = ignore, idArticle = "40067024", qtyAvailable = 0.0, qtyReserved = 2.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H04-PUFFER", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, wtGross = 100.0, vol = 288.0
      And load unit "AndreaLuTarget[0]" has 2 quantums, saved as collection "AndreaLuTargetQu"
      And quantum "AndreaLuTargetQu[0]" has: idQuantum = ignore, idArticle = "40067005", qtyAvailable = 0.0, qtyReserved = 1.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H04-PUFFER", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, wtGross = 540.0, vol = 575.0
      And quantum "AndreaLuTargetQu[1]" has: idQuantum = ignore, idArticle = "40067024", qtyAvailable = 0.0, qtyReserved = 2.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H04-PUFFER", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, wtGross = 100.0, vol = 288.0

      # cleanup
      Then the quantum "QuCollegeblock" has to be booked to location "SENKE-LAG"-"S-001"
      When RELQU is called
      Then RELQU was successful; transaction saved as "Transaction"
      Then the quantum "QuBag" has to be booked to location "SENKE-LAG"-"S-001"
      When RELQU is called
      Then RELQU was successful; transaction saved as "Transaction"

