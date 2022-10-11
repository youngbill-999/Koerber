package com.inconso.bend.inwmsx.it.stocktaking;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.stm.pers.gen.StmStockTakingListPk;
import com.inconso.bend.stm.pers.model.StmStockTakingItem;
import com.inconso.bend.stm.pers.model.StmStockTakingList;
import com.inconso.bend.stm.pers.rep.StmStockTakingItemRep;
import com.inconso.bend.stm.pers.rep.StmStockTakingListRep;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;

public class StocktakingFieldVerifier {

  @Autowired
  private StocktakingDataHandler stocktakingDataHandler;

  @Autowired
  private StmStockTakingItemRep  stockTakingItemRep;

  @Autowired
  private StmStockTakingListRep  stmStockTakingListRep;

  @Autowired
  private GeneralHelper          generalHelper;

  @Then("verify {Long} stocktaking lists created")
  public void verifyCreatedLists(Long i) {
    Map<String, String> allStockTakeLists = stocktakingDataHandler.getAllStockTakeListIds();
    assertEquals(i, allStockTakeLists.size(), "numberOfLists");

  }

  @And("verify {Long} list items created, {Long} items not empty")
  @Transactional(readOnly = true)
  public void verifyListContent(Long i, Long n) {

    List<StmStockTakingItem> stockTakingItems = stockTakingItemRep.findAll();

    List<StmStockTakingItem> stockTakingItems_Normal = new ArrayList<StmStockTakingItem>();
    for (int j = 0; j < stockTakingItems.size(); j++) {
      StmStockTakingItem temp = stockTakingItems.get(j);
      if (temp.getTypItem().equalsIgnoreCase("normal")) {
        stockTakingItems_Normal.add(temp);
      }
    }
    assertAll(() -> assertEquals(n, stockTakingItems_Normal.size(), "notEmptyItemNumber"),
        () -> assertEquals(i, stockTakingItems.size(), "numberOfItems"));
  }

  @And("status StockTakingList {String} is {String}")
  @Transactional(readOnly = true)
  public void verifyStatus(String keyStockTakingList, String status) {
    StmStockTakingListPk listPk = new StmStockTakingListPk(generalHelper.getIdSite(), stocktakingDataHandler.getStockTakeListId(keyStockTakingList));
    StmStockTakingList currentList = stmStockTakingListRep.findOneOrThrowException(listPk);
    assertEquals(status, currentList.getStat(), "stockTakingListStatus");
  }

}