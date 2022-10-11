package com.inconso.bend.inwmsx.it.inventory;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.inventory.logic.InventoryWeightAndVolumeJob;
import com.inconso.bend.inventory.logic.model.WeightAndVolumeDto;
import com.inconso.bend.inventory.logic.transaction.api.internal.LoadUnitTransactionElement;
import com.inconso.bend.inventory.logic.transaction.api.internal.LoadUnitTransactionElement.Level;
import com.inconso.bend.inventory.logic.transaction.api.internal.QuantumTransactionElement;
import com.inconso.bend.inventory.pers.gen.ImLoadUnitPk;
import com.inconso.bend.inventory.pers.gen.ImQuantumPk;
import com.inconso.bend.inventory.pers.model.ImLoadUnit;
import com.inconso.bend.inventory.pers.model.ImQuantum;
import com.inconso.bend.inventory.pers.rep.ImLoadUnitRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.topology.pers.gen.TopLuTypePk;
import com.inconso.bend.topology.pers.model.TopLuType;
import com.inconso.bend.topology.pers.rep.TopLuTypeRep;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class WeightAndVolumeJobHandler {

  @Autowired
  private GeneralHelper               generalHelper;

  @Autowired
  private InventoryDataHandler        inventoryDataHandler;

  @Autowired
  private ImLoadUnitRep               loadUnitRep;

  @Autowired
  private InventoryWeightAndVolumeJob weightAndVolumeJob;

  @Autowired
  private TopLuTypeRep                luTypeRep;

  private WeightAndVolumeDto          result = null;

  private ImLoadUnit                  loadUnit;

  @Transactional(readOnly = true)
  @When("Weight and volume are calculated for {double} pieces of article {string} with artvar {string}")
  public void weightAndVolumeAreCalculatedForPiecesOfArticleWithArtvarAndLoadUnitType(Double pieces, String article, String artvar) {
    if (artvar != null && artvar.isEmpty()) {
      artvar = null;
    }
    result = weightAndVolumeJob.calculateWeightAndVolume(generalHelper.getIdSite(), generalHelper.getIdClient(), article, artvar, pieces);
  }

  @Then("weight is {double}")
  public void weightIs(Double weight) {
    assertEquals(weight, result.getWeight());
  }

  @Then("volume is {double}")
  public void volumeIs(Double volume) {
    assertEquals(volume, result.getVolume());
  }

  @When("Weight and volume are calculated for {double} pieces of article {string} with artvar {string} on {string}")
  @Transactional(readOnly = true)
  public void weightAndVolumeAreCalculatedForPiecesOfArticleWithArtvarOn(Double pieces, String article, String artvar, String luTyp) {
    if (artvar != null && artvar.isEmpty()) {
      artvar = null;
    }

    // result = weightAndVolumeJob.calculateWeightAndVolume(SITE, client, article, artvar, pieces);

    TopLuType luType = luTypeRep.findOneOrThrowException(new TopLuTypePk(generalHelper.getIdSite(), luTyp), null);

    ImLoadUnit lu1 = new ImLoadUnit(new ImLoadUnitPk(generalHelper.getIdSite(), RandomStringUtils.randomNumeric(8)));
    lu1.setTopLuType(luType);
    lu1.setTypLu(luTyp);
    lu1.setWtTare(luType.getWtTare());

    QuantumTransactionElement quant = new QuantumTransactionElement();
    ImQuantum q = new ImQuantum(new ImQuantumPk(generalHelper.getIdSite(), RandomStringUtils.randomNumeric(10)));
    q.setIdClient(generalHelper.getIdClient());
    q.setIdArticle(article);
    q.setQtyAvailable(pieces);
    q.setArtvar(artvar);
    quant.setTransactionObject(q);

    LoadUnitTransactionElement lu = new LoadUnitTransactionElement(Level._1, lu1);
    lu.addChild(quant);
    quant.setParent(lu);

    weightAndVolumeJob.calculateWtGrossOfAbstractTransactionElement(lu);

    result = new WeightAndVolumeDto(lu.getTransactionObject().getWtGross(), lu.getTransactionObject().getVol());
  }

  /**
   * Verifies that the weight the given load unit has the expected value
   * 
   * @param key
   * 
   * @param weight
   * 
   */
  @Then("verify that the weight of the load unit {string} is {double}")
  @Transactional(readOnly = true)
  public void verifyWeightOfSelectedLoadUnit(String key, Double weight) {
    ImLoadUnit lu = readLoadUnit(inventoryDataHandler.getLoadUnit(key).getImLoadUnitPk().getIdLu());
    assertEquals(weight, lu.getWtGross());
  }

  /**
   * Reads the object for the occupated load unit
   * 
   * @param verifyLoadUnit
   * 
   * @return object location
   */
  private ImLoadUnit readLoadUnit(String verifyLoadUnit) {
    loadUnit = loadUnitRep.findOne(new ImLoadUnitPk(generalHelper.getIdSite(), verifyLoadUnit));
    return loadUnit;
  }
}
