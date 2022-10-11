package com.inconso.bend.inwmsx.it.batch;

import java.util.Date;
import com.inconso.bend.BwmsBatch.service.api.BwmsBatchBmcreInput;
import com.inconso.bend.BwmsBatch.service.api.BwmsBatchDesc;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import org.springframework.beans.factory.annotation.Autowired;
import io.cucumber.java.en.And;

public class BmCreHandler {

  @Autowired
  private WebserviceClient            webserviceClient;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  @Autowired
  private GeneralHelper               generalHelper;

  private BwmsBatchBmcreInput.Builder bmwsBatchBmcreInputBuilder;

  @And("create batch {String} for idArticle = {String} saved as {String} with tsBbd {Date}")
  public void createBatch(String batchName, String idArticle, String keyBatch, Date tsBbd) {
    ServiceInput<BwmsBatchBmcreInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());

    bmwsBatchBmcreInputBuilder = new BwmsBatchBmcreInput.Builder(generalHelper.getIdSite(), //
        "DIALOG", //
        "BM100", //
        "*", //
        generalHelper.getIdClient(), //
        "*", //
        idArticle, //
        "basis");

    bmwsBatchBmcreInputBuilder.withIdBatchOrBestBeforeDate(batchName, tsBbd, "0");

    inputService.setData(bmwsBatchBmcreInputBuilder.build());
    webserviceClient.call(BwmsBatchDesc.SERVICE, BwmsBatchDesc.BMCRE_EP, inputService);
    webserviceClient.verifySuccess();

    inventoryDataHandler.putBatchName(keyBatch, batchName);

  }
}
