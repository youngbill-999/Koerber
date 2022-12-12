package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.article.pers.gen.ArtArticlePk;
import com.inconso.bend.article.pers.model.ArtArticle;
import com.inconso.bend.article.pers.rep.ArtArticleRep;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.gen.ImQuantumPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inventory.pers.rep.ImQuantumRep;
import com.inconso.bend.inventory.service.transaction.api.InventoryCrequInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.FieldExtractor;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.topology.pers.gen.TopStorageLocationPk;
import com.inconso.bend.topology.pers.model.TopStorageLocation;
import com.inconso.bend.topology.pers.rep.TopStorageLocationRep;
import com.inconso.bend.wmsbase.pers.gen.WbClientPk;
import com.inconso.bend.wmsbase.pers.model.WbClient;
import com.inconso.bend.wmsbase.pers.rep.WbClientRep;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class CreQuHandler {

  private static final String         ID_SITE = "RL1";

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  @Autowired
  private TransactionHelper           transactionHelper;

  @Autowired
  private TopStorageLocationRep       locationRep;

  @Autowired
  private ImQuantumRep                imQuantumRep;

  @Autowired
  private ImLoadUnitRep               imLoadUnitRep;

  @Autowired
  private WbClientRep                 clientRep;

  @Autowired
  private ArtArticleRep               articleRep;

  private InventoryCrequInput.Builder crequInputBuilder;

  /**
   * Set H01-KLAER/K-101 with site requirement cooling for dessert
   */
  @Before("@coolingClearing")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void coolingClearing() {
    TopStorageLocation location = locationRep.findOne(new TopStorageLocationPk(ID_SITE, "H01-KLAER", "K-101"));
    location.setSiteRequirement3("TR<+5");
  }

  /**
   * Set H01-KLAER/K-101 with site requirement cooling for dessert
   */
  @After("@coolingClearing")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void uncoolingClearing() {
    TopStorageLocation location = locationRep.findOne(new TopStorageLocationPk(ID_SITE, "H01-KLAER", "K-101"));
    location.setSiteRequirement3(null);
  }

  /**
   * Set reg exp for client 1 sep crit 1 to number
   */
  @Before("@rk1_sepcrit1_regexp_number")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void sepCrit1WithRegExpNumber() {
    WbClient client = clientRep.findOne(new WbClientPk("RK1"));
    client.setSepCrit01IdRegExp("NUMBER");
  }

  /**
   * clear reg exp for client 1 sep crit 1 to number
   */
  @After("@rk1_sepcrit1_regexp_number")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void sepCrit1WithNoRegExp() {
    WbClient client = clientRep.findOne(new WbClientPk("RK1"));
    client.setSepCrit01IdRegExp(null);
  }

  /**
   * Set reg exp for client 1 sep crit 1 to number
   */
  @Before("@rk1_sepcrit1_no_default")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void sepCrit1WithoutDefault() {
    WbClient client = clientRep.findOne(new WbClientPk("RK1"));
    client.setSepCrit01DefaultValue(null);
  }

  /**
   * clear reg exp for client 1 sep crit 1 to number
   */
  @After("@rk1_sepcrit1_no_default")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void sepCrit1WithDefault() {
    WbClient client = clientRep.findOne(new WbClientPk("RK1"));
    client.setSepCrit01DefaultValue("0011");
  }

  @Before("@rk1_collegeblock_inactive")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void articleCollegeblockInactive() {
    ArtArticle article = articleRep.findOne(new ArtArticlePk("RK1", "40067005"));
    article.setStat("90");
  }

  @After("@rk1_collegeblock_inactive")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void articleCollegeblockActive() {
    ArtArticle article = articleRep.findOne(new ArtArticlePk("RK1", "40067005"));
    article.setStat("10");
  }

  /**
   * Prepares the input for a webservie call of transaction type CREQU with the given values.
   * 
   * @param storageAreaSrc
   *          source storage area
   * @param storageLocationSrc
   *          source storage location
   * @param qty
   *          free qty of new quantum
   * @param idArticle
   *          id of article
   */
  @Given("a quantum from storage location {string}-{string} with {double} pieces of article {string} has to be created")
  public void createQuInput(String storageAreaSrc, String storageLocationSrc, Double qty, String idArticle) {
    crequInputBuilder = new InventoryCrequInput.Builder(generalHelper.getIdSite(), //
        "DIALOG", "IM400", "*", //
        generalHelper.getIdClient(), "*", idArticle, qty, //
        storageAreaSrc, storageLocationSrc, "AUTO_IT");
    if ("RK1".equals(generalHelper.getIdClient())) {
      crequInputBuilder.build().setSepCrit03(RandomStringUtils.randomNumeric(9));
    }
  }

  /**
   * set the seperation criteria
   * 
   * @param sepCrit
   * 
   */
  @Given("the third separation criterion is {string}")
  public void setTheSeperationCriteria(String sepCrit) {
    crequInputBuilder.build().setSepCrit03(sepCrit);
  }

  /**
   * Prepares the input for a webservie call of transaction type CREQU with the given values an no quantity
   * 
   * @param storageAreaSrc
   *          source storage area
   * @param storageLocationSrc
   *          source storage location
   * @param idArticle
   *          id of article
   */
  @Given("a quantum from storage location {string}-{string} with no pieces of article {string} has to be created")
  public void createQuInputWithoutQty(String storageAreaSrc, String storageLocationSrc, String idArticle) {
    crequInputBuilder = new InventoryCrequInput.Builder(generalHelper.getIdSite(), //
        "DIALOG", "IM400", "*", //
        generalHelper.getIdClient(), "*", idArticle, null, //
        storageAreaSrc, storageLocationSrc, "AUTO_IT");
    crequInputBuilder.withSepCriterias(null, null, "123456", null, null, null, null, null, null, null);
  }

  @Given("the target location is {string}-{string}")
  public void setTgtLocation(String storageAreaTgt, String storageLocationTgt) {
    crequInputBuilder.withStorageLocationTgt(storageAreaTgt, storageLocationTgt);
  }

  @Given("the target load unit is {string}")
  public void setTgtLoadUnit(String loadUnit) {
    crequInputBuilder.withTargetLu(loadUnit, null, null, null);
  }

  @Given("the load unit {string} is the target")
  public void setRememberedTgtLoadUnit(String key) {
    crequInputBuilder.withTargetLu(inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu(), null, null, null);
  }

  @Given("the artvar is {string} and stock type is {string} and lock type is {string} and QC status is {string} and customs status is {string}")
  public void setStockCriteria(String artvar, String typStock, String typLock, String qcStat, String custStat) {
    crequInputBuilder.withTypAndStat(artvar, typStock, typLock, qcStat, custStat);
  }

  @Given("the CREQU reasons are {string}-{string}")
  public void setCrequReasons(String reason1, String reason2) {
    crequInputBuilder.withReasonTransaction(reason1, reason2);
  }

  @Given("BBD is {Date} and batch is {String}")
  public void setBBDAndBatch(Date tsBbd, String batch) throws ParseException {
    if (batch != null && !"".equals(batch)) {
      batch = inventoryDataHandler.getBatchName(batch);
    }

    crequInputBuilder.withIdBatchOrBestBeforeDate(batch, tsBbd);
  }

  @Given("goods receipt is {string}-{string} with incoming date {Date}")
  public void setGoodsReceipt(String idGoodsReceipt, String b, Date tsGoodsReceipt) throws ParseException {
    crequInputBuilder.withGoodsReceipt(idGoodsReceipt, Long.parseLong(b), tsGoodsReceipt);
  }

  @Given("special stock type is {string} and ID special stock is {string}")
  public void setSpecialStock(String specialStockType, String specialStockId) throws ParseException {
    crequInputBuilder.withSpecialStock(specialStockType, specialStockId);
  }

  @Given("CREQU input has: goodsReceipt = {String}, goodsReceiptItem = {Long}, tsGoodsReceipt = {Date}")
  public void crequInputHasGoodsReceipt(String idGoodsReceipt, Long item, Date tsGoodsReceipt) {
    crequInputBuilder.withGoodsReceipt(idGoodsReceipt, item, tsGoodsReceipt);
  }

  @Given("the CREQU input has attributes: {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}")
  public void theCREQUInputHasAttributes(String a01, String a02, String a03, String a04, String a05, String a06, String a07, String a08, String a09,
      String a10, String a11, String a12, String a13, String a14, String a15, String a16, String a17, String a18, String a19, String a20) {
    crequInputBuilder.withAttributes(a01, a02, a03, a04, a05, a06, a07, a08, a09, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
  }

  /**
   * Adds the given references to the input for the webservice call of transaction type CREQU
   * 
   * @param refType
   *          reference type
   * @param idRef1
   *          part 1 of ref key
   * @param idRef2
   *          part 1 of ref key
   */
  @And("the CREQU reference type is {string} with id {string}-{string}")
  public void setReferences(String refType, String idRef1, String idRef2) {
    if (crequInputBuilder != null) {
      crequInputBuilder.withTypRefAndId(refType, idRef1, idRef2);
    }
  }

  /**
   * Sets the given parameters for determination of a situation to the input for the webservice call of transaction type CREQU
   * 
   * @param clProcess
   *          process class
   * @param typProcess
   *          process type
   * @param stepProcess
   *          process step
   */
  @And("the CREQU situation parameters are {string}, {string}, {string}")
  public void setSituationParams(String clProcess, String typProcess, String stepProcess) {
    if (crequInputBuilder != null) {
      String idClient = crequInputBuilder.build().getIdClient();
      String idArticle = crequInputBuilder.build().getIdArticle();
      Double qty = crequInputBuilder.build().getQtyMoved();
      String storageAreaSrc = crequInputBuilder.build().getStorageAreaSrc();
      String storageLocationSrc = crequInputBuilder.build().getStorageLocationSrc();
      crequInputBuilder = new InventoryCrequInput.Builder(generalHelper.getIdSite(), //
          clProcess, // clProcess
          typProcess, // typProcess
          stepProcess, // stepProcess
          idClient, "*", idArticle, qty, //
          storageAreaSrc, storageLocationSrc, "AUTO_IT");
    }
  }

  @And("the sep crit 10 is {string}")
  public void setSepCrit10(String sepCrit10) {
    if (crequInputBuilder != null) {
      crequInputBuilder.withSepCriterias(null, null, null, null, null, null, null, null, null, sepCrit10);
    }
  }

  @And("the sep crit 1 is {string}")
  public void setSepCrit1(String sepCrit1) {
    if (crequInputBuilder != null) {
      crequInputBuilder.withSepCriterias(sepCrit1, null, null, null, null, null, null, null, null, null);
    }
  }

  /**
   * Call CREQU transaction
   */
  @When("CREQU is called")
  public void crequIsCalled() {
    // build up the input - in the general part for the moment just the user
    ServiceInput<InventoryCrequInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryCrequInput input = crequInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.CREQU_EP, inputService);
  }

  /**
   * Verifies that the prior webservice call was successful and stores the relevant outpur for future verifications.
   * 
   */
  @When("CREQU was successful, saved as {string}; transaction saved as {string}")
  @Transactional(readOnly = true)
  public void crequSuccessful(String keyQuantum, String keyTransaction) {
    transactionHelper.transactionSuccessful(keyTransaction);
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    String idQuantum = payload.getString("idQuantum");
    ImQuantum quantum = imQuantumRep.findOne(new ImQuantumPk(generalHelper.getIdSite(), idQuantum));
    inventoryDataHandler.putQuantum(keyQuantum, quantum);
  }

  /**
   * Verifies that the quantum is removed
   * 
   */
  @Then("verify quantum {string} is deleted")
  @Transactional(readOnly = true)
  public void verifyQuantumIsRemoved(String key) {
    ImQuantum quantum = inventoryDataHandler.getQuantum(key);
    assertEquals(null, quantum);
  }

  @Then("quantums {string} and {string} have different tsUpd")
  @Transactional(readOnly = true)
  public void updatedAuditFieldsUpd(String key1, String key2) {
    ImQuantum quantum1 = inventoryDataHandler.getQuantum(key1);
    ImQuantum quantum2 = inventoryDataHandler.getQuantum(key2);
    assertNotEquals(quantum1.getTsUpd(), quantum2.getTsUpd());
  }

  /**
   * Verifies that at level x a load unit exits
   */
  @Then("verify load unit exits at level {int} in quantum {string}")
  @Transactional(readOnly = true)
  public void verifyLuLevelExits(int level, String key) {
    ImQuantum quantum = inventoryDataHandler.getQuantum(key);

    switch (level) {
    case 1:
      assertNotNull(quantum.getIdLu1());
      break;
    case 2:
      assertNotNull(quantum.getIdLu2());
      break;
    case 3:
      assertNotNull(quantum.getIdLu3());
      break;
    default:
      throw new IllegalArgumentException();
    }
  }

  /**
   * Verifies that all quanta within the current transaction group are booked out
   */
  @Then("all quanta within the {string} transaction group are booked out")
  @Transactional(readOnly = true)
  public void bookedOutAllQuanta(String keyTransaction) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getIdQuantumSrc() != null) {
        ImQuantum quantum = readQuantum(actTransaction.getIdQuantumSrc());
        assertEquals(null, quantum);
      }
    }
  }

  @Then("quantum {string} has idLu1, saved as {string}")
  @Transactional(readOnly = true)
  public void saveIdLu1OfQuantum(String keyQuantum, String keyLu) {
    ImQuantum quantum = inventoryDataHandler.getQuantum(keyQuantum);
    ImLoadUnit loadUnit = imLoadUnitRep.findOne(new ImLoadUnitPk(quantum.getImQuantumPk().getIdSite(), quantum.getIdLu1()));
    inventoryDataHandler.putLoadUnit(keyLu, loadUnit);
  }

  /**
   * Read ImQuantum from database for given ID.
   * 
   * @return last created quantum
   */
  private ImQuantum readQuantum(String idQuantum) {
    return imQuantumRep.findOne(new ImQuantumPk(generalHelper.getIdSite(), idQuantum));
  }
}
