package com.inconso.bend.inwmsx.it.grbase;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.advice.service.api.GR300UpdateDeliveryItemAdviceInput;
import com.inconso.bend.article.service.api.ArtSearchArticleOutput;
import com.inconso.bend.grbase.pers.gen.GrInboundDeliveryItemPk;
import com.inconso.bend.grbase.pers.gen.GrInboundDeliveryItemTextPk;
import com.inconso.bend.grbase.pers.gen.GrInboundDeliveryPk;
import com.inconso.bend.grbase.pers.gen.GrInboundDeliveryTextPk;
import com.inconso.bend.grbase.pers.model.GrInboundDelivery;
import com.inconso.bend.grbase.pers.model.GrInboundDeliveryItem;
import com.inconso.bend.grbase.pers.model.GrInboundDeliveryItemText;
import com.inconso.bend.grbase.pers.model.GrInboundDeliveryText;
import com.inconso.bend.grbase.pers.rep.GrInboundDeliveryItemRep;
import com.inconso.bend.grbase.pers.rep.GrInboundDeliveryItemTextRep;
import com.inconso.bend.grbase.pers.rep.GrInboundDeliveryRep;
import com.inconso.bend.grbase.pers.rep.GrInboundDeliveryTextRep;
import com.inconso.bend.grbase.service.api.GR300SearchClientOutput;
import com.inconso.bend.grbase.service.api.GR300SearchDeliveryItemOutput;
import com.inconso.bend.grbase.service.api.GR300SearchDeliveryItemTextOutput;
import com.inconso.bend.grbase.service.api.GR300SearchDeliveryOutput;
import com.inconso.bend.grbase.service.api.GR300SearchDeliveryTextOutput;
import com.inconso.bend.grbase.service.api.GR300SearchSupplierOutput;
import com.inconso.bend.grbase.service.api.GR300SearchVehicleOutput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryItemInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryItemTextInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryTextInput;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.FieldExtractor;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.parmgmt.pers.gen.PmSupplierPk;
import com.inconso.bend.parmgmt.pers.model.PmSupplier;
import com.inconso.bend.parmgmt.pers.rep.PmSupplierRep;
import com.inconso.bend.tourmgmt.pers.gen.TmTransportVehiclePk;
import com.inconso.bend.tourmgmt.pers.model.TmTransportVehicle;
import com.inconso.bend.tourmgmt.pers.rep.TmTransportVehicleRep;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;

public class GrDeliveryFieldVerifier {

  @Autowired
  private WebserviceClient                        webserviceClient;

  @Autowired
  private GeneralHelper                           generalHelper;

  @Autowired
  private CucumberReport                          cucumberReport;

  @Autowired
  private GrDeliveryDataHandler                   grDeliveryDataHandler;

  @Autowired
  private GrInboundDeliveryRep                    grInboundDeliveryRep;

  @Autowired
  private GrInboundDeliveryTextRep                grInboundDeliveryTextRep;

  @Autowired
  private GrInboundDeliveryItemRep                grInboundDeliveryItemRep;

  @Autowired
  private GrInboundDeliveryItemTextRep            grInboundDeliveryItemTextRep;

  @Autowired
  private TmTransportVehicleRep                   tmTransportVehicleRep;

  @Autowired
  private PmSupplierRep                           pmSupplierRep;

  private List<GR300SearchDeliveryOutput>         gr300SearchDeliveryResults;
  private List<GR300SearchDeliveryTextOutput>     gr300SearchDeliveryTextResults;
  private List<GR300SearchDeliveryItemOutput>     gr300SearchDeliveryItemResults;
  private List<GR300SearchDeliveryItemTextOutput> gr300SearchDeliveryItemTextResults;
  private List<GR300SearchClientOutput>           gr300SearchClientResults;
  private List<ArtSearchArticleOutput>            artSearchArticleResults;
  private List<GR300SearchVehicleOutput>          gr300SearchVehicleResults;
  private List<GR300SearchSupplierOutput>         gr300SearchSupplierResults;

