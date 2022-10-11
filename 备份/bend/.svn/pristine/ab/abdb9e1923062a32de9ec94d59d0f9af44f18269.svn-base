package com.inconso.bend.inwmsx.it.inventory;

import org.springframework.beans.factory.annotation.Autowired;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryResstInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class ResStHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  private InventoryResstInput.Builder resstInputBuilder;

  /**
   * Prepares the input for a webservie call of transaction type RESST with the given values.
   * 
   * @param qty
   *          qty to reserve
   */
  @Given("{double} pieces of quantum {string} have to be reserved")
  public void createCorstInputToReserve(Double qty, String key) {
    resstInputBuilder = new InventoryResstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        inventoryDataHandler.getQuantum(key).getImQuantumPk().getIdQuantum(), qty, "AVAILABLE", "AUTO_IT");
  }

  /**
   * Prepares the input for a webservie call of transaction type RESST with the given values and reason.
   * 
   * @param qty
   *          qty to reserve
   * @param typQty
   *          type of qty
   * @param reason1
   *          reason transaction
   * @param reason2
   *          reason transaction
   */
  @Given("{double} {string} pieces of quantum {string} with reason {string} and {string} have to be reserved")
  public void createCorstInputWithReason(Double qty, String typQty, String key, String reason1, String reason2) {
    resstInputBuilder = new InventoryResstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        inventoryDataHandler.getQuantum(key).getImQuantumPk().getIdQuantum(), qty, typQty, "AUTO_IT");
    resstInputBuilder.withReasonTransaction(reason1, reason2);
  }

  /**
   * Call RESST transaction
   */
  @When("RESST is called")
  public void crequIsCalled() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryResstInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryResstInput input = resstInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RESST_EP, inputService);
  }

  /**
   * Sets the given parameters for determination of a situation to the input for the webservice call of transaction type RESST
   * 
   * @param key
   *          key
   * @param clProcess
   *          process class
   * @param typProcess
   *          process type
   * @param stepProcess
   *          process step
   */
  @And("the situation parameters for RESST are: creQu = {StringExt}, clProcess = {string}, typProcess = {string}, stepProcess = {string}")
  public void setSituationParams(GherkinType<String> creQu, String clProcess, String typProcess, String stepProcess) {
    creQu.setGetterForKey(inventoryDataHandler.idQuGetter);
    if (resstInputBuilder != null) {
      resstInputBuilder = new InventoryResstInput.Builder(generalHelper.getIdSite(), clProcess, // clProcess
          typProcess, // typProcess
          stepProcess, // stepProcess
          "RK1", "*", creQu.get(), 5.0, "AVAILABLE", "AUTO_IT");
    }
  }

  /**
   * Prepares the input for a webservie call of transaction type RESST with quantum ID empty.
   * 
   * @param qty
   * 
   * @param typeQty
   * 
   * @param reason1
   * 
   * @param reason2
   * 
   */
  @Given("{double} {string} pieces with empty quantum ID and reason {string} and {string} have to be reserved")
  public void createResstInputWithoutQuantumIdNull(Double qty, String typeQty, String reason1, String reason2) {
    resstInputBuilder = new InventoryResstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*", "", qty,
        typeQty, "AUTO_IT");
    resstInputBuilder.withReasonTransaction(reason1, reason2);
  }

  /**
   * Prepares the input for a webservie call of transaction type RESST with unknown quantum ID.
   * 
   * @param qty
   * 
   * @param typeQty
   * 
   * @param reason1
   * 
   * @param reason2
   * 
   */
  @Given("{double} {string} pieces with unknown quantum ID and reason {string} and {string} have to be reserved")
  public void createResstInputWithUnknownQuantumId(Double qty, String typeQty, String reason1, String reason2) {
    resstInputBuilder = new InventoryResstInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        "00000000000", qty, typeQty, "AUTO_IT");
    resstInputBuilder.withReasonTransaction(reason1, reason2);
  }
}
