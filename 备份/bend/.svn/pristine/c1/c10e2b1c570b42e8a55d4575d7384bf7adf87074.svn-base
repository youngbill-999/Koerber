package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNotSame;
import static org.junit.jupiter.api.Assertions.assertNull;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import io.cucumber.java.en.Then;

public class TransactionHandler {

  @Autowired
  private CucumberReport       cucumberReport;

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private TransactionHelper    transactionHelper;

  /**
   * Verifies that the given transaction has given target height
   * 
   * @param height
   *          expected height
   */
  @Then("transaction {string} has: heightTgt = {double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasATgtHeight(String keyTransaction, Double height) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(height, transaction.getHeightTgt())
        );
    //@formatter:on
  }

  /**
   * Verifies that the given transaction has given source height
   * 
   * @param heightSrc
   *          expected height
   */
  @Then("transaction {string} has: heightSrc = {double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSrcHeight(String keyTransaction, Double heightSrc) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(heightSrc, transaction.getHeightSrc())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has given reasons
   * 
   * @param reason1
   *          first reason
   * @param reason2
   *          second reason
   */
  @Then("transaction {string} has: reasonTransaction1 = {string}, reasonTransaction2 = {string}")
  @Then("transaction {string} has: reason1 = {string}, reason2= {string}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasReason(String keyTransaction, String reason1, String reason2) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(reason1, transaction.getReasonTransaction1()), 
        () -> assertEquals(reason2, transaction.getReasonTransaction2())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has given reasons
   * 
   * @param luTyp
   * 
   */
  @Then("transaction {string} has: typLu1Tgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasLuTyp(String keyTransaction, String typLu1Tgt) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(typLu1Tgt, transaction.getTypLu1Tgt())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has given situation
   * 
   * @param situation
   *          expected situation
   */
  @Then("transaction {string} has: situation = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasASituation(String keyTransaction, String situation) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(situation, transaction.getSituation())
        );
    //@formatter:on
  }

  @Then("transaction {string} has: typRef = {string}, idRef1 = {string}, idRef2 = {string}, idRef3 = {string}, idRef4 = {string}, idRef5 = {string}, idRef6 = {string}")
  public void transactionHasTypRefIdRef1IdRef2IdRef3IdRef4IdRef5IdRef6(String keyTransaction, String typRef, String idRef1, String idRef2,
      String idRef3, String idRef4, String idRef5, String idRef6) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertEquals(typRef, transaction.getTypRef()), 
        () -> assertEquals(idRef1, transaction.getIdRef1()),
        () -> assertEquals(idRef2, transaction.getIdRef2()),
        () -> assertEquals(idRef3, transaction.getIdRef3()),
        () -> assertEquals(idRef4, transaction.getIdRef4()),
        () -> assertEquals(idRef5, transaction.getIdRef5()),
        () -> assertEquals(idRef6, transaction.getIdRef6())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has the given sscc
   * 
   * @param sscc
   *          expected sscc
   */
  @Then("transaction {string} has: sscc = {String}")
  @Then("transaction {string} has: ssccTgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasGivenSSCC(String keyTransaction, String sscc) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(sscc, transaction.getSsccTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has the given sscc
   * 
   * @param sscc
   *          expected sscc
   */
  @Then("transaction {string} has: ssccSrc = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasGivenSSCCSrc(String keyTransaction, String sscc) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(sscc, transaction.getSsccSrc()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice a valid sscc
   * 
   */
  @Then("transaction {string} has a valid target SSCC")
  @Transactional(readOnly = true)
  public void verifyTransactionHasValidSSCC(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNotNull(transaction.getSsccTgt()), 
        () -> assertEquals(20, transaction.getSsccTgt().length()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice a valid sscc
   * 
   */
  @Then("transaction {string} has a valid source SSCC")
  @Transactional(readOnly = true)
  public void verifyTransactionHasValidSrcSSCC(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction, "transaction"), 
        () -> assertNotNull(transaction.getSsccSrc(), "ssccSrc"), 
        () -> assertEquals(20, transaction.getSsccSrc().length(), "length of ssccSrc"));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has the given load unit type
   * 
   * @param luType
   *          expected load unit type
   */
  @Then("transaction {string} has: typLu1Src = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasLoadUnitTypeSrc(String keyTransaction, String luType) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(luType, transaction.getTypLu1Src()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has the given load unit
   * 
   * @param idLu
   *          expected ID of load unit
   */
  @Then("transaction {string} has: idLu1Src = {StringExt}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasLoadUnitSrc(String keyTransaction, GherkinType<String> idLu) {
    idLu.setGetterForKey(inventoryDataHandler.idLuGetter);
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(idLu.get(), transaction.getIdLu1Src()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has source load unit
   *
   */
  @Then("transaction {string} has source load unit")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSrcLoadUnit(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNotNull(transaction.getIdLu1Src()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has the given load unit
   * 
   * @param idLu
   *          expected ID of load unit
   */
  @Then("transaction {string} has: idLu1Tgt = {StringExt}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasLoadUnit(String keyTransaction, GherkinType<String> idLu1Tgt) {
    idLu1Tgt.setGetterForKey(inventoryDataHandler.idLuGetter);
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(idLu1Tgt.get(), transaction.getIdLu1Tgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has source load unit
   */
  @Then("transaction {string} has target load unit")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtLoadUnit(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNotNull(transaction.getIdLu1Tgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has the given source area and location.
   * 
   * @param areaSrc
   *          expected source area
   * @param locationSrc
   *          expected source location
   */
  @Then("transaction {string} has: storageAreaSrc = {String}, storageLocationSrc = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSourceStorageLocation(String keyTransaction, String areaSrc, String locationSrc) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(areaSrc, transaction.getStorageAreaSrc()), 
        () -> assertEquals(locationSrc, transaction.getStorageLocationSrc()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice has the given target area and location.
   * 
   * @param areaTgt
   *          expected target area
   * @param locationTgt
   *          expected target location
   */
  @Then("transaction {string} has: storageAreaTgt = {string}, storageLocationTgt = {string}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTargetStorageLocation(String keyTransaction, String areaTgt, String locationTgt) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(areaTgt, transaction.getStorageAreaTgt()), 
        () -> assertEquals(locationTgt, transaction.getStorageLocationTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transactions created by the prior webservice have the given source area and location.
   * 
   * @param areaSrc
   *          expected source area
   * @param locationSrc
   *          expected source location
   */
  @Then("all transactions within {string} transaction group have: storageAreaSrc = {String}, storageLocationSrc = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionsHaveSourceStorageLocation(String keyTransaction, String areaSrc, String locationSrc) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getStorageAreaSrc() != null && actTransaction.getStorageLocationSrc() != null) {
      //@formatter:off
        assertAll(
            () -> assertNotNull(transaction), 
            () -> assertEquals(areaSrc, actTransaction.getStorageAreaSrc()), 
            () -> assertEquals(locationSrc, actTransaction.getStorageLocationSrc()));
        //@formatter:on
      }
    }
  }

  /**
   * Verifies that the transactions created by the prior webservice have the given target area and location.
   * 
   * @param areaTgt
   *          expected target area
   * @param locationTgt
   *          expected target location
   */
  @Then("all transactions within {string} transaction group have: storageAreaTgt = {String}, storageLocationTgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionsHaveTargetStorageLocation(String keyTransaction, String areaTgt, String locationTgt) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getStorageAreaTgt() != null && actTransaction.getStorageLocationTgt() != null) {
      //@formatter:off
        assertAll(
            () -> assertNotNull(transaction), 
            () -> assertEquals(areaTgt, actTransaction.getStorageAreaTgt()), 
            () -> assertEquals(locationTgt, actTransaction.getStorageLocationTgt()));
        //@formatter:on
      }
    }
  }

  /**
   * Verifies that the quantum within the same transaction group do not have load unit at level 3
   */
  @Then("all transactions within {string} transaction group do not have a load unit at level 3")
  @Transactional(readOnly = true)
  public void verifyLuLevel3DoesNotExits(String keyTransaction) {

    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getIdLu1Tgt() != null && actTransaction.getIdLu2Tgt() != null) {
        assertNull(actTransaction.getIdLu3Tgt());
      }

    }
  }

  /**
   * Verifies that all the transactions for quantum within the transaction group are created.
   * 
   */
  @Then("all transactions within {string} transaction group for quantum are created")
  @Transactional(readOnly = true)
  public void verifyTransactionGrpWithQuantum(String keyTransaction) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getIdClient() != null && actTransaction.getIdArticle() != null) {
      //@formatter:off
        assertAll(
            () -> assertNotNull(actTransaction), 
            () -> assertNotNull(actTransaction.getIdClient()), 
            () -> assertNotNull(actTransaction.getIdArticle()));
        //@formatter:on
      }
    }
  }

  /**
   * Verifies that all the transactions within the transaction group are created.
   * 
   */
  @Then("all transactions within {string} transaction group of load unit {string} are created")
  @Transactional(readOnly = true)
  public void verifyTransactionGrp(String keyTransaction, String keyLu) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      //@formatter:off
        assertAll(
            () -> assertNotNull(actTransaction), 
            () -> assertEquals(inventoryDataHandler.getLoadUnit(keyLu).getImLoadUnitPk().getIdLu() ,actTransaction.getIdLuSrc(), "idLuSrc of transaction"),
            // booking deleted lu with stack -> idLuTgt should now be empty...!
            () -> assertNull(actTransaction.getIdLuTgt(), "idLuTgt of transaction"));
        //@formatter:on
    }
  }

  /**
   * Verifies that the transaction created by the prior webservice call is in the given status
   * 
   * @param status
   *          expected status
   */
  @Then("transaction {string} has: stat = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionIsInStatus(String keyTransaction, String status) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(status, transaction.getStat()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has no source quantum data
   * 
   */
  @Then("transaction {string} has no source quantum data")
  @Transactional(readOnly = true)
  public void verifyTransactionHasNoSourceQuantumData(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNull(transaction.getIdQuantumSrc()),
        () -> assertNull(transaction.getQtyAvailableSrc()),
        () -> assertNull(transaction.getQtyReservedSrc()),
        () -> assertNull(transaction.getArtvarSrc()),
        () -> assertNull(transaction.getTypStockSrc()),
        () -> assertNull(transaction.getTypLockSrc()),
        () -> assertNull(transaction.getTypSpecialStockSrc()),
        () -> assertNull(transaction.getIdSpecialStockSrc()),
        () -> assertNull(transaction.getStatCustomsSrc()),
        () -> assertNull(transaction.getStatQualityControlSrc()),
        
      //Änderung 11.2020 auf Grund der Füllung von chargenspezifischen Felder von nun an.
        //() -> assertNull(transaction.getIdBatchSrc()),
        //() -> assertNull(transaction.getTsBbdSrc()),    
        
        () -> assertNull(transaction.getIdGoodsReceiptSrc()),
        () -> assertNull(transaction.getNumGoodsReceiptItemSrc()),
        () -> assertNull(transaction.getTsGoodsReceiptSrc())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has no source quantum data
   * 
   */
  @Then("all transactions within {string} transaction group have source quantum")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSourceQuantum(String keyTransaction) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getIdClient() != null && actTransaction.getIdArticle() != null) {
      //@formatter:off
        assertAll(
            () -> assertNotNull(actTransaction), 
            () -> assertNotNull(actTransaction.getIdQuantumSrc()),
            () -> assertNotNull(actTransaction.getQtyAvailableSrc()),
            () -> assertNotNull(actTransaction.getQtyReservedSrc()),
            () -> assertNotNull(actTransaction.getArtvarSrc()),
            () -> assertNotNull(actTransaction.getTypStockSrc()),
            () -> assertNotNull(actTransaction.getTypLockSrc()),
            () -> assertNotNull(actTransaction.getStatCustomsSrc())
            );
        //@formatter:on
      }
    }
  }

  /**
   * Verifies that the transaction created by the prior webservice call has no source quantum data
   * 
   */
  @Then("all transactions within {string} transaction group have target quantum")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTargetQuantum(String keyTransaction) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getIdClient() != null && actTransaction.getIdArticle() != null) {
      //@formatter:off
        assertAll(
            () -> assertNotNull(actTransaction), 
            () -> assertNotNull(actTransaction.getIdQuantumTgt()),
            () -> assertNotNull(actTransaction.getQtyAvailableTgt()),
            () -> assertNotNull(actTransaction.getQtyReservedTgt()),
            () -> assertNotNull(actTransaction.getArtvarTgt()),
            () -> assertNotNull(actTransaction.getTypStockTgt()),
            () -> assertNotNull(actTransaction.getTypLockTgt()),
            () -> assertNotNull(actTransaction.getStatCustomsTgt())
            );
        //@formatter:on
      }
    }
  }

  /**
   * Verifies that the transaction created by the prior webservice call has source quantum data
   * 
   */
  @Then("transaction {string} has source quantum data")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSourceQuantumData(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNotNull(transaction.getIdQuantumSrc()),
        () -> assertNotNull(transaction.getQtyAvailableSrc()),
        () -> assertNotNull(transaction.getQtyReservedSrc()),
        () -> assertNotNull(transaction.getArtvarSrc()),
        () -> assertNotNull(transaction.getTypStockSrc()),
        () -> assertNotNull(transaction.getTypLockSrc()),
        () -> assertNull(transaction.getTypSpecialStockSrc()),
        () -> assertNull(transaction.getIdSpecialStockSrc()),
        () -> assertNotNull(transaction.getStatCustomsSrc()),
        () -> assertNotNull(transaction.getStatQualityControlSrc()),
        () -> assertNull(transaction.getIdGoodsReceiptSrc()),
        () -> assertNull(transaction.getNumGoodsReceiptItemSrc()),
        () -> assertNull(transaction.getTsGoodsReceiptSrc())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has no target quantum data
   * 
   */
  @Then("transaction {string} has no target quantum data")
  @Transactional(readOnly = true)
  public void verifyTransactionHasNoTargetQuantumData(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNull(transaction.getIdQuantumTgt()),
        () -> assertNull(transaction.getQtyAvailableTgt()),
        () -> assertNull(transaction.getQtyReservedTgt()),
        () -> assertNull(transaction.getArtvarTgt()),
        () -> assertNull(transaction.getTypStockTgt()),
        () -> assertNull(transaction.getTypLockTgt()),
        () -> assertNull(transaction.getTypSpecialStockTgt()),
        () -> assertNull(transaction.getIdSpecialStockTgt()),
        () -> assertNull(transaction.getStatCustomsTgt()),
        () -> assertNull(transaction.getStatQualityControlTgt()),
        () -> assertNull(transaction.getIdBatchTgt()),
        () -> assertNull(transaction.getTsBbdTgt()),
        () -> assertNull(transaction.getIdGoodsReceiptTgt()),
        () -> assertNull(transaction.getNumGoodsReceiptItemTgt()),
        () -> assertNull(transaction.getTsGoodsReceiptTgt())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target artvar
   * 
   * @param artvar
   *          expected target artvar
   */
  @Then("transaction {string} has: artvarTgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtArtvar(String keyTransaction, String artvar) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(artvar, transaction.getArtvarTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target stock type
   * 
   * @param typStock
   *          expected target stock type
   */
  @Then("transaction {string} has: typStockTgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtTypStock(String keyTransaction, String typStock) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(typStock, transaction.getTypStockTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target lock type
   * 
   * @param typLock
   *          expected target lock type
   */
  @Then("transaction {string} has: typLockTgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtTypLock(String keyTransaction, String typLock) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(typLock, transaction.getTypLockTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target quality control status
   * 
   * @param qcStat
   *          expected target quality control status
   */
  @Then("the transaction has QC status {string}")
  @Then("transaction {string} has: statQualityControlTgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtQcStat(String keyTransaction, String qcStat) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(qcStat, transaction.getStatQualityControlTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target customs status
   * 
   * @param custStat
   *          expected target customs status
   */
  @Then("transaction {string} has: statCustomsTgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtCustomsStat(String keyTransaction, String custStat) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(custStat, transaction.getStatCustomsTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given source available quantity
   * 
   * @param qtyAvailable
   *          expected target available quantity
   */
  @Then("transaction {string} has: qtyAvailableSrc = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSrcQtyAvailable(String keyTransaction, Double qtyAvailable) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(qtyAvailable, transaction.getQtyAvailableSrc()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given source reserved quantity
   * 
   * @param qtyReserved
   *          expected target reserved quantity
   */
  @Then("transaction {string} has: qtyReservedSrc = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSrcQtyReserved(String keyTransaction, Double qtyReserved) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(qtyReserved, transaction.getQtyReservedSrc()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target available quantity
   * 
   * @param qtyAvailable
   *          expected target available quantity
   */
  @Then("transaction {string} has: qtyAvailableTgt = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtQtyAvailable(String keyTransaction, Double qtyAvailable) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(qtyAvailable, transaction.getQtyAvailableTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target reserved quantity
   * 
   * @param qtyReserved
   *          expected target reserved quantity
   */
  @Then("transaction {string} has: qtyReservedTgt = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtQtyReserved(String keyTransaction, Double qtyReserved) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(qtyReserved, transaction.getQtyReservedTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target batch
   * 
   * @param idBatch
   *          expected target batch
   */
  @Then("transaction {string} has: idBatchTgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtBatch(String keyTransaction, String idBatch) {
    /*
     * if (idBatch != null && !"".equals(idBatch)) { idBatch = inventoryDataHandler.getBatchName(idBatch); }
     */
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(idBatch, transaction.getIdBatchTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target batch
   * 
   * @param bbdAsString
   *          expected target bbd
   * @throws ParseException
   *           if date is not given in correct format
   */
  @Then("transaction {string} has: tsBbdTgt = {Date}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtBbd(String keyTransaction, Date bbd) throws ParseException {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(bbd, transaction.getTsBbdTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction has given source goods receipt
   * 
   * @param goodsReceipt
   *          expected source goods receipt
   * @param goodsReceiptItem
   *          expected source goods receipt item
   * 
   */
  @Then("transaction {string} has: idGoodsReceiptSrc = {String}, numGoodsReceiptItemSrc = {Long}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSrcGR(String keyTransaction, String goodsReceiptSrc, Long goodsReceiptItemSrc) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction, "no transaction created"), 
        () -> assertNotNull(transaction.getIdGoodsReceiptSrc(), "idGoodsReceiptSrc"),
        () -> assertEquals(goodsReceiptSrc, transaction.getIdGoodsReceiptSrc(), "idGoodsReceiptSrc"),
        () -> assertNotNull(transaction.getNumGoodsReceiptItemSrc(), "numGoodsReceiptItemSrc"),
        () -> assertEquals(goodsReceiptItemSrc, transaction.getNumGoodsReceiptItemSrc(), "numGoodsReceiptItemSrc"));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target goods receipt
   * 
   * @param goodsReceipt
   *          expected target goods receipt
   * @param goodsReceiptItem
   *          expected target goods receipt item
   * 
   */
  @Then("transaction {string} has: idGoodsReceiptTgt = {String}, numGoodsReceiptItemTgt = {Long}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtGoodsReceipt(String keyTransaction, String goodsReceipt, Long goodsReceiptItem) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    cucumberReport.setMessage("Transaction: " + transaction.getImTransactionPk());
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction, "no transaction created"), 
        () -> assertNotNull(transaction.getIdGoodsReceiptTgt(), "idGoodsReceiptTgt"),
        () -> assertEquals(goodsReceipt, transaction.getIdGoodsReceiptTgt(), "idGoodsReceiptTgt"),
        () -> assertNotNull(transaction.getNumGoodsReceiptItemTgt(), "numGoodsReceiptItemTgt"),
        () -> assertEquals(goodsReceiptItem, transaction.getNumGoodsReceiptItemTgt(), "numGoodsReceiptItemTgt"));
    //@formatter:on
  }

  /**
   * Verifies that the transaction has given source date of goods receipt
   * 
   * @param grAsString
   *          expected source goods receipt date as string
   * @throws ParseException
   *           if date is not given in correct format
   */
  @Then("transaction {string} has: tsGoodsReceiptSrc = {Date}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSrcGoodsReceiptDate(String keyTransaction, Date goodsReceiptDateSrc) throws ParseException {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction, "transaction"), 
        () -> assertEquals(goodsReceiptDateSrc, transaction.getTsGoodsReceiptSrc(), "tsGoodsReceiptSrc"));
    //@formatter:on
  }

  /**
   * Verifies that the transaction has given target date of goods receipt
   * 
   * @param grAsString
   *          expected target goods receipt date as string
   * @throws ParseException
   *           if date is not given in correct format
   */
  @Then("transaction {string} has: tsGoodsReceiptTgt = {Date}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtGoodsReceiptDate(String keyTransaction, Date goodsReceiptDate) throws ParseException {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction, "transaction"), 
        () -> assertEquals(goodsReceiptDate, transaction.getTsGoodsReceiptTgt(), "tsGoodsReceiptTgt"));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has no source separation criteria
   */
  @Then("transaction {string} has no source separation criteria")
  @Transactional(readOnly = true)
  public void verifyTransactionHasNoSrcSepCrit(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNull(transaction.getSepCrit01Src()),
        () -> assertNull(transaction.getSepCrit02Src()),
        () -> assertNull(transaction.getSepCrit03Src()),
        () -> assertNull(transaction.getSepCrit04Src()),
        () -> assertNull(transaction.getSepCrit05Src()),
        () -> assertNull(transaction.getSepCrit06Src()),
        () -> assertNull(transaction.getSepCrit07Src()),
        () -> assertNull(transaction.getSepCrit08Src()),
        () -> assertNull(transaction.getSepCrit09Src()),
        () -> assertNull(transaction.getSepCrit10Src())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target separation criterion 1
   * 
   * @param sepCrit1
   *          expected target sep crit 1
   */
  @Then("transaction {string} has: sepCrit01Tgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtSepCrit1(String keyTransaction, String sepCrit1) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(sepCrit1, transaction.getSepCrit01Tgt())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given target separation criterion 2
   * 
   * @param sepCrit2
   *          expected target sep crit 2
   */
  @Then("transaction {string} has: sepCrit02Tgt = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtSepCrit2(String keyTransaction, String sepCrit2) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(sepCrit2, transaction.getSepCrit02Tgt())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has no source load unit data
   */
  @Then("transaction {string} has no source load unit data")
  @Transactional(readOnly = true)
  public void verifyTransactionHasNoLoadUnitDataSrc(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNull(transaction.getIdLu1Src()),
        () -> assertNull(transaction.getIdLu2Src()),
        () -> assertNull(transaction.getIdLu3Src()),
        () -> assertNull(transaction.getSsccSrc()),
        () -> assertNull(transaction.getHeightSrc()),
        () -> assertNull(transaction.getWtGrossSrc()),
        () -> assertNull(transaction.getWtTareSrc())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction has given gross weight
   * 
   * @param weight
   *          weight
   */
  @Then("transaction {string} has: wtGrossTgt = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasGrossWeight(String keyTransaction, Double weight) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    assertEquals(weight, transaction.getWtGrossTgt());
  }

  /**
   * Verifies that the transaction has given target load unit tare weight
   * 
   * @param weight
   *          weight
   */
  @Then("all transactions within {string} transaction group have: wtTareTgt = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTgtLuTareWeight(String keyTransaction, Double weight) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getIdClient() != null && actTransaction.getIdArticle() != null) {
        assertEquals(weight, actTransaction.getWtTareTgt());
      }
    }

  }

  /**
   * Verifies that the transaction has given source load unit tare weight
   * 
   * @param weight
   *          weight
   */
  @Then("transaction {string} has: wtTareTgt = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasSrcLuTareWeight(String keyTransaction, Double weight) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    assertEquals(weight, transaction.getWtTareTgt());
  }

  /**
   * Verifies that the transaction has source gross weight
   * 
   */
  @Then("transaction {string} has source gross weight")
  @Transactional(readOnly = true)
  public void verifyTransactionHasGrossWeightSrc(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    assertNotNull(transaction.getWtGrossSrc());
  }

  /**
   * Verifies that the transaction has source load unit gross weight
   * 
   * @param weight
   *          weight
   * 
   */
  @Then("transaction {string} has: wtGrossSrc = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasLuGrossWeightSrc(String keyTransaction, Double weight) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    assertEquals(weight, transaction.getWtGrossSrc());
  }

  /**
   * Verifies that the transaction has target load unit gross weight
   * 
   * @param weight
   *          weight
   * 
   */
  @Then("all transactions within {string} transaction group have: wtGrossTgt = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasLuGrossWeightTgt(String keyTransaction, Double weight) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getIdClient() != null && actTransaction.getIdArticle() != null) {
        assertEquals(weight, actTransaction.getWtGrossTgt());
      }
    }

  }

  /**
   * Verifies that the transaction has target gross weight
   * 
   */
  @Then("transaction {string} has target gross weight")
  @Transactional(readOnly = true)
  public void verifyTransactionHasGrossWeightTgt(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    assertNotNull(transaction.getWtGrossTgt());
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given type of qty
   * 
   * 
   * @param typQty
   *          expected type of qty
   */
  @Then("transaction {string} has: typQuantity = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTypQty(String keyTransaction, String typQty) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(typQty, transaction.getTypQuantity()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given type of correction
   * 
   * @param typCorrection
   *          expected type of correction
   */
  @Then("transaction {string} has: typCorrection = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTypCorrection(String keyTransaction, String typCorrection) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(typCorrection, transaction.getTypCorrection()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has no target load unit data
   */
  @Then("transaction {string} has no target load unit data")
  @Transactional(readOnly = true)
  public void verifyTransactionHasNoLoadUnitDataTgt(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNull(transaction.getIdLu1Tgt()),
        () -> assertNull(transaction.getIdLu2Tgt()),
        () -> assertNull(transaction.getIdLu3Tgt()),
        () -> assertNull(transaction.getHeightTgt()),
        () -> assertNull(transaction.getWtGrossTgt()),
        () -> assertNull(transaction.getWtTareTgt())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction moved the expected available quantity from src to tgt
   * 
   * @param qtyAvailable
   * 
   * @param storageAreaSrc
   * 
   * @param storageLocationSrc
   * 
   * @param storageAreaTgt
   * 
   * @param storageLocationTgt
   * 
   */
  @Then("transaction {string} moved {Double} pieces from {string}-{string} to {string}-{string} to increase the available quantity")
  @Transactional(readOnly = true)
  public void verifyTransactionMovedQtyAvailable(String keyTransaction, Double qtyAvailable, String storageAreaSrc, String storageLocationSrc,
      String storageAreaTgt, String storageLocationTgt) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(qtyAvailable, transaction.getQtyMoved()),
        () -> assertEquals(storageAreaSrc, transaction.getStorageAreaSrc()),
        () -> assertEquals(storageLocationSrc, transaction.getStorageLocationSrc()),
        () -> assertEquals(storageLocationTgt, transaction.getStorageLocationTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has given type of transaction
   * 
   * @param typTransaction
   *          expected type of transaction
   */
  @Then("transaction {string} has: typTransaction = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasTypTransaction(String keyTransaction, String typTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(typTransaction, transaction.getTypTransaction()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction has correct client and aericle
   * 
   * @param client
   * 
   * @param article
   * 
   */
  @Then("all transactions within {string} transaction group have: idClient = {String}, idArticle = {String}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasClientArticle(String keyTransaction, String client, String article) {
    List<ImTransaction> transaction = transactionHelper.readTransactionGrpList(keyTransaction);

    for (ImTransaction actTransaction : transaction) {
      if (actTransaction.getIdClient() != null && actTransaction.getIdArticle() != null) {
    //@formatter:off
      assertAll(
          () -> assertNotNull(transaction), 
          () -> assertEquals(client, actTransaction.getIdClient()),
          () -> assertEquals(article, actTransaction.getIdArticle()));
      //@formatter:on
      }
    }

  }

  /**
   * Verifies that the transaction moved the expected quantity
   * 
   * @param qty
   * 
   */
  @Then("transaction {string} has: qtyMoved = {Double}")
  @Transactional(readOnly = true)
  public void verifyTransactionMovedQty(String keyTransaction, Double qty) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(qty, transaction.getQtyMoved()));
    //@formatter:on
  }

  /**
   * Verifies that the quantum data of transaction created by the prior webservice call are equal
   * 
   */
  @Then("transaction {string} has equal idQuantumSrc and idQuantumTgt")
  @Transactional(readOnly = true)
  public void verifyTransactionSrcQauntumTgtQuantumAreEqual(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertEquals(transaction.getIdQuantumSrc(), transaction.getIdQuantumTgt())
        );
    //@formatter:on
  }

  /**
   * Verifies that the quantum data of transaction created by the prior webservice call are equal
   * 
   */
  @Then("transaction {string} has not equal idQuantumSrc and idQuantumTgt")
  @Transactional(readOnly = true)
  public void verifyTransactionSrcQauntumTgtQuantumAreNotEqual(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNotSame(transaction.getIdQuantumSrc(), transaction.getIdQuantumTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction created by the prior webservice call has target load unit data
   */
  @Then("transaction {string} has target load unit data")
  @Transactional(readOnly = true)
  public void verifyTransactionHasLoadUnitDataTgt(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(
        () -> assertNotNull(transaction), 
        () -> assertNotNull(transaction.getIdLu1Tgt()),
        () -> assertNotNull(transaction.getHeightTgt()),
        () -> assertNotNull(transaction.getWtGrossTgt()),
        () -> assertNotNull(transaction.getWtTareTgt())
        );
    //@formatter:on
  }

  /**
   * Verifies that the transaction that was created by the prior webservice call referenced the quantum that was changed
   * 
   */
  @Then("transaction {string} has: idQuantumTgt = {StringExt}")
  @Transactional(readOnly = true)
  public void verifyTransactionReferencesQuantum(String keyTransaction, GherkinType<String> idQuantumTgt) {
    idQuantumTgt.setGetterForKey(inventoryDataHandler.idQuGetter);
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(() -> assertNotNull(transaction),
              () -> assertEquals(idQuantumTgt.get(), transaction.getIdQuantumTgt()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction that was created by the prior webservice call referenced the target quantum that was changed
   * 
   */
  @Then("transaction {string} has: BBDTgt = {Date}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasBBDTgt(String keyTransaction, Date BBDTgt) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(() -> assertNotNull(transaction),
              () -> assertEquals(BBDTgt, transaction.getTsBbdTgt()));
   //@formatter:on
  }

  /**
   * Verifies that the quantum that was created by the prior webservice call has the changed BBD
   * 
   * @param chgBbd
   *          requested changed BBD
   * 
   */
  @Then("transaction {string} has: BBD = {Date}")
  @Transactional(readOnly = true)
  public void verifyquantumHasBBD(String key, String chgBbd) {
    ImQuantum quantum = inventoryDataHandler.getQuantum(key);
    //@formatter:off
    assertAll(() -> assertNotNull(quantum), 
              () -> assertEquals(chgBbd, quantum.getStatCustoms()));
    //@formatter:on
  }

  /**
   * Verifies that the transaction that was created by the prior webservice call referenced the source quantum that was changed
   * 
   */
  @Then("transaction {string} has: BBDSrc = {Date}")
  @Transactional(readOnly = true)
  public void verifyTransactionHasBBDSrc(String keyTransaction, Date BBDSrc) {

    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(() -> assertNotNull(transaction),
              () -> assertEquals(BBDSrc, transaction.getTsBbdSrc()));
    //@formatter:on
  }

  @Then("transaction {string} has: attributesSrc = {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}")
  public void transactionHasAttributesSrc(String keyTransaction, String a01, String a02, String a03, String a04, String a05, String a06, String a07,
      String a08, String a09, String a10, String a11, String a12, String a13, String a14, String a15, String a16, String a17, String a18, String a19,
      String a20) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(    () -> assertEquals(a01, transaction.getAttribute01Src()),
                  () -> assertEquals(a02, transaction.getAttribute02Src()),
                  () -> assertEquals(a03, transaction.getAttribute03Src()), 
                  () -> assertEquals(a04, transaction.getAttribute04Src()),
                  () -> assertEquals(a05, transaction.getAttribute05Src()), 
                  () -> assertEquals(a06, transaction.getAttribute06Src()),
                  () -> assertEquals(a07, transaction.getAttribute07Src()), 
                  () -> assertEquals(a08, transaction.getAttribute08Src()),
                  () -> assertEquals(a09, transaction.getAttribute09Src()), 
                  () -> assertEquals(a10, transaction.getAttribute10Src()),
                  () -> assertEquals(a11, transaction.getAttribute11Src()),
                  () -> assertEquals(a12, transaction.getAttribute12Src()),
                  () -> assertEquals(a13, transaction.getAttribute13Src()), 
                  () -> assertEquals(a14, transaction.getAttribute14Src()),
                  () -> assertEquals(a15, transaction.getAttribute15Src()), 
                  () -> assertEquals(a16, transaction.getAttribute16Src()),
                  () -> assertEquals(a17, transaction.getAttribute17Src()), 
                  () -> assertEquals(a18, transaction.getAttribute18Src()),
                  () -> assertEquals(a19, transaction.getAttribute19Src()),
                  () -> assertEquals(a20, transaction.getAttribute20Src()));
    //@formatter:on
  }

  @Then("transaction {string} has: attributesTgt = {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}")
  public void transactionHasAttributesTgt(String keyTransaction, String a01, String a02, String a03, String a04, String a05, String a06, String a07,
      String a08, String a09, String a10, String a11, String a12, String a13, String a14, String a15, String a16, String a17, String a18, String a19,
      String a20) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    //@formatter:off
    assertAll(  () -> assertEquals(a01, transaction.getAttribute01Tgt()), 
                () -> assertEquals(a02, transaction.getAttribute02Tgt()),
                () -> assertEquals(a03, transaction.getAttribute03Tgt()), 
                () -> assertEquals(a04, transaction.getAttribute04Tgt()),
                () -> assertEquals(a05, transaction.getAttribute05Tgt()), 
                () -> assertEquals(a06, transaction.getAttribute06Tgt()),
                () -> assertEquals(a07, transaction.getAttribute07Tgt()), 
                () -> assertEquals(a08, transaction.getAttribute08Tgt()),
                () -> assertEquals(a09, transaction.getAttribute09Tgt()), 
                () -> assertEquals(a10, transaction.getAttribute10Tgt()),
                () -> assertEquals(a11, transaction.getAttribute11Tgt()), 
                () -> assertEquals(a12, transaction.getAttribute12Tgt()),
                () -> assertEquals(a13, transaction.getAttribute13Tgt()), 
                () -> assertEquals(a14, transaction.getAttribute14Tgt()),
                () -> assertEquals(a15, transaction.getAttribute15Tgt()), 
                () -> assertEquals(a16, transaction.getAttribute16Tgt()),
                () -> assertEquals(a17, transaction.getAttribute17Tgt()), 
                () -> assertEquals(a18, transaction.getAttribute18Tgt()),
                () -> assertEquals(a19, transaction.getAttribute19Tgt()), 
                () -> assertEquals(a20, transaction.getAttribute20Tgt()));
    //@formatter:on
  }

}
