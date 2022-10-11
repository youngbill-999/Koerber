package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.doubleThat;
import static org.mockito.ArgumentMatchers.nullable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.ServerProperties.Jetty.Threads;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.gen.ImQuantumPk;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inventory.pers.rep.ImQuantumRep;
import com.inconso.bend.inventory.service.transaction.api.InventoryChascInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.FieldExtractor;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class ChaScHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private TransactionHelper           transactionHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  @Autowired
  private ImQuantumRep                imQuantumRep;

  private InventoryChascInput.Builder chascInputBuilder;

  @When("CHASC is called")
  public void chascIsCalled() {

    ServiceInput<InventoryChascInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    InventoryChascInput input = chascInputBuilder.build();// here get the already generated one from the methods below.

    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.CHASC_EP, inputService);

  }

  @When("CHASC was successful, transaction saved as {string}")
  public void chascSuccess(String keyQuantum, String trans) {
    transactionHelper.transactionSuccessful(trans);

    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    String idQuantum = payload.getString("idQuantum");
    ImQuantum quantum = imQuantumRep.findOne(new ImQuantumPk(generalHelper.getIdSite(), idQuantum));
    inventoryDataHandler.putQuantum(keyQuantum, quantum);
  }

  @When("CHASC is used to change quantum ={string} with stock type ={string} and lock type ={string}")
  public void chascForChangeStockTypAndLockTyp(String Qu, String stockTyp, String lockTyp) {

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(Qu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();

    chascInputBuilder = new InventoryChascInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        imQuantumPk.getIdQuantum(), imQuantum.getQtyAvailable(), "AVAILABLE", imQuantum.getArtvar(), imQuantum.getIdBatch(), stockTyp, lockTyp,
        imQuantum.getTypSpecialStock(), imQuantum.getIdSpecialStock(), imQuantum.getSepCrit01(), imQuantum.getSepCrit02(), imQuantum.getSepCrit03(),
        imQuantum.getSepCrit04(), imQuantum.getSepCrit05(), imQuantum.getSepCrit06(), imQuantum.getSepCrit07(), imQuantum.getSepCrit08(),
        imQuantum.getSepCrit09(), imQuantum.getSepCrit10(), imQuantum.getStatCustoms(), imQuantum.getStatQualityControl(), "Basis");

  }

  /*
   * Input_Validation
   */

  @Given("CHASC input has: idSite = {String}")
  public void chascInputHasIdSite(String idSite) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(idSite, tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  @Given("CHASC input has: clProcess = {String}")
  public void chascInputHasClProcess(String clProcess) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), clProcess, tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  @Given("CHASC input has: artvar = {String}")
  public void chascInputHasArtvar(String artvar) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), artvar, tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  /*
   * Test fpr Melting
   * 
   */

  @When("CHASC is used to change quantum ={string} with artvar = {string}  and qtyMoved = {double}")
  public void chascCheckIfMeltingHappend(String Qu, String artvar, Double qtyMoved) {

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(Qu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();

    chascInputBuilder = new InventoryChascInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        imQuantumPk.getIdQuantum(), qtyMoved, "AVAILABLE", artvar, imQuantum.getIdBatch(), imQuantum.getTypStock(), imQuantum.getTypLock(), null,
        null, imQuantum.getSepCrit01(), imQuantum.getSepCrit02(), imQuantum.getSepCrit03(), null, null, null, null, null, null, null,
        imQuantum.getStatCustoms(), imQuantum.getStatQualityControl(), "Basis");
  }

  public ImQuantum readImQuantumUnit(String idQu) {
    ImQuantum quantum = imQuantumRep.findOne(new ImQuantumPk(generalHelper.getIdSite(), idQu));
    return quantum;
  }

  @Then("quantum {string} has decreased by {double} and quantum {string} has increased by {double}")
  @Transactional(readOnly = true)
  public void chascVerificationAfterMelting(String Qu1, Double qty1, String Qu2, Double qty2) {

    ImQuantum imQuantum1 = inventoryDataHandler.getQuantum(Qu1);
    ImQuantumPk imQuantumPk1 = imQuantum1.getImQuantumPk();

    double orgQtyAv1 = imQuantum1.getQtyAvailable();
    imQuantum1 = readImQuantumUnit(imQuantumPk1.getIdQuantum());
    double qtyAv1 = imQuantum1.getQtyAvailable();

    ImQuantum imQuantum2 = inventoryDataHandler.getQuantum(Qu2);
    ImQuantumPk imQuantumPk2 = imQuantum2.getImQuantumPk();

    double orgQtyAv2 = imQuantum2.getQtyAvailable();
    imQuantum2 = readImQuantumUnit(imQuantumPk2.getIdQuantum());
    double qtyAv2 = imQuantum2.getQtyAvailable();

    assertAll(() -> assertEquals(qty1, orgQtyAv1 - qtyAv1), () -> assertEquals(qty2, qtyAv2 - orgQtyAv2));
  }

  @Then("quantum {string} has artvar = {string}")
  @Transactional(readOnly = true)
  public void chascCheckArtvarAfterMelting(String Qu, String artvar) {
    ImQuantum imQuantum = inventoryDataHandler.getQuantum(Qu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();
    imQuantum = readImQuantumUnit(imQuantumPk.getIdQuantum());
    assertEquals(artvar, imQuantum.getArtvar());

  }

}
