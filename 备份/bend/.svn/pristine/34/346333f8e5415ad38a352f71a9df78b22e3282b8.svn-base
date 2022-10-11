package com.inconso.bend.inwmsx.it.general;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;
import org.junit.jupiter.api.function.Executable;
import org.springframework.beans.factory.annotation.Autowired;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.gdl.service.api.AutomatonData;
import com.inconso.bend.gdl.service.api.BendGdlDesc;
import com.inconso.bend.gdl.service.api.FieldAttribute;
import com.inconso.bend.gdl.service.api.FieldAttributeType;
import com.inconso.bend.gdl.service.api.GdlProcessingInput;
import com.inconso.bend.gdl.service.api.GdlProcessingOutput;
import com.inconso.bend.gdl.service.api.GdlRestartInput;
import com.inconso.bend.gdl.service.api.InputData;
import com.inconso.bend.gdl.service.api.OutputData;
import com.inconso.bend.gdl.service.api.ProxyState;
import com.inconso.bend.gdl.service.api.StateDescriptor;
import com.inconso.bend.gdl.service.api.StateHistoryDescriptor;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Then;

public class MdtHandler {

  @Autowired
  private WebserviceClient webserviceClient;

  @Autowired
  private MdtDataHandler   mdtDataHandler;

  @Autowired
  private GeneralHelper    generalHelper;

  @Autowired
  private GherkinTableCell gherkinTableCell;

  @Then("MDT RESTART {String} is called with: idTerminal = {String}")
  public void restart(String key, String idTerminal) {
    // restart

    StateDescriptor startStateDesc = new StateDescriptor();
    startStateDesc.setGraphName("MAIN_MENU");
    startStateDesc.setStateName("START");

    Map<String, String> inputparameter = new HashMap<String, String>();
    InputData inputData = new InputData();
    inputData.setInputparameter(inputparameter);

    GdlRestartInput gdlRestartInput = new GdlRestartInput();
    gdlRestartInput.setIdContext(generalHelper.getIdSite());
    gdlRestartInput.setIdTerminal(idTerminal);
    gdlRestartInput.setInputData(inputData);
    // serverUrl unnecessary for IT - no WildFly server in test environment
    gdlRestartInput.setServerUrl("");
    gdlRestartInput.setStartStateDesc(startStateDesc);

    ServiceInput<GdlRestartInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    serviceInput.setData(gdlRestartInput);
    webserviceClient.call(BendGdlDesc.SERVICE, BendGdlDesc.RESTART, serviceInput);
    GdlProcessingOutput gdlProcessingOutput = getGdlProcessingOutput();

    StateDescriptor currentState = gdlProcessingOutput.getCurrentStateDescriptor();
    StateDescriptor startState = gdlProcessingOutput.getCurrentStateDescriptor();

    // gdlProcessingInput init

    GdlProcessingInput gdlProcessingInput = new GdlProcessingInput();
    // copy sessionParameter and automatonData.stateHistory from output to input
    gdlProcessingInput.setSessionParameter(gdlProcessingOutput.getOutputData().getSessionParameter());
    gdlProcessingInput.getAutomatonData().setStateHistory(gdlProcessingOutput.getStateHistory());

    Map<String, String> sessionParameter = new HashMap<String, String>();
    AutomatonData automatonData = new AutomatonData();
    automatonData.setCurrentState(currentState);
    automatonData.setStartState(startState);

    gdlProcessingInput = new GdlProcessingInput();
    gdlProcessingInput.setAutomatonData(automatonData);
    gdlProcessingInput.setIdContext(generalHelper.getIdSite());
    gdlProcessingInput.setIdTerminal(idTerminal);
    gdlProcessingInput.setSessionParameter(sessionParameter);

    mdtDataHandler.putGdlProcessingInput(key, gdlProcessingInput);
  }

  @Then("MDT USER_INPUT {String} is called with: event = {String}, menue = {String}, inputparameter =")
  public void userInput(String key, String event, String menue, DataTable table) {
    GdlProcessingInput gdlProcessingInput = mdtDataHandler.getGdlProcessingInput(key);

    Map<String, String> inputparameter = new HashMap<String, String>();
    if (table != null) {
      table.asMap(String.class, String.class).forEach((k, v) -> inputparameter.put((String) k, gherkinTableCell.convertCell((String) v)));
    }

    InputData inputData = new InputData();
    inputData.setInputparameter(inputparameter);

    gdlProcessingInput.setEvent(event);
    gdlProcessingInput.setInputData(inputData);
    gdlProcessingInput.setMenue(menue);

    ServiceInput<GdlProcessingInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    serviceInput.setData(gdlProcessingInput);
    webserviceClient.call(BendGdlDesc.SERVICE, BendGdlDesc.USER_INPUT, serviceInput);
    GdlProcessingOutput gdlProcessingOutput = getGdlProcessingOutput();

    // copy sessionParameter and automatonData.stateHistory from output to input
    gdlProcessingInput.setSessionParameter(gdlProcessingOutput.getOutputData().getSessionParameter());
    gdlProcessingInput.getAutomatonData().setStateHistory(gdlProcessingOutput.getStateHistory());
    gdlProcessingInput.getAutomatonData().setCurrentState(gdlProcessingOutput.getCurrentStateDescriptor());
  }

