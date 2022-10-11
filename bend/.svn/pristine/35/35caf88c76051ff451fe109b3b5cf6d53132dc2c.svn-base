package com.inconso.bend.inwmsx.it.general;

import java.io.IOException;
import java.io.InputStream;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;

/**
 * 
 * Class to log the required message after a step to the dashboard 
 * 
 */

/**
 * @author SKAYA
 *
 */

@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class CucumberReport {

  private static final Logger LOG     = LoggerFactory.getLogger(InventoryDataHandler.class);

  private String              message = null;

  public void setMessage(String msg) {
    LOG.info(msg);

    if (this.message != null) {
      this.message = this.message.concat("\n").concat(msg);
    } else {
      this.message = msg;
    }
  }

  public void logMessage(Scenario scenario) {
    if (this.message != null) {
      scenario.log(this.message);
      this.message = null;
    }
  }

  @Before
  public void addImage(Scenario scenario) throws IOException, InterruptedException {
    if (scenario.getName().startsWith("Picking in ENTGR_01/ENTGR_04-ENT_H1_04")) {
      InputStream is = getClass().getClassLoader().getResourceAsStream("abc3.jpg");
      byte[] fileContent = is.readAllBytes();
      scenario.attach(fileContent, "image/png", "prettypicture");
    }
  }

}
