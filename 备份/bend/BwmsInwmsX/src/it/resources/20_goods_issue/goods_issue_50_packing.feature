@defaultdatabased
@goodsissue @packing

Feature: Goods Issue Packing

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

  Scenario: Packing PAC500
    #Collegeblocke
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 3.0 pieces of article "40067005" has to be created
    And the target location is "H01-FACH"-"106-2-008-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"

    # Makeup
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "LuMakeup-1"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1.0 pieces of article "40067114" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And BBD is 2021/03/12 and batch is null
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "QuMakeup"; transaction saved as "Transaction"
    And the quantum "QuMakeup" has to be booked to target load unit "LuMakeup-1"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
  	And the load unit "LuMakeup-1" has to be booked to target location "H01-HRL"-"104-1-005-01" with transaction type RELLU
    When RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"

    # Shopping Bag
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "LuBag-1"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.0 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "QuBag"; transaction saved as "Transaction"
    And the quantum "QuBag" has to be booked to target load unit "LuBag-1"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
   When the load unit "LuBag-1" has to be booked to target location "H01-HRL"-"104-1-007-01" with transaction type RELLU
    And RELLU is called
   Then RELLU was successful; transaction saved as "Transaction"
   
     
  
    Given order is created with: numPartialOrder = 0, idCustomer = "12445", typOrigin = "NOT", orderTyp = "NOT", priorityOrig = 500, priority = null, saved as "Order"
     # Customer Jonas Probst with id = 12445
     When PERSIST_ADDRESS_FROM_CUSTOMER is called for "Order" with: addressRef2 = "12445"
     Then WEBSERVICE succeeds
      # Collegeblock
      And order item is added to order "Order" with: numConsec = 1, idArticle = "40067005", qty = 3.0
      # Shopping Bag
      And order item is added to order "Order" with: numConsec = 2, idArticle = "40067024", qty = 2.0
      # Makeup
      And order item is added to order "Order" with: numConsec = 3, idArticle = "40067114", qty = 1.0

     # Finish Create Order / Abschluss Erfassung (10 = Ende AVV)
     When OPP_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 10 sec is passed
      And order "Order" is in status "10"
      And order "Order" has 3 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "10", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "10", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[2]" has: stat = "10", idArticle = "40067114", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Assign Shipping Typ / Versandart zuordnen
     When PLAN_LOADING_FOR_ORDER is called for "Order" with: typShipment = "DHL_PAKET"
     Then WEBSERVICE succeeds
     # Assign Packing Station / Packplatz zuordnen
     When CREATE_ASSIGNMENT GI_ORDER is called with: idWorkcenter = "P-401", priority = 500 for:
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
      And order "Order" has 3 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "20", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "20", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[2]" has: stat = "20", idArticle = "40067114", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Release Reservation / Freigabe Reservierung
     When RES_LIST_ORDER is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 5 sec is passed
      #And order "Order" is in status "34"
      And order "Order" has 3 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = "30", idArticle = "40067005", qtyActual = 0.0, qtyReserved = 3.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[1]" has: stat = "30", idArticle = "40067024", qtyActual = 0.0, qtyReserved = 2.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
      And order item "OrderItem[2]" has: stat = "30", idArticle = "40067114", qtyActual = 0.0, qtyReserved = 1.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = "basis", tsUpd = now
     # Release Order(s) / Freigabe Bearbeitung
     When RELEASE_LIST_ORDER_ANYWAY_EP is called for:
        | Order |
     Then WEBSERVICE succeeds
      And 3 sec is passed
     Then order "Order" has 3 bps record, saved as collection "BpsRecord"
     
      And bps record "BpsRecord[0]" has one picking order, saved as "PiOrder[0]"
      And picking order "PiOrder[0]" has one picking trip, saved as "PiTrip[0]"
      
     Then SETUP_PICKING_LU_EP is called with: idPickingOrder = "PiOrder[0]", idTerminal = "IPC6460", idWorkcenter = "PM-000", typLu = "EURO"
      And BOOK_PICKING_LU_EP is called with: idPickingTrip = "PiTrip[0]", idTerminal = "IPC6460", idWorkcenter = "PM-000"
      And COMPLETE_PICKING_EP is called with: idPickingTrip = "PiTrip[0]", idTerminal = "IPC6460", idWorkcenter = "PM-000", storageAreaTgt = "H04-PUFFER", storageLocationTgt = "P-401-001"
      And 3 sec is passed
      And order "Order" is in status "44"
     Then save src load unit of bps record "BpsRecord[0]" as "LuMakeup"
     Then save src load unit of bps record "BpsRecord[1]" as "LuShoppingBag"
     Then save src load unit of bps record "BpsRecord[2]" as "LuCollegeblock"
      And load unit "LuShoppingBag" has 1 transport task, saved as collection "LuShoppingBagTask"
      And load unit "LuCollegeblock" has 1 transport task, saved as collection "LuCollegeblockTask"
           
      And COMPLETE_TASK_EP is called with transport task "LuShoppingBagTask[0]"
      And 3 sec is passed
      And COMPLETE_TASK_EP is called with transport task "LuCollegeblockTask[0]"
      And 3 sec is passed
     Then save src quantum of bps record "BpsRecord[0]" as "QuantumMakeup"
     Then save src quantum of bps record "BpsRecord[1]" as "QuantumShoppingBag"
     Then save src quantum of bps record "BpsRecord[2]" as "QuantumCollegeblock"
     Then reload bps record "BpsRecord[0]"
     Then reload bps record "BpsRecord[1]"
     Then reload bps record "BpsRecord[2]"
     Then save src load unit of bps record "BpsRecord[0]" as "LuMakeup"
     Then save src load unit of bps record "BpsRecord[1]" as "LuShoppingBag"
     Then save src load unit of bps record "BpsRecord[2]" as "LuCollegeblock"

     Then MOVE_TO_PACKING is called for "Order" and "LuMakeup" with: idWorkcenter = "P-401"
     Then MOVE_TO_PACKING is called for "Order" and "LuShoppingBag" with: idWorkcenter = "P-401"   
     Then MOVE_TO_PACKING is called for "Order" and "LuCollegeblock" with: idWorkcenter = "P-401"
     Then CREATE_PKG is called for "Order" with: idWorkcenterPack = "P-401", typLu = "VBOX3", typRef = "GI_ORDER" saved as "Package[0]" on "LuPacking"   
      And REPACK is called for "Package[0]", "OrderItem[0]", "LuMakeup", "QuantumMakeup" with: idTerminalPack = "IPC6460", idWorkcenterPack = "P-401", qtyRepacked = 3.0, typRef = "GI_ORDER_ITEM"
      And REPACK is called for "Package[0]", "OrderItem[1]", "LuShoppingBag", "QuantumShoppingBag" with: idTerminalPack = "IPC6460", idWorkcenterPack = "P-401", qtyRepacked = 2.0, typRef = "GI_ORDER_ITEM"
      And REPACK is called for "Package[0]", "OrderItem[2]", "LuCollegeblock", "QuantumCollegeblock" with: idTerminalPack = "IPC6460", idWorkcenterPack = "P-401", qtyRepacked = 1.0, typRef = "GI_ORDER_ITEM"

      And COMPLETE_PACKING_OC is called for "LuPacking" with: idWorkcenter = "P-401", height = 30.0, width = 40.0, wtActual = 2.0, len = 60.0, typLu = "VBOX3", typLuNew = "VBOX3"	
      And 3 sec is passed
      And order "Order" is in status "60"

      # cleanup
      #Then the load unit "LuShoppingBag" has to be booked to target location "SENKE-LAG"-"S-001" with transaction type RELLU
      #When RELLU is called
      #Then RELLU was successful; transaction saved as "Transaction"
      #Then the load unit "LuCollegeblock" has to be booked to target location "SENKE-LAG"-"S-001" with transaction type RELLU
      #When RELLU is called
      #Then RELLU was successful; transaction saved as "Transaction"
      #Then the load unit "LuPacking" has to be booked to target location "SENKE-LAG"-"S-001" with transaction type RELLU
      #When RELLU is called
      #Then RELLU was successful; transaction saved as "Transaction"
    
    