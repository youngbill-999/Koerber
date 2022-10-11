package com.inconso.bend.inwmsx.it.stocktaking;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.bpsched.logic.util.BPSchedSelectHelper;
import com.inconso.bend.bpsched.pers.model.BpsProcessRecord;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.rep.ImQuantumRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import com.inconso.bend.stm.pers.model.StmStockTakingItem;
import com.inconso.bend.stm.pers.model.StmStockTakingList;
import com.inconso.bend.stm.pers.rep.StmStockTakingItemRep;
import com.inconso.bend.stm.pers.rep.StmStockTakingListRep;
import com.inconso.bend.stm.service.api.BwmsStocktakeDesc;
import com.inconso.bend.stm.service.api.StmStBookListInput;
import com.inconso.bend.stm.service.api.StmStDiscoveryInput;
import com.inconso.bend.stm.service.api.StmStockTakingCreationInput;
import com.inconso.bend.stm.service.api.StmStockTakingListInput;
import com.inconso.bend.stm.service.api.StmStockTakingListsInput;
import com.inconso.bend.stm.service.api.StmStockTakingQtyActualInput;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class StocktakingWebserviceCaller {

  @Autowired
  private GeneralHelper          generalHelper;

  @Autowired
  private WebserviceClient       webserviceClient;

  @Autowired
  private StmStockTakingListRep  stmStockTakingListRep;

  @Autowired
  private StocktakingDataHandler stockTakingDataHandler;

  @Autowired
  private StmStockTakingItemRep  stockTakingItemRep;

  @Autowired
  private BPSchedSelectHelper    bpsSelectHelper;

  @Autowired
  private ImQuantumRep           imQuantumRep;

  @Autowired
  private InventoryDataHandler   inventoryDataHandler;

  @When("STOCK_TAKING_CREATE is called with: cntItemsListMax = {Long}, cntItemsOverallMax = {Long}, datTarget = {Long}, idTerminal = {String}, idWorkcenter = {String}, stockTakingZoneList = {String}, storageArea = {String}, storageLocation = {String}, typEntry = {String}, typStockTakingList = {String}, saved as {String}")
  @Transactional(readOnly = true)
  public void createStockTaking(Long cntItemsListMax, Long cntItemsOverallMax, Long datTarget, String idTerminal, String idWorkcenter,
      String stockTakingZoneList, String storageArea, String storageLocation, String typEntry, String typStockTakingList, String keyStockTakingList) {
    ServiceInput<StmStockTakingCreationInput> inputService = new ServiceInput<>();
    StmStockTakingCreationInput input = new StmStockTakingCreationInput();
    inputService.setContext("SITE", generalHelper.getIdSite());

    input.setFlgAisleAlternateList("0"); // default?
    input.setCntItemsListMax(cntItemsListMax);
    input.setCntItemsOverallMax(cntItemsOverallMax);
    input.setDatTarget(new Date(datTarget));
    input.setIdTerminal(idTerminal);
    input.setIdWorkcenter(idWorkcenter);
    ArrayList<String> stockZoneList = new ArrayList<String>();
    stockZoneList.add(stockTakingZoneList);
    input.setStockTakingZoneList(stockZoneList);
    input.setStorageArea(storageArea);
    input.setStorageLocation(storageLocation);
    input.setTypEntry(typEntry);
    input.setTypStockTakingList(typStockTakingList);

    inputService.setData(input);
    webserviceClient.call(BwmsStocktakeDesc.SERVICE, BwmsStocktakeDesc.STOCK_TAKING_CREATE, inputService);
    webserviceClient.verifySuccess();

    generalHelper.waiting(10);
    List<StmStockTakingList> stockTakingLists = stmStockTakingListRep.findByZoneAndStat(generalHelper.getIdSite(), typEntry, stockTakingZoneList,
        "00", "10", "20");

    if (stockTakingLists.size() > 1) {
      for (int i = 0; i < stockTakingLists.size(); i++) {
        StmStockTakingList temp = stockTakingLists.get(i);
        stockTakingDataHandler.putStockTakeListId("StockTakingList[" + i + "]", temp.getStmStockTakingListPk().getIdStockTakingList());
      }
    } else if (stockTakingLists.size() == 1) {
      String idList = stockTakingLists.get(0).getStmStockTakingListPk().getIdStockTakingList();
      stockTakingDataHandler.putStockTakeListId(keyStockTakingList, idList);
    }

  }

  @Then("ENTER_QTY_ACTUAL is called for {String} with: idTerminal = {String}, idWorkcenter = {String}, cntCount = {Long} and:")
  @Transactional(readOnly = true)
  public void enterQtyActual(String keyStockTakingList, String idTerminal, String idWorkcenter, Long cntCount, DataTable table) {
    ServiceInput<StmStockTakingQtyActualInput> inputService = new ServiceInput<>();
    StmStockTakingQtyActualInput input = new StmStockTakingQtyActualInput();
    inputService.setContext("SITE", generalHelper.getIdSite());

    input.setCntCount(cntCount);
    input.setIdWorkcenter(idWorkcenter);
    input.setIdTerminal(idTerminal);

    String listId = stockTakingDataHandler.getStockTakeListId(keyStockTakingList);

    List<StmStockTakingItem> listItems = stockTakingItemRep.findByIdStockTakingList(generalHelper.getIdSite(), listId);

    assert (listItems.size() > 0);
    Long itemNumber = listItems.get(0).getStmStockTakingItemPk().getNumItem();

    Map<String, Double> qtyActualList = new HashMap<>();
    qtyActualList = table.asMap(String.class, Double.class);
    input.setQtyActual(qtyActualList.get("qtyActual"));

    List<BpsProcessRecord> listRecords = bpsSelectHelper.readRecordsByReference("STM_STOCK_TAKING_ITEM", generalHelper.getIdSite(), listId,
        String.valueOf(itemNumber), null, null, null);

    assert (listRecords.size() > 0);
    input.setIdRecord(listRecords.get(0).getBpsProcessRecordPk().getIdRecord());

    inputService.setData(input);
    webserviceClient.call(BwmsStocktakeDesc.SERVICE, BwmsStocktakeDesc.ENTER_QTY_ACTUAL, inputService);
    webserviceClient.verifySuccess();
  }

  @Then("STOCK_TAKING_RELEASE is called for {String}")
  @Transactional(readOnly = true)
  public void releaseStockTaking(String keyStockTakingList) {

    List<String> listOflistId = new ArrayList<String>();
    String listId = stockTakingDataHandler.getStockTakeListId(keyStockTakingList);

    listOflistId.add(listId);

    ServiceInput<StmStockTakingListsInput> inputService = new ServiceInput<>();
    StmStockTakingListsInput input = new StmStockTakingListsInput();
    inputService.setContext("SITE", generalHelper.getIdSite());

    input.setIdStockTakingListList(listOflistId);

    inputService.setData(input);
    webserviceClient.call(BwmsStocktakeDesc.SERVICE, BwmsStocktakeDesc.STOCK_TAKING_RELEASE, inputService);
    webserviceClient.verifySuccess();

  }

  @Then("FINISH_ENTER_QTY_ACTUAL is called for {String}")
  public void finishEnterQtyActual(String keyStockTakingList) {

    String listId = stockTakingDataHandler.getStockTakeListId(keyStockTakingList);

    ServiceInput<StmStockTakingListInput> inputService = new ServiceInput<StmStockTakingListInput>();
    StmStockTakingListInput input = new StmStockTakingListInput();
    inputService.setContext("SITE", generalHelper.getIdSite());

    input.setIdStockTakingList(listId);
    inputService.setData(input);
    webserviceClient.call(BwmsStocktakeDesc.SERVICE, BwmsStocktakeDesc.FINISH_ENTER_QTY_ACTUAL, inputService);
    webserviceClient.verifySuccess();

  }

  @And("CANCEL_STOCK_TAKING_LISTS")
  @Transactional(readOnly = true)
  public void cancelStockTakingLists() {
    List<StmStockTakingList> stockTakingItems = stmStockTakingListRep.findAll();
    ArrayList<String> idStockTakingList = new ArrayList<String>();
    for (int i = 0; i < stockTakingItems.size(); i++) {
      if (!stockTakingItems.get(i).getStat().equals("80") && !stockTakingItems.get(i).getStat().equals("90")) {
        idStockTakingList.add(stockTakingItems.get(i).getStmStockTakingListPk().getIdStockTakingList());
      }
    }
    assert (idStockTakingList.size() > 0);
    ServiceInput<StmStockTakingListsInput> inputService = new ServiceInput<StmStockTakingListsInput>();
    StmStockTakingListsInput input = new StmStockTakingListsInput();
    input.setIdStockTakingListList(idStockTakingList);

    inputService.setContext("SITE", generalHelper.getIdSite());
    inputService.setData(input);
    webserviceClient.call(BwmsStocktakeDesc.SERVICE, BwmsStocktakeDesc.CANCEL_STOCK_TAKING_LISTS, inputService);
    webserviceClient.verifySuccess();

  }

  @When("CREATE_AND_BOOK_DISCOVERY is called for {String} with: artvar = {String}, idArticle = {String}, idTerminal = {String}, idWorkcenter = {String}, qtyMoved = {Double}, storageArea = {String}, storageLocation = {String}, typLock = {String}, statCustoms = {String}, statQualityControl = {String}, typStock = {String}, save as {String}")
  @Transactional(readOnly = true)
  public void createDiscovery(String keyStockTakingList, String artvar, String idArticle, String idTerminal, String idWorkcenter, Double qtyMoved,
      String storageArea, String storageLocation, String typLock, String statCustoms, String statQualityControl, String typStock, String keyQuantum) {
    ServiceInput<StmStDiscoveryInput> inputService = new ServiceInput<StmStDiscoveryInput>();
    StmStDiscoveryInput input = new StmStDiscoveryInput();

    input.setArtvar(artvar);
    input.setIdArticle(idArticle);
    input.setIdClient(generalHelper.getIdClient());
    input.setIdStockTakingList(stockTakingDataHandler.getStockTakeListId(keyStockTakingList));
    input.setIdTerminal(idTerminal);
    input.setIdWorkcenter(idWorkcenter);
    input.setQtyMoved(qtyMoved);
    input.setTypStock(typStock);
    input.setStatCustoms(statCustoms);
    input.setStatQualityControl(statQualityControl);
    input.setStorageArea(storageArea);
    input.setStorageLocation(storageLocation);
    input.setTypLock(typLock);

    inputService.setContext("SITE", generalHelper.getIdSite());
    inputService.setData(input);
    webserviceClient.call(BwmsStocktakeDesc.SERVICE, BwmsStocktakeDesc.CREATE_AND_BOOK_DISCOVERY, inputService);
    webserviceClient.verifySuccess();

    List<ImQuantum> discoveryQu = imQuantumRep.findByIdSiteAndLocationAndAreaAndArticle(generalHelper.getIdSite(), storageLocation, storageArea,
        generalHelper.getIdClient(), idArticle);
    assert (discoveryQu.size() > 0);
    inventoryDataHandler.putQuantum(keyQuantum, discoveryQu.get(0));

  }

  @Then("BOOK_STOCK_TAKING_LIST is called for {String} with: idTerminal = {String}, idWorkcenter = {String}")
  public void bookStockTakingList(String keyStockTakingList, String idTerminal, String idWorkcenter) {

    ServiceInput<StmStBookListInput> inputService = new ServiceInput<StmStBookListInput>();
    StmStBookListInput input = new StmStBookListInput();

    input.setIdTerminal(idTerminal);
    input.setIdWorkcenter(idWorkcenter);
    input.setIdStockTakingList(stockTakingDataHandler.getStockTakeListId(keyStockTakingList));

    inputService.setContext("SITE", generalHelper.getIdSite());
    inputService.setData(input);
    webserviceClient.call(BwmsStocktakeDesc.SERVICE, BwmsStocktakeDesc.BOOK_STOCK_TAKING_LIST, inputService);
    webserviceClient.verifySuccess();

  }

  @Then("COMPLETE_STOCK_TAKING_LIST is called for {String} with: idTerminal = {String}, idWorkcenter = {String}")
  public void completeStockTakingList(String keyStockTakingList, String idTerminal, String idWorkcenter) {

    ServiceInput<StmStBookListInput> inputService = new ServiceInput<StmStBookListInput>();
    StmStBookListInput input = new StmStBookListInput();

    input.setIdTerminal(idTerminal);
    input.setIdWorkcenter(idWorkcenter);
    input.setIdStockTakingList(stockTakingDataHandler.getStockTakeListId(keyStockTakingList));

    inputService.setContext("SITE", generalHelper.getIdSite());
    inputService.setData(input);
    webserviceClient.call(BwmsStocktakeDesc.SERVICE, BwmsStocktakeDesc.COMPLETE_STOCK_TAKING_LIST, inputService);
    webserviceClient.verifySuccess();

  }

}
