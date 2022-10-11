#Author: pjohnke@inconso.de
#Keywords Summary : goods receiving inbound delivery process
@defaultdatabased
@goodsreceiving @delivery

Feature: Goods Receiving Delivery

# ToDo: Rework scenario descriptions, GR300_SEARCH_VEHICLES
  Background:
     Given set global: idSite = "RL1", idClient = "RK1"


  Scenario: GR300_SEARCH_VEHICLES finds nothing since idSite = null
     Given set global: idSite = null, idClient = "RK1"
		 When GR300_SEARCH_VEHICLES searches for: input = null
     Then GR300_SEARCH_VEHICLES finds 0 records

  Scenario: GR300_SEARCH_VEHICLES to search vehicles
     Given set global: idSite = "RL1", idClient = null
     When GR300_SEARCH_VEHICLES searches for: input = null
     Then GR300_SEARCH_VEHICLES finds 4 records
      And GR300_SEARCH_VEHICLES result record 0 has: idSite = "RL1", idTransportVehicle = "42900000002", typTransportVehicle = "IN", numTourExt = 10042, stat = ignore, nameDriver = "Benjamin Weiss", tsArrival = ignore, tsDock = ignore, tsStart = ignore, tsEnd = ignore, tsDeparture = ignore, truckLicensePlate = "SHL-VR-46"
      And GR300_SEARCH_VEHICLES result record 1 has: idSite = "RL1", idTransportVehicle = "42900000003", typTransportVehicle = "IN", numTourExt = 10057, stat = ignore, nameDriver = "Christian Diederich", tsArrival = ignore, tsDock = ignore, tsStart = ignore, tsEnd = ignore, tsDeparture = ignore, truckLicensePlate = "HZ-AG-1269"
      And GR300_SEARCH_VEHICLES result record 2 has: idSite = "RL1", idTransportVehicle = "42900000004", typTransportVehicle = "OUT", numTourExt = 90089, stat = ignore, nameDriver = "Yvonne Foerster", tsArrival = ignore, tsDock = ignore, tsStart = ignore, tsEnd = ignore, tsDeparture = ignore, truckLicensePlate = "HB-FE-211"
      And GR300_SEARCH_VEHICLES result record 3 has: idSite = "RL1", idTransportVehicle = "42900000005", typTransportVehicle = "OUT", numTourExt = 90017, stat = ignore, nameDriver = "Jens Schmidt", tsArrival = ignore, tsDock = ignore, tsStart = ignore, tsEnd = ignore, tsDeparture = ignore, truckLicensePlate = "ST-FL-254"
# Da tsArrival nicht gesetzt
#     And GR300_SEARCH_VEHICLES result record ? has: idSite = "RL1", idTransportVehicle = "42000000001", typTransportVehicle = "IN", numTourExt = 10008, stat = ignore, nameDriver = "Laura Schuster", tsArrival = ignore, tsDock = ignore, tsStart = ignore, tsEnd = ignore, tsDeparture = ignore, truckLicensePlate = "AC-WL-765"
#     And GR300_SEARCH_VEHICLES result record ? has: idSite = "RL1", idTransportVehicle = "42000000006", typTransportVehicle = "OUT", numTourExt = 90045, stat = ignore, nameDriver = "Heinz Wunderlich", tsArrival = ignore, tsDock = ignore, tsStart = ignore, tsEnd = ignore, tsDeparture = ignore, truckLicensePlate = "MR-E-87"


  Scenario: GR300_UPDATE_DELIVERY to create a new delivery
     When GR300_UPDATE_DELIVERY creates record with: numDeliveryNote = "TO_BE_CHANGED", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = "42900000001", nameDriver = "Laura Schuster", truckLicensePlate = "AC-WL-765"
     Then GR300_UPDATE_DELIVERY result is saved as "Delivery"
     When GR300_UPDATE_DELIVERY updates record with: idInboundDelivery = key:Delivery, numDeliveryNote = "CHANGED", datDeliveryNote = today, idSupplier = "312", name = null, idTransportVehicle = "42900000001", nameDriver = "Laura Schuster", truckLicensePlate = "AC-WL-765"
     Then GR300_UPDATE_DELIVERY result is saved as "Delivery"
     When GR300_SEARCH_DELIVERIES searches for: input = "CHANGED"
     Then GR300_SEARCH_DELIVERIES finds 1 record
      And GR300_SEARCH_DELIVERIES result record 0 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numDeliveryNote = "CHANGED", datDeliveryNote = today, idSupplier = "312", name = "Raab Office Discount", idTransportVehicle = "42900000001", nameDriver = "Laura Schuster", truckLicensePlate = "AC-WL-765"

