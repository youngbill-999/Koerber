#Author: pjohnke@inconso.de
#Keywords Summary : unplanned goods receiving process
@defaultdatabased
@goodsreceiving @unplanned

Feature: Goods Receiving Unplanned GR

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

  Scenario: RECEIVING_SEARCH_ARTICLE_VARIANT to search article variants related to an article in the unplanned goods receiving process
    Given RECEIVING_SEARCH_ARTICLE_VARIANT is called with: idArticle = "40067005"
     Then RECEIVING_SEARCH_ARTICLE_VARIANT finds 7 records
      And RECEIVING_SEARCH_ARTICLE_VARIANT result record 0 has: artvar = "1", typLu = "EURO", qtyPerLu = 1440.0, count2 = null, qty = 1440.0, heightClass = "HKL150", layer = 1
      And RECEIVING_SEARCH_ARTICLE_VARIANT result record 1 has: artvar = "2", typLu = "EURO", qtyPerLu = 300.0, count2 = 30, qty = 10.0, heightClass = "HKL050", layer = 1
      And RECEIVING_SEARCH_ARTICLE_VARIANT result record 2 has: artvar = "2", typLu = "LBOX1", qtyPerLu = 10.0, count2 = null, qty = 10.0, heightClass = "HKL030", layer = 2
      And RECEIVING_SEARCH_ARTICLE_VARIANT result record 3 has: artvar = "3", typLu = "EURO", qtyPerLu = 360.0, count2 = 30, qty = 12.0, heightClass = "HKL050", layer = 1
      And RECEIVING_SEARCH_ARTICLE_VARIANT result record 4 has: artvar = "3", typLu = "LBOX1", qtyPerLu = 12.0, count2 = null, qty = 12.0, heightClass = "HKL030", layer = 2
      And RECEIVING_SEARCH_ARTICLE_VARIANT result record 5 has: artvar = "4", typLu = "EURO", qtyPerLu = 1440.0, count2 = 48, qty = 30.0, heightClass = "HKL100", layer = 1
      And RECEIVING_SEARCH_ARTICLE_VARIANT result record 6 has: artvar = "4", typLu = "LBOX1", qtyPerLu = 30.0, count2 = null, qty = 30.0, heightClass = "HKL030", layer = 2
    
      
#  Scenario: CHECK_LU_CLOSED_EP to check if the loading unit type EURO is closed
#    Given loading unit type "EURO" in site "RL1" is checked if it is closed
#		 When CHECK_LU_CLOSED_EP is called
#     Then CHECK_LU_CLOSED_EP was successful
#      And a flag stating "false" is returned
      
