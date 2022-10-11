@defaultdatabased
@goodsissue @order
Feature: Goods Issue Order Preprocessing
This feature depends on defaultdata for:
 							- order types
 							- decision trees
 							- articles and their weights and volumes
 							- packing units and site specific packing 
  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

  Scenario: OPP sets weight and volume
    Given order is created with: numPartialOrder = 1, idCustomer = null, typOrigin = "MAN", orderTyp = "EIL", priorityOrig = 1, priority = 1, saved as "Order"
    #10 inconso Collegeblocks
    And order item is added to order "Order" with: numConsec = 1, idArticle = "40067005", qty = 10.0
    #5 inconso Chocolate Dessert
    And order item is added to order "Order" with: numConsec = 2, idArticle = "40067022", qty = 5.0
    #20 inconso Shopping Bags
    And order item is added to order "Order" with: numConsec = 3, idArticle = "40067024", qty = 20.0
    When OPP_SINGLE_ORDER is called for "Order"
     And 10 sec is passed
    #Default ArtVar
     Then order "Order" has 3 order items, saved as collection "OrderItem"
      And order item "OrderItem[0]" has: stat = ignore, idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = 6500.00, volTarget = 20400.00, idCre = "AUTO_IT", tsCre = now, idUpd = ignore, tsUpd = now
      And order item "OrderItem[1]" has: stat = ignore, idArticle = "40067022", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = 2025.00, volTarget = 07075.00, idCre = "AUTO_IT", tsCre = now, idUpd = ignore, tsUpd = now
      And order item "OrderItem[2]" has: stat = ignore, idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = 1000.00, volTarget = 02880.00, idCre = "AUTO_IT", tsCre = now, idUpd = ignore, tsUpd = now
    And order "Order" must have weight 9525.00
    And order "Order" must have volume 30355.00
    When CANCEL_ORDERS_EP is called for:
       | Order |
    Then WEBSERVICE succeeds
 	
 	Scenario: OPP counts items
    Given order is created with: numPartialOrder = 1, idCustomer = null, typOrigin = "MAN", orderTyp = "EIL", priorityOrig = 1, priority = 1, saved as "Order"
    #10 inconso Collegeblocks
    And order item is added to order "Order" with: numConsec = 1, idArticle = "40067005", qty = 10.0
    #5 inconso Chocolate Dessert
    And order item is added to order "Order" with: numConsec = 2, idArticle = "40067022", qty = 5.0
    #20 inconso Shopping Bags
    And order item is added to order "Order" with: numConsec = 3, idArticle = "40067024", qty = 20.0
    When OPP_SINGLE_ORDER is called for "Order"
     And 10 sec is passed
    # check count
    Then order "Order" has 3 order items, saved as collection "OrderItem"
    When CANCEL_ORDERS_EP is called for:
       | Order |
    Then WEBSERVICE succeeds
    
   Scenario: OPP set type lock and type stock if empty
    Given order is created with: numPartialOrder = 1, idCustomer = null, typOrigin = "MAN", orderTyp = "EIL", priorityOrig = 1, priority = 1, saved as "Order"
    #10 inconso Collegeblocks
    And order item is added to order "Order" with: numConsec = 1, idArticle = "40067005", qty = 10.0
    #5 inconso Chocolate Dessert
    And order item is added to order "Order" with: numConsec = 2, idArticle = "40067022", qty = 5.0
    #20 inconso Shopping Bags
    And order "Order" item 2 has stock type "LO" 
    And order item is added to order "Order" with: numConsec = 3, idArticle = "40067024", qty = 20.0
		And order "Order" item 3 has lock type "BATCH" 
    When OPP_SINGLE_ORDER is called for "Order"
     And 10 sec is passed
    Then order "Order" has 3 order items, saved as collection "OrderItem"
     And order item "OrderItem[0]" has: stat = ignore, idArticle = "40067005", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = ignore, tsUpd = now
     And order item "OrderItem[1]" has: stat = ignore, idArticle = "40067022", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "LO", typLock = "------", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = ignore, tsUpd = now
     And order item "OrderItem[2]" has: stat = ignore, idArticle = "40067024", qtyActual = 0.0, qtyReserved = 0.0, qtyCanceled = 0.0, typStock = "AV", typLock = "BATCH", wtTarget = ignore, volTarget = ignore, idCre = "AUTO_IT", tsCre = now, idUpd = ignore, tsUpd = now
    When CANCEL_ORDERS_EP is called for:
       | Order |
    Then WEBSERVICE succeeds
     And 3 sec is passed
    