package com.inconso.bend.inwmsx.it.grbase;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.advice.pers.model.AvAdvice;
import com.inconso.bend.advice.service.api.GR300UpdateDeliveryItemAdviceInput;
import com.inconso.bend.grbase.pers.model.GrInboundDelivery;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryItemInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryItemTextInput;
import com.inconso.bend.grbase.service.api.GR300UpdateDeliveryTextInput;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType.GetterFunction;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class GrDeliveryDataHandler {

  public final GetterFunction<String>        idGrInboundDeliveryGetter = key -> getGrInboundDelivery(key).getGrInboundDeliveryPk()
      .getIdInboundDelivery();
  public final GetterFunction<String>        idAvAdviceGetter          = key -> getAvAdvice(key).getAvAdvicePk().getIdAdvice();

  @Autowired
  private CucumberReport                     cucumberReport;

  private Map<String, GrInboundDelivery>     grInboundDeliveries       = new HashMap<String, GrInboundDelivery>();
  private Map<String, AvAdvice>              avAdvices                 = new HashMap<String, AvAdvice>();

  private GR300UpdateDeliveryInput           gr300UpdateDeliveryInput;
  private GR300UpdateDeliveryTextInput       gr300UpdateDeliveryTextInput;
  private GR300UpdateDeliveryItemInput       gr300UpdateDeliveryItemInput;
  private GR300UpdateDeliveryItemAdviceInput gr300UpdateDeliveryItemAdviceInput;
  private GR300UpdateDeliveryItemTextInput   gr300UpdateDeliveryItemTextInput;

  public GrInboundDelivery getGrInboundDelivery(String key) {
    if (!grInboundDeliveries.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return grInboundDeliveries.get(key);
  }

  public void putGrInboundDelivery(String key, GrInboundDelivery value) {
    cucumberReport.setMessage(String.format("putGrInboundDelivery(%s, %s)", key, value));
    grInboundDeliveries.put(key, value);
  }

  public AvAdvice getAvAdvice(String key) {
    if (!avAdvices.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return avAdvices.get(key);
  }

  public void putAvAdvice(String key, AvAdvice value) {
    cucumberReport.setMessage(String.format("putAvAdvice(%s, %s)", key, value));
    avAdvices.put(key, value);
  }

  public GR300UpdateDeliveryInput getGr300UpdateDeliveryInput() {
    return gr300UpdateDeliveryInput;
  }

  public void setGr300UpdateDeliveryInput(GR300UpdateDeliveryInput gr300UpdateDeliveryInput) {
    this.gr300UpdateDeliveryInput = gr300UpdateDeliveryInput;
  }

  public GR300UpdateDeliveryTextInput getGr300UpdateDeliveryTextInput() {
    return gr300UpdateDeliveryTextInput;
  }

  public void setGr300UpdateDeliveryTextInput(GR300UpdateDeliveryTextInput gr300UpdateDeliveryTextInput) {
    this.gr300UpdateDeliveryTextInput = gr300UpdateDeliveryTextInput;
  }

  public GR300UpdateDeliveryItemInput getGr300UpdateDeliveryItemInput() {
    return gr300UpdateDeliveryItemInput;
  }

  public void setGr300UpdateDeliveryItemInput(GR300UpdateDeliveryItemInput gr300UpdateDeliveryItemInput) {
    this.gr300UpdateDeliveryItemInput = gr300UpdateDeliveryItemInput;
  }

  public GR300UpdateDeliveryItemAdviceInput getGr300UpdateDeliveryItemAdviceInput() {
    return gr300UpdateDeliveryItemAdviceInput;
  }

  public void setGr300UpdateDeliveryItemAdviceInput(GR300UpdateDeliveryItemAdviceInput gr300UpdateDeliveryItemAdviceInput) {
    this.gr300UpdateDeliveryItemAdviceInput = gr300UpdateDeliveryItemAdviceInput;
  }

  public GR300UpdateDeliveryItemTextInput getGr300UpdateDeliveryItemTextInput() {
    return gr300UpdateDeliveryItemTextInput;
  }

  public void setGr300UpdateDeliveryItemTextInput(GR300UpdateDeliveryItemTextInput gr300UpdateDeliveryItemTextInput) {
    this.gr300UpdateDeliveryItemTextInput = gr300UpdateDeliveryItemTextInput;
  }

}
