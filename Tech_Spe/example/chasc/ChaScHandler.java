package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.apache.derby.iapi.error.PublicAPI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.gen.ImQuantumPk;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inventory.pers.rep.ImQuantumRep;
import com.inconso.bend.inventory.service.transaction.api.InventoryChascInput;
import com.inconso.bend.inventory.service.transaction.api.InventoryTransactionDesc;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
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
  private InventoryDataHandler        inventoryDataHandler;

  @Autowired
  private ImQuantumRep                imQuantumRep;

  @Autowired
  private CucumberReport              cucumberReport;

  private InventoryChascInput.Builder chascInputBuilder;

  /**
   * Calls the webservice of transaction type CHASC
   * 
   */

  @When("CHASC is called")
  public void chascIsCalled() {

    ServiceInput<InventoryChascInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    InventoryChascInput input = chascInputBuilder.build();// here get the already generated one from the methods below.
    inputService.setData(input);

    webserviceClient.call(InventoryTransactionDesc.SERVICE, InventoryTransactionDesc.CHASC_EP, inputService);

  }

  /**
   * initialise CHASC input for changing separational characteristics
   * 
   */
  @When("CHASC is used to change quantum = {string} with stock type = {string} and lock type = {string}")
  public void chascForChangeStockTypAndLockTyp(String keyQu, String typStock, String typLock) {

    if (keyQu == null) {
      assertEquals(null, keyQu);
    }

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(keyQu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();
    String idQuantum = imQuantumPk.getIdQuantum();
    String qtyType = "AVAILABLE";
    Double qtyMoved = imQuantum.getQtyAvailable();
    String artvar = imQuantum.getArtvar();
    // String typStock = imQuantum.getTypStock();
    // String typLock = imQuantum.getTypLock();
    String idBatch = imQuantum.getIdBatch();
    String typSpecialStock = imQuantum.getTypSpecialStock();
    String idSpecialStock = imQuantum.getIdSpecialStock();
    String statQualityControl = imQuantum.getStatQualityControl();
    String statCustoms = imQuantum.getStatCustoms();
    String sepCrit01 = imQuantum.getSepCrit01();
    String sepCrit02 = imQuantum.getSepCrit02();
    String sepCrit03 = imQuantum.getSepCrit03();
    String sepCrit04 = imQuantum.getSepCrit04();
    String sepCrit05 = imQuantum.getSepCrit05();
    String sepCrit06 = imQuantum.getSepCrit06();
    String sepCrit07 = imQuantum.getSepCrit07();
    String sepCrit08 = imQuantum.getSepCrit08();
    String sepCrit09 = imQuantum.getSepCrit09();
    String sepCrit10 = imQuantum.getSepCrit10();

    chascInputBuilder = new InventoryChascInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        idQuantum, qtyMoved, qtyType, artvar, idBatch, typStock, typLock, typSpecialStock, idSpecialStock, sepCrit01, sepCrit02, sepCrit03, sepCrit04,
        sepCrit05, sepCrit06, sepCrit07, sepCrit08, sepCrit09, sepCrit10, statCustoms, statQualityControl, "Basis");

  }

  /**
   * initialise CHASC input for changing separational characteristics
   * 
   */
  @When("CHASC is used to change quantum = {string} with qtyType = {string} and qtyMoved = {double}")
  public void chascCheckQtyChanging(String keyQu, String qtyType, Double qtyMoved) {
    if (keyQu == null) {
      assertEquals(null, keyQu);
    }

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(keyQu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();
    String idQuantum = imQuantumPk.getIdQuantum();
    // String qtyType;
    // Double qtyMoved;
    String artvar = imQuantum.getArtvar();
    String typStock = imQuantum.getTypStock();
    String typLock = imQuantum.getTypLock();
    String idBatch = imQuantum.getIdBatch();
    String typSpecialStock = imQuantum.getTypSpecialStock();
    String idSpecialStock = imQuantum.getIdSpecialStock();
    String statQualityControl = imQuantum.getStatQualityControl();
    String statCustoms = imQuantum.getStatCustoms();
    String sepCrit01 = imQuantum.getSepCrit01();
    String sepCrit02 = imQuantum.getSepCrit02();
    String sepCrit03 = imQuantum.getSepCrit03();
    String sepCrit04 = imQuantum.getSepCrit04();
    String sepCrit05 = imQuantum.getSepCrit05();
    String sepCrit06 = imQuantum.getSepCrit06();
    String sepCrit07 = imQuantum.getSepCrit07();
    String sepCrit08 = imQuantum.getSepCrit08();
    String sepCrit09 = imQuantum.getSepCrit09();
    String sepCrit10 = imQuantum.getSepCrit10();

    chascInputBuilder = new InventoryChascInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        idQuantum, qtyMoved, qtyType, artvar, idBatch, typStock, typLock, typSpecialStock, idSpecialStock, sepCrit01, sepCrit02, sepCrit03, sepCrit04,
        sepCrit05, sepCrit06, sepCrit07, sepCrit08, sepCrit09, sepCrit10, statCustoms, statQualityControl, "Basis");

  }

  /**
   * initialise CHASC input for changing separational characteristics
   * 
   */

  @When("CHASC is used to change quantum = {string} with artvar = {string}  and qtyMoved = {double}")
  public void chascCheckIfMeltingHappend(String keyQu, String artvar, Double qtyMoved) {
    if (keyQu == null) {
      assertEquals(null, keyQu);
    }

    ImQuantum imQuantum = inventoryDataHandler.getQuantum(keyQu);
    ImQuantumPk imQuantumPk = imQuantum.getImQuantumPk();
    String idQuantum = imQuantumPk.getIdQuantum();
    String qtyType = "AVAILABLE";
    // Double qtyMoved = imQuantum.getQtyAvailable();
    // String artvar = imQuantum.getArtvar();
    String typStock = imQuantum.getTypStock();
    String typLock = imQuantum.getTypLock();
    String idBatch = imQuantum.getIdBatch();
    String typSpecialStock = imQuantum.getTypSpecialStock();
    String idSpecialStock = imQuantum.getIdSpecialStock();
    String statQualityControl = imQuantum.getStatQualityControl();
    String statCustoms = imQuantum.getStatCustoms();
    String sepCrit01 = imQuantum.getSepCrit01();
    String sepCrit02 = imQuantum.getSepCrit02();
    String sepCrit03 = imQuantum.getSepCrit03();
    String sepCrit04 = imQuantum.getSepCrit04();
    String sepCrit05 = imQuantum.getSepCrit05();
    String sepCrit06 = imQuantum.getSepCrit06();
    String sepCrit07 = imQuantum.getSepCrit07();
    String sepCrit08 = imQuantum.getSepCrit08();
    String sepCrit09 = imQuantum.getSepCrit09();
    String sepCrit10 = imQuantum.getSepCrit10();

    chascInputBuilder = new InventoryChascInput.Builder(generalHelper.getIdSite(), "DIALOG", "IM400", "*", generalHelper.getIdClient(), "*",
        idQuantum, qtyMoved, qtyType, artvar, idBatch, typStock, typLock, typSpecialStock, idSpecialStock, sepCrit01, sepCrit02, sepCrit03, sepCrit04,
        sepCrit05, sepCrit06, sepCrit07, sepCrit08, sepCrit09, sepCrit10, statCustoms, statQualityControl, "Basis");

  }

  /*
   * Input_Validation
   */

  /*
   * Rebuild CHASC input after modifying some parameters in CoreInput
   */
  private void chascInputModification(InventoryChascInput tmpChascInput) {

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

  /*
   * Rebuild CHASC input when some parameters need to be changed
   */

  /*
   * 
   * Specify a new artvar
   * 
   */
  @Given("CHASC input has: artvar = {String}")
  public void chascInputHasArtvar(String artvar) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), artvar, tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(),
        tmpChascInput.getSepCrit02(), tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(),
        tmpChascInput.getSepCrit06(), tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(),
        tmpChascInput.getSepCrit10(), tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  /*
   * 
   * Specify a new batch
   * 
   */
  @Given("CHASC input has: batch = {String}")
  public void chascInputHasBatch(String batch) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), batch, tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(),
        tmpChascInput.getSepCrit02(), tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(),
        tmpChascInput.getSepCrit06(), tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(),
        tmpChascInput.getSepCrit10(), tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  /*
   * 
   * Specify a new idQuantum
   * 
   */
  @Given("CHASC input has: idQuantum = {String}")
  public void chascInputHasIdQuantum(String idQuantum) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), idQuantum, tmpChascInput.getQtyMoved(),
        tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(), tmpChascInput.getTypLock(),
        tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(), tmpChascInput.getSepCrit02(),
        tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(), tmpChascInput.getSepCrit06(),
        tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(), tmpChascInput.getSepCrit10(),
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  /*
   * 
   * Specify a new qtyType
   * 
   */
  @Given("CHASC input has: qtyType = {String}")
  public void chascInputHasQtyType(String qtyType) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), qtyType, tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(),
        tmpChascInput.getSepCrit02(), tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(),
        tmpChascInput.getSepCrit06(), tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(),
        tmpChascInput.getSepCrit10(), tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  /*
   * 
   * Specify a new qtyMoved
   * 
   */
  @Given("CHASC input has: qtyMoved = {double}")
  public void chascInputHasQtyMoved(Double qtyMoved) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(), qtyMoved,
        tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(), tmpChascInput.getTypLock(),
        tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(), tmpChascInput.getSepCrit02(),
        tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(), tmpChascInput.getSepCrit06(),
        tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(), tmpChascInput.getSepCrit10(),
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  /*
   * 
   * Specify a new typStock
   * 
   */
  @Given("CHASC input has: typStock = {String}")
  public void chascInputHastTypStock(String typStock) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), typStock,
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(),
        tmpChascInput.getSepCrit02(), tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(),
        tmpChascInput.getSepCrit06(), tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(),
        tmpChascInput.getSepCrit10(), tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  /*
   * 
   * Specify a new typLock
   * 
   */
  @Given("CHASC input has: typLock = {String}")
  public void chascInputHastTypLock(String typLock) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        typLock, tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(), tmpChascInput.getSepCrit02(),
        tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(), tmpChascInput.getSepCrit06(),
        tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(), tmpChascInput.getSepCrit10(),
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  /*
   * 
   * Specify a new statQualityControl
   * 
   */
  @Given("CHASC input has: statQualityControl = {String}")
  public void chascInputHasStatQualityControl(String statQualityControl) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(),
        tmpChascInput.getSepCrit02(), tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(),
        tmpChascInput.getSepCrit06(), tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(),
        tmpChascInput.getSepCrit10(), tmpChascInput.getStatCustoms(), statQualityControl, tmpChascInput.getIdUser());

  }

  /*
   * 
   * Specify a new statCustoms
   * 
   */
  @Given("CHASC input has: statCustoms = {String}")
  public void chascInputHasStatCustoms(String statCustoms) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(),
        tmpChascInput.getSepCrit02(), tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(),
        tmpChascInput.getSepCrit06(), tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(),
        tmpChascInput.getSepCrit10(), statCustoms, tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  /*
   * 
   * Specify a new special stock data
   * 
   */
  @Given("CHASC input has: specialTypStock = {String} and idSpecialTypStock = {String}")
  public void chascInputHasSpecialTypStock(String specialTypStock, String idSpecialTypStock) {

    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), specialTypStock, idSpecialTypStock, tmpChascInput.getSepCrit01(), tmpChascInput.getSepCrit02(),
        tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(), tmpChascInput.getSepCrit06(),
        tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(), tmpChascInput.getSepCrit10(),
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());

  }

  /*
   * 
   * Specify values for different Separation Criterias
   * 
   */

  @Given("CHASC input has: sepCrit01 = {String}")
  public void chascInputHasSepCrit01(String sepCrit01) {
    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), sepCrit01, tmpChascInput.getSepCrit02(),
        tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(), tmpChascInput.getSepCrit06(),
        tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(), tmpChascInput.getSepCrit10(),
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  @Given("CHASC input has: sepCrit02 = {String}")
  public void chascInputHasSepCrit02(String sepCrit02) {
    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(), sepCrit02,
        tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(), tmpChascInput.getSepCrit06(),
        tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(), tmpChascInput.getSepCrit10(),
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  @Given("CHASC input has: sepCrit03 = {String}")
  public void chascInputHasSepCrit03(String sepCrit03) {
    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(),
        tmpChascInput.getSepCrit02(), sepCrit03, tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(), tmpChascInput.getSepCrit06(),
        tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(), tmpChascInput.getSepCrit10(),
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  @Given("CHASC input has: sepCrit04 = {String}")
  public void chascInputHasSepCrit04(String sepCrit04) {
    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(),
        tmpChascInput.getSepCrit02(), tmpChascInput.getSepCrit03(), sepCrit04, tmpChascInput.getSepCrit05(), tmpChascInput.getSepCrit06(),
        tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(), tmpChascInput.getSepCrit10(),
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  @Given("CHASC input has: sepCrit10 = {String}")
  public void chascInputHasSepCrit10(String sepCrit10) {
    InventoryChascInput tmpChascInput = chascInputBuilder.build();

    chascInputBuilder = new InventoryChascInput.Builder(tmpChascInput.getIdSite(), tmpChascInput.getClProcess(), tmpChascInput.getTypProcess(),
        tmpChascInput.getStepProcess(), tmpChascInput.getIdClient(), tmpChascInput.getKey(), tmpChascInput.getIdQuantum(),
        tmpChascInput.getQtyMoved(), tmpChascInput.getQtyType(), tmpChascInput.getArtvar(), tmpChascInput.getIdBatch(), tmpChascInput.getTypStock(),
        tmpChascInput.getTypLock(), tmpChascInput.getTypSpecialStock(), tmpChascInput.getIdSpecialStock(), tmpChascInput.getSepCrit01(),
        tmpChascInput.getSepCrit02(), tmpChascInput.getSepCrit03(), tmpChascInput.getSepCrit04(), tmpChascInput.getSepCrit05(),
        tmpChascInput.getSepCrit06(), tmpChascInput.getSepCrit07(), tmpChascInput.getSepCrit08(), tmpChascInput.getSepCrit09(), sepCrit10,
        tmpChascInput.getStatCustoms(), tmpChascInput.getStatQualityControl(), tmpChascInput.getIdUser());
  }

  /*
   * 
   * when new quantum was created, it need to be save
   * 
   */

  @Then("save target quantum as {string} for transaction {string}")
  @Transactional(readOnly = true)
  public void chascSaveTgtQuantum(String keyQu, String keyTransaction) {

    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    ImQuantum quantum = imQuantumRep.findOne(new ImQuantumPk(generalHelper.getIdSite(), transaction.getIdQuantumTgt()));
    inventoryDataHandler.putQuantum(keyQu, quantum);

  }

  @Given("need an Article has more than 2 artvar and requires BBD")
  public void chascBBD() {
    cucumberReport.setMessage(
        "Melting with BBD: need to enter the Article Management to change some atr's BBD requirement, or add artvar of some articles to fit test description");
  }

}
