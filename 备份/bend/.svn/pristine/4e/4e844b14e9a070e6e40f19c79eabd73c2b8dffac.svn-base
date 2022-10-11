package com.inconso.bend.inwmsx.it.general;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.gibase.pers.gen.GiOrderItemPk;
import com.inconso.bend.grbase.pers.gen.GrReceivingItemPk;
import com.inconso.bend.inwmsx.it.gibase.GiBaseDataHandler;
import com.inconso.bend.inwmsx.it.grbase.GrBaseDataHandler;
import com.inconso.bend.inwmsx.it.transport.TransportDataHandler;
import com.inconso.bend.transport.pers.gen.TcsTaskTargetPk;
import com.inconso.bend.wmsbase.service.api.WmsBaseDesc;
import com.inconso.bend.wmsbase.service.api.WmsBaseSeqInput;
import com.inconso.bend.workctrplan.service.api.WorkctrPlanCreateAssignmentInput;
import com.inconso.bend.workctrplan.service.api.WorkctrPlanDesc;
import com.inconso.bend.workctrplan.service.api.WorkctrPlanToReferenceInput;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class GeneralHelper {

  public static final String   SCOPE_CUCUMBER_GLUE = "cucumber-glue";

  @Autowired
  private WebserviceClient     webserviceClient;

  @Autowired
  private CucumberReport       cucumberReport;

  @Autowired
  private TransportDataHandler transportDataHandler;

  @Autowired
  private GrBaseDataHandler    grBaseDataHandler;

  @Autowired
  private GiBaseDataHandler    giBaseDataHandler;

  private String               globalIdSite        = null;
  private String               globalIdClient      = null;

  private LocalDateTime        timer               = null;
  private Duration             duration            = null;

  public static Date parseJsonDate(String input) throws ParseException {
    Date result = null;

    if (input != null) {
      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX");
      Calendar calendar = Calendar.getInstance();
      calendar.setTime(format.parse(input));
      result = calendar.getTime();
    }

    return result;
  }

  public static String makeMapKeyWithIx(String key, int ix) {
    return key + "[" + ix + "]";
  }

  @Then("WEBSERVICE fails: error = {string}")
  public void verifyWebserviceFailure(String errorCode) {
    webserviceClient.verifyFailure();
    assertEquals(errorCode, webserviceClient.getErrorCode(), webserviceClient.getErrorMessage());
  }

  @Then("WEBSERVICE succeeds/succeeded")
  public void verifyWebserviceSuccess() {
    webserviceClient.verifySuccess();
  }

  @Then("{long} sec is/are passed")
  public void waiting(long time) {
    try {
      Thread.sleep(time * 1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
  }

  @Then("Report time stamp")
  public void reportTimeStamp() {
    Calendar now = Calendar.getInstance();
    cucumberReport.setMessage("ts: " + now.get(Calendar.HOUR_OF_DAY) + ":" + now.get(Calendar.MINUTE) + ":" + now.get(Calendar.SECOND) + "."
        + now.get(Calendar.MILLISECOND));
  }

  @Given("Start timer")
  public void startTimer() {
    if (timer != null) throw new RuntimeException("Timer cannot be used!");
    timer = LocalDateTime.now();
    cucumberReport.setMessage("Timer started at " + timer.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
  }

  @Then("Stop timer")
  public void stopTimer() {
    if (timer == null) throw new RuntimeException("Timer was not set!");
    LocalDateTime now = LocalDateTime.now();
    duration = Duration.between(timer, now);
    timer = null;
    cucumberReport
        .setMessage("Timer stopped at " + now.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) + " after " + duration.getSeconds() + " seconds.");
  }

  @Then("timed value is smaller than {long} {string}")
  public void timedValueIsSmallerThan(Long time, String unit) {

    long durationInUnit = 0L;
    switch (unit) {
    case "min":
      durationInUnit = duration.toMinutes();
      break;
    case "sec":
    default:
      durationInUnit = duration.toSeconds();
      break;
    }

    cucumberReport.setMessage("Timed value is " + durationInUnit + " " + unit);
    assertTrue(time.compareTo(durationInUnit) > 0);

  }

  @Given("set global: idSite = {String}, idClient = {String}")
  public void setGlobal(String idSite, String idClient) {
    globalIdSite = idSite;
    globalIdClient = idClient;
  }

  public String getIdSite() {
    return globalIdSite;
  }

  public String getIdClient() {
    return globalIdClient;
  }

  // uses a local WebserviceClient
  public String getNextSequenceNumber(String sequence) {
    // sequenceUtils.getNext("GI_SEQ_ID_ORDER");
    String result;
    WebserviceClient webserviceClient = new WebserviceClient();

    ServiceInput<WmsBaseSeqInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", getIdSite());

    WmsBaseSeqInput wmsBaseSeqInput = new WmsBaseSeqInput();
    wmsBaseSeqInput.setSequence(sequence);

    serviceInput.setData(wmsBaseSeqInput);
    webserviceClient.call(WmsBaseDesc.SERVICE, WmsBaseDesc.SEQ_GET_NEXT_WITH_INTERNAL_PREFIX, serviceInput);

    FieldExtractor payload = new FieldExtractor(webserviceClient.verifySuccess().getData());

    result = payload.getString("numSequence");
    return result;
  }

  public void verifyReference(String keyObject, String typRef, String[] ref) {
    assertEquals(typRef, ref[0], "typRef");

    //@formatter:off
    switch (typRef) {
    case "TCS_TASK_TARGET":
      TcsTaskTargetPk taskTargetPk = transportDataHandler.getTcsTaskTarget(keyObject).getTcsTaskTargetPk();    
      assertAll(
          () -> assertEquals(taskTargetPk.getIdSite(), ref[1], "idSite"),
          () -> assertEquals(taskTargetPk.getIdTask(), ref[2], "idTask"),
          () -> assertEquals(taskTargetPk.getNumTarget().toString(), ref[3], "numTarget"),
          () -> assertNull(ref[4]),
          () -> assertNull(ref[5]),
          () -> assertNull(ref[6])
      );
      break;

    case "GR_RECEIVING_ITEM":
      GrReceivingItemPk receivingItemPk = grBaseDataHandler.getReceivingItem(keyObject).getGrReceivingItemPk();      
      assertAll(
          () -> assertEquals(receivingItemPk.getIdSite(), ref[1], "idSite"),
          () -> assertEquals(receivingItemPk.getIdClient(), ref[2], "idClient"),
          () -> assertEquals(receivingItemPk.getIdGoodsReceipt(), ref[3], "idGoodsReceipt"),
          () -> assertEquals(receivingItemPk.getNumItem().toString(), ref[4], "numItem"),
          () -> assertNull(ref[5]),
          () -> assertNull(ref[6])
      );
      break;

    case "GI_ORDER_ITEM":
      GiOrderItemPk giOrderItemPk = giBaseDataHandler.getGiOrderItem(keyObject).getGiOrderItemPk();      
      assertAll(
          () -> assertEquals(giOrderItemPk.getIdSite(), ref[1], "idSite"),
          () -> assertEquals(giOrderItemPk.getIdClient(), ref[2], "idClient"),
          () -> assertEquals(giOrderItemPk.getIdOrder(), ref[3], "idOrder"),
          () -> assertEquals(giOrderItemPk.getNumPartialOrder().toString(), ref[4], "numPartialOrder"),
          () -> assertEquals(giOrderItemPk.getNumItem().toString(), ref[5], "numItem"),
          () -> assertNull(ref[6])
      );
      break;
      
    default:
      throw new IllegalArgumentException();
    }
    //@formatter:on
  }

  public void createAssignment(String idWorkcenter, long priority, List<WorkctrPlanToReferenceInput> references) {
    ServiceInput<WorkctrPlanCreateAssignmentInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", getIdSite());

    WorkctrPlanCreateAssignmentInput workctrPlanCreateAssignmentInput = new WorkctrPlanCreateAssignmentInput();
    workctrPlanCreateAssignmentInput.setIdSite(getIdSite());
    workctrPlanCreateAssignmentInput.setIdWorkcenter(idWorkcenter);
    workctrPlanCreateAssignmentInput.setPriority(priority);
    workctrPlanCreateAssignmentInput.setReferences(references);
    serviceInput.setData(workctrPlanCreateAssignmentInput);

    webserviceClient.call(WorkctrPlanDesc.SERVICE, WorkctrPlanDesc.CREATE_ASSIGNMENT, serviceInput);
  }

}
