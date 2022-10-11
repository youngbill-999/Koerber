package com.inconso.bend.inwmsx.it.transport;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.bpsched.pers.model.BpsProcessRecord;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inwmsx.it.bpsched.BPSchedDataHandler;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import com.inconso.bend.transport.pers.gen.TcsTaskPk;
import com.inconso.bend.transport.pers.gen.TcsTaskTargetPk;
import com.inconso.bend.transport.pers.model.TcsTask;
import com.inconso.bend.transport.pers.model.TcsTaskBpsAsgmt;
import com.inconso.bend.transport.pers.model.TcsTaskTarget;
import com.inconso.bend.transport.pers.rep.TcsTaskBpsAsgmtRep;
import com.inconso.bend.transport.pers.rep.TcsTaskRep;
import com.inconso.bend.transport.pers.rep.TcsTaskTargetRep;
import io.cucumber.java.en.Then;

public class TransportFieldVerifier {

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private TransportDataHandler transportDataHandler;

  @Autowired
  private BPSchedDataHandler   bpSchedDataHandler;

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private TcsTaskRep           taskRep;

  @Autowired
  private TcsTaskTargetRep     taskTargetRep;

  @Autowired
  private TcsTaskBpsAsgmtRep   taskBpsAsgmtRep;

  @Then("transport task {string} has: idTask = {StringExt}, stat = {StringExt}, priority = {LongExt}, typLu = {StringExt}, storageArea = {StringExt}, storageLocation = {StringExt}, "
      + "clProcess = {StringExt}, typProcess = {StringExt}, stepProcess = {StringExt}")
  public void verifyTcsTask(String keyTask, GherkinType<String> idTask, GherkinType<String> stat, GherkinType<Long> priority,
      GherkinType<String> typLu, GherkinType<String> storageArea, GherkinType<String> storageLocation, GherkinType<String> clProcess,
      GherkinType<String> typProcess, GherkinType<String> stepProcess) {

    //@formatter:off
    TcsTask record = transportDataHandler.getTcsTask(keyTask);
    
    assertAll(
        () -> assertEquals(generalHelper.getIdSite(), record.getTcsTaskPk().getIdSite(), "idSite"),
        () -> assertNotNull(record.getTcsTaskPk().getIdTask(), "idTask"),
        () -> idTask.assertEquality(record.getTcsTaskPk().getIdTask(), "idTask"),
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> priority.assertEquality(record.getPriority(), "priority"),
        () -> assertNotNull(record.getIdLu(), "idLu"),
        () -> typLu.assertEquality(record.getTypLu(), "typLu"),
        () -> assertNotNull(record.getStorageArea(), "storageArea"),
        () -> storageArea.assertEquality(record.getStorageArea(), "storageArea"),
        () -> assertNotNull(record.getStorageLocation(), "storageLocation"),
        () -> storageLocation.assertEquality(record.getStorageLocation(), "storageLocation"),
        () -> clProcess.assertEquality(record.getClProcess(), "clProcess"),
        () -> typProcess.assertEquality(record.getTypProcess(), "typProcess"),
        () -> stepProcess.assertEquality(record.getStepProcess(), "stepProcess")
    );
    //@formatter:on
  }

  @Then("transport task {string} has {int} bps record(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void saveBpsRecordsOfTcsTask(String keyTask, int count, String keyBpsRecord) {
    TcsTask task = transportDataHandler.getTcsTask(keyTask);

    List<TcsTaskBpsAsgmt> tcsTaskBpsAsgmts = taskBpsAsgmtRep.findByTcsTask(task);

    int i = 0;
    for (TcsTaskBpsAsgmt tcsTaskBpsAsgmt : tcsTaskBpsAsgmts) {
      assertEquals(task.getTcsTaskPk().getIdTask(), tcsTaskBpsAsgmt.getTcsTask().getTcsTaskPk().getIdTask(), "idTask");
      BpsProcessRecord bpsRecord = tcsTaskBpsAsgmt.getBpsProcessRecord();
      bpSchedDataHandler.putProcessRecord(GeneralHelper.makeMapKeyWithIx(keyBpsRecord, i), bpsRecord);
      i++;
    }

    assertEquals(count, i);
  }

  @Then("bps record {string} has one tcs task, saved as {string}")
  @Transactional(readOnly = true)
  public void saveTcsTaskOfBpsRecord(String keyBpsRecord, String keyTask) {
    BpsProcessRecord bpsRecord = bpSchedDataHandler.getProcessRecord(keyBpsRecord);

    List<TcsTaskBpsAsgmt> tcsTaskBpsAsgmts = taskBpsAsgmtRep.findByBpsProcessRecord(bpsRecord.getBpsProcessRecordPk().getIdSite(),
        bpsRecord.getBpsProcessRecordPk().getIdRecord());

    assertEquals(1, tcsTaskBpsAsgmts.size());
    TcsTaskBpsAsgmt tcsTaskBpsAsgmt = tcsTaskBpsAsgmts.get(0);

    TcsTask record = tcsTaskBpsAsgmt.getTcsTask();
    transportDataHandler.putTcsTask(keyTask, record);
  }

