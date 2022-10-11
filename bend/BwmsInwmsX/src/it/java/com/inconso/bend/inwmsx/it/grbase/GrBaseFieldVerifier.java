package com.inconso.bend.inwmsx.it.grbase;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.bpsched.pers.model.BpsProcessRecord;
import com.inconso.bend.bpsched.pers.rep.BpsProcessRecordRep;
import com.inconso.bend.grbase.pers.gen.GrReceivingItemPk;
import com.inconso.bend.grbase.pers.gen.GrReceivingPk;
import com.inconso.bend.grbase.pers.model.GrReceiving;
import com.inconso.bend.grbase.pers.model.GrReceivingItem;
import com.inconso.bend.grbase.pers.rep.GrReceivingItemRep;
import com.inconso.bend.grbase.pers.rep.GrReceivingRep;
import com.inconso.bend.grbase.service.api.collection.ReceivingSearchArticlevariantOutput;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inwmsx.it.bpsched.BPSchedDataHandler;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.FieldExtractor;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;

public class GrBaseFieldVerifier {

  @Autowired
  private WebserviceClient                          webserviceClient;

  @Autowired
  private GeneralHelper                             generalHelper;

  @Autowired
  private CucumberReport                            cucumberReport;

  @Autowired
  private GrBaseDataHandler                         grBaseDataHandler;

  @Autowired
  private GrBaseGlobalDataHandler                   grBaseGlobalDataHandler;

  @Autowired
  private BPSchedDataHandler                        bpSchedDataHandler;

  @Autowired
  private InventoryDataHandler                      inventoryDataHandler;

  @Autowired
  private GrReceivingRep                            receivingRep;

  @Autowired
  private GrReceivingItemRep                        receivingItemRep;

  @Autowired
  private BpsProcessRecordRep                       processRecordRep;

  @Autowired
  private ImLoadUnitRep                             loadUnitRep;

  private List<ReceivingSearchArticlevariantOutput> receivingSearchArticlevariantResults;

  @Then("RECEIVING_SEARCH_ARTICLE_VARIANT finds {int} record(s)")
  public void verifySearchArticleVariant(int count) {
    Comparator<ReceivingSearchArticlevariantOutput> compare = Comparator.comparing(ReceivingSearchArticlevariantOutput::getArtvar)
        .thenComparing(ReceivingSearchArticlevariantOutput::getTypLu).thenComparing(ReceivingSearchArticlevariantOutput::getCalculatedHeightClass)
        .thenComparing(ReceivingSearchArticlevariantOutput::getLayer).thenComparing(ReceivingSearchArticlevariantOutput::getQtyPerLu)
        .thenComparing(ReceivingSearchArticlevariantOutput::getQtyMu).thenComparing(ReceivingSearchArticlevariantOutput::getCount2);

    receivingSearchArticlevariantResults = webserviceClient.verifySuccess().getOutput().stream().map(element -> {
      FieldExtractor record = new FieldExtractor(element);
      ReceivingSearchArticlevariantOutput result = new ReceivingSearchArticlevariantOutput();

      result.setArtvar(record.getString("artvar"));
      result.setTypLu(record.getString("typLu"));
      result.setQtyPerLu(record.getDouble("qtyPerLu"));
      result.setCount2(record.getLong("count2"));
      result.setQtyMu(record.getDouble("qtyMu"));
      result.setCalculatedHeightClass(record.getString("calculatedHeightClass"));
      result.setLayer(Integer.toUnsignedLong(record.getInteger("layer")));

      return result;
    }).sorted(compare).collect(Collectors.toList());

    assertEquals(count, receivingSearchArticlevariantResults.size(), "count");
  }

  @And("RECEIVING_SEARCH_ARTICLE_VARIANT result record {int} has: artvar = {StringExt}, typLu = {StringExt}, qtyPerLu = {DoubleExt}, count2 = {LongExt}, qty = {DoubleExt}, heightClass = {StringExt}, layer = {LongExt}")
  public void verifySearchArticleVariantRecord(int index, GherkinType<String> artvar, GherkinType<String> typLu, GherkinType<Double> qtyPerLu,
      GherkinType<Long> count2, GherkinType<Double> qty, GherkinType<String> heightClass, GherkinType<Long> layer) {
    ReceivingSearchArticlevariantOutput record = receivingSearchArticlevariantResults.get(index);

    //@formatter:off
    assertAll(       
        () -> artvar.assertEquality(record.getArtvar(), "artvar"),
        () -> typLu.assertEquality(record.getTypLu(), "typLu"),
        () -> qtyPerLu.assertEquality(record.getQtyPerLu(), "qtyPerLu"),
        () -> count2.assertEquality(record.getCount2(), "count2"),
        () -> qty.assertEquality(record.getQtyMu(), "qty"),
        () -> heightClass.assertEquality(record.getCalculatedHeightClass(), "heightClass"),
        () -> layer.assertEquality(record.getLayer(), "layer")
    );
    //@formatter:on
  }

