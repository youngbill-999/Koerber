package com.inconso.bend.inwmsx.it.wmsbase;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import com.inconso.bend.wmsbase.pers.gen.WbClientPk;
import com.inconso.bend.wmsbase.pers.model.WbClient;
import com.inconso.bend.wmsbase.pers.rep.WbClientRep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.en.Given;

public class WbClientHandler {

  @Autowired
  private WbClientRep clientRep;

  @Given("client {string} has the following attribute configuration")
  @Transactional(readOnly = true)
  public void clientHasTheFollowingAttributeConfiguration(String idClient, io.cucumber.datatable.DataTable dataTable) {
    WbClient client = clientRep.findOne(new WbClientPk(idClient));
    List<WbClientAttributeConfiguration> configs = new ArrayList<>();

    List<List<String>> rows = dataTable.asLists(String.class);

    for (List<String> columns : rows) {
      configs.add(new WbClientAttributeConfiguration(columns.get(0), columns.get(1), columns.get(2), columns.get(3), columns.get(4), columns.get(5),
          columns.get(6), columns.get(7)));
    }

    int counter = 1;
    for (WbClientAttributeConfiguration config : configs) {
      setAttributeValues(client, config, counter);
      counter++;
    }

  }

  private void setAttributeValues(WbClient client, WbClientAttributeConfiguration config, int counter) {
    String number = String.valueOf(counter);
    if (number.length() == 1) number = "0".concat(number);
    try {
      Method setAttribute = WbClient.class.getMethod("setAttribute" + number, String.class);
      setAttribute.invoke(client, config.getAttribute());

      Method setDefaultValue = WbClient.class.getMethod("setAttribute" + number + "DefaultValue", String.class);
      setDefaultValue.invoke(client, config.getDefaultValue());

      Method setDescription = WbClient.class.getMethod("setAttribute" + number + "Name", String.class);
      setDescription.invoke(client, config.getDescription());

      Method setRegExp = WbClient.class.getMethod("setAttribute" + number + "IdRegExp", String.class);
      setRegExp.invoke(client, config.getRegExp());

      Method setUpdatable = WbClient.class.getMethod("setFlgAttribute" + number + "Updatable", String.class);
      setUpdatable.invoke(client, config.getUpdateable());

      Method setNullable = WbClient.class.getMethod("setFlgAttribute" + number + "Nullable", String.class);
      setNullable.invoke(client, config.getNullable());

      Method setNullcheck = WbClient.class.getMethod("setFlgAttribute" + number + "Nullcheck", String.class);
      setNullcheck.invoke(client, config.getNullcheck());

      Method setMerging = WbClient.class.getMethod("setClAttribute" + number + "Merge", String.class);
      setMerging.invoke(client, config.getMerging());

    } catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
      e.printStackTrace();
    }
  }

  @Given("delete attribute configuration for client {String}")
  @Transactional(readOnly = true)
  public void deleteAttributeConfiguration(String idClient) {
    WbClient client = clientRep.findOne(new WbClientPk(idClient));
    for (int i = 1; i <= 20; i++) {
      setAttributeValues(client, new WbClientAttributeConfiguration(null, null, null, "DEF", "0", "1", "0", null), i);
    }
  }

}