#  Scenario: CHECK_LU_CODED_EP to check if the loading unit type EURO is coded
#    Given loading unit type "EURO" in site "RL1" is checked if it is coded
#		 When CHECK_LU_CODED_EP is called
#     Then CHECK_LU_CODED_EP was successful
#      And a flag stating "false" is returned

       
  Scenario: unplanned goods receiving process
    Given RECEIVING_CREATE_RECEIVING is called with: idWorkcenter = "W400-101", idTerminal = "IPC6475", idGoodsReceipt = null, idArticle = "40067005", numGoodsReceiptItem = null, typLu = "EURO", artvar = "1", countEntities = 10.0, countGrippingUnit = null, qtyPerEntity = 30.0, qtyRemaining = null, qtyForBooking = 300.0, idBatch = null, tsBbd = null, typSpecialStock = null, idSpecialStock = null, storageArea = "H01-HRL", storageLocation = null, storeInZoneGroup = null, idLu = null, height = 150.0, repeatBooking = 1, controllerClass = "GR400"
     Then RECEIVING_CREATE_RECEIVING result is saved as "Receiving"; result has 1 load unit, saved as collection "Lu"; result has: booking = true, isFinishedSetUp = true
      And receiving "Receiving" has: idGoodsReceipt = ignore, stat = "20", typGoodsReceipt = "UNPL", datGoodsReceipt = ignore, idTerminal = "IPC6475", idWorkcenter = "W400-101", clUnplanned = "DAILY_WC"
      And load unit "Lu[0]" has: idLu = ignore, typLu = "EURO", statOccupied = "90", pctOccupied = 0.00, flgStockTaking = false, tsStockTaking = now, idUserStockTaking = "basis", storageArea = "H01-HRL", storageLocation = ignore, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", flgInTransit = true, idTransaction = ignore, sscc = ignore, wtGross = 190000.0, wtTare = 28000.0, height = 150.0, vol = 316500.0
      And load unit "Lu[0]" has 1 quantum, saved as collection "Lu[0]Qu"
      And quantum "Lu[0]Qu[0]" has: idQuantum = ignore, idArticle = "40067005", qtyAvailable = 300.0, qtyReserved = 0.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H01-HRL", storageLocation = "", storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", flgInTransit = true, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 1, tsGoodsReceipt = ignore, wtGross = 162000.0, vol = 172500.0
      And load unit "Lu[0]" has 1 bps record, saved as collection "Lu[0]BpsRecord"
      And bps record "Lu[0]BpsRecord[0]" has: idRecord = ignore, stat = "10", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "30", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067005", qty = 300.0, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 162000.0, unitWt = "GR", vol = 172500.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H01-HRL", storageLocationTgt = ignore
      And bps record "Lu[0]BpsRecord[0]" has 2 steps, saved as collection "Lu[0]BpsRecord[0]BpsStep"
      And bps step "Lu[0]BpsRecord[0]BpsStep[0]" has: idRecord = ignore, numConsec = 1, statStep = "90", typStep = "SETUP", tsStartTargetMaxStep = now, idNode = "d33d30c2-d78b-4515-a4ed-5a54ea8b2b41", tsStart = now, tsEnd = now
      And bps step "Lu[0]BpsRecord[0]BpsStep[1]" has: idRecord = ignore, numConsec = 2, statStep = "30", typStep = "TRANSPORT", tsStartTargetMaxStep = now, idNode = "923e7d70-8dbe-4073-b578-b5c20407cf39", tsStart = now, tsEnd = null
      And quantum "Lu[0]Qu[0]" or load unit "Lu[0]" has 4 transactions, saved as collection "Lu[0]Transaction"
      And CRELU transaction "Lu[0]Transaction[0]" has: idTransaction = ignore, stat = "90", situation = "GR_UNPLANNED", idCre = "basis", tsCre = now, storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001", storageAreaTgt = "H01-WE", storageLocationTgt = "W-101", idLu = key:Lu[0], typLu = "EURO", height = 150.0, vol = 144000.0, wt = 28000.0
      And CREQU transaction "Lu[0]Transaction[1]" has: idTransaction = ignore, stat = "90", situation = "GR_UNPLANNED", idCre = "basis", tsCre = now, storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001", storageAreaTgt = "H01-WE", storageLocationTgt = "W-101", idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 150.0, vol = 316500.0, wtGross = 190000.0, wtTare = 28000.0, idArticle = "40067005", qtyMoved = 300.0, idQuantum = key:Lu[0]Qu[0], artvar = "1", volQuantum = 172500.0, wtGrossQuantum = 162000.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 1, tsGoodsReceipt = ignore
      And RELLU transaction "Lu[0]Transaction[2]" has: idTransaction = ignore, stat = "10", situation = "GR_FINISH", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H01-HRL", storageLocationTgt = ignore, idLu = key:Lu[0], idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 150.0, vol = 316500.0, wtGross = 190000.0, wtTare = 28000.0, idArticle = null, idQuantum = null, artvar = null, volQuantum = null, wtGrossQuantum = null, qtyAvailable = null, qtyReserved = null, typStock = null, typLock = null, statQualityControl = null, statCustoms = null, idBatch = null, tsBbd = null, sepCrit01 = null, sepCrit02 = null, sepCrit03 = null, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, typRelocation = "TRANSPORT"
      And RELLU transaction "Lu[0]Transaction[3]" has: idTransaction = ignore, stat = "10", situation = "GR_FINISH", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H01-HRL", storageLocationTgt = ignore, idLu = key:Lu[0], idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 150.0, vol = 316500.0, wtGross = 190000.0, wtTare = 28000.0, idArticle = "40067005", idQuantum = key:Lu[0]Qu[0], artvar = "1", volQuantum = 172500.0, wtGrossQuantum = 162000.0, qtyAvailable = 300.0, qtyReserved = 0.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 1, tsGoodsReceipt = ignore, typRelocation = "TRANSPORT"
      And transactions have same idTransactionGrp:
        | Lu[0]Transaction[2] |
        | Lu[0]Transaction[3] |
      And bps record "Lu[0]BpsRecord[0]" has one receiving item, saved as "ReceivingItem[0]"
      And receiving item "ReceivingItem[0]" has: idGoodsReceipt = key:Receiving, numItem = 1, stat = "30", idArticle = "40067005", artvar = "1", qtyDeliveryNote = 0.0, qtyTarget = 300.0, qtyCanceled = 0.0, qtyActual = 300.0, sepCrit03 = key:Receiving
      And bps record "Lu[0]BpsRecord[0]" has: typRef = "GR_RECEIVING_ITEM", matches "ReceivingItem[0]"
      And load unit "Lu[0]" has 1 transport task, saved as collection "Lu[0]Task"
      And transport task "Lu[0]Task[0]" has: idTask = ignore, stat = "20", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"
      And transport task "Lu[0]Task[0]" has 1 bps record, saved as collection "Lu[0]Task[0]BpsRecord"
      And bps records are equal:
        |Lu[0]BpsRecord[0]|
        |Lu[0]Task[0]BpsRecord[0]|
      And transport task "Lu[0]Task[0]" has 1 transport task target, saved as collection "Lu[0]TaskTarget"
      And transport task target "Lu[0]TaskTarget[0]" has: idTask = ignore, numTarget = 1, stat = "20", numSort = 1, storageArea = "H01-HRL", storageLocation = ignore, idTransaction = ignore
      And transaction "Lu[0]Transaction[0]" has: typRef = "GR_RECEIVING_ITEM", matches "ReceivingItem[0]"
      And transaction "Lu[0]Transaction[1]" has: typRef = "GR_RECEIVING_ITEM", matches "ReceivingItem[0]"
      And transaction "Lu[0]Transaction[2]" has: typRef = "TCS_TASK_TARGET", matches "Lu[0]TaskTarget[0]"
      And transaction "Lu[0]Transaction[3]" has: typRef = "TCS_TASK_TARGET", matches "Lu[0]TaskTarget[0]"
      And COMPLETE_TASK_EP is called with transport task "Lu[0]Task[0]"
     Then reload bps record "Lu[0]BpsRecord[0]"
      And reload transport task "Lu[0]Task[0]"
      And transport task "Lu[0]Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"
      And reload transport task target "Lu[0]TaskTarget[0]"
      And transport task target "Lu[0]TaskTarget[0]" has: idTask = ignore, numTarget = 1, stat = "90", numSort = 1, storageArea = "H01-HRL", storageLocation = ignore, idTransaction = ignore
      And bps record "Lu[0]BpsRecord[0]" has: idRecord = ignore, stat = "90", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "90", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067005", qty = 300.0, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 162000.0, unitWt = "GR", vol = 172500.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H01-HRL", storageLocationSrc = ignore, storageAreaTgt = null, storageLocationTgt = null
     Then reload receiving item "ReceivingItem[0]"
      And receiving item "ReceivingItem[0]" has: idGoodsReceipt = key:Receiving, numItem = 1, stat = "90", idArticle = "40067005", artvar = "1", qtyDeliveryNote = 0.0, qtyTarget = 300.0, qtyCanceled = 0.0, qtyActual = 300.0, sepCrit03 = key:Receiving
