package com.inconso.bend.inwmsx.it.bpsched;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.bpsched.logic.util.BPSchedSelectHelper;
import com.inconso.bend.bpsched.pers.gen.BpsProcessRecordPk;
import com.inconso.bend.bpsched.pers.model.BpsProcessRecord;
import com.inconso.bend.bpsched.pers.model.BpsProcessStep;
import com.inconso.bend.bpsched.pers.rep.BpsProcessRecordRep;
import com.inconso.bend.bpsched.pers.rep.BpsProcessStepRep;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.gen.ImQuantumPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inventory.pers.rep.ImQuantumRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import com.inconso.bend.inwmsx.it.topology.TopologyDataHandler;
import com.inconso.bend.topology.pers.gen.TopStorageLocationPk;
import com.inconso.bend.topology.pers.model.TopStorageLocation;
import com.inconso.bend.topology.pers.rep.TopStorageLocationRep;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;

public class BPSchedFieldVerifier {

  @Autowired
  private BPSchedDataHandler    bpSchedDataHandler;

  @Autowired
  private InventoryDataHandler  inventoryDataHandler;

  @Autowired
  private TopologyDataHandler   topologyDataHandler;

  @Autowired
  private GeneralHelper         generalHelper;

  @Autowired
  private BpsProcessRecordRep   processRecordRep;

  @Autowired
  private BPSchedSelectHelper   bpsSelectHelper;

  @Autowired
  private BpsProcessStepRep     processStepRep;

  @Autowired
  private ImQuantumRep          quantumRep;

  @Autowired
  private ImLoadUnitRep         loadUnitRep;

  @Autowired
  private TopStorageLocationRep topStorageLocationRep;

