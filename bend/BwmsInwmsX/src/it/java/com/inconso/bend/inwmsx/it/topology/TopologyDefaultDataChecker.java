package com.inconso.bend.inwmsx.it.topology;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.topology.pers.gen.TopVStorageLocationPk;
import com.inconso.bend.topology.pers.model.TopVStorageLocation;
import com.inconso.bend.topology.pers.rep.TopVStorageLocationRep;
import io.cucumber.java.en.Then;

public class TopologyDefaultDataChecker {

  @Autowired
  private GeneralHelper          generalHelper;

  @Autowired
  private TopVStorageLocationRep topVStorageLocationRep;

  /**
   * Verifies that every storage location has status occupied "00"
   */
  @Then("^All storage locations are not occupied$")
  @Transactional(readOnly = true)
  public void allStorageLocationsAreNotOccupied() {
    List<TopVStorageLocation> storageLocations = topVStorageLocationRep.findAll();
    for (TopVStorageLocation storageLocation : storageLocations) {
      assertEquals("00", storageLocation.getStatOccupied());
    }
  }

  /**
   * Verifies that there is the given amount of storage location
   * 
   * @param count
   *          expected amount of storage locations
   */
  @Then("^There are (\\d+) storage locations$")
  @Transactional(readOnly = true)
  public void thereAreStorageLocations(int count) {
    List<TopVStorageLocation> storageLocations = topVStorageLocationRep.findAll();
    assertEquals(count, storageLocations.size());
  }

  /**
   * Verifies that the given location is empty
   * 
   * @param area
   *          pk of location
   * @param location
   *          pk of location
   * 
   */
  @Then("location {string}-{string} is empty")
  @Transactional(readOnly = true)
  public void locationIsEmpty(String area, String location) {
    TopVStorageLocation storageLocation = topVStorageLocationRep.findOne(new TopVStorageLocationPk(generalHelper.getIdSite(), area, location));
    assertAll(() -> assertEquals("00", storageLocation.getStatOccupied()), () -> assertEquals((Double) 0.0, storageLocation.getPctOccupied()));
  }

  @Then("location {string}-{string} is occupied")
  @Transactional(readOnly = true)
  public void locationIsOccupied(String area, String location) {
    TopVStorageLocation storageLocation = topVStorageLocationRep.findOne(new TopVStorageLocationPk(generalHelper.getIdSite(), area, location));
    assertEquals("90", storageLocation.getStatOccupied());
  }

  @Then("location {string}-{string} has occupied percentage {double}")
  @Transactional(readOnly = true)
  public void locationHasOccupiedPct(String area, String location, Double pct) {
    TopVStorageLocation storageLocation = topVStorageLocationRep.findOne(new TopVStorageLocationPk(generalHelper.getIdSite(), area, location));
    assertEquals(pct, storageLocation.getPctOccupied());
  }
}
