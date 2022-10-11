package com.inconso.bend.inwmsx.it.packing;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.pabase.pers.model.PaPackage;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class PackingDataHandler {

  @Autowired
  private CucumberReport         cucumberReport;

  private Map<String, PaPackage> paPackage = new HashMap<String, PaPackage>();

  public PaPackage getPaPackage(String key) {
    if (!paPackage.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return paPackage.get(key);
  }

  public void putPaPackage(String key, PaPackage value) {
    cucumberReport.setMessage(String.format("putPaPackage(%s, %s)", key, value));
    paPackage.put(key, value);
  }

}