  @Then("bps record {string} has: idRecord = {StringExt}, stat = {StringExt}, typ = {StringExt}, priorityOrig = {LongExt}, idRecordGrp = {StringExt}, "
      + "typStep = {StringExt}, statStep = {StringExt}, tsStartTargetMaxStep = {DateTimeExt}, tsEndTargetMax = {DateTimeExt}, numConsecStep = {LongExt}, idNode = {StringExt}, "
      + "idArticle = {StringExt}, qty = {DoubleExt}, artvar = {StringExt}, typStock = {StringExt}, typLock = {StringExt}, "
      + "statQualityControl = {StringExt}, statCustoms = {StringExt}, sepCrit01 = {StringExt}, sepCrit02 = {StringExt}, sepCrit03 = {StringExt}, wt = {DoubleExt}, unitWt = {StringExt}, vol = {DoubleExt}, "
      + "unitVol = {StringExt}, idLuSrc = {StringExt}, idQuantumSrc = {StringExt}, storageAreaSrc = {StringExt}, storageLocationSrc = {StringExt}, storageAreaTgt = {StringExt}, storageLocationTgt = {StringExt}")
  public void verifyBpsRecord(String key, GherkinType<String> idRecord, GherkinType<String> stat, GherkinType<String> typ,
      GherkinType<Long> priorityOrig, GherkinType<String> idRecordGrp, GherkinType<String> typStep, GherkinType<String> statStep,
      GherkinType<Date> tsStartTargetMaxStep, GherkinType<Date> tsEndTargetMax, GherkinType<Long> numConsecStep, GherkinType<String> idNode,
      GherkinType<String> idArticle, GherkinType<Double> qty, GherkinType<String> artvar, GherkinType<String> typStock, GherkinType<String> typLock,
      GherkinType<String> statQualityControl, GherkinType<String> statCustoms, GherkinType<String> sepCrit01, GherkinType<String> sepCrit02,
      GherkinType<String> sepCrit03, GherkinType<Double> wt, GherkinType<String> unitWt, GherkinType<Double> vol, GherkinType<String> unitVol,
      GherkinType<String> idLuSrc, GherkinType<String> idQuantumSrc, GherkinType<String> storageAreaSrc, GherkinType<String> storageLocationSrc,
      GherkinType<String> storageAreaTgt, GherkinType<String> storageLocationTgt) {

    //@formatter:off
    BpsProcessRecord record = bpSchedDataHandler.getProcessRecord(key);

    assertAll(        
        () -> assertEquals(generalHelper.getIdSite(), record.getBpsProcessRecordPk().getIdSite(), "idSite"),
        () -> assertEquals(generalHelper.getIdClient(), record.getIdClient(), "idClient"),
        () -> assertNotNull(record.getBpsProcessRecordPk().getIdRecord(), "idRecord"),
        () -> idRecord.assertEquality(record.getBpsProcessRecordPk().getIdRecord(), "idRecord"),
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> typ.assertEquality(record.getTyp(), "typ"),
        () -> priorityOrig.assertEquality(record.getPriorityOrig(), "priorityOrig"),
        () -> assertNotNull(record.getIdRecordGrp(), "idRecordGrp"),
        () -> idRecordGrp.assertEquality(record.getIdRecordGrp(), "idRecordGrp"),
        () -> typStep.assertEquality(record.getTypStep(), "typStep"),
        () -> statStep.assertEquality(record.getStatStep(), "statStep"),        
        () -> tsStartTargetMaxStep.assertEquality(record.getTsStartTargetMaxStep(), "tsStartTargetMaxStep"),
        () -> tsEndTargetMax.assertEquality(record.getTsEndTargetMax(), "tsEndTargetMax"),
        () -> numConsecStep.assertEquality(record.getNumConsecStep(), "numConsecStep"),
        () -> idNode.assertEquality(record.getIdNode(), "idNode"),
        () -> idArticle.assertEquality(record.getIdArticle(), "idArticle"),
        () -> qty.assertEquality(record.getQty(), "qty"),
        () -> artvar.assertEquality(record.getArtvar(), "artvar"),
        () -> typStock.assertEquality(record.getTypStock(), "typStock"),
        () -> typLock.assertEquality(record.getTypLock(), "typLock"),
        () -> statQualityControl.assertEquality(record.getStatQualityControl(), "statQualityControl"),
        () -> statCustoms.assertEquality(record.getStatCustoms(), "statCustoms"),
        () -> sepCrit01.assertEquality(record.getSepCrit01(), "sepCrit01"),
        () -> sepCrit02.assertEquality(record.getSepCrit02(), "sepCrit02"),
        () -> sepCrit03.assertEquality(record.getSepCrit03(), "sepCrit03"),
        () -> wt.assertEquality(record.getWt(), "wt"),
        () -> unitWt.assertEquality(record.getUnitWt(), "unitWt"),
        () -> vol.assertEquality(record.getVol(), "vol"),
        () -> unitVol.assertEquality(record.getUnitVol(), "unitVol"),
        () -> assertNotNull(record.getIdLuSrc(), "idLuSrc"),
        () -> idLuSrc.assertEquality(record.getIdLuSrc(), "idLuSrc"),
        () -> assertNotNull(record.getIdQuantumSrc(), "idQuantumSrc"),
        () -> idQuantumSrc.assertEquality(record.getIdQuantumSrc(), "idQuantumSrc"),
        () -> storageAreaSrc.assertEquality(record.getStorageAreaSrc(), "storageAreaSrc"),
        () -> assertTrue((record.getStorageAreaSrc() == null) == (record.getStorageLocationSrc() == null), "storageLocationSrc"),
        () -> storageLocationSrc.assertEquality(record.getStorageLocationSrc(), "storageLocationSrc"),
        () -> storageAreaTgt.assertEquality(record.getStorageAreaTgt(), "storageAreaTgt"),
        () -> assertTrue((record.getStorageAreaTgt() == null) == (record.getStorageLocationTgt() == null), "storageLocationTgt"),
        () -> storageLocationTgt.assertEquality(record.getStorageLocationTgt(), "storageLocationTgt")
    );
    //@formatter:on
  }

