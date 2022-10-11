package com.inconso.bend.inwmsx.it.grbase;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.advice.pers.gen.AvAdvicePk;
import com.inconso.bend.advice.pers.rep.AvAdviceRep;
import com.inconso.bend.advice.service.api.AdviceDesc;
import com.inconso.bend.advice.service.api.ReleaseAdviceInput;
import com.inconso.bend.advice.service.api.ReleaseAdviceListInput;
import com.inconso.bend.advice.service.api.SubseqBookAVInput;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;

public class AdviceWebserviceCaller {

  @Autowired
  private WebserviceClient      webserviceClient;

  @Autowired
  private GeneralHelper         generalHelper;

  @Autowired
  private GrDeliveryDataHandler grDeliveryDataHandler;
  @Autowired
  private AvAdviceRep           avAdviceRep;

  @Then("SUBSEQ_BOOKING_AV is called for advice {string}")
  @Transactional(readOnly = true)
  public void closeAdviceWithShortfall(String key) {
    AvAdvicePk avAdvicePk = grDeliveryDataHandler.getAvAdvice(key).getAvAdvicePk();
    SubseqBookAVInput subseqBookingAvInput = new SubseqBookAVInput();
    subseqBookingAvInput.setIdAdvice(avAdvicePk.getIdAdvice());
    subseqBookingAvInput.setIdClient(avAdvicePk.getIdClient());

    ServiceInput<SubseqBookAVInput> serviceInput = new ServiceInput<SubseqBookAVInput>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());
    serviceInput.setData(subseqBookingAvInput);

    webserviceClient.call(AdviceDesc.SERVICE, AdviceDesc.SUBSEQ_BOOKING_AV, serviceInput);
  }

  @And("advice {string} was successfully released")
  @Transactional(readOnly = true)
  public void releaseAdvice(String key) {
    AvAdvicePk avAdvicePk = grDeliveryDataHandler.getAvAdvice(key).getAvAdvicePk();

    ServiceInput<ReleaseAdviceListInput> serviceInput = new ServiceInput<ReleaseAdviceListInput>();
    ReleaseAdviceInput relAdviceInput = new ReleaseAdviceInput(avAdvicePk.getIdClient(), avAdvicePk.getIdAdvice());
    ArrayList<ReleaseAdviceInput> relAdviceInputList = new ArrayList<ReleaseAdviceInput>();
    relAdviceInputList.add(relAdviceInput);
    ReleaseAdviceListInput relAdviceListInput = new ReleaseAdviceListInput();
    relAdviceListInput.setReleaseAdviceList(relAdviceInputList);

    serviceInput.setData(relAdviceListInput);
    serviceInput.setContext("SITE", generalHelper.getIdSite());
    webserviceClient.call(AdviceDesc.SERVICE, AdviceDesc.RELEASE_ADVICE_EP, serviceInput);
    webserviceClient.verifySuccess();

    assertEquals("10", avAdviceRep.findOne(avAdvicePk).getStat());
  }
}
