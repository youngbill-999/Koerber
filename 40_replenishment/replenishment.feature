#Author: Bei.Yu@koerber-supplychain.com
#Keywords Summary :
#@defaultdatabased
@replenishment
@run
Feature: Replenishment - Preventitive Rep based on configuration in dialog REP020

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

##############################################################-1-######################################################################   
  Scenario: RD_MULTI_CONFIG
    This webservice executes store out zone based replenishment under all active configuration in dialog REP020
    Step Definition: 
         make sure the third configuration in REP020(Körber Mousepad for store out zone ENT_H1_02) is active
         as required to create 3 quantum of Körber Mousepad in store out zone ENT_H1_02
         run the webservice and a new replenishment for this configuration will be generated.
  
    Given active the configuration of preventive replenishmen of article "40067007"
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
      And deactive the configuration of preventive replenishmen of article "40067007" 
      
####################################################################-2-################################################################ 
   Scenario: RD_SINGLE_CONFIG
    This webservice executes store out zone based replenishment for one specific configuration in dialog REP020
    ps. In comparison with RD_MULTI_CONFIG, this webservice is more precise for a single store out zone replenishment
    Step Definition: 
         make sure the third configuration in REP020(Körber Mousepad for store out zone ENT_H1_02) is active
         as required to create 3 quantum of Körber Mousepad in store out zone ENT_H1_02
         run the webservice and a new replenishment for this configuration will be generated.
   
    Given active the configuration of preventive replenishmen of article "40067007"
    Given RD_SINGLE_CONFIG is called, idArticle = "40067007", clArticles = "*", grpArticles = "*", idStoreOutZone = "ENT_H1_02"    
       And WEBSERVICE succeeds
       And 5 sec is passed
       And a replenishment request is generated, which has stat = "00", typReplenishment = "SO_ZONE", idArticle = "40067007", save as "Rep"
       And replenishment request "Rep" has: typReplenishment = "SO_ZONE", stat = "00", idArticle = "40067007", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 0, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 0, cntLuTarget = 3, qtyActual = null, qtyReserved = null, qtyTarget = null
    
    
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
    
    
    When RELEASE_REP_REQUESTS is called for:
      |Rep|
     And WEBSERVICE succeeds
     And 8 sec is passed
     And reload replenishment request "Rep"
     And replenishment request "Rep" has: typReplenishment = "SO_ZONE", stat = "20", idArticle = "40067007", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 3, cntLuTarget = 3, qtyActual = null, qtyReserved = null, qtyTarget = null
     
       
   
    #Verify that quanta is reserved
     And quantum "QuMousepad[0]" has available quantity 0.0
     And quantum "QuMousepad[0]" has reserved quantity 1800.0
		 And quantum "QuMousepad[1]" has available quantity 0.0
     And quantum "QuMousepad[1]" has reserved quantity 1800.0
     And quantum "QuMousepad[2]" has available quantity 0.0
     And quantum "QuMousepad[2]" has reserved quantity 1800.0
     And replenishment request "Rep" has 3 bps records, saved as collection "RepBpsRecord"
     And bps record "RepBpsRecord[0]" has one tcs task, saved as "RepRequest[0]TcsTask[0]"
     And bps record "RepBpsRecord[1]" has one tcs task, saved as "RepRequest[0]TcsTask[1]"
     And bps record "RepBpsRecord[2]" has one tcs task, saved as "RepRequest[0]TcsTask[2]" 
    
    
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
     And reload replenishment request "Rep" 
     And replenishment request "Rep" has: typReplenishment = "SO_ZONE", stat = "90", idArticle = "40067007", artvar = null, idBatch = null, idCre = "basis", tsCre = now, idUpd = "RES_RESERV", tsUpd = now, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 1, cntResAttemptMax = 10, cntLuActual = 3, cntLuReserved = 3, cntLuTarget = 3, qtyActual = null, qtyReserved = null, qtyTarget = null
     
     
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
      And deactive the configuration of preventive replenishmen of article "40067007" 
       
################################################################################################################################

Scenario: Change demand with webservice - DETERMINE_DEMAND_REP_REQUESTS for Preventive replenishment for picking zone
  This case tests the functionality of webservice DETERMINE_DEMAND_REP_REQUESTS which identify any replenishment requirement changes and update the value 
  of new requirement into exsisting replenishment request
  Step Definition:
  1.generate a new replenishment by trigger a picking zone based configuration
  2.change the replenishment request
  3.call webservice DETERMINE_DEMAND_REP_REQUESTS
  4.verify the requirement changes
  
  Given active the configuration of preventive replenishmen of article "40067007" 
  Given change the configuration of preventive replenishmen of article "40067007" with: cntLuMax = 3
  
  Given RD_SINGLE_CONFIG is called, idArticle = "40067007", clArticles = "*", grpArticles = "*", idStoreOutZone = "ENT_H1_02"    
       And WEBSERVICE succeeds
       And 5 sec is passed
       And a replenishment request is generated, which has stat = "00", typReplenishment = "SO_ZONE", idArticle = "40067007", save as "Rep"
       And replenishment request "Rep" has: typReplenishment = "SO_ZONE", stat = "00", idArticle = "40067007", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 0, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 0, cntLuTarget = 3, qtyActual = null, qtyReserved = null, qtyTarget = null
  
  Then change the configuration of preventive replenishmen of article "40067007" with: cntLuMax = 2   
       And DETERMINE_DEMAND_REP_REQUESTS is called for:
           |Rep|
       And WEBSERVICE succeeds
       And reload replenishment request "Rep"
       And replenishment request "Rep" has: typReplenishment = "SO_ZONE", stat = "00", idArticle = "40067007", artvar = null, idBatch = null, idStoreOutZone = "ENT_H1_02", cntResAttemptActual = 0, cntResAttemptMax = 10, cntLuActual = 0, cntLuReserved = 0, cntLuTarget = 2, qtyActual = null, qtyReserved = null, qtyTarget = null
  Then CANCEL_REP_REQUESTS is callede for:
       | Rep |
       And WEBSERVICE succeeds
       And 3 sec is passed
       And reload replenishment request "Rep" 
       And replenishment request "Rep" has: stat = "80"
  #reset the default setting    
  Then change the configuration of preventive replenishmen of article "40067007" with: cntLuMax = 3   
  Then deactive the configuration of preventive replenishmen of article "40067007"    
              
       
       
       
       
     