  @Then("bps record {string} has: typRef = {string}, matches {string}")
  public void verifyBpsRecordRef(String BpsRecord, String typRef, String keyObject) {
    BpsProcessRecord record = bpSchedDataHandler.getProcessRecord(BpsRecord);
    assertNotNull(record, "bpsRecord");
    String[] ref = { record.getTypRef(), record.getIdRef1(), record.getIdRef2(), record.getIdRef3(), record.getIdRef4(), record.getIdRef5(),
        record.getIdRef6() };

    generalHelper.verifyReference(keyObject, typRef, ref);
  }

  @Then("bps step {string} has: idRecord = {StringExt}, numConsec = {LongExt}, statStep = {StringExt}, typStep = {StringExt}, tsStartTargetMaxStep = {DateTimeExt}, "
      + "idNode = {StringExt}, tsStart = {DateTimeExt}, tsEnd = {DateTimeExt}")
  public void verifyBpsStep(String key, GherkinType<String> idRecord, GherkinType<Long> numConsec, GherkinType<String> statStep,
      GherkinType<String> typStep, GherkinType<Date> tsStartTargetMaxStep, GherkinType<String> idNode, GherkinType<Date> tsStart,
      GherkinType<Date> tsEnd) {

    //@formatter:off
    BpsProcessStep record = bpSchedDataHandler.getProcessStep(key);

    assertAll(
        () -> assertEquals(generalHelper.getIdSite(), record.getBpsProcessStepPk().getIdSite(), "idSite"),
        () -> assertNotNull(record.getBpsProcessStepPk().getIdRecord(), "idRecord"),
        () -> idRecord.assertEquality(record.getBpsProcessStepPk().getIdRecord(), "idRecord"),
        () -> numConsec.assertEquality(record.getBpsProcessStepPk().getNumConsec(), "numConsec"),
        () -> statStep.assertEquality(record.getStatStep(), "statStep"),
        () -> typStep.assertEquality(record.getTypStep(), "typStep"),
        () -> idNode.assertEquality(record.getIdNode(), "idNode"),
        () -> tsStart.assertEquality(record.getTsStart(), "tsStart"),
        () -> tsEnd.assertEquality(record.getTsEnd(), "tsEnd")        
    );
    //@formatter:on
  }

  @Then("load unit {string} has {int} bps record(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void saveBpsRecords(String keyLu, int count, String key) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(keyLu);

    List<BpsProcessRecord> bpsRecords = processRecordRep.findByIdLuSrc(loadUnit.getImLoadUnitPk().getIdSite(), loadUnit.getImLoadUnitPk().getIdLu());

    int i = 0;
    for (BpsProcessRecord bpsRecord : bpsRecords) {
      assertEquals(loadUnit.getImLoadUnitPk().getIdLu(), bpsRecord.getIdLuSrc());
      bpSchedDataHandler.putProcessRecord(GeneralHelper.makeMapKeyWithIx(key, i), bpsRecord);
      i++;
    }

    assertEquals(count, i);
  }

  @Then("bps record {string} has {int} step(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void saveBpsSteps(String keyRecord, int count, String keyStep) {
    BpsProcessRecord bpsRecord = bpSchedDataHandler.getProcessRecord(keyRecord);
    List<BpsProcessStep> bpsSteps = processStepRep.findByProcessRecord(bpsRecord.getBpsProcessRecordPk().getIdSite(),
        bpsRecord.getBpsProcessRecordPk().getIdRecord());

    int i = 0;
    for (BpsProcessStep bpsStep : bpsSteps) {
      assertEquals(bpsRecord.getBpsProcessRecordPk(), bpsStep.getBpsProcessRecord().getBpsProcessRecordPk());
      bpSchedDataHandler.putProcessStep(GeneralHelper.makeMapKeyWithIx(keyStep, i), bpsStep);
      i++;
    }

    assertEquals(count, i);
  }

