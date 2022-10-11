package com.inconso.bend.inwmsx.it.stockavail;

import org.springframework.beans.factory.annotation.Autowired;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.gibase.service.api.BwmsGIBaseOrderListInput;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.inwmsx.it.gibase.GiBaseHelper;
import com.inconso.bend.stockavail.service.api.StockAvailDesc;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.When;

public class StockAvailWebserviceCaller {

  @Autowired
  private WebserviceClient webserviceClient;
  @Autowired
  private GiBaseHelper     giBaseHelper;

  @When("SAC_LIST_ORDER is/was called for:")
  public ServiceInput<BwmsGIBaseOrderListInput> doSacListOrder(DataTable table) throws InterruptedException {

    ServiceInput<BwmsGIBaseOrderListInput> serviceInput = giBaseHelper.doListOrder(table);
    webserviceClient.call(StockAvailDesc.SERVICE, StockAvailDesc.SAC_LIST_ORDER, serviceInput);

    return serviceInput;
  }

}