#Clean up
			Then delete load unit "Lu[0]"

  Scenario: unplanned goods receiving process with repeatBooking = 2
    Given RECEIVING_CREATE_RECEIVING is called with: idWorkcenter = "W400-101", idTerminal = "IPC6475", idGoodsReceipt = null, idArticle = "40067005", numGoodsReceiptItem = null, typLu = "EURO", artvar = "1", countEntities = 10.0, countGrippingUnit = null, qtyPerEntity = 30.0, qtyRemaining = null, qtyForBooking = 300.0, idBatch = null, tsBbd = null, typSpecialStock = null, idSpecialStock = null, storageArea = "H01-HRL", storageLocation = null, storeInZoneGroup = null, idLu = null, height = 150.0, repeatBooking = 2, controllerClass = "GR400"
     Then RECEIVING_CREATE_RECEIVING result is saved as "Receiving"; result has 2 load unit, saved as collection "Lu"; result has: booking = true, isFinishedSetUp = true
      And receiving "Receiving" has: idGoodsReceipt = ignore, stat = "20", typGoodsReceipt = "UNPL", datGoodsReceipt = ignore, idTerminal = "IPC6475", idWorkcenter = "W400-101", clUnplanned = "DAILY_WC"
# 1st
      And load unit "Lu[0]" has: idLu = ignore, typLu = "EURO", statOccupied = "90", pctOccupied = 0.00, flgStockTaking = false, tsStockTaking = now, idUserStockTaking = "basis", storageArea = "H01-HRL", storageLocation = ignore, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", flgInTransit = true, idTransaction = ignore, sscc = ignore, wtGross = 190000.0, wtTare = 28000.0, height = 150.0, vol = 316500.0
      And load unit "Lu[0]" has 1 quantum, saved as collection "Lu[0]Qu"
      And quantum "Lu[0]Qu[0]" has: idQuantum = ignore, idArticle = "40067005", qtyAvailable = 300.0, qtyReserved = 0.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H01-HRL", storageLocation = "", storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", flgInTransit = true, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 1, tsGoodsReceipt = ignore, wtGross = 162000.0, vol = 172500.0
      And load unit "Lu[0]" has 1 bps record, saved as collection "Lu[0]BpsRecord"
      And bps record "Lu[0]BpsRecord[0]" has: idRecord = ignore, stat = "10", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "30", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067005", qty = 300.0, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 162000.0, unitWt = "GR", vol = 172500.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H01-HRL", storageLocationTgt = ignore
      And bps record "Lu[0]BpsRecord[0]" has 2 steps, saved as collection "Lu[0]BpsRecord[0]BpsStep"
      And bps step "Lu[0]BpsRecord[0]BpsStep[0]" has: idRecord = ignore, numConsec = 1, statStep = "90", typStep = "SETUP", tsStartTargetMaxStep = now, idNode = "d33d30c2-d78b-4515-a4ed-5a54ea8b2b41", tsStart = now, tsEnd = now
      And bps step "Lu[0]BpsRecord[0]BpsStep[1]" has: idRecord = ignore, numConsec = 2, statStep = "30", typStep = "TRANSPORT", tsStartTargetMaxStep = now, idNode = "923e7d70-8dbe-4073-b578-b5c20407cf39", tsStart = now, tsEnd = null
      And quantum "Lu[0]Qu[0]" or load unit "Lu[0]" has 4 transactions, saved as collection "Lu[0]Transaction"
      And CRELU transaction "Lu[0]Transaction[0]" has: idTransaction = ignore, stat = "90", situation = "GR_UNPLANNED", idCre = "basis", tsCre = now, storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001", storageAreaTgt = "H01-WE", storageLocationTgt = "W-101", idLu = key:Lu[0], typLu = "EURO", height = 150.0, vol = 144000.0, wt = 28000.0
      And CREQU transaction "Lu[0]Transaction[1]" has: idTransaction = ignore, stat = "90", situation = "GR_UNPLANNED", idCre = "basis", tsCre = now, storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001", storageAreaTgt = "H01-WE", storageLocationTgt = "W-101", idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 150.0, vol = 316500.0, wtGross = 190000.0, wtTare = 28000.0, idArticle = "40067005", qtyMoved = 300.0, idQuantum = key:Lu[0]Qu[0], artvar = "1", volQuantum = 172500.0, wtGrossQuantum = 162000.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 1, tsGoodsReceipt = ignore
      And RELLU transaction "Lu[0]Transaction[2]" has: idTransaction = ignore, stat = "10", situation = "GR_FINISH", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H01-HRL", storageLocationTgt = ignore, idLu = key:Lu[0], idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 150.0, vol = 316500.0, wtGross = 190000.0, wtTare = 28000.0, idArticle = null, idQuantum = null, artvar = null, volQuantum = null, wtGrossQuantum = null, qtyAvailable = null, qtyReserved = null, typStock = null, typLock = null, statQualityControl = null, statCustoms = null, idBatch = null, tsBbd = null, sepCrit01 = null, sepCrit02 = null, sepCrit03 = null, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, typRelocation = "TRANSPORT"
      And RELLU transaction "Lu[0]Transaction[3]" has: idTransaction = ignore, stat = "10", situation = "GR_FINISH", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H01-HRL", storageLocationTgt = ignore, idLu = key:Lu[0], idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 150.0, vol = 316500.0, wtGross = 190000.0, wtTare = 28000.0, idArticle = "40067005", idQuantum = key:Lu[0]Qu[0], artvar = "1", volQuantum = 172500.0, wtGrossQuantum = 162000.0, qtyAvailable = 300.0, qtyReserved = 0.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 1, tsGoodsReceipt = ignore, typRelocation = "TRANSPORT"
      And transactions have same idTransactionGrp:
        | Lu[0]Transaction[2] |
        | Lu[0]Transaction[3] |
      And bps record "Lu[0]BpsRecord[0]" has one receiving item, saved as "ReceivingItem[0]"
      And receiving item "ReceivingItem[0]" has: idGoodsReceipt = key:Receiving, numItem = 1, stat = "30", idArticle = "40067005", artvar = "1", qtyDeliveryNote = 0.0, qtyTarget = 300.0, qtyCanceled = 0.0, qtyActual = 300.0, sepCrit03 = key:Receiving
      And bps record "Lu[0]BpsRecord[0]" has: typRef = "GR_RECEIVING_ITEM", matches "ReceivingItem[0]"
      And load unit "Lu[0]" has 1 transport task, saved as collection "Lu[0]Task"
      And transport task "Lu[0]Task[0]" has: idTask = ignore, stat = "20", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"
      And transport task "Lu[0]Task[0]" has 1 bps record, saved as collection "Lu[0]Task[0]BpsRecord"
      And bps records are equal:
        |Lu[0]BpsRecord[0]|
        |Lu[0]Task[0]BpsRecord[0]|
      And transport task "Lu[0]Task[0]" has 1 transport task target, saved as collection "Lu[0]TaskTarget"
      And transport task target "Lu[0]TaskTarget[0]" has: idTask = ignore, numTarget = 1, stat = "20", numSort = 1, storageArea = "H01-HRL", storageLocation = ignore, idTransaction = ignore
      And transaction "Lu[0]Transaction[0]" has: typRef = "GR_RECEIVING_ITEM", matches "ReceivingItem[0]"
      And transaction "Lu[0]Transaction[1]" has: typRef = "GR_RECEIVING_ITEM", matches "ReceivingItem[0]"
      And transaction "Lu[0]Transaction[2]" has: typRef = "TCS_TASK_TARGET", matches "Lu[0]TaskTarget[0]"
      And transaction "Lu[0]Transaction[3]" has: typRef = "TCS_TASK_TARGET", matches "Lu[0]TaskTarget[0]"
      And COMPLETE_TASK_EP is called with transport task "Lu[0]Task[0]"
     Then reload bps record "Lu[0]BpsRecord[0]"
      And reload transport task "Lu[0]Task[0]"
      And transport task "Lu[0]Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"
      And reload transport task target "Lu[0]TaskTarget[0]"
      And transport task target "Lu[0]TaskTarget[0]" has: idTask = ignore, numTarget = 1, stat = "90", numSort = 1, storageArea = "H01-HRL", storageLocation = ignore, idTransaction = ignore
      And bps record "Lu[0]BpsRecord[0]" has: idRecord = ignore, stat = "90", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "90", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067005", qty = 300.0, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 162000.0, unitWt = "GR", vol = 172500.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H01-HRL", storageLocationSrc = ignore, storageAreaTgt = null, storageLocationTgt = null
     Then reload receiving item "ReceivingItem[0]"
      And receiving item "ReceivingItem[0]" has: idGoodsReceipt = key:Receiving, numItem = 1, stat = "90", idArticle = "40067005", artvar = "1", qtyDeliveryNote = 0.0, qtyTarget = 300.0, qtyCanceled = 0.0, qtyActual = 300.0, sepCrit03 = key:Receiving