  @Then("reload bps record {string}")
  @Transactional(readOnly = true)
  public void reloadBpsRecord(String keyRecord) {
    BpsProcessRecord bpsRecord = bpSchedDataHandler.getProcessRecord(keyRecord);
    bpsRecord = processRecordRep.findOne(bpsRecord.getBpsProcessRecordPk());
    bpSchedDataHandler.putProcessRecord(keyRecord, bpsRecord);
  }

  @Then("reload bps step {string}")
  @Transactional(readOnly = true)
  public void reloadBpsStep(String keyStep) {
    BpsProcessStep bpsStep = bpSchedDataHandler.getProcessStep(keyStep);
    bpsStep = processStepRep.findOne(bpsStep.getBpsProcessStepPk());
    bpSchedDataHandler.putProcessStep(keyStep, bpsStep);
  }

  @Then("save src quantum of bps record {string} as {string}")
  @Transactional(readOnly = true)
  public void saveSrcQuantum(String keyRecord, String keyQuantum) {
    BpsProcessRecord bpsRecord = bpSchedDataHandler.getProcessRecord(keyRecord);
    ImQuantum quantum = quantumRep.findOne(new ImQuantumPk(bpsRecord.getBpsProcessRecordPk().getIdSite(), bpsRecord.getIdQuantumSrc()));
    inventoryDataHandler.putQuantum(keyQuantum, quantum);
  }

  @Then("save src load unit of bps record {string} as {string}")
  @Transactional(readOnly = true)
  public void saveSrcLoadUnit(String keyRecord, String keyLoadUnit) {
    BpsProcessRecord bpsRecord = bpSchedDataHandler.getProcessRecord(keyRecord);
    ImLoadUnit loadUnit = loadUnitRep.findOne(new ImLoadUnitPk(bpsRecord.getBpsProcessRecordPk().getIdSite(), bpsRecord.getIdLuSrc()));
    inventoryDataHandler.putLoadUnit(keyLoadUnit, loadUnit);
  }

  @Then("save tgt location of bps record {string} as {string}")
  @Transactional(readOnly = true)
  public void saveTgtLocation(String keyRecord, String keyTopStorageLocation) {
    BpsProcessRecord bpsRecord = bpSchedDataHandler.getProcessRecord(keyRecord);
    TopStorageLocation topStorageLocation = topStorageLocationRep.findOne(
        new TopStorageLocationPk(bpsRecord.getBpsProcessRecordPk().getIdSite(), bpsRecord.getStorageAreaTgt(), bpsRecord.getStorageLocationTgt()));
    topologyDataHandler.putTopStorageLocation(keyTopStorageLocation, topStorageLocation);
  }

  @Transactional(readOnly = true)
  public void saveBpsRecordsByReference(String[] ref, int count, String key) {
    List<BpsProcessRecord> bpsRecords = bpsSelectHelper.readRecordsByReference(ref[0], ref[1], ref[2], ref[3], ref[4], ref[5], ref[6]);

    int i = 0;
    for (BpsProcessRecord bpsRecord : bpsRecords) {
      bpSchedDataHandler.putProcessRecord(GeneralHelper.makeMapKeyWithIx(key, i), bpsRecord);
      i++;
    }

    assertEquals(count, bpsRecords.size(), "count");
  }

  private boolean verifyBpsRecordsAllMatch(DataTable table) {
    List<String> list = table.asList();
    BpsProcessRecordPk pivot = bpSchedDataHandler.getProcessRecord(list.get(0)).getBpsProcessRecordPk();

    boolean result = list.stream().map(key -> {
      BpsProcessRecordPk piPickingOrderPk = bpSchedDataHandler.getProcessRecord(key).getBpsProcessRecordPk();
      return piPickingOrderPk;
    }).allMatch(elem -> elem.equals(pivot));

    return result;
  }

  @Then("bps records are equal:")
  public void verifyBpsRecordsEqual(DataTable table) {
    assertTrue(verifyBpsRecordsAllMatch(table));
  }

  @Then("bps records are unequal:")
  public void verifyBpsRecordsUnequal(DataTable table) {
    assertFalse(verifyBpsRecordsAllMatch(table));
  }

}
