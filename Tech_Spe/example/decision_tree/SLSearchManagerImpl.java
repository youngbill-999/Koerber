package com.inconso.bend.slsearch.logic;

import java.util.List;
import java.util.Map;
import com.inconso.bend.bpsched.pers.model.BpsProcessRecord;
import com.inconso.bend.dectree.logic.DecTreeManager;
import com.inconso.bend.slsearch.logic.api.SLSearchInput;
import com.inconso.bend.slsearch.logic.api.SLSearchLuInput;
import com.inconso.bend.slsearch.logic.api.SLSearchOutput;
import com.inconso.bend.slsearch.logic.model.SLSearchGenericSearchCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;

@Component
public class SLSearchManagerImpl implements SLSearchManager {

  private static final String ID_SITE_NULL = "idSite must not be null";
  private static final String ID_NODE_NULL = "idNode must not be null";

  private Logger              log          = LoggerFactory.getLogger(SLSearchManager.class);

  @Autowired
  private SLSearchJob         sLSearchJob;

  @Autowired
  private DecTreeManager      decTreeManager;

  @Override
  public SLSearchOutput searchLocationWithRecords(String idSite, String idNode, List<BpsProcessRecord> processRecordList) {

    Assert.notEmpty(processRecordList, "processRecordList must not be null or empty");
    Assert.notNull(idSite, ID_SITE_NULL);
    Assert.notNull(idNode, ID_NODE_NULL);

    SLSearchInput input = sLSearchJob.createInputForRecords(processRecordList);

    return searchLocation(idSite, idNode, input);
  }

  @Override
  public SLSearchOutput searchLocationWithRecords(String idSite, String idNode, List<BpsProcessRecord> processRecordList,
      Map<String, SLSearchGenericSearchCriteria> genericSearchCriteria) {

    Assert.notEmpty(processRecordList, "processRecordList must not be null or empty");
    Assert.notNull(idSite, ID_SITE_NULL);
    Assert.notNull(idNode, ID_NODE_NULL);

    SLSearchInput input = sLSearchJob.createInputForRecords(processRecordList);

    input.setGenericSearchCriteria(genericSearchCriteria);

    return searchLocation(idSite, idNode, input);
  }

  @Override
  public SLSearchOutput searchLocationWithLu(String idSite, String idNode, SLSearchLuInput input) {
    Assert.notNull(input, "input must not be null");
    Assert.notNull(idSite, ID_SITE_NULL);
    Assert.notNull(idNode, ID_NODE_NULL);
    Assert.notNull(input.getIdSite(), "input.getIdSite() must not be null");
    Assert.notNull(input.getIdLu(), "input.getIdLu() must not be null");
    return searchLocation(idSite, idNode, sLSearchJob.convertInput(input));
  }

  @Override
  public SLSearchOutput searchLocation(String idSite, String idNode, SLSearchInput input) {
    Assert.notNull(input, "input must not be null");
    Assert.notNull(idSite, ID_SITE_NULL);
    Assert.notNull(idNode, ID_NODE_NULL);
    Assert.notNull(input.getIdSite(), "input.getIdSite() must not be null");
    log.debug("run DTE root node {}/{}", idSite, idNode);
    return (SLSearchOutput) decTreeManager.start(idSite, idNode, sLSearchJob.transformBeforeSearch(input));
  }
}