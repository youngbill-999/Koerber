package com.inconso.bend.inwmsx.it.inventory;

import org.springframework.beans.factory.annotation.Autowired;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryStaluInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class StaLuHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  private InventoryStaluInput.Builder staluInputBuilder;

  /**
   * Prepares the input for a webservice call of transaction type STALU without source load unit ID.
   * 
   */
  @Given("the input for STALU has to be prepared with target load unit {string} and without source load unit ID")
  public void createStaluInputWithoutIdLuSrc(String key) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*", null,
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), "AUTO_IT");
  }

  /**
   * Prepares the input for a webservice call of transaction type STALU the input for STALU has to be prepared without a target storage area
   * 
   */
  @Given("the input for STALU has to be prepared with source load unit {string} and without a target storage area")
  public void createStaluInputWithoutStorageAreaTgt(String key) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), null, "AUTO_IT");
    staluInputBuilder.withStorageLocationTgt(null, null);
  }

  /**
   * Prepares the input for a webservice call of transaction type STALU with an unknown source load unit ID.
   * 
   */
  @Given("the input for STALU has to be prepared with target load unit {string} and an unknown source load unit ID")
  public void createStaluInputWithUnknownIdLuSrc(String key) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*", "unknownIdLuSrc",
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), "AUTO_IT");
  }

  /**
   * Prepares the input for a webservie call of transaction type STALU with an unknown target load unit ID.
   * 
   */
  @Given("the input for STALU has to be prepared with source load unit {string} and an unknown target load unit ID")
  public void createStaluInputWithUnknownIdLuTgt(String key) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), "unknownIdLuSrc", "AUTO_IT");
  }

  /**
   * Prepares the input for a webservice call of transaction type STALU with an unknown target load unit ID.
   * 
   */
  @Given("the input for STALU has to be prepared with target load unit {string} and an unknown target location")
  public void createStaluInputWithUnknownLocationTgt(String key) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), null, "AUTO_IT");
    staluInputBuilder.withStorageLocationTgt("unkownAreaTgt", "unkownLocationTgt");
  }

  /**
   * Adds the given references to the input for the webservice call of transaction type STALU
   * 
   * @param refType
   *          reference type
   * @param idRef1
   *          part 1 of ref key
   * @param idRef2
   *          part 1 of ref key
   */
  @And("the STALU reference type is {string} with id {string}-{string}")
  public void setReferences(String refType, String idRef1, String idRef2) {
    if (staluInputBuilder != null) {
      staluInputBuilder.withTypRefAndId(refType, idRef1, idRef2);
    }
  }

  /**
   * Prepares the input for a webservice call of transaction type STALU with the given load unit to stack off.
   * 
   * @param key
   * 
   * @param areaTgt
   * 
   * @param locationTgt
   * 
   */
  @Given("the load unit {string} has to be stacked off to the target location {string}-{string}")
  public void createStaluInputOnLuToStackOff(String key, String areaTgt, String locationTgt) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), null, "AUTO_IT");
    staluInputBuilder.withStorageLocationTgt(areaTgt, locationTgt);
  }

  /**
   * Prepares the input for a webservice call of transaction type STALU with the given load unit.
   * 
   * @param keyTopLu
   * 
   * @param keyBottomLu
   * 
   */
  @Given("the load unit {string} has to be stacked on the load unit {string}")
  public void createStaluInputOnLu(String keyTopLu, String keyBottomLu) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(keyTopLu).getImLoadUnitPk().getIdLu(),
        inventoryDataHandler.getLoadUnit(keyBottomLu).getImLoadUnitPk().getIdLu(), "AUTO_IT");
  }

  /**
   * Sets the given parameters for determination of a situation to the input for the webservice call of transaction type STALU
   * 
   * @param keyTopLu
   * 
   * @param keyBottomLu
   * 
   * @param clProcess
   *          process class
   * @param typProcess
   *          process type
   * @param stepProcess
   *          process step
   */
  @And("the load unit {string} has to be stacked on the load unit {string} with: clProcess = {string}, typProcess = {string}, stepProcess = {string}")
  public void setSituationParams(String keyTopLu, String keyBottomLu, String clProcess, String typProcess, String stepProcess) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), clProcess, typProcess, stepProcess, "*",
        inventoryDataHandler.getLoadUnit(keyTopLu).getImLoadUnitPk().getIdLu(),
        inventoryDataHandler.getLoadUnit(keyBottomLu).getImLoadUnitPk().getIdLu(), "AUTO_IT");
  }

  /**
   * Prepares the input for a webservice call of transaction type STALU the input for STALU has to be prepared with target location and target load
   * unit
   * 
   */
  @Given("the load unit {string} has to be stacked on the load unit {string} with target location {string}-{string}")
  public void createStaluInputWithStorageLocAndLuTgt(String keyTopLu, String keyBottomLu, String storageAreaTgt, String storageLocationTgt) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(keyTopLu).getImLoadUnitPk().getIdLu(),
        inventoryDataHandler.getLoadUnit(keyBottomLu).getImLoadUnitPk().getIdLu(), "AUTO_IT");
    staluInputBuilder.withStorageLocationTgt(storageAreaTgt, storageLocationTgt);
  }

  /**
   * Prepares the input for a webservice call of transaction type STALU with the given load unit to stack to location.
   * 
   * @param key
   * 
   * @param storageAreaTgt
   * 
   * @param storageLocationTgt
   * 
   */
  @Given("the load unit {string} has to be stacked to location {string}-{string}")
  public void createStaluInputOnLuSelectedToLocation(String key, String storageAreaTgt, String storageLocationTgt) {
    staluInputBuilder = new InventoryStaluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), null, "AUTO_IT");
    staluInputBuilder.withStorageLocationTgt(storageAreaTgt, storageLocationTgt);
  }

  /**
   * Call STALU transaction
   */
  @When("STALU is called")
  public void staluIsCalled() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryStaluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryStaluInput input = staluInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.STALU_EP, inputService);
  }

}
