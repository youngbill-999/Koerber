package com.inconso.bend.inwmsx.it.general;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import io.cucumber.java.AfterStep;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;

public class CucumberHooks {

  private static final String  IT_SERVER                 = "ifbbend06";
  private static final boolean IS_IT_SERVER              = isItServer();
  private static final boolean IS_IMPLICIT_SETUP         = false;
  private static final int     HOOK_ORDER_SETUP_TEARDOWN = 0;
  private static SetupOption   currentSetup              = SetupOption.NONE;

  @Autowired
  private CucumberReport       cucumberReport;

  public enum SetupOption {
    NONE, DEFAULT
  }

  /**
   * Checks if current environment is the integration test environment specified in "IT_SERVER"
   */
  private static boolean isItServer() {
    String springDatasourceUrl = System.getProperty("spring.datasource.url");

    Pattern pattern = Pattern.compile("//" + IT_SERVER + "(?=\\b)");
    Matcher matcher = pattern.matcher(springDatasourceUrl);

    boolean result = matcher.find();
    return result;
  }

  private static void setup(SetupOption setupOption) {
    // ToDo
  }

  /**
   * Ensures that the current environment is "integration test" before setup in order to avoid accidentally messing up the database in other
   * environments.
   */
  private static void setupIfItServer(SetupOption setupOption) {
    if (IS_IT_SERVER) {
      currentSetup = setupOption;
      setup(currentSetup);
    }
  }

  @Before(value = "not @setup", order = HOOK_ORDER_SETUP_TEARDOWN)
  public void setupImplicit() {
    if (IS_IMPLICIT_SETUP || currentSetup != SetupOption.DEFAULT) {
      setupIfItServer(SetupOption.DEFAULT);
    }
  }

  @Before(value = "@setup and @setupDefault", order = HOOK_ORDER_SETUP_TEARDOWN)
  public void setupDefault() {
    setupIfItServer(SetupOption.DEFAULT);
  }

  @AfterStep
  public void output(Scenario scenario) {
    cucumberReport.logMessage(scenario);
  }

}
