@transport
Feature: TCS.001-001: bwmstransportapi/activateRouting - Transport Management Routing Activation
The transport management stores routings based on configured nodes and transitions. The system ensures that 
at all times there is only one active routing. If there are transport orders based on a routing, that should be deactivated, 
its status is changed to 70 - expiring. A service job checks cyclomatically whether all tasks are finished and therefore the routing
may be deactivated.

  Background:
    Given set global: idSite = "RL1", idClient = "RK1"

Scenario: TCS.001-001-0001: A new routing version is created and activated. The initial routing version is deactivated directly.
	Given the currently active routing for system "TCS" is stored as "V0"
	Given NEW_ROUTING_EP is called for system "TCS" with text "TCS.001-0001"
	And the new routing version is stored as "V1"
	When routing version "V1" is activated
	And 1 sec is passed
	Then routing version "V0" in inactive and has a deactivation date
	And routing version "V1" is active and has an activation date
	#No clean-up required
	
Scenario: TCS.001-001-0002: A new routing Version is created and activated, the old one has unfinished transport orders and is expiring. 
  Given the currently active routing for system "TCS" is stored as "V0"
	And routing version "V0" has unfinished orders
	Given NEW_ROUTING_EP is called for system "TCS" with text "TCS.001-0002"
  And the new routing version is stored as "V1"
	When routing version "V1" is activated
  And 1 sec is passed
  Then routing version "V0" is expiring and has a deactivation date
	And routing version "V1" is active and has an activation date
	#No clean-up required