  @Then("GR300_UPDATE_DELIVERY result is saved as {string}")
  @Transactional(readOnly = true)
  public void verifyDelivery(String key) {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    GR300UpdateDeliveryInput gr300UpdateDeliveryInput = grDeliveryDataHandler.getGr300UpdateDeliveryInput();
    boolean isCreated = gr300UpdateDeliveryInput.getIdInboundDelivery() == null;

    String idInboundDelivery = isCreated ? payload.getString("idInboundDelivery") : gr300UpdateDeliveryInput.getIdInboundDelivery();
    String idSite = generalHelper.getIdSite();
    String idClient = gr300UpdateDeliveryInput.getIdClient();
    String numDeliveryNote = gr300UpdateDeliveryInput.getNumDeliveryNote();
    Date datDeliveryNote = gr300UpdateDeliveryInput.getDatDeliveryNote();
    String idSupplier = gr300UpdateDeliveryInput.getIdSupplier();
    String name = gr300UpdateDeliveryInput.getName();
    String idTransportVehicle = gr300UpdateDeliveryInput.getIdTransportVehicle();
    String nameDriver = gr300UpdateDeliveryInput.getNameDriver();
    String truckLicensePlate = gr300UpdateDeliveryInput.getTruckLicensePlate();

    // Update PK in the input object in case of record creation
    gr300UpdateDeliveryInput.setIdInboundDelivery(idInboundDelivery);

    // The webservice only takes the supplier name into account if the supplier doesn't exist (to create a new supplier), otherwise the name is
    // ignored.
    if (idSupplier != null && idClient != null) {
      PmSupplier pmSupplier = pmSupplierRep.findOne(new PmSupplierPk(idClient, idSupplier));
      if (pmSupplier != null) {
        name = pmSupplier.getName();
      }
    }
    String supplierName = name;

    GrInboundDelivery grInboundDelivery = grInboundDeliveryRep.findOne(new GrInboundDeliveryPk(idSite, idClient, idInboundDelivery));
    grDeliveryDataHandler.putGrInboundDelivery(key, grInboundDelivery);

    TmTransportVehicle tmTransportVehicle = tmTransportVehicleRep.findOne(new TmTransportVehiclePk(idSite, idTransportVehicle));

    assertAll(
        // check service result

        () -> assertNotNull(idInboundDelivery, "Service result: idInboundDelivery"),
        () -> assertEquals(idInboundDelivery, payload.getString("idInboundDelivery"), "Service result: idInboundDelivery"),

        () -> assertEquals(idSite, payload.getString("idSite"), "Service result: idSite"),
        () -> assertEquals(idClient, payload.getString("idClient"), "Service result: idClient"),

        () -> assertEquals(numDeliveryNote, payload.getString("numDeliveryNote"), "Service result: numDeliveryNote"),
        () -> assertEquals(datDeliveryNote, payload.getDate("datDeliveryNote"), "Service result: datDeliveryNote"),
        () -> assertEquals(idSupplier, payload.getString("idSupplier"), "Service result: idSupplier"),
        () -> assertEquals(supplierName, payload.getString("name"), "Service result: name"),
        () -> assertEquals(idTransportVehicle, payload.getString("idTransportVehicle"), "Service result: idTransportVehicle"),
        () -> assertEquals(nameDriver, payload.getString("nameDriver"), "Service result: nameDriver"),
        () -> assertEquals(truckLicensePlate, payload.getString("truckLicensePlate"), "Service result: truckLicensePlate"),

        // check persistence

        () -> assertEquals(idSite, grInboundDelivery.getGrInboundDeliveryPk().getIdSite(), "Persistence: idSite"),
        () -> assertEquals(idClient, grInboundDelivery.getGrInboundDeliveryPk().getIdClient(), "Persistence: idClient"),
        () -> assertEquals(idInboundDelivery, grInboundDelivery.getGrInboundDeliveryPk().getIdInboundDelivery(), "Persistence: idInboundDelivery"),

        () -> assertEquals(numDeliveryNote, grInboundDelivery.getNumDeliveryNote(), "Persistence: numDeliveryNote"),
        () -> assertEquals(datDeliveryNote, grInboundDelivery.getDatDeliveryNote(), "Persistence: datDeliveryNote"),
        () -> assertEquals(idSupplier, grInboundDelivery.getIdSupplier(), "Persistence: idSupplier"),
        () -> assertEquals(idTransportVehicle, grInboundDelivery.getIdTransportVehicle(), "Persistence: idTransportVehicle"),
        () -> assertEquals(nameDriver, (tmTransportVehicle != null) ? tmTransportVehicle.getNameDriver() : null, "Persistence: nameDriver"),
        () -> assertEquals(truckLicensePlate, (tmTransportVehicle != null) ? tmTransportVehicle.getTruckLicensePlate() : null,
            "Persistence: truckLicensePlate"));
  }

  @Then("GR300_UPDATE_DELIVERY_TEXT is/was successful")
  @Transactional(readOnly = true)
  public void verifyDeliveryText() {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    GR300UpdateDeliveryTextInput gr300UpdateDeliveryTextInput = grDeliveryDataHandler.getGr300UpdateDeliveryTextInput();
    boolean isCreated = gr300UpdateDeliveryTextInput.getNumConsec() == null;
    boolean isDelete = "1".equals(gr300UpdateDeliveryTextInput.getFlgDelete());

    Long numConsec = isCreated ? payload.getLong("numConsec") : gr300UpdateDeliveryTextInput.getNumConsec();
    String idSite = generalHelper.getIdSite();
    String idClient = gr300UpdateDeliveryTextInput.getIdClient();
    String idInboundDelivery = gr300UpdateDeliveryTextInput.getIdInboundDelivery();
    String typTxt = gr300UpdateDeliveryTextInput.getTypTxt();
    String txtInboundDelivery = gr300UpdateDeliveryTextInput.getTxtInboundDelivery();

    // Update PK in the input object in case of record creation
    gr300UpdateDeliveryTextInput.setNumConsec(numConsec);

    GrInboundDeliveryText inboundDeliveryText = grInboundDeliveryTextRep
        .findOne(new GrInboundDeliveryTextPk(idSite, idClient, idInboundDelivery, numConsec));

    if (inboundDeliveryText != null) {
      cucumberReport.setMessage(inboundDeliveryText.getGrInboundDeliveryTextPk().toString());
    }

    assertAll(
        // check service result

        () -> assertNotNull(numConsec, "Service result: numConsec"),
        () -> assertEquals(numConsec, payload.getLong("numConsec"), "Service result: numConsec"),

        () -> assertEquals(idSite, payload.getString("idSite"), "Service result: idSite"),
        () -> assertEquals(idClient, payload.getString("idClient"), "Service result: idClient"),
        () -> assertEquals(idInboundDelivery, payload.getString("idInboundDelivery"), "Service result: idInboundDelivery"));

    if (isDelete) {
      // check persistence
      assertNull(inboundDeliveryText, "Persistence: Deletion failed");
    } else {
      assertAll(
          // check service result

          () -> assertEquals(typTxt, payload.getString("typText"), "Service result: typText"),
          () -> assertEquals(txtInboundDelivery, payload.getString("txtInboundDelivery"), "Service result: txtInboundDelivery"),

          // check persistence

          () -> assertEquals(idSite, inboundDeliveryText.getGrInboundDeliveryTextPk().getIdSite(), "Persistence: idSite"),
          () -> assertEquals(idClient, inboundDeliveryText.getGrInboundDeliveryTextPk().getIdClient(), "Persistence: idClient"),
          () -> assertEquals(idInboundDelivery, inboundDeliveryText.getGrInboundDeliveryTextPk().getIdInboundDelivery(),
              "Persistence: idInboundDelivery"),
          () -> assertEquals(numConsec, inboundDeliveryText.getGrInboundDeliveryTextPk().getNumConsec(), "Persistence: numConsec"),

          () -> assertEquals(typTxt, inboundDeliveryText.getTypTxt(), "Persistence: typTxt"),
          () -> assertEquals(txtInboundDelivery, inboundDeliveryText.getTxtInboundDelivery(), "Persistence: txtInboundDelivery"));
    }
  }

