@defaultdatabased 

Feature: TECH.002-001 Performance Test on IMI800 bookings


Background: 
    Given set global: idSite = "RL1", idClient = "RK1"
    

Scenario: TECH.002-001-0001: The first 1000 new datasets of IMI800 are booked. Time is logged

Given Start timer
Given 1000 new datasets of IMI800 are booked
Then Stop timer
Then timed value is smaller than 90 "sec"