package com.inconso.bend.inwmsx.it.topology;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.topology.pers.gen.TopStorageLocationPk;
import com.inconso.bend.topology.pers.model.TopStorageLocation;
import com.inconso.bend.topology.pers.rep.TopStorageLocationRep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.en.Given;

@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class TopologyHandler {

  @Autowired
  private GeneralHelper         generalHelper;

  @Autowired
  private TopStorageLocationRep storageLocationRep;

  /**
   * Prepares the given location for SLAA verification
   */
  @Given("prepare target location {string}-{string} for SLAA verification")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void prepareLocationForSlaa(String storageAreaTgt, String storageLocationTgt) {
    if (storageAreaTgt != null && storageLocationTgt != null) {
      TopStorageLocation storageLocation = storageLocationRep
          .findOne(new TopStorageLocationPk(generalHelper.getIdSite(), storageAreaTgt, storageLocationTgt));
      assertNotNull(storageLocation);

      storageLocation.setFlgFixedLocation("0");
      storageLocation.setFlgSingleArticle("1");
      storageLocationRep.persist(storageLocation);

    }
  }
}
