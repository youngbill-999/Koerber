package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.inconso.bend.core.config.BendCoreTextCodes;
import com.inconso.bend.core.exception.BendException;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitIdRangePk;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImLoadUnitIdRange;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitIdRangeRep;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inventory.pers.rep.ImQuantumRep;
import com.inconso.bend.inventory.service.api.InventoryDesc;
import com.inconso.bend.inventory.service.api.InventoryLuClosedInput;
import com.inconso.bend.inventory.service.api.InventoryLuCodedInput;
import com.inconso.bend.inventory.service.api.InventoryPrintLblInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryCreluInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryCrequInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryRelluInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryRelquInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.FieldExtractor;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.print.pers.rep.PrtReprintRep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class InventoryWebserviceCaller {

  private String               recentlyCreatedLUId;
  private boolean              isLuCoded;

  @Autowired
  private WebserviceClient     webserviceClient;

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private ImLoadUnitRep        imLoadUnitRep;

  @Autowired
  private ImLoadUnitIdRangeRep imLoadUnitIdRangeRep;

  @Autowired
  private ImQuantumRep         imQuantumRep;

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private TransactionHelper    transactionHelper;

  @And("storage location {string}-{string} is empty")
  @Transactional(readOnly = true)
  public void setStorageLocationEmpty(String storageArea, String storageLocation) {
    // Find all load unit at location and move to senke
    List<ImLoadUnit> loadUnit = imLoadUnitRep.findByIdSiteAndLocAndArea(generalHelper.getIdSite(), storageArea, storageLocation);
    for (ImLoadUnit imLoadUnit : loadUnit) {
      InventoryRelluInput relluInput = new InventoryRelluInput.Builder(generalHelper.getIdSite(), "*", // clProcess
          "*", // typProcess
          "*", // stepProcess
          "*", // key
          imLoadUnit.getImLoadUnitPk().getIdLu(), "AUTO_IT").withStorageLocationTgt("SENKE-LAG", "S-001")
              .withReasonTransaction("Cleaning Location", storageArea + " : " + storageLocation).build();
      // build up the input - in the general part for the moment just the user
      ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
      inputService.setContext("SITE", generalHelper.getIdSite());
      inputService.setData(relluInput);
      webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);
    }

    List<ImQuantum> quanta = imQuantumRep.findByIdSiteAndLocationAndArea(generalHelper.getIdSite(), storageLocation, storageArea);
    for (ImQuantum quantum : quanta) {
      InventoryRelquInput relquInput = new InventoryRelquInput.Builder(generalHelper.getIdSite(), "*", // clProcess
          "*", // typProcess
          "*", // stepProcess
          quantum.getIdClient(), "*", // key
          quantum.getImQuantumPk().getIdQuantum(), "AUTO_IT").withStorageLocationTgt("SENKE-LAG", "S-001")
              .withReasonTransaction("Cleaning Location", storageArea + " : " + storageLocation).build();
      // build up the input - in the general part for the moment just the user
      ServiceInput<InventoryRelquInput> inputService = new ServiceInput<>();
      inputService.setContext("SITE", generalHelper.getIdSite());
      inputService.setData(relquInput);
      webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELQU_EP, inputService);
    }
  }

  /**
   * Calls CREQU with the given input values and verifies that the call returns successfully
   * 
   * @param qty
   *          input quantity
   * @param idArticle
   *          input article id
   * @param artvar
   *          input article variant
   * @param storageAreaTgt
   *          input target storage area
   * @param storageLocationTgt
   *          input target storage location
   * @param sepCrit01
   *          first separation criterion
   * @param sepCrit02
   *          second separation criterion
   * @param sepCrit03
   *          third separation criterion
   * @param sepCrit04
   *          fourth separation criterion
   */
  @When("Create Quantum {double} times article {string} in artvar {string} in area {string} at location {string} with separation criteria {string}-{string}-{string}-{string}")
  public void createQuantum(Double qty, String idArticle, String artvar, //
      String storageAreaTgt, String storageLocationTgt, //
      String sepCrit01, String sepCrit02, String sepCrit03, String sepCrit04) {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryCrequInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryCrequInput input = new InventoryCrequInput.Builder(generalHelper.getIdSite(), "DIALOG", // clProcess
        "IM400", // typProcess
        "CREQU", // stepProcess
        generalHelper.getIdClient(), "*", // key
        idArticle, qty, //
        "QUELLE-LAG", "Q-001", // Quelle
        "AUTO_IT").withTypAndStat(artvar, "AV", "------", "00", "00")
            .withSepCriterias(sepCrit01, sepCrit02, sepCrit03, sepCrit04, null, null, null, null, null, null)
            .withStorageLocationTgt(storageAreaTgt, storageLocationTgt).build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.CREQU_EP, inputService);
    Map<String, Object> result = webserviceClient.verifySuccess().getData();
    // (String) result.get("idQuantum");
  }

  /**
   * Calls CRELU with the given input values and verifies that the call returns successfully
   * 
   * @param typLU
   *          requested load unit type
   * @param storageAreaTgt
   *          specified target storage area
   * @param storageLocationTgt
   *          specied target storage loaction
   */
  @When("Create Load Unit with type {string} in area {string} at location {string}")
  public void createLU(String typLU, //
      String storageAreaTgt, String storageLocationTgt) {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryCreluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryCreluInput input = new InventoryCreluInput.Builder(generalHelper.getIdSite(), "DIALOG", // clProcess
        "IM400", // typProcess
        "CRELU", // stepProcess
        "*", // key
        "QUELLE-LAG", "Q-001", // Quelle
        storageAreaTgt, storageLocationTgt, "AUTO_IT").withTypLu(typLU).build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.CRELU_EP, inputService);
    Map<String, Object> data = webserviceClient.verifySuccess().getData();
    recentlyCreatedLUId = (String) data.get("idLu");
  }

  /**
   * Calls RELLU with the given input values and verifies that the call returns successfully
   * 
   * @param storageArea
   *          specified target storage area
   * @param storageLocation
   *          specified target storage location
   */
  @When("Move Load Unit area {string} at location {string}")
  public void moveLoadUnitAreaAtLocation(String storageArea, String storageLocation) {
    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    // @formatter:off
    InventoryRelluInput input = new InventoryRelluInput.Builder(
        generalHelper.getIdSite(),
        "DIALOG",//clProcess
        "IM400",//typProcess
        "RELLU",//stepProcess
        "*",//key
        recentlyCreatedLUId,
        "AUTO_IT")
            .withStorageLocationTgt(storageArea, storageLocation)
            .build();
    // @formatter:on
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);
    webserviceClient.verifySuccess();
  }

  @And("delete quantum {string}")
  public void deleteQuantum(String keyQuantum) {
    String idQu = inventoryDataHandler.getQuantum(keyQuantum).getImQuantumPk().getIdQuantum();
    InventoryRelquInput.Builder relquInputBuilder = new InventoryRelquInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*",
        generalHelper.getIdClient(), "*", idQu, "CLEAN_IT").withStorageLocationTgt("SENKE-LAG", "S-001");
    ServiceInput<InventoryRelquInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelquInput input = relquInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELQU_EP, inputService);
  }

  @And("delete load unit {string}")
  public void deleteLoadUnit(String keyLoadUnit) {
    String idLu = inventoryDataHandler.getLoadUnit(keyLoadUnit).getImLoadUnitPk().getIdLu();
    InventoryRelluInput.Builder relluInputBuilder = new InventoryRelluInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", "*", idLu,
        "CLEAN_IT").withStorageLocationTgt("SENKE-LAG", "S-001");

    ServiceInput<InventoryRelluInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryRelluInput input = relluInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.RELLU_EP, inputService);
  }

  // TODO: Parameterize true / false
  @When("LU_CODED is called with {string} should return {string}")
  public void luCODEDIsCalledTheShouldReturnTrue(String luType, String result) {

    ServiceInput<InventoryLuCodedInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    InventoryLuCodedInput input = new InventoryLuCodedInput();
    input.setTypLu(luType);
    input.setIdSite(generalHelper.getIdSite());
    inputService.setData(input);

    webserviceClient.call(InventoryDesc.SERVICE, InventoryDesc.CHECK_LU_CODED_EP, inputService);
    assertEquals(result, (webserviceClient.verifySuccess().getData().get("isLuCoded").toString()));
  }

  // Throw Exeception when a given luType does not exist

  @When("LU_CODED is called with {string} throws an exception {string}")
  public void luTypNotExisting(String luType, String exCode) {

    ServiceInput<InventoryLuCodedInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    InventoryLuCodedInput input = new InventoryLuCodedInput();
    input.setTypLu(luType);
    input.setIdSite(generalHelper.getIdSite());
    inputService.setData(input);

    webserviceClient.call(InventoryDesc.SERVICE, InventoryDesc.CHECK_LU_CODED_EP, inputService);
    assertEquals(exCode, webserviceClient.verifySuccess().getErrorCode());

  }

  // TODO: Capitals for webservice constant (LU_CLOSED), result parameterized, renaming "string" variable to reflect actual content
  @When("LU_Closed is called the {string} should return true if load unit is closed")
  public void luClosedIsCalledTheShouldReturnTrueIfLoadUnitIsClosed(String string) {
    ServiceInput<InventoryLuCodedInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryLuCodedInput input = new InventoryLuCodedInput();
    input.setTypLu(string);
    input.setIdSite(generalHelper.getIdSite());
    inputService.setData(input);
    webserviceClient.call(InventoryDesc.SERVICE, InventoryDesc.CHECK_LU_CLOSED_EP, inputService);
    assertEquals(true, (boolean) (webserviceClient.verifySuccess().getData().get("isLuClosed")));
  }

  @When("LU_CLOSED is called with {String} to check for closed load units should return {string}")
  public void checkIsLuClosed(String typeLu, String result) {
    boolean mybool = Boolean.parseBoolean(result);
    ServiceInput<InventoryLuClosedInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    InventoryLuClosedInput input = new InventoryLuClosedInput();
    input.setIdSite(generalHelper.getIdSite());
    input.setTypLu(typeLu);

    inputService.setData(input);
    webserviceClient.call(InventoryDesc.SERVICE, InventoryDesc.CHECK_LU_CLOSED_EP, inputService);
    webserviceClient.verifySuccess();

    assertEquals(mybool, (boolean) webserviceClient.getData().get("isLuClosed"));
  }

  @When("LU_CLOSED is called with {string} to check for not closed load units should return {string}")
  public void checkIsLuNotClosed(String typeLu, String result) {
    boolean mybool = Boolean.parseBoolean(result);
    ServiceInput<InventoryLuClosedInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    InventoryLuClosedInput input = new InventoryLuClosedInput();
    input.setIdSite(generalHelper.getIdSite());
    input.setTypLu(typeLu);
    inputService.setData(input);
    webserviceClient.call(InventoryDesc.SERVICE, InventoryDesc.CHECK_LU_CLOSED_EP, inputService);
    webserviceClient.verifySuccess();

    assertEquals(mybool, webserviceClient.getData().get("isLuClosed"));
  }

  @When("LU_CLOSED is called with {string} should return {string}")
  public void checkIsLuClosedNOTExist(String typeLu, String idException) {

    ServiceInput<InventoryLuClosedInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    InventoryLuClosedInput input = new InventoryLuClosedInput();
    input.setIdSite(generalHelper.getIdSite());
    input.setTypLu(typeLu);
    inputService.setData(input);
    webserviceClient.call(InventoryDesc.SERVICE, InventoryDesc.CHECK_LU_CLOSED_EP, inputService);
    String errorCode = webserviceClient.getErrorCode();
    assertEquals(idException, webserviceClient.getErrorCode());

  }

  // BeiYu_Task2_Printing
  @When("PRINT_PID_LBL is used to print PID label for Load Unit {string} with document IM_PID_LBL")
  @Transactional(readOnly = true)
  public void printTestLu(String lu) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(lu);
    assertNotNull(loadUnit);

    ServiceInput<InventoryPrintLblInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    InventoryPrintLblInput inputWebService = new InventoryPrintLblInput();
    inputWebService.setIdSite(generalHelper.getIdSite());
    inputWebService.setTypLU(loadUnit.getTypLu());
    inputWebService.setIdTerminal("IPC7301");
    inputWebService.setIdLu(loadUnit.getImLoadUnitPk().getIdLu());

    inputService.setData(inputWebService);
    webserviceClient.call(InventoryDesc.SERVICE, InventoryDesc.PRINT_PID_LBL, inputService);
    webserviceClient.verifySuccess();

  }

}
