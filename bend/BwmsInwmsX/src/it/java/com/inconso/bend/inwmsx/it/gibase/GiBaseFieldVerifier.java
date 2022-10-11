package com.inconso.bend.inwmsx.it.gibase;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.bpsched.logic.util.BPSchedSelectHelper;
import com.inconso.bend.bpsched.pers.gen.BpsProcessRecordPk;
import com.inconso.bend.bpsched.pers.model.BpsProcessRecord;
import com.inconso.bend.distrib.pers.model.DiDistribTrip;
import com.inconso.bend.distrib.pers.rep.DiDistribTripRep;
import com.inconso.bend.gibase.pers.gen.GiOrderPk;
import com.inconso.bend.gibase.pers.model.GiOrder;
import com.inconso.bend.gibase.pers.model.GiOrderItem;
import com.inconso.bend.gibase.pers.rep.GiOrderItemRep;
import com.inconso.bend.gibase.pers.rep.GiOrderRep;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inwmsx.it.bpsched.BPSchedDataHandler;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import com.inconso.bend.picking.pers.gen.PiPickingOrderPk;
import com.inconso.bend.picking.pers.gen.PiPickingTripPk;
import com.inconso.bend.picking.pers.model.PiPickingOrder;
import com.inconso.bend.picking.pers.model.PiPickingOrderBpsAsgmt;
import com.inconso.bend.picking.pers.model.PiPickingTrip;
import com.inconso.bend.picking.pers.rep.PiPickingOrderBpsAsgmtRep;
import com.inconso.bend.picking.pers.rep.PiPickingOrderRep;
import com.inconso.bend.picking.pers.rep.PiPickingTripRep;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;

public class GiBaseFieldVerifier {

  @Autowired
  private GeneralHelper             generalHelper;

  @Autowired
  private GiBaseDataHandler         giBaseDataHandler;

  @Autowired
  private BPSchedDataHandler        bpSchedDataHandler;

  @Autowired
  private InventoryDataHandler      inventoryDataHandler;

  @Autowired
  private BPSchedSelectHelper       bpsSelectHelper;

  @Autowired
  private GiOrderRep                orderRep;

  @Autowired
  private GiOrderItemRep            orderItemRep;

  @Autowired
  private PiPickingOrderRep         piPickingOrderRep;

  @Autowired
  private PiPickingOrderBpsAsgmtRep piPickingOrderBpsAsgmtRep;

  @Autowired
  private PiPickingTripRep          piPickingTripRep;

  @Autowired
  private ImLoadUnitRep             loadUnitRep;

  @Autowired
  private DiDistribTripRep          diDistribTripRep;

  @Then("order {string} has {int} order item(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void saveOrderItems(String key, int count, String keyOrderItem) {
    GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    GiOrder order = orderRep.findOne(giOrderPk);

    List<GiOrderItem> orderItems = orderItemRep.findByGiOrder(order);

    int i = 0;
    for (GiOrderItem orderItem : orderItems) {
      assertEquals(order.getGiOrderPk(), orderItem.getGiOrder().getGiOrderPk(), "giOrderPk");
      giBaseDataHandler.putGiOrderItem(GeneralHelper.makeMapKeyWithIx(keyOrderItem, i), orderItem);
      i++;
    }

    assertEquals(count, order.getCntItems());
    assertEquals(count, i);
  }

