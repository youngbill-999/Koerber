#Author: anruppel@inconso.de
#Date: 17.01.2019
@defaultdatacheck @topology
Feature: Topology Default Data
This feature verifies if the defaultdata installed by the component WMS_TOPOLGY is inserted correctly in the database.
Including: - Correct amount of storage locations
					 - All storage locations are not occupied
					 
  Scenario: 31126 Storage Locations created
    Then There are 31126 storage locations

  Scenario: All storage locations are not occupied
    Then All storage locations are not occupied