  /**
   * Unplanned goods receiving: Successful webservice call RECEIVING_CREATE_RECEIVING.
   */
  @Then("RECEIVING_CREATE_RECEIVING result is saved as {string}; result has {int} load unit(s), saved as collection {string}; result has: booking = {BooleanExt}, isFinishedSetUp = {BooleanExt}")
  @Transactional(readOnly = true)
  public void verifyGrReceivingSuccessful(String keyReceiving, int count, String keyLu, GherkinType<Boolean> booking,
      GherkinType<Boolean> isFinishedSetUp) {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    List<String> lus = payload.getStringList("createdLus");

    int i = 0;
    for (String lu : lus) {
      inventoryDataHandler.putLoadUnit(GeneralHelper.makeMapKeyWithIx(keyLu, i),
          loadUnitRep.findOne(new ImLoadUnitPk(generalHelper.getIdSite(), lu)));
      i++;
    }

    int actualCount = i;

    //@formatter:off
    assertAll(       
        () -> assertEquals(count, actualCount, "count"),
        () -> booking.assertEquality(payload.getBoolean("booking"), "booking"),
        () -> isFinishedSetUp.assertEquality(payload.getBoolean("isFinishedSetUp"), "isFinishedSetUp")
    );
    //@formatter:on

    /*
     * Get the receiving item via the first lu -> process records -> receiving item -> receiving
     * 
     * Depending on the configuration several calls to RECEIVING_CREATE_RECEIVING can be booked to the same receiving
     */
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(GeneralHelper.makeMapKeyWithIx(keyLu, 0));

    BpsProcessRecord processRecord = processRecordRep.findByIdLuSrc(loadUnit.getImLoadUnitPk().getIdSite(), loadUnit.getImLoadUnitPk().getIdLu())
        .get(0);

    GrReceivingItem receivingItem = receivingItemRep.findOne(new GrReceivingItemPk(processRecord.getBpsProcessRecordPk().getIdSite(),
        processRecord.getIdRef2(), processRecord.getIdRef3(), Long.parseLong(processRecord.getIdRef4())));

    GrReceiving receiving = receivingRep.findOne(new GrReceivingPk(generalHelper.getIdSite(), receivingItem.getGrReceivingItemPk().getIdClient(),
        receivingItem.getGrReceivingItemPk().getIdGoodsReceipt()));

    grBaseDataHandler.putReceiving(keyReceiving, receiving);

    // Bookkeeping of itemCount.
    // Makes it possible to verify itemCount relative to the current receiving even though the receiving is shared.
    String message = "ts: " + System.currentTimeMillis() + " key: " + keyReceiving + ":";
    long cnt;
    // fetch itemCount of the preceding scenario once per scenario
    if (!grBaseDataHandler.containsReceivingItemCount(receiving.getGrReceivingPk())) {
      cnt = grBaseGlobalDataHandler.getReceivingItemCount(receiving.getGrReceivingPk());
      grBaseDataHandler.putReceivingItemCount(receiving.getGrReceivingPk(), cnt);
      message += "\ngrBaseDataHandler.putReceivingItemCount(" + receiving.getGrReceivingPk().toString() + ", " + cnt + ")";
    }
    // save the current itemCount for succeeding scenarios
    cnt = receivingItemRep.findByGrReceiving(receiving).size();
    grBaseGlobalDataHandler.putReceivingItemCount(receiving.getGrReceivingPk(), cnt);
    message += "\ngrBaseGlobalDataHandler.putReceivingItemCount(" + receiving.getGrReceivingPk().toString() + ", " + cnt + ")";

    cucumberReport.setMessage(message);
  }

