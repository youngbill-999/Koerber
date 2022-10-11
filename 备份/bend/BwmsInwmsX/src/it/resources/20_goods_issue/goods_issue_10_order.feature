@defaultdatabased
@goodsissue @order
Feature: Goods Issue Order

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

  Scenario: Test for WA with client RK2 to make use of automated release
    Given set global: idSite = "RL1", idClient = "RK2"
    Given create batch "dc1234" for idArticle = "DC-270" saved as "dc1234" with tsBbd null
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.0 pieces of article "DC-270" has to be created
    	And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    	And the target location is "H01-FACH"-"106-2-002-01"
    	And BBD is 2030/01/01 and batch is "dc1234"
    	And CREQU is called	
    And CREQU was successful, saved as "Qu"; transaction saved as "Transaction" 
    And Create Load Unit with type "EURO" in area "H01-KLAER" at location "K-101"
    And Move Load Unit area "H01-HRL" at location "101-2-002-02"
    And order is created with: numPartialOrder = 1, idCustomer = null, typOrigin = "MAN", orderTyp = "EIL", priorityOrig = 1, priority = 1, saved as "Order"
    #40 Camcorder - Digital Camera
    And order item is added to order "Order" with: numConsec = 1, idArticle = "DC-270", qty = 2.0
    #50 Scanner DS-980DW
    And order item is added to order "Order" with: numConsec = 2, idArticle = "UP-E63", qty = 50.0
    #200 Desktop Gaming PC
    And order item is added to order "Order" with: numConsec = 3, idArticle = "9A-0A1", qty = 200.0
    When OPP_SINGLE_ORDER is called for "Order"
     And 10 sec is passed
    Then order "Order" is in status "15"
    Then order "Order" has 3 order items, saved as collection "OrderItem"
     And order item "OrderItem[0]" has: stat = "20", idArticle = "DC-270", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "SAC_STOCK_AVAIL_CHECK", tsUpd = now
     And order item "OrderItem[1]" has: stat = "15", idArticle = "UP-E63", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "SAC_STOCK_AVAIL_CHECK", tsUpd = now
     And order item "OrderItem[2]" has: stat = "15", idArticle = "9A-0A1", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "SAC_STOCK_AVAIL_CHECK", tsUpd = now
		
		 # cleanup
		Then the quantum "Qu" has to be booked to location "SENKE-LAG"-"S-001"
		When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And delete batch "dc1234" of article "DC-270"

  Scenario: Create order with customer and cancel it before release.
    Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order"
     # Customer Jonas Probst with id = 12445
     When PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order" with: addressRef2 = "12445"
     Then WEBSERVICE succeeds
      And order item is added to order "Order" with: numConsec = 1, idArticle = "40067005", qty = 300.0
      And order item is added to order "Order" with: numConsec = 2, idArticle = "40067007", qty = 1800.0
     # Finish Create Order / Abschluss Erfassung (10 = Ende AVV)
     When OPP_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 10 sec is passed
      And order "Order" is in status "10"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "10", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "10", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
     # Assign Shipping Typ / Versandart zuordnen
     When SAC_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 3 sec is passed
      And order "Order" is in status "15"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "15", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "15", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
     When CANCEL_ORDERS_EP is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 3 sec is passed
      And order "Order" is in status "80"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "80", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0300.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "80", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 1800.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   

				# Scenario ends after cancellation of order. It is the base for further tests with an order.


  Scenario: Create order with customer and release it to shipment area.
    Given the parameter "FLG_CHECK_SSCC" of workcenter "P-203" is set to "0"
    Given RECEIVING_CREATE_RECEIVING is called with: idWorkcenter = "W400-101", idTerminal = "IPC6475", idGoodsReceipt = null, idArticle = "40067005", numGoodsReceiptItem = null, typLu = "EURO", artvar = "2", countEntities = 10.0, countGrippingUnit = null, qtyPerEntity = 30.0, qtyRemaining = null, qtyForBooking = 300.0, idBatch = null, tsBbd = null, typSpecialStock = null, idSpecialStock = null, storageArea = "H01-HRL", storageLocation = null, storeInZoneGroup = null, idLu = null, height = 50.0, repeatBooking = 1, controllerClass = "GR400"
     Then RECEIVING_CREATE_RECEIVING result is saved as "Receiving"; result has 1 load unit, saved as collection "GrLu"; result has: booking = true, isFinishedSetUp = true
      And load unit "GrLu[0]" has 1 transport task, saved as collection "GrLu[0]Task"
      And COMPLETE_TASK_EP is called with transport task "GrLu[0]Task[0]"
      And reload transport task "GrLu[0]Task[0]"
      And transport task "GrLu[0]Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"
    Given RECEIVING_CREATE_RECEIVING is called with: idWorkcenter = "W400-101", idTerminal = "IPC6475", idGoodsReceipt = null, idArticle = "40067007", numGoodsReceiptItem = null, typLu = "EURO", artvar = "1", countEntities = null, countGrippingUnit = null, qtyPerEntity = null, qtyRemaining = null, qtyForBooking = 1800.0, idBatch = null, tsBbd = null, typSpecialStock = null, idSpecialStock = null, storageArea = "H01-HRL", storageLocation = null, storeInZoneGroup = null, idLu = null, height = 150.0, repeatBooking = 1, controllerClass = "GR400"
     Then RECEIVING_CREATE_RECEIVING result is saved as "Receiving"; result has 1 load unit, saved as collection "GrLu"; result has: booking = true, isFinishedSetUp = true
      And load unit "GrLu[0]" has 1 transport task, saved as collection "GrLu[0]Task"
      And COMPLETE_TASK_EP is called with transport task "GrLu[0]Task[0]"
      And reload transport task "GrLu[0]Task[0]"
      And transport task "GrLu[0]Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"

    Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order"
     # Customer Jonas Probst with id = 12445
     When PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order" with: addressRef2 = "12445"
     Then WEBSERVICE succeeds
      And order item is added to order "Order" with: numConsec = 1, idArticle = "40067005", qty = 300.0
      And order item is added to order "Order" with: numConsec = 2, idArticle = "40067007", qty = 1800.0
     # Finish Create Order / Abschluss Erfassung (10 = Ende AVV)
     When OPP_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds          
      And 10 sec is passed
      And order "Order" is in status "10"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "10", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "10", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
     # Assign Shipping Typ / Versandart zuordnen
     When PLAN_LOADING_FOR_ORDER is called for "Order" with: typShipment = "SPEDITION"
     Then WEBSERVICE succeeds
     # Assign Packing Station / Packplatz zuordnen
     When CREATE_ASSIGNMENT GI_ORDER is called with: idWorkcenter = "P-201", priority = 500 for:
        | Order |
     Then WEBSERVICE succeeds
     # Assign Staging Area / Bereitstellfläche zuordnen
     When ASSIGN_STAGING_AREA_TO_ORDER is called with: idStagingArea = "V201", idLoading = null for:
        | Order |
     Then WEBSERVICE succeeds
     # Release Stock Availability Check / Freigabe BVP
     When SAC_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 3 sec is passed
      And order "Order" is in status "20"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "20", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "20", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
     # Release Reservation / Freigabe Reservierung
     When RES_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 5 sec is passed
      And order "Order" is in status "30"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0300.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "30", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 1800.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
     # Release Order(s) / Freigabe Bearbeitung
     When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 3 sec is passed
      And order "Order" is in status "34"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0300.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "30", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 1800.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
     Then order "Order" has 2 bps record, saved as collection "BpsRecord"
     Then save src load unit of bps record "BpsRecord[0]" as "Lu[0]"      
      And save current transport task of load unit "Lu[0]" as "Task[0]"
      And COMPLETE_TASK_EP is called with transport task "Task[0]"
      And reload transport task "Task[0]"
      And transport task "Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-HRL", storageLocation = ignore, clProcess = "PA", typProcess = "PRINTING", stepProcess = "RELEASE"
     Then save src load unit of bps record "BpsRecord[1]" as "Lu[1]"
      And save current transport task of load unit "Lu[1]" as "Task[1]"
      And COMPLETE_TASK_EP is called with transport task "Task[1]"
      And reload transport task "Task[1]"
      And transport task "Task[1]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-HRL", storageLocation = ignore, clProcess = "PA", typProcess = "PRINTING", stepProcess = "RELEASE"
      And 3 sec is passed
      And order "Order" is in status "48"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0300.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "30", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 1800.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
     # Package state 50 (packed) / PS status 50 (gepackt)
      
     # Complete Package at Packing Station / Abschluss PS am Druckplatz
     Then COMPLETE_BPS_RECORD is called for with: packageLu = key:Lu[0], idWorkcenter = "P-203"
     Then COMPLETE_BPS_RECORD is called for with: packageLu = key:Lu[1], idWorkcenter = "P-203"
      And 3 sec is passed
      And save current transport task of load unit "Lu[0]" as "Task[0]"
      And COMPLETE_TASK_EP is called with transport task "Task[0]"
      And reload transport task "Task[0]"
      And transport task "Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H02-PACK", storageLocation = "P-203", clProcess = "PA", typProcess = "PRINTING", stepProcess = "FINISH"
      And save current transport task of load unit "Lu[1]" as "Task[1]"
      And COMPLETE_TASK_EP is called with transport task "Task[1]"
      And reload transport task "Task[1]"
      And transport task "Task[1]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H02-PACK", storageLocation = "P-203", clProcess = "PA", typProcess = "PRINTING", stepProcess = "FINISH"
     # Package state 60 (ready) / PS status 60 (bereitgestellt)
      And 1 sec are passed
      And order "Order" is in status "60"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0300.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "30", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 1800.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
      And 3 sec is passed
     Then order "Order" has 2 packages, saved as collection "Package"
      And package "Package[0]" has: stat = "60", idLu = key:Lu[0], typ = "NORM", idCre = "BPS_SCHEDULER", tsCre = now, idUpd = "basis", tsUpd = now
      And package "Package[1]" has: stat = "60", idLu = key:Lu[1], typ = "NORM", idCre = "BPS_SCHEDULER", tsCre = now, idUpd = "basis", tsUpd = now
     # Create Loading / Verladung anlegen
      And create loading "Loading" with: gate = "T101", typShipment = "SPEDITION"
     # Assign Order to created Loading / Auftrag zuweisen
     Then ASSIGN_ORDER_TO_LOADING "Loading" is called with: idStagingArea = null for:
          |Order|
     Then WEBSERVICE succeeds
    
    #Scenario ends with the completion of Packaging. It is the base for further tests.
    #Clean-up
    Then the parameter "FLG_CHECK_SSCC" of workcenter "P-203" is set to "1"
