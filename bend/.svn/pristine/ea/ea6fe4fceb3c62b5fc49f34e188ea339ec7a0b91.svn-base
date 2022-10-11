package com.inconso.bend.inwmsx.it.topology;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType.GetterFunction;
import com.inconso.bend.topology.pers.model.TopStorageLocation;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class TopologyDataHandler {

  public final GetterFunction<String>     storageAreaGetter     = key -> getTopStorageLocation(key).getTopStorageLocationPk().getStorageArea();
  public final GetterFunction<String>     storageLocationGetter = key -> getTopStorageLocation(key).getTopStorageLocationPk().getStorageLocation();

  @Autowired
  private CucumberReport                  cucumberReport;

  private Map<String, TopStorageLocation> topStorageLocations   = new HashMap<String, TopStorageLocation>();

  public TopStorageLocation getTopStorageLocation(String key) {
    if (!topStorageLocations.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return topStorageLocations.get(key);
  }

  public void putTopStorageLocation(String key, TopStorageLocation value) {
    cucumberReport.setMessage(String.format("putTopStorageLocation(%s, %s)", key, value));
    topStorageLocations.put(key, value);
  }

}
