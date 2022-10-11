package com.inconso.bend.inwmsx.it.packing;

import org.springframework.beans.factory.annotation.Autowired;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import com.inconso.bend.packing.service.api.BwmsPackingDesc;
import com.inconso.bend.packing.service.api.PackingCompleteBpsRecordInput;
import io.cucumber.java.en.When;

public class PackingWebserviceCaller {

  @Autowired
  private WebserviceClient     webserviceClient;

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @When("COMPLETE_BPS_RECORD is called for with: packageLu = {StringExt}, idWorkcenter = {String}")
  public void completeBpsRecord(GherkinType<String> packageLu, String idWorkcenter) {
    packageLu.setGetterForKey(inventoryDataHandler.idLuGetter);
    ServiceInput<PackingCompleteBpsRecordInput> input = new ServiceInput<>();
    input.setContext("SITE", generalHelper.getIdSite());

    PackingCompleteBpsRecordInput packingCompleteBpsRecordInput = new PackingCompleteBpsRecordInput();
    packingCompleteBpsRecordInput.setIdSite(generalHelper.getIdSite());
    packingCompleteBpsRecordInput.setIdWorkcenter(idWorkcenter);
    packingCompleteBpsRecordInput.setPackageLu(packageLu.get());
    input.setData(packingCompleteBpsRecordInput);

    webserviceClient.call(BwmsPackingDesc.SERVICE, BwmsPackingDesc.COMPLETE_BPS_RECORD, input);
    webserviceClient.verifySuccess();
  }
}
