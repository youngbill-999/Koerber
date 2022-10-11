package com.inconso.bend.inwmsx.it.replenishment;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.repbase.pers.model.RepReplenishmentRequest;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class ReplenishmentDataHandler {

  @Autowired
  private CucumberReport                       cucumberReport;

  private Map<String, RepReplenishmentRequest> repReplenishmentRequest = new HashMap<String, RepReplenishmentRequest>();

  public RepReplenishmentRequest getRepReplenishmentRequest(String key) {
    if (!repReplenishmentRequest.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return repReplenishmentRequest.get(key);
  }

  public void putRepReplenishmentRequest(String key, RepReplenishmentRequest value) {
    cucumberReport.setMessage(String.format("putRepReplenishmentRequest(%s, %s)", key, value));
    repReplenishmentRequest.put(key, value);
  }

}