#  Scenario: GR300_UPDATE_DELIVERY to create a new delivery
#     When GR300_UPDATE_DELIVERY creates record with: numDeliveryNote = "WRONG_SUPPLIER_TEXT", datDeliveryNote = today, idSupplier = "SUPP_1", name = "Wrong supplier text", idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
#     Then GR300_UPDATE_DELIVERY result is saved as "Delivery"
#     Given set global: idSite = null, idClient = "RK1"
#     When GR300_SEARCH_SUPPLIERS searches for: input = "Wrong supplier text"
#     Then GR300_SEARCH_SUPPLIERS finds 0 record
#     When GR300_SEARCH_DELIVERIES searches for: input = "WRONG_SUPPLIER_TEXT"
#     Then GR300_SEARCH_DELIVERIES finds 1 record
#      And GR300_SEARCH_DELIVERIES result record 0 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numDeliveryNote = "WRONG_SUPPLIER_TEXT", datDeliveryNote = today, idSupplier = "SUPP_1", name = "Supplier 1", idTransportVehicle = null, nameDriver = null, truckLicensePlate = null

#  Scenario: GR300_UPDATE_DELIVERY to create a new delivery
#     When GR300_UPDATE_DELIVERY creates record with: numDeliveryNote = "NEW_SUPPLIER", datDeliveryNote = today, idSupplier = "NEW", name = "new", idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
#     Then GR300_UPDATE_DELIVERY result is saved as "Delivery"
#     When GR300_SEARCH_SUPPLIERS searches for: input = "new"
#     Then GR300_SEARCH_SUPPLIERS finds 1 record
#      And GR300_SEARCH_SUPPLIERS result record 0 has: idClient = "RK1", idSupplier = "NEW", name = "new"
#     When GR300_SEARCH_DELIVERIES searches for: input = "NEW_SUPPLIER"
#     Then GR300_SEARCH_DELIVERIES finds 1 record
#      And GR300_SEARCH_DELIVERIES result record 0 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numDeliveryNote = "NEW_SUPPLIER", datDeliveryNote = today, idSupplier = "NEW", name = "new", idTransportVehicle = null, nameDriver = null, truckLicensePlate = null