# 2nd
      And load unit "Lu[1]" has: idLu = ignore, typLu = "EURO", statOccupied = "90", pctOccupied = 0.00, flgStockTaking = false, tsStockTaking = now, idUserStockTaking = "basis", storageArea = "H01-HRL", storageLocation = ignore, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", flgInTransit = true, idTransaction = ignore, sscc = ignore, wtGross = 190000.0, wtTare = 28000.0, height = 150.0, vol = 316500.0
      And load unit "Lu[1]" has 1 quantum, saved as collection "Lu[1]Qu"
      And quantum "Lu[1]Qu[0]" has: idQuantum = ignore, idArticle = "40067005", qtyAvailable = 300.0, qtyReserved = 0.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H01-HRL", storageLocation = "", storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", flgInTransit = true, idTransaction = ignore, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 2, tsGoodsReceipt = ignore, wtGross = 162000.0, vol = 172500.0
      And load unit "Lu[1]" has 1 bps record, saved as collection "Lu[1]BpsRecord"
      And bps record "Lu[1]BpsRecord[0]" has: idRecord = ignore, stat = "10", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "30", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067005", qty = 300.0, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 162000.0, unitWt = "GR", vol = 172500.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H01-HRL", storageLocationTgt = ignore
      And bps record "Lu[1]BpsRecord[0]" has 2 steps, saved as collection "Lu[1]BpsRecord[0]BpsStep"
      And bps step "Lu[1]BpsRecord[0]BpsStep[0]" has: idRecord = ignore, numConsec = 1, statStep = "90", typStep = "SETUP", tsStartTargetMaxStep = now, idNode = "d33d30c2-d78b-4515-a4ed-5a54ea8b2b41", tsStart = now, tsEnd = now
      And bps step "Lu[1]BpsRecord[0]BpsStep[1]" has: idRecord = ignore, numConsec = 2, statStep = "30", typStep = "TRANSPORT", tsStartTargetMaxStep = now, idNode = "923e7d70-8dbe-4073-b578-b5c20407cf39", tsStart = now, tsEnd = null
      And quantum "Lu[1]Qu[0]" or load unit "Lu[1]" has 4 transactions, saved as collection "Lu[1]Transaction"
      And CRELU transaction "Lu[1]Transaction[0]" has: idTransaction = ignore, stat = "90", situation = "GR_UNPLANNED", idCre = "basis", tsCre = now, storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001", storageAreaTgt = "H01-WE", storageLocationTgt = "W-101", idLu = key:Lu[1], typLu = "EURO", height = 150.0, vol = 144000.0, wt = 28000.0
      And CREQU transaction "Lu[1]Transaction[1]" has: idTransaction = ignore, stat = "90", situation = "GR_UNPLANNED", idCre = "basis", tsCre = now, storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001", storageAreaTgt = "H01-WE", storageLocationTgt = "W-101", idLu1 = key:Lu[1], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 150.0, vol = 316500.0, wtGross = 190000.0, wtTare = 28000.0, idArticle = "40067005", qtyMoved = 300.0, idQuantum = key:Lu[1]Qu[0], artvar = "1", volQuantum = 172500.0, wtGrossQuantum = 162000.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 2, tsGoodsReceipt = ignore
      And RELLU transaction "Lu[1]Transaction[2]" has: idTransaction = ignore, stat = "10", situation = "GR_FINISH", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H01-HRL", storageLocationTgt = ignore, idLu = key:Lu[1], idLu1 = key:Lu[1], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 150.0, vol = 316500.0, wtGross = 190000.0, wtTare = 28000.0, idArticle = null, idQuantum = null, artvar = null, volQuantum = null, wtGrossQuantum = null, qtyAvailable = null, qtyReserved = null, typStock = null, typLock = null, statQualityControl = null, statCustoms = null, idBatch = null, tsBbd = null, sepCrit01 = null, sepCrit02 = null, sepCrit03 = null, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, typRelocation = "TRANSPORT"
      And RELLU transaction "Lu[1]Transaction[3]" has: idTransaction = ignore, stat = "10", situation = "GR_FINISH", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H01-HRL", storageLocationTgt = ignore, idLu = key:Lu[1], idLu1 = key:Lu[1], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 150.0, vol = 316500.0, wtGross = 190000.0, wtTare = 28000.0, idArticle = "40067005", idQuantum = key:Lu[1]Qu[0], artvar = "1", volQuantum = 172500.0, wtGrossQuantum = 162000.0, qtyAvailable = 300.0, qtyReserved = 0.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 2, tsGoodsReceipt = ignore, typRelocation = "TRANSPORT"
      And transactions have same idTransactionGrp:
        | Lu[1]Transaction[2] |
        | Lu[1]Transaction[3] |
      And bps record "Lu[1]BpsRecord[0]" has one receiving item, saved as "ReceivingItem[1]"
      And receiving item "ReceivingItem[1]" has: idGoodsReceipt = key:Receiving, numItem = 2, stat = "30", idArticle = "40067005", artvar = "1", qtyDeliveryNote = 0.0, qtyTarget = 300.0, qtyCanceled = 0.0, qtyActual = 300.0, sepCrit03 = key:Receiving
      And bps record "Lu[1]BpsRecord[0]" has: typRef = "GR_RECEIVING_ITEM", matches "ReceivingItem[1]"
      And load unit "Lu[1]" has 1 transport task, saved as collection "Lu[1]Task"
      And transport task "Lu[1]Task[0]" has: idTask = ignore, stat = "20", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"
      And transport task "Lu[1]Task[0]" has 1 bps record, saved as collection "Lu[1]Task[0]BpsRecord"
      And bps records are equal:
        |Lu[1]BpsRecord[0]|
        |Lu[1]Task[0]BpsRecord[0]|
      And transport task "Lu[1]Task[0]" has 1 transport task target, saved as collection "Lu[1]TaskTarget"
      And transport task target "Lu[1]TaskTarget[0]" has: idTask = ignore, numTarget = 1, stat = "20", numSort = 1, storageArea = "H01-HRL", storageLocation = ignore, idTransaction = ignore
      And transaction "Lu[1]Transaction[0]" has: typRef = "GR_RECEIVING_ITEM", matches "ReceivingItem[1]"
      And transaction "Lu[1]Transaction[1]" has: typRef = "GR_RECEIVING_ITEM", matches "ReceivingItem[1]"
      And transaction "Lu[1]Transaction[2]" has: typRef = "TCS_TASK_TARGET", matches "Lu[1]TaskTarget[0]"
      And transaction "Lu[1]Transaction[3]" has: typRef = "TCS_TASK_TARGET", matches "Lu[1]TaskTarget[0]"
      And COMPLETE_TASK_EP is called with transport task "Lu[1]Task[0]"
     Then reload bps record "Lu[1]BpsRecord[0]"
      And reload transport task "Lu[1]Task[0]"
      And transport task "Lu[1]Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"
      And reload transport task target "Lu[1]TaskTarget[0]"
      And transport task target "Lu[1]TaskTarget[0]" has: idTask = ignore, numTarget = 1, stat = "90", numSort = 1, storageArea = "H01-HRL", storageLocation = ignore, idTransaction = ignore
      And bps record "Lu[1]BpsRecord[0]" has: idRecord = ignore, stat = "90", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "90", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067005", qty = 300.0, artvar = "1", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 162000.0, unitWt = "GR", vol = 172500.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H01-HRL", storageLocationSrc = ignore, storageAreaTgt = null, storageLocationTgt = null
     Then reload receiving item "ReceivingItem[1]"
      And receiving item "ReceivingItem[1]" has: idGoodsReceipt = key:Receiving, numItem = 2, stat = "90", idArticle = "40067005", artvar = "1", qtyDeliveryNote = 0.0, qtyTarget = 300.0, qtyCanceled = 0.0, qtyActual = 300.0, sepCrit03 = key:Receiving
