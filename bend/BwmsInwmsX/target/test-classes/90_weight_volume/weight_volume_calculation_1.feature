#Author: 
#Date: 
@defaultdatacheck @inventory
Feature: Weight Volume Calculation 1

  Scenario Outline: Verify that the weight and volume calculations are correct in RK2
  Given set global: idSite = "RL1", idClient = "RK2"
  When Weight and volume are calculated for <pcs> pieces of article <article> with artvar <artvar>
  Then weight is <exp-weight>
  And volume is <exp-volume>
      Examples: 
      |   pcs         | article    | artvar |    exp-weight  |   exp-volume   |
      |   12.0        | "WL-BG2"   | ""	    |    348000.000  |   1026000.000  |
      |   50.0	      | "WL-BG2"   | ""	    |   1485000.000  |   4455000.000  |
      |   62.0	      | "WL-BG2"   | ""	    |   1833000.000  |   5481000.000  |
      |   30.0        | "DC-270"   | "1"    |     90000.000  |    356863.320  |
      |   36.0	      | "DC-270"   | "1"    |    136000.000  |    572235.984  |
      |   42.0	      | "DC-270"   | "1"    |    154000.000  |    643608.648  |     
      |  648.0        | "WT-XP3"   | "2"    |    211864.000  |    633600.000  |
      |  649.0        | "WT-XP3"   | "2"    |    212107.000  |    634208.150  |
      |   27.0        | "WT-XP3"   | "2"    |      7661.000  |     20400.000  |      
      |    3.0	      | "WT-XP3"   | "2"    |       729.000  |      1824.450  |
      |  669.0	      | "WT-XP3"   | "2"    |    216967.000  |    646371.150  |  
      |   28.0        | "WT-XP3"   | "2"    |      7904.000  |     21008.150  |
      |    4.0	      | "WT-XP3"   | "2"    |       972.000  |      2432.600  |
      |  150.0	      | "WT-XP3"   | "2"    |     41950.000  |    111122.250  |  
      |  152.0        | "WT-XP3"   | "2"    |     42436.000  |    112338.550  |
      | 2035.0	      | "WT-XP3"   | "2"    |    661005.000  |   1968081.500  |
      

  Scenario Outline: Verify that the weight and volume calculations according to LE type are correct in RK1
  Given set global: idSite = "RL1", idClient = "RK1"
  When Weight and volume are calculated for <pcs> pieces of article <article> with artvar <artvar> on <luTyp>
  Then weight is <exp-weight>
  And volume is <exp-volume>
      Examples: 
      |   pcs         | article      | artvar |	 luTyp			|		exp-weight  |   exp-volume   |
      | 1800.0        | "40067007"   | "1"    | "EURO"			|		371800.000  |   1051200.000  |
      | 1800.0	      | "40067007"   | "1"    | "INDU"			|  	406800.000  |   1231200.000  |
      | 1600.0	      | "40067007"   | "1"    | "EURO"			|		333600.000  |    950400.000  |
      | 2000.0        | "40067007"   | "1"    | "EURO"			|		410000.000  |   1152000.000  |
      |  300.0	      | "40067005"   | "2"    | "EURO"			|		223000.000  |    390000.000  |
      |   10.0	      | "40067005"   | "2"    | "EURO"	 		|		34500.000  	|    164400.000  |
      |   10.0        | "40067005"   | "2"    | "LBOX1"	 		|		6500.000  	| 	  20400.000  |
      |    5.0        | "40067005"   | "2"    | "LBOX1"	 		|		3800.000    |     20400.000  |
      |   50.0	      | "40067005"   | "2"    | "EURO"  		|		60500.000  	|    246000.000  |
      |   50.0	      | "40067005"   | "2"    | "LBOX1" 		|		28100.000  	|     20400.000  |
      |   52.0        | "40067005"   | "2"    | "EURO" 			|		61580.000  	|    247150.000  |
      |   52.0	      | "40067005"   | "2"    | "LBOX1" 		|		29180.000  	|     20400.000  |
      |  311.0	      | "40067005"   | "2"    | "EURO"			|		230040.000  |    410975.000  |
      |  331.0	      | "40067005"   | "2"    | "EURO"			|		243040.000  |    451775.000  |
      |  911.0        | "40067005"   | "2"    | "EURO"			|		620040.000  |    902975.000  |

  Scenario Outline: Verify that the weight and volume calculations according to LE type are correct in RK2
  Given set global: idSite = "RL1", idClient = "RK2"
  When Weight and volume are calculated for <pcs> pieces of article <article> with artvar <artvar> on <luTyp>
  Then weight is <exp-weight>
  And volume is <exp-volume>
      Examples: 
      |   pcs         | article      | artvar |	 luTyp			|		exp-weight  |   exp-volume   |
      |  648.0	      | "WT-XP3"     | "2"    |	"EURO"			|		211864.000  |    633600.000  |
      |   27.0	      | "WT-XP3"     | "2"    |	"LBOX1"	 		|		7661.000  	|     20400.000  |
      |    3.0	      | "WT-XP3"     | "2"    |	"GREIF"			|		729.000  	|      1824.450  |
      |    1.0	      | "WT-XP3"     | "2"    |	"EURO"	 		|		28243.000  	|    144608.150  |
      |    9.0	      | "WT-XP3"     | "2"    |	"EURO"	 		|		30187.000  	|    149473.350  |
      |   10.0	      | "WT-XP3"     | "2"    |	"EURO"	 		|		30430.000  	|    150081.500  |
      |  679.0	      | "WT-XP3"     | "2"    | "EURO"			|		220497.000  |    656432.600  |
      |  685.0	      | "WT-XP3"     | "2"    | "EURO"			|		221955.000  |    660081.500  |
      |  733.0	      | "WT-XP3"     | "2"    |	"EURO"			|		235819.000  |    697232.600  |
      | 1975.0	      | "WT-XP3"     | "2"    | "INDU"			|		679225.000  |   2103632.600  |
