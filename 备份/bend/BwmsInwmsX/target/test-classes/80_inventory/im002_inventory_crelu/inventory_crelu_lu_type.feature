#Author: anruppel@inconso.de
#Keywords Summary : CRELU, Load unit ID <-> load unit type
@inventory @crelu @defaultdatabased
Feature: IM.002-003: inventory/transaction/crelu - Inventory CRELU with load ID to load unit type relation

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

Scenario: IM.002-003-0001: CRELU fails, if load unit ID and load unit type do not match.
	IM-0004: Invalid combination of id load unit and type.
 	Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is "INDU"
    And the load unit ID is "023012345670"
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0004"

  Scenario Outline: IM.002-003-0002 - 0003: CRELU with given load unit ID <id-lu> creates load unit of type <lu-type>.
  If the prefix of the load unit ID has a unique association in the table 'im_load_unit_id_range' that defines a range of possible ID, 
  the created load unit must be of the corresponding type.
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit ID is <id-lu>
 		When CRELU is called
 	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
    And load unit "Lu" has type <lu-type>
    And transaction "Transaction" has: typLu1Tgt = <lu-type>
  #Clean-Up
  Then delete load unit "Lu"
    Examples: 
      | id-lu           | lu-type |
      | "012012345678"  | "INDU"  |
      | "029012345678"  | "VBOX2" |  
      
Scenario Outline: IM.002-003-0004 - 0011: CRELU with given load type <lu-type> creates a load unit with prefix <lu-prefix>.
 	If the given load unit type has a unique association in the table 'im_load_unit_id_range' that defines a sequence, 
  	the created load unit must have an ID that starts with the corresponding prefix.
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is <lu-type>
 		When CRELU is called
 	Then CRELU was successful, saved as "Lu"; transaction saved as "Transaction"
    And load unit "Lu" ID has prefix <lu-prefix>
    And transaction "Transaction" has: typLu1Tgt = <lu-type>
  #Clean-Up
  Then delete load unit "Lu"
        Examples: 
      | lu-type | lu-prefix |
      | "EURO"  | "021"		|
      | "GBOX"  | "022" 	|
      | "LBOX1" | "023" 	|
      | "LBOX2" | "024"		|
      | "LBOX3" | "025"		|
      | "ROLL"  | "026"		|
      | "VBOX1" | "028"		|
      | "VBOX3" | "030"		|
     
 
Scenario Outline: IM.002-003-0012 - 0019: CRELU with given load unit ID <id-lu> fails.
 	If the given load unit prefix has a unique association in the table 'im_load_unit_id_range' that defines a sequence, 
  	the load unit cannot be created, because the numbers may conflict with numbers later taken from the sequence.
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit ID is <id-lu>
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0039"
    Examples: 
      | id-lu           |
      | "021012345678"  |
      | "022012345678"  |
      | "023012345678"  |
      | "024012345678"  |
      | "025012345678"  |
      | "026012345678"  |
      | "027012345678"  |
      | "028012345678"  |
      
  Scenario Outline: IM.002-003-0020 - 0021: CRELU with given load unit ID <id-lu> and load unit type <lu-type> fails.
  If the load unit ID has a unique association in the table 'im_load_unit_id_range' that defines a range of possible ID, 
  the load unit must be within this range, regardless if the prefix is ok.
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is <lu-type>
    And the load unit ID is <id-lu>
 		When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0004"
    Examples: 
      | id-lu           | lu-type |
      | "012999999998"  | "INDU"  |
      | "029999999998"  | "VBOX2" |  

  Scenario Outline: IM.002-003-0022 - 0023: CRELU with given load unit type <lu-type> fails.
  If the load unit type has a unique association in the table 'im_load_unit_id_range' that defines a range of possible IDs, 
  a load unit ID has to be entered.
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit type is <lu-type>
    	When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0002"
    Examples: 
      | lu-type |
      | "INDU"  |
      | "VBOX2" |  

  Scenario Outline: IM.002-003-0024 - 0026: CRELU with given load unit ID <id-lu> fails.
  If the load unit ID has a unique association in the table 'im_load_unit_id_range' that defines a range of possible IDs, 
  and no load unit type is entered, any number outside the corresponding range has to be rejected.
    Given a load unit from storage location "QUELLE-LAG"-"Q-001" to storage location "H01-KLAER"-"K-101" has to be created
    And the load unit ID is <id-lu>
    	When CRELU is called
 	Then WEBSERVICE fails: error = "IM-0001"
    Examples: 
      | id-lu          |
      | "029999999999" |
      | "012899999999" |  
      | "4711"         |  