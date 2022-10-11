package com.inconso.bend.inwmsx.it.stocktaking;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class StocktakingDataHandler {

  @Autowired
  private CucumberReport      cucumberReport;

  private Map<String, String> stockTakeListIds = new HashMap<String, String>();

  public String getStockTakeListId(String key) {
    if (!stockTakeListIds.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return stockTakeListIds.get(key);
  }

  public void putStockTakeListId(String key, String idList) {
    cucumberReport.setMessage(String.format("putStockTakeListId(%s, %s)", key, idList));
    stockTakeListIds.put(key, idList);
  }

  public Map<String, String> getAllStockTakeListIds() {
    return stockTakeListIds;
  }

}
