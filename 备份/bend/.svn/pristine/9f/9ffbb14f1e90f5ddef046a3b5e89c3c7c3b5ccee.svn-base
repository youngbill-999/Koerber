package com.inconso.bend.inwmsx.it.grbase;

import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Component;
import com.inconso.bend.grbase.pers.gen.GrReceivingPk;

// No @Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE) - share state over all scenarios
@Component
public class GrBaseGlobalDataHandler {

  private Map<GrReceivingPk, Long> receivingsItemCount = new HashMap<GrReceivingPk, Long>();

  // ReceivingItemCount only for bookkeeping purposes - see verifyGrReceivingSuccessful()

  public void putReceivingItemCount(GrReceivingPk key, Long value) {
    receivingsItemCount.put(key, value);
  }

  public long getReceivingItemCount(GrReceivingPk key) {
    long result;

    if (!receivingsItemCount.containsKey(key)) {
      result = 0L;
    } else {
      result = receivingsItemCount.get(key);
    }
    return result;
  }

}
