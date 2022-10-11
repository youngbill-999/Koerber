#Author: pjohnke@inconso.de
#Keywords Summary : goods receiving inbound delivery process with advice
@defaultdatabased
@goodsreceiving @deliveryadvice 

Feature: Goods Receiving Delivery Advice

  Background:
     Given set global: idSite = "RL1", idClient = "RK1"

  Scenario: GR300_UPDATE_DELIVERY_ITEM_EP to create a new delivery item
     Given advice "Advice" created
     Given adviceItem 1 created for advice "Advice" with: idArticle = "40067005", typOverDelivery = "ALL", typUnderDelivery = "ALL", numItem = 1
     Given adviceItem 2 created for advice "Advice" with: idArticle = "40067007", typOverDelivery = "ALL", typUnderDelivery = "ALL", numItem = 5
     Given adviceItem 3 created for advice "Advice" with: idArticle = "40067008", typOverDelivery = "ALL", typUnderDelivery = "ALL", numItem = 1
     Given adviceItem 4 created for advice "Advice" with: idArticle = "40067111", typOverDelivery = "ALL", typUnderDelivery = "ALL", numItem = 8
       And advice "Advice" was successfully released
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM_EP", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067005", qtyDeliveryNote = 3, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 1
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067007", qtyDeliveryNote = 2, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 2
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067008", qtyDeliveryNote = 1, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 3
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067111", qtyDeliveryNote = 8, idBatch = "Batch 1", tsBbd = null, idAdvice = key:Advice, numItemAdvice = 4
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      Then delivery has 4 delivery items
       And advice "Advice" reached status "20"
       
      When GR300_CREATE_RECEIVING is called with: idInboundDelivery = key:Delivery, numDeliveryNote = "ITEM_EP", idWorkCenter = "W-000", idTerminal = "IPC6475", idGoodsReceipt = null
      Then GR300_CREATE_RECEIVING result is saved as "Receiving"
       And receiving "Receiving" has: idGoodsReceipt = ignore, stat = "02", typGoodsReceipt = "DELIV", datGoodsReceipt = now, idTerminal = null, idWorkcenter = null, clUnplanned = null

			# "SUBSEQ_BOOKING_AV" is aka "Finish (shortage)":
      Then SUBSEQ_BOOKING_AV is called for advice "Advice"

      Then 1 sec is passed
       And advice "Advice" reached status "30"
       
  Scenario: GR300_UPDATE_DELIVERY_ITEM_EP to create a new delivery item with advice (no underdelivery allowed), one overdelivery and one underdelivery
     Given advice "Advice" created
     Given adviceItem 1 created for advice "Advice" with: idArticle = "40067005", typOverDelivery = "ALL", typUnderDelivery = "NO", numItem = 1
     Given adviceItem 2 created for advice "Advice" with: idArticle = "40067007", typOverDelivery = "ALL", typUnderDelivery = "NO", numItem = 5
     Given adviceItem 3 created for advice "Advice" with: idArticle = "40067008", typOverDelivery = "ALL", typUnderDelivery = "NO", numItem = 1
     Given adviceItem 4 created for advice "Advice" with: idArticle = "40067111", typOverDelivery = "ALL", typUnderDelivery = "NO", numItem = 8
       And advice "Advice" was successfully released
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM_EP", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 1
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067007", qtyDeliveryNote = 3, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 2
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067008", qtyDeliveryNote = 1, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 3
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067111", qtyDeliveryNote = 10, idBatch = "Batch 1", tsBbd = null, idAdvice = key:Advice, numItemAdvice = 4
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      Then delivery has 4 delivery items
       And advice "Advice" reached status "20"
      
       
Scenario: GR300_UPDATE_DELIVERY_ITEM_EP to create a new delivery item with advice (no overdelivery allowed), one overdelivery and one underdelivery
     Given advice "Advice" created
     Given adviceItem 1 created for advice "Advice" with: idArticle = "40067005", typOverDelivery = "NO", typUnderDelivery = "ALL", numItem = 1
     Given adviceItem 2 created for advice "Advice" with: idArticle = "40067007", typOverDelivery = "NO", typUnderDelivery = "ALL", numItem = 5
     Given adviceItem 3 created for advice "Advice" with: idArticle = "40067008", typOverDelivery = "NO", typUnderDelivery = "ALL", numItem = 1
     Given adviceItem 4 created for advice "Advice" with: idArticle = "40067111", typOverDelivery = "NO", typUnderDelivery = "ALL", numItem = 8
       And advice "Advice" was successfully released
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM_EP", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 1
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067007", qtyDeliveryNote = 4, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 2
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067008", qtyDeliveryNote = 10, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 3
       And WEBSERVICE fails: error = "AV-0005"
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067111", qtyDeliveryNote = 8, idBatch = "Batch 1", tsBbd = null, idAdvice = key:Advice, numItemAdvice = 4
  
       

      
Scenario: GR300_UPDATE_DELIVERY_ITEM_EP to create a new delivery item with advice (no overdelivery allowed), one overdelivery
     Given advice "Advice" created
     Given adviceItem 1 created for advice "Advice" with: idArticle = "40067005", typOverDelivery = "NO", typUnderDelivery = "NO", numItem = 1
     Given adviceItem 2 created for advice "Advice" with: idArticle = "40067007", typOverDelivery = "NO", typUnderDelivery = "NO", numItem = 5
     Given adviceItem 3 created for advice "Advice" with: idArticle = "40067008", typOverDelivery = "NO", typUnderDelivery = "NO", numItem = 1
     Given adviceItem 4 created for advice "Advice" with: idArticle = "40067111", typOverDelivery = "NO", typUnderDelivery = "NO", numItem = 8
       And advice "Advice" was successfully released
     Given GR300_UPDATE_DELIVERY created record with: numDeliveryNote = "ITEM_EP", datDeliveryNote = null, idSupplier = null, name = null, idTransportVehicle = null, nameDriver = null, truckLicensePlate = null
       And GR300_UPDATE_DELIVERY result is saved as "Delivery"
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067005", qtyDeliveryNote = 1, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 1
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067007", qtyDeliveryNote = 6, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 2
       And WEBSERVICE fails: error = "AV-0005"
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067008", qtyDeliveryNote = 1, idBatch = null, tsBbd = null, idAdvice = key:Advice, numItemAdvice = 3
       And GR300_UPDATE_DELIVERY_ITEM_EP is successful
      When GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = key:Delivery, idArticle = "40067111", qtyDeliveryNote = 8, idBatch = "Batch 1", tsBbd = null, idAdvice = key:Advice, numItemAdvice = 4

       
     