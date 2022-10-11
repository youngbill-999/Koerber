package com.inconso.bend.inwmsx.it.transport;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.transport.pers.model.TcsRoutingVersion;
import com.inconso.bend.transport.pers.model.TcsTask;
import com.inconso.bend.transport.pers.model.TcsTaskTarget;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class TransportDataHandler {

  @Autowired
  private CucumberReport                 cucumberReport;

  private Map<String, TcsTask>           tcsTasks           = new HashMap<String, TcsTask>();
  private Map<String, TcsTaskTarget>     tcsTaskTargets     = new HashMap<String, TcsTaskTarget>();
  private Map<String, TcsRoutingVersion> tcsRoutingVersions = new HashMap<>();

  public TcsTask getTcsTask(String key) {
    if (!tcsTasks.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return tcsTasks.get(key);
  }

  public void putTcsTask(String key, TcsTask value) {
    cucumberReport.setMessage(String.format("putTcsTask(%s, %s)", key, value));
    tcsTasks.put(key, value);
  }

  public TcsTaskTarget getTcsTaskTarget(String key) {
    if (!tcsTaskTargets.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return tcsTaskTargets.get(key);
  }

  public void putTcsTaskTarget(String key, TcsTaskTarget value) {
    cucumberReport.setMessage(String.format("putTcsTaskTarget(%s, %s)", key, value));
    tcsTaskTargets.put(key, value);
  }

  public TcsRoutingVersion getTcsRoutingVersion(String key) {
    if (!tcsRoutingVersions.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return tcsRoutingVersions.get(key);
  }

  public void putTcsRoutingVersion(String key, TcsRoutingVersion value) {
    cucumberReport.setMessage(String.format("putTcsRoutingVersion(%s, %s)", key, value));
    tcsRoutingVersions.put(key, value);
  }

}
