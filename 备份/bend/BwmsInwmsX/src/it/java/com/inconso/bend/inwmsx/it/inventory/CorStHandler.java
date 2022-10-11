package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryCorstInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.topology.pers.gen.TopVStorageLocationPk;
import com.inconso.bend.topology.pers.model.TopVStorageLocation;
import com.inconso.bend.topology.pers.rep.TopVStorageLocationRep;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class CorStHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  @Autowired
  private TopVStorageLocationRep      locationRep;

  private InventoryCorstInput.Builder corstInputBuilder;

  private TopVStorageLocation         storageLocation;

  /**
   * Prepares the input for a webservice call of transaction type CORST with the given values for the selected quantum.
   * 
   * @param typQty
   *          type of qty
   * @param key
   *          key
   * @param correctionType
   *          type correction
   * @param qty
   *          free qty of new quantum
   * @param storageAreaSrc
   *          source storage area
   * @param storageLocationSrc
   *          source storage location
   */
  @Given("the {string} quantity of the quantum {string} has to be changed with correction type {string} by {double} pieces with location {string}-{string}")
  public void createCorstInputForSelectedQuantum(String typQty, String key, String correctionType, Double qty, String storageAreaSrc,
      String storageLocationSrc) {
    corstInputBuilder = new InventoryCorstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        inventoryDataHandler.getQuantum(key).getImQuantumPk().getIdQuantum(), qty, typQty, correctionType, storageAreaSrc, storageLocationSrc,
        "AUTO_IT");
  }

  /**
   * Prepares the input for a webservie call of transaction type CORST without type of quantity.
   * 
   * @param key
   *          key
   * @param correctionType
   *          type correction
   * @param qty
   *          free qty of new quantum
   * @param storageAreaSrc
   *          source storage area
   * @param storageLocationSrc
   *          source storage location
   */
  @Given("the quantum {string} has to be changed without type of quantity and with correction type {string} by {double} pieces with location {string}-{string}")
  public void createCorstInputWithoutQtyTyp(String key, String correctionType, Double qty, String storageAreaSrc, String storageLocationSrc) {
    corstInputBuilder = new InventoryCorstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        inventoryDataHandler.getQuantum(key).getImQuantumPk().getIdQuantum(), qty, "", correctionType, storageAreaSrc, storageLocationSrc, "AUTO_IT");
  }

  /**
   * Prepares the input for a webservie call of transaction type CORST with empty quantum ID.
   * 
   * @param qtyTyp
   *          type of quantity
   * @param storageAreaSrc
   *          source storage area
   * @param storageLocationSrc
   *          source storage location
   * @param qty
   *          free qty of new quantum
   * @param correctionType
   *          type correction
   */
  @Given("the {string} quantity with empty quantum ID has to be changed with correction type {string} by {double} pieces with location {string}-{string}")
  public void createCorstInputWithEmtpyQuantum(String qtyTyp, String correctionType, Double qty, String storageAreaSrc, String storageLocationSrc) {
    corstInputBuilder = new InventoryCorstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*", "", qty,
        qtyTyp, correctionType, storageAreaSrc, storageLocationSrc, "AUTO_IT");
  }

  /**
   * Prepares the input for a webservie call of transaction type CORST without correction type.
   */
  @Given("the quantum {string} has to be changed with type of quantity {string} and without correction type by {double} pieces with location {string}-{string}")
  public void createCorstInputWithoutCorTyp(String key, String typQty, Double qty, String storageAreaSrc, String storageLocationSrc) {
    corstInputBuilder = new InventoryCorstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        inventoryDataHandler.getQuantum(key).getImQuantumPk().getIdQuantum(), qty, typQty, "", storageAreaSrc, storageLocationSrc, "AUTO_IT");
  }

  /**
   * Prepares the input for a webservie call of transaction type CORST without quantum ID.
   * 
   * @param storageAreaSrc
   *          source storage area
   * @param storageLocationSrc
   *          source storage location
   * @param qty
   *          free qty of new quantum
   * @param typQty
   *          type of qty
   * @param correctionType
   *          type correction
   */
  @Given("the {string} quantity without quantum ID has to be changed with correction type {string} by {double} pieces with location {string}-{string}")
  public void createCorstInputWithoutQuantum(String typQty, String correctionType, Double qty, String storageAreaSrc, String storageLocationSrc) {
    corstInputBuilder = new InventoryCorstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*", null,
        qty, typQty, correctionType, storageAreaSrc, storageLocationSrc, "AUTO_IT");
  }

  /**
   * Prepares the input for a webservie call of transaction type CORST with nonexistent quantum ID.
   * 
   * @param quantumId
   *          nonexistent quantum ID
   * @param storageAreaSrc
   *          source storage area
   * @param storageLocationSrc
   *          source storage location
   * @param qty
   *          free qty of new quantum
   * @param typQty
   *          type of qty
   * @param correctionType
   *          type correction
   */
  @Given("the {string} quantity with a nonexistent quantum ID {string} has to be changed with correction type {string} by {double} pieces with location {string}-{string}")
  public void createCorstInputNonexistsQuantum(String typQty, String quantumId, String correctionType, Double qty, String storageAreaSrc,
      String storageLocationSrc) {
    corstInputBuilder = new InventoryCorstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        quantumId, qty, typQty, correctionType, storageAreaSrc, storageLocationSrc, "AUTO_IT");
  }

  /**
   * Generate the input for a webservie call of transaction type CORST to get error message.
   * 
   * @param quantumId
   * 
   * @param storageAreaSrc
   *          source storage area
   * @param storageLocationSrc
   *          source storage location
   * @param qty
   *          qty for correction
   * @param typQty
   *          type of qty
   * @param correctionType
   *          type correction
   */
  @Given("prepares the transaction type CORST with different: {string}, {double}, {string}, {string}, {string}, {string}")
  public void createCorstInputWithError(String quantumId, Double qty, String typQty, String correctionType, String storageAreaSrc,
      String storageLocationSrc) {
    corstInputBuilder = new InventoryCorstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        quantumId, qty, typQty, correctionType, storageAreaSrc, storageLocationSrc, "AUTO_IT");
  }

  /**
   * Call CORST transaction
   */
  @When("CORST is called")
  public void corstIsCalled() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryCorstInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryCorstInput input = corstInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.CORST_EP, inputService);
  }

  /**
   * Current weight of location
   * 
   * @param area
   * 
   * @param stoLocation
   * 
   * @param weight
   * 
   */
  @Then("the current weight of location {string}-{string} is {double}")
  @Transactional(readOnly = true)
  public void currentWeightOfLocation(String area, String stoLocation, Double weight) {
    TopVStorageLocation location = readStorageLocation(area, stoLocation);
    assertEquals(weight, location.getWtResidual());
  }

  /**
   * Verifies that remaining weight has the expected value
   * 
   * @param area
   * 
   * @param stoLocation
   * 
   * @param weight
   * 
   */
  @Then("verify that the remaining weight of location {string}-{string} is {double}")
  @Transactional(readOnly = true)
  public void verifyRemainingWeightOfLocation(String area, String stoLocation, Double weight) {
    TopVStorageLocation location = readStorageLocation(area, stoLocation);
    assertEquals(weight, location.getWtResidual());
  }

  /**
   * Sets the given parameters for determination of a situation to the input for the webservice call of transaction type CORST
   * 
   * @param clProcess
   *          process class
   * @param typProcess
   *          process type
   * @param stepProcess
   *          process step
   */
  @And("the situation parameters for CORST are {string}, {string}, {string}")
  public void setSituationParams(String clProcess, String typProcess, String stepProcess) {
    if (corstInputBuilder != null) {
      corstInputBuilder.build().setClProcess(clProcess);
      corstInputBuilder.build().setTypProcess(typProcess);
      corstInputBuilder.build().setStepProcess(stepProcess);
    }
  }

  /**
   * Reads the object for the occupated location
   * 
   * @param verifyLocation
   * 
   * @return object location
   */
  private TopVStorageLocation readStorageLocation(String area, String location) {
    storageLocation = locationRep.findOne(new TopVStorageLocationPk(generalHelper.getIdSite(), area, location));
    return storageLocation;
  }

  @Given("the CORST reasons are {string} and {string}")
  public void setCrequReasons(String reason1, String reason2) {
    corstInputBuilder.withReasonTransaction(reason1, reason2);
  }
}
