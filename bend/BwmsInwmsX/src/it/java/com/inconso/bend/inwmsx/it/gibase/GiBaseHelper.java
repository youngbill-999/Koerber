package com.inconso.bend.inwmsx.it.gibase;

import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.gibase.pers.gen.GiOrderPk;
import com.inconso.bend.gibase.service.api.BwmsGIBaseOrderInput;
import com.inconso.bend.gibase.service.api.BwmsGIBaseOrderListInput;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import io.cucumber.datatable.DataTable;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class GiBaseHelper {

  @Autowired
  private GeneralHelper     generalHelper;

  @Autowired
  private GiBaseDataHandler giBaseDataHandler;

  public ServiceInput<BwmsGIBaseOrderListInput> doListOrder(DataTable table) throws InterruptedException {
    List<BwmsGIBaseOrderInput> list = table.asList().stream().map(key -> {
      GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();

      BwmsGIBaseOrderInput bwmsGIBaseOrderInput = new BwmsGIBaseOrderInput();
      bwmsGIBaseOrderInput.setIdSite(giOrderPk.getIdSite());
      bwmsGIBaseOrderInput.setIdClient(giOrderPk.getIdClient());
      bwmsGIBaseOrderInput.setIdOrder(giOrderPk.getIdOrder());
      bwmsGIBaseOrderInput.setNumPartialOrder(giOrderPk.getNumPartialOrder());

      return bwmsGIBaseOrderInput;
    }).collect(Collectors.toList());

    ServiceInput<BwmsGIBaseOrderListInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    BwmsGIBaseOrderListInput bwmsGIBaseOrderListInput = new BwmsGIBaseOrderListInput();
    bwmsGIBaseOrderListInput.setOrderList(list);

    serviceInput.setData(bwmsGIBaseOrderListInput);
    // webserviceClient.call(BwmsGIBaseDesc.SERVICE, endpoint, serviceInput);

    return serviceInput;
  }

}
