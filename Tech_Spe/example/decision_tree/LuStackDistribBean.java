package com.inconso.bend.distrib.logic.bps;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.inconso.bend.bpsched.api.LogicalGroupCrit;
import com.inconso.bend.bpsched.api.LogicalLoadUnitGroupCrit;
import com.inconso.bend.bpsched.config.BPSchedStatPS;
import com.inconso.bend.bpsched.pers.model.BpsProcessRecord;
import com.inconso.bend.bpsched.pers.model.BpsProcessStep;
import com.inconso.bend.bpsched.pers.rep.BpsProcessRecordRep;
import com.inconso.bend.core.exception.BendException;
import com.inconso.bend.core.logic.BendUserManager;
import com.inconso.bend.distrib.config.DiDistribBpsStatPsDistribEnum;
import com.inconso.bend.distrib.config.DiDistribParaNameEnum;
import com.inconso.bend.distrib.config.DiDistribSequences;
import com.inconso.bend.distrib.config.DiDistribTextCodes;
import com.inconso.bend.distrib.config.DiDistribTripBpsAsgmtStatEnum;
import com.inconso.bend.distrib.config.DiDistribTripStatEnum;
import com.inconso.bend.distrib.config.DiDistribTripTypEnum;
import com.inconso.bend.distrib.config.DiImClProcessCode;
import com.inconso.bend.distrib.config.DiImStepProcessCode;
import com.inconso.bend.distrib.config.DiImTypProcessCode;
import com.inconso.bend.distrib.config.DiToTypRefCode;
import com.inconso.bend.distrib.logic.DiDistribJob;
import com.inconso.bend.distrib.pers.gen.DiDistribTripBpsAsgmtPk;
import com.inconso.bend.distrib.pers.model.DiDistribTrip;
import com.inconso.bend.distrib.pers.model.DiDistribTripBpsAsgmt;
import com.inconso.bend.distrib.pers.rep.DiDistribTripBpsAsgmtRep;
import com.inconso.bend.inventory.config.ImStepProcessCode;
import com.inconso.bend.inventory.logic.model.ImBaseLu;
import com.inconso.bend.inventory.logic.transaction.api.ImRelluInput;
import com.inconso.bend.inventory.logic.transaction.api.ImRelluInput.TypeOfRelocation;
import com.inconso.bend.inventory.logic.transaction.api.ImStaluInput;
import com.inconso.bend.inventory.logic.transaction.lu.ImLoadUnitTransactionManager;
import com.inconso.bend.inventory.logic.transaction.util.ImQuantumUtils;
import com.inconso.bend.inventory.logic.validator.ImTransitChecksUtil;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitStackPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImLoadUnitStack;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitStackRep;
import com.inconso.bend.inventory.pers.rep.ImQuantumRep;
import com.inconso.bend.slsearch.logic.SLSearchManager;
import com.inconso.bend.slsearch.logic.api.SLSearchLuInput;
import com.inconso.bend.slsearch.logic.api.SLSearchOutput;
import com.inconso.bend.topology.pers.gen.TopStorageLocationPk;
import com.inconso.bend.topology.pers.model.TopStorageLocation;
import com.inconso.bend.topology.pers.model.TopStoreInZone;
import com.inconso.bend.topology.pers.rep.TopStorageLocationRep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component(value = "LuStackDistribBean")
public class LuStackDistribBean extends AbstractDistribBean {

  @Autowired
  private BpsProcessRecordRep          bpsProcessRecordRep;

  @Autowired
  private SLSearchManager              slSearchManager;

  @Autowired
  private ImLoadUnitTransactionManager loadUnitTransactionManager;

  @Autowired
  private DiDistribTripBpsAsgmtRep     diDistribTripBpsAsgmtRep;

  @Autowired
  private TopStorageLocationRep        topStorageLocationRep;

  @Autowired
  private ImQuantumRep                 imQuantumRep;

  @Autowired
  private ImQuantumUtils               imQuantumUtils;

  @Autowired
  private ImLoadUnitStackRep           imLoadUnitStackRep;

  @Autowired
  private DiDistribJob                 diDistribJob;

