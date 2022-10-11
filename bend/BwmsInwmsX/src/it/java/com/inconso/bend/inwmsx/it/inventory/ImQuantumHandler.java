package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.inventory.pers.gen.ImQuantumPk;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.rep.ImQuantumRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.topology.pers.gen.TopLuTypePk;
import com.inconso.bend.topology.pers.model.TopLuType;
import com.inconso.bend.topology.pers.rep.TopLuTypeRep;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.en.Then;

public class ImQuantumHandler {

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private ImQuantumRep         imQuantumRep;

  @Autowired
  private GeneralHelper        generalHelper;

  @Then("set quantum {string} flag stock taking = {string}")
  @Transactional
  public void setQuantumUnitFlagStockTaking(String quKey, String flagStockTaking) {

    ImQuantum quantumUnit = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    quantumUnit.setFlgStockTaking(flagStockTaking);

  }

  @Then("set quantum {string} reserved quantity = {Double}")
  @Transactional
  public void setQuantumReservedQuantity(String quKey, Double qtyReservedTgt) {

    ImQuantum quantumUnit = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    quantumUnit.setQtyReserved(qtyReservedTgt);

  }

  @Then("set quantum {string} bbd = {Date}")
  @Transactional
  public void setmakeUpBbd(String quKey, Date tsBbd) {

    ImQuantum quantumUnit = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    quantumUnit.setTsBbd(tsBbd);

  }

  /**
   * Ensure that ImQuantum that was created is only read from database if it's necessary.
   * 
   * @param idQu
   * 
   * @return last created transaction
   */
  public ImQuantum readImQuantumUnit(String idQu) {
    ImQuantum quantum = imQuantumRep.findOne(new ImQuantumPk(generalHelper.getIdSite(), idQu));
    return quantum;
  }

  @Then("quantum {string} has: attributes = {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}")
  @Transactional(readOnly = true)
  public void verifyQuantumAttributes(String quKey, String attribute01, String attribute02, String attribute03, String attribute04,
      String attribute05, String attribute06, String attribute07, String attribute08, String attribute09, String attribute10, String attribute11,
      String attribute12, String attribute13, String attribute14, String attribute15, String attribute16, String attribute17, String attribute18,
      String attribute19, String attribute20) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
             
