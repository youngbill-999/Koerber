#Author: skaya@inconso.de
#Keywords Summary :
@inventory @stalu @defaultdatabased
Feature: IM.006-003: inventory/transaction/stalu - Inventory STALU

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"


  Scenario: IM.006-003-0001: Different load units with quanta will be stacked/stacked off
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "EURO"
    When CRELU is called
    Then CRELU was successful, saved as "1"; transaction saved as "Transaction"
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "2"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 40.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "1"; transaction saved as "Transaction"
    And the quantum "1" has to be booked to target load unit "2"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "2" has to be stacked on the load unit "1"
    And STALU is called
    And STALU was successful; transaction saved as "Transaction"
    And transaction "Transaction" has: typTransaction = "STALU"
    And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067024"
    And transaction "Transaction" has: typLu1Src = "LBOX3"
    And transaction "Transaction" has: typLu1Tgt = "EURO"
    And transaction "Transaction" has source load unit
    And transaction "Transaction" has target load unit
    And transaction "Transaction" has: wtGrossSrc = 4400.000
    And all transactions within "Transaction" transaction group have: wtGrossTgt = 32400.000
    And transaction "Transaction" has: wtTareTgt = 2400.000
    And all transactions within "Transaction" transaction group have: wtTareTgt = 28000.000
    And all transactions within "Transaction" transaction group have source quantum
    And all transactions within "Transaction" transaction group have target quantum
    And reload quantum "1"
    And verify load unit exits at level 1 in quantum "1"
    And verify load unit exits at level 2 in quantum "1"
    And transaction "Transaction" has: stat = "90"
    And reload load unit "1"
    And target load unit "1" is 8.33 percent occupied
    And Verify that a load unit stack record for the load unit "2" exits
    And Verify that the load unit "2" IdLu2 is stacked on the load unit "1" IdLu1
    
    # A second LBOX3 will be booked via STALU on EURO
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "3"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 75.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "2"; transaction saved as "Transaction"
    And the quantum "2" has to be booked to target load unit "3"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "3" has to be stacked on the load unit "1"
    And STALU is called
    And STALU was successful; transaction saved as "Transaction"
    And transaction "Transaction" has: typTransaction = "STALU"
    And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067024"
    And transaction "Transaction" has: typLu1Src = "LBOX3"
    And transaction "Transaction" has: typLu1Tgt = "EURO"
    And transaction "Transaction" has source load unit
    And transaction "Transaction" has target load unit
    And transaction "Transaction" has: wtGrossSrc = 6150.000
    And all transactions within "Transaction" transaction group have: wtGrossTgt = 38550.000
    And all transactions within "Transaction" transaction group have source quantum
    And all transactions within "Transaction" transaction group have target quantum
    And reload quantum "2"
    And verify load unit exits at level 1 in quantum "2"
    And verify load unit exits at level 2 in quantum "2"
    And transaction "Transaction" has: stat = "90"
    And reload load unit "1"
    And target load unit "1" is 16.67 percent occupied
    And Verify that a load unit stack record for the load unit "3" exits
    And Verify that the load unit "3" IdLu2 is stacked on the load unit "1" IdLu1
    
    # A further load unit VBOX1 will be booked via STALU on EURO
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "VBOX1"
    When CRELU is called
    Then CRELU was successful, saved as "4"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.000 pieces of article "40067222" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "3"; transaction saved as "Transaction"
    And the quantum "3" has to be booked to target load unit "4"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "4" has to be stacked on the load unit "1"
    And STALU is called
    And STALU was successful; transaction saved as "Transaction"
    And transaction "Transaction" has: typTransaction = "STALU"
    And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067222"
    And transaction "Transaction" has: typLu1Src = "VBOX1"
    And transaction "Transaction" has: typLu1Tgt = "EURO"
    And transaction "Transaction" has source load unit
    And transaction "Transaction" has target load unit
    And transaction "Transaction" has: wtGrossSrc = 1800.000
    And all transactions within "Transaction" transaction group have: wtGrossTgt = 40350.000
    And all transactions within "Transaction" transaction group have source quantum
    And all transactions within "Transaction" transaction group have target quantum
    And reload quantum "3"
    And verify load unit exits at level 1 in quantum "3"
    And verify load unit exits at level 2 in quantum "3"
    And transaction "Transaction" has: stat = "90"
    And reload load unit "1"
    And target load unit "1" is 29.17 percent occupied
    And Verify that a load unit stack record for the load unit "4" exits
    And Verify that the load unit "4" IdLu2 is stacked on the load unit "1" IdLu1
    
    # EURO will be booked via STALU to another location
    And the load unit "1" has to be booked to target location "H01-HRL"-"103-1-001-01" with transaction type RELLU
    And RELLU is called
    And RELLU was successful; transaction saved as "Transaction"
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "LBOX3"
    When CRELU is called
    Then CRELU was successful, saved as "5"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 75.000 pieces of article "40067024" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "4"; transaction saved as "Transaction"
    And the quantum "4" has to be booked to target load unit "5"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "5" has to be stacked on the load unit "1"
    And STALU is called
    And STALU was successful; transaction saved as "Transaction"
    And transaction "Transaction" has: typTransaction = "STALU"
    And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067024"
    And transaction "Transaction" has: typLu1Src = "LBOX3"
    And transaction "Transaction" has: typLu1Tgt = "EURO"
    And transaction "Transaction" has source load unit
    And transaction "Transaction" has target load unit
    And transaction "Transaction" has: wtGrossSrc = 6150.000
    And all transactions within "Transaction" transaction group have: wtGrossTgt = 46500.000
    And all transactions within "Transaction" transaction group have source quantum
    And all transactions within "Transaction" transaction group have target quantum
    And reload quantum "4"
    And verify load unit exits at level 1 in quantum "4"
    And verify load unit exits at level 2 in quantum "4"
    And transaction "Transaction" has: stat = "90"
    And reload load unit "1"
    And target load unit "1" is 37.50 percent occupied
    And Verify that a load unit stack record for the load unit "5" exits
    And Verify that the load unit "5" IdLu2 is stacked on the load unit "1" IdLu1
    And verify that the remaining weight of location "H01-HRL"-"103-1-001-01" is 953500.000
    
    # A further lu of type TUETE will be booked via STALU on the first LBOX3
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "6"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.000 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 4"-"Test CREQU 5"
    And CREQU is called
    And CREQU was successful, saved as "5"; transaction saved as "Transaction"
    And the quantum "5" has to be booked to target load unit "6"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "6" has to be stacked on the load unit "2"
    And STALU is called
    And STALU was successful; transaction saved as "Transaction"
    And transaction "Transaction" has: typTransaction = "STALU"
    And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067007"
    And transaction "Transaction" has: typLu1Src = "TUETE"
    And transaction "Transaction" has: typLu1Tgt = "EURO"
    And transaction "Transaction" has source load unit
    And transaction "Transaction" has target load unit
    And transaction "Transaction" has: wtGrossSrc = 387.000
    And all transactions within "Transaction" transaction group have: wtGrossTgt = 46887.000
    And all transactions within "Transaction" transaction group have source quantum
    And all transactions within "Transaction" transaction group have target quantum
    And reload quantum "5"
    And verify load unit exits at level 1 in quantum "5"
    And verify load unit exits at level 2 in quantum "5"
    And verify load unit exits at level 3 in quantum "5"
    And transaction "Transaction" has: stat = "90"
    And reload load unit "2"
    And target load unit "2" is 1.00 percent occupied
    And reload load unit "1"
    And target load unit "1" is 45.83 percent occupied
    And Verify that a load unit stack record for the load unit "6" exits
    And Verify that the load unit "6" IdLu3 is stacked on the load unit "2" IdLu2
    And Verify that the load unit "2" IdLu2 is stacked on the load unit "1" IdLu1
    And verify that the remaining weight of location "H01-HRL"-"103-1-001-01" is 953113.000

    # A second lu typ of TUETE will be booked via STALU on the first LBOX3
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "7"; transaction saved as "Transaction"
    And a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.000 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "6"; transaction saved as "Transaction"
    And the quantum "6" has to be booked to target load unit "7"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "7" has to be stacked on the load unit "2"
    And STALU is called
    And STALU was successful; transaction saved as "Transaction"
    And transaction "Transaction" has: typTransaction = "STALU"
    And all transactions within "Transaction" transaction group have: idClient = "RK1", idArticle = "40067007"
    And transaction "Transaction" has: typLu1Src = "TUETE"
    And transaction "Transaction" has: typLu1Tgt = "EURO"
    And transaction "Transaction" has source load unit
    And transaction "Transaction" has target load unit
    And transaction "Transaction" has: wtGrossSrc = 387.000
    And all transactions within "Transaction" transaction group have: wtGrossTgt = 47274.000
    And all transactions within "Transaction" transaction group have source quantum
    And all transactions within "Transaction" transaction group have target quantum
    And reload quantum "6"
    And verify load unit exits at level 1 in quantum "6"
    And verify load unit exits at level 2 in quantum "6"
    And verify load unit exits at level 3 in quantum "6"
    And transaction "Transaction" has: stat = "90"
    And reload load unit "2"
    And target load unit "2" is 2.00 percent occupied
    And reload load unit "1"
    And target load unit "1" is 54.17 percent occupied
    And Verify that a load unit stack record for the load unit "7" exits
    And Verify that the load unit "7" IdLu3 is stacked on the load unit "2" IdLu2
    And Verify that the load unit "2" IdLu2 is stacked on the load unit "1" IdLu1
    And verify that the remaining weight of location "H01-HRL"-"103-1-001-01" is 952726.000
    
    # The second load unit LBOX3 will be stacked off to a certain location
    And the load unit "2" has to be stacked off to the target location "H01-WE"-"W-101"
    And STALU is called
    And STALU was successful; transaction saved as "Transaction"
    And transaction "Transaction" has: typTransaction = "STALU"
    And all transactions within "Transaction" transaction group have: storageAreaSrc = "H01-HRL", storageLocationSrc = "103-1-001-01"
    And all transactions within "Transaction" transaction group have: storageAreaTgt = "H01-WE", storageLocationTgt = "W-101"
    And all transactions within "Transaction" transaction group do not have a load unit at level 3
    And reload load unit "1"
    And verify that the weight of the load unit "1" is 42100.000
    And the status of the load unit "1" is "90"
    And target load unit "1" is 29.17 percent occupied
    And reload load unit "2"
		And verify that the weight of the load unit "2" is 5174.000
		And the status of the load unit "2" is "90"
		And target load unit "2" is 2.00 percent occupied
    And reload load unit "6"
		And verify that the weight of the load unit "6" is 387.000
		And the status of the load unit "6" is "90"
    And reload load unit "7"
		And verify that the weight of the load unit "7" is 387.000
		And the status of the load unit "7" is "90"
		And verify that the load unit stack of the load unit "1" has no level 3
		And verify that the load unit stack of the load unit "2" has no level 3
		And verify that the remaining weight of location "H01-HRL"-"103-1-001-01" is 957900.000
		
		#The second load unit LBOX3 will be stacked on to the first load unit EURO
		And the load unit "2" has to be stacked on the load unit "1"
    And STALU is called
    And STALU was successful; transaction saved as "Transaction"
    And transaction "Transaction" has: typTransaction = "STALU"
    And all transactions within "Transaction" transaction group have: storageAreaSrc = "H01-WE", storageLocationSrc = "W-101"
    And all transactions within "Transaction" transaction group have: storageAreaTgt = "H01-HRL", storageLocationTgt = "103-1-001-01"
		And all transactions within "Transaction" transaction group for quantum are created
    And reload load unit "1"
    And verify that the weight of the load unit "1" is 47274.000
    And the status of the load unit "1" is "90"
    And target load unit "1" is 54.17 percent occupied
    And reload load unit "2"
		And verify that the weight of the load unit "2" is 5174.000
		And the status of the load unit "2" is "90"
		And target load unit "2" is 2.00 percent occupied
    And reload load unit "6"
		And verify that the weight of the load unit "6" is 387.000
		And the status of the load unit "6" is "90"
    And reload load unit "7"
		And verify that the weight of the load unit "7" is 387.000
    And verify that the remaining weight of location "H01-HRL"-"103-1-001-01" is 952726.000
    
    # A third load unit "TUETE" will be stacked on to the first load unit "EURO"
    And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-WE"-"W-101" has to be created
    And the load unit type is "TUETE"
    When CRELU is called
    Then CRELU was successful, saved as "8"; transaction saved as "Transaction"
		And a quantum from storage location "QUELLE-LAG"-"Q-001" with 2.000 pieces of article "40067007" has to be created
    And the target location is "H01-KLAER"-"K-101"
    And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
    And the CREQU reasons are "Test CREQU 2"-"Test CREQU 3"
    And CREQU is called
    And CREQU was successful, saved as "7"; transaction saved as "Transaction"
    And the quantum "7" has to be booked to target load unit "8"
    And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
    When RELQU is called
    Then RELQU was successful; transaction saved as "Transaction"
    And the load unit "8" has to be stacked on the load unit "1"
    And STALU is called
    And STALU was successful; transaction saved as "Transaction"
    And transaction "Transaction" has: typTransaction = "STALU"
    And all transactions within "Transaction" transaction group have: storageAreaSrc = "H01-WE", storageLocationSrc = "W-101"
    And all transactions within "Transaction" transaction group have: storageAreaTgt = "H01-HRL", storageLocationTgt = "103-1-001-01"
    And all transactions within "Transaction" transaction group for quantum are created
    And reload load unit "1"
    And verify that the weight of the load unit "1" is 47661.000
    And the status of the load unit "1" is "90"
    And target load unit "1" is 54.22 percent occupied
    And reload load unit "8"
    And verify that the weight of the load unit "8" is 387.000
    And reload quantum "7"
    And verify load unit exits at level 1 in quantum "7"
    And verify load unit exits at level 2 in quantum "7"
    And verify that the remaining weight of location "H01-HRL"-"103-1-001-01" is 952339.000
    
    # The first load unit EURO will removed as well as all the other load unit
    And the load unit "1" has to be booked to target location "SENKE-LAG"-"S-001" with transaction type RELLU
    When RELLU is called
    Then RELLU was successful; transaction saved as "Transaction"
		And all transactions within "Transaction" transaction group of load unit "1" are created
		And location "H01-HRL"-"103-1-001-01" is empty
		And all quanta within the "Transaction" transaction group are booked out
		And all load unit stacks within "Transaction" transaction group are booked out
		And all load units within "Transaction" transaction group are booked out
    