  @Then("receiving {string} has: idGoodsReceipt = {StringExt}, stat = {StringExt}, typGoodsReceipt = {StringExt}, "
      + "datGoodsReceipt = {DateTimeExt}, idTerminal = {StringExt}, idWorkcenter = {StringExt}, clUnplanned = {StringExt}")
  public void verifyGrReceiving(String key, GherkinType<String> idGoodsReceipt, GherkinType<String> stat, GherkinType<String> typGoodsReceipt,
      GherkinType<Date> datGoodsReceipt, GherkinType<String> idTerminal, GherkinType<String> idWorkcenter, GherkinType<String> clUnplanned) {

    //@formatter:off
    GrReceiving record = grBaseDataHandler.getReceiving(key);

    assertAll(
        () -> assertEquals(generalHelper.getIdSite(), record.getGrReceivingPk().getIdSite(), "idSite"),
        () -> assertEquals(generalHelper.getIdClient(), record.getGrReceivingPk().getIdClient(), "idClient"),
        () -> idGoodsReceipt.assertEquality(record.getGrReceivingPk().getIdGoodsReceipt(), "idGoodsReceipt"),
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> typGoodsReceipt.assertEquality(record.getTypGoodsReceipt(), "typGoodsReceipt"),
        () -> datGoodsReceipt.assertEquality(record.getDatGoodsReceipt(), "datGoodsReceipt"),
        () -> idTerminal.assertEquality(record.getIdTerminal(), "idTerminal"),
        () -> idWorkcenter.assertEquality(record.getIdWorkcenter(), "idWorkcenter"),
        () -> clUnplanned.assertEquality(record.getClUnplanned(), "clUnplanned")
    );
    //@formatter:on
  }

  @Then("receiving item {string} has: idGoodsReceipt = {StringExt}, numItem = {LongExt}, stat = {StringExt}, idArticle = {StringExt}, "
      + "artvar = {StringExt}, qtyDeliveryNote = {DoubleExt}, qtyTarget = {DoubleExt}, qtyCanceled = {DoubleExt}, qtyActual = {DoubleExt}, sepCrit03 = {StringExt}")
  public void verifyGrReceivingItem(String key, GherkinType<String> idGoodsReceipt, GherkinType<Long> numItem, GherkinType<String> stat,
      GherkinType<String> idArticle, GherkinType<String> artvar, GherkinType<Double> qtyDeliveryNote, GherkinType<Double> qtyTarget,
      GherkinType<Double> qtyCanceled, GherkinType<Double> qtyActual, GherkinType<String> sepCrit03) {
    idGoodsReceipt.setGetterForKey(grBaseDataHandler.idGoodsReceiptGetter);
    sepCrit03.setGetterForKey(grBaseDataHandler.idGoodsReceiptGetter);

    //@formatter:off
    GrReceivingItem record = grBaseDataHandler.getReceivingItem(key);
    
    assertAll(
        () -> assertEquals(generalHelper.getIdSite(), record.getGrReceivingItemPk().getIdSite(), "idSite"),
        () -> assertEquals(generalHelper.getIdClient(), record.getGrReceivingItemPk().getIdClient(), "idClient"),
        () -> idGoodsReceipt.assertEquality(record.getGrReceivingItemPk().getIdGoodsReceipt(), "idGoodsReceipt"),
        () -> numItem.assertEquality(record.getGrReceivingItemPk().getNumItem() - grBaseDataHandler.getReceivingItemCount(new GrReceivingPk(record.getGrReceivingItemPk().getIdSite(), record.getGrReceivingItemPk().getIdClient(), record.getGrReceivingItemPk().getIdGoodsReceipt())), "numItem"),      
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> idArticle.assertEquality(record.getIdArticle(), "idArticle"),
        () -> artvar.assertEquality(record.getArtvar(), "artvar"),
        () -> qtyDeliveryNote.assertEquality(record.getQtyDeliveryNote(), "qtyDeliveryNote"),
        () -> qtyTarget.assertEquality(record.getQtyTarget(), "qtyTarget"),
        () -> qtyCanceled.assertEquality(record.getQtyCanceled(), "qtyCanceled"),
        () -> qtyActual.assertEquality(record.getQtyActual(), "qtyActual"),
        () -> sepCrit03.assertEquality(record.getSepCrit03(), "sepCrit03")         
    );
    //@formatter:on
  }

