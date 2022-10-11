package com.inconso.bend.inwmsx.it.inventory;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType.GetterFunction;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class InventoryDataHandler {

  public final GetterFunction<String> idLuGetter          = key -> getLoadUnit(key).getImLoadUnitPk().getIdLu();
  public final GetterFunction<String> idQuGetter          = key -> getQuantum(key).getImQuantumPk().getIdQuantum();
  public final GetterFunction<String> idTransactionGetter = key -> getTransaction(key).getImTransactionPk().getIdTransaction();

  @Autowired
  private CucumberReport              cucumberReport;

  private Map<String, ImLoadUnit>     loadUnits           = new HashMap<String, ImLoadUnit>();
  private Map<String, ImQuantum>      quantums            = new HashMap<String, ImQuantum>();
  private Map<String, ImTransaction>  transactions        = new HashMap<String, ImTransaction>();
  private Map<String, String>         batches             = new HashMap<String, String>();

  public ImLoadUnit getLoadUnit(String key) {
    if (!loadUnits.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return loadUnits.get(key);
  }

  public void putLoadUnit(String key, ImLoadUnit value) {
    cucumberReport.setMessage(String.format("putLoadUnit(%s, %s)", key, value));
    loadUnits.put(key, value);
  }

  public ImQuantum getQuantum(String key) {
    if (!quantums.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return quantums.get(key);
  }

  public void putQuantum(String key, ImQuantum value) {
    cucumberReport.setMessage(String.format("putQuantum(%s, %s)", key, value));
    quantums.put(key, value);
  }

  public ImTransaction getTransaction(String key) {
    if (!transactions.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return transactions.get(key);
  }

  public void putTransaction(String key, ImTransaction value) {
    cucumberReport.setMessage(String.format("putTransaction(%s, %s)", key, value));
    transactions.put(key, value);
  }

  public String getBatchName(String key) {
    if (!batches.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return batches.get(key);
  }

  public void putBatchName(String key, String value) {
    cucumberReport.setMessage(String.format("putBatchName(%s, %s)", key, value));
    batches.put(key, value);
  }

}
