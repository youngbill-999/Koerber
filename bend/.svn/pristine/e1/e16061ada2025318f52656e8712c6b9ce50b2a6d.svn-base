package com.inconso.bend.inwmsx.it.replenishment;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import com.inconso.bend.repbase.pers.gen.RepConfigStoreOutZonePk;
import com.inconso.bend.repbase.pers.model.RepConfigStoreOutZone;
import com.inconso.bend.repbase.pers.model.RepReplenishmentRequest;
import com.inconso.bend.repbase.pers.rep.RepConfigStoreOutZoneRep;
import com.inconso.bend.repbase.pers.rep.RepReplenishmentRequestRep;
import com.inconso.bend.repbase.service.api.BwmsRepBaseDesc;
import com.inconso.bend.repbase.service.api.RepBaseConfStoreOutZoneInput;
import com.inconso.bend.repbase.service.api.RepBaseConfStoreOutZoneListInput;
import com.inconso.bend.repbase.service.api.RepBaseReplenishmentRequestInput;
import com.inconso.bend.repbase.service.api.RepBaseReplenishmentRequestListInput;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.When;

public class ReplenishmentWebserviceCaller {

  @Autowired
  private WebserviceClient                    webserviceClient;

  @Autowired
  private ReplenishmentDataHandler            replenishmentDataHandler;

  @Autowired
  private GeneralHelper                       generalHelper;

  @Autowired
  private RepConfigStoreOutZoneRep            repConfigStoreOutZoneRep;

  @Autowired
  private RepReplenishmentRequestRep          repReplenishmentRequestRep;

  @Autowired
  private PlatformTransactionManager          transactionManager;

  private Comparator<RepReplenishmentRequest> compare = Comparator.comparing(RepReplenishmentRequest::getRepReplenishmentRequestPk, (lhs, rhs) -> {
                                                        return lhs.getIdReplenishment().compareTo(rhs.getIdReplenishment());
                                                      });

  /**
   * writes the active-flags of the replenishment configurations for the specified articles
   * 
   * @param table
   *          article ids
   * 
   * @param flag
   *          flag value to write
   * 
   */
  private void writeActiveFlags(DataTable table, boolean flag) {
    List<RepConfigStoreOutZone> repConfigStoreOutZones = repConfigStoreOutZoneRep.findAll();
    List<String> articles = table.asList();
    repConfigStoreOutZones.stream().forEach(item -> {
      boolean s = item.getRepConfigStoreOutZonePk().getIdSite().equals(generalHelper.getIdSite());
      boolean c = item.getRepConfigStoreOutZonePk().getIdClient().equals(generalHelper.getIdClient());
      boolean a = articles.stream().anyMatch(elem -> elem.equals(item.getRepConfigStoreOutZonePk().getIdArticle()));

      if (s && c && a) {
        item.setFlgActive(flag ? "1" : "0");
      }
    });
    repConfigStoreOutZoneRep.flush();
  }

  @When("RD_MULTI_CONFIG is called, {int} replenishment requests saved as collection {string}, articles:")
  @Transactional(propagation = Propagation.NOT_SUPPORTED)
  public void repDetByMultiStoreZoneOutConfig(int count, String key, DataTable table) {
    // manual transaction handling necessary since the updated active-flags must be committed before the web service call so that the changes will be seen by
    // the web service
    TransactionTemplate transactionTemplate = new TransactionTemplate(transactionManager);
    transactionTemplate.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);

    transactionTemplate.execute(new TransactionCallbackWithoutResult() {

      @Override
      protected void doInTransactionWithoutResult(TransactionStatus status) {
        writeActiveFlags(table, true);
      }
    });

