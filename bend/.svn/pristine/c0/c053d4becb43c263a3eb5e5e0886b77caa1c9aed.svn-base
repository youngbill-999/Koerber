package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import io.cucumber.java.en.Then;

public class InventoryDefaultDataChecker {

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private ImLoadUnitRep        loadUnitRep;

  /**
   * Verifies that the given location with load unit is empty
   * 
   */
  @Then("location H01-KLAER K-101 with the load unit {string} is empty")
  @Transactional(readOnly = true)
  public void locationWithLuIsEmpty(String key) {
    ImLoadUnit loadUnit = loadUnitRep
        .findOne(new ImLoadUnitPk(generalHelper.getIdSite(), inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu()));
    assertAll(() -> assertEquals("00", loadUnit.getStatOccupied()));
  }
}