#Clean up
			Then delete load unit "Lu[0]"
			Then delete load unit "Lu[1]"

@deactivateEUROR
  Scenario: unplanned goods receiving process with mix lu
     When RECMIXLU_SEARCH_LU_TYPES is called with: input = "EURO", typLu = null, idWorkcenter = "W410-101", idTerminal = null
     Then RECMIXLU_SEARCH_LU_TYPES result has one load unit, saved as "Lu"
     When RECEIVING_CREATE_RECEIVING is called with: idWorkcenter = "W410-101", idTerminal = "IPC6491", idGoodsReceipt = null, idArticle = "40067005", numGoodsReceiptItem = null, typLu = "EURO", artvar = "2", countEntities = 0.0, countGrippingUnit = null, qtyPerEntity = 0.0, qtyRemaining = 100, qtyForBooking = 100.0, idBatch = null, tsBbd = null, typSpecialStock = null, idSpecialStock = null, storageArea = null, storageLocation = null, storeInZoneGroup = null, idLu = key:Lu, height = null, repeatBooking = null, controllerClass = "GR410"
     Then RECEIVING_CREATE_RECEIVING result is saved as "Receiving"; result has 1 load unit, saved as collection "Lu"; result has: booking = true, isFinishedSetUp = true  
     And receiving "Receiving" has: idGoodsReceipt = ignore, stat = "20", typGoodsReceipt = "UNPL", datGoodsReceipt = ignore, idTerminal = "IPC6491", idWorkcenter = "W410-101", clUnplanned = "DAILY_WC"
     When RECEIVING_CREATE_RECEIVING is called with: idWorkcenter = "W410-101", idTerminal = "IPC6491", idGoodsReceipt = null, idArticle = "40067008", numGoodsReceiptItem = null, typLu = null, artvar = null, countEntities = 0.0, countGrippingUnit = 0.0, qtyPerEntity = 0.0, qtyRemaining = 40, qtyForBooking = 40.0, idBatch = null, tsBbd = null, typSpecialStock = null, idSpecialStock = null, storageArea = null, storageLocation = null, storeInZoneGroup = null, idLu = key:Lu, height = null, repeatBooking = null, controllerClass = "GR410"
     Then RECEIVING_CREATE_RECEIVING result is saved as "Receiving"; result has 1 load unit, saved as collection "Lu"; result has: booking = true, isFinishedSetUp = true  
     And receiving "Receiving" has: idGoodsReceipt = ignore, stat = "20", typGoodsReceipt = "UNPL", datGoodsReceipt = ignore, idTerminal = "IPC6491", idWorkcenter = "W410-101", clUnplanned = "DAILY_WC"

     And reload load unit "Lu"
     And load unit "Lu" has: idLu = ignore, typLu = "EURO", statOccupied = "90", pctOccupied = 0.00, flgStockTaking = false, tsStockTaking = now, idUserStockTaking = "basis", storageArea = "H01-WE", storageLocation = ignore, storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, sscc = ignore, wtGross = 125840.0, wtTare = 28000.0, height = 15.0, vol = 404480.0
     And load unit "Lu" has 2 quantums, saved as collection "Qu"
     And quantum "Qu[0]" has: idQuantum = ignore, idArticle = "40067005", qtyAvailable = 100.0, qtyReserved = 0.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H01-WE", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = "2", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 1, tsGoodsReceipt = ignore, wtGross = 65000.0, vol = 204000.0
     And quantum "Qu[1]" has: idQuantum = ignore, idArticle = "40067008", qtyAvailable = 40.0, qtyReserved = 0.0, flgStockTaking = false, idLu1 = ignore, typLu1 = "EURO", storageArea = "H01-WE", storageLocation = "", storageAreaSrc = null, storageLocationSrc = null, flgInTransit = false, idTransaction = ignore, artvar = null, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 2, tsGoodsReceipt = ignore, wtGross = 32840.0, vol = 56480.0
     And load unit "Lu" has 2 bps record, saved as collection "LuBpsRecord"

     And bps record "LuBpsRecord[0]" has one receiving item, saved as "ReceivingItem[0]"
     And receiving item "ReceivingItem[0]" has: idGoodsReceipt = key:Receiving, numItem = 1, stat = "30", idArticle = "40067005", artvar = "2", qtyDeliveryNote = 0.0, qtyTarget = 100.0, qtyCanceled = 0.0, qtyActual = 100.0, sepCrit03 = key:Receiving
     And bps record "LuBpsRecord[1]" has one receiving item, saved as "ReceivingItem[1]"
     And receiving item "ReceivingItem[1]" has: idGoodsReceipt = key:Receiving, numItem = 2, stat = "30", idArticle = "40067008", artvar = null, qtyDeliveryNote = 0.0, qtyTarget = 40.0, qtyCanceled = 0.0, qtyActual = 40.0, sepCrit03 = key:Receiving

     Then RECMIXLU_PUSH_LU is called with: idLu = key:Lu, idWorkCenter = "W410-101", idTerminal = "IPC6491", storageArea = null, storageLocation = null, storeInZoneGroup = null, height = 300.0

     And reload bps record "LuBpsRecord[0]"
     And bps record "LuBpsRecord[0]" has: idRecord = ignore, stat = "10", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "30", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067005", qty = 100.0, artvar = "2", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 65000.0, unitWt = "GR", vol = 204000.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H02-HRL", storageLocationTgt = ignore
     And bps record "LuBpsRecord[0]" has 2 steps, saved as collection "BpsRecord[0]BpsStep"
     And bps step "BpsRecord[0]BpsStep[0]" has: idRecord = ignore, numConsec = 1, statStep = "90", typStep = "SETUP", tsStartTargetMaxStep = now, idNode = "d33d30c2-d78b-4515-a4ed-5a54ea8b2b41", tsStart = now, tsEnd = now
     And bps step "BpsRecord[0]BpsStep[1]" has: idRecord = ignore, numConsec = 2, statStep = "30", typStep = "TRANSPORT", tsStartTargetMaxStep = now, idNode = "923e7d70-8dbe-4073-b578-b5c20407cf39", tsStart = now, tsEnd = null
     And reload bps record "LuBpsRecord[1]"
     And bps record "LuBpsRecord[1]" has: idRecord = ignore, stat = "10", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "30", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067008", qty = 40.0, artvar = null, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 32840.0, unitWt = "GR", vol = 56480.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H02-HRL", storageLocationTgt = ignore
     And bps record "LuBpsRecord[1]" has 2 steps, saved as collection "BpsRecord[1]BpsStep"
     And bps step "BpsRecord[1]BpsStep[0]" has: idRecord = ignore, numConsec = 1, statStep = "90", typStep = "SETUP", tsStartTargetMaxStep = now, idNode = "d33d30c2-d78b-4515-a4ed-5a54ea8b2b41", tsStart = now, tsEnd = now
     And bps step "BpsRecord[1]BpsStep[1]" has: idRecord = ignore, numConsec = 2, statStep = "30", typStep = "TRANSPORT", tsStartTargetMaxStep = now, idNode = "923e7d70-8dbe-4073-b578-b5c20407cf39", tsStart = now, tsEnd = null

     And quantum null or load unit "Lu[0]" has 4 transactions, saved as collection "Lu[0]Transaction"
     And CRELU transaction "Lu[0]Transaction[0]" has: idTransaction = ignore, stat = "90", situation = "GR_MIXED_LU", idCre = "basis", tsCre = now, storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001", storageAreaTgt = "H01-WE", storageLocationTgt = "W-101", idLu = key:Lu[0], typLu = "EURO", height = 15.0, vol = 144000.0, wt = 28000.0
     And RELLU transaction "Lu[0]Transaction[1]" has: idTransaction = ignore, stat = "10", situation = "GR_FINISH", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H02-HRL", storageLocationTgt = ignore, idLu = key:Lu[0], idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 15.0, vol = 404480.0, wtGross = 125840.0, wtTare = 28000.0, idArticle = null, idQuantum = null, artvar = null, volQuantum = null, wtGrossQuantum = null, qtyAvailable = null, qtyReserved = null, typStock = null, typLock = null, statQualityControl = null, statCustoms = null, idBatch = null, tsBbd = null, sepCrit01 = null, sepCrit02 = null, sepCrit03 = null, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = null, numGoodsReceiptItem = null, tsGoodsReceipt = null, typRelocation = "TRANSPORT"
     And RELLU transaction "Lu[0]Transaction[2]" has: idTransaction = ignore, stat = "10", situation = "GR_FINISH", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H02-HRL", storageLocationTgt = ignore, idLu = key:Lu[0], idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 15.0, vol = 404480.0, wtGross = 125840.0, wtTare = 28000.0, idArticle = "40067005", idQuantum = key:Qu[0], artvar = "2", volQuantum = 204000.0, wtGrossQuantum = 65000.0, qtyAvailable = 100.0, qtyReserved = 0.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 1, tsGoodsReceipt = ignore, typRelocation = "TRANSPORT"
     And RELLU transaction "Lu[0]Transaction[3]" has: idTransaction = ignore, stat = "10", situation = "GR_FINISH", idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, storageAreaSrc = "H01-WE", storageLocationSrc = "W-101", storageAreaTgt = "H02-HRL", storageLocationTgt = ignore, idLu = key:Lu[0], idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 15.0, vol = 404480.0, wtGross = 125840.0, wtTare = 28000.0, idArticle = "40067008", idQuantum = key:Qu[1], artvar = null, volQuantum = 56480.0, wtGrossQuantum = 32840.0, qtyAvailable = 40.0, qtyReserved = 0.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 2, tsGoodsReceipt = ignore, typRelocation = "TRANSPORT"
     And transactions have same idTransactionGrp:
       | Lu[0]Transaction[1] |
       | Lu[0]Transaction[2] |
       | Lu[0]Transaction[3] |

     And quantum "Qu[0]" or load unit null has 2 transaction, saved as collection "Qu[0]Transaction"
     And CREQU transaction "Qu[0]Transaction[0]" has: idTransaction = ignore, stat = "90", situation = "GR_UNPLANNED", idCre = "basis", tsCre = now, storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001", storageAreaTgt = "H01-WE", storageLocationTgt = "W-101", idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 15.0, vol = 348000.0, wtGross = 93000.0, wtTare = 28000.0, idArticle = "40067005", qtyMoved = 100.0, idQuantum = key:Qu[0], artvar = "2", volQuantum = 204000.0, wtGrossQuantum = 65000.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 1, tsGoodsReceipt = ignore
     And quantum "Qu[1]" or load unit null has 2 transaction, saved as collection "Qu[1]Transaction"
     And CREQU transaction "Qu[1]Transaction[0]" has: idTransaction = ignore, stat = "90", situation = "GR_UNPLANNED", idCre = "basis", tsCre = now, storageAreaSrc = "QUELLE-LAG", storageLocationSrc = "Q-001", storageAreaTgt = "H01-WE", storageLocationTgt = "W-101", idLu1 = key:Lu[0], typLu1 = "EURO", idLu2 = null, typLu2 = null, idLu3 = null, typLu3 = null, height = 15.0, vol = 404480.0, wtGross = 125840.0, wtTare = 28000.0, idArticle = "40067008", qtyMoved = 40.0, idQuantum = key:Qu[1], artvar = null, volQuantum = 56480.0, wtGrossQuantum = 32840.0, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", idBatch = null, tsBbd = null, sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, sepCrit04 = null, sepCrit05 = null, sepCrit06 = null, sepCrit07 = null, sepCrit08 = null, sepCrit09 = null, sepCrit10 = null, idSpecialStock = null, typSpecialStock = null, idGoodsReceipt = key:Receiving, numGoodsReceiptItem = 2, tsGoodsReceipt = ignore

      And load unit "Lu" has 1 transport task, saved as collection "Task"
      And transport task "Task[0]" has: idTask = ignore, stat = "20", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"
      And transport task "Task[0]" has 2 bps records, saved as collection "TaskBpsRecord"
      And bps records are equal:
        |LuBpsRecord[0]|
        |TaskBpsRecord[0]|
      And bps records are equal:
        |LuBpsRecord[1]|
        |TaskBpsRecord[1]|
      And bps records are unequal:
        |LuBpsRecord[0]|
        |LuBpsRecord[1]|
      And transport task "Task[0]" has 1 transport task target, saved as collection "TaskTarget"
      And transport task target "TaskTarget[0]" has: idTask = ignore, numTarget = 1, stat = "20", numSort = 1, storageArea = "H02-HRL", storageLocation = ignore, idTransaction = ignore
     When COMPLETE_TASK_EP is called with transport task "Task[0]"
      And reload transport task "Task[0]"
      And transport task "Task[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H01-WE", storageLocation = "W-101", clProcess = "GR", typProcess = "SETUP", stepProcess = "FINISH"
      And reload transport task target "TaskTarget[0]"
      And transport task target "TaskTarget[0]" has: idTask = ignore, numTarget = 1, stat = "90", numSort = 1, storageArea = "H02-HRL", storageLocation = ignore, idTransaction = ignore
     Then reload bps record "LuBpsRecord[0]"
      And bps record "LuBpsRecord[0]" has: idRecord = ignore, stat = "90", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "90", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067005", qty = 100.0, artvar = "2", typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 65000.0, unitWt = "GR", vol = 204000.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H02-HRL", storageLocationSrc = ignore, storageAreaTgt = null, storageLocationTgt = null
      And reload receiving item "ReceivingItem[0]"
      And receiving item "ReceivingItem[0]" has: idGoodsReceipt = key:Receiving, numItem = 1, stat = "90", idArticle = "40067005", artvar = "2", qtyDeliveryNote = 0.0, qtyTarget = 100.0, qtyCanceled = 0.0, qtyActual = 100.0, sepCrit03 = key:Receiving
     Then reload bps record "LuBpsRecord[1]"
      And bps record "LuBpsRecord[1]" has: idRecord = ignore, stat = "90", typ = "DEF", priorityOrig = 500, idRecordGrp = ignore, typStep = "TRANSPORT", statStep = "90", tsStartTargetMaxStep = now+0.02:00, tsEndTargetMax = now+0.04:00, numConsecStep = 2, idNode = "7c350f9f-cac6-4e5e-ba70-38dd40e13972", idArticle = "40067008", qty = 40.0, artvar = null, typStock = "AV", typLock = "------", statQualityControl = "00", statCustoms = "00", sepCrit01 = "0011", sepCrit02 = "0220", sepCrit03 = ignore, wt = 32840.0, unitWt = "GR", vol = 56480.0, unitVol = "CBCM", idLuSrc = ignore, idQuantumSrc = ignore, storageAreaSrc = "H02-HRL", storageLocationSrc = ignore, storageAreaTgt = null, storageLocationTgt = null
      And reload receiving item "ReceivingItem[1]"
      And receiving item "ReceivingItem[1]" has: idGoodsReceipt = key:Receiving, numItem = 2, stat = "90", idArticle = "40067008", artvar = null, qtyDeliveryNote = 0.0, qtyTarget = 40.0, qtyCanceled = 0.0, qtyActual = 40.0, sepCrit03 = key:Receiving

#Clean up
			Then delete load unit "Lu"