  @Then("order item {string} has: stat = {StringExt}, idArticle = {StringExt}, qtyActual = {DoubleExt}, qtyReserved = {DoubleExt}, qtyCanceled = {DoubleExt}, typStock = {StringExt}, typLock = {StringExt}, wtTarget = {DoubleExt}, volTarget = {DoubleExt}, idCre = {StringExt}, tsCre = {DateTimeExt}, idUpd = {StringExt}, tsUpd = {DateTimeExt}")
  public void verifyOrderItem(String key, GherkinType<String> stat, GherkinType<String> idArticle, GherkinType<Double> qtyActual,
      GherkinType<Double> qtyReserved, GherkinType<Double> qtyCanceled, GherkinType<String> typStock, GherkinType<String> typLock,
      GherkinType<Double> wtTarget, GherkinType<Double> volTarget, GherkinType<String> idCre, GherkinType<Date> tsCre, GherkinType<String> idUpd,
      GherkinType<Date> tsUpd) {

    //@formatter:off
    GiOrderItem record = giBaseDataHandler.getGiOrderItem(key);

    assertAll(
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> idArticle.assertEquality(record.getIdArticle(), "idArticle"),
        () -> qtyActual.assertEquality(record.getQtyActual(), "qtyActual"),
        () -> qtyReserved.assertEquality(record.getQtyReserved(), "qtyReserved"),
        () -> qtyCanceled.assertEquality(record.getQtyCanceled(), "qtyCanceled"),
        () -> typStock.assertEquality(record.getTypStock(), "typStock"),
        () -> typLock.assertEquality(record.getTypLock(), "typLock"),
        () -> wtTarget.assertEquality(record.getWtTarget(), "wtTarget"),
        () -> volTarget.assertEquality(record.getVolTarget(), "volTarget"),
        () -> idCre.assertEquality(record.getIdCre(), "idCre"),
        () -> tsCre.assertEquality(record.getTsCre(), "tsCre"),
        () -> idUpd.assertEquality(record.getIdUpd(), "idUpd"),
        () -> tsUpd.assertEquality(record.getTsUpd(), "tsUpd")
    );
    //@formatter:on
  }

  @Then("order {string} has {int} bps record(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void saveBpsRecordsOfOrder(String key, int count, String keyBpsRecord) {
    GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    GiOrder order = orderRep.findOne(giOrderPk);

    assertEquals(count, order.getCntItems());

    for (int i = 0; i < order.getCntItems(); i++) {
      List<BpsProcessRecord> bpsRecords = bpsSelectHelper.readRecordsByReference("GI_ORDER_ITEM", giOrderPk.getIdSite(), giOrderPk.getIdClient(),
          giOrderPk.getIdOrder(), giOrderPk.getNumPartialOrder().toString(), Integer.toString(i + 1), null);
      assertEquals(1, bpsRecords.size());
      bpSchedDataHandler.putProcessRecord(GeneralHelper.makeMapKeyWithIx(keyBpsRecord, i), bpsRecords.get(0));
    }
  }

  @Then("bps record {string} has one picking order, saved as {string}")
  @Transactional(readOnly = true)
  public void savePickingOrder(String key, String keyPickingOrder) {
    BpsProcessRecordPk bpsProcessRecordPk = bpSchedDataHandler.getProcessRecord(key).getBpsProcessRecordPk();

    List<PiPickingOrderBpsAsgmt> piPickingOrderBpsAsgmt = piPickingOrderBpsAsgmtRep.findByIdSiteAndIdRecord(bpsProcessRecordPk.getIdSite(),
        bpsProcessRecordPk.getIdRecord());

    assertEquals(1, piPickingOrderBpsAsgmt.size());

    PiPickingOrder piPickingOrder = piPickingOrderBpsAsgmt.get(0).getPiPickingOrder();
    giBaseDataHandler.putPiPickingOrder(keyPickingOrder, piPickingOrder);
  }

  @Then("picking order {string} has one picking trip, saved as {string}")
  @Transactional(readOnly = true)
  public void savePickingTrip(String key, String keyPickingTrip) {
    PiPickingOrder piPickingOrder = giBaseDataHandler.getPiPickingOrder(key);
    PiPickingTrip piPickingTrip = piPickingTripRep.findOne(piPickingOrder.getPiPickingTrip().getPiPickingTripPk());
    giBaseDataHandler.putPiPickingTrip(keyPickingTrip, piPickingTrip);
  }

  @Then("save load unit of picking order {string} as {string}")
  @Transactional(readOnly = true)
  public void savePickingOrderLoadUnit(String keyPickingOrder, String keyLoadUnit) {
    PiPickingOrder piPickingOrder = giBaseDataHandler.getPiPickingOrder(keyPickingOrder);
    ImLoadUnit loadUnit = loadUnitRep.findOne(new ImLoadUnitPk(piPickingOrder.getPiPickingOrderPk().getIdSite(), piPickingOrder.getIdLu()));
    inventoryDataHandler.putLoadUnit(keyLoadUnit, loadUnit);
  }

  @Then("reload picking order {string}")
  @Transactional(readOnly = true)
  public void reloadPickingOrder(String key) {
    PiPickingOrder piPickingOrder = giBaseDataHandler.getPiPickingOrder(key);
    piPickingOrder = piPickingOrderRep.findOne(piPickingOrder.getPiPickingOrderPk());
    giBaseDataHandler.putPiPickingOrder(key, piPickingOrder);
  }

