package com.inconso.bend.inwmsx.it.bpsched;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.bpsched.pers.model.BpsProcessRecord;
import com.inconso.bend.bpsched.pers.model.BpsProcessStep;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class BPSchedDataHandler {

  @Autowired
  private CucumberReport                cucumberReport;

  private Map<String, BpsProcessRecord> processRecords = new HashMap<String, BpsProcessRecord>();
  private Map<String, BpsProcessStep>   processSteps   = new HashMap<String, BpsProcessStep>();

  public BpsProcessRecord getProcessRecord(String key) {
    if (!processRecords.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return processRecords.get(key);
  }

  public void putProcessRecord(String key, BpsProcessRecord value) {
    cucumberReport.setMessage(String.format("putProcessRecord(%s, %s)", key, value));
    processRecords.put(key, value);
  }

  public BpsProcessStep getProcessStep(String key) {
    if (!processSteps.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return processSteps.get(key);
  }

  public void putProcessStep(String key, BpsProcessStep value) {
    cucumberReport.setMessage(String.format("putProcessStep(%s, %s)", key, value));
    processSteps.put(key, value);
  }

}
