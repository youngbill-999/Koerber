package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.grbase.pers.gen.GrReceivingPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inventory.pers.rep.ImQuantumRep;
import com.inconso.bend.inventory.pers.rep.ImTransactionRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.grbase.GrBaseDataHandler;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;

public class InventoryFieldVerifier {

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private GrBaseDataHandler    grBaseDataHandler;

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private ImQuantumRep         imQuantumRep;

  @Autowired
  private ImTransactionRep     imTransactionRep;

  @Autowired
  private ImLoadUnitRep        imLoadUnitRep;

  //@formatter:off
  private void verifyTransaction(ImTransaction record,
      GherkinType<String> typTransaction, GherkinType<String> idClient, GherkinType<String> idTransaction,
      GherkinType<String> stat, GherkinType<String> situation, GherkinType<String> idCre, GherkinType<Date> tsCre, GherkinType<String> idUpd, GherkinType<Date> tsUpd,
      GherkinType<String> storageAreaSrc, GherkinType<String> storageLocationSrc, GherkinType<String> storageAreaTgt, GherkinType<String> storageLocationTgt,
      
      GherkinType<String> ssccSrc, GherkinType<String> idLuSrc,
      GherkinType<String> idLu1Src, GherkinType<String> typLu1Src,
      GherkinType<String> idLu2Src, GherkinType<String> typLu2Src,
      GherkinType<String> idLu3Src, GherkinType<String> typLu3Src,
      GherkinType<Double> heightSrc, GherkinType<Double> volSrc, GherkinType<Double> wtGrossSrc, GherkinType<Double> wtTareSrc, 
      
      GherkinType<String> ssccTgt, GherkinType<String> idLuTgt,
      GherkinType<String> idLu1Tgt, GherkinType<String> typLu1Tgt,
      GherkinType<String> idLu2Tgt, GherkinType<String> typLu2Tgt,
      GherkinType<String> idLu3Tgt, GherkinType<String> typLu3Tgt,
      GherkinType<Double> heightTgt, GherkinType<Double> volTgt, GherkinType<Double> wtGrossTgt, GherkinType<Double> wtTareTgt, 
      
      GherkinType<String> idArticle, GherkinType<Double> qtyMoved,
      
      GherkinType<String> idQuantumSrc, GherkinType<String> artvarSrc, GherkinType<Double> volQuantumSrc, GherkinType<Double> wtGrossQuantumSrc,
      GherkinType<Double> qtyAvailableSrc, GherkinType<Double> qtyReservedSrc, GherkinType<String> typStockSrc, GherkinType<String> typLockSrc,
      GherkinType<String> statQualityControlSrc, GherkinType<String> statCustomsSrc, GherkinType<String> idBatchSrc, GherkinType<Date> tsBbdSrc,
      GherkinType<String> sepCrit01Src, GherkinType<String> sepCrit02Src, GherkinType<String> sepCrit03Src, GherkinType<String> sepCrit04Src, GherkinType<String> sepCrit05Src, 
      GherkinType<String> sepCrit06Src, GherkinType<String> sepCrit07Src, GherkinType<String> sepCrit08Src, GherkinType<String> sepCrit09Src, GherkinType<String> sepCrit10Src, 
      GherkinType<String> idSpecialStockSrc, GherkinType<String> typSpecialStockSrc,
      
      GherkinType<String> idQuantumTgt, GherkinType<String> artvarTgt, GherkinType<Double> volQuantumTgt, GherkinType<Double> wtGrossQuantumTgt,
      GherkinType<Double> qtyAvailableTgt, GherkinType<Double> qtyReservedTgt, GherkinType<String> typStockTgt, GherkinType<String> typLockTgt,
      GherkinType<String> statQualityControlTgt, GherkinType<String> statCustomsTgt, GherkinType<String> idBatchTgt, GherkinType<Date> tsBbdTgt,
      GherkinType<String> sepCrit01Tgt, GherkinType<String> sepCrit02Tgt, GherkinType<String> sepCrit03Tgt, GherkinType<String> sepCrit04Tgt, GherkinType<String> sepCrit05Tgt,
      GherkinType<String> sepCrit06Tgt, GherkinType<String> sepCrit07Tgt, GherkinType<String> sepCrit08Tgt, GherkinType<String> sepCrit09Tgt, GherkinType<String> sepCrit10Tgt,      
      GherkinType<String> idSpecialStockTgt, GherkinType<String> typSpecialStockTgt,

      GherkinType<String> idGoodsReceiptSrc, GherkinType<Long> numGoodsReceiptItemSrc, GherkinType<Date> tsGoodsReceiptSrc,
      GherkinType<String> idGoodsReceiptTgt, GherkinType<Long> numGoodsReceiptItemTgt, GherkinType<Date> tsGoodsReceiptTgt,
            
      GherkinType<String> typRelocation,
      GherkinType<String> typQuantity,
      GherkinType<String> typCorrection,
      GherkinType<String> idTransactionModify,
      GherkinType<String> reasonTransaction1,
      GherkinType<String> reasonTransaction2,

      // booking type High-Level Reservation:
      GherkinType<String> idReservationHl,
      GherkinType<String> idStoreOutZoneHl,
      GherkinType<String> storageAreaHl,
      GherkinType<String> storageLocationHl,
      
      // booking type Batchmanagement (BM):
      GherkinType<String> batchAttribute,
      GherkinType<Date> tsBatchFirstGoodsReceipt,
      GherkinType<String> batchValueSrc,
      GherkinType<String> statBatchSrc,
      GherkinType<String> statBatchLockSrc,
      GherkinType<String> batchValueTgt,
      GherkinType<String> statBatchTgt,
      GherkinType<String> statBatchLockTgt      
    ) {

    idLuSrc.setGetterForKey(inventoryDataHandler.idLuGetter);
    idLu1Src.setGetterForKey(inventoryDataHandler.idLuGetter);
    idLu2Src.setGetterForKey(inventoryDataHandler.idLuGetter);
    idLu3Src.setGetterForKey(inventoryDataHandler.idLuGetter);
    idLuTgt.setGetterForKey(inventoryDataHandler.idLuGetter);
    idLu1Tgt.setGetterForKey(inventoryDataHandler.idLuGetter);
    idLu2Tgt.setGetterForKey(inventoryDataHandler.idLuGetter);
    idLu3Tgt.setGetterForKey(inventoryDataHandler.idLuGetter);
    idTransaction.setGetterForKey(inventoryDataHandler.idTransactionGetter);
    idQuantumSrc.setGetterForKey(inventoryDataHandler.idQuGetter);
    idQuantumTgt.setGetterForKey(inventoryDataHandler.idQuGetter);

    Long numGoodsReceiptItemSrcActual = (record.getNumGoodsReceiptItemSrc() == null) ? null : (record.getNumGoodsReceiptItemSrc() - grBaseDataHandler.getReceivingItemCount(new GrReceivingPk(generalHelper.getIdSite(), record.getIdClient(), record.getIdGoodsReceiptSrc())));
    Long numGoodsReceiptItemTgtActual = (record.getNumGoodsReceiptItemTgt() == null) ? null : (record.getNumGoodsReceiptItemTgt() - grBaseDataHandler.getReceivingItemCount(new GrReceivingPk(generalHelper.getIdSite(), record.getIdClient(), record.getIdGoodsReceiptTgt())));
    
    assertAll(
        () -> assertNotNull(record, "transaction"), 
        () -> typTransaction.assertEquality(record.getTypTransaction(), "typTransaction"),
        () -> assertEquals(generalHelper.getIdSite(), record.getImTransactionPk().getIdSite(), "idSite"),
        () -> idClient.assertEquality(record.getIdClient(), "idClient"),
        () -> idTransaction.assertEquality(record.getImTransactionPk().getIdTransaction(), "idTransaction"),
        
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> situation.assertEquality(record.getSituation(), "situation"),
        () -> idCre.assertEquality(record.getIdCre(), "idCre"),
        () -> tsCre.assertEquality(record.getTsCre(), "tsCre"),
        () -> idUpd.assertEquality(record.getIdUpd(), "idUpd"),
        () -> tsUpd.assertEquality(record.getTsUpd(), "tsUpd"),

        () -> storageAreaSrc.assertEquality(record.getStorageAreaSrc(), "storageAreaSrc"),
        () -> storageLocationSrc.assertEquality(record.getStorageLocationSrc(), "storageLocationSrc"),
        () -> storageAreaTgt.assertEquality(record.getStorageAreaTgt(), "storageAreaTgt"),
        () -> storageLocationTgt.assertEquality(record.getStorageLocationTgt(), "storageLocationTgt"),

        () -> ssccSrc.assertEquality(record.getSsccSrc(), "ssccSrc"),
        () -> idLuSrc.assertEquality(record.getIdLuSrc(), "idLuSrc"),
        () -> idLu1Src.assertEquality(record.getIdLu1Src(), "idLu1Src"),
        () -> typLu1Src.assertEquality(record.getTypLu1Src(), "typLu1Src"),
        () -> idLu2Src.assertEquality(record.getIdLu2Src(), "idLu2Src"),
        () -> typLu2Src.assertEquality(record.getTypLu2Src(), "typLu2Src"),
        () -> idLu3Src.assertEquality(record.getIdLu3Src(), "idLu3Src"),
        () -> typLu3Src.assertEquality(record.getTypLu3Src(), "typLu3Src"),
        () -> heightSrc.assertEquality(record.getHeightSrc(), "heightSrc"),
        () -> volSrc.assertEquality(record.getVolSrc(), "volSrc"),
        () -> wtGrossSrc.assertEquality(record.getWtGrossSrc(), "wtGrossSrc"),
        () -> wtTareSrc.assertEquality(record.getWtTareSrc(), "wtTareSrc"),

        () -> ssccTgt.assertEquality(record.getSsccTgt(), "ssccTgt"),
        () -> idLuTgt.assertEquality(record.getIdLuTgt(), "idLuTgt"),
        () -> idLu1Tgt.assertEquality(record.getIdLu1Tgt(), "idLu1Tgt"),
        () -> typLu1Tgt.assertEquality(record.getTypLu1Tgt(), "typLu1Tgt"),
        () -> idLu2Tgt.assertEquality(record.getIdLu2Tgt(), "idLu2Tgt"),
        () -> typLu2Tgt.assertEquality(record.getTypLu2Tgt(), "typLu2Tgt"),
        () -> idLu3Tgt.assertEquality(record.getIdLu3Tgt(), "idLu3Tgt"),
        () -> typLu3Tgt.assertEquality(record.getTypLu3Tgt(), "typLu3Tgt"),
        () -> heightTgt.assertEquality(record.getHeightTgt(), "heightTgt"),
        () -> volTgt.assertEquality(record.getVolTgt(), "volTgt"),
        () -> wtGrossTgt.assertEquality(record.getWtGrossTgt(), "wtGrossTgt"),
        () -> wtTareTgt.assertEquality(record.getWtTareTgt(), "wtTareTgt"),

        () -> idArticle.assertEquality(record.getIdArticle(), "idArticle"),
        () -> qtyMoved.assertEquality(record.getQtyMoved(), "qtyMoved"),

        () -> idQuantumSrc.assertEquality(record.getIdQuantumSrc(), "idQuantumSrc"),
        () -> artvarSrc.assertEquality(record.getArtvarSrc(), "artvarSrc"),
        () -> volQuantumSrc.assertEquality(record.getVolQuantumSrc(), "volQuantumSrc"),
        () -> wtGrossQuantumSrc.assertEquality(record.getWtGrossQuantumSrc(), "wtGrossQuantumSrc"),
        () -> qtyAvailableSrc.assertEquality(record.getQtyAvailableSrc(), "qtyAvailableSrc"),
        () -> qtyReservedSrc.assertEquality(record.getQtyReservedSrc(), "qtyReservedSrc"),
        () -> typStockSrc.assertEquality(record.getTypStockSrc(), "typStockSrc"),
        () -> typLockSrc.assertEquality(record.getTypLockSrc(), "typLockSrc"),
        () -> statQualityControlSrc.assertEquality(record.getStatQualityControlSrc(), "statQualityControlSrc"),
        () -> statCustomsSrc.assertEquality(record.getStatCustomsSrc(), "statCustomsSrc"),
        () -> idBatchSrc.assertEquality(record.getIdBatchSrc(), "idBatchSrc"),
        () -> tsBbdSrc.assertEquality(record.getTsBbdSrc(), "tsBbdSrc"),
        () -> sepCrit01Src.assertEquality(record.getSepCrit01Src(), "sepCrit01Src"),
        () -> sepCrit02Src.assertEquality(record.getSepCrit02Src(), "sepCrit02Src"),
        () -> sepCrit03Src.assertEquality(record.getSepCrit03Src(), "sepCrit03Src"),
        () -> sepCrit04Src.assertEquality(record.getSepCrit04Src(), "sepCrit04Src"),
        () -> sepCrit05Src.assertEquality(record.getSepCrit05Src(), "sepCrit05Src"),
        () -> sepCrit06Src.assertEquality(record.getSepCrit06Src(), "sepCrit06Src"),
        () -> sepCrit07Src.assertEquality(record.getSepCrit07Src(), "sepCrit07Src"),
        () -> sepCrit08Src.assertEquality(record.getSepCrit08Src(), "sepCrit08Src"),
        () -> sepCrit09Src.assertEquality(record.getSepCrit09Src(), "sepCrit09Src"),
        () -> sepCrit10Src.assertEquality(record.getSepCrit10Src(), "sepCrit10Src"),
        () -> idSpecialStockSrc.assertEquality(record.getIdSpecialStockSrc(), "idSpecialStockSrc"),
        () -> typSpecialStockSrc.assertEquality(record.getTypSpecialStockSrc(), "typSpecialStockSrc"),
        
        () -> idQuantumTgt.assertEquality(record.getIdQuantumTgt(), "idQuantumTgt"),
        () -> artvarTgt.assertEquality(record.getArtvarTgt(), "artvarTgt"),
        () -> volQuantumTgt.assertEquality(record.getVolQuantumTgt(), "volQuantumTgt"),
        () -> wtGrossQuantumTgt.assertEquality(record.getWtGrossQuantumTgt(), "wtGrossQuantumTgt"),
        () -> qtyAvailableTgt.assertEquality(record.getQtyAvailableTgt(), "qtyAvailableTgt"),
        () -> qtyReservedTgt.assertEquality(record.getQtyReservedTgt(), "qtyReservedTgt"),
        () -> typStockTgt.assertEquality(record.getTypStockTgt(), "typStockTgt"),
        () -> typLockTgt.assertEquality(record.getTypLockTgt(), "typLockTgt"),
        () -> statQualityControlTgt.assertEquality(record.getStatQualityControlTgt(), "statQualityControlTgt"),
        () -> statCustomsTgt.assertEquality(record.getStatCustomsTgt(), "statCustomsTgt"),
        () -> idBatchTgt.assertEquality(record.getIdBatchTgt(), "idBatchTgt"),
        () -> tsBbdTgt.assertEquality(record.getTsBbdTgt(), "tsBbdTgt"),
        () -> sepCrit01Tgt.assertEquality(record.getSepCrit01Tgt(), "sepCrit01Tgt"),
        () -> sepCrit02Tgt.assertEquality(record.getSepCrit02Tgt(), "sepCrit02Tgt"),
        () -> sepCrit03Tgt.assertEquality(record.getSepCrit03Tgt(), "sepCrit03Tgt"),
        () -> sepCrit04Tgt.assertEquality(record.getSepCrit04Tgt(), "sepCrit04Tgt"),
        () -> sepCrit05Tgt.assertEquality(record.getSepCrit05Tgt(), "sepCrit05Tgt"),
        () -> sepCrit06Tgt.assertEquality(record.getSepCrit06Tgt(), "sepCrit06Tgt"),
        () -> sepCrit07Tgt.assertEquality(record.getSepCrit07Tgt(), "sepCrit07Tgt"),
        () -> sepCrit08Tgt.assertEquality(record.getSepCrit08Tgt(), "sepCrit08Tgt"),
        () -> sepCrit09Tgt.assertEquality(record.getSepCrit09Tgt(), "sepCrit09Tgt"),
        () -> sepCrit10Tgt.assertEquality(record.getSepCrit10Tgt(), "sepCrit10Tgt"),
        () -> idSpecialStockTgt.assertEquality(record.getIdSpecialStockTgt(), "idSpecialStockTgt"),
        () -> typSpecialStockTgt.assertEquality(record.getTypSpecialStockTgt(), "typSpecialStockTgt"),
        
        () -> idGoodsReceiptSrc.assertEquality(record.getIdGoodsReceiptSrc(), "idGoodsReceiptSrc"),
        () -> numGoodsReceiptItemSrc.assertEquality(numGoodsReceiptItemSrcActual, "numGoodsReceiptItemSrc"),
        () -> tsGoodsReceiptSrc.assertEquality(record.getTsGoodsReceiptSrc(), "tsGoodsReceiptSrc"),
        () -> idGoodsReceiptTgt.assertEquality(record.getIdGoodsReceiptTgt(), "idGoodsReceiptTgt"),
        () -> numGoodsReceiptItemTgt.assertEquality(numGoodsReceiptItemTgtActual, "numGoodsReceiptItemTgt"),
        () -> tsGoodsReceiptTgt.assertEquality(record.getTsGoodsReceiptTgt(), "tsGoodsReceiptTgt"),
        
        () -> typRelocation.assertEquality(record.getTypRelocation(), "typRelocation"),
        () -> typQuantity.assertEquality(record.getTypQuantity(), "typQuantity"),
        () -> typCorrection.assertEquality(record.getTypCorrection(), "typCorrection"),
        () -> idTransactionModify.assertEquality(record.getIdTransactionModify(), "idTransactionModify"),
        () -> reasonTransaction1.assertEquality(record.getReasonTransaction1(), "reasonTransaction1"),
        () -> reasonTransaction2.assertEquality(record.getReasonTransaction2(), "reasonTransaction2"),

        // booking type High-Level Reservation:
        () -> idReservationHl.assertEquality(record.getIdReservationHl(), "idReservationHl"),
        () -> idStoreOutZoneHl.assertEquality(record.getIdStoreOutZoneHl(), "idStoreOutZoneHl"),
        () -> storageAreaHl.assertEquality(record.getStorageAreaHl(), "storageAreaHl"),
        () -> storageLocationHl.assertEquality(record.getStorageLocationHl(), "storageLocationHl"),

        // booking type Batchmanagement (BM):
        () -> batchAttribute.assertEquality(record.getBatchAttribute(), "batchAttribute"),
        () -> tsBatchFirstGoodsReceipt.assertEquality(record.getTsBatchFirstGoodsReceipt(), "tsBatchFirstGoodsReceipt"),
        () -> batchValueSrc.assertEquality(record.getBatchValueSrc(), "batchValueSrc"),
        () -> statBatchSrc.assertEquality(record.getStatBatchSrc(), "statBatchSrc"),
        () -> statBatchLockSrc.assertEquality(record.getStatBatchLockSrc(), "statBatchLockSrc"),
        () -> batchValueTgt.assertEquality(record.getBatchValueTgt(), "batchValueTgt"),
        () -> statBatchTgt.assertEquality(record.getStatBatchTgt(), "statBatchTgt"),
        () -> statBatchLockTgt.assertEquality(record.getStatBatchLockTgt(), "statBatchLockTgt")
    );
    // Kontextabhaengig LE/Quant? :  volSrc  wtGrossSrc  wtTareSrc  volTgt  wtGrossTgt  wtTareTgt
  }
  //@formatter:on

