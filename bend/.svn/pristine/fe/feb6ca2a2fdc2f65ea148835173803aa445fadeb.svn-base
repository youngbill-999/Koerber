package com.inconso.bend.inwmsx.it.inventoryinit;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inventory.init.pers.model.ImiLoadStock;
import com.inconso.bend.inventory.init.pers.rep.ImiLoadStockRep;
import com.inconso.bend.inventory.init.service.api.BwmsInventoryInitDesc;
import com.inconso.bend.inventory.init.service.api.BwmsInventoryInitLoadStockInput;
import com.inconso.bend.inventory.init.service.api.BwmsInventoryInitLoadStockListInput;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.en.And;

public class InventoryInitWebserviceCaller {

  @Autowired
  private GeneralHelper    generalHelper;

  @Autowired
  private WebserviceClient webserviceClient;

  @Autowired
  private ImiLoadStockRep  imiLoadStockRep;

  @And("{int} new datasets of IMI800 are booked")
  @Transactional(readOnly = true)
  public void bookDataSetsFromImi800(Integer count) {

    Page<ImiLoadStock> imiLoadStocksPage = imiLoadStockRep.findAll(new Specification<ImiLoadStock>() {

      private static final long serialVersionUID = 1L;

      @Override
      public Predicate toPredicate(Root<ImiLoadStock> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
        //
        Predicate[] pretAr = new Predicate[2];
        pretAr[0] = cb.equal(root.get("imiLoadStockPk").get("idSite"), generalHelper.getIdSite());
        pretAr[1] = cb.equal(root.get("stat"), "00");
        return cb.and(pretAr);
      }
    }, Pageable.ofSize(count));

    List<BwmsInventoryInitLoadStockInput> loadStockInput = new ArrayList<>();

    List<ImiLoadStock> imiLoadStocks = imiLoadStocksPage.getContent();
    imiLoadStocks.stream().forEach(i -> {
      BwmsInventoryInitLoadStockInput input = new BwmsInventoryInitLoadStockInput();
      input.setIdSite(generalHelper.getIdSite());
      input.setIdLoadStock(i.getImiLoadStockPk().getIdLs());
      loadStockInput.add(input);
    });

    BwmsInventoryInitLoadStockListInput bookInput = new BwmsInventoryInitLoadStockListInput();
    bookInput.setLoadStockList(loadStockInput);

    ServiceInput<BwmsInventoryInitLoadStockListInput> inputService = new ServiceInput<>();
    inputService.setContext("SITE", generalHelper.getIdSite());
    inputService.setData(bookInput);

    webserviceClient.call(BwmsInventoryInitDesc.SERVICE, BwmsInventoryInitDesc.BOOK_EP, inputService);
  }
}
