package com.inconso.bend.inwmsx.it.inventory;

import org.springframework.beans.factory.annotation.Autowired;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryRelluInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class RelLuHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  private InventoryRelluInput.Builder relluInputBuilder;

  /**
   * Prepares the input for a webservice call of transaction type RELQU with the given load unit.
   * 
   * @param key
   * 
   * @param storageAreaTgt
   * 
   * @param StorageLocationTgt
   * 
   */
  @Given("the load unit {string} has to be booked to target location {string}-{string} with transaction type RELLU")
  public void createRelLUInputForSelectedLu(String key, String storageAreaTgt, String StorageLocationTgt) {
    relluInputBuilder = new InventoryRelluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), "AUTO_IT");
    relluInputBuilder.withStorageLocationTgt(storageAreaTgt, StorageLocationTgt);
  }

  /**
   * Call RELLU transaction
   */
  @When("RELLU is called")
  public void relquIsCalled() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);
  }

}
