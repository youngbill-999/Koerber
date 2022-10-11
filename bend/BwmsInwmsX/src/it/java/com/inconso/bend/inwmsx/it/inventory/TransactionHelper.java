package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.inventory.pers.gen.ImTransactionPk;
import com.inconso.bend.inventory.pers.model.ImTransaction;
import com.inconso.bend.inventory.pers.rep.ImTransactionRep;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.FieldExtractor;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.WebserviceClient;
import io.cucumber.java.en.Then;

@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class TransactionHelper {

  @Autowired
  private WebserviceClient     webserviceClient;

  @Autowired
  private CucumberReport       cucumberReport;

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private ImTransactionRep     transactionRep;

  /**
   * Verifies that the prior webservice call was successful and stores the relevant output for future verifications.
   * 
   */
  @Then("CORST was successful; transaction saved as {String}")
  @Then("RELLU was successful; transaction saved as {String}")
  @Then("RELQU was successful; transaction saved as {String}")
  @Then("RESST was successful; transaction saved as {String}")
  @Then("STALU was successful; transaction saved as {String}")
  @Then("CHALA was successful; transaction saved as {String}")
  @Then("CHAQA was successful; transaction saved as {String}")
  @Then("CHASC was successful; transaction saved as {String}")
  @Transactional(readOnly = true)
  public void transactionSuccessful(String keyTransaction) {
    Map<String, Object> data = webserviceClient.verifySuccess().getData();

    FieldExtractor payload = new FieldExtractor(data);

    String idSite = payload.getString("idSite");
    String idTransaction = payload.getString("idTransaction");
    String idLu = payload.getString("idLu");
    String idQuantum = payload.getString("idQuantum");

    ImTransaction transaction = transactionRep.findOne(new ImTransactionPk(idSite, idTransaction));
    assertNotNull(transaction);
    inventoryDataHandler.putTransaction(keyTransaction, transaction);

    if (idLu != null) {
      cucumberReport.setMessage("idLu = " + idLu);
    }

    if (idQuantum != null) {
      cucumberReport.setMessage("idQuantum = " + idQuantum);
    }
  }

  /**
   * read transaction group list.
   * 
   * @return last created transaction
   */
  public List<ImTransaction> readTransactionGrpList(String keyTransaction) {
    ImTransaction transaction = inventoryDataHandler.getTransaction(keyTransaction);
    List<ImTransaction> transactions = transactionRep.findAll((root, query, cb) -> {
      // return cb.equal(root.get("idTransactionGrp"), transaction);
      return cb.equal(root.get("idTransactionGrp"), transaction.getImTransactionPk().getIdTransaction());
    });

    return transactions;
  }

}