# Legt implizit ein neues Vehicle mit anderer ID und leeren Feldern an -> siehe #5746
#  Scenario: GR300_UPDATE_DELIVERY to create a new delivery
#     When GR300_UPDATE_DELIVERY creates record with: numDeliveryNote = "UNKNOWN_VEHICLE", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = "42999999999", nameDriver = null, truckLicensePlate = null
#		 Then WEBSERVICE fails: error = "BEND-????"

  Scenario: GR300_UPDATE_DELIVERY_TEXT to delete not existing record
    Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "TEXT_FAIL", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
      And GR300_UPDATE_DELIVERY result is saved as "Delivery"
     When GR300_UPDATE_DELIVERY_TEXT deletes record with: idInboundDelivery = key:Delivery, numConsec = 2
		 Then WEBSERVICE fails: error = "BEND-0001"

  Scenario: GR300_UPDATE_DELIVERY_ITEM to delete not existing record
    Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM_FAIL", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
      And GR300_UPDATE_DELIVERY result is saved as "Delivery"
     When GR300_UPDATE_DELIVERY_ITEM deletes record with: idInboundDelivery = key:Delivery, numItem = 2
		 Then WEBSERVICE fails: error = "BEND-0001"

  Scenario: GR300_UPDATE_DELIVERY_ITEM_EP to delete not existing record
    Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM_EP_FAIL", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
      And GR300_UPDATE_DELIVERY result is saved as "Delivery"
     When GR300_UPDATE_DELIVERY_ITEM_EP deletes record with: idInboundDelivery = key:Delivery, numItem = 2
		 Then WEBSERVICE fails: error = "BEND-0001"

  Scenario: GR300_UPDATE_DELIVERY_ITEM_TEXT to delete not existing record
    Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM_TEXT_FAIL", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
      And GR300_UPDATE_DELIVERY result is saved as "Delivery"
     When GR300_UPDATE_DELIVERY_ITEM_TEXT deletes record with: idInboundDelivery = key:Delivery, numItem = 2, numConsec = 3
		 Then WEBSERVICE fails: error = "BEND-0001"

  Scenario: GR300_UPDATE_DELIVERY_TEXT to create a new delivery text
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "TEXT", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
      When GR300_UPDATE_DELIVERY_TEXT creates record with: idInboundDelivery = key:Delivery, typTxt = "SETINF", txtInboundDelivery = "1st delivery text"
       And GR300_UPDATE_DELIVERY_TEXT is successful
      When GR300_UPDATE_DELIVERY_TEXT creates record with: idInboundDelivery = key:Delivery, typTxt = "SETINF", txtInboundDelivery = "? delivery text"
       And GR300_UPDATE_DELIVERY_TEXT is successful
      When GR300_UPDATE_DELIVERY_TEXT creates record with: idInboundDelivery = key:Delivery, typTxt = "SETINF", txtInboundDelivery = "3nd delivery text"
       And GR300_UPDATE_DELIVERY_TEXT is successful
      When GR300_UPDATE_DELIVERY_TEXT creates record with: idInboundDelivery = key:Delivery, typTxt = "SETINF", txtInboundDelivery = "4th delivery text"
       And GR300_UPDATE_DELIVERY_TEXT is successful
      Then delivery has 4 delivery texts
      When GR300_UPDATE_DELIVERY_TEXT deletes record with: idInboundDelivery = key:Delivery, numConsec = 3
       And GR300_UPDATE_DELIVERY_TEXT is successful
      Then delivery has 3 delivery texts
      When GR300_UPDATE_DELIVERY_TEXT updates record with: idInboundDelivery = key:Delivery, numConsec = 2, typTxt = "SETINF", txtInboundDelivery = "2nd delivery text"
       And GR300_UPDATE_DELIVERY_TEXT is successful
      Then delivery has 3 delivery texts
      When GR300_SEARCH_DELIVERY_TEXT searches for: idInboundDelivery = key:Delivery, typTxt = "SETINF"
      Then GR300_SEARCH_DELIVERY_TEXT finds 3 records
       And GR300_SEARCH_DELIVERY_TEXT result record 0 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numConsec = 1, typTxt = "SETINF", txtInboundDelivery = "1st delivery text"
       And GR300_SEARCH_DELIVERY_TEXT result record 1 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numConsec = 2, typTxt = "SETINF", txtInboundDelivery = "2nd delivery text"
       And GR300_SEARCH_DELIVERY_TEXT result record 2 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numConsec = 4, typTxt = "SETINF", txtInboundDelivery = "4th delivery text"

  Scenario: GR300_UPDATE_DELIVERY_ITEM to create a new delivery item
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
      When GR300_UPDATE_DELIVERY_ITEM creates record with: idInboundDelivery = key:Delivery, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = null, tsBbd = null
       And GR300_UPDATE_DELIVERY_ITEM is successful
      When GR300_UPDATE_DELIVERY_ITEM creates record with: idInboundDelivery = key:Delivery, idArticle = "40067007", qtyDeliveryNote = 5, idBatch = null, tsBbd = null
       And GR300_UPDATE_DELIVERY_ITEM is successful
      When GR300_UPDATE_DELIVERY_ITEM creates record with: idInboundDelivery = key:Delivery, idArticle = "40067008", qtyDeliveryNote = 1, idBatch = null, tsBbd = null
       And GR300_UPDATE_DELIVERY_ITEM is successful
      When GR300_UPDATE_DELIVERY_ITEM creates record with: idInboundDelivery = key:Delivery, idArticle = "40067111", qtyDeliveryNote = 8, idBatch = "Batch 1", tsBbd = null
       And GR300_UPDATE_DELIVERY_ITEM is successful
      Then delivery has 4 delivery items
      When GR300_UPDATE_DELIVERY_ITEM deletes record with: idInboundDelivery = key:Delivery, numItem = 3
       And GR300_UPDATE_DELIVERY_ITEM is successful
      Then delivery has 3 delivery items
      When GR300_UPDATE_DELIVERY_ITEM updates record with: idInboundDelivery = key:Delivery, numItem = 2, idArticle = "40067022", qtyDeliveryNote = 5, idBatch = null, tsBbd = today+365
       And GR300_UPDATE_DELIVERY_ITEM is successful
      Then delivery has 3 delivery items
      When GR300_SEARCH_DELIVERY_ITEM searches for: idInboundDelivery = key:Delivery, input = null
      Then GR300_SEARCH_DELIVERY_ITEM finds 3 records
       And GR300_SEARCH_DELIVERY_ITEM result record 0 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numItem = 1, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = null, tsBbd = null
       And GR300_SEARCH_DELIVERY_ITEM result record 1 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numItem = 2, idArticle = "40067022", qtyDeliveryNote = 5, idBatch = null, tsBbd = today+365
       And GR300_SEARCH_DELIVERY_ITEM result record 2 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numItem = 4, idArticle = "40067111", qtyDeliveryNote = 8, idBatch = "Batch 1", tsBbd = null

  Scenario: GR300_UPDATE_DELIVERY_ITEM_EP to create a new delivery item
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM_EP", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = null, tsBbd = null, idAdvice = null, numItemAdvice = null
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067007", qtyDeliveryNote = 5, idBatch = null, tsBbd = null, idAdvice = null, numItemAdvice = null
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067008", qtyDeliveryNote = 1, idBatch = null, tsBbd = null, idAdvice = null, numItemAdvice = null
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067111", qtyDeliveryNote = 8, idBatch = "Batch 1", tsBbd = null, idAdvice = null, numItemAdvice = null
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      Then delivery has 4 delivery items
      When GR300_UPDATE_DELIVERY_ITEM_EP deletes record with: idInboundDelivery = key:Delivery, numItem = 3
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      Then delivery has 3 delivery items
      When GR300_UPDATE_DELIVERY_ITEM_EP updates record with: idInboundDelivery = key:Delivery, numItem = 2, idArticle = "40067022", qtyDeliveryNote = 5, idBatch = null, tsBbd = today+365, idAdvice = null, numItemAdvice = null
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      Then delivery has 3 delivery items
      When GR300_SEARCH_DELIVERY_ITEM searches for: idInboundDelivery = key:Delivery, input = null
      Then GR300_SEARCH_DELIVERY_ITEM finds 3 records
       And GR300_SEARCH_DELIVERY_ITEM result record 0 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numItem = 1, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = null, tsBbd = null
       And GR300_SEARCH_DELIVERY_ITEM result record 1 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numItem = 2, idArticle = "40067022", qtyDeliveryNote = 5, idBatch = null, tsBbd = today+365
       And GR300_SEARCH_DELIVERY_ITEM result record 2 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numItem = 4, idArticle = "40067111", qtyDeliveryNote = 8, idBatch = "Batch 1", tsBbd = null

  Scenario: GR300_UPDATE_DELIVERY_ITEM_TEXT to create a new delivery item text
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM_TEXT", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
     Given GR300_UPDATE_DELIVERY_ITEM_EP created record with: idInboundDelivery = key:Delivery, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = null, tsBbd = null, idAdvice = null, numItemAdvice = null
       And GR300_UPDATE_DELIVERY_ITEM_EP was successful
     Given GR300_UPDATE_DELIVERY_ITEM_EP created record with: idInboundDelivery = key:Delivery, idArticle = "40067007", qtyDeliveryNote = 5, idBatch = null, tsBbd = null, idAdvice = null, numItemAdvice = null
       And GR300_UPDATE_DELIVERY_ITEM_EP was successful
		  When GR300_UPDATE_DELIVERY_ITEM_TEXT creates record with: idInboundDelivery = key:Delivery, numItem = 2, typTxt = "SETINF", txtInboundDeliveryItem = "item 2 text 1"
		   And GR300_UPDATE_DELIVERY_ITEM_TEXT is successful
		  When GR300_UPDATE_DELIVERY_ITEM_TEXT creates record with: idInboundDelivery = key:Delivery, numItem = 2, typTxt = "SETINF", txtInboundDeliveryItem = "item 2 text ?"
		   And GR300_UPDATE_DELIVERY_ITEM_TEXT is successful
		  When GR300_UPDATE_DELIVERY_ITEM_TEXT creates record with: idInboundDelivery = key:Delivery, numItem = 2, typTxt = "SETINF", txtInboundDeliveryItem = "item 2 text 3"
		   And GR300_UPDATE_DELIVERY_ITEM_TEXT is successful
		  When GR300_UPDATE_DELIVERY_ITEM_TEXT creates record with: idInboundDelivery = key:Delivery, numItem = 2, typTxt = "SETINF", txtInboundDeliveryItem = "item 2 text 4"
		   And GR300_UPDATE_DELIVERY_ITEM_TEXT is successful
      Then delivery item with numItem = 1 has 0 delivery item texts
      Then delivery item with numItem = 2 has 4 delivery item texts
      When GR300_UPDATE_DELIVERY_ITEM_TEXT deletes record with: idInboundDelivery = key:Delivery, numItem = 2, numConsec = 3
       And GR300_UPDATE_DELIVERY_ITEM_TEXT is successful
      Then delivery item with numItem = 2 has 3 delivery item texts
      When GR300_UPDATE_DELIVERY_ITEM_TEXT updates record with: idInboundDelivery = key:Delivery, numItem = 2, numConsec = 2, typTxt = "SETINF", txtInboundDeliveryItem = "item 2 text 2"
		   And GR300_UPDATE_DELIVERY_ITEM_TEXT is successful
      Then delivery item with numItem = 2 has 3 delivery item texts
      When GR300_SEARCH_DELIVERY_ITEM_TEXT searches for: idInboundDelivery = key:Delivery, numItem = 2, typTxt = "SETINF"
      Then GR300_SEARCH_DELIVERY_ITEM_TEXT finds 3 records
       And GR300_SEARCH_DELIVERY_ITEM_TEXT result record 0 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numItem = 2, numConsec = 1, typTxt = "SETINF", txtInboundDeliveryItem = "item 2 text 1"
       And GR300_SEARCH_DELIVERY_ITEM_TEXT result record 1 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numItem = 2, numConsec = 2, typTxt = "SETINF", txtInboundDeliveryItem = "item 2 text 2"
       And GR300_SEARCH_DELIVERY_ITEM_TEXT result record 2 has: idSite = "RL1", idClient = "RK1", idInboundDelivery = key:Delivery, numItem = 2, numConsec = 4, typTxt = "SETINF", txtInboundDeliveryItem = "item 2 text 4"
      
  Scenario: GR300_SEARCH_DELIVERIES to search deliveries
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "1_DELIVERY_SEARCH", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "2_DELIVERY_SEARCH", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "3_DELIVERY_SEARCH", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
      When GR300_SEARCH_DELIVERIES searches for: input = "_DELIVERY_SEARCH"
      Then GR300_SEARCH_DELIVERIES finds 3 records
     Given set global: idSite = "RL2", idClient = "RK1"
      When GR300_SEARCH_DELIVERIES searches for: input = "_DELIVERY_SEARCH"
      Then GR300_SEARCH_DELIVERIES finds 0 records
     Given set global: idSite = "RL1", idClient = "RK2"
      When GR300_SEARCH_DELIVERIES searches for: input = "_DELIVERY_SEARCH"
      Then GR300_SEARCH_DELIVERIES finds 0 records

