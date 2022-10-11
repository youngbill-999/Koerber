package com.inconso.bend.inwmsx.it.replenishment;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.inwmsx.it.bpsched.BPSchedFieldVerifier;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.repbase.pers.gen.RepReplenishmentRequestPk;
import com.inconso.bend.repbase.pers.model.RepReplenishmentRequest;
import com.inconso.bend.repbase.pers.rep.RepReplenishmentRequestRep;
import io.cucumber.java.en.Then;

public class ReplenishmentFieldVerifier {

  @Autowired
  private GeneralHelper              generalHelper;

  @Autowired
  private ReplenishmentDataHandler   replenishmentDataHandler;

  @Autowired
  private BPSchedFieldVerifier       bpSchedFieldVerifier;

  @Autowired
  private RepReplenishmentRequestRep repReplenishmentRequestRep;

  @Then("replenishment request {string} has {int} bps record(s), saved as collection {string}")
  public void saveBpsRecordsOfReplenishmentRequest(String key, int count, String keyBpsRecord) {
    RepReplenishmentRequestPk repReplenishmentRequestPk = replenishmentDataHandler.getRepReplenishmentRequest(key).getRepReplenishmentRequestPk();

    String[] ref = { "REP_REPLENISHMENT_REQUEST", repReplenishmentRequestPk.getIdSite(), repReplenishmentRequestPk.getIdReplenishment(), null, null,
        null, null };

    bpSchedFieldVerifier.saveBpsRecordsByReference(ref, count, keyBpsRecord);
  }

  @Then("reload replenishment request {string}")
  @Transactional(readOnly = true)
  public void reloadReplenishmentRequest(String keyReplenishmentRequest) {
    RepReplenishmentRequest replenishmentRequest = replenishmentDataHandler.getRepReplenishmentRequest(keyReplenishmentRequest);
    replenishmentRequest = repReplenishmentRequestRep.findOne(replenishmentRequest.getRepReplenishmentRequestPk());
    replenishmentDataHandler.putRepReplenishmentRequest(keyReplenishmentRequest, replenishmentRequest);
  }

  @Then("replenishment request {string} has: typReplenishment = {StringExt}, stat = {StringExt}, idArticle = {StringExt}, artvar = {StringExt}, idBatch = {StringExt}, idCre = {StringExt}, tsCre = {DateTimeExt}, idUpd = {StringExt}, tsUpd = {DateTimeExt}, "
      + "idStoreOutZone = {StringExt}, cntResAttemptActual = {LongExt}, cntResAttemptMax = {LongExt}, cntLuActual = {LongExt}, cntLuReserved = {LongExt}, cntLuTarget = {LongExt}, qtyActual = {DoubleExt}, qtyReserved = {DoubleExt}, qtyTarget = {DoubleExt}")
  public void verifyReplenishmentRequest(String key, GherkinType<String> typReplenishment, GherkinType<String> stat, GherkinType<String> idArticle,
      GherkinType<String> artvar, GherkinType<String> idBatch, GherkinType<String> idCre, GherkinType<Date> tsCre, GherkinType<String> idUpd,
      GherkinType<Date> tsUpd, GherkinType<String> idStoreOutZone, GherkinType<Long> cntResAttemptActual, GherkinType<Long> cntResAttemptMax,
      GherkinType<Long> cntLuActual, GherkinType<Long> cntLuReserved, GherkinType<Long> cntLuTarget, GherkinType<Double> qtyActual,
      GherkinType<Double> qtyReserved, GherkinType<Double> qtyTarget) {
    //@formatter:off
    RepReplenishmentRequest record = replenishmentDataHandler.getRepReplenishmentRequest(key);
/*
    record.getPriority();
    record.getPriorityOrig();
    record.getStatQualityControl();
    record.getStorageArea(); immer null?
    record.getStorageLocation(); immer null?
    record.getTypLock();
    record.getTypStock();
    record.getIdSpecialStock();
    record.getTypSpecialStock();
*/
    assertAll(
        () -> assertEquals(generalHelper.getIdSite(), record.getRepReplenishmentRequestPk().getIdSite(), "idSite"),
        () -> assertEquals(generalHelper.getIdClient(), record.getIdClient(), "idClient"),
        () -> typReplenishment.assertEquality(record.getTypReplenishment(), "typReplenishment"),
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> idArticle.assertEquality(record.getIdArticle(), "idArticle"),
        () -> artvar.assertEquality(record.getArtvar(), "artvar"),
        () -> idBatch.assertEquality(record.getIdBatch(), "idBatch"),
        () -> idCre.assertEquality(record.getIdCre(), "idCre"),
        () -> tsCre.assertEquality(record.getTsCre(), "tsCre"),
        () -> idUpd.assertEquality(record.getIdUpd(), "idUpd"),
        () -> tsUpd.assertEquality(record.getTsUpd(), "tsUpd"),
        () -> idStoreOutZone.assertEquality(record.getIdStoreOutZone(), "idStoreOutZone"),
        () -> cntResAttemptActual.assertEquality(record.getCntResAttemptActual(), "cntResAttemptActual"),
        () -> cntResAttemptMax.assertEquality(record.getCntResAttemptMax(), "cntResAttemptMax"),
        () -> cntLuActual.assertEquality(record.getCntLuActual(), "cntLuActual"),
        () -> cntLuReserved.assertEquality(record.getCntLuReserved(), "cntLuReserved"),
        () -> cntLuTarget.assertEquality(record.getCntLuTarget(), "cntLuTarget"),
        () -> qtyActual.assertEquality(record.getQtyActual(), "qtyActual"),
        () -> qtyReserved.assertEquality(record.getQtyReserved(), "qtyReserved"),
        () -> qtyTarget.assertEquality(record.getQtyTarget(), "qtyTarget")
    );
    //@formatter:on
  }
}
