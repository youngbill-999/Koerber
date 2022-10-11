package com.inconso.bend.inwmsx.it.grbase;

import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import com.inconso.bend.advice.service.api.GR300CreateReceivingAdviceInput;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.grbase.service.api.BwmsGRBaseDesc;
import com.inconso.bend.grbase.service.api.collection.ReceivingBookingReceivingItemInput;
import com.inconso.bend.grbase.service.api.collection.ReceivingSearchArticlevariantInput;
import com.inconso.bend.grbase.service.api.collection.mixlu.RecMixLuLUInput;
import com.inconso.bend.grbase.service.api.collection.mixlu.RecMixLuPushMixedLu;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import com.inconso.bend.wmsbase.logic.WmsBaseHelper;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class GrBaseWebserviceCaller {

  @Autowired
  private WebserviceClient      webserviceClient;

  @Autowired
  private GeneralHelper         generalHelper;

  @Autowired
  private GrBaseDataHandler     grBaseDataHandler;

  @Autowired
  private GrDeliveryDataHandler grDeliveryDataHandler;

  @Autowired
  private InventoryDataHandler  inventoryDataHandler;

  @Given("RECEIVING_SEARCH_ARTICLE_VARIANT is called with: idArticle = {string}")
  public void SearchArticlevariant(String idArticle) {
    ReceivingSearchArticlevariantInput input = new ReceivingSearchArticlevariantInput();
    input.setIdClient(generalHelper.getIdClient());
    input.setIdArticle(idArticle);

    ServiceInput<ReceivingSearchArticlevariantInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    inputService.setData(input);

    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.RECEIVING_SEARCH_ARTICLE_VARIANT, inputService);
  }

  @When("RECEIVING_CREATE_RECEIVING is called with: " + "idWorkcenter = {String}, idTerminal = {String}, idGoodsReceipt = {String}, "
      + "idArticle = {String}, numGoodsReceiptItem = {Long}, typLu = {String}, artvar = {String}, "
      + "countEntities = {Double}, countGrippingUnit = {Double}, qtyPerEntity = {Double}, qtyRemaining = {Double}, "
      + "qtyForBooking = {Double}, idBatch = {String}, tsBbd = {Date}, typSpecialStock = {String}, "
      + "idSpecialStock = {String}, storageArea = {String}, storageLocation = {String}, storeInZoneGroup = {String}, "
      + "idLu = {StringExt}, height = {Double}, repeatBooking = {Integer}, controllerClass = {String}")
  public void createReceiving(String idWorkcenter, String idTerminal, String idGoodsReceipt, String idArticle, Long numGoodsReceiptItem, String typLu,
      String artvar, Double countEntities, Double countGrippingUnit, Double qtyPerEntity, Double qtyRemaining, Double qtyForBooking, String idBatch,
      Date tsBbd, String typSpecialStock, String idSpecialStock, String storageArea, String storageLocation, String storeInZoneGroup,
      GherkinType<String> idLu, Double height, Integer repeatBooking, String controllerClass) {
    idLu.setGetterForKey(inventoryDataHandler.idLuGetter);
    ServiceInput<ReceivingBookingReceivingItemInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    ReceivingBookingReceivingItemInput receivingBookingReceivingItemInput = new ReceivingBookingReceivingItemInput();
    receivingBookingReceivingItemInput.setIdClient(generalHelper.getIdClient());
    receivingBookingReceivingItemInput.setIdWorkCenter(idWorkcenter);
    receivingBookingReceivingItemInput.setIdTerminal(idTerminal);
    receivingBookingReceivingItemInput.setIdArticle(idArticle);
    receivingBookingReceivingItemInput.setIdGoodsReceipt(idGoodsReceipt);
    receivingBookingReceivingItemInput.setNumGoodsReceiptItem(numGoodsReceiptItem);
    receivingBookingReceivingItemInput.setTypLu(typLu);
    receivingBookingReceivingItemInput.setArtvar(artvar);
    receivingBookingReceivingItemInput.setCountEntities(countEntities);
    receivingBookingReceivingItemInput.setCountGrippingUnit(countGrippingUnit);
    receivingBookingReceivingItemInput.setQtyPerEntity(qtyPerEntity);
    receivingBookingReceivingItemInput.setQtyRemaining(qtyRemaining);
    receivingBookingReceivingItemInput.setQtyForBooking(qtyForBooking);
    receivingBookingReceivingItemInput.setIdBatch(idBatch);
    receivingBookingReceivingItemInput.setTsBbd(tsBbd);
    receivingBookingReceivingItemInput.setTypSpecialStock(typSpecialStock);
    receivingBookingReceivingItemInput.setIdSpecialStock(idSpecialStock);
    receivingBookingReceivingItemInput.setStorageArea(storageArea);
    receivingBookingReceivingItemInput.setStorageLocation(storageLocation);
    receivingBookingReceivingItemInput.setStoreInZoneGroup(storeInZoneGroup);
    receivingBookingReceivingItemInput.setIdLu(idLu.get());
    receivingBookingReceivingItemInput.setHeight(height);
    receivingBookingReceivingItemInput.setRepeatBooking(repeatBooking);
    receivingBookingReceivingItemInput.setControllerClass(controllerClass);

    inputService.setData(receivingBookingReceivingItemInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.RECEIVING_CREATE_RECEIVING, inputService);
  }

  @When("RECEIVING_BOOK_RECEIVING_ITEM is called with: " + "idWorkcenter = {String}, idTerminal = {String}, idGoodsReceipt = {StringExt}, "
      + "idArticle = {String}, numGoodsReceiptItem = {Long}, typLu = {String}, artvar = {String}, "
      + "countEntities = {Double}, countGrippingUnit = {Double}, qtyPerEntity = {Double}, qtyRemaining = {Double}, "
      + "qtyForBooking = {Double}, idBatch = {String}, tsBbd = {Date}, typSpecialStock = {String}, "
      + "idSpecialStock = {String}, storageArea = {String}, storageLocation = {String}, storeInZoneGroup = {String}, "
      + "idLu = {String}, height = {Double}, repeatBooking = {Integer}, controllerClass = {String}")
  public void bookReceivingitem(String idWorkcenter, String idTerminal, GherkinType<String> idGoodsReceipt, String idArticle,
      Long numGoodsReceiptItem, String typLu, String artvar, Double countEntities, Double countGrippingUnit, Double qtyPerEntity, Double qtyRemaining,
      Double qtyForBooking, String idBatch, Date tsBbd, String typSpecialStock, String idSpecialStock, String storageArea, String storageLocation,
      String storeInZoneGroup, String idLu, Double height, Integer repeatBooking, String controllerClass) {
    idGoodsReceipt.setGetterForKey(grBaseDataHandler.idGoodsReceiptGetter);

    ServiceInput<ReceivingBookingReceivingItemInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    ReceivingBookingReceivingItemInput receivingBookingReceivingItemInput = new ReceivingBookingReceivingItemInput();
    receivingBookingReceivingItemInput.setIdClient(generalHelper.getIdClient());
    receivingBookingReceivingItemInput.setIdWorkCenter(idWorkcenter);
    receivingBookingReceivingItemInput.setIdTerminal(idTerminal);
    receivingBookingReceivingItemInput.setIdArticle(idArticle);
    receivingBookingReceivingItemInput.setIdGoodsReceipt(idGoodsReceipt.get());
    receivingBookingReceivingItemInput.setNumGoodsReceiptItem(numGoodsReceiptItem);
    receivingBookingReceivingItemInput.setTypLu(typLu);
    receivingBookingReceivingItemInput.setArtvar(artvar);
    receivingBookingReceivingItemInput.setCountEntities(countEntities);
    receivingBookingReceivingItemInput.setCountGrippingUnit(countGrippingUnit);
    receivingBookingReceivingItemInput.setQtyPerEntity(qtyPerEntity);
    receivingBookingReceivingItemInput.setQtyRemaining(qtyRemaining);
    receivingBookingReceivingItemInput.setQtyForBooking(qtyForBooking);
    receivingBookingReceivingItemInput.setIdBatch(idBatch);
    receivingBookingReceivingItemInput.setTsBbd(tsBbd);
    receivingBookingReceivingItemInput.setTypSpecialStock(typSpecialStock);
    receivingBookingReceivingItemInput.setIdSpecialStock(idSpecialStock);
    receivingBookingReceivingItemInput.setStorageArea(storageArea);
    receivingBookingReceivingItemInput.setStorageLocation(storageLocation);
    receivingBookingReceivingItemInput.setStoreInZoneGroup(storeInZoneGroup);
    receivingBookingReceivingItemInput.setIdLu(idLu);
    receivingBookingReceivingItemInput.setHeight(height);
    receivingBookingReceivingItemInput.setRepeatBooking(repeatBooking);
    receivingBookingReceivingItemInput.setControllerClass(controllerClass);

    inputService.setData(receivingBookingReceivingItemInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.RECEIVING_BOOK_RECEIVING_ITEM, inputService);
  }

  @When("GR300_CREATE_RECEIVING is called with: idInboundDelivery = {StringExt}, numDeliveryNote = {String}, idWorkCenter = {String}, idTerminal = {String}, idGoodsReceipt = {String}")
  public void createGr300Receiving(GherkinType<String> idInboundDelivery, String numDeliveryNote, String idWorkCenter, String idTerminal,
      String idGoodsReceipt) {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    ServiceInput<GR300CreateReceivingAdviceInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300CreateReceivingAdviceInput gr300CreateReceivingAdviceInput = new GR300CreateReceivingAdviceInput();
    gr300CreateReceivingAdviceInput.setIdClient(generalHelper.getIdClient());
    gr300CreateReceivingAdviceInput.setIdInboundDelivery(idInboundDelivery.get());
    gr300CreateReceivingAdviceInput.setNumDeliveryNote(numDeliveryNote);
    gr300CreateReceivingAdviceInput.setIdGoodsReceipt(idGoodsReceipt);
    gr300CreateReceivingAdviceInput.setIdTerminal(idTerminal);
    gr300CreateReceivingAdviceInput.setIdWorkCenter(idWorkCenter);
    gr300CreateReceivingAdviceInput.setIdAdvice(null); // relict, not used anymore
    gr300CreateReceivingAdviceInput.setNumAdviceItem(null); // relict, not used anymore

    serviceInput.setData(gr300CreateReceivingAdviceInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_CREATE_RECEIVING, serviceInput);
  }

  @When("RECMIXLU_PUSH_LU is called with: idLu = {StringExt}, idWorkCenter = {String}, idTerminal = {String}, storageArea = {String}, storageLocation = {String}, storeInZoneGroup = {String}, height = {Double}")
  public void recmixluPushLu(GherkinType<String> idLu, String idWorkCenter, String idTerminal, String storageArea, String storageLocation,
      String storeInZoneGroup, Double height) {
    idLu.setGetterForKey(inventoryDataHandler.idLuGetter);
    ServiceInput<RecMixLuPushMixedLu> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    RecMixLuPushMixedLu recMixLuPushMixedLu = new RecMixLuPushMixedLu();
    recMixLuPushMixedLu.setIdLu(idLu.get());
    recMixLuPushMixedLu.setIdWorkCenter(idWorkCenter);
    recMixLuPushMixedLu.setIdTerminal(idTerminal);
    recMixLuPushMixedLu.setStorageArea(storageArea);
    recMixLuPushMixedLu.setStorageLocation(storageLocation);
    recMixLuPushMixedLu.setStoreInZoneGroup(storeInZoneGroup);
    recMixLuPushMixedLu.setHeight(height);

    serviceInput.setData(recMixLuPushMixedLu);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.RECMIXLU_PUSH_LU, serviceInput);
  }

  @When("RECMIXLU_SEARCH_LU_TYPES is called with: input = {String}, typLu = {String}, idWorkcenter = {String}, idTerminal = {String}")
  public void recmixluSearchLuTypes(String input, String typLu, String idWorkcenter, String idTerminal) {
    ServiceInput<RecMixLuLUInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    RecMixLuLUInput recMixLuLUInput = new RecMixLuLUInput();
    recMixLuLUInput.setInput(input);
    recMixLuLUInput.setTypLu(typLu);
    recMixLuLUInput.setIdWorkcenter(idWorkcenter);
    recMixLuLUInput.setIdTerminal(idTerminal);

    serviceInput.setData(recMixLuLUInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.RECMIXLU_SEARCH_LU_TYPES, serviceInput);
  }

}
