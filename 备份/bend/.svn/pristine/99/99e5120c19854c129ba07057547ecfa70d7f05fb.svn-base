package com.inconso.bend.inwmsx.it.slaasgmt;

import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.slaasgmt.pers.gen.SlaaSingleArticleConfigPk;
import com.inconso.bend.slaasgmt.pers.model.SlaaSingleArticleConfig;
import com.inconso.bend.slaasgmt.pers.rep.SlaaSingleArticleConfigRep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.en.Given;

public class SlaaHandler {

  @Autowired
  private GeneralHelper              generalHelper;

  @Autowired
  private SlaaSingleArticleConfigRep singleArticleConfigRep;

  @Given("create single article config for client location type {String} with flags artvar = {String}, qty = {String}, lu type = {String}, stock type = {String}, lock type = {String}, special stock type = {String}, special stock ID = {String}, customs = {String}, qc = {String}, batch = {String}, sepCrits = {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}, {String}")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void createSingleArticleConfig(String typLocation, String flgArtvar, String flgQty, String flgTypLu, String flgTypStock, String flgTypLock,
      String flgTypSpecialStock, String flgIdSpecialStock, String flgStatCustoms, String flgStatQualityControl, String flgIdBatch,
      String flgSepCrit01, String flgSepCrit02, String flgSepCrit03, String flgSepCrit04, String flgSepCrit05, String flgSepCrit06,
      String flgSepCrit07, String flgSepCrit08, String flgSepCrit09, String flgSepCrit10) {

    SlaaSingleArticleConfig singleArticleConfig = new SlaaSingleArticleConfig(
        new SlaaSingleArticleConfigPk(generalHelper.getIdSite(), generalHelper.getIdClient(), typLocation));
    singleArticleConfig.setFlgArtvar(flgArtvar);
    singleArticleConfig.setFlgQty(flgQty);
    singleArticleConfig.setFlgTypLu(flgTypLu);
    singleArticleConfig.setFlgTypStock(flgTypStock);
    singleArticleConfig.setFlgTypLock(flgTypLock);
    singleArticleConfig.setFlgTypSpecialStock(flgTypSpecialStock);
    singleArticleConfig.setFlgIdSpecialStock(flgIdSpecialStock);
    singleArticleConfig.setFlgStatCustoms(flgStatCustoms);
    singleArticleConfig.setFlgStatQualityControl(flgStatQualityControl);
    singleArticleConfig.setFlgIdBatch(flgIdBatch);
    singleArticleConfig.setFlgSepCrit01(flgSepCrit01);
    singleArticleConfig.setFlgSepCrit02(flgSepCrit02);
    singleArticleConfig.setFlgSepCrit03(flgSepCrit03);
    singleArticleConfig.setFlgSepCrit04(flgSepCrit04);
    singleArticleConfig.setFlgSepCrit05(flgSepCrit05);
    singleArticleConfig.setFlgSepCrit06(flgSepCrit06);
    singleArticleConfig.setFlgSepCrit07(flgSepCrit07);
    singleArticleConfig.setFlgSepCrit08(flgSepCrit08);
    singleArticleConfig.setFlgSepCrit09(flgSepCrit09);
    singleArticleConfig.setFlgSepCrit10(flgSepCrit10);
    singleArticleConfig.setFlgIdBatch(flgIdBatch);

    singleArticleConfig.setFlgActive("1");
    singleArticleConfigRep.persist(singleArticleConfig);

  }

  @Given("delete single article config for client location type {String}")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void deleteSingleArticleConfig(String typLocation) {
    singleArticleConfigRep.deleteById(new SlaaSingleArticleConfigPk(generalHelper.getIdSite(), generalHelper.getIdClient(), typLocation));
  }

}