  @Override
  public LogicalGroupCrit createStartGroupCriterion(BpsProcessRecord processRecord) {

    if (processRecord.getIdLuSrc() == null) return null;

    ImBaseLu baseLu = imLoadUnitChecksJob.getBaseLuIdOfStack(processRecord.getBpsProcessRecordPk().getIdSite(), processRecord.getIdLuSrc());

    LogicalLoadUnitGroupCrit groupCrit = new LogicalLoadUnitGroupCrit(processRecord.getBpsProcessStepCurr().getGroupName(),
        processRecord.getBpsProcessStepCurr().getTypStep(), processRecord.getBpsProcessRecordPk().getIdSite(), baseLu.getIdLu());

    groupCrit.setBean(this);

    return groupCrit;
  }

  @Override
  public List<BpsProcessRecord> readStartGroup(LogicalGroupCrit groupCrit) {

    if (groupCrit instanceof LogicalLoadUnitGroupCrit luGroupCrit) {
      //
      return bpsProcessRecordRep.findRecordsByBaseLuId(luGroupCrit.getIdSite(), luGroupCrit.getIdLu(), luGroupCrit.getTypStep(),
          luGroupCrit.getGroupName(), codeCache.getValue(BPSchedStatPS.CANCELED));
    }

    return new ArrayList<>();
  }

  @Override
  protected void dataChecks(List<BpsProcessRecord> records, String idLu) {
    super.dataChecks(records, idLu);
    // load unit must not be in transit
    ImLoadUnit loadUnit = imLoadUnitChecksJob.findLoadUnit(wmsBaseHelper.getCurrentSite(), idLu);
    ImTransitChecksUtil.assertLoadUnitSrcNotInTransit(loadUnit);
    // Check whether there is no unfinished distribution trip for this load unit
    assertNoOpenDistribTripForLu(loadUnit);
    // every quantum on the stack must be found in the process records and the source load unit id must be the container to be distributed
    checkQuanta(records, idLu);
  }

  /**
   * Checks on quanta
   * 
   * @param records
   *          process records to be processed
   * @param idLu
   *          base load unit id
   */
  protected void checkQuanta(List<BpsProcessRecord> records, String idLu) {
    // get every quantum on the stack and check if there is a process record for it
    List<ImQuantum> quantumList = imQuantumRep.findByIdSiteAndIdLu(wmsBaseHelper.getCurrentSite(), idLu);
    Map<String, List<BpsProcessRecord>> recordsGroupedByIdQt = records.stream().collect(Collectors.groupingBy(BpsProcessRecord::getIdQuantumSrc));
    quantumList.forEach((quantum) -> {
      List<BpsProcessRecord> recordsForQuantum = recordsGroupedByIdQt.get(quantum.getImQuantumPk().getIdQuantum());
      if (recordsForQuantum == null || recordsForQuantum.isEmpty()) {
        throw new BendException(DiDistribTextCodes.DI_0002, quantum.getImQuantumPk().getIdSite(), quantum.getImQuantumPk().getIdQuantum());
      }
      // check if the highest load unit id of the quantum is assigned to the process record as source load unit
      String expectedIdLu = imQuantumUtils.calcHighestLoadUnitId(quantum);
      if (expectedIdLu != null && (!expectedIdLu.equals(recordsForQuantum.get(0).getIdLuSrc()))) {
        throw new BendException(DiDistribTextCodes.DI_0003, recordsForQuantum.get(0).getBpsProcessRecordPk().getIdSite(),
            recordsForQuantum.get(0).getBpsProcessRecordPk().getIdRecord(), expectedIdLu, recordsForQuantum.get(0).getIdLuSrc());
      }
    });
  }

  /**
   * throws an exception when there is already an unfinished distribution trip for the load unit
   * 
   * @param loadUnit
   *          the load unit
   */
  protected void assertNoOpenDistribTripForLu(ImLoadUnit loadUnit) {
    if (distribTripRep.countByIdSiteAndIdLuAndStatLt(loadUnit.getImLoadUnitPk().getIdSite(), loadUnit.getImLoadUnitPk().getIdLu(),
        codeCache.getValue(DiDistribTripStatEnum.CANCELED)) > 0) {
      throw new BendException(DiDistribTextCodes.DI_0001, loadUnit.getImLoadUnitPk().getIdSite(), loadUnit.getImLoadUnitPk().getIdLu());
    }
  }