  @Then("bps record {string} has one receiving item, saved as {string}")
  @Transactional(readOnly = true)
  public void saveReceivingItem(String keyRecord, String keyReceivingItem) {
    BpsProcessRecord bpsRecord = bpSchedDataHandler.getProcessRecord(keyRecord);

    GrReceivingItem receivingItem = receivingItemRep
        .findOne(new GrReceivingItemPk(bpsRecord.getIdRef1(), bpsRecord.getIdRef2(), bpsRecord.getIdRef3(), Long.parseLong(bpsRecord.getIdRef4())));

    assertNotNull(receivingItem, "no receiving item");

    grBaseDataHandler.putReceivingItem(keyReceivingItem, receivingItem);
  }

  @Then("reload receiving {string}")
  @Transactional(readOnly = true)
  public void reloadReceiving(String keyReceiving) {
    GrReceiving receiving = grBaseDataHandler.getReceiving(keyReceiving);
    receiving = receivingRep.findOne(receiving.getGrReceivingPk());
    grBaseDataHandler.putReceiving(keyReceiving, receiving);
  }

  @Then("reload receiving item {string}")
  @Transactional(readOnly = true)
  public void reloadReceivingItem(String keyReceivingItem) {
    GrReceivingItem receivingItem = grBaseDataHandler.getReceivingItem(keyReceivingItem);
    receivingItem = receivingItemRep.findOne(receivingItem.getGrReceivingItemPk());
    grBaseDataHandler.putReceivingItem(keyReceivingItem, receivingItem);
  }

  @Then("GR300_CREATE_RECEIVING result is saved as {string}")
  @Transactional(readOnly = true)
  public void verifyGr300ReceivingSuccessful(String keyReceiving) {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    String idSite = generalHelper.getIdSite();
    String idClient = generalHelper.getIdClient();
    String idGoodsReceipt = payload.getString("idGoodsReceipt");

    GrReceiving receiving = receivingRep.findOne(new GrReceivingPk(idSite, idClient, idGoodsReceipt));
    grBaseDataHandler.putReceiving(keyReceiving, receiving);

    //@formatter:off
    assertAll(       
            () -> assertEquals(idSite, payload.getString("idSite"), "Service result: idSite"),
            () -> assertEquals(idClient, payload.getString("idClient"), "Service result: idClient")
    );
    //@formatter:on
  }

  @Then("RECEIVING_BOOK_RECEIVING_ITEM result has {int} load unit(s), saved as collection {string}; result has: booking = {BooleanExt}, isFinishedSetUp = {BooleanExt}, qtyActual = {DoubleExt}")
  @Transactional(readOnly = true)
  public void verifyBookReceivingItemSuccessful(int count, String keyLu, GherkinType<Boolean> booking, GherkinType<Boolean> isFinishedSetUp,
      GherkinType<Double> qtyActual) {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    List<String> lus = payload.getStringList("createdLus");

    int i = 0;
    for (String lu : lus) {
      inventoryDataHandler.putLoadUnit(GeneralHelper.makeMapKeyWithIx(keyLu, i),
          loadUnitRep.findOne(new ImLoadUnitPk(generalHelper.getIdSite(), lu)));
      i++;
    }

    int actualCount = i;

    //@formatter:off
    assertAll(       
        () -> assertEquals(count, actualCount, "count"),
        () -> booking.assertEquality(payload.getBoolean("booking"), "booking"),
        () -> isFinishedSetUp.assertEquality(payload.getBoolean("isFinishedSetUp"), "isFinishedSetUp"),
        () -> qtyActual.assertEquality(payload.getDouble("qtyActual"), "qtyActual")
    );
    //@formatter:on
  }

  @Then("RECMIXLU_SEARCH_LU_TYPES result has one load unit, saved as {string}")
  @Transactional(readOnly = true)
  public void verifyRecmixluSearchLuTypesSuccessful(String keyLu) {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    String idSite = generalHelper.getIdSite();
    // String idClient = generalHelper.getIdClient();

    FieldExtractor outputLu = new FieldExtractor(payload.getObjectMap("outputLu"));
    // ArrayList<Object> outputLUTypeList = payload.getObjectArray("outputLUTypeList");
    String idLu = outputLu.getString("idLu");

    inventoryDataHandler.putLoadUnit(keyLu, loadUnitRep.findOne(new ImLoadUnitPk(idSite, idLu)));

    //@formatter:off
//    assertAll(       
//            () -> assertEquals(idSite, payload.getString("idSite"), "Service result: idSite"),
//            () -> assertEquals(idClient, payload.getString("idClient"), "Service result: idClient")
//    );
    //@formatter:on
  }

}
