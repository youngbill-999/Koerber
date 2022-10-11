#Author: skaya@inconso.de
#Keywords Summary :
@defaultdatacheck @inventory
Feature: Weight Volume Calculation 2

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"
 
  Scenario: verify that the weight calculations of stacked load units are correct
  #EURO anlegen
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "EURO"
    	And CRELU is called
 			And CRELU was successful, saved as "1"; transaction saved as "Transaction"
    	And verify that the weight of the load unit "1" is 28000.000
   #VBOX1 mit Artikel 40067007 und Menge 200 anlegen
    	And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "VBOX1"
    	And CRELU is called
 			And CRELU was successful, saved as "2"; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 100.0 pieces of article "40067007" has to be created
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   		And the load unit "2" is the target
   		And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
   		And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 	 		And verify that the weight of the load unit "2" is 19400.000
 	 	#VBOX1 auf EURO stapeln
    	And the load unit "2" has to be stacked on the load unit "1"
    	And STALU is called
    	And STALU was successful; transaction saved as "Transaction"
    	And verify that the weight of the load unit "1" is 47400.000
    #Menge auf VBOX1 um 20 erhöhen
    	And a quantum from storage location "QUELLE-LAG"-"Q-001" with 20.0 pieces of article "40067007" has to be created
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   		And the load unit "2" is the target
   		And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
			And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And verify that the weight of the load unit "2" is 23220.000
 			And verify that the weight of the load unit "1" is 51220.000
 		#Quant von Artikel 40067024 und Menge 5 auf EURO anlegen
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.0 pieces of article "40067024" has to be created
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   		And the load unit "1" is the target
   		And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
			And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And verify that the weight of the load unit "1" is 51470.000
 		#TUETE mit Artikel 40067111 und Menge 1 anlegen
 			And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "TUETE"
    	And CRELU is called
 			And CRELU was successful, saved as "3"; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1.0 pieces of article "40067111" has to be created
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   		And create batch "KAS1234514512" for idArticle = "40067111" saved as "BatchAfterShave[0]" with tsBbd null
   		And BBD is null and batch is "BatchAfterShave[0]"
   		And the load unit "3" is the target
   		And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
			And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And verify that the weight of the load unit "3" is 235.000
 		#TUETE auf VBOX1 stapeln
 			And the load unit "3" has to be stacked on the load unit "2"
    	And STALU is called
    	And STALU was successful; transaction saved as "Transaction"
    	And verify that the weight of the load unit "2" is 23455.000
 			And verify that the weight of the load unit "1" is 51705.000
    #Menge in TUETE um 1 erhöhen
    	And a quantum from storage location "QUELLE-LAG"-"Q-001" with 1.0 pieces of article "40067111" has to be created
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   		And create batch "KAS123451451" for idArticle = "40067111" saved as "BatchAfterShave[1]" with tsBbd null
   		And BBD is null and batch is "BatchAfterShave[1]"
   		And the load unit "3" is the target
   		And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
			And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And verify that the weight of the load unit "3" is 465.000
 			And verify that the weight of the load unit "2" is 23685.000
 			And verify that the weight of the load unit "1" is 51935.000
 		#Quant von Artikel 40067114 und Menge 4 auf VBOX1 anlegen
 			And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "VBOX1"
    	And CRELU is called
 			And CRELU was successful, saved as "4"; transaction saved as "Transaction"
 			And a quantum from storage location "QUELLE-LAG"-"Q-001" with 4.0 pieces of article "40067114" has to be created
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   		And BBD is 2020/01/27 and batch is null
   		And the load unit "2" is the target
   		And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
   		And CREQU is called
 			And CREQU was successful, saved as "Qu"; transaction saved as "Transaction"
 			And verify that the weight of the load unit "2" is 24485.000
 			And verify that the weight of the load unit "1" is 52735.000
 		#Wiederholen von "TUETE anlegen" und "TUETE stapeln"
		#zweimal; es sollen abschließen 3 Tüten in der Versandbox liegen
			And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "TUETE"
    	And CRELU is called
 			And CRELU was successful, saved as "5"; transaction saved as "Transaction"
 			And the load unit "5" has to be stacked on the load unit "2"
    	And STALU is called
    	And STALU was successful; transaction saved as "Transaction"
 			And a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "TUETE"
    	And CRELU is called
 			And CRELU was successful, saved as "6"; transaction saved as "Transaction"
 			And the load unit "6" has to be stacked on the load unit "2"
    	And STALU is called
    	And STALU was successful; transaction saved as "Transaction"
 			And verify that the weight of the load unit "2" is 24495.000
 			And verify that the weight of the load unit "1" is 52745.000
 			And the load unit "2" has to be stacked to location "H01-KLAER"-"K-101"
 			And STALU is called
    	And STALU was successful; transaction saved as "Transaction"
 			And verify that the weight of the load unit "2" is 24495.000
 			And verify that the weight of the load unit "1" is 28250.000
 			
 			
 		Scenario: verify that the weight calculations of load units with different articles are correct
 		#EURO anlegen
 			Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H02-KLAER"-"K-201" has to be created
    	And the load unit type is "EURO"
    	And CRELU is called
  		And CRELU was successful, saved as "1"; transaction saved as "Transaction"
  		And verify that the weight of the load unit "1" is 28000.000		
 		#Erstes Quant mit Artikel 40067005 und Menge 5 auf EURO erzeugen	
  		And a quantum from storage location "QUELLE-LAG"-"Q-001" with 5.0 pieces of article "40067005" has to be created
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   		And the load unit "1" is the target
   		And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
   		And CREQU is called
  		And CREQU was successful, saved as "1"; transaction saved as "Transaction"
  		And verify that the weight of the load unit "1" is 30700.000
 		#Zweites Quant mit Artikel 40067007 und Menge 12 auf EURO erzeugen
  		And a quantum from storage location "QUELLE-LAG"-"Q-001" with 12.0 pieces of article "40067007" has to be created
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   		And the load unit "1" is the target
   		And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
   		And CREQU is called
  		And CREQU was successful, saved as "2"; transaction saved as "Transaction"
  		And verify that the weight of the load unit "1" is 32992.000
 		#Drittes Quant mit Artikel 40067222 und Menge 250 auf EURO erzeugen
  		And a quantum from storage location "QUELLE-LAG"-"Q-001" with 250.0 pieces of article "40067222" has to be created
   		And the artvar is "1" and stock type is "AV" and lock type is "------" and QC status is "00" and customs status is "00"
   		And the load unit "1" is the target
   		And the CREQU reasons are "Test CREQU 1"-"Test CREQU 2"
   		And CREQU is called
  		And CREQU was successful, saved as "3"; transaction saved as "Transaction"
  		And verify that the weight of the load unit "1" is 107992.000
 		#Menge des ersten Quants um 50 erhöhen
  		And the "AVAILABLE" quantity of the quantum "1" has to be changed with correction type "INCREASE" by 50.0 pieces with location "QUELLE-LAG"-"Q-001"
  		And CORST is called
  		And CORST was successful; transaction saved as "Transaction"
  		And verify that the weight of the load unit "1" is 134992.000
  	#Menge des zweiten Quants um 2 verringern
  		And the "AVAILABLE" quantity of the quantum "2" has to be changed with correction type "DECREASE" by 2.0 pieces with location "SENKE-LAG"-"S-001"
  		And CORST is called
  		And CORST was successful; transaction saved as "Transaction"
  		And verify that the weight of the load unit "1" is 134610.000
  	#Drittes Quant ausbuchen
  		And the quantum "3" has to be booked to location "H01-KLAER"-"K-101"
  		And the reasons for relocate quantum are "Test RELQU 1" and "Test RELQU 2"
  		And RELQU is called
  		And RELQU was successful; transaction saved as "Transaction"
  		And verify that the weight of the load unit "1" is 59610.000
  		
 			