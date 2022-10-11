package com.inconso.bend.inwmsx.it.batch;

import java.util.List;
import javax.persistence.criteria.Predicate;
import com.inconso.bend.batch.pers.gen.BmBatchPk;
import com.inconso.bend.batch.pers.model.BmBatchAttribute;
import com.inconso.bend.batch.pers.rep.BmBatchAttributeRep;
import com.inconso.bend.batch.pers.rep.BmBatchRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.en.And;

public class BmBatchHandler {

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private BmBatchRep           bmBatchRep;

  @Autowired
  private BmBatchAttributeRep  bmBatchAttributeRep;

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @And("delete batch {string} of article {string}")
  @Transactional(readOnly = true)
  public void deleteBatch(String keyBatch, String idArticle) {
    String idBatch = inventoryDataHandler.getBatchName(keyBatch);
    if (idBatch != null) {
      List<BmBatchAttribute> batchAttributes = bmBatchAttributeRep.findAll((root, query, cb) -> {
        Predicate where = cb.equal(root.get("bmBatchAttributePk").get("idClient"), generalHelper.getIdClient());
        where = cb.and(where, cb.equal(root.get("bmBatchAttributePk").get("idArticle"), idArticle));
        where = cb.and(where, cb.equal(root.get("bmBatchAttributePk").get("idBatch"), idBatch));

        return cb.and(where);
      });

      bmBatchAttributeRep.delete(batchAttributes);
      bmBatchRep.deleteById(new BmBatchPk(generalHelper.getIdClient(), idArticle, idBatch));
    }
  }

}