  @Override
  protected void addSpecificTripData(DiDistribTrip trip, List<BpsProcessRecord> records, String idLu) {
    trip.setTypDistribTrip(codeCache.getValue(DiDistribTripTypEnum.LUSTAK));

    super.addSpecificTripData(trip, records, idLu);
  }

  @Override
  protected void prepareDistribTrip(DiDistribTrip trip, List<BpsProcessRecord> records, String idLu) {
    super.prepareDistribTrip(trip, records, idLu);
    // adjust ordering of records
    records.forEach((record) -> createDiTripBpsAsgmt(record, trip.getDiDistribTripPk().getIdDistribTrip()));
    boolean bItStacked = false;
    if (isItAStack(records)) {
      bItStacked = true;
      // group records per idLuSrc
      Map<String, List<BpsProcessRecord>> recordsGroupedByIdLu = records.stream().collect(Collectors.groupingBy(BpsProcessRecord::getIdLuSrc));
      recordsGroupedByIdLu.forEach((idLuOfRecords, recordListPerLu) -> {
        multipleContainerProcessing(recordListPerLu, trip, idLuOfRecords);
      });
    } else {
      ImLoadUnit loadUnit = imLoadUnitChecksJob.findLoadUnit(wmsBaseHelper.getCurrentSite(), idLu);
      singleContainerProcessing(loadUnit, records, trip);
    }
    // add store in zone in trip when it is the same for all records
    TopStoreInZone storeInZone = getUniqueStoreInZone(records);
    trip.setIdStoreInZone(storeInZone != null ? storeInZone.getTopStoreInZonePk().getIdStoreInZone() : null);
    // adjust ordering of records
    if (bItStacked) {
      bPSchedSortingManager.sortRecordsByStoreInZone(records, true);
      records.forEach((record) -> updateNumSortDiTripBpsAsgmtLoc(record, trip.getDiDistribTripPk().getIdDistribTrip()));
    }
  }

  /**
   * returns the store in zone when all process records are assigned to the same store in zone, otherwise it returns null
   * 
   * @param records
   *          the records to be processed
   * @return {@link TopStoreInZone}
   */
  protected TopStoreInZone getUniqueStoreInZone(List<BpsProcessRecord> records) {
    TopStoreInZone tmpStoreInZone = null;
    for (BpsProcessRecord record : records) {
      TopStorageLocation location = topStorageLocationRep
          .findOne(new TopStorageLocationPk(record.getBpsProcessRecordPk().getIdSite(), record.getStorageAreaTgt(), record.getStorageLocationTgt()));
      if ((location.getTopStoreInZone() == null) || (tmpStoreInZone != null && !tmpStoreInZone.equals(location.getTopStoreInZone()))) {
        return null;
      } else {
        tmpStoreInZone = location.getTopStoreInZone();
      }
    }
    return tmpStoreInZone;
  }

  /**
   * helper method to check whether the records are stacked
   * 
   * @param records
   *          the process records
   * @return boolean value
   */
  protected boolean isItAStack(List<BpsProcessRecord> records) {
    for (BpsProcessRecord record : records) {
      if (imLoadUnitChecksJob.isLoadUnitStacked(record.getBpsProcessRecordPk().getIdSite(), record.getIdLuSrc())) {
        return true;
      }
    }
    return false;
  }

  /**
   * handles stacked load units and its records
   * 
   * @param records
   *          the records that belong to the current load unit
   * @param trip
   *          the distribution trip
   * @param idLu
   *          the id of the base load unit
   */
  protected void multipleContainerProcessing(List<BpsProcessRecord> records, DiDistribTrip trip, String idLu) {
    // the container will be removed from stack (except from the carrying load unit)
    if (imLoadUnitChecksJob.isLoadUnitStacked(wmsBaseHelper.getCurrentSite(), records.get(0).getIdLuSrc())) {
      unstackContainer(records.get(0), trip);
    }
    // singleContainerProcessing
    ImLoadUnit loadUnit = imLoadUnitChecksJob.findLoadUnit(wmsBaseHelper.getCurrentSite(), records.get(0).getIdLuSrc());
    singleContainerProcessing(loadUnit, records, trip);
  }