  @Then("MDT USER_INPUT result has: graphName = {StringExt}, stateName = {StringExt}, dynamicSubgraph = {StringExt} and:")
  public void verifyState(GherkinType<String> graphName, GherkinType<String> stateName, GherkinType<String> dynamicSubgraph, DataTable table) {
    final String OUTPUTPARAMETER_DIALOG = "outputparameterDialog.";
    final String SESSION_PARAMETER = "sessionParameter.";

    GdlProcessingOutput gdlProcessingOutput = getGdlProcessingOutput();
    OutputData outputData = gdlProcessingOutput.getOutputData();

    Collection<Executable> executables = new ArrayList<Executable>();

    executables.add(() -> graphName.assertEquality(gdlProcessingOutput.getCurrentStateDescriptor().getGraphName(), "graphName"));
    executables.add(() -> stateName.assertEquality(gdlProcessingOutput.getCurrentStateDescriptor().getStateName(), "stateName"));
    executables.add(() -> dynamicSubgraph.assertEquality(outputData.getDynamicSubgraph(), "dynamicSubgraph"));

    // gdlProcessingOutput.getProxyState()
    // outputData.getFieldAttributes()

    Map<String, String> map = table.asMap(String.class, String.class);
    map.forEach((k, v) -> {
      String valueExpected = gherkinTableCell.convertCell(v);

      if (k.startsWith(OUTPUTPARAMETER_DIALOG)) {
        String key = k.substring(OUTPUTPARAMETER_DIALOG.length());
        assertTrue(outputData.getOutputparameterDialog().containsKey(key), "outputData.getOutputparameterDialog().containsKey(" + key + ")");
        String valueActual = outputData.getOutputparameterDialog().get(key);
        executables.add(() -> assertEquals(valueExpected, valueActual, key));
      } else if (k.startsWith(SESSION_PARAMETER)) {
        String key = k.substring(SESSION_PARAMETER.length());
        assertTrue(outputData.getSessionParameter().containsKey(key), "outputData.getSessionParameter().containsKey(" + key + ")");
        String valueActual = outputData.getSessionParameter().get(key);
        executables.add(() -> assertEquals(valueExpected, valueActual, key));
      } else {
        throw new IllegalArgumentException(k);
      }
    });

    assertAll(executables);
  }

  @Then("MDT {String} exit")
  // simulates pressing back until root is reached
  public void toMdtExit(String key) {
    String graphName = null;
    String stateName = null;

    do {
      GdlProcessingOutput gdlProcessingOutput = getGdlProcessingOutput();

      if (gdlProcessingOutput.getCurrentStateDescriptor().getGraphName().equals(graphName)
          && gdlProcessingOutput.getCurrentStateDescriptor().getStateName().equals(stateName)) {
        throw new IllegalStateException("root unreachable with BEXIT");
      }

      graphName = gdlProcessingOutput.getCurrentStateDescriptor().getGraphName();
      stateName = gdlProcessingOutput.getCurrentStateDescriptor().getStateName();

      if ("MAIN_MENU".equals(graphName) && "START".equals(stateName)) {
        break;
      }

      userInput(key, "BEXIT", null, null);
    } while (true);
  }

  // Deserializing webservice result
  @SuppressWarnings("unchecked")
  private GdlProcessingOutput getGdlProcessingOutput() {
    GdlProcessingOutput result = new GdlProcessingOutput();

    FieldExtractor data = new FieldExtractor(webserviceClient.verifySuccess().getData());
    FieldExtractor output = new FieldExtractor(data.getObjectMap("outputData"));

    ArrayList<FieldAttribute> fieldAttributes = new ArrayList<FieldAttribute>();
    output.getObjectArray("fieldAttributes").forEach(obj -> {
      FieldExtractor fe = new FieldExtractor((Map<String, Object>) obj);
      // ToDo: FieldAttributeType ??? fieldAttribute.setFieldAttributeType((FieldAttributeType) fe.getInteger("fieldAttributeType"));
      FieldAttribute fieldAttribute = new FieldAttribute(fe.getString("idDialogField"), FieldAttributeType.Invoke, fe.getString("value"));
      fieldAttributes.add(fieldAttribute);
    });

    OutputData outputData = new OutputData();
    outputData.setSessionParameter(output.getStringMap("sessionParameter"));
    outputData.setOutputparameterDialog(output.getStringMap("outputparameterDialog"));
    outputData.setFieldAttributes(fieldAttributes);

    FieldExtractor proxyStateMap = new FieldExtractor(data.getObjectMap("proxyState"));
    ProxyState proxyState = new ProxyState();
    proxyState.setActions(proxyStateMap.getStringMap("actions"));
    proxyState.setAttributes(proxyStateMap.getStringMap("attributes"));
    proxyState.setDialog(proxyStateMap.getString("dialog"));
    proxyState.setGraphname(proxyStateMap.getString("graphname"));
    proxyState.setName(proxyStateMap.getString("name"));

    Stack<StateHistoryDescriptor> stateHistoryStack = new Stack<StateHistoryDescriptor>();
    data.getObjectArray("stateHistory").forEach(obj -> {
      FieldExtractor fe = new FieldExtractor((Map<String, Object>) obj);
      StateHistoryDescriptor stateHistoryDescriptor = new StateHistoryDescriptor(fe.getString("stateName"), fe.getString("graphName"),
          fe.getString("directEvent"));
      stateHistoryStack.add(stateHistoryDescriptor);
    });

    result.setCurrentStateDescriptor(new StateDescriptor(data.getStringMap("currentStateDescriptor").get("stateName"),
        data.getStringMap("currentStateDescriptor").get("graphName")));
    result.setExitOnLastGraph(data.getBoolean("exitOnLastGraph"));
    result.setGraphChange(data.getBoolean("graphChange"));
    result.setOutputData(outputData);
    result.setProxyState(proxyState);
    result.setStateChange(data.getBoolean("stateChange"));
    result.setStateHistory(stateHistoryStack);

    return result;
  }
}
