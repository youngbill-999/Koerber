package com.inconso.bend.inwmsx.it.inventory;

import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.service.transaction.api.InventoryChalaInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import org.springframework.beans.factory.annotation.Autowired;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class ChaLaHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  private InventoryChalaInput.Builder chalaInputBuilder;

  /**
   * Create input for a CHALA booking with SSCC and height
   */
  @When("CHALA is used to change load unit {string} with SSCC = {String} and height = {Double}")
  public void setchalaIInputparameters(String idLu, String sscc, Double height) {

    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(idLu);

    chalaInputBuilder = new InventoryChalaInput.Builder(generalHelper.getIdSite(), "DIALOG", // clProcess
        "IM400", // typProcess
        "*", // stepProcess
        "*", // key
        loadUnit.getImLoadUnitPk().getIdLu(), "basis", sscc, height);
  }

  /**
   * Calls the webservice of transaction type CHALA
   * 
   */
  @When("CHALA is called")
  public void chalaIsCalled() {
    ServiceInput<InventoryChalaInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    InventoryChalaInput input = chalaInputBuilder.build();
    inputService.setData(input);
    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.CHALA_EP, inputService);

  }

  /**
   * Only change idSite of CHALA input
   */

  @Given("CHALA input has: idSite = {String}")
  public void chalaInputWithGivenSite(String idSite) {
    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(idSite, // set to input
        tmp.getClProcess(), //
        tmp.getTypProcess(), //
        tmp.getStepProcess(), //
        tmp.getKey(), //
        tmp.getIdLu(), //
        tmp.getIdUser(), //
        tmp.getSscc(), //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  /**
   * Only change clProcess of CHALA input
   */

  @Given("CHALA input has: clProcess = {String}")
  public void chalaInputWithGivenClProcess(String clProcess) {
    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), clProcess, // set to input
        tmp.getTypProcess(), //
        tmp.getStepProcess(), //
        tmp.getKey(), //
        tmp.getIdLu(), //
        tmp.getIdUser(), //
        tmp.getSscc(), //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  /**
   * Only change typProcess of CHALA input
   */

  @Given("CHALA input has: typProcess = {String}")
  public void chalaInputWithGivenTypProcess(String typProcess) {
    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), //
        tmp.getClProcess(), //
        typProcess, // set to input
        tmp.getStepProcess(), //
        tmp.getKey(), //
        tmp.getIdLu(), //
        tmp.getIdUser(), //
        tmp.getSscc(), //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  /**
   * Only change stepProcess of CHALA input
   */

  @Given("CHALA input has: stepProcess = {String}")
  public void chalaInputWithGivenStepProcess(String stepProcess) {
    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), //
        tmp.getClProcess(), //
        tmp.getTypProcess(), //
        stepProcess, // set to input
        tmp.getKey(), //
        tmp.getIdLu(), //
        tmp.getIdUser(), //
        tmp.getSscc(), //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  /**
   * Only change bookingKey of CHALA input
   */

  @Given("CHALA input has: bookingKey = {String}")
  public void chalaInputWithGivenBookingKey(String bookingKey) {
    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), //
        tmp.getClProcess(), //
        tmp.getTypProcess(), //
        tmp.getStepProcess(), //
        bookingKey, // set to input
        tmp.getIdLu(), //
        tmp.getIdUser(), //
        tmp.getSscc(), //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  @Given("CHALA input has: idLu = {String}")
  public void chalaInputWithGivenIdLu(String idLu) {
    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), //
        tmp.getClProcess(), //
        tmp.getTypProcess(), //
        tmp.getStepProcess(), //
        tmp.getKey(), idLu, // set to input
        tmp.getIdUser(), //
        tmp.getSscc(), //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  @Given("quantum input has: idLu = {String}")
  public void quantumIdLu(String idLu) {
    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), //
        tmp.getClProcess(), //
        tmp.getTypProcess(), //
        tmp.getStepProcess(), //
        tmp.getKey(), //
        idLu, // set to input
        tmp.getIdUser(), //
        tmp.getSscc(), //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  /**
   * Only change idUser of CHALA input
   */

  @Given("CHALA input has: idUser = {String}")
  public void chalaInputWithGiveIdUser(String idUser) {
    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), //
        tmp.getClProcess(), //
        tmp.getTypProcess(), //
        tmp.getStepProcess(), //
        tmp.getKey(), //
        tmp.getIdLu(), //
        idUser, // set to input
        tmp.getSscc(), //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  @When("CHALA input has: SSCC = {String}")
  public void setChalaInputSSCCNull(String sscc) {

    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), //
        tmp.getClProcess(), //
        tmp.getTypProcess(), //
        tmp.getStepProcess(), //
        tmp.getKey(), //
        tmp.getIdLu(), //
        tmp.getIdUser(), //
        sscc, //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  @When("CHALA input has: height = {Double}")
  public void setChalaInputHeightNull(Double height) {

    InventoryChalaInput tmp = chalaInputBuilder.build();

    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), //
        tmp.getClProcess(), //
        tmp.getTypProcess(), //
        tmp.getStepProcess(), //
        tmp.getKey(), //
        tmp.getIdLu(), //
        tmp.getIdUser(), //
        tmp.getSscc(), //
        height // set to input
    );
    copyDataToChalaInputBuilder(tmp);
  }

  @When("CHALA input has: clProcess = {string}, typProcess = {string}, stepProcess = {string}, client = {string}, bookingKey= {string}")
  public void chalaInputHasClProcessTypProcessStepProcessClientBookingKey(String clProcess, String typProcess, String stepProcess, String client,
      String bookingKey) {
    InventoryChalaInput tmp = chalaInputBuilder.build();
    chalaInputBuilder = new InventoryChalaInput.Builder(tmp.getIdSite(), //
        clProcess, // set to input
        typProcess, // set to input
        stepProcess, // set to input
        bookingKey, // set to input
        tmp.getIdLu(), //
        tmp.getIdUser(), //
        tmp.getSscc(), //
        tmp.getHeight() //
    );
    copyDataToChalaInputBuilder(tmp);
  }

  private void copyDataToChalaInputBuilder(InventoryChalaInput tmp) {
    chalaInputBuilder.withReasonTransaction(tmp.getReasonTransaction1(), tmp.getReasonTransaction2());
    chalaInputBuilder.withStorageLocationSrc(tmp.getStorageAreaSrc(), tmp.getStorageLocationSrc());
    chalaInputBuilder.withTypRefAndId(tmp.getTypRef(), tmp.getIdRef1(), tmp.getIdRef2(), tmp.getIdRef3(), tmp.getIdRef4(), tmp.getIdRef5(),
        tmp.getIdRef6());
    chalaInputBuilder.withStorageLocationTgt(tmp.getStorageAreaTgt(), tmp.getStorageLocationTgt());
  }

  @And("CHALA input has: typRef = {String}, idRef1 = {String}, idRef2 = {String}, idRef3 = {String}, idRef4 = {String}, idRef5 = {String}, idRef6 = {String}")
  public void setChalaReferencesTypesAndIds(String typRef, String idRef1, String idRef2, String idRef3, String idRef4, String idRef5, String idRef6) {
    if (chalaInputBuilder != null) {
      chalaInputBuilder.withTypRefAndId(typRef, idRef1, idRef2, idRef3, idRef4, idRef5, idRef6);
    }
  }

  @When("CHALA input has: reason1 = {string}, reason2 = {string}")
  public void setChalaReasons(String reason1, String reason2) {
    if (chalaInputBuilder != null) {
      chalaInputBuilder.withReasonTransaction(reason1, reason2);
    }
  }

}