  /**
   * handles one load unit and all records that belong to it
   * 
   * @param loadUnit
   *          the load unit
   * @param records
   *          all records that belong to the load unit
   * @param trip
   *          the distribution trip
   */
  protected void singleContainerProcessing(ImLoadUnit loadUnit, List<BpsProcessRecord> records, DiDistribTrip trip) {
    // calculation of target location for the container
    SLSearchOutput slOutput = getTargeLocationForContainer(records.get(0).getBpsProcessStepCurr(), loadUnit.getImLoadUnitPk().getIdLu());
    if (slOutput.getStorageArea() == null || slOutput.getStorageLocation() == null) {
      throw new BendException(DiDistribTextCodes.DI_0004, loadUnit.getImLoadUnitPk().getIdSite(), loadUnit.getImLoadUnitPk().getIdLu());
    }
    // the container will be booked on the target location by RELOCATION
    bookRelocation(records.get(0).getBpsProcessStepCurr(), loadUnit.getImLoadUnitPk().getIdLu(), slOutput.getStorageArea(),
        slOutput.getStorageLocation(), trip);
    // add target storage location in records
    records.forEach((record) -> {
      record.setStorageAreaTgt(slOutput.getStorageArea());
      record.setStorageLocationTgt(slOutput.getStorageLocation());
      fillDiTripBpsAsgmtLoc(record, trip.getDiDistribTripPk().getIdDistribTrip());
    });
  }

  /**
   * Creates a DiDistribTripBpsAsgmt, a connection between the current process record and the DiDistribTrip
   * 
   * @param record
   *          the process record
   * @param idTrip
   *          the id of the trip
   * 
   * @return {@link DiDistribTripBpsAsgmt}
   */
  protected DiDistribTripBpsAsgmt createDiTripBpsAsgmt(BpsProcessRecord record, String idTrip) {
    DiDistribTripBpsAsgmtPk pk = new DiDistribTripBpsAsgmtPk(wmsBaseHelper.getCurrentSite(), idTrip, record.getBpsProcessRecordPk().getIdRecord());
    DiDistribTripBpsAsgmt asgmt = new DiDistribTripBpsAsgmt(pk);
    ImLoadUnitStack luStack = imLoadUnitStackRep.findOne(new ImLoadUnitStackPk(wmsBaseHelper.getCurrentSite(), record.getIdLuSrc()));
    asgmt.setStat(codeCache.getValue(DiDistribTripBpsAsgmtStatEnum.NEW));
    asgmt.setIdPut(sequenceUtils.getNextWithPrefix(DiDistribSequences.DI_SEQ_ID_PUT.name()));
    asgmt.setNumSort(record.getNumSort());
    asgmt.setIdQuantumSrc(record.getIdQuantumSrc());
    asgmt.setIdLuSrc(record.getIdLuSrc());
    asgmt.setStorageAreaTgt(record.getStorageAreaTgt());
    asgmt.setStorageLocationTgt(record.getStorageLocationTgt());
    if (luStack != null) {
      asgmt.setPosition(luStack.getPosition());
    }
    diDistribTripBpsAsgmtRep.persist(asgmt);
    return asgmt;
  }

  protected void fillDiTripBpsAsgmtLoc(BpsProcessRecord record, String idTrip) {
    DiDistribTripBpsAsgmtPk pk = new DiDistribTripBpsAsgmtPk(wmsBaseHelper.getCurrentSite(), idTrip, record.getBpsProcessRecordPk().getIdRecord());
    DiDistribTripBpsAsgmt asgmt = diDistribTripBpsAsgmtRep.findOne(pk);
    asgmt.setStorageAreaTgt(record.getStorageAreaTgt());
    asgmt.setStorageLocationTgt(record.getStorageLocationTgt());
    diDistribJob.updatePRAndDependencies(record, codeCache.getValue(BPSchedStatPS.READY), DiDistribBpsStatPsDistribEnum.CREATED_DISTRIB_TRIP);
  }