# idInboundDelivery must not be null ???
#  Scenario: GR300_SEARCH_DELIVERIES_ITEM to search delivery items
#     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "1_TEXT_SEARCH", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
#       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
#     Given GR300_UPDATE_DELIVERY_ITEM created record with: idInboundDelivery = key:Delivery, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = "1st-batch-1st-delivery", tsBbd = null
#       And GR300_UPDATE_DELIVERY_ITEM was successful
#     Given GR300_UPDATE_DELIVERY_ITEM created record with: idInboundDelivery = key:Delivery, idArticle = "40067007", qtyDeliveryNote = 5, idBatch = "2nd-batch-1st-delivery", tsBbd = null
#       And GR300_UPDATE_DELIVERY_ITEM was successful
#     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "2_TEXT_SEARCH", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
#       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
#     Given GR300_UPDATE_DELIVERY_ITEM created record with: idInboundDelivery = key:Delivery, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = "1st-batch-2nd-delivery", tsBbd = null
#       And GR300_UPDATE_DELIVERY_ITEM was successful
#     Given GR300_UPDATE_DELIVERY_ITEM created record with: idInboundDelivery = key:Delivery, idArticle = "40067007", qtyDeliveryNote = 5, idBatch = "2nd-batch-2nd-delivery", tsBbd = null
#       And GR300_UPDATE_DELIVERY_ITEM was successful
#      When GR300_SEARCH_DELIVERY_ITEM searches for: idInboundDelivery = null, input = "batch"
#      Then GR300_SEARCH_DELIVERY_ITEM finds 2 records
#      When GR300_SEARCH_DELIVERY_ITEM searches for: idInboundDelivery = null, input = "batch"
#      Then GR300_SEARCH_DELIVERY_ITEM finds 4 records
#      When GR300_SEARCH_DELIVERY_ITEM searches for: idInboundDelivery = null, input = "40067007"
#      Then GR300_SEARCH_DELIVERY_ITEM finds 2 records

  Scenario: GR300_SEARCH_CLIENTS fails since idSite = null
		 When GR300_SEARCH_CLIENTS searches for: idSite = null, idClient = "RK1"
		 Then WEBSERVICE fails: error = "BEND-0001"

  Scenario: GR300_SEARCH_CLIENTS to search clients
		 When GR300_SEARCH_CLIENTS searches for: idSite = "RL1", idClient = null
     Then GR300_SEARCH_CLIENTS finds 2 records
      And GR300_SEARCH_CLIENTS result record 0 has: idSite = "RL1", idClient = "RK1", name = "Referenzklient 1"
      And GR300_SEARCH_CLIENTS result record 1 has: idSite = "RL1", idClient = "RK2", name = "Referenzklient 2"
      
  Scenario: GR300_SEARCH_CLIENTS to search client RK1
     When GR300_SEARCH_CLIENTS searches for: idSite = "RL1", idClient = "RK1"
     Then GR300_SEARCH_CLIENTS finds 1 record
      And GR300_SEARCH_CLIENTS result record 0 has: idSite = "RL1", idClient = "RK1", name = "Referenzklient 1"

  Scenario: GR300_SEARCH_ARTICLES fails since idClient = null
     Given set global: idSite = "RL1", idClient = null
		 When GR300_SEARCH_ARTICLES searches for: input = "College"
		 Then WEBSERVICE fails: error = "BEND-0005"

  Scenario: GR300_SEARCH_ARTICLES to search articles
		 When GR300_SEARCH_ARTICLES searches for: input = "Col"
		 Then GR300_SEARCH_ARTICLES finds 1 record
      And GR300_SEARCH_ARTICLES result record 0 has: idClient = "RK1", idArticle = "40067005", codeEan = "55333340067005", txtLabel = "Körber Collegeblock", unitSock = "PCS", flgArtvar = true, flgBatch = false, flgBbd = false

  Scenario: GR300_SEARCH_ARTICLES to search articles
     Given set global: idSite = null, idClient = "RK1"
		 When GR300_SEARCH_ARTICLES searches for: input = "40067005"
		 Then GR300_SEARCH_ARTICLES finds 1 record
      And GR300_SEARCH_ARTICLES result record 0 has: idClient = "RK1", idArticle = "40067005", codeEan = "55333340067005", txtLabel = "Körber Collegeblock", unitSock = "PCS", flgArtvar = true, flgBatch = false, flgBbd = false
   
  Scenario: GR300_SEARCH_ARTICLES to search articles
     Given set global: idSite = null, idClient = "RK1"
     When GR300_SEARCH_ARTICLES searches for: input = "Körber"
     Then GR300_SEARCH_ARTICLES finds 12 records
      And GR300_SEARCH_ARTICLES result record 0 has: idClient = "RK1", idArticle = "40067005", codeEan = "55333340067005", txtLabel = "Körber Collegeblock", unitSock = "PCS", flgArtvar = true, flgBatch = false, flgBbd = false
      And GR300_SEARCH_ARTICLES result record 1 has: idClient = "RK1", idArticle = "40067007", codeEan = "55333340067007", txtLabel = "Körber Mousepad", unitSock = "PCS", flgArtvar = true, flgBatch = false, flgBbd = false
      And GR300_SEARCH_ARTICLES result record 2 has: idClient = "RK1", idArticle = "40067008", codeEan = "55333340067008", txtLabel = "Körber Hammer", unitSock = "PCS", flgArtvar = false, flgBatch = false, flgBbd = false
      And GR300_SEARCH_ARTICLES result record 3 has: idClient = "RK1", idArticle = "40067021", codeEan = "55333340067021", txtLabel = "Körber Geschenkkorb", unitSock = "PCS", flgArtvar = false, flgBatch = true, flgBbd = true
      And GR300_SEARCH_ARTICLES result record 4 has: idClient = "RK1", idArticle = "40067022", codeEan = "55333340067022", txtLabel = "Körber Chocolate Dessert", unitSock = "PCS", flgArtvar = true, flgBatch = true, flgBbd = true
      And GR300_SEARCH_ARTICLES result record 5 has: idClient = "RK1", idArticle = "40067024", codeEan = "55333340067024", txtLabel = "Körber Shopping Bag", unitSock = "PCS", flgArtvar = true, flgBatch = false, flgBbd = false
      And GR300_SEARCH_ARTICLES result record 6 has: idClient = "RK1", idArticle = "40067111", codeEan = "55333340067111", txtLabel = "Körber Aftershave", unitSock = "PCS", flgArtvar = true, flgBatch = true, flgBbd = false
      And GR300_SEARCH_ARTICLES result record 7 has: idClient = "RK1", idArticle = "40067114", codeEan = "55333340067114", txtLabel = "Körber Makeup", unitSock = "PCS", flgArtvar = true, flgBatch = false, flgBbd = true
      And GR300_SEARCH_ARTICLES result record 8 has: idClient = "RK1", idArticle = "40067222", codeEan = "55333340067222", txtLabel = "Körber Flip Flops", unitSock = "PCS", flgArtvar = true, flgBatch = false, flgBbd = false
	#T-Shirt
	    And GR300_SEARCH_ARTICLES result record 9 has: idClient = "RK1", idArticle = "55534011", codeEan = "55333355534011", txtLabel = "Körber T-Shirt", unitSock = "PCS", flgArtvar = false, flgBatch = false, flgBbd = false
	#Longsleeve
	    And GR300_SEARCH_ARTICLES result record 10 has: idClient = "RK1", idArticle = "55534012", codeEan = "55333355534012", txtLabel = "Körber Longsleeve", unitSock = "PCS", flgArtvar = false, flgBatch = false, flgBbd = false
  #Polo Shirt
      And GR300_SEARCH_ARTICLES result record 11 has: idClient = "RK1", idArticle = "55534013", codeEan = "55333355534013", txtLabel = "Körber Polo Shirt", unitSock = "PCS", flgArtvar = false, flgBatch = false, flgBbd = false
  

  Scenario: GR300_SEARCH_SUPPLIERS fails since idClient = null
     Given set global: idSite = "RL1", idClient = null
		 When GR300_SEARCH_SUPPLIERS searches for: input = null
		 Then WEBSERVICE fails: error = "BEND-0005"

  Scenario: GR300_SEARCH_SUPPLIERS to search suppliers
     Given set global: idSite = null, idClient = "RK1"
		 When GR300_SEARCH_SUPPLIERS searches for: input = null
		 Then GR300_SEARCH_SUPPLIERS finds 3 records
		  And GR300_SEARCH_SUPPLIERS result record 0 has: idClient = "RK1", idSupplier = "187", name = "Neugebauer und Söhne OHG"
		  And GR300_SEARCH_SUPPLIERS result record 1 has: idClient = "RK1", idSupplier = "312", name = "Raab Office Discount"
		  And GR300_SEARCH_SUPPLIERS result record 2 has: idClient = "RK1", idSupplier = "467", name = "Junker Produktion & Vertrieb"

  Scenario: GR300_SEARCH_SUPPLIERS to search suppliers
     Given set global: idSite = null, idClient = "RK1"
		 When GR300_SEARCH_SUPPLIERS searches for: input = "OHG"
		 Then GR300_SEARCH_SUPPLIERS finds 1 records
		  And GR300_SEARCH_SUPPLIERS result record 0 has: idClient = "RK1", idSupplier = "187", name = "Neugebauer und Söhne OHG"
		  
  Scenario: GR300_SEARCH_SUPPLIERS to search suppliers
     Given set global: idSite = null, idClient = "RK1"
		 When GR300_SEARCH_SUPPLIERS searches for: input = "31"
		 Then GR300_SEARCH_SUPPLIERS finds 1 record
		  And GR300_SEARCH_SUPPLIERS result record 0 has: idClient = "RK1", idSupplier = "312", name = "Raab Office Discount"
		  