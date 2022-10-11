package com.inconso.bend.inwmsx.it.transport;

import java.util.LinkedList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inwmsx.it.general.FieldExtractor;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.transport.pers.gen.TcsRoutingVersionPk;
import com.inconso.bend.transport.pers.model.TcsRoutingVersion;
import com.inconso.bend.transport.pers.model.TcsTask;
import com.inconso.bend.transport.pers.rep.TcsRoutingVersionRep;
import com.inconso.bend.transport.service.api.BwmsRoutingVersionInput;
import com.inconso.bend.transport.service.api.BwmsSystemAndNameInput;
import com.inconso.bend.transport.service.api.BwmsTransportDesc;
import com.inconso.bend.transport.service.api.TcsTaskInput;
import com.inconso.bend.transport.service.api.TcsTaskListInput;
import com.inconso.bend.transport.service.api.TcsTransportCreInput;
import io.cucumber.java.en.When;

public class TransportWebserviceCaller {

  private String               currentSystem;

  @Autowired
  private WebserviceClient     webserviceClient;

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private TransportDataHandler transportDataHandler;

  @Autowired
  private TcsRoutingVersionRep tcsRoutingVersionRep;

  /**
   * Call webservice to create a new routing
   */
  @When("NEW_ROUTING_EP is called for system {string} with text {string}")
  @Transactional(readOnly = true)
  public void createNewRouting(String system, String text) {
    currentSystem = system;
    ServiceInput<BwmsSystemAndNameInput> input = new ServiceInput<>();
    input.setContext("SITE", generalHelper.getIdSite());
    BwmsSystemAndNameInput dataInput = new BwmsSystemAndNameInput();
    dataInput.setIdSite(generalHelper.getIdSite());
    dataInput.setIdSystem(system);
    dataInput.setTxtDescr(text);
    input.setData(dataInput);
    webserviceClient.call(BwmsTransportDesc.SERVICE, BwmsTransportDesc.NEW_ROUTING_EP, input);
  }

  @When("the new routing version is stored as {string}")
  @Transactional(readOnly = true)
  public void routingCreationSuccessful(String keyRoutingVersion) {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    String idRoutingVersion = payload.getString("result");
    System.out.println(idRoutingVersion);
    TcsRoutingVersion routingVersion = tcsRoutingVersionRep
        .findOne(new TcsRoutingVersionPk(generalHelper.getIdSite(), currentSystem, Long.valueOf(idRoutingVersion)));
    transportDataHandler.putTcsRoutingVersion(keyRoutingVersion, routingVersion);
  }

  /**
   * Call webservice to activate given routing version
   * 
   * @param numVersion
   *          id of routing version
   * @param idSystem
   *          system of routing version
   */
  @When("routing version {string} is activated")
  @Transactional(readOnly = true)
  public void routingVersionIsActivated(String keyRoutingVersion) {
    TcsRoutingVersion routingVersion = transportDataHandler.getTcsRoutingVersion(keyRoutingVersion);
    // build up the input - in the general part for the moment just the user
    ServiceInput<BwmsRoutingVersionInput> input = new ServiceInput<>();
    input.setContext("SITE", generalHelper.getIdSite());
    BwmsRoutingVersionInput dataInput = new BwmsRoutingVersionInput();
    dataInput.setIdSite(generalHelper.getIdSite());
    dataInput.setIdSystem(routingVersion.getTcsRoutingVersionPk().getIdSystem());
    dataInput.setNumVersion(routingVersion.getTcsRoutingVersionPk().getNumVersion());
    input.setData(dataInput);
    webserviceClient.call(BwmsTransportDesc.SERVICE, BwmsTransportDesc.ACTIVATE_ROUTING_EP, input);
  }

  /**
   * Call webservice to relocate the selected load unit
   * 
   * @param storageAreaTgt
   * 
   * @param StorageLocationTgt
   * 
   * @param idLu
   * 
   */
  public void relocateSelectedLu(String storageAreaTgt, String StorageLocationTgt, String idLu) {

    ServiceInput<TcsTransportCreInput> input = new ServiceInput<>();
    input.setContext("SITE", generalHelper.getIdSite());
    TcsTransportCreInput servideData = new TcsTransportCreInput();

    servideData.setIdSite(generalHelper.getIdSite());
    servideData.setIdLuSrc(idLu);
    servideData.setAreaTgt(storageAreaTgt);
    servideData.setLocationTgt(StorageLocationTgt);
    servideData.setPriority(10L);
    //
    servideData.setClProcess("DIALOG");
    servideData.setTypProcess("IM110");
    servideData.setStepProcess("TRANSP");
    input.setData(servideData);

    webserviceClient.call(BwmsTransportDesc.SERVICE, BwmsTransportDesc.PLANNING_EP, input);
  }

  @When("COMPLETE_TASK_EP is called with transport task {string}")
  public void completeTcsTask(String keyTcsTask) {
    TcsTask tcsTask = transportDataHandler.getTcsTask(keyTcsTask);
    TcsTaskInput tcsTaskInput = new TcsTaskInput();
    tcsTaskInput.setIdSite(tcsTask.getTcsTaskPk().getIdSite());
    tcsTaskInput.setIdTask(tcsTask.getTcsTaskPk().getIdTask());

    ServiceInput<TcsTaskListInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", tcsTask.getTcsTaskPk().getIdSite());

    List<TcsTaskInput> tcsTaskList = new LinkedList<TcsTaskInput>();
    tcsTaskList.add(tcsTaskInput);

    TcsTaskListInput tcsTaskListInput = new TcsTaskListInput();
    tcsTaskListInput.setTaskList(tcsTaskList);

    serviceInput.setData(tcsTaskListInput);
    webserviceClient.call(BwmsTransportDesc.SERVICE, BwmsTransportDesc.COMPLETE_TASK_EP, serviceInput);
    webserviceClient.verifySuccess();
  }

}