  protected void updateNumSortDiTripBpsAsgmtLoc(BpsProcessRecord record, String idTrip) {
    DiDistribTripBpsAsgmtPk pk = new DiDistribTripBpsAsgmtPk(wmsBaseHelper.getCurrentSite(), idTrip, record.getBpsProcessRecordPk().getIdRecord());
    DiDistribTripBpsAsgmt asgmt = diDistribTripBpsAsgmtRep.findOne(pk);
    asgmt.setNumSort(record.getNumSort());
  }

  /**
   * Unstacks the current container
   * 
   * @param record
   *          the current process record
   * @param trip
   *          the current distribution trip
   */
  protected void unstackContainer(BpsProcessRecord record, DiDistribTrip trip) {
    String key = bpsHelper.getStepDteNodeParaValue(record.getBpsProcessStepCurr(), DiDistribParaNameEnum.BOOKING_KEY);

    // @formatter:off
    ImStaluInput input = new ImStaluInput.Builder(
        wmsBaseHelper.getCurrentSite(),
        codeCache.getValue(DiImClProcessCode.DI),
        codeCache.getValue(DiImTypProcessCode.DISTRIB),
        codeCache.getValue(DiImStepProcessCode.PUT),
        key != null ? key : "*", 
        record.getIdLuSrc(), 
        BendUserManager.getManager().getIdUser())
        .withTypRefAndId(codeCache.getValue(DiToTypRefCode.DI_DISTRIB_TRIP), trip.getDiDistribTripPk().getIdSite(), trip.getDiDistribTripPk().getIdDistribTrip(), null, null, null, null)
        .build();
    // @formatter:on
    loadUnitTransactionManager.doStalu(input);
  }

  /**
   * books a RELOCATION-RELLU with the load unit to the target storage location
   * 
   * @param currentStep
   *          current process step
   * @param idLu
   *          the id of the load unit
   * @param storageAreaTgt
   *          target storage area
   * @param storageLocationTgt
   *          target storage location
   * @param trip
   *          current distribution trip
   */
  protected void bookRelocation(BpsProcessStep currentStep, String idLu, String storageAreaTgt, String storageLocationTgt, DiDistribTrip trip) {
    String key = bpsHelper.getStepDteNodeParaValue(currentStep, DiDistribParaNameEnum.BOOKING_KEY);

    // @formatter:off
    ImRelluInput input = new ImRelluInput.Builder(
        wmsBaseHelper.getCurrentSite(), 
        codeCache.getValue(DiImClProcessCode.DI),
        codeCache.getValue(DiImTypProcessCode.DISTRIB),
        codeCache.getValue(ImStepProcessCode.TRIP),
        key != null ? key : "*", 
        idLu, 
        storageAreaTgt, 
        storageLocationTgt, 
        TypeOfRelocation.RELOCATION, 
        BendUserManager.getManager().getIdUser())
        .withTypRefAndId(codeCache.getValue(DiToTypRefCode.DI_DISTRIB_TRIP), trip.getDiDistribTripPk().getIdSite(), trip.getDiDistribTripPk().getIdDistribTrip(), null, null, null, null)
        .build();
    // @formatter:on

    loadUnitTransactionManager.doRellu(input);
  }

  /**
   * Gets the target location for the current container by dte node parameter
   * 
   * @param currentStep
   *          current process step
   * @param idLu
   *          the id of the load unit
   * @return {@link SLSearchOutput}
   */
  protected SLSearchOutput getTargeLocationForContainer(BpsProcessStep currentStep, String idLu) {
    String slsRootNode = bpsHelper.getStepDteNodeParaValueOrThrowException(currentStep, DiDistribParaNameEnum.SLS_ROOT);

    SLSearchLuInput slSearchInput = new SLSearchLuInput.Builder(wmsBaseHelper.getCurrentSite(), idLu).build();

    return slSearchManager.searchLocationWithLu(wmsBaseHelper.getCurrentSite(), slsRootNode, slSearchInput);
  }

}
