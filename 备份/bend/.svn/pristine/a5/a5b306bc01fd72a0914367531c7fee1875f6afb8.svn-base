package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.core.exception.BendException;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.gen.ImTransactionPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inventory.pers.rep.ImTransactionRep;
import com.inconso.bend.inventory.service.transaction.api.InventoryRelluInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.FieldExtractor;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.topology.pers.gen.TopVStorageLocationPk;
import com.inconso.bend.topology.pers.model.TopVStorageLocation;
import com.inconso.bend.topology.pers.rep.TopVStorageLocationRep;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class RelLuHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  private InventoryRelluInput.Builder relluInputBuilder;
  @Autowired
  private ImTransactionRep            transactionRep;
  @Autowired
  private ImLoadUnitRep               imLoadUnitRep;
  @Autowired
  private TopVStorageLocationRep      storageLocationRep;

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

  @Given("the load unit {string} has to be booked to target location {string}-{string} with RELLU type BOOKING")
  public void relocateLu(String key, String loadAreaTgt, String loadLocationTgt) {
    relluInputBuilder = new InventoryRelluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), "IM400", "AUTO_IT");
    relluInputBuilder.withStorageLocationTgt(loadAreaTgt, loadLocationTgt);
  }

  @Given("the load unit {string} has to be booked to target location {string}-{string} with RELLU type BOOKING and location having {double}% occupation")
  @Transactional(readOnly = false)
  public void relocateLuNotEnoughCapacityTargetLocation(String key, String loadAreaTgt, String loadLocationTgt, double occupation) {

    double storageoccupation = storageLocationRep
        .findOneOrThrowException(new TopVStorageLocationPk(generalHelper.getIdSite(), loadAreaTgt, loadLocationTgt)).getPctOccupied();
    if (!(storageoccupation == occupation)) {
      var obj = storageLocationRep.findOneOrThrowException(new TopVStorageLocationPk(generalHelper.getIdSite(), loadAreaTgt, loadLocationTgt));
      obj._persistence_set_pctOccupied(occupation);

    }
    // System.out.println(storageoccupation);
    relluInputBuilder = new InventoryRelluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*",
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), "IM400", "AUTO_IT");
    relluInputBuilder.withStorageLocationTgt(loadAreaTgt, loadLocationTgt);
  }

  @And("load unit with transaction {string} is at target location {string}-{string}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitIsAtTgtLocation(String key, String area, String location) {
    ImTransaction currentTransaction = inventoryDataHandler.getTransaction(key);
    String transactionGroup = inventoryDataHandler.getTransaction(key).getIdTransactionGrp();
    //@formatter:off
    assertAll(() -> assertNotNull(currentTransaction), 
              () -> assertEquals(area, currentTransaction.getStorageAreaTgt()), 
              () -> assertEquals(location, currentTransaction.getStorageLocationTgt()));
    //@formatter:on
  }

  @And("load unit with transaction {string} source location was {string}-{string}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitSourceLocation(String key, String area, String location) {
    ImTransaction currentTransaction = inventoryDataHandler.getTransaction(key);
    //@formatter:off
    assertAll(() -> assertNotNull(currentTransaction), 
              () -> assertEquals(area, currentTransaction.getStorageAreaSrc()), 
              () -> assertEquals(location, currentTransaction.getStorageLocationSrc()));
    //@formatter:on
  }

  @And("load unit with transaction {string} is not moving and has status {string}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitNotMoving(String key, String status) {
    ImTransaction currentTransaction = inventoryDataHandler.getTransaction(key);
    //@formatter:off
    assertAll(() -> assertNotNull(currentTransaction), 
              () -> assertEquals("90", currentTransaction.getStat()));
    //@formatter:on
  }

  @When("RELLU is called with no idSite")
  public void checkRelluWithNoIdSite() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    InventoryRelluInput input = relluInputBuilder.build();
    input.setIdSite(null);
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with no clProcess")
  public void checkRelluWithNoclProcess() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    input.setClProcess(null);
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with no typProcess")
  public void checkRelluWithNoTypProcess() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    input.setTypProcess(null);
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with no stepProcess")
  public void checkRelluWithNoStepProcess() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    input.setStepProcess(null);
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with no key")
  public void checkRelluWithNokey() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    input.setKey(null);
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with no idLu")
  public void checkRelluWithNoIdLu() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    input.setIdLu(null);
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with no idUser")
  public void checkRelluWithNoIdUser() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    input.setIdUser(null);
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with inconsistent references, dRef null and idRef1 filled")
  public void checkRelluWithInconsistentReference() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.withTypRefAndId(null, "reference1", "reference2").build();
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with inconsistent references, idRef = GI_ORDER and idRef1 = null, idRef2, idRef3, idRef4, idRef5 and idRef6 filled")
  public void checkRelluWithInconsistentReferenceIdRef() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder
        .withTypRefAndId("GI_ORDER", null, "reference2", "reference3", "reference4", "reference5", "reference6").build();
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with inconsistent references, idRef = ABC and others are irrelevant")
  public void checkRelluWithInconsistentReferenceIdRefAndOthersIrrelevant() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.withTypRefAndId("ABC", null, null, null, null, null, null).build();
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);

  }

  @When("RELLU is called with non-existing Lu")
  public void checkRelluWithInvalidTypStepProcessCombination() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    input.setIdLu("012333333330");
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);
  }

  @When("RELLU is called with no target location")
  public void checkRelluWithNotargetLocation() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    input.setStorageLocationTgt(null);
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);
  }

  @When("RELLU is called with a target location that doesnot accept load unit type")
  @When("RELLU is called with a target location having enough capacity")
  @When("RELLU is called with a target location having not enough capacity")
  public void checkRelluWithtargetLocationinsufficientorsufficientcapcity() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);
  }

  @Then("RELLU throws id exception {string}")
  public void relluThrowsIdException(String exceptionid) {
    assertEquals(exceptionid, webserviceClient.getErrorCode());

  }

  @Then("verify that RELLU is successful")
  public void relluSuccess() {
    webserviceClient.verifySuccess();

  }

}
