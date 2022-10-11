package com.inconso.bend.inwmsx.it.general;

import java.util.HashMap;
import java.util.Map;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.gdl.service.api.GdlProcessingInput;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class MdtDataHandler {

  private Map<String, GdlProcessingInput> gdlProcessingInput = new HashMap<String, GdlProcessingInput>();

  public GdlProcessingInput getGdlProcessingInput(String key) {
    if (!gdlProcessingInput.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return gdlProcessingInput.get(key);
  }

  public void putGdlProcessingInput(String key, GdlProcessingInput value) {
    gdlProcessingInput.put(key, value);
  }

}