  @Then("transport task target {string} has: idTask = {StringExt}, numTarget = {LongExt}, stat = {StringExt}, numSort = {LongExt}, "
      + "storageArea = {StringExt}, storageLocation = {StringExt}, idTransaction = {StringExt}")
  public void verifyTcsTaskTarget(String key, GherkinType<String> idTask, GherkinType<Long> numTarget, GherkinType<String> stat,
      GherkinType<Long> numSort, GherkinType<String> storageArea, GherkinType<String> storageLocation, GherkinType<String> idTransaction) {

    //@formatter:off
    TcsTaskTarget record = transportDataHandler.getTcsTaskTarget(key);

    assertAll(
        () -> assertEquals(generalHelper.getIdSite(), record.getTcsTaskTargetPk().getIdSite(), "idSite"),
        () -> assertNotNull(record.getTcsTaskTargetPk().getIdTask(), "idTask"),
        () -> idTask.assertEquality(record.getTcsTaskTargetPk().getIdTask(), "idTask"),
        () -> numTarget.assertEquality(record.getTcsTaskTargetPk().getNumTarget(), "numTarget"),
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> numSort.assertEquality(record.getNumSort(), "numSort"),
        () -> assertNotNull(record.getStorageArea(), "storageArea"),
        () -> storageArea.assertEquality(record.getStorageArea(), "storageArea"),
        () -> assertNotNull(record.getStorageLocation(), "storageLocation"),
        () -> storageLocation.assertEquality(record.getStorageLocation(), "storageLocation"),
        () -> assertNotNull(record.getIdTransaction(), "idTransaction"),
        () -> idTransaction.assertEquality(record.getIdTransaction(), "idTransaction")
    );
    //@formatter:on
  }

  @Then("save current transport task of load unit {string} as {string}")
  @Transactional(readOnly = true)
  public void saveTcsTask(String keyLu, String keyTask) throws InterruptedException {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(keyLu);

    List<TcsTask> tasks = taskRep.findByIdSiteAndIdLu(generalHelper.getIdSite(), loadUnit.getImLoadUnitPk().getIdLu());

    TcsTask task = tasks.get(tasks.size() - 1);
    transportDataHandler.putTcsTask(keyTask, task);
  }

  @Then("load unit {string} has {int} transport task(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void saveTcsTasks(String keyLu, int count, String keyTask) {
    ImLoadUnit loadUnit = inventoryDataHandler.getLoadUnit(keyLu);

    List<TcsTask> tasks = taskRep.findByIdSiteAndIdLu(generalHelper.getIdSite(), loadUnit.getImLoadUnitPk().getIdLu());

    int i = 0;
    for (TcsTask task : tasks) {
      assertEquals(loadUnit.getImLoadUnitPk().getIdLu(), task.getIdLu(), "idLu");
      transportDataHandler.putTcsTask(GeneralHelper.makeMapKeyWithIx(keyTask, i), task);
      i++;
    }

    assertEquals(count, i);
  }

  @Then("transport task {string} has {int} transport task target(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void saveTcsTaskTargets(String keyTask, int count, String keyTaskTarget) {
    TcsTask task = transportDataHandler.getTcsTask(keyTask);

    // In principal a TcsTaskTarget may have several TcsTaskTargets. At the moment only 1:1 relationship is supported
    List<TcsTaskTarget> taskTargets = new ArrayList<TcsTaskTarget>();
    TcsTaskTarget taskTarget = taskTargetRep.findOne(new TcsTaskTargetPk(task.getTcsTaskPk().getIdSite(), task.getTcsTaskPk().getIdTask(), 1L));
    taskTargets.add(taskTarget);

    int i = 0;
    for (TcsTaskTarget target : taskTargets) {
      TcsTaskPk taskPkExpected = task.getTcsTaskPk();
      TcsTaskPk taskPkActual = target.getTcsTask().getTcsTaskPk();
      assertEquals(taskPkExpected.getIdSite(), taskPkActual.getIdSite());
      assertEquals(taskPkExpected.getIdTask(), taskPkActual.getIdTask());
      transportDataHandler.putTcsTaskTarget(GeneralHelper.makeMapKeyWithIx(keyTaskTarget, i), target);
      i++;
    }

    assertEquals(count, i);
  }

  @Then("reload transport task {string}")
  @Transactional(readOnly = true)
  public void reloadTcsTask(String keyTask) {
    TcsTask task = transportDataHandler.getTcsTask(keyTask);
    task = taskRep.findOne(task.getTcsTaskPk());
    transportDataHandler.putTcsTask(keyTask, task);
  }

  @Then("reload transport task target {string}")
  @Transactional(readOnly = true)
  public void reloadTcsTaskTarget(String keyTaskTarget) {
    TcsTaskTarget task = transportDataHandler.getTcsTaskTarget(keyTaskTarget);
    task = taskTargetRep.findOne(task.getTcsTaskTargetPk());
    transportDataHandler.putTcsTaskTarget(keyTaskTarget, task);
  }

}
