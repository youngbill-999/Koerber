@defaultdatabased 
Feature: TECH.001-001 Technical test on selection on views.
  In several processes we came across unexpected behaviour when selecting data from views for which the underlying data had been changed in the base tables in the same transaction. 
  This feature represents the different known scenarios using data from the tables ART_ART_PACKING_UNIT in relation to the View ART_V_PU_LU_TYPE.

  Background: 
    Given set global: idSite = "RL1", idClient = "RK1"

  Scenario: A selection on data on a view is executed. The base data is changed in the same transaction and the data is requeried (via repository findOne).
    The new result displays old, unchanged base data.

    Given View selection without flush shows old value

  Scenario: A selection on data on a view is executed. The base data is changed in the same transaction, the repository is flushed and the data is requeried (via repository findOne).
    The new result displays old, unchanged base data.

    Given View selection with flush shows old value

  Scenario: A selection on data on a view is executed. The base data is changed in the same transaction, the repository is flushed and the data is requeried (via repository readFromDatabaseEnforced).
    The new result displays the changed base data.

    Given View selection with flush and readDataBaseEnforced shows new value
    
  Scenario: Base data of a view is changed in the same transaction, the repository is flushed and the data is queried (via repository findOne).
    The new result displays the changed base data.

    Given View selection with flush shows new value for first view query
    
    
  Scenario: Base data of a view is changed in the same transaction, the repository is not flushed and the data is queried (via repository findOne).
    The new result displays the old base data.

    Given View selection without flush shows old value for first view query