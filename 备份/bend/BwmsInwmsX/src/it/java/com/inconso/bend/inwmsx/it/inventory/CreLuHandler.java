package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.util.List;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitStackPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImLoadUnitStack;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitStackRep;
import com.inconso.bend.inventory.service.transaction.api.InventoryCreluInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.FieldExtractor;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.inwmsx.it.transport.TransportWebserviceCaller;
import com.inconso.bend.topology.pers.gen.TopStorageAreaPk;
import com.inconso.bend.topology.pers.gen.TopVStorageLocationPk;
import com.inconso.bend.topology.pers.model.TopStorageArea;
import com.inconso.bend.topology.pers.model.TopVStorageLocation;
import com.inconso.bend.topology.pers.rep.TopStorageAreaRep;
import com.inconso.bend.topology.pers.rep.TopVStorageLocationRep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class CreLuHandler {

  private static final String         ID_SITE = "RL1";

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private TransportWebserviceCaller   transportWebserviceCaller;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  @Autowired
  private TransactionHelper           transactionHelper;

  @Autowired
  private ImLoadUnitRep               imLoadUnitRep;

  @Autowired
  private TopStorageAreaRep           areaRep;

  @Autowired
  private TopVStorageLocationRep      storageLocationRep;

  @Autowired
  private ImLoadUnitStackRep          loadUnitStackRep;

  private InventoryCreluInput.Builder creluInputBuilder;

  /**
   * Allows empty LU management for location area "H01-BL" before the scenario
   */
  @Before("@allowEmptyLuForLocationAreaH01BL")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void allowEmptyLuForLocationAreaH01BL() {
    TopStorageArea h01bl = areaRep.findOne(new TopStorageAreaPk(ID_SITE, "H01-BL"));
    h01bl.setFlgEmptyLuMgmt("1");
  }

  /**
   * Forbids empty LU management for location area "H01-BL" before the scenario
   */
  @After("@allowEmptyLuForLocationAreaH01BL")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void forbidEmptyLuForLocationAreaH01BL() {
    TopStorageArea h01bl = areaRep.findOne(new TopStorageAreaPk(ID_SITE, "H01-BL"));
    h01bl.setFlgEmptyLuMgmt("0");
  }

  /**
   * Allows empty LU management for location area "H01-FACH" before the scenario
   */
  @Before("@allowEmptyLuForLocationAreaH01FACH")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void allowEmptyLuForLocationAreaH01FACH() {
    TopStorageArea h01bl = areaRep.findOne(new TopStorageAreaPk(ID_SITE, "H01-FACH"));
    h01bl.setFlgEmptyLuMgmt("1");
  }

  /**
   * Forbids empty LU management for location area "H01-FACH" before the scenario
   */
  @After("@allowEmptyLuForLocationAreaH01FACH")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void forbidEmptyLuForLocationAreaH01FACH() {
    TopStorageArea h01bl = areaRep.findOne(new TopStorageAreaPk(ID_SITE, "H01-FACH"));
    h01bl.setFlgEmptyLuMgmt("0");
  }

  /**
   * Prepares the input for a webservie call of transaction type CRELU with the given values.
   * 
   * @param storageAreaSrc
   *          source storage area
   * @param storageLocationSrc
   *          source storage location
   * @param storageAreaTgt
   *          target storage area
   * @param storageLocationTgt
   *          target storage location
   */
  @Given("a load unit from storage location {string}-{string} to storage location {string}-{string} has to be created")
  public void createLUInput(String storageAreaSrc, String storageLocationSrc, String storageAreaTgt, String storageLocationTgt) {
    creluInputBuilder = new InventoryCreluInput.Builder(generalHelper.getIdSite(), "DIALOG", // clProcess
        "IM400", // typProcess
        "CRELU", // stepProcess
        "*", // key
        storageAreaSrc, storageLocationSrc, // Quelle
        storageAreaTgt, storageLocationTgt, "AUTO_IT");
  }

  /**
   * Adds the given load unit ID to the input for the webservice call of transaction type CRELU
   * 
   * @param luId
   *          specified load unit ID
   */
  @And("the load unit ID is {string}")
  public void setLUInputLuId(String luId) {
    if (creluInputBuilder != null) {
      creluInputBuilder.withIdLu(luId);
    }
  }

  /**
   * Adds the given sscc to the input for the web service call of transaction type CRELU
   * 
   * @param sscc
   *          specified SSCC
   */
  @And("the CRELU input has: SSCC = {String}")
  public void setLUInputSscc(String sscc) {
    if (creluInputBuilder != null) {
      creluInputBuilder.withSscc(sscc);
    }
  }

  /**
   * Adds the given height to the input for the web service call of transaction type CRELU
   * 
   * @param height
   *          specified height
   */
  @And("the CRELU input has: height = {Double}")
  public void setLUInputheight(Double height) {
    if (creluInputBuilder != null) {
      creluInputBuilder.withHeight(height);
    }
  }

  /**
   * Adds the given load unit type to the input for the webservice call of transaction type CRELU
   * 
   * @param luType
   *          specified load unit type
   */
  @And("the load unit type is {string}")
  public void setLUInputLuType(String luType) {
    if (creluInputBuilder != null) {
      creluInputBuilder.withTypLu(luType);
    }
  }

  /**
   * Sets the given parameters for determination of a situation to the input for the webservice call of transaction type CRELU
   * 
   * @param clProcess
   *          process class
   * @param typProcess
   *          process type
   * @param stepProcess
   *          process step
   */
  @And("the situation parameters are {string}, {string}, {string}")
  public void setSituationParams(String clProcess, String typProcess, String stepProcess) {
    if (creluInputBuilder != null) {
      String storageAreaSrc = creluInputBuilder.build().getStorageAreaSrc();
      String storageLocationSrc = creluInputBuilder.build().getStorageLocationSrc();
      String storageAreaTgt = creluInputBuilder.build().getStorageAreaTgt();
      String storageLocationTgt = creluInputBuilder.build().getStorageLocationTgt();
      creluInputBuilder = new InventoryCreluInput.Builder(generalHelper.getIdSite(), clProcess, // clProcess
          typProcess, // typProcess
          stepProcess, // stepProcess
          "*", // key
          storageAreaSrc, storageLocationSrc, // Quelle
          storageAreaTgt, storageLocationTgt, "AUTO_IT");
    }
  }

  /**
   * Adds the given references to the input for the webservice call of transaction type CRELU
   * 
   * @param refType
   *          reference type
   * @param idRef1
   *          part 1 of ref key
   * @param idRef2
   *          part 1 of ref key
   */
  @And("the reference type is {string} with id {string}-{string}")
  public void setReferences(String refType, String idRef1, String idRef2) {
    if (creluInputBuilder != null) {
      creluInputBuilder.withTypRefAndId(refType, idRef1, idRef2);
    }
  }

  /**
   * Adds the given reasons to the input for the webservice call of transaction type CRELU
   * 
   * @param reason1
   *          first reason
   * @param reason2
   *          second reason
   */
  @And("the reasons are {string}-{string}")
  public void setLUInputReason(String reason1, String reason2) {
    if (creluInputBuilder != null) {
      creluInputBuilder.withReasonTransaction(reason1, reason2);
    }
  }

  /**
   * Calls the webservice of transaction type CRELU
   * 
   */
  @When("CRELU is called")
  public void creluIsCalled() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryCreluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryCreluInput input = creluInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.CRELU_EP, inputService);
  }

  /**
   * Verifies that the prior webservice call was successful and stores the relevant outpur for future verifications.
   * 
   */
  @When("CRELU was successful, saved as {string}; transaction saved as {string}")
  @Transactional(readOnly = true)
  public void creluSuccessful(String keyLoadUnit, String keyTransaction) {
    transactionHelper.transactionSuccessful(keyTransaction);
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    String idLu = payload.getString("idLu");
    ImLoadUnit loadUnit = imLoadUnitRep.findOne(new ImLoadUnitPk(generalHelper.getIdSite(), idLu));
    inventoryDataHandler.putLoadUnit(keyLoadUnit, loadUnit);
  }

  /**
   * Verifies that the load unit that was created by the prior webservice call is in status occupied "00" and the occupied percantage is 0 as well.
   * 
   */
  @Then("load unit {string} is empty")
  @Transactional(readOnly = true)
  public void verifyLoadUnitIsEmpty(String key) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(() -> assertNotNull(loadUnit), 
              () -> assertEquals("00", loadUnit.getStatOccupied()),
              () -> assertEquals(0.0, (double) loadUnit.getPctOccupied()));
    //@formatter:on
  }

  /**
   * Verifies that the load unit that was created by the prior webservice call has a sscc that consists of 20 characters
   */
  @Then("load unit {string} has a valid SSCC")
  @Transactional(readOnly = true)
  public void verifyLoadUnitHasValidSscc(String key) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(() -> assertNotNull(loadUnit), 
              () -> assertNotNull(loadUnit.getSscc()), 
              () -> assertEquals(20, loadUnit.getSscc().length()));
    //@formatter:on
  }

  /**
   * Verifies that the load unit that was created by the prior webservice call has the transaction ID that was returned by the service as output
   * 
   */
  @Then("load unit {string} has: idTransaction = {StringExt}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitHasTransactionId(String key, GherkinType<String> idTransaction) {
    idTransaction.setGetterForKey(inventoryDataHandler.idTransactionGetter);
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(() -> assertNotNull(loadUnit), 
              () -> assertEquals(idTransaction.get(), loadUnit.getIdTransaction()));
    //@formatter:on
  }

  /**
   * Verifies that the load unit that was created by the prior webservice call has the same gross weight as tara weight
   *
   */
  @Then("gross weight of the load unit {string} is the same as the tara weight")
  @Transactional(readOnly = true)
  public void verifyLoadUnitHasSameGrossAndTaraWeight(String key) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(() -> assertNotNull(loadUnit), 
              () -> assertEquals(loadUnit.getWtGross(), loadUnit.getWtTare()));
    //@formatter:on
  }

  /**
   * Verifies that the load unit that was created by the prior webservice call has the given load unit type
   * 
   * @param loadUnitType
   *          load unit type
   */
  @Then("load unit {string} has type {string}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitType(String key, String loadUnitType) {
    ImLoadUnit currentLu = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(() -> assertNotNull(currentLu), 
              () -> assertEquals(loadUnitType, currentLu.getTypLu()));
    //@formatter:on
  }

  /**
   * Verifies that the load unit that was created by the prior webservice call has an ID that starts with the given prefix.
   * 
   * @param luPrefix
   *          expected prefix
   */
  @Then("load unit {string} ID has prefix {string}")
  public void verifyLoadUnitIdPrefix(String key, String luPrefix) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    assertTrue(loadUnit.getImLoadUnitPk().getIdLu().startsWith(luPrefix));
  }

  /**
   * Verifies that the load unit that was created by the prior webservice call has the flag for transit set to "0"
   * 
   */
  @Then("load unit {string} is not moving")
  @Transactional(readOnly = true)
  public void verifyLoadUnitNotMoving(String key) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(() -> assertNotNull(loadUnit), 
              () -> assertEquals("0", loadUnit.getFlgInTransit()));
    //@formatter:on
  }

  /**
   * Verifies that the load unit that was created by the prior webservice call is at the desired target location
   * 
   */
  @Then("load unit {string} is at storage location {string}-{string}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitIsAtTgtLocation(String key, String area, String location) {
    ImLoadUnit currentLu = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(() -> assertNotNull(currentLu), 
              () -> assertEquals(area, currentLu.getStorageArea()), 
              () -> assertEquals(location, currentLu.getStorageLocation()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has the same sscc as the load unit
   *
   */
  @Then("transaction {string} has the same SSCC as the load unit {string}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTheSameSSCCAsTheLoadUnit(String keyTransaction, String keyLoadUnit) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(keyLoadUnit);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNotNull(loadUnit), 
        () -> assertEquals(transaction.getSsccTgt(), loadUnit.getSscc()));
    //@formatter:on
  }

  /**
   * Verifies that the load unit created by the prior webservice has the given sscc
   * 
   * @param sscc
   *          expected sscc
   */
  @Then("load unit {string} has SSCC {string}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitHasGivenSSCC(String key, String sscc) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(
        () -> assertNotNull(loadUnit), 
        () -> assertEquals(sscc, loadUnit.getSscc()));
    //@formatter:on
  }

  /**
   * Verifies that the load unit created by the prior webservice has the given height
   * 
   * @param height
   *          expected height
   */
  @Then("load unit {string} has height {double}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitHasGivenHeight(String key, Double height) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(
        () -> assertNotNull(loadUnit), 
        () -> assertEquals(height, loadUnit.getHeight()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has the same gross and tara weight as the load unit
   * 
   */
  @Then("transaction {string} has the same gross and tara weight as the load unit {string}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTheSameGrossAndTaraWeightAsTheLoadUnit(String keyTransaction, String keyLoadUnit) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(keyLoadUnit);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNotNull(loadUnit), 
        () -> assertEquals(transaction.getWtGrossTgt(), loadUnit.getWtGross()),
        () -> assertEquals(transaction.getWtTareTgt(), loadUnit.getWtTare()));
    //@formatter:on
  }

  /**
   * Verifies that location is occupied
   * 
   * @param percantageOccupied
   *          expected occupation
   */
  @Then("storage location {string}-{string} is {double} percent occupied")
  @Transactional(readOnly = true)
  public void verifyTargetLocationIsOccupied(String area, String location, Double percantageOccupied) {
    TopVStorageLocation targetLocation = storageLocationRep.findOne(new TopVStorageLocationPk(generalHelper.getIdSite(), area, location));

    //@formatter:off
    assertAll(
        () -> assertNotNull(targetLocation), 
        () -> assertEquals(percantageOccupied, targetLocation.getPctOccupied())
        );
    if(percantageOccupied == 0.0) {
      assertEquals("00", targetLocation.getStatOccupied());
    }else {
      assertEquals("90", targetLocation.getStatOccupied());
    }
    //@formatter:on
  }

  /**
   * Verifies that target load unit is occupied
   * 
   * @param percantageOccupied
   *          expected occupation
   */
  @Then("target load unit {string} is {double} percent occupied")
  @Transactional(readOnly = true)
  public void verifyTargetLoadUnitIsOccupied(String key, Double percantageOccupied) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    //@formatter:off
    assertAll(
        () -> assertNotNull(loadUnit), 
        () -> assertEquals(percantageOccupied, loadUnit.getPctOccupied())
        );
    //@formatter:on
  }

  /**
   * Verifies that location has remaining capacity
   * 
   * @param remainingCapacity
   *          expected remaining capacity
   */
  @Then("storage location {string}-{string} has remaining capacity {double}")
  @Transactional(readOnly = true)
  public void verifyTargetLocationHasRemainingCapacity(String area, String location, Double remainingCapacity) {
    TopVStorageLocation targetLocation = storageLocationRep.findOne(new TopVStorageLocationPk(generalHelper.getIdSite(), area, location));

    //@formatter:off
    assertAll(
        () -> assertNotNull(targetLocation), 
        () -> assertEquals(remainingCapacity, targetLocation.getNumRemainingCapacity())
        );
    //@formatter:on
  }

  /**
   * Verifies that in load unit stacks a record for the given load unit exits
   *
   */
  @Then("Verify that the load unit {string} has three level")
  @Transactional(readOnly = true)
  public void verifySelectedLoadUnitStack3Level(String key) {
    List<ImLoadUnitStack> loadUnitStackList = readLoadUnitStackLv1(inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu());

    for (ImLoadUnitStack loadUnitStack : loadUnitStackList) {
      if (loadUnitStack != null && loadUnitStack.getIdLu3() != null) {
        assertNotNull(loadUnitStack);
        assertNotNull(loadUnitStack.getIdLu3());
      }
    }
  }

  /**
   * Verifies that in load unit stacks a record for the load unit exits
   * 
   */
  @Then("Verify that a load unit stack record for the load unit {string} exits")
  @Transactional(readOnly = true)
  public void verifySelectedLoadUnitStackRecord(String key) {
    ImLoadUnitStack loadUnitStack = readLoadUnitStack(inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu());
    assertNotNull(loadUnitStack);
  }

  /**
   * Verifies that the load unit stack of the given load unit has no level 3
   * 
   */
  @Then("verify that the load unit stack of the load unit {string} has no level 3")
  @Transactional(readOnly = true)
  public void verifySelectedLoadUnitStackNoLvl3(String key) {
    List<ImLoadUnitStack> loadUnitStackList = readLoadUnitStackLv1(inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu());

    for (ImLoadUnitStack loadUnitStack : loadUnitStackList) {
      assertNotNull(loadUnitStack);
      assertNull(loadUnitStack.getIdLu3());
    }
  }

  /**
   * Verifies that all load unit stacks within the current transaction group are booked out
   */
  @Then("all load unit stacks within {string} transaction group are booked out")
  @Transactional(readOnly = true)
  public void bookedOutAllLuStacks(String keyTransaction) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {

      if (actTransaction.getIdLu1Src() != null) {
        ImLoadUnitStack loadUnitStack = readLoadUnitStack(actTransaction.getIdLu1Src());
        assertNull(loadUnitStack);
      }
      if (actTransaction.getIdLu2Src() != null) {
        ImLoadUnitStack loadUnitStack = readLoadUnitStack(actTransaction.getIdLu2Src());
        assertNull(loadUnitStack);
      }
      if (actTransaction.getIdLu3Src() != null) {
        ImLoadUnitStack loadUnitStack = readLoadUnitStack(actTransaction.getIdLu3Src());
        assertNull(loadUnitStack);
      }
    }
  }

  /**
   * Verifies that top lu is stacked on bottom lu
   *
   * @param keyTopLu
   * 
   * @param keyBottomLu
   * 
   */
  @Then("Verify that the load unit {string} IdLu2 is stacked on the load unit {string} IdLu1")
  @Transactional(readOnly = true)
  public void verifylu2stackedlu1(String keyTopLu, String keyBottomLu) {
    String topLuId = inventoryDataHandler.getLoadUnit(keyTopLu).getImLoadUnitPk().getIdLu();
    String bottomLuId = inventoryDataHandler.getLoadUnit(keyBottomLu).getImLoadUnitPk().getIdLu();
    ImLoadUnitStack loadUnitStack = readLoadUnitStack(topLuId);

    assertNotNull(loadUnitStack);
    assertEquals(bottomLuId, loadUnitStack.getIdLu1());
    assertEquals(topLuId, loadUnitStack.getIdLu2());
  }

  /**
   * Verifies that top lu is stacked on bottom lu
   *
   * @param keyTopLu
   * 
   * @param keyBottomLu
   * 
   */
  @Then("Verify that the load unit {string} IdLu3 is stacked on the load unit {string} IdLu2")
  @Transactional(readOnly = true)
  public void verifylu3stackedlu2(String keyTopLu, String keyBottomLu) {
    String topLuId = inventoryDataHandler.getLoadUnit(keyTopLu).getImLoadUnitPk().getIdLu();
    String bottomLuId = inventoryDataHandler.getLoadUnit(keyBottomLu).getImLoadUnitPk().getIdLu();
    ImLoadUnitStack loadUnitStack = readLoadUnitStack(topLuId);

    assertNotNull(loadUnitStack);
    assertEquals(bottomLuId, loadUnitStack.getIdLu2());
    assertEquals(topLuId, loadUnitStack.getIdLu3());
  }

  /**
   * Verifies that the given load unit is stacked
   * 
   * unused
   */
  @Then("Verify that the load unit {string} is stacked")
  @Transactional(readOnly = true)
  public void verifyLoadUnitIsStacked(String key) {
    ImLoadUnitStack loadUnitStack = readLoadUnitStack(inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu());
  //@formatter:off
    assertAll(
        () -> assertNotNull(loadUnitStack), 
        () -> assertEquals(inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), loadUnitStack.getIdLu2())
        );
    //@formatter:on

  }

  /**
   * verifies the status of the given load unit
   * 
   * @param status
   *          expected status
   */
  @Then("the status of the load unit {string} is {string}")
  @Transactional(readOnly = true)
  public void verifySelectedLuStatus(String key, String status) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);

    //@formatter:off
    assertAll(
        () -> assertNotNull(loadUnit), 
        () -> assertEquals(status, loadUnit.getStatOccupied()));
    //@formatter:on
  }

  /**
   * Relocate the selected load unit
   * 
   * @param key
   * 
   * @param storageAreaTgt
   * 
   * @param StorageLocationTgt
   * 
   */
  @Given("the load unit {string} has to be relocated to {string}-{string}")
  public void relocateSelectedLu(String key, String storageAreaTgt, String StorageLocationTgt) {
    transportWebserviceCaller.relocateSelectedLu(storageAreaTgt, StorageLocationTgt,
        inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu());
  }

  /**
   * Verifies that the load unit of the quantum has given gross weight
   * 
   * @param weight
   *          weight
   */
  @Then("load unit {string} has gross weight {double}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitGrossWeight(String key, Double weight) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(key);
    assertEquals(weight, loadUnit.getWtGross());
  }

  /**
   * Verifies that the transaction that was created by the prior webservice call is not referenced by the load unit of the created quantum
   */
  @Then("load unit {string} does not reference transaction {string}")
  @Transactional(readOnly = true)
  public void verifyLoadUnitDoesNotReferenceTransaction(String keyLoadUnit, String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(keyLoadUnit);
    assertNotEquals(transaction, loadUnit.getIdTransaction());
  }

  /**
   * Ensure that the load unit that was created is only read from database if it's necessary.
   * 
   * @return loadUnitStack
   */
  private ImLoadUnitStack readLoadUnitStack(String luId) {
    ImLoadUnitStack loadUnitStack = new ImLoadUnitStack();
    if (luId != null) {
      loadUnitStack = loadUnitStackRep.findOne(new ImLoadUnitStackPk(generalHelper.getIdSite(), luId));
    }
    return loadUnitStack;
  }

  /**
   * Ensure that the load unit that was created is only read from database if it's necessary.
   * 
   * @return loadUnitStack
   */
  private List<ImLoadUnitStack> readLoadUnitStackLv1(String luId) {
    List<ImLoadUnitStack> loadUnitStack = null;
    if (luId != null) {
      loadUnitStack = loadUnitStackRep.findAll((root, query, cb) -> {
        return cb.equal(root.get("idLu1"), luId);
      });
    }
    return loadUnitStack;
  }

}
