package com.inconso.bend.inwmsx.it.gibase;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import com.inconso.bend.article.pers.gen.ArtArticlePk;
import com.inconso.bend.article.pers.model.ArtArticle;
import com.inconso.bend.article.pers.rep.ArtArticleRep;
import com.inconso.bend.core.exception.BendException;
import com.inconso.bend.core.exception.BendExceptionArguments;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.gibase.pers.gen.GiOrderItemPk;
import com.inconso.bend.gibase.pers.gen.GiOrderPk;
import com.inconso.bend.gibase.pers.gen.GiOrderTypPk;
import com.inconso.bend.gibase.pers.model.GiOrder;
import com.inconso.bend.gibase.pers.model.GiOrderItem;
import com.inconso.bend.gibase.pers.model.GiOrderTyp;
import com.inconso.bend.gibase.pers.rep.GiOrderItemRep;
import com.inconso.bend.gibase.pers.rep.GiOrderRep;
import com.inconso.bend.gibase.pers.rep.GiOrderTypRep;
import com.inconso.bend.gibase.service.api.BwmsGIBaseDesc;
import com.inconso.bend.gibase.service.api.BwmsGIBaseOrderAdAddressInput;
import com.inconso.bend.gibase.service.api.BwmsGIBaseOrderInput;
import com.inconso.bend.gibase.service.api.BwmsGIBaseOrderListInput;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import com.inconso.bend.load.config.BwmsLoadingTextCodes;
import com.inconso.bend.load.config.LoadSequences;
import com.inconso.bend.load.pers.gen.LoadLoadingPk;
import com.inconso.bend.load.pers.gen.LoadShipmentTypPk;
import com.inconso.bend.load.pers.model.LoadLoading;
import com.inconso.bend.load.pers.model.LoadShipmentTyp;
import com.inconso.bend.load.pers.rep.LoadLoadingRep;
import com.inconso.bend.load.pers.rep.LoadShipmentTypRep;
import com.inconso.bend.load.service.api.BwmsLoadingDesc;
import com.inconso.bend.load.service.api.LoadStartLoadingInput;
import com.inconso.bend.pabase.pers.rep.PaPackageRep;
import com.inconso.bend.pabase.service.api.BwmsPaBaseDesc;
import com.inconso.bend.pabase.service.api.PaBaseCreatePackageInput;
import com.inconso.bend.pabase.service.api.PaBaseRepackInput;
import com.inconso.bend.packing.service.api.BwmsPackingDesc;
import com.inconso.bend.packing.service.api.PackingCompletePackingInput;
import com.inconso.bend.packing.service.api.PackingSearchMoveInput;
import com.inconso.bend.picking.pers.gen.PiPickingOrderPk;
import com.inconso.bend.picking.pers.gen.PiPickingTripPk;
import com.inconso.bend.picking.service.api.BwmsPickingDesc;
import com.inconso.bend.picking.service.api.PiPickingInput;
import com.inconso.bend.picking.service.api.PiPrintPickingTripInput;
import com.inconso.bend.picking.service.api.PiReleasePickingOrderInput;
import com.inconso.bend.ship.pers.model.ShipOrderAsgmt;
import com.inconso.bend.ship.pers.rep.ShipOrderAsgmtRep;
import com.inconso.bend.ship.service.api.BwmsShippingDesc;
import com.inconso.bend.ship.service.api.ShipFinishLoadingInput;
import com.inconso.bend.ship.service.api.ShipLoadingOrderInput;
import com.inconso.bend.ship.service.api.ShipOrderAsgmtLoadingStagingUsageInput;
import com.inconso.bend.ship.service.api.ShipOrderAsgmtLoadingStagingUsageListInput;
import com.inconso.bend.ship.service.api.ShipOrderInput;
import com.inconso.bend.ship.service.api.ShipOrderInputListWithTypShipment;
import com.inconso.bend.tourmgmt.pers.gen.TmTransportVehiclePk;
import com.inconso.bend.tourmgmt.pers.model.TmTransportVehicle;
import com.inconso.bend.tourmgmt.pers.rep.TmTransportVehicleRep;
import com.inconso.bend.workctrplan.service.api.WorkctrPlanToReferenceInput;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class GiBaseWebserviceCaller {

  @Autowired
  private GiBaseHelper          giBaseHelper;

  @Autowired
  private LoadShipmentTypRep    loadTypShipmentRep;

  @Autowired
  private WebserviceClient      webserviceClient;

  @Autowired
  private GeneralHelper         generalHelper;

  @Autowired
  private GiBaseDataHandler     giBaseDataHandler;

  @Autowired
  private InventoryDataHandler  inventoryDataHandler;

  @Autowired
  private GiOrderRep            orderRep;

  @Autowired
  private GiOrderItemRep        orderItemRep;

  @Autowired
  private GiOrderTypRep         orderTypRep;

  @Autowired
  private ArtArticleRep         articleRep;

  @Autowired
  private ShipOrderAsgmtRep     shipOrderAsgmtRep;

  @Autowired
  private TmTransportVehicleRep tmTransportVehicleRep;

  @Autowired
  private LoadLoadingRep        loadLoadingRep;

  @Autowired
  private PaPackageRep          paPackageRep;

  /**
   * Calls the Webservice 'OPP_SINGLE_ORDER' for the given order id for the first partial order
   * 
   * @throws InterruptedException
   *           when sleep is interrupted
   */
  @When("OPP_SINGLE_ORDER is/was called for {string}")
  public void orderpreprocessingIsCalledForOrder(String key) throws InterruptedException {
    // build up the input - in the general part for the moment just the user
    GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    ServiceInput<BwmsGIBaseOrderInput> input = new ServiceInput<>();
    input.setContext("SITE", generalHelper.getIdSite());
    BwmsGIBaseOrderInput dataInput = new BwmsGIBaseOrderInput();
    dataInput.setIdSite(giOrderPk.getIdSite());
    dataInput.setIdClient(giOrderPk.getIdClient());
    dataInput.setIdOrder(giOrderPk.getIdOrder());
    dataInput.setNumPartialOrder(giOrderPk.getNumPartialOrder());
    input.setData(dataInput);
    webserviceClient.call(BwmsGIBaseDesc.SERVICE, BwmsGIBaseDesc.OPP_SINGLE_ORDER, input);
    webserviceClient.verifySuccess();
  }

  @When("OPP_LIST_ORDER is/was called for:")
  public ServiceInput<BwmsGIBaseOrderListInput> doOOPListOfOrder(DataTable table) throws InterruptedException {
    // Abschluss Erfassung
    ServiceInput<BwmsGIBaseOrderListInput> serviceInput = giBaseHelper.doListOrder(table);
    webserviceClient.call(BwmsGIBaseDesc.SERVICE, BwmsGIBaseDesc.OPP_LIST_ORDER, serviceInput);
    return serviceInput;
  }

  @When("RELEASE_LIST_ORDER_ANYWAY_EP is/was called for:")
  public ServiceInput<BwmsGIBaseOrderListInput> releaseOrdersOfListAnyway(DataTable table) throws InterruptedException {
    // Freigabe Bearbeitung

    ServiceInput<BwmsGIBaseOrderListInput> serviceInput = giBaseHelper.doListOrder(table);
    webserviceClient.call(BwmsGIBaseDesc.SERVICE, BwmsGIBaseDesc.RELEASE_LIST_ORDER_ANYWAY_EP, serviceInput);
    return serviceInput;
  }

  @When("CANCEL_ORDERS_EP is/was called for:")
  public ServiceInput<BwmsGIBaseOrderListInput> cancelOrders(DataTable table) throws InterruptedException {
    // Stornieren
    ServiceInput<BwmsGIBaseOrderListInput> serviceInput = giBaseHelper.doListOrder(table);
    webserviceClient.call(BwmsGIBaseDesc.SERVICE, BwmsGIBaseDesc.CANCEL_ORDERS_EP, serviceInput);
    return serviceInput;
  }

  /**
   * Create an order for the given type. Retrieves the ID from the sequence and sets several default values.
   * 
   * @param orderTyp
   *          order type (must exists in DB)
   */
  @Given("order is created with: numPartialOrder = {long}, idCustomer = {StringExt}, typOrigin = {String}, orderTyp = {String}, priorityOrig = {Long}, priority = {Long}, saved as {string}")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void anOrderForClientWithIDIsCreated(Long numPartialOrder, GherkinType<String> idCustomer, String typOrigin, String orderTyp,
      Long priorityOrig, Long priority, String key) {
    GiOrderTyp giOrderTyp = orderTypRep.findOne(new GiOrderTypPk(generalHelper.getIdSite(), generalHelper.getIdClient(), orderTyp));
    String idOrder = generalHelper.getNextSequenceNumber("GI_SEQ_ID_ORDER");
    GiOrder newOrder = new GiOrder(new GiOrderPk(generalHelper.getIdSite(), generalHelper.getIdClient(), idOrder, numPartialOrder));
    newOrder.setStat("00"); // Statuskonstante?
    newOrder.setGiOrderTyp(giOrderTyp);
    newOrder.setClOrder("DEF");
    newOrder.setFlgHoldRequest("0");
    newOrder.setCntItems(0L);
    newOrder.setFlgPickUp("0");
    newOrder.setFlgRushOrder("0");
    newOrder.setPriorityOrig(priorityOrig);
    newOrder.setPriority(priority);
    newOrder.setTypOrigin(typOrigin);
    newOrder.setUnitVol("CBCM");
    newOrder.setUnitWt("GR");
    newOrder.setTypLoadComplete("NONE");
    newOrder.setIdCustomer((idCustomer != null) ? (idCustomer.get()) : "");

    orderRep.persist(newOrder);
    giBaseDataHandler.putGiOrder(key, newOrder);
  }

  /**
   * Creates an order item for the priorly created order with given item num ans a request for a given amount of pieces from the specified article.
   * Several default values are set.
   * 
   * @param numConsec
   *          item num
   * @param qty
   *          requested amount of pieces
   * @param idArticle
   *          id of requested article
   */
  @Given("order item is added to order {string} with: numConsec = {int}, idArticle = {string}, qty = {double}")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void orderHasAnOrderItemForPiecesOfArticle(String key, int numConsec, String idArticle, double qty) {
    GiOrderPk recentlyCreatedOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    ArtArticle article = articleRep.findOne(new ArtArticlePk(recentlyCreatedOrderPk.getIdClient(), idArticle));
    GiOrderItem orderItem = new GiOrderItem(new GiOrderItemPk(generalHelper.getIdSite(), recentlyCreatedOrderPk.getIdClient(),
        recentlyCreatedOrderPk.getIdOrder(), recentlyCreatedOrderPk.getNumPartialOrder(), (long) numConsec));
    orderItem.setQtyTargetOrig(qty);
    orderItem.setQtyTarget(qty);
    orderItem.setQtyActual(0.0);
    orderItem.setQtyCanceled(0.0);
    orderItem.setQtyReserved(0.0);
    orderItem.setArtArticle(article);
    orderItem.setStat("00");
    orderItem.setTypMessage("DEF");
    orderItem.setTypItem("DEF");
    orderItem.setFlgSingleBatch("0");
    orderItem.setStatCustoms("00");
    orderItem.setStatQualityControl("00");
    orderItem.setUnitVol("CBCM");
    orderItem.setUnitWt("GR");
    orderItemRep.persist(orderItem);
  }

  /**
   * Verifies that the priorly created order item with given numConsec has given stock type
   * 
   * @param numConsec
   *          item number
   * @param typStock
   *          expected stock type
   */
  @Given("order {string} item {long} has stock type {string}")
  @Transactional(readOnly = true)
  public void orderItemOfOrderHasStockType(String key, long numConsec, String typStock) {
    GiOrderPk recentlyCreatedOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    GiOrderItem orderItem = orderItemRep.findOne(new GiOrderItemPk(generalHelper.getIdSite(), recentlyCreatedOrderPk.getIdClient(),
        recentlyCreatedOrderPk.getIdOrder(), recentlyCreatedOrderPk.getNumPartialOrder(), numConsec));
    orderItem.setTypStock(typStock);
  }

  /**
   * Verifies that the priorly created order item with given numConsec has given lock type
   * 
   * @param numConsec
   *          item number
   * @param typLock
   *          expected lock type
   */
  @Given("order {string} item {long} has lock type {string}")
  @Transactional(readOnly = true)
  public void orderItemOfOrderHasLockType(String key, long numConsec, String typLock) {
    GiOrderPk recentlyCreatedOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    GiOrderItem orderItem = orderItemRep.findOne(new GiOrderItemPk(generalHelper.getIdSite(), recentlyCreatedOrderPk.getIdClient(),
        recentlyCreatedOrderPk.getIdOrder(), recentlyCreatedOrderPk.getNumPartialOrder(), numConsec));
    orderItem.setTypLock(typLock);
  }

  /**
   * Verifies that the priorly created order has the given weight
   * 
   * @param weight
   *          expected weight
   */
  @Then("order {string} must have weight {double}")
  @Transactional(readOnly = true)
  public void orderHasWeight(String key, double weight) {
    GiOrderPk recentlyCreatedOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    GiOrder order = orderRep.findOne(recentlyCreatedOrderPk);
    assertEquals(weight, (double) order.getWtTarget());
  }

  /**
   * Verifies that the priorly created order has the given volume
   * 
   * @param volume
   *          expected volume
   */
  @Then("order {string} must have volume {double}")
  @Transactional(readOnly = true)
  public void orderHasVolume(String key, double volume) {
    GiOrderPk recentlyCreatedOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    GiOrder order = orderRep.findOne(recentlyCreatedOrderPk);
    assertEquals(volume, (double) order.getVolTarget());
  }

  /**
   * Verifies that the priorly created order is in the given status
   * 
   * @param status
   *          expected status
   */
  @Then("order {string} is in status {string}")
  @Transactional(readOnly = true)
  public void orderIsInStatus(String key, String status) {
    GiOrderPk recentlyCreatedOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    GiOrder order = orderRep.findOne(recentlyCreatedOrderPk);
    assertEquals(status, order.getStat());
  }

  @When("PERSIST_ADDRESS_FROM_CUSTOMER is/was called for {string} with: addressRef2 = {String}")
  public void saveOrder(String key, String addressRef2) {
    GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();

    ServiceInput<BwmsGIBaseOrderAdAddressInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    BwmsGIBaseOrderAdAddressInput bwmsGIBaseOrderAdAddressInput = new BwmsGIBaseOrderAdAddressInput();
    bwmsGIBaseOrderAdAddressInput.setIdSite(giOrderPk.getIdSite());
    bwmsGIBaseOrderAdAddressInput.setIdClient(giOrderPk.getIdClient());
    bwmsGIBaseOrderAdAddressInput.setIdOrder(giOrderPk.getIdOrder());
    bwmsGIBaseOrderAdAddressInput.setNumPartialOrder(giOrderPk.getNumPartialOrder());
    bwmsGIBaseOrderAdAddressInput.setAddressRef2(addressRef2);

    serviceInput.setData(bwmsGIBaseOrderAdAddressInput);
    webserviceClient.call(BwmsGIBaseDesc.SERVICE, BwmsGIBaseDesc.PERSIST_ADDRESS_FROM_CUSTOMER, serviceInput);
  }

  @When("ASSIGN_STAGING_AREA_TO_ORDER is/was called with: idStagingArea = {String}, idLoading = {String} for:")
  public void assignStagingAreaToOrder(String idStagingArea, String idLoading, DataTable table) {
    // Bereitstellungsflaeche zuordnen
    List<ShipOrderAsgmtLoadingStagingUsageInput> list = table.asList().stream().map(key -> {
      GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();

      ShipOrderAsgmtLoadingStagingUsageInput shipOrderAsgmtLoadingStagingUsageInput = new ShipOrderAsgmtLoadingStagingUsageInput();
      shipOrderAsgmtLoadingStagingUsageInput.setIdSite(giOrderPk.getIdSite());
      shipOrderAsgmtLoadingStagingUsageInput.setIdClient(giOrderPk.getIdClient());
      shipOrderAsgmtLoadingStagingUsageInput.setIdOrder(giOrderPk.getIdOrder());
      shipOrderAsgmtLoadingStagingUsageInput.setNumPartialOrder(giOrderPk.getNumPartialOrder());
      shipOrderAsgmtLoadingStagingUsageInput.setIdStagingArea(idStagingArea);
      shipOrderAsgmtLoadingStagingUsageInput.setAssignExistingStagingArea(null); // ?
      shipOrderAsgmtLoadingStagingUsageInput.setIdLoading(idLoading);
      shipOrderAsgmtLoadingStagingUsageInput.setNumItem(null); // ?

      return shipOrderAsgmtLoadingStagingUsageInput;
    }).collect(Collectors.toList());

    ServiceInput<ShipOrderAsgmtLoadingStagingUsageListInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    ShipOrderAsgmtLoadingStagingUsageListInput shipOrderAsgmtLoadingStagingUsageListInput = new ShipOrderAsgmtLoadingStagingUsageListInput();
    shipOrderAsgmtLoadingStagingUsageListInput.setOrderLoadingStagingUsageList(list);

    serviceInput.setData(shipOrderAsgmtLoadingStagingUsageListInput);
    webserviceClient.call(BwmsShippingDesc.SERVICE, BwmsShippingDesc.ASSIGN_STAGING_AREA_TO_ORDER, serviceInput);
  }

  @When("PLAN_LOADING_FOR_ORDER is/was called for {string} with: typShipment = {String}")
  public void planLoadingForOrder(String key, String typShipment) {
    GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();

    ServiceInput<ShipOrderInputListWithTypShipment> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    ShipOrderInputListWithTypShipment shipOrderTypShipmentInput = new ShipOrderInputListWithTypShipment(
        Arrays.asList(new ShipOrderInput(giOrderPk.getIdClient(), giOrderPk.getIdOrder(), giOrderPk.getNumPartialOrder())), typShipment);

    serviceInput.setData(shipOrderTypShipmentInput);
    webserviceClient.call(BwmsShippingDesc.SERVICE, BwmsShippingDesc.PLAN_LOADING_FOR_ORDER, serviceInput);
  }

  @When("CREATE_ASSIGNMENT GI_ORDER is/was called with: idWorkcenter = {String}, priority = {Long} for:")
  public void createAssignmentForGiOrder(String idWorkcenter, long priority, DataTable table) {
    List<WorkctrPlanToReferenceInput> references = table.asList().stream().map(key -> {
      GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();

      WorkctrPlanToReferenceInput workctrPlanToReferenceInput = new WorkctrPlanToReferenceInput();
      workctrPlanToReferenceInput.setTypRef("GI_ORDER");
      workctrPlanToReferenceInput.setIdRef1(giOrderPk.getIdSite());
      workctrPlanToReferenceInput.setIdRef2(giOrderPk.getIdClient());
      workctrPlanToReferenceInput.setIdRef3(giOrderPk.getIdOrder());
      workctrPlanToReferenceInput.setIdRef4(giOrderPk.getNumPartialOrder().toString());

      return workctrPlanToReferenceInput;
    }).collect(Collectors.toList());

    generalHelper.createAssignment(idWorkcenter, priority, references);
  }

  @Then("create transport vehicle: nameDriver = {String}, truckLicensePlate = {String}, tour = {Long}, typ = {String}")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void createNewTransportVehicle(String nameDriver, String truckLicensePlate, Long tour, String typ) {
    String vehicleId = generalHelper.getNextSequenceNumber("TM_SEQ_ID_TRANSPORT_VEHICLE");

    TmTransportVehicle vehicle = new TmTransportVehicle(new TmTransportVehiclePk(generalHelper.getIdSite(), vehicleId));
    vehicle.setNameDriver(nameDriver);
    vehicle.setNumTourExternal(tour);
    vehicle.setTruckLicensePlate(truckLicensePlate);
    vehicle.setTypTransportVehicle(typ);
    // vehicle.setTsArrival();
    vehicle.setStat("00");

    tmTransportVehicleRep.persist(vehicle);
    giBaseDataHandler.putTransportVehicle(vehicle);
  }

  @And("order {String} has one loading, saved as {String}")
  @Transactional(readOnly = true)
  public void saveLoading(String key, String keyLoading) {
    GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();
    String idLoading = getIdLoading(giOrderPk);

    LoadLoading load = loadLoadingRep.findById(new LoadLoadingPk(generalHelper.getIdSite(), idLoading)).get();
    giBaseDataHandler.putLoadLoading(keyLoading, load);
  }

  @And("START_LOADING is/was called for {String} with: idWorkcenter = {String}")
  @Transactional(readOnly = true)
  public void startLoading(String key, String idWorkcenter) {
    String idLoading = giBaseDataHandler.getLoadLoading(key).getLoadLoadingPk().getIdLoading();
    ServiceInput<LoadStartLoadingInput> serviceInput = new ServiceInput<>();
    LoadStartLoadingInput input = new LoadStartLoadingInput();
    input.setIdLoading(idLoading);
    input.setIdTransportVehicle(giBaseDataHandler.getTransportVehicle().getTmTransportVehiclePk().getIdTransportVehicle());
    input.setIdWorkcenter(idWorkcenter);
    input.setNameDriver(giBaseDataHandler.getTransportVehicle().getNameDriver());
    input.setTruckLicensePlate(giBaseDataHandler.getTransportVehicle().getTruckLicensePlate());
    serviceInput.setContext("SITE", generalHelper.getIdSite());
    serviceInput.setData(input);

    webserviceClient.call(BwmsLoadingDesc.SERVICE, BwmsLoadingDesc.START_LOADING, serviceInput);
  }

  @And("LOAD_ORDER is/was called for {String} with: idTerminal = {String}, idWorkcenter = {String}, numPartialOrder = {Long}")
  @Transactional(readOnly = true)
  public void loadOrder(String key, String idTerminal, String idWorkcenter, Long numPartialOrder) {
    GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();

    ServiceInput<ShipLoadingOrderInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());
    ShipLoadingOrderInput shipLoadingOrderInput = new ShipLoadingOrderInput();

    shipLoadingOrderInput.setIdClient(generalHelper.getIdClient());
    shipLoadingOrderInput.setIdOrder(giOrderPk.getIdOrder());
    shipLoadingOrderInput.setNumPartialOrder(numPartialOrder);
    shipLoadingOrderInput.setIdTerminal(idTerminal);
    shipLoadingOrderInput.setIdWorkcenter(idWorkcenter);
    shipLoadingOrderInput.setIdLoading(getIdLoading(giOrderPk));

    serviceInput.setData(shipLoadingOrderInput);
    webserviceClient.call(BwmsShippingDesc.SERVICE, BwmsShippingDesc.LOAD_ORDER, serviceInput);
  }

  @And("FINISH_LOADING is/was called for {String} with: idWorkcenter = {String}, idTerminal = {String}")
  public void finishLoading(String key, String idWorkcenter, String idTerminal) {
    LoadLoading loading = giBaseDataHandler.getLoadLoading(key);
    ServiceInput<ShipFinishLoadingInput> serviceInput = new ServiceInput<>();
    ShipFinishLoadingInput shipFinishLoadingInput = new ShipFinishLoadingInput();
    serviceInput.setContext("SITE", generalHelper.getIdSite());
    shipFinishLoadingInput.setIdLoading(loading.getLoadLoadingPk().getIdLoading());
    shipFinishLoadingInput.setIdWorkcenter(idWorkcenter);
    shipFinishLoadingInput.setIdTerminal(idTerminal);
    serviceInput.setData(shipFinishLoadingInput);
    webserviceClient.call(BwmsShippingDesc.SERVICE, BwmsShippingDesc.FINISH_LOADING, serviceInput);
  }

  @When("PICKING_TRIP_CREATION_EP is/was called with: idTerminal = {String} for:")
  public void pickingTripCreation(String idTerminal, DataTable table) throws InterruptedException {
    List<PiReleasePickingOrderInput> list = table.asList().stream().map(key -> {
      PiPickingOrderPk piPickingOrderPk = giBaseDataHandler.getPiPickingOrder(key).getPiPickingOrderPk();

      PiReleasePickingOrderInput piReleasePickingOrderInput = new PiReleasePickingOrderInput();
      piReleasePickingOrderInput.setIdSite(piPickingOrderPk.getIdSite());
      piReleasePickingOrderInput.setIdPickingOrder(piPickingOrderPk.getIdPickingOrder());

      return piReleasePickingOrderInput;
    }).collect(Collectors.toList());

    ServiceInput<PiPickingInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    PiPickingInput piPickingInput = new PiPickingInput();
    // ToDo Fields?
    piPickingInput.setIdTerminal(idTerminal);
    piPickingInput.setOrderList(list);

    serviceInput.setData(piPickingInput);
    webserviceClient.call(BwmsPickingDesc.SERVICE, BwmsPickingDesc.PICKING_TRIP_CREATION_EP, serviceInput);
  }

  @When("START_PICKING_TRIPS_BY_DOC_EP is/was called with: idTerminal = {String} for:")
  public void startPickingTripsByDocument(String idTerminal, DataTable table) throws InterruptedException {
    // Belegkommissionierung
    List<PiPrintPickingTripInput> list = table.asList().stream().map(key -> {
      PiPickingTripPk piPickingTripPk = giBaseDataHandler.getPiPickingTrip(key).getPiPickingTripPk();

      PiPrintPickingTripInput piPrintPickingTripInput = new PiPrintPickingTripInput();
      piPrintPickingTripInput.setIdSite(piPickingTripPk.getIdSite());
      piPrintPickingTripInput.setIdPickingTrip(piPickingTripPk.getIdPickingTrip());

      return piPrintPickingTripInput;
    }).collect(Collectors.toList());

    ServiceInput<PiPickingInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    PiPickingInput piPickingInput = new PiPickingInput();
    // ToDo Fields?
    piPickingInput.setIdTerminal(idTerminal);
    piPickingInput.setTripList(list);

    serviceInput.setData(piPickingInput);
    webserviceClient.call(BwmsPickingDesc.SERVICE, BwmsPickingDesc.START_PICKING_TRIPS_BY_DOC_EP, serviceInput);
  }

  @And("loading {String} has: stat = {StringExt}, idGate = {StringExt}")
  @Transactional(readOnly = true)
  public void verifyLoadingStatus(String key, GherkinType<String> stat, GherkinType<String> idGate) {
    LoadLoading loading = giBaseDataHandler.getLoadLoading(key);
    assertAll(() -> stat.assertEquality(loading.getStat(), "stat"), () -> idGate.assertEquality(loading.getIdGate(), "idGate"));
  }

  @Then("reload loading {string}")
  @Transactional(readOnly = true)
  public void reloadLoading(String key) {
    LoadLoading loading = giBaseDataHandler.getLoadLoading(key);
    loading = loadLoadingRep.findById(new LoadLoadingPk(generalHelper.getIdSite(), loading.getLoadLoadingPk().getIdLoading())).get();
    giBaseDataHandler.putLoadLoading(key, loading);
  }

  private String getIdLoading(GiOrderPk giOrderPk) {
    List<ShipOrderAsgmt> shipOrders = shipOrderAsgmtRep.findByIdOrderAndStatLt(giOrderPk.getIdSite(), giOrderPk.getIdClient(), giOrderPk.getIdOrder(),
        "70");
    Comparator<ShipOrderAsgmt> descByTsCreated = new Comparator<ShipOrderAsgmt>() {

      @Override
      public int compare(ShipOrderAsgmt c1, ShipOrderAsgmt c2) {
        return Long.valueOf(c1.getTsCre().getTime()).compareTo(c2.getTsCre().getTime());
      }
    };
    shipOrders.sort(descByTsCreated);
    String idLoading = shipOrders.get(0).getIdLoading();

    return idLoading;
  }

  @And("create loading {String} with: gate = {String}, typShipment = {String}")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void createLoading(String keyLoading, String gate, String typShipment) {

    String idLoading = generalHelper.getNextSequenceNumber(LoadSequences.LOAD_SEQ_ID_LOADING.name());
    LoadLoading newLoading = new LoadLoading(new LoadLoadingPk(generalHelper.getIdSite(), idLoading));

    LoadShipmentTypPk loadShipmentTypPk = new LoadShipmentTypPk(generalHelper.getIdSite(), typShipment);
    LoadShipmentTyp loadShipmentTyp = loadTypShipmentRep.findOneOrThrowException(loadShipmentTypPk,
        () -> new BendExceptionArguments(BwmsLoadingTextCodes.LOAD_0001, loadShipmentTypPk.getIdSite(), loadShipmentTypPk.getTypShipment()));
    if (!"1".equals(loadShipmentTyp.getFlgActive())) {
      throw new BendException(BwmsLoadingTextCodes.LOAD_0001, loadShipmentTypPk.getIdSite(), loadShipmentTypPk.getTypShipment());
    }
    newLoading.setCntLuMax(loadShipmentTyp.getCntLuMax());
    newLoading.setIdGate(gate);
    newLoading.setLoadShipmentTyp(new LoadShipmentTyp(new LoadShipmentTypPk(generalHelper.getIdSite(), typShipment)));
    newLoading.setVolMax(loadShipmentTyp.getVolMax());
    newLoading.setWtMax(loadShipmentTyp.getWtMax());
    newLoading.setStat("30"); // Statuskonstante?

    loadLoadingRep.persist(newLoading);

    giBaseDataHandler.putLoadLoading(keyLoading, newLoading);

  }

  @Then("ASSIGN_ORDER_TO_LOADING {String} is called with: idStagingArea = {String} for:")
  public void assignOrderToLoading(String keyLoading, String idStagingArea, DataTable orders) {

    List<ShipOrderAsgmtLoadingStagingUsageInput> list = orders.asList().stream().map(key -> {
      GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();

      ShipOrderAsgmtLoadingStagingUsageInput shipOrderAsgmtInput = new ShipOrderAsgmtLoadingStagingUsageInput();
      shipOrderAsgmtInput.setIdSite(giOrderPk.getIdSite());
      shipOrderAsgmtInput.setIdClient(giOrderPk.getIdClient());
      shipOrderAsgmtInput.setIdOrder(giOrderPk.getIdOrder());
      shipOrderAsgmtInput.setNumPartialOrder(giOrderPk.getNumPartialOrder());
      shipOrderAsgmtInput.setAssignExistingStagingArea(idStagingArea == null);

      shipOrderAsgmtInput.setIdLoading(giBaseDataHandler.getLoadLoading(keyLoading).getLoadLoadingPk().getIdLoading());

      return shipOrderAsgmtInput;
    }).collect(Collectors.toList());

    ServiceInput<ShipOrderAsgmtLoadingStagingUsageListInput> serviceInput = new ServiceInput<ShipOrderAsgmtLoadingStagingUsageListInput>();
    ShipOrderAsgmtLoadingStagingUsageListInput shipOrderAsgmtListInput = new ShipOrderAsgmtLoadingStagingUsageListInput();

    shipOrderAsgmtListInput.setOrderLoadingStagingUsageList(list);

    serviceInput.setData(shipOrderAsgmtListInput);
    serviceInput.setContext("SITE", generalHelper.getIdSite());
    webserviceClient.call(BwmsShippingDesc.SERVICE, BwmsShippingDesc.ASSIGN_ORDER_TO_LOADING, serviceInput);
    webserviceClient.verifySuccess();
  }

  @Then("SETUP_PICKING_LU_EP is called with: idPickingOrder = {String}, idTerminal = {String}, idWorkcenter = {String}, typLu = {String}")
  public void setupPickingLU(String keyOrder, String idTerminal, String idWorkcenter, String typLu) {
    ServiceInput<PiPickingInput> serviceInput = new ServiceInput<PiPickingInput>();
    PiPickingInput pickingInput = new PiPickingInput();
    pickingInput.setIdPickingOrder(giBaseDataHandler.getPiPickingOrder(keyOrder).getPiPickingOrderPk().getIdPickingOrder());
    pickingInput.setIdSite(generalHelper.getIdSite());
    pickingInput.setIdTerminal(idTerminal);
    pickingInput.setIdWorkcenter(idWorkcenter);
    pickingInput.setTypLu(typLu);
    pickingInput.setPickByDocument(true);

    serviceInput.setData(pickingInput);
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    webserviceClient.call(BwmsPickingDesc.SERVICE, BwmsPickingDesc.SETUP_PICKING_LU_EP, serviceInput);
    webserviceClient.verifySuccess();
  }

  @And("BOOK_PICKING_LU_EP is called with: idPickingTrip = {String}, idTerminal = {String}, idWorkcenter = {String}")
  public void bookPickingLu(String keyPickingTrip, String idTerminal, String idWorkcenter) {

    ServiceInput<PiPickingInput> serviceInput = new ServiceInput<PiPickingInput>();
    PiPickingInput pickingInput = new PiPickingInput();
    pickingInput.setIdPickingTrip(giBaseDataHandler.getPiPickingTrip(keyPickingTrip).getPiPickingTripPk().getIdPickingTrip());
    pickingInput.setIdSite(generalHelper.getIdSite());
    pickingInput.setIdTerminal(idTerminal);
    pickingInput.setIdWorkcenter(idWorkcenter);
    pickingInput.setPickByDocument(true);
    pickingInput.setStorageAreaTgt(null);
    pickingInput.setStorageLocationTgt(null);

    serviceInput.setData(pickingInput);
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    webserviceClient.call(BwmsPickingDesc.SERVICE, BwmsPickingDesc.BOOK_PICKING_LU_EP, serviceInput);
    webserviceClient.verifySuccess();

  }

  @And("COMPLETE_PICKING_EP is called with: idPickingTrip = {String}, idTerminal = {String}, idWorkcenter = {String}, storageAreaTgt = {String}, storageLocationTgt = {String}")
  public void completePicking(String keyPickingTrip, String idTerminal, String idWorkcenter, String storageAreaTgt, String storageLocationTgt) {

    ServiceInput<PiPickingInput> serviceInput = new ServiceInput<PiPickingInput>();
    PiPickingInput pickingInput = new PiPickingInput();
    pickingInput.setIdPickingTrip(giBaseDataHandler.getPiPickingTrip(keyPickingTrip).getPiPickingTripPk().getIdPickingTrip());
    pickingInput.setIdSite(generalHelper.getIdSite());
    pickingInput.setIdTerminal(idTerminal);
    pickingInput.setIdWorkcenter(idWorkcenter);
    pickingInput.setPickByDocument(true);
    pickingInput.setStorageAreaTgt(storageAreaTgt);
    pickingInput.setStorageLocationTgt(storageLocationTgt);

    serviceInput.setData(pickingInput);
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    webserviceClient.call(BwmsPickingDesc.SERVICE, BwmsPickingDesc.COMPLETE_PICKING_EP, serviceInput);
    webserviceClient.verifySuccess();
  }

  @Then("MOVE_TO_PACKING is called for {String} and {String} with: idWorkcenter = {String}")
  public void moveToPacking(String keyOrder, String keyPickingLu, String idWorkcenter) {
    ServiceInput<PackingSearchMoveInput> serviceInput = new ServiceInput<PackingSearchMoveInput>();
    PackingSearchMoveInput moveInput = new PackingSearchMoveInput();
    moveInput.setIdClient(generalHelper.getIdClient());
    moveInput.setIdWorkcenter(idWorkcenter);

    moveInput.setPickingLu(inventoryDataHandler.getLoadUnit(keyPickingLu).getImLoadUnitPk().getIdLu());
    moveInput.setIdOrder(giBaseDataHandler.getGiOrder(keyOrder).getGiOrderPk().getIdOrder());
    moveInput.setNumPartialOrder(giBaseDataHandler.getGiOrder(keyOrder).getGiOrderPk().getNumPartialOrder());

    serviceInput.setData(moveInput);
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    webserviceClient.call(BwmsPackingDesc.SERVICE, BwmsPackingDesc.MOVE_TO_PACKING, serviceInput);
    webserviceClient.verifySuccess();

  }

  @Then("CREATE_PKG is called for {String} with: idWorkcenterPack = {String}, typLu = {String}, typRef = {String} saved as {String} on {String}")
  @Transactional(readOnly = true)
  public void createPackage(String keyOrder, String idWorkcenterPack, String typLu, String typRef, String keyPackage, String keyLu) {
    ServiceInput<PaBaseCreatePackageInput> serviceInput = new ServiceInput<PaBaseCreatePackageInput>();
    PaBaseCreatePackageInput createPackageInput = new PaBaseCreatePackageInput();

    createPackageInput.setIdRef1(generalHelper.getIdSite());
    createPackageInput.setIdRef2(generalHelper.getIdClient());
    createPackageInput.setIdRef3(giBaseDataHandler.getGiOrder(keyOrder).getGiOrderPk().getIdOrder());
    createPackageInput.setIdRef4(giBaseDataHandler.getGiOrder(keyOrder).getGiOrderPk().getNumPartialOrder().toString());
    createPackageInput.setIdWorkcenterPack(idWorkcenterPack);
    createPackageInput.setTypLu(typLu);
    createPackageInput.setTypRef(typRef);

    serviceInput.setData(createPackageInput);
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    webserviceClient.call(BwmsPaBaseDesc.SERVICE, BwmsPaBaseDesc.CREATE_PKG, serviceInput);
    webserviceClient.verifySuccess();

    giBaseDataHandler.putPaPackage(keyPackage, paPackageRep.findByReferences(typRef, generalHelper.getIdSite(), generalHelper.getIdClient(),
        giBaseDataHandler.getGiOrder(keyOrder).getGiOrderPk().getIdOrder(), "0", null, null).get(0));

    inventoryDataHandler.putLoadUnit(keyLu, paPackageRep.findByReferences(typRef, generalHelper.getIdSite(), generalHelper.getIdClient(),
        giBaseDataHandler.getGiOrder(keyOrder).getGiOrderPk().getIdOrder(), "0", null, null).get(0).getImLoadUnit());
  }

  @And("REPACK is called for {String}, {String}, {String}, {String} with: idTerminalPack = {String}, idWorkcenterPack = {String}, qtyRepacked = {Double}, typRef = {String}")
  public void repackItem(String keyPackage, String keyOrderItem, String keyPickingLu, String keyQuantum, String idTerminalPack,
      String idWorkcenterPack, Double qtyRepacked, String typRef) {
    ServiceInput<PaBaseRepackInput> serviceInput = new ServiceInput<PaBaseRepackInput>();
    PaBaseRepackInput repackInput = new PaBaseRepackInput();
    repackInput.setIdClient(generalHelper.getIdClient());
    repackInput.setIdQuantum(inventoryDataHandler.getQuantum(keyQuantum).getImQuantumPk().getIdQuantum());
    repackInput.setIdRef1(generalHelper.getIdSite());
    repackInput.setIdRef2(generalHelper.getIdClient());
    repackInput.setIdRef3(giBaseDataHandler.getGiOrderItem(keyOrderItem).getGiOrderItemPk().getIdOrder());
    repackInput.setIdRef4("0"); // numPartialOrder
    repackInput.setPickingLu(inventoryDataHandler.getLoadUnit(keyPickingLu).getImLoadUnitPk().getIdLu());// pickingLu
    repackInput.setPackageLu(giBaseDataHandler.getPaPackage(keyPackage).getIdLu());
    repackInput.setTypRef(typRef);
    repackInput.setQtyRepacked(qtyRepacked);
    repackInput.setIdWorkcenterPack(idWorkcenterPack);
    repackInput.setIdTerminalPack(idTerminalPack);

    serviceInput.setData(repackInput);
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    webserviceClient.call(BwmsPaBaseDesc.SERVICE, BwmsPaBaseDesc.REPACK, serviceInput);
    webserviceClient.verifySuccess();
  }

  @And("COMPLETE_PACKING_OC is called for {String} with: idWorkcenter = {String}, height = {Double}, width = {Double}, wtActual = {Double}, len = {Double}, typLu = {String}, typLuNew = {String}")
  public void completePacking(String keyPickingLu, String idWorkcenter, Double height, Double width, Double wtActual, Double len, String typLu,
      String typLuNew) {
    ServiceInput<PackingCompletePackingInput> serviceInput = new ServiceInput<PackingCompletePackingInput>();
    PackingCompletePackingInput packingCompleteInput = new PackingCompletePackingInput();

    packingCompleteInput.setPackageLu(inventoryDataHandler.getLoadUnit(keyPickingLu).getImLoadUnitPk().getIdLu());
    packingCompleteInput.setHeight(height);
    packingCompleteInput.setIdWorkcenter(idWorkcenter);
    packingCompleteInput.setLen(len);
    packingCompleteInput.setTypLu(typLu);
    packingCompleteInput.setTypLuNew(typLuNew);
    packingCompleteInput.setUnitLen("CM");
    packingCompleteInput.setUnitWtActual("GR");
    packingCompleteInput.setWtActual(wtActual);
    packingCompleteInput.setCancelIfEmpty(true);

    serviceInput.setData(packingCompleteInput);
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    webserviceClient.call(BwmsPackingDesc.SERVICE, BwmsPackingDesc.COMPLETE_PACKING_OC, serviceInput);
    webserviceClient.verifySuccess();
  }

}
