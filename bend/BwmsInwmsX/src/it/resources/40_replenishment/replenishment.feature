#Author: pjohnke@inconso.de
#Keywords Summary : replenishment
@defaultdatabased
@replenishment

Feature: Replenishment

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

  Scenario: replenishment
    # Mousepad
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "LuMousepad[0]"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1800.0 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuMousepad[0]"; transaction saved as "Transaction"
    And the quantum "QuMousepad[0]" has to be booked to target load unit "LuMousepad[0]"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the load unit "LuMousepad[0]" has to be booked to target location "H02-BLD"-"201" with transaction type RELLU
    And RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"
    # Mousepad
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "LuMousepad[1]"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1800.0 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuMousepad[1]"; transaction saved as "Transaction"
    And the quantum "QuMousepad[1]" has to be booked to target load unit "LuMousepad[1]"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the load unit "LuMousepad[1]" has to be booked to target location "H02-BLD"-"201" with transaction type RELLU
    And RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"
    # Mousepad
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "LuMousepad[2]"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1800.0 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And CREQU is called
    And CREQU was successful, saved as "QuMousepad[2]"; transaction saved as "Transaction"
    And the quantum "QuMousepad[2]" has to be booked to target load unit "LuMousepad[2]"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    Then the load unit "LuMousepad[2]" has to be booked to target location "H02-BLD"-"201" with transaction type RELLU
    And RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"

    When RD_MULTI_CONFIG is called, 1 replenishment requests saved as collection "RepRequest", articles:
      |40067007|
    Then WEBSERVICE succeeds
     And replenishment request "RepRequest[0]" has: typReplenishment = "SO_ZONE", stat = "00", idArticle = "40067007", artvar = null, idBatch = null, idCre = "basis", tsCre = now, idUpd = "basis", tsUpd = now, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 0, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 0, cntLuTarget = 3, qtyActual = null, qtyReserved = null, qtyTarget = null
    When RELEASE_REP_REQUESTS is called for:
      |RepRequest[0]|
    Then WEBSERVICE succeeds
     And 8 sec is passed
     #Verify that quanta is reserved
     And quantum "QuMousepad[0]" has available quantity 0.0
     And quantum "QuMousepad[0]" has reserved quantity 1800.0
		 And quantum "QuMousepad[1]" has available quantity 0.0
     And quantum "QuMousepad[1]" has reserved quantity 1800.0
     And quantum "QuMousepad[2]" has available quantity 0.0
     And quantum "QuMousepad[2]" has reserved quantity 1800.0
     And replenishment request "RepRequest[0]" has 3 bps records, saved as collection "RepRequest[0]BpsRecord"
     And bps record "RepRequest[0]BpsRecord[0]" has one tcs task, saved as "RepRequest[0]TcsTask[0]"
     And bps record "RepRequest[0]BpsRecord[1]" has one tcs task, saved as "RepRequest[0]TcsTask[1]"
     And bps record "RepRequest[0]BpsRecord[2]" has one tcs task, saved as "RepRequest[0]TcsTask[2]"
     And COMPLETE_TASK_EP is called with transport task "RepRequest[0]TcsTask[0]"
     And COMPLETE_TASK_EP is called with transport task "RepRequest[0]TcsTask[1]"
     And COMPLETE_TASK_EP is called with transport task "RepRequest[0]TcsTask[2]"
     And reload transport task "RepRequest[0]TcsTask[0]"
     And reload transport task "RepRequest[0]TcsTask[1]"
     And reload transport task "RepRequest[0]TcsTask[2]"
     And transport task "RepRequest[0]TcsTask[0]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H02-BLD", storageLocation = "201", clProcess = "REP", typProcess = "REPL", stepProcess = "FINISH"
     And transport task "RepRequest[0]TcsTask[1]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H02-BLD", storageLocation = "201", clProcess = "REP", typProcess = "REPL", stepProcess = "FINISH"
     And transport task "RepRequest[0]TcsTask[2]" has: idTask = ignore, stat = "90", priority = ignore, typLu = "EURO", storageArea = "H02-BLD", storageLocation = "201", clProcess = "REP", typProcess = "REPL", stepProcess = "FINISH"
     And 5 sec is passed
     And reload replenishment request "RepRequest[0]"
     And replenishment request "RepRequest[0]" has: typReplenishment = "SO_ZONE", stat = "90", idArticle = "40067007", artvar = null, idBatch = null, idCre = "basis", tsCre = now, idUpd = "RES_RESERV", tsUpd = now, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = 3, cntLuReserved = 3, cntLuTarget = 3, qtyActual = null, qtyReserved = null, qtyTarget = null
     #Verify that quanta is not reserved
     And quantum "QuMousepad[0]" has available quantity 1800.0
     And quantum "QuMousepad[0]" has reserved quantity 0.0
		 And quantum "QuMousepad[1]" has available quantity 1800.0
     And quantum "QuMousepad[1]" has reserved quantity 0.0
     And quantum "QuMousepad[2]" has available quantity 1800.0
     And quantum "QuMousepad[2]" has reserved quantity 0.0
     
      # cleanup
      Then the quantum "QuMousepad[0]" has to be booked to location "SENKE-LAG"-"S-001"
      When RELQU is called
      Then RELQU was successful; transaction saved as "Transaction"
      Then the quantum "QuMousepad[1]" has to be booked to location "SENKE-LAG"-"S-001"
      When RELQU is called
      Then RELQU was successful; transaction saved as "Transaction"
      Then the quantum "QuMousepad[2]" has to be booked to location "SENKE-LAG"-"S-001"
      When RELQU is called
      Then RELQU was successful; transaction saved as "Transaction"
     