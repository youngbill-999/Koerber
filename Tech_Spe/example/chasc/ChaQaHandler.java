package com.inconso.bend.inwmsx.it.inventory;

import java.util.Date;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.service.transaction.api.InventoryChaqaInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import org.springframework.beans.factory.annotation.Autowired;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class ChaQaHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  private InventoryChaqaInput.Builder chaqaInputBuilder;

  /**
   * Calls the webservice of transaction type CHAQA
   * 
   */
  @When("CHAQA is called")
  public void chaQaIsCalled() {
    ServiceInput<InventoryChaqaInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryChaqaInput input = chaqaInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.CHAQA_EP, inputService);

  }

  @When("CHAQA is used to change quantum {String} with BBD = {Date}")
  public void changesQuantumBBD(String keyQu, Date tsBbd) {

    Date tsGr = inventoryDataHandler.getQuantum(keyQu).getTsGoodsReceipt();
    String idGr = inventoryDataHandler.getQuantum(keyQu).getIdGoodsReceipt();
    Long numGrItem = inventoryDataHandler.getQuantum(keyQu).getNumGoodsReceiptItem();

    String idQu = null;
    if (keyQu != null) {
      ImQuantum quantumUnit = inventoryDataHandler.getQuantum(keyQu);
      idQu = quantumUnit.getImQuantumPk().getIdQuantum();

    }
    chaqaInputBuilder = new InventoryChaqaInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*", idQu,
        tsBbd, idGr, numGrItem, tsGr, "Basis");
  }

  @When("CHAQA is used to change quantum {String} with BBD = {Date} and GR-Date = {Date}")
  public void createchaqaInputForBBDAndGrDate(String key, Date tsBbd, Date grDate) {

    chaqaInputBuilder = new InventoryChaqaInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        inventoryDataHandler.getQuantum(key).getImQuantumPk().getIdQuantum(), tsBbd, // set as input
        inventoryDataHandler.getQuantum(key).getIdGoodsReceipt(), inventoryDataHandler.getQuantum(key).getNumGoodsReceiptItem(), grDate, "Basis");
  }

  @When("CHAQA is used to change quantum {string} with GR-Date = {Date} and GR = {string}-{Long}")
  public void createchaqaInputForGRAndGRDate(String keyQu, Date grDate, String idGr, Long grItem) {

    Date tsBbd = inventoryDataHandler.getQuantum(keyQu).getTsBbd();
    String idQu = null;

    if (keyQu != null) {

      ImQuantum quantumUnit = inventoryDataHandler.getQuantum(keyQu);
      idQu = quantumUnit.getImQuantumPk().getIdQuantum();
    }
    chaqaInputBuilder = new InventoryChaqaInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*", idQu,
        tsBbd, idGr, grItem, grDate, "Basis");
  }

  @When("CHAQA is used to change quantum {String} with attribute values: {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}")
  public void setChaqaAttributes(String keyQu, String attribute01, String attribute02, String attribute03, String attribute04, String attribute05,
      String attribute06, String attribute07, String attribute08, String attribute09, String attribute10, String attribute11, String attribute12,
      String attribute13, String attribute14, String attribute15, String attribute16, String attribute17, String attribute18, String attribute19,
      String attribute20) {

    Date tsBbd = inventoryDataHandler.getQuantum(keyQu).getTsBbd();
    Date tsGr = inventoryDataHandler.getQuantum(keyQu).getTsGoodsReceipt();
    String idGr = inventoryDataHandler.getQuantum(keyQu).getIdGoodsReceipt();
    Long numGrItem = inventoryDataHandler.getQuantum(keyQu).getNumGoodsReceiptItem();
    String idQu = null;

    if (keyQu != null) {
      ImQuantum quantumUnit = inventoryDataHandler.getQuantum(keyQu);
      idQu = quantumUnit.getImQuantumPk().getIdQuantum();
    }

    chaqaInputBuilder = new InventoryChaqaInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*", idQu,
        tsBbd, idGr, numGrItem, tsGr, "Basis");

    if (chaqaInputBuilder != null) {
      chaqaInputBuilder.withAttributes(attribute01, attribute02, attribute03, attribute04, attribute05, attribute06, attribute07, attribute08,
          attribute09, attribute10, attribute11, attribute12, attribute13, attribute14, attribute15, attribute16, attribute17, attribute18,
          attribute19, attribute20);
    }
  }

  /**
   * Only change idSite of CHAQA input
   */

  @Given("CHAQA input has: idSite = {String}")
  public void setChaqaInputWithGivenSite(String idSite) {
    InventoryChaqaInput tmp = chaqaInputBuilder.build();

    chaqaInputBuilder = new InventoryChaqaInput.Builder(idSite, // set to input
        tmp.getClProcess(), tmp.getTypProcess(), tmp.getStepProcess(), tmp.getIdClient(), tmp.getKey(), tmp.getIdQuantum(), tmp.getTsBbd(),
        tmp.getIdGoodsReceipt(), tmp.getNumGoodsReceiptItem(), tmp.getTsGoodsReceipt(), tmp.getIdUser());
    copyDataToChaqaInputBuilder(tmp);

  }

  @Given("CHAQA input has: clProcess = {String}")
  public void setChaqaInputWithGivenClProcess(String clProcess) {
    InventoryChaqaInput tmp = chaqaInputBuilder.build();

    chaqaInputBuilder = new InventoryChaqaInput.Builder(tmp.getIdSite(), clProcess, // set to input
        tmp.getTypProcess(), tmp.getStepProcess(), tmp.getIdClient(), tmp.getKey(), tmp.getIdQuantum(), tmp.getTsBbd(), tmp.getIdGoodsReceipt(),
        tmp.getNumGoodsReceiptItem(), tmp.getTsGoodsReceipt(), tmp.getIdUser());
    copyDataToChaqaInputBuilder(tmp);

  }

  @Given("CHAQA input has: typProcess = {String}")
  public void setChaqaInputWithGivenTypProcess(String typProcess) {
    InventoryChaqaInput tmp = chaqaInputBuilder.build();

    chaqaInputBuilder = new InventoryChaqaInput.Builder(tmp.getIdSite(), tmp.getClProcess(), typProcess, // set to input
        tmp.getStepProcess(), tmp.getIdClient(), tmp.getKey(), tmp.getIdQuantum(), tmp.getTsBbd(), tmp.getIdGoodsReceipt(),
        tmp.getNumGoodsReceiptItem(), tmp.getTsGoodsReceipt(), tmp.getIdUser());
    copyDataToChaqaInputBuilder(tmp);

  }

  @Given("CHAQA input has: stepProcess = {String}")
  public void setChaqaInputWithGivenStepProcess(String stepProcess) {
    InventoryChaqaInput tmp = chaqaInputBuilder.build();

    chaqaInputBuilder = new InventoryChaqaInput.Builder(tmp.getIdSite(), tmp.getClProcess(), tmp.getTypProcess(), stepProcess, tmp.getIdClient(),
        tmp.getKey(), tmp.getIdQuantum(), tmp.getTsBbd(), tmp.getIdGoodsReceipt(), tmp.getNumGoodsReceiptItem(), tmp.getTsGoodsReceipt(),
        tmp.getIdUser());
    copyDataToChaqaInputBuilder(tmp);

  }

  @Given("CHAQA input has: bookingKey = {String}")
  public void chaqaInputWithGivenBookingKey(String bookingKey) {
    InventoryChaqaInput tmp = chaqaInputBuilder.build();

    chaqaInputBuilder = new InventoryChaqaInput.Builder(tmp.getIdSite(), tmp.getClProcess(), tmp.getTypProcess(), // set to input
        tmp.getStepProcess(), tmp.getIdClient(), bookingKey, tmp.getIdQuantum(), tmp.getTsBbd(), tmp.getIdGoodsReceipt(),
        tmp.getNumGoodsReceiptItem(), tmp.getTsGoodsReceipt(), tmp.getIdUser());
    copyDataToChaqaInputBuilder(tmp);

  }

  @Given("CHAQA input has: idQuantum = {String}")
  public void chaqaInputWithGivenIdQuantum(String idQuantum) {
    InventoryChaqaInput tmp = chaqaInputBuilder.build();

    chaqaInputBuilder = new InventoryChaqaInput.Builder(tmp.getIdSite(), tmp.getClProcess(), tmp.getTypProcess(), tmp.getStepProcess(),
        tmp.getIdClient(), tmp.getKey(), idQuantum, // set to input
        tmp.getTsBbd(), tmp.getIdGoodsReceipt(), tmp.getNumGoodsReceiptItem(), tmp.getTsGoodsReceipt(), tmp.getIdUser());
    copyDataToChaqaInputBuilder(tmp);

  }

  @Given("CHAQA input has: idUser = {String}")
  public void chaqaInputWithGivenidUser(String idUser) {
    InventoryChaqaInput tmp = chaqaInputBuilder.build();

    chaqaInputBuilder = new InventoryChaqaInput.Builder(tmp.getIdSite(), tmp.getClProcess(), tmp.getTypProcess(), tmp.getStepProcess(),
        tmp.getIdClient(), tmp.getKey(), tmp.getIdQuantum(), tmp.getTsBbd(), tmp.getIdGoodsReceipt(), tmp.getNumGoodsReceiptItem(),
        tmp.getTsGoodsReceipt(), idUser); // set to input
    copyDataToChaqaInputBuilder(tmp);

  }

  @When("CHAQA input has: clProcess = {string}, typProcess = {string}, stepProcess = {string}, client = {string}, bookingKey= {string}")
  public void setChaqaProperties(String clProcess, String typProcess, String stepProcess, String client, String bookingKey) {
    InventoryChaqaInput tmp = chaqaInputBuilder.build();
    chaqaInputBuilder = new InventoryChaqaInput.Builder(tmp.getIdSite(), //
        clProcess, // set to input
        typProcess, // set to input
        stepProcess, // set to input
        client, // set to input
        bookingKey, //
        tmp.getIdQuantum(), //
        tmp.getTsBbd(), //
        tmp.getIdGoodsReceipt(), tmp.getNumGoodsReceiptItem(), tmp.getTsGoodsReceipt(), tmp.getIdUser()
    //
    );
    copyDataToChaqaInputBuilder(tmp);
  }

  @When("CHAQA input has: reason1 = {string}, reason2 = {string}")
  public void setchaqaReason1Reason2(String reason1, String reason2) {
    if (chaqaInputBuilder != null) {
      chaqaInputBuilder.withReasonTransaction(reason1, reason2);
    }

  }

  @When("CHAQA input has: typRef = {String}, idRef1 = {String}, idRef2 = {String}, idRef3 = {String}, idRef4 = {String}, idRef5 = {String}, idRef6 = {String}")
  public void setChaqaReferencesTypesAndIds(String typRef, String idRef1, String idRef2, String idRef3, String idRef4, String idRef5, String idRef6) {
    if (chaqaInputBuilder != null) {
      chaqaInputBuilder.withTypRefAndId(typRef, idRef1, idRef2, idRef3, idRef4, idRef5, idRef6);
    }
  }

  private void copyDataToChaqaInputBuilder(InventoryChaqaInput tmp) {
    chaqaInputBuilder.withReasonTransaction(tmp.getReasonTransaction1(), tmp.getReasonTransaction2());
    chaqaInputBuilder.withStorageLocationSrc(tmp.getStorageAreaSrc(), tmp.getStorageLocationSrc());
    chaqaInputBuilder.withTypRefAndId(tmp.getTypRef(), tmp.getIdRef1(), tmp.getIdRef2(), tmp.getIdRef3(), tmp.getIdRef4(), tmp.getIdRef5(),
        tmp.getIdRef6());
    chaqaInputBuilder.withStorageLocationTgt(tmp.getStorageAreaTgt(), tmp.getStorageLocationTgt());
    chaqaInputBuilder.withAttributes(tmp.getAttribute01(), tmp.getAttribute02(), tmp.getAttribute03(), tmp.getAttribute04(), tmp.getAttribute05(),
        tmp.getAttribute06(), tmp.getAttribute07(), tmp.getAttribute08(), tmp.getAttribute09(), tmp.getAttribute10(), tmp.getAttribute11(),
        tmp.getAttribute12(), tmp.getAttribute13(), tmp.getAttribute14(), tmp.getAttribute15(), tmp.getAttribute16(), tmp.getAttribute17(),
        tmp.getAttribute18(), tmp.getAttribute19(), tmp.getAttribute20());
  }

}