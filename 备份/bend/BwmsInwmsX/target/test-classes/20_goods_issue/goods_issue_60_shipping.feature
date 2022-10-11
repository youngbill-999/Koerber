@defaultdatabased
@goodsissue @shipping

Feature: Goods Issue Shipping

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario: Create order withour customer and finish loading with SHIP400 and transport vehicle.
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

    Given order is created with: numPartialOrder = 0, idCustomer = "", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order"
     # Do not select a customer here! 
		 # Die Angabe eines eines Kunden führt (laut aktueller Konfiguration) zur einer MDT-gesteuerten Verladung, nicht zum Dialog SHIP400, der hier getestet wird.
      And order item is added to order "Order" with: numConsec = 1, idArticle = "40067005", qty = 300.0
      And order item is added to order "Order" with: numConsec = 2, idArticle = "40067007", qty = 1800.0
     # Finish Create Order / Abschluss Erfassung (10 = Ende AVV)
     When OPP_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds          
      And 20 sec is passed
      And order "Order" is in status "10"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "10", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "10", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
     # Assign Shipping Typ / Versandart zuordnen
     When PLAN_LOADING_FOR_ORDER is called for "Order" with: typShipment = "SPED_INT"
     Then WEBSERVICE succeeds
     # Assign Packing Station / Packplatz zuordnen
     When CREATE_ASSIGNMENT GI_ORDER is called with: idWorkcenter = "P-301", priority = 500 for:
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
      And 5 sec is passed
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
      And 5 sec is passed
      And order "Order" is in status "34"
     Then order "Order" has 2 bps record, saved as collection "BpsRecord"
     Then save src load unit of bps record "BpsRecord[0]" as "Lu[0]"      
      And save current transport task of load unit "Lu[0]" as "Task[0]"
      And COMPLETE_TASK_EP is called with transport task "Task[0]"
      And 5 sec is passed
      And reload transport task "Task[0]"
      And transport task "Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-HRL", storageLocation = ignore, clProcess = "PA", typProcess = "PRINTING", stepProcess = "RELEASE"
     Then save src load unit of bps record "BpsRecord[1]" as "Lu[1]"
      And save current transport task of load unit "Lu[1]" as "Task[1]"
      And COMPLETE_TASK_EP is called with transport task "Task[1]"
      And reload transport task "Task[1]"
      And transport task "Task[1]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-HRL", storageLocation = ignore, clProcess = "PA", typProcess = "PRINTING", stepProcess = "RELEASE"
      And 10 sec is passed
      And order "Order" is in status "48"
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
      And 3 sec is passed
      And reload transport task "Task[1]"
      And transport task "Task[1]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H02-PACK", storageLocation = "P-203", clProcess = "PA", typProcess = "PRINTING", stepProcess = "FINISH"
     # Package state 60 (ready) / PS status 60 (bereitgestellt)
      And order "Order" is in status "60"
     Then order "Order" has 2 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0300.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "30", idArticle = "40067007", qtyActual = 0.0, qtyReserved = 1800.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now   
      And 3 sec is passed
     Then order "Order" has 2 packages, saved as collection "Package"
      And package "Package[0]" has: stat = "60", idLu = key:Lu[0], typ = "NORM", idCre = "BPS_SCHEDULER", tsCre = now, idUpd = "basis", tsUpd = now
      And package "Package[1]" has: stat = "60", idLu = key:Lu[1], typ = "NORM", idCre = "BPS_SCHEDULER", tsCre = now, idUpd = "basis", tsUpd = now
     Then create transport vehicle: nameDriver = "Hans Schmidt", truckLicensePlate = "HS-TB-123", tour = 12345, typ = "OUT"
      And 2 sec is passed
    
     # Create Loading / Verladung anlegen
      And create loading "Loading" with: gate = "T101", typShipment = "SPED_INT"
     # Assign Order to created Loading / Order zuweisen
     Then ASSIGN_ORDER_TO_LOADING "Loading" is called with: idStagingArea = null for:
          |Order|
     Then WEBSERVICE succeeds
      And START_LOADING is called for "Loading" with: idWorkcenter = "V-000"
     Then WEBSERVICE succeeds
      And LOAD_ORDER is called for "Order" with: idTerminal = "IPC6460", idWorkcenter = "V-000", numPartialOrder = 0
     Then WEBSERVICE succeeds
      And order "Order" is in status "70"
      And FINISH_LOADING is called for "Loading" with: idWorkcenter = "V-000", idTerminal = "IPC6460"
     Then WEBSERVICE succeeds
      And 2 sec is passed
      And order "Order" is in status "90"
      
      # Scenario ends with finishing loading and completing order.
      #Clean-up
      Then the parameter "FLG_CHECK_SSCC" of workcenter "P-203" is set to "1"
      
      