  @Then("reload picking trip {string}")
  @Transactional(readOnly = true)
  public void reloadPickingTrip(String key) {
    PiPickingTrip piPickingTrip = giBaseDataHandler.getPiPickingTrip(key);
    piPickingTrip = piPickingTripRep.findOne(piPickingTrip.getPiPickingTripPk());
    giBaseDataHandler.putPiPickingTrip(key, piPickingTrip);
  }

  @Then("picking order {string} has: idPickingTrip = {StringExt}, stat = {StringExt}, idCre = {StringExt}, tsCre = {DateTimeExt}, idUpd = {StringExt}, tsUpd = {DateTimeExt}")
  public void verifyPickingOrder(String key, GherkinType<String> idPickingTrip, GherkinType<String> stat, GherkinType<String> idCre,
      GherkinType<Date> tsCre, GherkinType<String> idUpd, GherkinType<Date> tsUpd) {
    idPickingTrip.setGetterForKey(giBaseDataHandler.idPickingTripGetter);

    //@formatter:off
    PiPickingOrder record = giBaseDataHandler.getPiPickingOrder(key);
    
    assertAll(
        () -> idPickingTrip.assertEquality(record.getIdPickingTrip(), "idPickingTrip"),
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> idCre.assertEquality(record.getIdCre(), "idCre"),
        () -> tsCre.assertEquality(record.getTsCre(), "tsCre"),
        () -> idUpd.assertEquality(record.getIdUpd(), "idUpd"),
        () -> tsUpd.assertEquality(record.getTsUpd(), "tsUpd")
    );
    //@formatter:on
  }

  @Then("picking trip {string} has: stat = {StringExt}, idCre = {StringExt}, tsCre = {DateTimeExt}, idUpd = {StringExt}, tsUpd = {DateTimeExt}")
  public void verifyPickingTrip(String key, GherkinType<String> stat, GherkinType<String> idCre, GherkinType<Date> tsCre, GherkinType<String> idUpd,
      GherkinType<Date> tsUpd) {
    //@formatter:off
    PiPickingTrip record = giBaseDataHandler.getPiPickingTrip(key);

    assertAll(
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> idCre.assertEquality(record.getIdCre(), "idCre"),
        () -> tsCre.assertEquality(record.getTsCre(), "tsCre"),
        () -> idUpd.assertEquality(record.getIdUpd(), "idUpd"),
        () -> tsUpd.assertEquality(record.getTsUpd(), "tsUpd")
    );
    //@formatter:on
  }

  @Then("save load unit of picking trip {string} as {string}")
  @Transactional(readOnly = true)
  public void savePickingTripLoadUnit(String keyPickingTrip, String keyLoadUnit) {
    PiPickingTrip piPickingTrip = giBaseDataHandler.getPiPickingTrip(keyPickingTrip);
    ImLoadUnit loadUnit = loadUnitRep.findOne(new ImLoadUnitPk(piPickingTrip.getPiPickingTripPk().getIdSite(), piPickingTrip.getIdLu()));
    inventoryDataHandler.putLoadUnit(keyLoadUnit, loadUnit);
  }

  private boolean verifyPickingOrdersAllMatch(DataTable table) {
    List<String> list = table.asList();
    PiPickingOrderPk pivot = giBaseDataHandler.getPiPickingOrder(list.get(0)).getPiPickingOrderPk();

    boolean result = list.stream().map(key -> {
      PiPickingOrderPk piPickingOrderPk = giBaseDataHandler.getPiPickingOrder(key).getPiPickingOrderPk();
      return piPickingOrderPk;
    }).allMatch(elem -> elem.equals(pivot));

    return result;
  }

  @Then("picking orders are equal:")
  public void verifyPickingOrdersEqual(DataTable table) {
    assertTrue(verifyPickingOrdersAllMatch(table));
  }

  @Then("picking orders are unequal:")
  public void verifyPickingOrdersUnequal(DataTable table) {
    assertFalse(verifyPickingOrdersAllMatch(table));
  }