    transactionTemplate.execute(new TransactionCallbackWithoutResult() {

      @Override
      protected void doInTransactionWithoutResult(TransactionStatus status) {
        Optional<RepReplenishmentRequest> last = getLastRepReplenishmentRequest();

        List<RepConfigStoreOutZone> repConfigStoreOutZones = repConfigStoreOutZoneRep.findAll();
        List<RepBaseConfStoreOutZoneInput> list = repConfigStoreOutZones.stream().filter(item -> item.getFlgActive().equals("1")).map(item -> {
          RepConfigStoreOutZonePk itemPk = item.getRepConfigStoreOutZonePk();
          return new RepBaseConfStoreOutZoneInput("SO_ZONE", itemPk.getIdClient(), itemPk.getIdArticle(), itemPk.getClArticles(),
              itemPk.getGrpArticles(), itemPk.getIdStoreOutZone());
        }).collect(Collectors.toList());

        ServiceInput<RepBaseConfStoreOutZoneListInput> serviceInput = new ServiceInput<>();
        serviceInput.setContext("SITE", generalHelper.getIdSite());

        RepBaseConfStoreOutZoneListInput repBaseConfStoreOutZoneListInput = new RepBaseConfStoreOutZoneListInput();
        repBaseConfStoreOutZoneListInput.setConfStoreOutList(list);

        serviceInput.setData(repBaseConfStoreOutZoneListInput);
        webserviceClient.call(BwmsRepBaseDesc.SERVICE, BwmsRepBaseDesc.RD_MULTI_CONFIG, serviceInput);

        generalHelper.waiting(4);
        writeActiveFlags(table, false);

        List<RepReplenishmentRequest> repReplenishmentRequests = getRepReplenishmentRequests(last).collect(Collectors.toList());

        int i = 0;
        for (RepReplenishmentRequest repReplenishmentRequest : repReplenishmentRequests) {
          replenishmentDataHandler.putRepReplenishmentRequest(GeneralHelper.makeMapKeyWithIx(key, i), repReplenishmentRequest);
          i++;
        }

        assertEquals(count, repReplenishmentRequests.size(), "count");
      }
    });
  }

  @When("RELEASE_REP_REQUESTS is called for:")
  public void releaseReplenishmentRequests(DataTable replenishmentRequests) {
    List<RepBaseReplenishmentRequestInput> list = replenishmentRequests.asList().stream().map(key -> {
      return new RepBaseReplenishmentRequestInput(
          replenishmentDataHandler.getRepReplenishmentRequest(key).getRepReplenishmentRequestPk().getIdReplenishment());
    }).collect(Collectors.toList());

    ServiceInput<RepBaseReplenishmentRequestListInput> serviceInput = new ServiceInput<>();
    serviceInput.setContext("SITE", generalHelper.getIdSite());

    RepBaseReplenishmentRequestListInput repBaseReplenishmentRequestListInput = new RepBaseReplenishmentRequestListInput();
    repBaseReplenishmentRequestListInput.setReplenishmentRequestList(list);

    serviceInput.setData(repBaseReplenishmentRequestListInput);
    webserviceClient.call(BwmsRepBaseDesc.SERVICE, BwmsRepBaseDesc.RELEASE_REP_REQUESTS, serviceInput);
  }

  private Stream<RepReplenishmentRequest> getRepReplenishmentRequests() {
    return repReplenishmentRequestRep.findAll().stream().filter(item -> item.getIdClient().equals(generalHelper.getIdClient())
        && item.getRepReplenishmentRequestPk().getIdSite().equals(generalHelper.getIdSite()));
  }

  private Stream<RepReplenishmentRequest> getRepReplenishmentRequests(Optional<RepReplenishmentRequest> after) {
    Stream<RepReplenishmentRequest> result = getRepReplenishmentRequests();

    if (after.isPresent()) {
      result = result.filter(item -> item.getRepReplenishmentRequestPk().getIdReplenishment()
          .compareTo(after.get().getRepReplenishmentRequestPk().getIdReplenishment()) > 0);
    }
    return result.sorted(compare);
  }

  private Optional<RepReplenishmentRequest> getLastRepReplenishmentRequest() {
    Optional<RepReplenishmentRequest> last = getRepReplenishmentRequests().max(compare);
    return last;
  }
}