  @Then("GR300_UPDATE_DELIVERY_ITEM is/was successful")
  @Transactional(readOnly = true)
  public void verifyDeliveryItem() {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    GR300UpdateDeliveryItemInput gr300UpdateDeliveryItemInput = grDeliveryDataHandler.getGr300UpdateDeliveryItemInput();
    boolean isCreated = gr300UpdateDeliveryItemInput.getNumItem() == null;
    boolean isDelete = gr300UpdateDeliveryItemInput.isDelete();

    Long numItem = isCreated ? payload.getLong("numItem") : gr300UpdateDeliveryItemInput.getNumItem();
    String idSite = generalHelper.getIdSite();
    String idClient = gr300UpdateDeliveryItemInput.getIdClient();
    String idInboundDelivery = gr300UpdateDeliveryItemInput.getIdInboundDelivery();
    String idArticle = gr300UpdateDeliveryItemInput.getIdArticle();
    Double qtyDeliveryNote = gr300UpdateDeliveryItemInput.getQtyDeliveryNote();
    String idBatch = gr300UpdateDeliveryItemInput.getIdBatch();
    Date tsBbd = gr300UpdateDeliveryItemInput.getTsBbd();

    // Update PK in the input object in case of record creation
    gr300UpdateDeliveryItemInput.setNumItem(numItem);

    GrInboundDeliveryItem inboundDeliveryItem = grInboundDeliveryItemRep
        .findOne(new GrInboundDeliveryItemPk(idSite, idClient, idInboundDelivery, numItem));

    if (inboundDeliveryItem != null) {
      cucumberReport.setMessage(inboundDeliveryItem.getGrInboundDeliveryItemPk().toString());
    }

    assertAll(
        // check service result

        () -> assertNotNull(numItem, "Service result: numItem"), () -> assertEquals(numItem, payload.getLong("numItem"), "Service result: numItem"),

        () -> assertEquals(idSite, payload.getString("idSite"), "Service result: idSite"),
        () -> assertEquals(idClient, payload.getString("idClient"), "Service result: idClient"),
        () -> assertEquals(idInboundDelivery, payload.getString("idInboundDelivery"), "Service result: idInboundDelivery"));

    if (isDelete) {
      // check persistence
      assertNull(inboundDeliveryItem, "Persistence: Deletion failed");
    } else {
      assertAll(
          // check service result

          () -> assertEquals(idArticle, payload.getString("idArticle"), "Service result: idArticle"),
          () -> assertEquals(qtyDeliveryNote, payload.getDouble("qtyDeliveryNote"), "Service result: qtyDeliveryNote"),
          () -> assertEquals(idBatch, payload.getString("idBatch"), "Service result: idBatch"),
          () -> assertEquals(tsBbd, payload.getDate("tsBbd"), "Service result: tsBbd"),

          // check persistence

          () -> assertEquals(idSite, inboundDeliveryItem.getGrInboundDeliveryItemPk().getIdSite(), "Persistence: idSite"),
          () -> assertEquals(idClient, inboundDeliveryItem.getGrInboundDeliveryItemPk().getIdClient(), "Persistence: idClient"),
          () -> assertEquals(idInboundDelivery, inboundDeliveryItem.getGrInboundDeliveryItemPk().getIdInboundDelivery(),
              "Persistence: idInboundDelivery"),
          () -> assertEquals(numItem, inboundDeliveryItem.getGrInboundDeliveryItemPk().getNumItem(), "Persistence: numItem"),

          () -> assertEquals(idArticle, inboundDeliveryItem.getIdArticle(), "Persistence: idArticle"),
          () -> assertEquals(qtyDeliveryNote, inboundDeliveryItem.getQtyDeliveryNote(), "Persistence: qtyDeliveryNote"),
          () -> assertEquals(idBatch, inboundDeliveryItem.getIdBatch(), "Persistence: idBatch"),
          () -> assertEquals(tsBbd, inboundDeliveryItem.getTsBbd(), "Persistence: tsBbd"));
    }
  }

  @Then("GR300_UPDATE_DELIVERY_ITEM_EP is/was successful")
  @Transactional(readOnly = true)
  public void verifyDeliveryItemAdvice() {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    GR300UpdateDeliveryItemAdviceInput gr300UpdateDeliveryItemAdviceInput = grDeliveryDataHandler.getGr300UpdateDeliveryItemAdviceInput();
    boolean isCreated = gr300UpdateDeliveryItemAdviceInput.getNumItem() == null;
    boolean isDelete = gr300UpdateDeliveryItemAdviceInput.isDelete();

    Long numItem = isCreated ? payload.getLong("numItem") : gr300UpdateDeliveryItemAdviceInput.getNumItem();
    String idClient = gr300UpdateDeliveryItemAdviceInput.getIdClient();
    String idInboundDelivery = gr300UpdateDeliveryItemAdviceInput.getIdInboundDelivery();
    String idArticle = gr300UpdateDeliveryItemAdviceInput.getIdArticle();
    Double qtyDeliveryNote = gr300UpdateDeliveryItemAdviceInput.getQtyDeliveryNote();
    String idBatch = gr300UpdateDeliveryItemAdviceInput.getIdBatch();
    Date tsBbd = gr300UpdateDeliveryItemAdviceInput.getTsBbd();

    // Update PK in the input object in case of record creation
    gr300UpdateDeliveryItemAdviceInput.setNumItem(numItem);

    GrInboundDeliveryItem inboundDeliveryItem = grInboundDeliveryItemRep
        .findOne(new GrInboundDeliveryItemPk(generalHelper.getIdSite(), idClient, idInboundDelivery, numItem));

    if (inboundDeliveryItem != null) {
      cucumberReport.setMessage(inboundDeliveryItem.getGrInboundDeliveryItemPk().toString());
    }

    assertAll(
        // check service result

        () -> assertNotNull(numItem, "Service result: numItem"), () -> assertEquals(numItem, payload.getLong("numItem"), "Service result: numItem"),
        () -> assertEquals(idClient, payload.getString("idClient"), "Service result: idClient"),
        () -> assertEquals(idInboundDelivery, payload.getString("idInboundDelivery"), "Service result: idInboundDelivery"));

    if (isDelete) {
      // check persistence
      assertNull(inboundDeliveryItem, "Persistence: Deletion failed");
    } else {
      assertAll(
          // check service result

          () -> assertEquals(idArticle, payload.getString("idArticle"), "Service result: idArticle"),
          () -> assertEquals(qtyDeliveryNote, payload.getDouble("qtyDeliveryNote"), "Service result: qtyDeliveryNote"),
          () -> assertEquals(idBatch, payload.getString("idBatch"), "Service result: idBatch"),
          () -> assertEquals(tsBbd, payload.getDate("tsBbd"), "Service result: tsBbd"),

          // check persistence

          () -> assertEquals(idClient, inboundDeliveryItem.getGrInboundDeliveryItemPk().getIdClient(), "Persistence: idClient"),
          () -> assertEquals(idInboundDelivery, inboundDeliveryItem.getGrInboundDeliveryItemPk().getIdInboundDelivery(),
              "Persistence: idInboundDelivery"),
          () -> assertEquals(numItem, inboundDeliveryItem.getGrInboundDeliveryItemPk().getNumItem(), "Persistence: numItem"),

          () -> assertEquals(idArticle, inboundDeliveryItem.getIdArticle(), "Persistence: idArticle"),
          () -> assertEquals(qtyDeliveryNote, inboundDeliveryItem.getQtyDeliveryNote(), "Persistence: qtyDeliveryNote"),
          () -> assertEquals(idBatch, inboundDeliveryItem.getIdBatch(), "Persistence: idBatch"),
          () -> assertEquals(tsBbd, inboundDeliveryItem.getTsBbd(), "Persistence: tsBbd")
      // idAdvice
      // numItemAdvice
      );
    }
  }

