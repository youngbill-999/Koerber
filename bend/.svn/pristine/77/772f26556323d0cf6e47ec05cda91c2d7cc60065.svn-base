package com.inconso.bend.inwmsx.it.inventory;

import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryRelquInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import org.springframework.beans.factory.annotation.Autowired;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class RelQuHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private CucumberReport              cucumberReport;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  private InventoryRelquInput.Builder relquInputBuilder;

  /**
   * Prepares the input for a webservice call of transaction type RELQU with the given quantum ID.
   * 
   */
  @Given("the quantum {string} has to be booked to target load unit {string}")
  public void createRelquInputWithQuantumId(String keyCreQu, String keyCreLu) {
    String creQuId = inventoryDataHandler.getQuantum(keyCreQu).getImQuantumPk().getIdQuantum();
    relquInputBuilder = new InventoryRelquInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*", creQuId,
        "AUTO_IT");
    String creLuId = inventoryDataHandler.getLoadUnit(keyCreLu).getImLoadUnitPk().getIdLu();
    relquInputBuilder.withTargetLu(creLuId);
    cucumberReport.setMessage("idQuantum = " + creQuId + " , idLu = " + creLuId);
  }

  /**
   * Prepares the input for a webservice call of transaction type RELQU with the given quantum and location.
   * 
   * @param key
   * 
   * @param storageAreaTgt
   * 
   * @param storageLocationTgt
   * 
   */

  @Given("the quantum {string} has to be booked to location {string}-{string}")
  public void createRelquInputForSelectedQuantumWithLocation(String key, String storageAreaTgt, String storageLocationTgt) {
    relquInputBuilder = new InventoryRelquInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        inventoryDataHandler.getQuantum(key).getImQuantumPk().getIdQuantum(), "AUTO_IT");
    relquInputBuilder.withTargetLu(null);
    relquInputBuilder.withStorageLocationTgt(storageAreaTgt, storageLocationTgt);
  }

  /**
   * Prepares the input for a webservie call of transaction type RELQU with the given load unit.
   * 
   */
  @Given("RELQU target load unit is {string}")
  public void createRelquInputWithLoadUnit(String key) {
    relquInputBuilder.withTargetLu(inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu());
  }

  /**
   * Prepares the input for a webservie call of transaction type RELQU with the given reasons.
   * 
   * @param reason1
   * 
   * @param reason2
   * 
   */
  @Given("the reasons for relocate quantum are {string} and {string}")
  public void setCrequReasons(String reason1, String reason2) {
    relquInputBuilder.withReasonTransaction(reason1, reason2);
  }

  /**
   * Call RELQU transaction
   */
  @When("RELQU is called")
  public void relquIsCalled() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelquInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelquInput input = relquInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELQU_EP, inputService);
  }

  /**
   * Sets the given parameters for determination of a situation to the input for the webservice call of transaction type RELQU
   * 
   * @param clProcess
   *          process class
   * @param typProcess
   *          process type
   * @param stepProcess
   *          process step
   */
  @And("the situation parameters for RELQU are: creQu = {StringExt}, clProcess = {string}, typProcess = {string}, stepProcess = {string}")
  public void setSituationParams(GherkinType<String> creQu, String clProcess, String typProcess, String stepProcess) {
    creQu.setGetterForKey(inventoryDataHandler.idQuGetter);
    if (relquInputBuilder != null) {
      relquInputBuilder = new InventoryRelquInput.Builder(generalHelper.getIdSite(), clProcess, // clProcess
          typProcess, // typProcess
          stepProcess, // stepProcess
          generalHelper.getIdClient(), "*", creQu.get(), "AUTO_IT");
    }
  }

  /**
   * Prepares the input for a webservie call of transaction type RELQU with empty quantum ID.
   * 
   * @param storageAreaTgt
   * 
   * @param storageLocationTgt
   * 
   */
  @Given("the input with empty quantum ID has to be booked to location {string}-{string}")
  public void createRelquInputWithoutQuantumIdNull(String storageAreaTgt, String storageLocationTgt) {
    relquInputBuilder = new InventoryRelquInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*", "",
        "AUTO_IT");
    relquInputBuilder.withStorageLocationTgt(storageAreaTgt, storageLocationTgt);
  }

  /**
   * Prepares the input for a webservie call of transaction type RELQU without target load unit.
   * 
   */
  @Given("the input without target load unit for transaction type RELQU")
  public void createRelquInputWithoutTargetLu() {
    relquInputBuilder = new InventoryRelquInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        "42000000041", "AUTO_IT");
    relquInputBuilder.withTargetLu(null);
  }

  /**
   * Prepares the input for a webservie call of transaction type RELQU without target location.
   * 
   */
  @Given("the input without target location for transaction type RELQU")
  public void createRelquInputWithoutTargetLocation() {
    relquInputBuilder = new InventoryRelquInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        "42000000041", "AUTO_IT");
    relquInputBuilder.withStorageLocationTgt(null, null);
  }

  /**
   * Prepares the input for a webservie call of transaction type RELQU without target location.
   * 
   * @param quantumId
   * 
   * @param storageAreaTgt
   * 
   * @param storageLocationTgt
   * 
   * @param idLu
   * 
   */
  @Given("the input with quantum ID {string}, target location {string}-{string} and load unit {string}")
  public void createRelquInputWithTargetLocationAndLu(String quantumId, String storageAreaTgt, String storageLocationTgt, String idLu) {
    relquInputBuilder = new InventoryRelquInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        quantumId, "AUTO_IT");
    relquInputBuilder.withTargetLu(idLu);
    relquInputBuilder.withStorageLocationTgt(storageAreaTgt, storageLocationTgt);

  }

}
