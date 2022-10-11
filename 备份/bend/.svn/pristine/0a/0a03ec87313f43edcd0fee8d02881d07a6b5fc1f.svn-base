package com.inconso.bend.inwmsx.it.packing;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.gibase.pers.gen.GiOrderPk;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType;
import com.inconso.bend.inwmsx.it.gibase.GiBaseDataHandler;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import com.inconso.bend.pabase.pers.model.PaPackage;
import com.inconso.bend.pabase.pers.rep.PaPackageRep;
import io.cucumber.java.en.Then;

public class PackingFieldVerifier {

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private PackingDataHandler   packingDataHandler;

  @Autowired
  private GiBaseDataHandler    giBaseDataHandler;

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private PaPackageRep         paPackageRep;

  @Then("order {string} has {int} package(s), saved as collection {string}")
  @Transactional(readOnly = true)
  public void savePackagesOfOrder(String key, int count, String keyPackage) {
    GiOrderPk giOrderPk = giBaseDataHandler.getGiOrder(key).getGiOrderPk();

    Comparator<PaPackage> compare = Comparator.comparing(PaPackage::getIdLu);

    List<PaPackage> packages = paPackageRep.findByReferences("GI_ORDER", giOrderPk.getIdSite(), giOrderPk.getIdClient(), giOrderPk.getIdOrder(),
        giOrderPk.getNumPartialOrder().toString(), null, null).stream().sorted(compare).collect(Collectors.toList());

    int i = 0;
    for (PaPackage paPackage : packages) {
      packingDataHandler.putPaPackage(GeneralHelper.makeMapKeyWithIx(keyPackage, i), paPackage);
      i++;
    }

    assertEquals(count, i);
  }

  @Then("package {string} has: stat = {StringExt}, idLu = {StringExt}, typ = {StringExt}, idCre = {StringExt}, tsCre = {DateTimeExt}, idUpd = {StringExt}, tsUpd = {DateTimeExt}")
  public void verifyPackage(String key, GherkinType<String> stat, GherkinType<String> idLu, GherkinType<String> typ, GherkinType<String> idCre,
      GherkinType<Date> tsCre, GherkinType<String> idUpd, GherkinType<Date> tsUpd) {
    idLu.setGetterForKey(inventoryDataHandler.idLuGetter);

    //@formatter:off
    PaPackage record = packingDataHandler.getPaPackage(key);
    
    assertAll(
        () -> assertEquals(generalHelper.getIdSite(), record.getPaPackagePk().getIdSite(), "idSite"),
        () -> assertNotNull(record.getPaPackagePk().getIdPackage(), "idPackage"),
        () -> stat.assertEquality(record.getStat(), "stat"),
        () -> idLu.assertEquality(record.getIdLu(), "idLu"),
        () -> typ.assertEquality(record.getTyp(), "typ"),
        () -> idCre.assertEquality(record.getIdCre(), "idCre"),
        () -> tsCre.assertEquality(record.getTsCre(), "tsCre"),
        () -> idUpd.assertEquality(record.getIdUpd(), "idUpd"),
        () -> tsUpd.assertEquality(record.getTsUpd(), "tsUpd")
    );
    /*
    record.getIdLu1();
    record.getIdLu2();
    record.getIdLu3();
    record.getIdPackage1();
    record.getIdPackage2();
    record.getIdPackage3();
    record.getImLoadUnit();
    record.getLen();
    record.getTsCre();
    record.getTsUpd();
    record.getTypLu();
    record.getVol();
    record.getHeight();
    record.getWidth();
    record.getWtGross();
    record.getWtTare();
    record.getWtWeighted();
    */
    //@formatter:on

  }
}
