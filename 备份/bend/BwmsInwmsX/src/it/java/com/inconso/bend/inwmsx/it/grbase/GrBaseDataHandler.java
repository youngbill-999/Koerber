package com.inconso.bend.inwmsx.it.grbase;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.grbase.pers.gen.GrReceivingPk;
import com.inconso.bend.grbase.pers.model.GrReceiving;
import com.inconso.bend.grbase.pers.model.GrReceivingItem;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType.GetterFunction;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class GrBaseDataHandler {

  public final GetterFunction<String>  idGoodsReceiptGetter = key -> getReceiving(key).getGrReceivingPk().getIdGoodsReceipt();

  @Autowired
  private CucumberReport               cucumberReport;

  private Map<String, GrReceiving>     receivings           = new HashMap<String, GrReceiving>();
  private Map<String, GrReceivingItem> receivingItems       = new HashMap<String, GrReceivingItem>();
  private Map<GrReceivingPk, Long>     receivingsItemCount  = new HashMap<GrReceivingPk, Long>();

  public GrReceiving getReceiving(String key) {
    if (!receivings.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return receivings.get(key);
  }

  public void putReceiving(String key, GrReceiving value) {
    cucumberReport.setMessage(String.format("putReceiving(%s, %s)", key, value));
    receivings.put(key, value);
  }

  public GrReceivingItem getReceivingItem(String key) {
    if (!receivingItems.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return receivingItems.get(key);
  }

  public void putReceivingItem(String key, GrReceivingItem value) {
    cucumberReport.setMessage(String.format("putReceivingItem(%s, %s)", key, value));
    receivingItems.put(key, value);
  }

  // ReceivingItemCount only for bookkeeping purposes - see verifyGrReceivingSuccessful()

  public long getReceivingItemCount(GrReceivingPk key) {
    long result;

    if (!receivingsItemCount.containsKey(key)) {
      result = 0L;
    } else {
      result = receivingsItemCount.get(key);
    }
    return result;
  }

  public void putReceivingItemCount(GrReceivingPk key, Long value) {
    receivingsItemCount.put(key, value);
  }

  public boolean containsReceivingItemCount(GrReceivingPk key) {
    return receivingsItemCount.containsKey(key);
  }

}
