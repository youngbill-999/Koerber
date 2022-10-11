package com.inconso.bend.inwmsx.it.transport;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.util.List;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.core.code.CodeCache;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.transport.config.BwmsTransportRoutingVersionStatCodes;
import com.inconso.bend.transport.pers.gen.TcsOrderPk;
import com.inconso.bend.transport.pers.gen.TcsRoutingVersionPk;
import com.inconso.bend.transport.pers.model.TcsOrder;
import com.inconso.bend.transport.pers.model.TcsRoutingVersion;
import com.inconso.bend.transport.pers.rep.TcsOrderRep;
import com.inconso.bend.transport.pers.rep.TcsRoutingVersionRep;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

public class TransportStepDefinition {

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private TcsRoutingVersionRep tcsRoutingVersionRep;

  @Autowired
  private TcsOrderRep          orderRep;

  @Autowired
  private CodeCache            codeCache;

  @Autowired
  private TransportDataHandler transportDataHandler;

  @Given("the currently active routing for system {string} is stored as {string}")
  @Transactional(readOnly = true)
  public void theCurrentlyActiveRoutingForSystemIsStoredAs(String system, String key) {
    final String active = codeCache.getValue(BwmsTransportRoutingVersionStatCodes.ACTIVE);
    List<TcsRoutingVersion> activeRoutings = tcsRoutingVersionRep.findBySystemAndStat(generalHelper.getIdSite(), system, active);
    TcsRoutingVersion activeRouting = activeRoutings.get(0);
    transportDataHandler.putTcsRoutingVersion(key, activeRouting);
  }

  @Given("routing version {string} has unfinished orders")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void oldRoutingVersionHasUnfinishedOrders(String keyRoutingVersion) {
    TcsRoutingVersion oldVersion = transportDataHandler.getTcsRoutingVersion(keyRoutingVersion);
    TcsOrder createdOrder = new TcsOrder(
        new TcsOrderPk(generalHelper.getIdSite(), oldVersion.getTcsRoutingVersionPk().getIdSystem(), RandomStringUtils.random(12)));
    createdOrder.setIdLu("L-1");
    createdOrder.setTypLu("EURO");
    createdOrder.setPriority(1L);
    createdOrder.setTcsRoutingVersion(oldVersion);
    createdOrder.setStat("00");
    createdOrder.setFlgPriorityMan("0");
    orderRep.persist(createdOrder);
  }

  @Then("routing version {string} in inactive and has a deactivation date")
  @Transactional(readOnly = true)
  public void routingVersionInactive(String keyRoutingVersion) {
    TcsRoutingVersionPk routingVersioPk = transportDataHandler.getTcsRoutingVersion(keyRoutingVersion).getTcsRoutingVersionPk();
    TcsRoutingVersion routingVersion = tcsRoutingVersionRep.findOne(routingVersioPk);
    assertAll(() -> assertEquals("80", routingVersion.getStat(), routingVersion.getTcsRoutingVersionPk().toString()) //
        , () -> assertNotNull(routingVersion.getTsDeactivation(), routingVersion.getTcsRoutingVersionPk().toString()));
  }

  @Then("routing version {string} is expiring and has a deactivation date")
  @Transactional(readOnly = true)
  public void oldRoutingVersionExpiring(String keyRoutingVersion) {
    TcsRoutingVersionPk routingVersioPk = transportDataHandler.getTcsRoutingVersion(keyRoutingVersion).getTcsRoutingVersionPk();
    TcsRoutingVersion routingVersion = tcsRoutingVersionRep.findOne(routingVersioPk);
    assertAll(() -> assertEquals("70", routingVersion.getStat(), routingVersion.getTcsRoutingVersionPk().toString()) //
        , () -> assertNotNull(routingVersion.getTsDeactivation(), routingVersion.getTcsRoutingVersionPk().toString()));
  }

  @Then("routing version {string} is active and has an activation date")
  @Transactional(readOnly = true)
  public void oldRoutingVersionIsInactiveAndHasDeactivationDate(String keyRoutingVersion) {
    TcsRoutingVersionPk routingVersioPk = transportDataHandler.getTcsRoutingVersion(keyRoutingVersion).getTcsRoutingVersionPk();
    TcsRoutingVersion routingVersion = tcsRoutingVersionRep.findOne(routingVersioPk);
    assertAll(() -> assertEquals("10", routingVersion.getStat(), routingVersion.getTcsRoutingVersionPk().toString()) //
        , () -> assertNotNull(routingVersion.getTsActivation(), routingVersion.getTcsRoutingVersionPk().toString()));
  }

}
