package com.inconso.bend.inwmsx.it.reserv;

import org.springframework.beans.factory.annotation.Autowired;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.gibase.service.api.BwmsGIBaseOrderListInput;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.inwmsx.it.gibase.GiBaseHelper;
import com.inconso.bend.ordres.service.api.OrdresDesc;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.When;

public class ReservWebserviceCaller {

  @Autowired
  private WebserviceClient webserviceClient;

  @Autowired
  private GiBaseHelper     giBaseHelper;

  @When("RES_LIST_ORDER is/was called for:")
  public ServiceInput<BwmsGIBaseOrderListInput> doResListOrder(DataTable table) throws InterruptedException {

    ServiceInput<BwmsGIBaseOrderListInput> serviceInput = giBaseHelper.doListOrder(table);
    webserviceClient.call(OrdresDesc.SERVICE, OrdresDesc.RES_LIST_ORDER, serviceInput);

    return serviceInput;
  }

  @When("RESET_RESERV_OF_ORDERS_EP is/was called for:")
  public ServiceInput<BwmsGIBaseOrderListInput> resetReservationOfOrders(DataTable table) throws InterruptedException {

    ServiceInput<BwmsGIBaseOrderListInput> serviceInput = giBaseHelper.doListOrder(table);
    webserviceClient.call(OrdresDesc.SERVICE, OrdresDesc.RESET_RESERV_OF_ORDERS_EP, serviceInput);

    return serviceInput;
  }

}