  @Then("GR300_UPDATE_DELIVERY_ITEM_TEXT is/was successful")
  @Transactional(readOnly = true)
  public void verifyDeliveryItemText() {
    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());
    GR300UpdateDeliveryItemTextInput gr300UpdateDeliveryItemTextInput = grDeliveryDataHandler.getGr300UpdateDeliveryItemTextInput();
    boolean isCreated = gr300UpdateDeliveryItemTextInput.getNumConsec() == null;
    boolean isDelete = "1".equals(gr300UpdateDeliveryItemTextInput.getFlgDelete());

    Long numConsec = isCreated ? payload.getLong("numConsec") : gr300UpdateDeliveryItemTextInput.getNumConsec();
    String idSite = generalHelper.getIdSite();
    String idClient = gr300UpdateDeliveryItemTextInput.getIdClient();
    String idInboundDelivery = gr300UpdateDeliveryItemTextInput.getIdInboundDelivery();
    Long numItem = gr300UpdateDeliveryItemTextInput.getNumItem();
    String typTxt = gr300UpdateDeliveryItemTextInput.getTypTxt();
    String txtInboundDeliveryItem = gr300UpdateDeliveryItemTextInput.getTxtInboundDeliveryItem();

    // Update PK in the input object in case of record creation
    gr300UpdateDeliveryItemTextInput.setNumConsec(numConsec);

    GrInboundDeliveryItemText inboundDeliveryItemText = grInboundDeliveryItemTextRep
        .findOne(new GrInboundDeliveryItemTextPk(idSite, idClient, idInboundDelivery, numItem, numConsec));

    if (inboundDeliveryItemText != null) {
      cucumberReport.setMessage(inboundDeliveryItemText.getGrInboundDeliveryItemTextPk().toString());
    }

    assertAll(
        // check service result

        () -> assertNotNull(numConsec, "Service result: numConsec"),
        () -> assertEquals(numConsec, payload.getLong("numConsec"), "Service result: numConsec"),

        () -> assertEquals(idSite, payload.getString("idSite"), "Service result: idSite"),
        () -> assertEquals(idClient, payload.getString("idClient"), "Service result: idClient"),
        () -> assertEquals(idInboundDelivery, payload.getString("idInboundDelivery"), "Service result: idInboundDelivery"),
        () -> assertEquals(numItem, payload.getLong("numItem"), "Service result: numItem"));