              () -> assertEquals(attribute01, quantum.getAttribute01()), 
              () -> assertEquals(attribute02, quantum.getAttribute02()), 
              () -> assertEquals(attribute03, quantum.getAttribute03()), 
              () -> assertEquals(attribute04, quantum.getAttribute04()), 
              () -> assertEquals(attribute05, quantum.getAttribute05()), 
              () -> assertEquals(attribute06, quantum.getAttribute06()), 
              () -> assertEquals(attribute07, quantum.getAttribute07()), 
              () -> assertEquals(attribute08, quantum.getAttribute08()), 
              () -> assertEquals(attribute09, quantum.getAttribute09()), 
              () -> assertEquals(attribute10, quantum.getAttribute10()), 
              () -> assertEquals(attribute11, quantum.getAttribute11()), 
              () -> assertEquals(attribute12, quantum.getAttribute12()), 
              () -> assertEquals(attribute13, quantum.getAttribute13()), 
              () -> assertEquals(attribute14, quantum.getAttribute14()), 
              () -> assertEquals(attribute15, quantum.getAttribute15()), 
              () -> assertEquals(attribute16, quantum.getAttribute16()), 
              () -> assertEquals(attribute17, quantum.getAttribute17()), 
              () -> assertEquals(attribute18, quantum.getAttribute18()), 
              () -> assertEquals(attribute19, quantum.getAttribute19()), 
              () -> assertEquals(attribute20, quantum.getAttribute20()));
    //@formatter:on
  }

  @Then("quantum {String} has: BBD = {Date}")
  @Transactional(readOnly = true)
  public void quantumHasBBD(String quKey, Date tsBBD) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    assertEquals(tsBBD, quantum.getTsBbd());
  }

  /**
   * Verifies that the quantum that was created by the prior webservice call has the given article.
   * 
   * @param idArticle
   *          requested article id
   */
  @Then("quantum {string} has article {string}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasGivenArticles(String quKey, String idArticle) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(generalHelper.getIdClient(), quantum.getIdClient()),
              () -> assertEquals(idArticle, quantum.getIdArticle()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum that was created by the prior webservice call has the given available quantity
   * 
   * @param qtyAvailable
   *          requested available quantity
   * 
   */
  @Then("quantum {string} has available quantity {double}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasQtyAvailable(String quKey, Double qtyAvailable) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(qtyAvailable, quantum.getQtyAvailable()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum has the given reserved quantity
   * 
   * @param qtyReserved
   *          requested reserved quantity
   * 
   */
  @Then("quantum {string} has reserved quantity {double}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasQtyReserved(String quKey, Double qtyReserved) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(qtyReserved, quantum.getQtyReserved()));
    //@formatter:on
  }

  @Then("quantum {string} has: idUpd = {string}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasIdUpd(String quKey, String idUpd) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum),
              () -> assertEquals(idUpd, quantum.getIdUpd()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum has the given artvar
   * 
   * @param artvar
   *          requested artvar
   * 
   */
  @Then("quantum {string} has artvar {string}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasArtvar(String quKey, String artvar) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(artvar, quantum.getArtvar()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum has the given stock type
   * 
   * @param typStock
   *          requested stock type
   * 
   */
  @Then("quantum {string} has stock type {string}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasTypStock(String quKey, String typStock) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(typStock, quantum.getTypStock()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum has the given lock type
   * 
   * @param typLock
   *          requested lock type
   * 
   */
  @Then("quantum {string} has lock type {string}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasTypLock(String quKey, String typLock) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(typLock, quantum.getTypLock()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum has the given quality control status
   * 
   * @param qcStat
   *          requested QC status
   * 
   */
  @Then("quantum {string} has QC status {string}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasQcStat(String quKey, String qcStat) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(qcStat, quantum.getStatQualityControl()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum has the given customs status
   * 
   * @param custStat
   *          requested customs status
   * 
   */
  @Then("quantum {string} has customs status {string}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasCustStat(String quKey, String custStat) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(custStat, quantum.getStatCustoms()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum that was created by the prior webservice call has the given separation criterion 1
   * 
   * @param sepCrit1
   *          requested separation criterion 1
   * 
   */
  @Then("quantum {string} has sep crit 1 {string}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasSepCrit1(String quKey, String sepCrit1) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(sepCrit1, quantum.getSepCrit01()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum that was created by the prior webservice call has the given separation criterion 2
   * 
   * @param sepCrit2
   *          requested separation criterion 2
   * 
   */
  @Then("quantum {string} has sep crit 2 {string}")
  @Transactional(readOnly = true)
  public void verifyQuantumHasSepCrit2(String quKey, String sepCrit2) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(sepCrit2, quantum.getSepCrit02()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum that was created by the prior webservice call has the created transaction ID
   * 
   */
  @Then("quantum {string} has: idTransaction = {StringExt}")
  @Transactional(readOnly = true)
  public void verifyQuantumTransactionID(String quKey, GherkinType<String> idTransaction) {
    idTransaction.setGetterForKey(inventoryDataHandler.idTransactionGetter);
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(idTransaction.get(), quantum.getIdTransaction()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum that was created by the prior webservice call is at the given location
   * 
   * @param area
   *          requested current storage area
   * @param location
   *          requested current storage location
   * 
   */
  @Then("quantum {string} is at {string}-{string}")
  @Transactional(readOnly = true)
  public void verifyQuantumAtLocation(String quKey, String area, String location) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());

    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(area, quantum.getStorageArea()), 
              () -> assertEquals(location, quantum.getStorageLocation()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum that was created by the prior webservice call is not moving
   * 
   */
  @Then("quantum {string} is not moving")
  @Transactional(readOnly = true)
  public void verifyQuantumIsNotMoving(String quKey) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals("0", quantum.getFlgInTransit()));
    //@formatter:on
  }

  @Then("quantum {string} has: goods receipt = {String}-{Long} and GR-Date = {Date}")
  @Transactional(readOnly = true)
  public void quantumHasGoodsReceiptAndGRDate(String quKey, String goodsReceipt, Long grItem, Date tsGoodsReceipt) {
    ImQuantum quantum = readImQuantumUnit(inventoryDataHandler.getQuantum(quKey).getImQuantumPk().getIdQuantum());
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(goodsReceipt, quantum.getIdGoodsReceipt()), 
              () -> assertEquals(grItem, quantum.getNumGoodsReceiptItem()), 
              () -> assertEquals(tsGoodsReceipt, quantum.getTsGoodsReceipt()));
    //@formatter:on
  }

}
