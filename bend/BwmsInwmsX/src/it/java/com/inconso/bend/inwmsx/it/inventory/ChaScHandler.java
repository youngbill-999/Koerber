package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.booleanThat;
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

  @When("CHASC is used to change quantum ={string} with qtyType ={string} and qtyMoved = {double}")
  public void chascIsUsedToChangeQuantumWithQtyTypeAndQtyMoved(String Qu, String qtyType, Double qtyMoved) {

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(Qu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();

    chascInputBuilder = new InventoryChascInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        imQuantumPk.getIdQuantum(), qtyMoved, qtyType, imQuantum.getArtvar(), imQuantum.getIdBatch(), imQuantum.getTypStock(), imQuantum.getTypLock(),
        imQuantum.getTypSpecialStock(), imQuantum.getIdSpecialStock(), imQuantum.getSepCrit01(), imQuantum.getSepCrit02(), imQuantum.getSepCrit03(),
        imQuantum.getSepCrit04(), imQuantum.getSepCrit05(), imQuantum.getSepCrit06(), imQuantum.getSepCrit07(), imQuantum.getSepCrit08(),
        imQuantum.getSepCrit09(), imQuantum.getSepCrit10(), imQuantum.getStatCustoms(), imQuantum.getStatQualityControl(), "Basis");

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

  @When("CHASC is used to change quantum ={string} with qtyType = {string} and qtyMoved = {double}")
  public void chascCheckQtyChanging(String Qu, String qtyType, Double qtyMoved) {

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(Qu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();

    chascInputBuilder = new InventoryChascInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        imQuantumPk.getIdQuantum(), qtyMoved, qtyType, imQuantum.getArtvar(), imQuantum.getIdBatch(), imQuantum.getTypStock(), imQuantum.getTypLock(),
        null, null, imQuantum.getSepCrit01(), imQuantum.getSepCrit02(), imQuantum.getSepCrit03(), null, null, null, null, null, null, null,
        imQuantum.getStatCustoms(), imQuantum.getStatQualityControl(), "Basis");
  }

  /*
   * Input_Validation
   */

  public void chascInputModification(InventoryChascInput tmpChascInput) {

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  @Given("CHASC input has: idSite = {String}")
  public void chascInputHasIdSite(String idSite) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();
    tmpChascInput.setIdSite(idSite);
    chascInputModification(tmpChascInput);

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

  @Given("CHASC input has: batch = {String}")
  public void chascInputHasBatch(String batch) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), batch, tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  @Given("CHASC input has: clProcess = {String}")
  public void chascInputHasClProcess(String clProcess) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();
    tmpChascInput.setClProcess(clProcess);
    chascInputModification(tmpChascInput);
  }

  @Given("CHASC input has: typProcess = {String}")
  public void chascInputHasTypProcess(String typProcess) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();
    tmpChascInput.setTypProcess(typProcess);
    chascInputModification(tmpChascInput);
  }

  @Given("CHASC input has: stepProcess = {String}")
  public void chascInputHasStepProcess(String stepProcess) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();
    tmpChascInput.setStepProcess(stepProcess);
    chascInputModification(tmpChascInput);
  }

  @Given("CHASC input has: key = {String}")
  public void chascInputHasKey(String key) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();
    tmpChascInput.setKey(key);
    chascInputModification(tmpChascInput);

  }

  @Given("CHASC input has: idUser = {String}")
  public void chascInputHasIduser(String idUser) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();
    tmpChascInput.setIdUser(idUser);
    chascInputModification(tmpChascInput);

  }

  @Given("CHASC input has References: typRef = {String}, idRef1 = {String}, idRef2 = {String}, idRef3 = {String}, idRef4 = {String}, idRef5 = {String}, idRef6 = {String}")
  public void chascInputHasRef(String typRef, String idRef1, String idRef2, String idRef3, String idRef4, String idRef5, String idRef6) {
    if (chascInputBuilder != null) {

      chascInputBuilder.withTypRefAndId(typRef, idRef1, idRef2, idRef3, idRef4, idRef5, idRef6);

    }
  }

  @Given("CHASC input has: idQuantum = {String}")
  public void chascInputHasIdQuantum(String idQuantum) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), idQuantum, tmpChascInput.getQtyMoved(),
        tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(), tmpChascInput.getTypLock(),
        null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(),
        tmpChascInput.getIdUser());

  }

  @Given("CHASC input has: qtyType = {String}")
  public void chascInputHasQtyType(String qtyType) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), qtyType, tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  @Given("CHASC input has: qtyMoved = {double}")
  public void chascInputHasQtyMoved(Double qtyMoved) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(), qtyMoved,
        tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(), tmpChascInput.getTypLock(),
        null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(),
        tmpChascInput.getIdUser());

  }

  @Given("CHASC input has: typStock = {String}")
  public void chascInputHastTypStock(String typStock) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), typStock,
        tmpChascInput.getTypLock(), null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  @Given("CHASC input has: typLock = {String}")
  public void chascInputHastTypLock(String typLock) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        typLock, null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  @Given("CHASC input has: statQualityControl = {String}")
  public void chascInputHasStatQualityControl(String statQualityControl) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), null, null, null, null, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        statQualityControl, tmpChascInput.getIdUser());

  }

  @Given("CHASC input has: statCustoms = {String}")
  public void chascInputHasStatCustoms(String statCustoms) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), null, null, null, null, null, null, null, null, null, null, null, null, statCustoms,
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  @Given("CHASC input has: specialTypStock = {String} and idSpecialTypStock = {String}")
  public void chascInputHasSpecialTypStock(String specialTypStock, String idSpecialTypStock) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), specialTypStock, idSpecialTypStock, null, null, null, null, null, null, null, null, null, null,
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  @Given("CHASC input has: sepCrit01 = {String}, sepCrit02 = {String}")
  public void chascInputHasSepCrit01NullSepCrit02Null(String sepCrit01, String sepCrit02) {
    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), null, null, sepCrit01, sepCrit02, null, null, null, null, null, null, null, null, tmpChascInput.getStatCustoms(),
        tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  private void tempLate() {
    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
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

  @Then("quantum {string} was deleted and quantum {string} has increased by {double}")
  @Transactional(readOnly = true)
  public void chascDeletionAfterMelting(String Qu1, String Qu2, Double qty2) {

    ImQuantum imQuantum1 = inventoryDataHandler.getQuantum(Qu1);
    ImQuantumPk imQuantumPk1 = imQuantum1.getImQuantumPk();
    imQuantum1 = readImQuantumUnit(imQuantumPk1.getIdQuantum());
    boolean checkIsQu1 = (imQuantum1 == null) ? true : false;

    ImQuantum imQuantum2 = inventoryDataHandler.getQuantum(Qu2);
    ImQuantumPk imQuantumPk2 = imQuantum2.getImQuantumPk();

    double orgQtyAv2 = imQuantum2.getQtyAvailable();
    imQuantum2 = readImQuantumUnit(imQuantumPk2.getIdQuantum());
    double qtyAv2 = imQuantum2.getQtyAvailable();

    assertAll(() -> assertEquals(true, checkIsQu1), () -> assertEquals(qty2, qtyAv2 - orgQtyAv2));
  }

  @Then("quantum {string} has artvar = {string}")
  @Transactional(readOnly = true)
  public void chascCheckArtvarAfterMelting(String Qu, String artvar) {
    ImQuantum imQuantum = inventoryDataHandler.getQuantum(Qu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();
    imQuantum = readImQuantumUnit(imQuantumPk.getIdQuantum());
    assertEquals(artvar, imQuantum.getArtvar());

  }

  /*
   * Test fpr Splitting
   * 
   */

  @Then("save target quantum as {string} for transaction {string}")
  @Transactional(readOnly = true)
  public void chascSaveTgtQuantum(String keyQu, String keyTransaction) {

    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    ImQuantum quantum = imQuantumRep.findOne(new ImQuantumPk(generalHelper.getIdSite(), transaction.getIdQuantumTgt()));
    inventoryDataHandler.putQuantum(keyQu, quantum);

  }

  @Then("quantum {string} has QtyAvailble with {double}")
  @Transactional(readOnly = true)
  public void chascCheckAvaQuantity(String keyQu, Double qty) {

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(keyQu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();
    imQuantum = readImQuantumUnit(imQuantumPk.getIdQuantum());
    double qtyAv = imQuantum.getQtyAvailable();

    assertEquals(qty, qtyAv);// no need to count the orign qty.because the target quantum do not have orign count.it is newly generate
  }

  @Then("quantum {string} has decreased by {double}")
  @Transactional(readOnly = true)
  public void chascVerificationAfterMelting(String keyQu, Double qty) {

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(keyQu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();

    double orgQtyAv = imQuantum.getQtyAvailable();
    imQuantum = readImQuantumUnit(imQuantumPk.getIdQuantum());
    double qtyAv = imQuantum.getQtyAvailable();

    assertEquals(qty, orgQtyAv - qtyAv);
  }

  @Then("quantum {string} has Increased by {double}")
  @Transactional(readOnly = true)
  public void chascVerificationIncrement(String keyQu, Double qty) {

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(keyQu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();

    double orgQtyAv = imQuantum.getQtyAvailable();
    imQuantum = readImQuantumUnit(imQuantumPk.getIdQuantum());
    double qtyAv = imQuantum.getQtyAvailable();

    assertEquals(qty, qtyAv - orgQtyAv);
  }

}