    if (isDelete) {
      assertNull(inboundDeliveryItemText, "Persistence: Deletion failed");
    } else {
      assertAll(
          // check service result

          () -> assertEquals(typTxt, payload.getString("typTxt"), "Service result: typTxt"),
          () -> assertEquals(txtInboundDeliveryItem, payload.getString("txtInboundDeliveryItem"), "Service result: txtInboundDeliveryItem"),

          // check persistence

          () -> assertEquals(idSite, inboundDeliveryItemText.getGrInboundDeliveryItemTextPk().getIdSite(), "Persistence: idSite"),
          () -> assertEquals(idClient, inboundDeliveryItemText.getGrInboundDeliveryItemTextPk().getIdClient(), "Persistence: idClient"),
          () -> assertEquals(idInboundDelivery, inboundDeliveryItemText.getGrInboundDeliveryItemTextPk().getIdInboundDelivery(),
              "Persistence: idInboundDelivery"),
          () -> assertEquals(numItem, inboundDeliveryItemText.getGrInboundDeliveryItemTextPk().getNumItem(), "Persistence: numItem"),
          () -> assertEquals(numConsec, inboundDeliveryItemText.getGrInboundDeliveryItemTextPk().getNumConsec(), "Persistence: numConsec"),

          () -> assertEquals(typTxt, inboundDeliveryItemText.getTypTxt(), "Persistence: typTxt"),
          () -> assertEquals(txtInboundDeliveryItem, inboundDeliveryItemText.getTxtInboundDeliveryItem(), "Persistence: txtInboundDeliveryItem"));
    }
  }

  @Then("delivery has {long} delivery text(s)")
  @Transactional(readOnly = true)
  public void verifyDeliveryTextCount(Long textCount) {
    GR300UpdateDeliveryInput gr300UpdateDeliveryInput = grDeliveryDataHandler.getGr300UpdateDeliveryInput();
    List<GrInboundDeliveryText> grInboundDeliveryTexts = grInboundDeliveryTextRep.findBySiteAndClientAndInboundDelivery(generalHelper.getIdSite(),
        gr300UpdateDeliveryInput.getIdClient(), gr300UpdateDeliveryInput.getIdInboundDelivery());
    assertEquals(grInboundDeliveryTexts.size(), textCount);
  }

  @Then("delivery has {long} delivery item(s)")
  @Transactional(readOnly = true)
  public void verifyDeliveryItemCount(Long itemCount) {
    GR300UpdateDeliveryInput gr300UpdateDeliveryInput = grDeliveryDataHandler.getGr300UpdateDeliveryInput();
    List<GrInboundDeliveryItem> grInboundDeliveryItems = grInboundDeliveryItemRep.findBySiteAndClientAndInboundDelivery(generalHelper.getIdSite(),
        gr300UpdateDeliveryInput.getIdClient(), gr300UpdateDeliveryInput.getIdInboundDelivery());
    assertEquals(grInboundDeliveryItems.size(), itemCount);
  }

  @Then("delivery item with numItem = {long} has {long} delivery item text(s)")
  @Transactional(readOnly = true)
  public void verifyDeliveryItemTextCount(Long numItem, Long itemTextCount) {
    GR300UpdateDeliveryInput gr300UpdateDeliveryInput = grDeliveryDataHandler.getGr300UpdateDeliveryInput();
    List<GrInboundDeliveryItemText> grInboundDeliveryItemTexts = grInboundDeliveryItemTextRep
        .findBySiteAndClientAndInboundDeliveryAndInboundDeliveryItem(generalHelper.getIdSite(), gr300UpdateDeliveryInput.getIdClient(),
            gr300UpdateDeliveryInput.getIdInboundDelivery(), numItem);
    assertEquals(grInboundDeliveryItemTexts.size(), itemTextCount);
  }

  @Then("GR300_SEARCH_DELIVERIES finds {int} record(s)")
  public void verifySearchDelivery(int count) {
    Comparator<GR300SearchDeliveryOutput> compare = Comparator.comparing(GR300SearchDeliveryOutput::getIdSite)
        .thenComparing(GR300SearchDeliveryOutput::getIdClient).thenComparing(GR300SearchDeliveryOutput::getIdInboundDelivery)
        .thenComparing(GR300SearchDeliveryOutput::getNumDeliveryNote);

    gr300SearchDeliveryResults = webserviceClient.verifySuccess().getOutput().stream().map(element -> {
      FieldExtractor record = new FieldExtractor(element);
      GR300SearchDeliveryOutput result = new GR300SearchDeliveryOutput();

      result.setIdSite(record.getString("idSite"));
      result.setIdClient(record.getString("idClient"));
      result.setIdInboundDelivery(record.getString("idInboundDelivery"));
      result.setNumDeliveryNote(record.getString("numDeliveryNote"));
      result.setDatDeliveryNote(record.getDate("datDeliveryNote"));
      result.setIdSupplier(record.getString("idSupplier"));
      result.setName(record.getString("name"));
      result.setIdTransportVehicle(record.getString("idTransportVehicle"));
      result.setNameDriver(record.getString("nameDriver"));
      result.setTruckLicensePlate(record.getString("truckLicensePlate"));

      return result;
    }).sorted(compare).collect(Collectors.toList());

    assertEquals(count, gr300SearchDeliveryResults.size(), "count");
  }

  @And("GR300_SEARCH_DELIVERIES result record {int} has: idSite = {StringExt}, idClient = {StringExt}, idInboundDelivery = {StringExt}, numDeliveryNote = {StringExt}, datDeliveryNote = {DateExt}, idSupplier = {StringExt}, name = {StringExt}, idTransportVehicle = {StringExt}, nameDriver = {StringExt}, truckLicensePlate = {StringExt}")
  public void verifySearchDeliveryRecord(int index, GherkinType<String> idSite, GherkinType<String> idClient, GherkinType<String> idInboundDelivery,
      GherkinType<String> numDeliveryNote, GherkinType<Date> datDeliveryNote, GherkinType<String> idSupplier, GherkinType<String> name,
      GherkinType<String> idTransportVehicle, GherkinType<String> nameDriver, GherkinType<String> truckLicensePlate) {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    GR300SearchDeliveryOutput record = gr300SearchDeliveryResults.get(index);

    //@formatter:off
    assertAll(
        () -> idSite.assertEquality(record.getIdSite(), "idSite"),
        () -> idClient.assertEquality(record.getIdClient(), "idClient"),
        () -> idInboundDelivery.assertEquality(record.getIdInboundDelivery(), "idInboundDelivery"),
        () -> numDeliveryNote.assertEquality(record.getNumDeliveryNote(), "numDeliveryNote"),
        () -> datDeliveryNote.assertEquality(record.getDatDeliveryNote(), "datDeliveryNote"),
        () -> idSupplier.assertEquality(record.getIdSupplier(), "idSupplier"),
        () -> name.assertEquality(record.getName(), "name"),
        () -> idTransportVehicle.assertEquality(record.getIdTransportVehicle(), "idTransportVehicle"),
        () -> nameDriver.assertEquality(record.getNameDriver(), "nameDriver"),
        () -> truckLicensePlate.assertEquality(record.getTruckLicensePlate(), "truckLicensePlate")
    );
    //@formatter:on
  }

  @Then("GR300_SEARCH_DELIVERY_TEXT finds {int} record(s)")
  public void verifySearchDeliveryText(int count) {
    Comparator<GR300SearchDeliveryTextOutput> compare = Comparator.comparing(GR300SearchDeliveryTextOutput::getIdSite)
        .thenComparing(GR300SearchDeliveryTextOutput::getIdClient).thenComparing(GR300SearchDeliveryTextOutput::getIdInboundDelivery)
        .thenComparing(GR300SearchDeliveryTextOutput::getNumConsec);

    gr300SearchDeliveryTextResults = webserviceClient.verifySuccess().getOutput().stream().map(element -> {
      FieldExtractor record = new FieldExtractor(element);
      GR300SearchDeliveryTextOutput result = new GR300SearchDeliveryTextOutput();

      result.setIdSite(record.getString("idSite"));
      result.setIdClient(record.getString("idClient"));
      result.setIdInboundDelivery(record.getString("idInboundDelivery"));
      result.setNumConsec(record.getLong("numConsec"));
      result.setTxtInboundDelivery(record.getString("txtInboundDelivery"));
      result.setTypText(record.getString("typText"));

      return result;
    }).sorted(compare).collect(Collectors.toList());

    assertEquals(count, gr300SearchDeliveryTextResults.size(), "count");
  }

  @And("GR300_SEARCH_DELIVERY_TEXT result record {int} has: idSite = {StringExt}, idClient = {StringExt}, idInboundDelivery = {StringExt}, numConsec = {LongExt}, typTxt = {StringExt}, txtInboundDelivery = {StringExt}")
  public void verifySearchDeliveryTextRecord(int index, GherkinType<String> idSite, GherkinType<String> idClient,
      GherkinType<String> idInboundDelivery, GherkinType<Long> numConsec, GherkinType<String> typTxt, GherkinType<String> txtInboundDelivery) {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    GR300SearchDeliveryTextOutput record = gr300SearchDeliveryTextResults.get(index);

    //@formatter:off
    assertAll(
        () -> idSite.assertEquality(record.getIdSite(), "idSite"),
        () -> idClient.assertEquality(record.getIdClient(), "idClient"),
        () -> idInboundDelivery.assertEquality(record.getIdInboundDelivery(), "idInboundDelivery"),
        () -> numConsec.assertEquality(record.getNumConsec(), "numConsec"),
        () -> typTxt.assertEquality(record.getTypText(), "typTxt"),
        () -> txtInboundDelivery.assertEquality(record.getTxtInboundDelivery(), "txtInboundDelivery")        
    );
    //@formatter:on
  }

  @Then("GR300_SEARCH_DELIVERY_ITEM finds {int} record(s)")
  public void verifySearchDeliveryItem(int count) {
    Comparator<GR300SearchDeliveryItemOutput> compare = Comparator.comparing(GR300SearchDeliveryItemOutput::getIdSite)
        .thenComparing(GR300SearchDeliveryItemOutput::getIdClient).thenComparing(GR300SearchDeliveryItemOutput::getIdInboundDelivery)
        .thenComparing(GR300SearchDeliveryItemOutput::getNumItem);

    gr300SearchDeliveryItemResults = webserviceClient.verifySuccess().getOutput().stream().map(element -> {
      FieldExtractor record = new FieldExtractor(element);
      GR300SearchDeliveryItemOutput result = new GR300SearchDeliveryItemOutput();

      result.setIdSite(record.getString("idSite"));
      result.setIdClient(record.getString("idClient"));
      result.setIdInboundDelivery(record.getString("idInboundDelivery"));
      result.setNumItem(record.getLong("numItem"));
      result.setIdArticle(record.getString("idArticle"));
      result.setQtyDeliveryNote(record.getDouble("qtyDeliveryNote"));
      result.setIdBatch(record.getString("idBatch"));
      result.setTsBbd(record.getDate("tsBbd"));

      result.setArtvar(record.getString("artvar"));
      result.setDataMessage(record.getString("dataMessage"));
      result.setIdRefDocument1(record.getString("idRefDocument1"));
      result.setIdRefDocument2(record.getString("idRefDocument2"));
      result.setIdRefExternal1(record.getString("idRefExternal1"));
      result.setIdRefExternal2(record.getString("idRefExternal2"));
      result.setIdRefExternalItem(record.getString("idRefExternalItem"));
      result.setIdRefLineItem(record.getString("idRefLineItem"));
      result.setIdSupplier(record.getString("idSupplier"));
      result.setSepCrit01(record.getString("sepCrit01"));
      result.setSepCrit02(record.getString("sepCrit02"));
      result.setSepCrit03(record.getString("sepCrit03"));
      result.setSepCrit04(record.getString("sepCrit04"));
      result.setSepCrit05(record.getString("sepCrit05"));
      result.setSepCrit06(record.getString("sepCrit06"));
      result.setSepCrit07(record.getString("sepCrit07"));
      result.setSepCrit08(record.getString("sepCrit08"));
      result.setSepCrit09(record.getString("sepCrit09"));
      result.setSepCrit10(record.getString("sepCrit10"));
      result.setStat(record.getString("stat"));
      result.setTxtLabel(record.getString("txtLabel"));
      result.setTypDocument(record.getString("typDocument"));
      result.setTypExternal(record.getString("typExternal"));
      result.setUnitStock(record.getString("unitStock"));

      return result;
    }).sorted(compare).collect(Collectors.toList());

    assertEquals(count, gr300SearchDeliveryItemResults.size(), "count");
  }

  @And("GR300_SEARCH_DELIVERY_ITEM result record {int} has: idSite = {StringExt}, idClient = {StringExt}, idInboundDelivery = {StringExt}, numItem = {LongExt}, idArticle = {StringExt}, qtyDeliveryNote = {DoubleExt}, idBatch = {StringExt}, tsBbd = {DateExt}")
  public void verifySearchDeliveryItemRecord(int index, GherkinType<String> idSite, GherkinType<String> idClient,
      GherkinType<String> idInboundDelivery, GherkinType<Long> numItem, GherkinType<String> idArticle, GherkinType<Double> qtyDeliveryNote,
      GherkinType<String> idBatch, GherkinType<Date> tsBbd) {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);
    GR300SearchDeliveryItemOutput record = gr300SearchDeliveryItemResults.get(index);

    //@formatter:off
    assertAll(
        () -> idSite.assertEquality(record.getIdSite(), "idSite"),
        () -> idClient.assertEquality(record.getIdClient(), "idClient"),
        () -> idInboundDelivery.assertEquality(record.getIdInboundDelivery(), "idInboundDelivery"),
        () -> numItem.assertEquality(record.getNumItem(), "numItem"),
        () -> idArticle.assertEquality(record.getIdArticle(), "idArticle"),
        () -> qtyDeliveryNote.assertEquality(record.getQtyDeliveryNote(), "qtyDeliveryNote"),
        () -> idBatch.assertEquality(record.getIdBatch(), "idBatch"),
        () -> tsBbd.assertEquality(record.getTsBbd(), "tsBbd")
    );    
    //@formatter:on
  }

  @Then("GR300_SEARCH_DELIVERY_ITEM_TEXT finds {int} record(s)")
  public void verifySearchDeliveryItemText(int count) {
    Comparator<GR300SearchDeliveryItemTextOutput> compare = Comparator.comparing(GR300SearchDeliveryItemTextOutput::getIdSite)
        .thenComparing(GR300SearchDeliveryItemTextOutput::getIdClient).thenComparing(GR300SearchDeliveryItemTextOutput::getIdInboundDelivery)
        .thenComparing(GR300SearchDeliveryItemTextOutput::getNumItem).thenComparing(GR300SearchDeliveryItemTextOutput::getNumConsec);

    gr300SearchDeliveryItemTextResults = webserviceClient.verifySuccess().getOutput().stream().map(element -> {
      FieldExtractor record = new FieldExtractor(element);
      GR300SearchDeliveryItemTextOutput result = new GR300SearchDeliveryItemTextOutput();

      result.setIdSite(record.getString("idSite"));
      result.setIdClient(record.getString("idClient"));
      result.setIdInboundDelivery(record.getString("idInboundDelivery"));
      result.setNumItem(record.getLong("numItem"));
      result.setNumConsec(record.getLong("numConsec"));
      result.setTypText(record.getString("typText"));
      result.setTxtInboundDelivery(record.getString("txtInboundDelivery"));

      return result;
    }).sorted(compare).collect(Collectors.toList());

    assertEquals(count, gr300SearchDeliveryItemTextResults.size(), "count");
  }

  @And("GR300_SEARCH_DELIVERY_ITEM_TEXT result record {int} has: idSite = {StringExt}, idClient = {StringExt}, idInboundDelivery = {StringExt}, numItem = {LongExt}, numConsec = {LongExt}, typTxt = {StringExt}, txtInboundDeliveryItem = {StringExt}")
  public void verifySearchDeliveryItemTextRecord(int index, GherkinType<String> idSite, GherkinType<String> idClient,
      GherkinType<String> idInboundDelivery, GherkinType<Long> numItem, GherkinType<Long> numConsec, GherkinType<String> typTxt,
      GherkinType<String> txtInboundDeliveryItem) {
    idInboundDelivery.setGetterForKey(grDeliveryDataHandler.idGrInboundDeliveryGetter);

    GR300SearchDeliveryItemTextOutput record = gr300SearchDeliveryItemTextResults.get(index);

    //@formatter:off
    assertAll(
        () -> idSite.assertEquality(record.getIdSite(), "idSite"),
        () -> idClient.assertEquality(record.getIdClient(), "idClient"),
        () -> idInboundDelivery.assertEquality(record.getIdInboundDelivery(), "idInboundDelivery"),
        () -> numItem.assertEquality(record.getNumItem(), "numItem"),
        () -> numConsec.assertEquality(record.getNumConsec(), "numConsec"),
        () -> typTxt.assertEquality(record.getTypText(), "typTxt"),
        () -> txtInboundDeliveryItem.assertEquality(record.getTxtInboundDelivery(), "txtInboundDeliveryItem")
    );    
    //@formatter:on
  }

  @Then("GR300_SEARCH_CLIENTS finds {int} record(s)")
  public void verifySearchClient(int count) {
    Comparator<GR300SearchClientOutput> compare = Comparator.comparing(GR300SearchClientOutput::getIdSite)
        .thenComparing(GR300SearchClientOutput::getIdClient).thenComparing(GR300SearchClientOutput::getName);

    gr300SearchClientResults = webserviceClient.verifySuccess().getOutput().stream().map(element -> {
      FieldExtractor record = new FieldExtractor(element);
      GR300SearchClientOutput result = new GR300SearchClientOutput();

      result.setIdSite(record.getString("idSite"));
      result.setIdClient(record.getString("idClient"));
      result.setName(record.getString("name"));

      return result;
    }).sorted(compare).collect(Collectors.toList());

    assertEquals(count, gr300SearchClientResults.size());
  }

  @And("GR300_SEARCH_CLIENTS result record {int} has: idSite = {StringExt}, idClient = {StringExt}, name = {StringExt}")
  public void verifySearchClientRecord(int index, GherkinType<String> idSite, GherkinType<String> idClient, GherkinType<String> name) {
    GR300SearchClientOutput record = gr300SearchClientResults.get(index);

    //@formatter:off
    assertAll(
        () -> idSite.assertEquality(record.getIdSite(), "idSite"),
        () -> idClient.assertEquality(record.getIdClient(), "idClient"),
        () -> name.assertEquality(record.getName(), "name")
    );    
    //@formatter:on
  }

  @Then("GR300_SEARCH_ARTICLES finds {int} record(s)")
  public void verifySearchArticle(int count) {
    Comparator<ArtSearchArticleOutput> compare = Comparator.comparing(ArtSearchArticleOutput::getIdClient)
        .thenComparing(ArtSearchArticleOutput::getIdArticle);

    artSearchArticleResults = webserviceClient.verifySuccess().getOutput().stream().map(element -> {
      FieldExtractor record = new FieldExtractor(element);
      ArtSearchArticleOutput result = new ArtSearchArticleOutput();

      result.setIdClient(record.getString("idClient"));
      result.setIdArticle(record.getString("idArticle"));
      result.setCodeEan(record.getString("codeEan"));
      result.setTxtLabel(record.getString("txtLabel"));
      result.setUnitSock(record.getString("unitSock"));
      result.setFlgArtvar(record.getString("flgArtvar"));
      result.setFlgBatch(record.getString("flgBatch"));
      result.setFlgBbd(record.getString("flgBbd"));

      return result;
    }).sorted(compare).collect(Collectors.toList());

    assertEquals(count, artSearchArticleResults.size());
  }

  @And("GR300_SEARCH_ARTICLES result record {int} has: idClient = {StringExt}, idArticle = {StringExt}, codeEan = {StringExt}, txtLabel = {StringExt}, unitSock = {StringExt}, flgArtvar = {BooleanExt}, flgBatch = {BooleanExt}, flgBbd = {BooleanExt}")
  public void verifySearchArticleRecord(int index, GherkinType<String> idClient, GherkinType<String> idArticle, GherkinType<String> codeEan,
      GherkinType<String> txtLabel, GherkinType<String> unitSock, GherkinType<Boolean> flgArtvar, GherkinType<Boolean> flgBatch,
      GherkinType<Boolean> flgBbd) {
    ArtSearchArticleOutput record = artSearchArticleResults.get(index);

    //@formatter:off
    assertAll(
        () -> idClient.assertEquality(record.getIdClient(), "idClient"),
        () -> idArticle.assertEquality(record.getIdArticle(), "idArticle"),
        () -> codeEan.assertEquality(record.getCodeEan(), "codeEan"),
        () -> txtLabel.assertEquality(record.getTxtLabel(), "txtLabel"),
        () -> unitSock.assertEquality(record.getUnitSock(), "unitSock"),
        () -> flgArtvar.assertEquality(record.getFlgArtvar().equals("1"), "flgArtvar"),
        () -> flgBatch.assertEquality(record.getFlgBatch().equals("1"), "flgBatch"),
        () -> flgBbd.assertEquality(record.getFlgBbd().equals("1"), "flgBbd")
    );    
    //@formatter:on    
  }

  @Then("GR300_SEARCH_VEHICLES finds {int} record(s)")
  public void verifySearchVehicle(int count) {
    Comparator<GR300SearchVehicleOutput> compare = Comparator.comparing(GR300SearchVehicleOutput::getIdSite)
        .thenComparing(GR300SearchVehicleOutput::getIdTransportVehicle);

    gr300SearchVehicleResults = webserviceClient.verifySuccess().getOutput().stream().map(element -> {
      FieldExtractor record = new FieldExtractor(element);
      GR300SearchVehicleOutput result = new GR300SearchVehicleOutput();

      result.setIdSite(record.getString("idSite"));
      result.setIdTransportVehicle(record.getString("idTransportVehicle"));
      result.setTypTransportVehicle(record.getString("typTransportVehicle"));
      result.setNumTourExt(record.getLong("numTourExt"));
      result.setStat(record.getString("stat"));
      result.setNameDriver(record.getString("nameDriver"));
      result.setTsArrival(record.getDate("tsArrival"));
      result.setTsDock(record.getDate("tsDock"));
      result.setTsStart(record.getDate("tsStart"));
      result.setTsEnd(record.getDate("tsEnd"));
      result.setTsDeparture(record.getDate("tsDeparture"));
      result.setTruckLicensePlate(record.getString("truckLicensePlate"));

      return result;
    }).sorted(compare).collect(Collectors.toList());

    assertEquals(count, gr300SearchVehicleResults.size());
  }

  @And("GR300_SEARCH_VEHICLES result record {int} has: idSite = {StringExt}, idTransportVehicle = {StringExt}, typTransportVehicle = {StringExt}, numTourExt = {LongExt}, stat = {StringExt}, nameDriver = {StringExt}, tsArrival = {DateExt}, tsDock = {DateExt}, tsStart = {DateExt}, tsEnd = {DateExt}, tsDeparture = {DateExt}, truckLicensePlate = {StringExt}")
  public void verifySearchVehicleRecord(int index, GherkinType<String> idSite, GherkinType<String> idTransportVehicle,
      GherkinType<String> typTransportVehicle, GherkinType<Long> numTourExt, GherkinType<String> stat, GherkinType<String> nameDriver,
      GherkinType<Date> tsArrival, GherkinType<Date> tsDock, GherkinType<Date> tsStart, GherkinType<Date> tsEnd, GherkinType<Date> tsDeparture,
      GherkinType<String> truckLicensePlate) {
    GR300SearchVehicleOutput record = gr300SearchVehicleResults.get(index);

    //@formatter:off
    cucumberReport.setMessage("idSite = "                + record.getIdSite()
                            + " , idTransportVehicle = " + record.getIdTransportVehicle()
                            + " , typTransportVehicle = "+ record.getTypTransportVehicle()
                            + " , numTourExt = "         + record.getNumTourExt()
                            + " , stat = "               + record.getStat()
                            + " , nameDriver = "         + record.getNameDriver()
                            + " , tsArrival = "          + record.getTsArrival()
                            + " , tsDock = "             + record.getTsDock()
                            + " , tsStart = "            + record.getTsStart()
                            + " , tsEnd = "              + record.getTsEnd()
                            + " , tsDeparture = "        + record.getTsDeparture()
                            + " , truckLicensePlate = "  + record.getTruckLicensePlate()
        );
    assertAll(
        () -> idSite.assertEquality(record.getIdSite(), "idSite"),
        () -> idTransportVehicle.assertEquality(record.getIdTransportVehicle(), "idTransportVehicle"),
        () -> typTransportVehicle.assertEquality(record.getTypTransportVehicle(), "typTransportVehicle"),
        () -> numTourExt.assertEquality(record.getNumTourExt(), "numTourExt"),
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> nameDriver.assertEquality(record.getNameDriver(), "nameDriver"),
        () -> tsArrival.assertEquality(record.getTsArrival(), "tsArrival"),
        () -> tsDock.assertEquality(record.getTsDock(), "tsDock"),
        () -> tsStart.assertEquality(record.getTsStart(), "tsStart"),
        () -> tsEnd.assertEquality(record.getTsEnd(), "tsEnd"),
        () -> tsDeparture.assertEquality(record.getTsDeparture(), "tsDeparture"),
        () -> truckLicensePlate.assertEquality(record.getTruckLicensePlate(), "truckLicensePlate")
    );    
    //@formatter:on    
  }

  @Then("GR300_SEARCH_SUPPLIERS finds {int} record(s)")
  public void verifySearchSupplier(int count) {
    Comparator<GR300SearchSupplierOutput> compare = Comparator.comparing(GR300SearchSupplierOutput::getIdClient)
        .thenComparing(GR300SearchSupplierOutput::getIdSupplier);

    gr300SearchSupplierResults = webserviceClient.verifySuccess().getOutput().stream().map(element -> {
      FieldExtractor record = new FieldExtractor(element);
      GR300SearchSupplierOutput result = new GR300SearchSupplierOutput();

      result.setIdClient(record.getString("idClient"));
      result.setIdSupplier(record.getString("idSupplier"));
      result.setName(record.getString("name"));

      return result;
    }).sorted(compare).collect(Collectors.toList());

    assertEquals(count, gr300SearchSupplierResults.size());
  }

  @And("GR300_SEARCH_SUPPLIERS result record {int} has: idClient = {StringExt}, idSupplier = {StringExt}, name = {StringExt}")
  public void verifySearchSupplierRecord(int index, GherkinType<String> idClient, GherkinType<String> idSupplier, GherkinType<String> name) {
    GR300SearchSupplierOutput record = gr300SearchSupplierResults.get(index);

    //@formatter:off
    assertAll(
        () -> idClient.assertEquality(record.getIdClient(), "idClient"),
        () -> idSupplier.assertEquality(record.getIdSupplier(), "idSupplier"),
        () -> name.assertEquality(record.getName(), "name")
    );    
    //@formatter:on    
  }

}