  @Then("transaction {string} has: typRef = {string}, matches {string}")
  public void verifyTransactionRef(String keyTransaction, String typRef, String keyObject) {
    ImTransaction record = inventoryDataHandler.getTransaction(keyTransaction);
    assertNotNull(record, "transaction");
    String[] ref = { record.getTypRef(), record.getIdRef1(), record.getIdRef2(), record.getIdRef3(), record.getIdRef4(), record.getIdRef5(),
        record.getIdRef6() };

    generalHelper.verifyReference(keyObject, typRef, ref);
  }

  @Then("transactions have same idTransactionGrp:")
  public void verifyTransactionGrp(DataTable table) {
    List<String> list = table.asList();
    ImTransaction pivot = inventoryDataHandler.getTransaction(list.get(0));

    for (String key : list) {
      assertEquals(pivot.getIdTransactionGrp(), inventoryDataHandler.getTransaction(key).getIdTransactionGrp(), key);
    }
  }

  //@formatter:off
  @Then("CRELU transaction {string} has: idTransaction = {StringExt}, "
      + "stat = {StringExt}, situation = {StringExt}, idCre = {StringExt}, tsCre = {DateTimeExt}, "
      + "storageAreaSrc = {StringExt}, storageLocationSrc = {StringExt}, storageAreaTgt = {StringExt}, storageLocationTgt = {StringExt}, "
      + "idLu = {StringExt}, typLu = {StringExt}, height = {DoubleExt}, vol = {DoubleExt}, wt = {DoubleExt}")
  public void verifyTransactionCrelu(String keyTransaction,
      GherkinType<String> idTransaction,
      GherkinType<String> stat, GherkinType<String> situation, GherkinType<String> idCre, GherkinType<Date> tsCre,
      GherkinType<String> storageAreaSrc, GherkinType<String> storageLocationSrc, GherkinType<String> storageAreaTgt, GherkinType<String> storageLocationTgt,
      GherkinType<String> idLu,
      GherkinType<String> typLu,
      GherkinType<Double> height, GherkinType<Double> vol, GherkinType<Double> wt
    ) {
    ImTransaction record = inventoryDataHandler.getTransaction(keyTransaction);

    verifyTransaction(record, GherkinType.of("CRELU"), GherkinType.of(null), idTransaction,
        stat, situation, idCre, tsCre, idCre, tsCre, storageAreaSrc, storageLocationSrc, storageAreaTgt, storageLocationTgt,
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),  GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.ignore(), idLu, idLu, typLu, GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), height, vol, wt, wt,
        GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null)
    );
  }
  //@formatter:on

  //@formatter:off
  @Then("CREQU transaction {string} has: idTransaction = {StringExt}, "
      + "stat = {StringExt}, situation = {StringExt}, idCre = {StringExt}, tsCre = {DateTimeExt}, "
      + "storageAreaSrc = {StringExt}, storageLocationSrc = {StringExt}, storageAreaTgt = {StringExt}, storageLocationTgt = {StringExt}, "
      + "idLu1 = {StringExt}, typLu1 = {StringExt}, idLu2 = {StringExt}, typLu2 = {StringExt}, idLu3 = {StringExt}, typLu3 = {StringExt}, "
      + "height = {DoubleExt}, vol = {DoubleExt}, wtGross = {DoubleExt}, wtTare = {DoubleExt}, "
      + "idArticle = {StringExt}, qtyMoved = {DoubleExt}, "
      + "idQuantum = {StringExt}, artvar = {StringExt}, volQuantum = {DoubleExt}, wtGrossQuantum = {DoubleExt}, "
      + "typStock = {StringExt}, typLock = {StringExt}, "
      + "statQualityControl = {StringExt}, statCustoms = {StringExt}, idBatch = {StringExt}, tsBbd = {DateTimeExt}, "
      + "sepCrit01 = {StringExt}, sepCrit02 = {StringExt}, sepCrit03 = {StringExt}, sepCrit04 = {StringExt}, sepCrit05 = {StringExt}, "
      + "sepCrit06 = {StringExt}, sepCrit07 = {StringExt}, sepCrit08 = {StringExt}, sepCrit09 = {StringExt}, sepCrit10 = {StringExt}, "
      + "idSpecialStock = {StringExt}, typSpecialStock = {StringExt}, "
      + "idGoodsReceipt = {StringExt}, numGoodsReceiptItem = {LongExt}, tsGoodsReceipt = {DateTimeExt}")
  public void verifyTransactionCrequ(String keyTransaction,
      GherkinType<String> idTransaction,
      GherkinType<String> stat, GherkinType<String> situation, GherkinType<String> idCre, GherkinType<Date> tsCre,
      GherkinType<String> storageAreaSrc, GherkinType<String> storageLocationSrc, GherkinType<String> storageAreaTgt, GherkinType<String> storageLocationTgt,
            
      GherkinType<String> idLu1, GherkinType<String> typLu1,
      GherkinType<String> idLu2, GherkinType<String> typLu2,
      GherkinType<String> idLu3, GherkinType<String> typLu3,
      GherkinType<Double> height, GherkinType<Double> vol, GherkinType<Double> wtGross, GherkinType<Double> wtTare, 
      
      GherkinType<String> idArticle, GherkinType<Double> qtyMoved,
      
      GherkinType<String> idQuantum, GherkinType<String> artvar, GherkinType<Double> volQuantum, GherkinType<Double> wtGrossQuantum,
      GherkinType<String> typStock, GherkinType<String> typLock,
      GherkinType<String> statQualityControl, GherkinType<String> statCustoms, GherkinType<String> idBatch, GherkinType<Date> tsBbd,
      GherkinType<String> sepCrit01, GherkinType<String> sepCrit02, GherkinType<String> sepCrit03, GherkinType<String> sepCrit04, GherkinType<String> sepCrit05,
      GherkinType<String> sepCrit06, GherkinType<String> sepCrit07, GherkinType<String> sepCrit08, GherkinType<String> sepCrit09, GherkinType<String> sepCrit10,      
      GherkinType<String> idSpecialStock, GherkinType<String> typSpecialStock,

      GherkinType<String> idGoodsReceipt, GherkinType<Long> numGoodsReceiptItem, GherkinType<Date> tsGoodsReceipt
    ) {
    idGoodsReceipt.setGetterForKey(grBaseDataHandler.idGoodsReceiptGetter);
    
    ImTransaction record = inventoryDataHandler.getTransaction(keyTransaction);

    verifyTransaction(record, GherkinType.of("CREQU"), GherkinType.of(generalHelper.getIdClient()), idTransaction,
        stat, situation, idCre, tsCre, idCre, tsCre, storageAreaSrc, storageLocationSrc, storageAreaTgt, storageLocationTgt,
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),  GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.ignore(), GherkinType.of(null), idLu1, typLu1, idLu2, typLu3, idLu3, typLu3, height, vol, wtGross, wtTare,
        idArticle, qtyMoved,
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null),
        idQuantum, artvar, volQuantum, wtGrossQuantum,
        qtyMoved, GherkinType.of(0.0), typStock, typLock,
        statQualityControl, statCustoms, idBatch, tsBbd,
        sepCrit01, sepCrit02, sepCrit03, sepCrit04, sepCrit05, sepCrit06, sepCrit07, sepCrit08, sepCrit09, sepCrit10,
        idSpecialStock, typSpecialStock,
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        idGoodsReceipt, numGoodsReceiptItem, tsGoodsReceipt,
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null)
    );
  }
  //@formatter:on

  //@formatter:off
  @Then("RELLU transaction {string} has: idTransaction = {StringExt}, "
      + "stat = {StringExt}, situation = {StringExt}, idCre = {StringExt}, tsCre = {DateTimeExt}, idUpd = {StringExt}, tsUpd = {DateTimeExt}, "
      + "storageAreaSrc = {StringExt}, storageLocationSrc = {StringExt}, storageAreaTgt = {StringExt}, storageLocationTgt = {StringExt}, "
      + "idLu = {StringExt}, idLu1 = {StringExt}, typLu1 = {StringExt}, idLu2 = {StringExt}, typLu2 = {StringExt}, idLu3 = {StringExt}, typLu3 = {StringExt}, "
      + "height = {DoubleExt}, vol = {DoubleExt}, wtGross = {DoubleExt}, wtTare = {DoubleExt}, "
      + "idArticle = {StringExt}, "
      + "idQuantum = {StringExt}, artvar = {StringExt}, volQuantum = {DoubleExt}, wtGrossQuantum = {DoubleExt}, "
      + "qtyAvailable = {DoubleExt}, qtyReserved = {DoubleExt}, typStock = {StringExt}, typLock = {StringExt}, "
      + "statQualityControl = {StringExt}, statCustoms = {StringExt}, idBatch = {StringExt}, tsBbd = {DateTimeExt}, "
      + "sepCrit01 = {StringExt}, sepCrit02 = {StringExt}, sepCrit03 = {StringExt}, sepCrit04 = {StringExt}, sepCrit05 = {StringExt}, "
      + "sepCrit06 = {StringExt}, sepCrit07 = {StringExt}, sepCrit08 = {StringExt}, sepCrit09 = {StringExt}, sepCrit10 = {StringExt}, "
      + "idSpecialStock = {StringExt}, typSpecialStock = {StringExt}, "
      + "idGoodsReceipt = {StringExt}, numGoodsReceiptItem = {LongExt}, tsGoodsReceipt = {DateTimeExt}, "
      + "typRelocation = {StringExt}")
  public void verifyTransactionRellu(String keyTransaction,
      GherkinType<String> idTransaction,
      GherkinType<String> stat, GherkinType<String> situation, GherkinType<String> idCre, GherkinType<Date> tsCre, GherkinType<String> idUpd, GherkinType<Date> tsUpd,
      GherkinType<String> storageAreaSrc, GherkinType<String> storageLocationSrc, GherkinType<String> storageAreaTgt, GherkinType<String> storageLocationTgt,

      GherkinType<String> idLu,
      GherkinType<String> idLu1, GherkinType<String> typLu1,
      GherkinType<String> idLu2, GherkinType<String> typLu2,
      GherkinType<String> idLu3, GherkinType<String> typLu3,
      GherkinType<Double> height, GherkinType<Double> vol, GherkinType<Double> wtGross, GherkinType<Double> wtTare, 

      GherkinType<String> idArticle,

      GherkinType<String> idQuantum, GherkinType<String> artvar, GherkinType<Double> volQuantum, GherkinType<Double> wtGrossQuantum,
      GherkinType<Double> qtyAvailable, GherkinType<Double> qtyReserved, GherkinType<String> typStock, GherkinType<String> typLock,
      GherkinType<String> statQualityControl, GherkinType<String> statCustoms, GherkinType<String> idBatch, GherkinType<Date> tsBbd,
      GherkinType<String> sepCrit01, GherkinType<String> sepCrit02, GherkinType<String> sepCrit03, GherkinType<String> sepCrit04, GherkinType<String> sepCrit05, 
      GherkinType<String> sepCrit06, GherkinType<String> sepCrit07, GherkinType<String> sepCrit08, GherkinType<String> sepCrit09, GherkinType<String> sepCrit10, 
      GherkinType<String> idSpecialStock, GherkinType<String> typSpecialStock,

      GherkinType<String> idGoodsReceipt, GherkinType<Long> numGoodsReceiptItem, GherkinType<Date> tsGoodsReceipt,
            
      GherkinType<String> typRelocation
    ) {
    idGoodsReceipt.setGetterForKey(grBaseDataHandler.idGoodsReceiptGetter);
    ImTransaction record = inventoryDataHandler.getTransaction(keyTransaction);
    GherkinType<String> idClient = GherkinType.of(null);
    
    // special checks for quantum RELLU
    
    Double actualQtyMoved = record.getQtyMoved();
    if (actualQtyMoved != null) {
      assertEquals(actualQtyMoved, record.getQtyAvailableTgt() + record.getQtyReservedTgt(), "qtyMoved");
      idClient = GherkinType.of(generalHelper.getIdClient());
    }
    GherkinType<Double> qtyMoved;
    if (qtyAvailable.isIgnore() || qtyReserved.isIgnore()) {
      qtyMoved = GherkinType.ignore();
    } else if (qtyAvailable.get() != null && qtyReserved.get() != null) {
      qtyMoved = GherkinType.of(qtyAvailable.get() + qtyReserved.get());
    } else {
      qtyMoved = GherkinType.of(null);
    }

    //Double actualWtGrossQuantum = record.getWtGrossQuantumSrc();
    //if (actualWtGrossQuantum != null) {
    //  assertEquals(record.getWtGrossSrc(), record.getWtTareSrc() + actualWtGrossQuantum, "wtGross");
    //}

    verifyTransaction(record, GherkinType.of("RELLU"), idClient, idTransaction,
        stat, situation, idCre, tsCre, idUpd, tsUpd, storageAreaSrc, storageLocationSrc, storageAreaTgt, storageLocationTgt,
        GherkinType.ignore(), idLu, idLu1, typLu1, idLu2, typLu3, idLu3, typLu3, height, vol, wtGross, wtTare,
        GherkinType.ignore(), idLu, idLu1, typLu1, idLu2, typLu3, idLu3, typLu3, height, vol, wtGross, wtTare,
        idArticle, qtyMoved,
        idQuantum, artvar, volQuantum, wtGrossQuantum,
        qtyAvailable, qtyReserved, typStock, typLock,
        statQualityControl, statCustoms, idBatch, tsBbd,
        sepCrit01, sepCrit02, sepCrit03, sepCrit04, sepCrit05, sepCrit06, sepCrit07, sepCrit08, sepCrit09, sepCrit10,
        idSpecialStock, typSpecialStock,
        idQuantum, artvar, volQuantum, wtGrossQuantum,
        qtyAvailable, qtyReserved, typStock, typLock,
        statQualityControl, statCustoms, idBatch, tsBbd,
        sepCrit01, sepCrit02, sepCrit03, sepCrit04, sepCrit05, sepCrit06, sepCrit07, sepCrit08, sepCrit09, sepCrit10,
        idSpecialStock, typSpecialStock,
        idGoodsReceipt, numGoodsReceiptItem, tsGoodsReceipt,
        idGoodsReceipt, numGoodsReceiptItem, tsGoodsReceipt,
        typRelocation, GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null),
        GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null), GherkinType.of(null)
    );
  }
  //@formatter:on

  @Then("quantum {string} has: idQuantum = {StringExt}, idArticle = {StringExt}, qtyAvailable = {DoubleExt}, qtyReserved = {DoubleExt}, "
      + "flgStockTaking = {BooleanExt}, idLu1 = {StringExt}, typLu1 = {StringExt}, storageArea = {StringExt}, storageLocation = {StringExt}, storageAreaSrc = {StringExt}, "
      + "storageLocationSrc = {StringExt}, flgInTransit = {BooleanExt}, idTransaction = {StringExt}, artvar = {StringExt}, typStock = {StringExt}, typLock = {StringExt}, statQualityControl = {StringExt}, "
      + "statCustoms = {StringExt}, sepCrit01 = {StringExt}, sepCrit02 = {StringExt}, sepCrit03 = {StringExt}, idGoodsReceipt = {StringExt}, numGoodsReceiptItem = {LongExt}, tsGoodsReceipt = {DateTimeExt}, "
      + "wtGross = {DoubleExt}, vol = {DoubleExt}")
  public void verifyQuantum(String key, GherkinType<String> idQuantum, GherkinType<String> idArticle, GherkinType<Double> qtyAvailable,
      GherkinType<Double> qtyReserved, GherkinType<Boolean> flgStockTaking, GherkinType<String> idLu1, GherkinType<String> typLu1,
      GherkinType<String> storageArea, GherkinType<String> storageLocation, GherkinType<String> storageAreaSrc,
      GherkinType<String> storageLocationSrc, GherkinType<Boolean> flgInTransit, GherkinType<String> idTransaction, GherkinType<String> artvar,
      GherkinType<String> typStock, GherkinType<String> typLock, GherkinType<String> statQualityControl, GherkinType<String> statCustoms,
      GherkinType<String> sepCrit01, GherkinType<String> sepCrit02, GherkinType<String> sepCrit03, GherkinType<String> idGoodsReceipt,
      GherkinType<Long> numGoodsReceiptItem, GherkinType<Date> tsGoodsReceipt, GherkinType<Double> wtGross, GherkinType<Double> vol) {
    idGoodsReceipt.setGetterForKey(grBaseDataHandler.idGoodsReceiptGetter);

    //@formatter:off     
    ImQuantum record = inventoryDataHandler.getQuantum(key);

    Long actNumGoodsReceiptItem = (record.getNumGoodsReceiptItem() == null) ? null : record.getNumGoodsReceiptItem() - grBaseDataHandler.getReceivingItemCount(new GrReceivingPk(generalHelper.getIdSite(), generalHelper.getIdClient(), record.getIdGoodsReceipt()));
    
    assertAll(
        () -> assertEquals(generalHelper.getIdSite(), record.getImQuantumPk().getIdSite(), "idSite"),
        () -> assertEquals(generalHelper.getIdClient(), record.getIdClient(), "idClient"),
        () -> assertNotNull(record.getImQuantumPk().getIdQuantum(), "idQuantum"),
        () -> idQuantum.assertEquality(record.getImQuantumPk().getIdQuantum(), "idQuantum"),
        () -> idArticle.assertEquality(record.getIdArticle(), "idArticle"),
        () -> qtyAvailable.assertEquality(record.getQtyAvailable(), "qtyAvailable"),
        () -> qtyReserved.assertEquality(record.getQtyReserved(), "qtyReserved"),
        () -> flgStockTaking.assertEquality(record.getFlgStockTaking().equals("1"), "flgStockTaking"),
        () -> assertNotNull(record.getIdLu1(), "idLu1"),
        () -> idLu1.assertEquality(record.getIdLu1(), "idLu1"),
        () -> typLu1.assertEquality(record.getTypLu1(), "typLu1"),
        () -> storageArea.assertEquality(record.getStorageArea(), "storageArea"),
        () -> assertTrue((record.getStorageArea() == null) == (record.getStorageLocation() == null), "storageLocation"),      
        () -> storageAreaSrc.assertEquality(record.getStorageAreaSrc(), "storageAreaSrc"),
        () -> assertTrue((record.getStorageAreaSrc() == null) == (record.getStorageLocationSrc() == null), "storageLocationSrc"),
        () -> storageLocationSrc.assertEquality(record.getStorageLocationSrc(), "storageLocationSrc"),
        () -> flgInTransit.assertEquality(record.getFlgInTransit().equals("1"), "flgInTransit"),
        () -> assertNotNull(record.getIdTransaction(), "idTransaction"),
        () -> idTransaction.assertEquality(record.getIdTransaction(), "idTransaction"),
        () -> artvar.assertEquality(record.getArtvar(), "artvar"),
        () -> typStock.assertEquality(record.getTypStock(), "typStock"),
        () -> typLock.assertEquality(record.getTypLock(), "typLock"),
        () -> statQualityControl.assertEquality(record.getStatQualityControl(), "statQualityControl"),
        () -> statCustoms.assertEquality(record.getStatCustoms(), "statCustoms"),
        () -> sepCrit01.assertEquality(record.getSepCrit01(), "sepCrit01"),
        () -> sepCrit02.assertEquality(record.getSepCrit02(), "sepCrit02"),
        () -> sepCrit03.assertEquality(record.getSepCrit03(), "sepCrit03"),
        () -> idGoodsReceipt.assertEquality(record.getIdGoodsReceipt(), "idGoodsReceipt"),
        () -> numGoodsReceiptItem.assertEquality(actNumGoodsReceiptItem, "numGoodsReceiptItem"),
        () -> tsGoodsReceipt.assertEquality(record.getTsGoodsReceipt(), "tsGoodsReceipt"),
        () -> wtGross.assertEquality(record.getWtGross(), "wtGross"),
        () -> vol.assertEquality(record.getVol(), "vol")
    );
    //@formatter:on
  }

  @Then("load unit {string} has: idLu = {StringExt}, typLu = {StringExt}, statOccupied = {StringExt}, pctOccupied = {DoubleExt}, flgStockTaking = {BooleanExt}, tsStockTaking = {DateTimeExt}, idUserStockTaking = {StringExt}, storageArea = {StringExt}, storageLocation = {StringExt}, storageAreaSrc = {StringExt}, storageLocationSrc = {StringExt}, flgInTransit = {BooleanExt}, idTransaction = {StringExt}, sscc = {StringExt}, wtGross = {DoubleExt}, wtTare = {DoubleExt}, height = {DoubleExt}, vol = {DoubleExt}")
  public void verifyLoadUnit(String key, GherkinType<String> idLu, GherkinType<String> typLu, GherkinType<String> statOccupied,
      GherkinType<Double> pctOccupied, GherkinType<Boolean> flgStockTaking, GherkinType<Date> tsStockTaking, GherkinType<String> idUserStockTaking,
      GherkinType<String> storageArea, GherkinType<String> storageLocation, GherkinType<String> storageAreaSrc,
      GherkinType<String> storageLocationSrc, GherkinType<Boolean> flgInTransit, GherkinType<String> idTransaction, GherkinType<String> sscc,
      GherkinType<Double> wtGross, GherkinType<Double> wtTare, GherkinType<Double> height, GherkinType<Double> vol) {
    idTransaction.setGetterForKey(inventoryDataHandler.idTransactionGetter);

    //@formatter:off
    ImLoadUnit record = inventoryDataHandler.getLoadUnit(key);

    assertAll(        
        () -> assertEquals(generalHelper.getIdSite(), record.getImLoadUnitPk().getIdSite(), "idSite"),
        () -> assertNotNull(record.getImLoadUnitPk().getIdLu(), "idLu"),                                                 
        () -> idLu.assertEquality(record.getImLoadUnitPk().getIdLu(), "idLu"),
        () -> typLu.assertEquality(record.getTypLu(), "typLu"),
        () -> statOccupied.assertEquality(record.getStatOccupied(), "statOccupied"),
        () -> pctOccupied.assertEquality(record.getPctOccupied(), "pctOccupied"),
        () -> flgStockTaking.assertEquality(record.getFlgStockTaking().equals("1"), "flgStockTaking"),
        () -> tsStockTaking.assertEquality(record.getTsStockTaking(), "tsStockTaking"),
        () -> idUserStockTaking.assertEquality(record.getIdUserStockTaking(), "idUserStockTaking"),
        () -> storageArea.assertEquality(record.getStorageArea(), "storageArea"),
        () -> assertTrue((record.getStorageArea() == null) == (record.getStorageLocation() == null), "storageLocation"),
        () -> storageLocation.assertEquality(record.getStorageLocation(), "storageLocation"),
        () -> storageAreaSrc.assertEquality(record.getStorageAreaSrc(), "storageAreaSrc"),
        () -> assertTrue((record.getStorageAreaSrc() == null) == (record.getStorageLocationSrc() == null), "storageLocationSrc"),
        () -> storageLocationSrc.assertEquality(record.getStorageLocationSrc(), "storageLocationSrc"),
        () -> flgInTransit.assertEquality(record.getFlgInTransit().equals("1"), "flgInTransit"),
        () -> assertNotNull(record.getIdTransaction(), "idTransaction"),
        () -> idTransaction.assertEquality(record.getIdTransaction(), "idTransaction"),
        () -> sscc.assertEquality(record.getSscc(), "sscc"),
        () -> wtGross.assertEquality(record.getWtGross(), "wtGross"),
        () -> wtTare.assertEquality(record.getWtTare(), "wtTare"),
        () -> height.assertEquality(record.getHeight(), "height"),
        () -> vol.assertEquality(record.getVol(), "vol")
    );  
    //@formatter:on
  }

  @Then("load unit {string} has {int} quantum(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void saveQuantumsOfLoadUnit(String keyLu, int count, String keyQu) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(keyLu);
    List<ImQuantum> quantums = imQuantumRep.findByIdSiteAndIdLu(loadUnit.getImLoadUnitPk().getIdSite(), loadUnit.getImLoadUnitPk().getIdLu());

    int i = 0;
    for (ImQuantum qu : quantums) {
      assertEquals(loadUnit.getImLoadUnitPk().getIdLu(), qu.getIdLu1());
      inventoryDataHandler.putQuantum(GeneralHelper.makeMapKeyWithIx(keyQu, i), qu);
      i++;
    }

    assertEquals(count, i);
  }

  @Then("reload load unit {string}")
  @Transactional(readOnly = true)
  public void reloadLoadUnit(String keyLu) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(keyLu);
    loadUnit = imLoadUnitRep.findOne(loadUnit.getImLoadUnitPk());
    inventoryDataHandler.putLoadUnit(keyLu, loadUnit);
  }

  @Then("quantum {String} or load unit {String} has {int} transaction(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void saveTransaction(String keyQu, String keyLu, int count, String keyTransaction) {
    Comparator<ImTransaction> compare = Comparator.comparing(ImTransaction::getImTransactionPk, (lhs, rhs) -> {
      return lhs.getIdTransaction().compareTo(rhs.getIdTransaction());
    });

    String idQuantum = (keyQu == null) ? null : inventoryDataHandler.getQuantum(keyQu).getImQuantumPk().getIdQuantum();
    String idLoadUnit = (keyLu == null) ? null : inventoryDataHandler.getLoadUnit(keyLu).getImLoadUnitPk().getIdLu();

    List<ImTransaction> transactions = imTransactionRep.findByIdQuantumTgtOrIdLuTgt(idQuantum, idLoadUnit).stream().sorted(compare)
        .collect(Collectors.toList());

    int i = 0;
    for (ImTransaction tr : transactions) {
      if ((idQuantum != null && idQuantum.equals(tr.getIdQuantumTgt())) || (idLoadUnit != null && idLoadUnit.equals(tr.getIdLuTgt()))) {
        inventoryDataHandler.putTransaction(GeneralHelper.makeMapKeyWithIx(keyTransaction, i), tr);
        i++;
      } else {
        // Why can this happen?
        // assertTrue((idQuantum != null && idQuantum.equals(tr.getIdQuantumTgt())) || (idLoadUnit != null && idLoadUnit.equals(tr.getIdLuTgt())));
      }
    }

    assertEquals(count, i, "count");
  }

  @Then("reload quantum {string}")
  @Transactional(readOnly = true)
  public void reloadQuantum(String keyQu) {
    ImQuantum quantum = inventoryDataHandler.getQuantum(keyQu);
    quantum = imQuantumRep.findOne(quantum.getImQuantumPk());
    inventoryDataHandler.putQuantum(keyQu, quantum);
  }

  @Then("reload transaction {string}")
  @Transactional(readOnly = true)
  public void reloadTransaction(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    transaction = imTransactionRep.findOne(transaction.getImTransactionPk());
    inventoryDataHandler.putTransaction(keyTransaction, transaction);
  }

}
