@defaultdatabased
@stocktaking

Feature: Stocktaking by document

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"
    

  Scenario: Test list creation
  # Collegeblock
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067005" has to be created
    And the target location is "H01-FACH"-"106-2-001-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuCollegeblock[0]"; transaction saved as "Transaction"
    
    # Makeup
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.0 pieces of article "40067114" has to be created
    And the target location is "H01-FACH"-"106-2-002-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And BBD is 2021/03/12 and batch is null
    And CREQU is called
    And CREQU was successful, saved as "QuMakeup[0]"; transaction saved as "Transaction"
		
    # Shopping Bag
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 10.0 pieces of article "40067024" has to be created
    And the target location is "H01-FACH"-"106-2-003-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuShoppingBag[0]"; transaction saved as "Transaction"
    
    When STOCK_TAKING_CREATE is called with: cntItemsListMax = 5, cntItemsOverallMax = 60, datTarget = 1601416800000, idTerminal = "IPC6460", idWorkcenter = "STMCTR-000", stockTakingZoneList = "ST_H1_04", storageArea = "H01-FACH", storageLocation = null, typEntry = "DOC", typStockTakingList = "TEILK", saved as "StockTakingLists"   
	  Then verify 12 stocktaking lists created
	  And  verify 60 list items created, 3 items not empty
	  
	  
	  # cleanup
	  And  CANCEL_STOCK_TAKING_LISTS
	  
	  Then the quantum "QuCollegeblock[0]" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the quantum "QuMakeup[0]" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the quantum "QuShoppingBag[0]" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
	  
	
 	Scenario: Test enter quantities
 	  # Collegeblock
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 15.0 pieces of article "40067005" has to be created
    And the target location is "H01-FACH"-"106-2-001-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuCollegeblock[0]"; transaction saved as "Transaction"
 	
 	  # Makeup
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.0 pieces of article "40067114" has to be created
    And the target location is "H01-FACH"-"106-2-002-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And BBD is 2021/03/12 and batch is null
    And CREQU is called
    And CREQU was successful, saved as "QuMakeup[0]"; transaction saved as "Transaction"

    # Shopping Bag
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 9.0 pieces of article "40067024" has to be created
    And the target location is "H01-FACH"-"106-2-003-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuShoppingBag[0]"; transaction saved as "Transaction"

	 	When STOCK_TAKING_CREATE is called with: cntItemsListMax = 15, cntItemsOverallMax = 40, datTarget = 1601416800000, idTerminal = "IPC6460", idWorkcenter = "STMCTR-000", stockTakingZoneList = "ST_H1_04", storageArea = "H01-FACH", storageLocation = "106-2-001-02", typEntry = "DOC", typStockTakingList = "TEILK", saved as "StockTakingList[0]"   
		Then verify 1 stocktaking lists created
		 And status StockTakingList "StockTakingList[0]" is "20"
		Then ENTER_QTY_ACTUAL is called for "StockTakingList[0]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000", cntCount = 1 and:
		|qtyActual |15|
		When STOCK_TAKING_CREATE is called with: cntItemsListMax = 15, cntItemsOverallMax = 40, datTarget = 1601416800000, idTerminal = "IPC6460", idWorkcenter = "STMCTR-000", stockTakingZoneList = "ST_H1_04", storageArea = "H01-FACH", storageLocation = "106-2-002-02", typEntry = "DOC", typStockTakingList = "TEILK", saved as "StockTakingList[1]"   
		Then verify 2 stocktaking lists created
		 And status StockTakingList "StockTakingList[0]" is "20"
		Then ENTER_QTY_ACTUAL is called for "StockTakingList[1]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000", cntCount = 1 and:
		|qtyActual |5|
	  When STOCK_TAKING_CREATE is called with: cntItemsListMax = 15, cntItemsOverallMax = 40, datTarget = 1601416800000, idTerminal = "IPC6460", idWorkcenter = "STMCTR-000", stockTakingZoneList = "ST_H1_04", storageArea = "H01-FACH", storageLocation = "106-2-003-02", typEntry = "DOC", typStockTakingList = "TEILK", saved as "StockTakingList[2]"   
		Then verify 3 stocktaking lists created
		 And status StockTakingList "StockTakingList[0]" is "20"
		Then ENTER_QTY_ACTUAL is called for "StockTakingList[2]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000", cntCount = 1 and:
		|qtyActual |9|
		Then FINISH_ENTER_QTY_ACTUAL is called for "StockTakingList[0]"
		Then FINISH_ENTER_QTY_ACTUAL is called for "StockTakingList[1]"
		Then FINISH_ENTER_QTY_ACTUAL is called for "StockTakingList[2]"

	 	  # cleanup
	  And  CANCEL_STOCK_TAKING_LISTS
	  Then the quantum "QuCollegeblock[0]" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the quantum "QuMakeup[0]" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the quantum "QuShoppingBag[0]" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"

    

	Scenario: Test enter quantities, save new finding and book lists
 	  # Collegeblock
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 15.0 pieces of article "40067005" has to be created
    And the target location is "H01-FACH"-"106-2-001-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuCollegeblock[0]"; transaction saved as "Transaction"
 	
 	  # Makeup
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.0 pieces of article "40067114" has to be created
    And the target location is "H01-FACH"-"106-2-002-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And BBD is 2021/03/12 and batch is null
    And CREQU is called
    And CREQU was successful, saved as "QuMakeup[0]"; transaction saved as "Transaction"

    # Shopping Bag
    Given a quantum from storage location "QUELLE-LAG"-"Q-001" with 9.0 pieces of article "40067024" has to be created
    And the target location is "H01-FACH"-"106-2-003-02"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuShoppingBag[0]"; transaction saved as "Transaction"
    
    When STOCK_TAKING_CREATE is called with: cntItemsListMax = 15, cntItemsOverallMax = 40, datTarget = 1601416800000, idTerminal = "IPC6460", idWorkcenter = "STMCTR-000", stockTakingZoneList = "ST_H1_04", storageArea = "H01-FACH", storageLocation = "106-2-001-02", typEntry = "DOC", typStockTakingList = "TEILK", saved as "StockTakingList[0]"   
		Then verify 1 stocktaking lists created
		And status StockTakingList "StockTakingList[0]" is "20"
		Then ENTER_QTY_ACTUAL is called for "StockTakingList[0]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000", cntCount = 1 and:
		|qtyActual |15|
		When STOCK_TAKING_CREATE is called with: cntItemsListMax = 15, cntItemsOverallMax = 40, datTarget = 1601416800000, idTerminal = "IPC6460", idWorkcenter = "STMCTR-000", stockTakingZoneList = "ST_H1_04", storageArea = "H01-FACH", storageLocation = "106-2-002-02", typEntry = "DOC", typStockTakingList = "TEILK", saved as "StockTakingList[1]"   
		Then verify 2 stocktaking lists created
		Then ENTER_QTY_ACTUAL is called for "StockTakingList[1]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000", cntCount = 1 and:
		|qtyActual |5|
	  When STOCK_TAKING_CREATE is called with: cntItemsListMax = 15, cntItemsOverallMax = 40, datTarget = 1601416800000, idTerminal = "IPC6460", idWorkcenter = "STMCTR-000", stockTakingZoneList = "ST_H1_04", storageArea = "H01-FACH", storageLocation = "106-2-003-02", typEntry = "DOC", typStockTakingList = "TEILK", saved as "StockTakingList[2]"   
		Then verify 3 stocktaking lists created
		Then ENTER_QTY_ACTUAL is called for "StockTakingList[2]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000", cntCount = 1 and:
		|qtyActual |9|
		Then FINISH_ENTER_QTY_ACTUAL is called for "StockTakingList[0]"
		Then FINISH_ENTER_QTY_ACTUAL is called for "StockTakingList[1]"
		Then FINISH_ENTER_QTY_ACTUAL is called for "StockTakingList[2]"
		
		When CREATE_AND_BOOK_DISCOVERY is called for "StockTakingList[0]" with: artvar = "1", idArticle = "40067222", idTerminal = "IPC6460", idWorkcenter = "STM-000", qtyMoved = 3.0, storageArea = "H01-FACH", storageLocation = "106-2-001-02", typLock = "------", statCustoms = "00", statQualityControl = "00", typStock = "AV", save as "QuDiscovery"
	  
	  Then BOOK_STOCK_TAKING_LIST is called for "StockTakingList[0]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000"
	  Then BOOK_STOCK_TAKING_LIST is called for "StockTakingList[1]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000"
	  Then BOOK_STOCK_TAKING_LIST is called for "StockTakingList[2]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000"
	  
	  Then COMPLETE_STOCK_TAKING_LIST is called for "StockTakingList[0]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000"
	  And  status StockTakingList "StockTakingList[0]" is "90"
	  Then COMPLETE_STOCK_TAKING_LIST is called for "StockTakingList[1]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000"
	  And  status StockTakingList "StockTakingList[1]" is "90"
	  Then COMPLETE_STOCK_TAKING_LIST is called for "StockTakingList[2]" with: idTerminal = "IPC6460", idWorkcenter = "STM-000"
	  And  status StockTakingList "StockTakingList[2]" is "90"
		
			 	  # cleanup
	
	  Then the quantum "QuCollegeblock[0]" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the quantum "QuMakeup[0]" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the quantum "QuShoppingBag[0]" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the quantum "QuDiscovery" has to be booked to location "SENKE-LAG"-"S-001"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
   

	
    