  private boolean verifyPickingTripsAllMatch(DataTable table) {
    List<String> list = table.asList();
    PiPickingTripPk pivot = giBaseDataHandler.getPiPickingTrip(list.get(0)).getPiPickingTripPk();

    boolean result = list.stream().map(key -> {
      PiPickingTripPk piPickingOrderPk = giBaseDataHandler.getPiPickingTrip(key).getPiPickingTripPk();
      return piPickingOrderPk;
    }).allMatch(elem -> elem.equals(pivot));

    return result;
  }

  @Then("picking trips are equal:")
  public void verifyPickingTripsEqual(DataTable table) {
    assertTrue(verifyPickingTripsAllMatch(table));
  }

  @Then("picking trips are unequal:")
  public void verifyPickingTripsUnequal(DataTable table) {
    assertFalse(verifyPickingTripsAllMatch(table));
  }

  @Then("save distribution trip of load unit id {StringExt} as {string}")
  @Transactional(readOnly = true)
  public void saveLoadUnitDistributionTrip(GherkinType<String> idLu, String key) {
    idLu.setGetterForKey(inventoryDataHandler.idLuGetter);
    List<DiDistribTrip> diDistribTrips = diDistribTripRep.findByDiDistribTripPkIdSiteAndIdLuAndStatLessThan( //
        generalHelper.getIdSite(), idLu.get(), "99"); // Read all distribution trips, even if completed

    assertEquals(1, diDistribTrips.size());
    DiDistribTrip diDistribTrip = diDistribTrips.get(0);
    giBaseDataHandler.putDiDistribTrip(key, diDistribTrip);
  }

  @Then("distribution trip {string} has: stat = {StringExt}, typDistribTrip = {StringExt}, idLu = {StringExt}, idCre = {StringExt}, tsCre = {DateTimeExt}, idUpd = {StringExt}, tsUpd = {DateTimeExt}, "
      + "idUserRelease = {StringExt}, idTerminalRelease = {StringExt}, idWorkcenterRelease = {StringExt}, tsRelease = {DateTimeExt}, tsStart = {DateTimeExt}, tsEnd = {DateTimeExt}, "
      + "priority = {LongExt}, idStoreInZone = {StringExt}, idStoreOutZone = {StringExt}")
  public void verifyDistributionTrip(String key, GherkinType<String> stat, GherkinType<String> typDistribTrip, GherkinType<String> idLu,
      GherkinType<String> idCre, GherkinType<Date> tsCre, GherkinType<String> idUpd, GherkinType<Date> tsUpd, GherkinType<String> idUserRelease,
      GherkinType<String> idTerminalRelease, GherkinType<String> idWorkcenterRelease, GherkinType<Date> tsRelease, GherkinType<Date> tsStart,
      GherkinType<Date> tsEnd, GherkinType<Long> priority, GherkinType<String> idStoreInZone, GherkinType<String> idStoreOutZone) {
    //@formatter:off
    DiDistribTrip record = giBaseDataHandler.getDiDistribTrip(key);

    assertAll(
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> typDistribTrip.assertEquality(record.getTypDistribTrip(), "typDistribTrip"),
        () -> idLu.assertEquality(record.getIdLu(), "idLu"),
        () -> idCre.assertEquality(record.getIdCre(), "idCre"),
        () -> tsCre.assertEquality(record.getTsCre(), "tsCre"),
        () -> idUpd.assertEquality(record.getIdUpd(), "idUpd"),
        () -> tsUpd.assertEquality(record.getTsUpd(), "tsUpd"),
        () -> idUserRelease.assertEquality(record.getIdUserRelease(), "idUserRelease"),
        () -> idTerminalRelease.assertEquality(record.getIdTerminalRelease(), "idTerminalRelease"),
        () -> idWorkcenterRelease.assertEquality(record.getIdWorkcenterRelease(), "idWorkcenterRelease"),
        () -> tsRelease.assertEquality(record.getTsRelease(), "tsRelease"),
        () -> tsStart.assertEquality(record.getTsStart(), "tsStart"),
        () -> tsEnd.assertEquality(record.getTsEnd(), "tsEnd"),
        () -> priority.assertEquality(record.getPriority(), "priority"),
        () -> idStoreInZone.assertEquality(record.getIdStoreInZone(), "idStoreInZone"),
        () -> idStoreOutZone.assertEquality(record.getIdStoreOutZone(), "idStoreOutZone")
    );
    //@formatter:on
  }

}
