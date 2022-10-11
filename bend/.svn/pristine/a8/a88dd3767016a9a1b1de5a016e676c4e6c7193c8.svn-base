package com.inconso.bend.inwmsx.it.grbase;

import java.text.ParseException;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import com.inconso.bend.advice.service.api.AdviceDesc;
import com.inconso.bend.advice.service.api.GR300UpdateDeliveryItemAdviceInput;
import com.inconso.bend.article.service.api.ArtSearchArticleInput;
import com.inconso.bend.article.service.api.BwmsArticleDesc;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.grbase.service.api.BwmsGRBaseDesc;
import com.inconso.bend.grbase.service.api.GR300SearchClientInput;
import com.inconso.bend.grbase.service.api.GR300SearchDeliveryItemInput;
import com.inconso.bend.grbase.service.api.GR300SearchDeliveryItemTextInput;
import com.inconso.bend.grbase.service.api.GR300SearchDeliveryTextInput;
import com.inconso.bend.grbase.service.api.GR300SearchInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryItemInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryItemTextInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryTextInput;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class GrDeliveryWebserviceCaller {

  @Autowired
  private WebserviceClient      webserviceClient;

  @Autowired
  private GeneralHelper         generalHelper;

  @Autowired
  private GrDeliveryDataHandler grDeliveryDataHandler;

  private void saveDelivery(GherkinType<String> idInboundDelivery, String numDeliveryNote, Date datDeliveryNote, String idSupplier, String name,
      String idTransportVehicle, String nameDriver, String truckLicensePlate) throws ParseException {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);

    ServiceInput<GR300UpdateDeliveryInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300UpdateDeliveryInput gr300UpdateDeliveryInput = new GR300UpdateDeliveryInput();
    gr300UpdateDeliveryInput.setIdClient(generalHelper.getIdClient());
    gr300UpdateDeliveryInput.setIdInboundDelivery(idInboundDelivery.get());
    gr300UpdateDeliveryInput.setNumDeliveryNote(numDeliveryNote);
    gr300UpdateDeliveryInput.setDatDeliveryNote(datDeliveryNote);
    gr300UpdateDeliveryInput.setIdSupplier(idSupplier);
    gr300UpdateDeliveryInput.setName(name);
    gr300UpdateDeliveryInput.setIdTransportVehicle(idTransportVehicle);
    gr300UpdateDeliveryInput.setNameDriver(nameDriver);
    gr300UpdateDeliveryInput.setTruckLicensePlate(truckLicensePlate);
    grDeliveryDataHandler.setGr300UpdateDeliveryInput(gr300UpdateDeliveryInput);

    serviceInput.setData(gr300UpdateDeliveryInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_UPDATE_DELIVERY, serviceInput);
  }

  private void saveDeliveryText(Boolean deleteFlag, GherkinType<String> idInboundDelivery, Long numConsec, String typTxt, String txtInboundDelivery) {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    ServiceInput<GR300UpdateDeliveryTextInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300UpdateDeliveryTextInput gr300UpdateDeliveryTextInput = new GR300UpdateDeliveryTextInput();
    gr300UpdateDeliveryTextInput.setIdClient(generalHelper.getIdClient());
    gr300UpdateDeliveryTextInput.setIdInboundDelivery(idInboundDelivery.get());
    gr300UpdateDeliveryTextInput.setNumConsec(numConsec);
    gr300UpdateDeliveryTextInput.setTypTxt(typTxt);
    gr300UpdateDeliveryTextInput.setTxtInboundDelivery(txtInboundDelivery);
    gr300UpdateDeliveryTextInput.setFlgDelete(deleteFlag ? "1" : "0");
    grDeliveryDataHandler.setGr300UpdateDeliveryTextInput(gr300UpdateDeliveryTextInput);

    serviceInput.setData(gr300UpdateDeliveryTextInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_UPDATE_DELIVERY_TEXT, serviceInput);
  }

  private void saveDeliveryItem(Boolean deleteFlag, GherkinType<String> idInboundDelivery, Long numItem, String idArticle, Double qtyDeliveryNote,
      String idBatch, Date tsBbd) {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    ServiceInput<GR300UpdateDeliveryItemInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300UpdateDeliveryItemInput gr300UpdateDeliveryItemInput = new GR300UpdateDeliveryItemInput();
    gr300UpdateDeliveryItemInput.setIdClient(generalHelper.getIdClient());
    gr300UpdateDeliveryItemInput.setIdInboundDelivery(idInboundDelivery.get());
    gr300UpdateDeliveryItemInput.setNumItem(numItem);
    gr300UpdateDeliveryItemInput.setIdArticle(idArticle);
    gr300UpdateDeliveryItemInput.setQtyDeliveryNote(qtyDeliveryNote);
    gr300UpdateDeliveryItemInput.setIdBatch(idBatch);
    gr300UpdateDeliveryItemInput.setTsBbd(tsBbd);
    gr300UpdateDeliveryItemInput.setDelete(deleteFlag);
    grDeliveryDataHandler.setGr300UpdateDeliveryItemInput(gr300UpdateDeliveryItemInput);

    serviceInput.setData(gr300UpdateDeliveryItemInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_UPDATE_DELIVERY_ITEM, serviceInput);
  }

  private void saveDeliveryItemAdvice(Boolean deleteFlag, GherkinType<String> idInboundDelivery, Long numItem, String idArticle,
      Double qtyDeliveryNote, String idBatch, Date tsBbd, GherkinType<String> idAdvice, Long numItemAdvice) {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    idAdvice.setGetterForKey(grDeliveryDataHandler.idAvAdviceGetter);
    ServiceInput<GR300UpdateDeliveryItemAdviceInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300UpdateDeliveryItemAdviceInput gr300UpdateDeliveryItemAdviceInput = new GR300UpdateDeliveryItemAdviceInput();
    gr300UpdateDeliveryItemAdviceInput.setIdClient(generalHelper.getIdClient());
    gr300UpdateDeliveryItemAdviceInput.setIdInboundDelivery(idInboundDelivery.get());
    gr300UpdateDeliveryItemAdviceInput.setNumItem(numItem);
    gr300UpdateDeliveryItemAdviceInput.setIdArticle(idArticle);
    gr300UpdateDeliveryItemAdviceInput.setQtyDeliveryNote(qtyDeliveryNote);
    gr300UpdateDeliveryItemAdviceInput.setIdBatch(idBatch);
    gr300UpdateDeliveryItemAdviceInput.setTsBbd(tsBbd);
    gr300UpdateDeliveryItemAdviceInput.setIdAdvice(idAdvice.get());
    gr300UpdateDeliveryItemAdviceInput.setNumItemAdvice(numItemAdvice);
    gr300UpdateDeliveryItemAdviceInput.setDelete(deleteFlag);
    grDeliveryDataHandler.setGr300UpdateDeliveryItemAdviceInput(gr300UpdateDeliveryItemAdviceInput);

    serviceInput.setData(gr300UpdateDeliveryItemAdviceInput);
    webserviceClient.call(AdviceDesc.SERVICE, AdviceDesc.GR300_UPDATE_DELIVERY_ITEM_EP, serviceInput);
  }

  private void saveDeliveryItemText(Boolean deleteFlag, GherkinType<String> idInboundDelivery, Long numItem, Long numConsec, String typTxt,
      String txtInboundDeliveryItem) {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    ServiceInput<GR300UpdateDeliveryItemTextInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300UpdateDeliveryItemTextInput gr300UpdateDeliveryItemTextInput = new GR300UpdateDeliveryItemTextInput();
    gr300UpdateDeliveryItemTextInput.setIdClient(generalHelper.getIdClient());
    gr300UpdateDeliveryItemTextInput.setIdInboundDelivery(idInboundDelivery.get());
    gr300UpdateDeliveryItemTextInput.setNumItem(numItem);
    gr300UpdateDeliveryItemTextInput.setNumConsec(numConsec);
    gr300UpdateDeliveryItemTextInput.setTypTxt(typTxt);
    gr300UpdateDeliveryItemTextInput.setTxtInboundDeliveryItem(txtInboundDeliveryItem);
    gr300UpdateDeliveryItemTextInput.setFlgDelete(deleteFlag ? "1" : "0");
    grDeliveryDataHandler.setGr300UpdateDeliveryItemTextInput(gr300UpdateDeliveryItemTextInput);

    serviceInput.setData(gr300UpdateDeliveryItemTextInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_UPDATE_DELIVERY_ITEM_TEXT, serviceInput);
  }

  @When("GR300_UPDATE_DELIVERY creates record with: numDeliveryNote = {String}, datDeliveryNote = {Date}, idSupplier = {String}, name = {String}, idTransportVehicle = {String}, nameDriver = {String}, truckLicensePlate = {String}")
  @Given("GR300_UPDATE_DELIVERY created record with: numDeliveryNote = {String}, datDeliveryNote = {Date}, idSupplier = {String}, name = {String}, idTransportVehicle = {String}, nameDriver = {String}, truckLicensePlate = {String}")
  public void createDelivery(String numDeliveryNote, Date datDeliveryNote, String idSupplier, String name, String idTransportVehicle,
      String nameDriver, String truckLicensePlate) throws ParseException {
    saveDelivery(GherkinType.of(null), numDeliveryNote, datDeliveryNote, idSupplier, name, idTransportVehicle, nameDriver, truckLicensePlate);
  }

  @When("GR300_UPDATE_DELIVERY updates record with: idInboundDelivery = {StringExt}, numDeliveryNote = {String}, datDeliveryNote = {Date}, idSupplier = {String}, name = {String}, idTransportVehicle = {String}, nameDriver = {String}, truckLicensePlate = {String}")
  public void updateDelivery(GherkinType<String> idInboundDelivery, String numDeliveryNote, Date datDeliveryNote, String idSupplier, String name,
      String idTransportVehicle, String nameDriver, String truckLicensePlate) throws ParseException {
    saveDelivery(idInboundDelivery, numDeliveryNote, datDeliveryNote, idSupplier, name, idTransportVehicle, nameDriver, truckLicensePlate);
  }

  @When("GR300_UPDATE_DELIVERY_TEXT creates record with: idInboundDelivery = {StringExt}, typTxt = {String}, txtInboundDelivery = {String}")
  @Given("GR300_UPDATE_DELIVERY_TEXT created record with: idInboundDelivery = {StringExt}, typTxt = {String}, txtInboundDelivery = {String}")
  public void createDeliveryText(GherkinType<String> idInboundDelivery, String typTxt, String txtInboundDelivery) {
    saveDeliveryText(false, idInboundDelivery, null, typTxt, txtInboundDelivery);
  }

  @When("GR300_UPDATE_DELIVERY_TEXT updates record with: idInboundDelivery = {StringExt}, numConsec = {Long}, typTxt = {String}, txtInboundDelivery = {String}")
  public void updateDeliveryText(GherkinType<String> idInboundDelivery, Long numConsec, String typTxt, String txtInboundDelivery) {
    saveDeliveryText(false, idInboundDelivery, numConsec, typTxt, txtInboundDelivery);
  }

  @When("GR300_UPDATE_DELIVERY_TEXT deletes record with: idInboundDelivery = {StringExt}, numConsec = {Long}")
  public void deleteDeliveryText(GherkinType<String> idInboundDelivery, Long numConsec) {
    saveDeliveryText(true, idInboundDelivery, numConsec, null, null);
  }

  @When("GR300_UPDATE_DELIVERY_ITEM creates record with: idInboundDelivery = {StringExt}, idArticle = {String}, qtyDeliveryNote = {Double}, idBatch = {String}, tsBbd = {Date}")
  @Given("GR300_UPDATE_DELIVERY_ITEM created record with: idInboundDelivery = {StringExt}, idArticle = {String}, qtyDeliveryNote = {Double}, idBatch = {String}, tsBbd = {Date}")
  public void createDeliveryItem(GherkinType<String> idInboundDelivery, String idArticle, Double qtyDeliveryNote, String idBatch, Date tsBbd) {
    saveDeliveryItem(false, idInboundDelivery, null, idArticle, qtyDeliveryNote, idBatch, tsBbd);
  }

  @When("GR300_UPDATE_DELIVERY_ITEM updates record with: idInboundDelivery = {StringExt}, numItem = {Long}, idArticle = {String}, qtyDeliveryNote = {Double}, idBatch = {String}, tsBbd = {Date}")
  public void updateDeliveryItem(GherkinType<String> idInboundDelivery, Long numItem, String idArticle, Double qtyDeliveryNote, String idBatch,
      Date tsBbd) {
    saveDeliveryItem(false, idInboundDelivery, numItem, idArticle, qtyDeliveryNote, idBatch, tsBbd);
  }

  @When("GR300_UPDATE_DELIVERY_ITEM deletes record with: idInboundDelivery = {StringExt}, numItem = {Long}")
  public void deleteDeliveryItem(GherkinType<String> idInboundDelivery, Long numItem) {
    saveDeliveryItem(true, idInboundDelivery, numItem, null, null, null, null);
  }

  @When("GR300_UPDATE_DELIVERY_ITEM_EP creates record with: idInboundDelivery = {StringExt}, idArticle = {String}, qtyDeliveryNote = {Double}, idBatch = {String}, tsBbd = {Date}, idAdvice = {StringExt}, numItemAdvice = {Long}")
  @Given("GR300_UPDATE_DELIVERY_ITEM_EP created record with: idInboundDelivery = {StringExt}, idArticle = {String}, qtyDeliveryNote = {Double}, idBatch = {String}, tsBbd = {Date}, idAdvice = {StringExt}, numItemAdvice = {Long}")
  public void createDeliveryItemAdvice(GherkinType<String> idInboundDelivery, String idArticle, Double qtyDeliveryNote, String idBatch, Date tsBbd,
      GherkinType<String> idAdvice, Long numItemAdvice) {
    saveDeliveryItemAdvice(false, idInboundDelivery, null, idArticle, qtyDeliveryNote, idBatch, tsBbd, idAdvice, numItemAdvice);
  }

  @When("GR300_UPDATE_DELIVERY_ITEM_EP updates record with: idInboundDelivery = {StringExt}, numItem = {Long}, idArticle = {String}, qtyDeliveryNote = {Double}, idBatch = {String}, tsBbd = {Date}, idAdvice = {StringExt}, numItemAdvice = {Long}")
  public void updateDeliveryItemAdvice(GherkinType<String> idInboundDelivery, Long numItem, String idArticle, Double qtyDeliveryNote, String idBatch,
      Date tsBbd, GherkinType<String> idAdvice, Long numItemAdvice) {
    saveDeliveryItemAdvice(false, idInboundDelivery, numItem, idArticle, qtyDeliveryNote, idBatch, tsBbd, idAdvice, numItemAdvice);
  }

  @When("GR300_UPDATE_DELIVERY_ITEM_EP deletes record with: idInboundDelivery = {StringExt}, numItem = {Long}")
  public void deleteDeliveryItemAdvice(GherkinType<String> idInboundDelivery, Long numItem) {
    saveDeliveryItemAdvice(true, idInboundDelivery, numItem, null, null, null, null, GherkinType.of(null), null);
  }

  @When("GR300_UPDATE_DELIVERY_ITEM_TEXT creates record with: idInboundDelivery = {StringExt}, numItem = {Long}, typTxt = {String}, txtInboundDeliveryItem = {String}")
  @Given("GR300_UPDATE_DELIVERY_ITEM_TEXT created record with: idInboundDelivery = {StringExt}, numItem = {Long}, typTxt = {String}, txtInboundDeliveryItem = {String}")
  public void createDeliveryItemText(GherkinType<String> idInboundDelivery, Long numItem, String typTxt, String txtInboundDeliveryItem) {
    saveDeliveryItemText(false, idInboundDelivery, numItem, null, typTxt, txtInboundDeliveryItem);
  }

  @When("GR300_UPDATE_DELIVERY_ITEM_TEXT updates record with: idInboundDelivery = {StringExt}, numItem = {Long}, numConsec = {Long}, typTxt = {String}, txtInboundDeliveryItem = {String}")
  public void updateDeliveryItemText(GherkinType<String> idInboundDelivery, Long numItem, Long numConsec, String typTxt,
      String txtInboundDeliveryItem) {
    saveDeliveryItemText(false, idInboundDelivery, numItem, numConsec, typTxt, txtInboundDeliveryItem);
  }

  @When("GR300_UPDATE_DELIVERY_ITEM_TEXT deletes record with: idInboundDelivery = {StringExt}, numItem = {Long}, numConsec = {Long}")
  public void deleteDeliveryItemText(GherkinType<String> idInboundDelivery, Long numItem, Long numConsec) {
    saveDeliveryItemText(true, idInboundDelivery, numItem, numConsec, null, null);
  }

  @When("GR300_SEARCH_DELIVERIES searches for: input = {String}")
  public void searchDeliveries(String input) throws ParseException {
    ServiceInput<GR300SearchInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300SearchInput gr300SearchInput = new GR300SearchInput();
    gr300SearchInput.setIdClient(generalHelper.getIdClient());
    gr300SearchInput.setInput(input);

    serviceInput.setData(gr300SearchInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_SEARCH_DELIVERIES, serviceInput);
  }

  @When("GR300_SEARCH_DELIVERY_TEXT searches for: idInboundDelivery = {StringExt}, typTxt = {String}")
  public void searchDeliveryTexts(GherkinType<String> idInboundDelivery, String typTxt) throws ParseException {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    ServiceInput<GR300SearchDeliveryTextInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300SearchDeliveryTextInput gr300SearchDeliveryTextInput = new GR300SearchDeliveryTextInput();
    gr300SearchDeliveryTextInput.setIdClient(generalHelper.getIdClient());
    gr300SearchDeliveryTextInput.setIdInboundDelivery(idInboundDelivery.get());
    gr300SearchDeliveryTextInput.setTypTxt(typTxt);

    serviceInput.setData(gr300SearchDeliveryTextInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_SEARCH_DELIVERY_TEXT, serviceInput);
  }

  @When("GR300_SEARCH_DELIVERY_ITEM searches for: idInboundDelivery = {StringExt}, input = {String}")
  public void searchDeliveryItems(GherkinType<String> idInboundDelivery, String input) throws ParseException {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    ServiceInput<GR300SearchDeliveryItemInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300SearchDeliveryItemInput gr300SearchDeliveryItemInput = new GR300SearchDeliveryItemInput();
    gr300SearchDeliveryItemInput.setIdClient(generalHelper.getIdClient());
    gr300SearchDeliveryItemInput.setIdInboundDelivery(idInboundDelivery.get());
    gr300SearchDeliveryItemInput.setInput(input);

    serviceInput.setData(gr300SearchDeliveryItemInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_SEARCH_DELIVERY_ITEM, serviceInput);
  }

  @When("GR300_SEARCH_DELIVERY_ITEM_TEXT searches for: idInboundDelivery = {StringExt}, numItem = {Long}, typTxt = {String}")
  public void searchDeliveryItemTexts(GherkinType<String> idInboundDelivery, Long numItem, String typTxt) throws ParseException {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    ServiceInput<GR300SearchDeliveryItemTextInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300SearchDeliveryItemTextInput gr300SearchDeliveryItemTextInput = new GR300SearchDeliveryItemTextInput();
    gr300SearchDeliveryItemTextInput.setIdClient(generalHelper.getIdClient());
    gr300SearchDeliveryItemTextInput.setIdInboundDelivery(idInboundDelivery.get());
    gr300SearchDeliveryItemTextInput.setNumItem(numItem);
    gr300SearchDeliveryItemTextInput.setTypTxt(typTxt);

    serviceInput.setData(gr300SearchDeliveryItemTextInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_SEARCH_DELIVERY_ITEM_TEXT, serviceInput);
  }

  @When("GR300_SEARCH_CLIENTS searches for: idSite = {String}, idClient = {String}")
  public void searchClients(String idSite, String idClient) throws ParseException {
    ServiceInput<GR300SearchClientInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", idSite);

    GR300SearchClientInput gr300SearchClientInput = new GR300SearchClientInput();
    gr300SearchClientInput.setIdClient(idClient);

    serviceInput.setData(gr300SearchClientInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_SEARCH_CLIENTS, serviceInput);
  }

  @When("GR300_SEARCH_ARTICLES searches for: input = {String}")
  public void searchArticles(String input) throws ParseException {
    ServiceInput<ArtSearchArticleInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    ArtSearchArticleInput searchInput = new ArtSearchArticleInput(generalHelper.getIdClient(), input, true, true, true, true, true, true);

    serviceInput.setData(searchInput);
    webserviceClient.call(BwmsArticleDesc.SERVICE, BwmsArticleDesc.SEARCH_ARTICLES, serviceInput);
  }

  @When("GR300_SEARCH_VEHICLES searches for: input = {String}")
  public void searchVehicles(String input) throws ParseException {
    ServiceInput<GR300SearchInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300SearchInput gr300SearchInput = new GR300SearchInput();
    gr300SearchInput.setIdClient(generalHelper.getIdClient());
    gr300SearchInput.setInput(input);

    serviceInput.setData(gr300SearchInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_SEARCH_VEHICLES, serviceInput);
  }

  @When("GR300_SEARCH_SUPPLIERS searches for: input = {String}")
  public void searchSuppliers(String input) throws ParseException {
    ServiceInput<GR300SearchInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    GR300SearchInput gr300SearchInput = new GR300SearchInput();
    gr300SearchInput.setIdClient(generalHelper.getIdClient());
    gr300SearchInput.setInput(input);

    serviceInput.setData(gr300SearchInput);
    webserviceClient.call(BwmsGRBaseDesc.SERVICE, BwmsGRBaseDesc.GR300_SEARCH_SUPPLIERS, serviceInput);
  }

}
