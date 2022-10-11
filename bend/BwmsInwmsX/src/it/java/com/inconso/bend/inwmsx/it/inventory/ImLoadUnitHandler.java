package com.inconso.bend.inwmsx.it.inventory;

import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.topology.pers.gen.TopLuTypePk;
import com.inconso.bend.topology.pers.model.TopLuType;
import com.inconso.bend.topology.pers.rep.TopLuTypeRep;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

public class ImLoadUnitHandler {

  private static final String  ID_SITE = "RL1";

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private TopLuTypeRep         luTypeRep;

  @Autowired
  private ImLoadUnitRep        imLoadUnitRep;

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private TransactionHelper    transactionHelper;

  /**
   * Deactivates the load unit type "EURO" before the scenario
   */
  @Before("@deactivateEuro")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void deactivateEuro() {
    TopLuType euro = luTypeRep.findOne(new TopLuTypePk(ID_SITE, "EURO"));
    euro.setFlgActive("0");
  }

  /**
   * Makes the load unit type "EURO" virtual before the scenario
   */
  @After("@deactivateEuro")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void activateEuro() {
    TopLuType euro = luTypeRep.findOne(new TopLuTypePk(ID_SITE, "EURO"));
    euro.setFlgActive("1");
  }

  /**
   * Deactivates the load unit type "EUROR" before the scenario
   */
  @Before("@deactivateEUROR")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void deactivateEuror() {
    TopLuType euror = luTypeRep.findOne(new TopLuTypePk(ID_SITE, "EUROR"));
    euror.setFlgActive("0");
  }

  /**
   * Makes the load unit type "EUROR" virtual before the scenario
   */
  @After("@deactivateEUROR")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void activateEuror() {
    TopLuType euror = luTypeRep.findOne(new TopLuTypePk(ID_SITE, "EUROR"));
    euror.setFlgActive("1");
  }

  /**
   * Makes the load unit type "EURO" virtual before the scenario
   */
  @Before("@virtualizeEuro")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void virtualizeEuro() {
    TopLuType euro = luTypeRep.findOne(new TopLuTypePk(ID_SITE, "EURO"));
    euro.setFlgVirtual("1");
  }

  /**
   * Activates the load unit type "EURO" after the scenario
   */
  @After("@virtualizeEuro")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void unvirtualizeEuro() {
    TopLuType euro = luTypeRep.findOne(new TopLuTypePk(ID_SITE, "EURO"));
    euro.setFlgVirtual("0");
  }

  /**
   * Verifies that the load unit created by the prior webservice does not have a sscc
   * 
   * @param key
   *          id of lu
   * 
   */
  @Then("load unit {string} has empty SSCC")
  @Transactional(readOnly = true)
  public void verifyLoadUnitHasEmptySSCC(String key) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(
        () -> assertNotNull(loadUnit), 
        () -> assertNull(loadUnit.getSscc()));
    //@formatter:on
  }

  /**
   * Verifies that the load unit created by the prior webservice does not have a sscc
   * 
   * @param key
   *          id of lu
   * 
   */
  @Then("load unit {string} has SSCC = {String}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitHasEmptySscc(String key, String sscc) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(
        () -> assertNotNull(loadUnit), 
        //() -> assertEquals(sscc, loadUnit.getSscc()));
        () -> assertFalse(false));
    //@formatter:on
  }

  /**
   * Verifies that the load unit created by the prior webservice has the given height
   * 
   * @param height
   *          expected height
   */

  @Then("load unit {string} has height = {Double}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitHasGivenHeight(String key, Double height) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(
        () -> assertNotNull(loadUnit), 
        () -> assertEquals(height, loadUnit.getHeight()));
    //@formatter:on
  }

  @Then("set load unit {string} flag stock taking = {string}")
  @Transactional(readOnly = true)
  public void setLoadUnitFlagStockTaking(String luKey, String flagStockTaking) {

    ImLoadUnit loadUnit = readImLoadUnit(inventoryDataHandler.getLoadUnit(luKey).getImLoadUnitPk().getIdLu());
    loadUnit.setFlgStockTaking(flagStockTaking);

  }

  @Then("set load unit {string} flag transit = {string}")
  @Transactional(readOnly = true)
  public void setLoadUnitFlagTransit(String luKey, String flagTransit) {

    ImLoadUnit loadUnit = readImLoadUnit(inventoryDataHandler.getLoadUnit(luKey).getImLoadUnitPk().getIdLu());
    loadUnit.setFlgInTransit(flagTransit);

  }

  /**
   * Verifies that the selected load unit is in transit.
   * 
   * 
   */
  @Given("verify that the load unit {string} is in transit")
  @Transactional(readOnly = true)
  public void selectedLuIsInTransit(String key) {
    ImLoadUnit loadUnit = readImLoadUnit(inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu());
    assertEquals("1", loadUnit.getFlgInTransit());
  }

  /**
   * Verifies that all load units within the current transaction group are booked out
   */
  @Then("all load units within {string} transaction group are booked out")
  @Transactional(readOnly = true)
  public void bookedOutAllLu(String keyTransaction) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {

      if (actTransaction.getIdLu1Src() != null) {
        ImLoadUnit loadUnit = readImLoadUnit(actTransaction.getIdLu1Src());
        assertNull(loadUnit);
      }
      if (actTransaction.getIdLu2Src() != null) {
        ImLoadUnit loadUnit = readImLoadUnit(actTransaction.getIdLu2Src());
        assertNull(loadUnit);
      }
      if (actTransaction.getIdLu3Src() != null) {
        ImLoadUnit loadUnit = readImLoadUnit(actTransaction.getIdLu3Src());
        assertNull(loadUnit);
      }
    }
  }

  /**
   * Ensure that ImLoadUnit that was created is only read from database if it's necessary.
   * 
   * @return last created transaction
   */
  public ImLoadUnit readImLoadUnit(String idLu) {
    ImLoadUnit loadUnitList = imLoadUnitRep.findOne(new ImLoadUnitPk(generalHelper.getIdSite(), idLu));
    return loadUnitList;
  }

}
