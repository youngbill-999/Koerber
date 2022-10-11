package com.inconso.bend.inwmsx.it.technical;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.Optional;
import com.inconso.bend.article.pers.gen.ArtArtPackingUnitPk;
import com.inconso.bend.article.pers.gen.ArtVPuLuTypePk;
import com.inconso.bend.article.pers.model.ArtArtPackingUnit;
import com.inconso.bend.article.pers.model.ArtVPuLuType;
import com.inconso.bend.article.pers.rep.ArtArtPackingUnitRep;
import com.inconso.bend.article.pers.rep.ArtVPuLuTypeRep;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.en.Given;

public class ViewSelectionSteps {

  @Autowired
  private GeneralHelper        generalHelper;

  @Autowired
  private ArtVPuLuTypeRep      artVPuLuTypeRep;

  @Autowired
  private ArtArtPackingUnitRep artArtPackingUnitRep;

  @Autowired
  CucumberReport               cucumberReport;

  @Given("View selection without flush shows old value")
  @Transactional(propagation = Propagation.REQUIRED)
  public void viewSelectionWithoutFlush() {
    String idSite = "RL1";
    String idClient = "RK1";
    String idArticle = "40067022";
    String artvar = "1";
    String typLu = "EURO";
    Long layer = 1L;
    String oldFlgShippable = "1";
    String newFlgShippable = "0";

    // Select View
    ArtVPuLuType artVPuLuTypeBefore = artVPuLuTypeRep.findOne(new ArtVPuLuTypePk(idSite, idClient, idArticle, artvar, typLu));
    cucumberReport.setMessage(artVPuLuTypeBefore.toString() + " ---> " + artVPuLuTypeBefore.getFlgShippable());
    oldFlgShippable = artVPuLuTypeBefore.getFlgShippable();

    newFlgShippable = "0".equals(oldFlgShippable) ? "1" : "0";

    // Change Data in base table
    ArtArtPackingUnit artArtpackingUnit = artArtPackingUnitRep
        .findOne(new ArtArtPackingUnitPk(generalHelper.getIdSite(), generalHelper.getIdClient(), idArticle, artvar, layer));
    artArtpackingUnit.setFlgShippable(newFlgShippable);

    // Reselect View
    ArtVPuLuType artVPuLuTypeAfter = artVPuLuTypeRep.findOne(new ArtVPuLuTypePk(idSite, idClient, idArticle, artvar, typLu));
    cucumberReport.setMessage(artVPuLuTypeAfter.toString() + " ---> " + artVPuLuTypeAfter.getFlgShippable());
    assertEquals(oldFlgShippable, artVPuLuTypeAfter.getFlgShippable());

    // Restore original value
    artArtpackingUnit.setFlgShippable(oldFlgShippable);

  }

  @Given("View selection with flush shows old value")
  @Transactional(propagation = Propagation.REQUIRED)
  public void viewSelectionWithFlush() {
    String idSite = "RL1";
    String idClient = "RK1";
    String idArticle = "40067022";
    String artvar = "1";
    String typLu = "EURO";
    Long layer = 1L;
    String oldFlgShippable = "1";
    String newFlgShippable = "0";

    // Select View
    ArtVPuLuType artVPuLuTypeBefore = artVPuLuTypeRep.findOne(new ArtVPuLuTypePk(idSite, idClient, idArticle, artvar, typLu));
    cucumberReport.setMessage(artVPuLuTypeBefore.toString() + " ---> " + artVPuLuTypeBefore.getFlgShippable());
    oldFlgShippable = artVPuLuTypeBefore.getFlgShippable();

    newFlgShippable = "0".equals(oldFlgShippable) ? "1" : "0";

    // Change Data in base table
    ArtArtPackingUnit artArtpackingUnit = artArtPackingUnitRep
        .findOne(new ArtArtPackingUnitPk(generalHelper.getIdSite(), generalHelper.getIdClient(), idArticle, artvar, layer));
    artArtpackingUnit.setFlgShippable(newFlgShippable);

    // Flush entity manager
    artVPuLuTypeRep.flush();

    // Reselect View
    ArtVPuLuType artVPuLuTypeAfter = artVPuLuTypeRep.findOne(new ArtVPuLuTypePk(idSite, idClient, idArticle, artvar, typLu));
    cucumberReport.setMessage(artVPuLuTypeAfter.toString() + " ---> " + artVPuLuTypeAfter.getFlgShippable());
    assertEquals(oldFlgShippable, artVPuLuTypeAfter.getFlgShippable());

    // Restore original value
    artArtpackingUnit.setFlgShippable(oldFlgShippable);
  }

  @Given("View selection with flush and readDataBaseEnforced shows new value")
  @Transactional(propagation = Propagation.REQUIRED)
  public void viewSelectionWithEnforcedRead() {
    String idSite = "RL1";
    String idClient = "RK1";
    String idArticle = "40067022";
    String artvar = "1";
    String typLu = "EURO";
    Long layer = 1L;
    String oldFlgShippable = "1";
    String newFlgShippable = "0";

    // Select View
    Optional<ArtVPuLuType> artVPuLuTypeBefore = artVPuLuTypeRep.findById(new ArtVPuLuTypePk(idSite, idClient, idArticle, artvar, typLu));
    if (artVPuLuTypeBefore.isPresent()) {
      cucumberReport.setMessage(artVPuLuTypeBefore.get().toString() + " ---> " + artVPuLuTypeBefore.get().getFlgShippable());
      oldFlgShippable = artVPuLuTypeBefore.get().getFlgShippable();
    }

    newFlgShippable = "0".equals(oldFlgShippable) ? "1" : "0";

    // Change Data in base table
    ArtArtPackingUnit artArtpackingUnit = artArtPackingUnitRep
        .findOne(new ArtArtPackingUnitPk(generalHelper.getIdSite(), generalHelper.getIdClient(), idArticle, artvar, layer));
    artArtpackingUnit.setFlgShippable(newFlgShippable);

    artArtPackingUnitRep.flush();

    // Reselect View
    ArtVPuLuType artVPuLuTypeAfter = artVPuLuTypeRep.findOne(new ArtVPuLuTypePk(idSite, idClient, idArticle, artvar, typLu));
    ArtVPuLuType artArtPuLuType = artVPuLuTypeRep.readFromDatabaseEnforced(artVPuLuTypeAfter);
    cucumberReport.setMessage(artArtPuLuType.toString() + " ---> " + artArtPuLuType.getFlgShippable());
    assertEquals(newFlgShippable, artArtPuLuType.getFlgShippable());

    // Restore original value
    artArtpackingUnit.setFlgShippable(oldFlgShippable);
  }

  @Given("View selection with flush shows new value for first view query")
  @Transactional(propagation = Propagation.REQUIRED)
  public void viewSelectionWithFlushAndFirstQuery() {
    String idSite = "RL1";
    String idClient = "RK1";
    String idArticle = "40067022";
    String artvar = "1";
    String typLu = "EURO";
    Long layer = 1L;
    String oldFlgShippable = "1";
    String newFlgShippable = "2";

    // Change Data in base table
    ArtArtPackingUnit artArtpackingUnit = artArtPackingUnitRep
        .findOne(new ArtArtPackingUnitPk(generalHelper.getIdSite(), generalHelper.getIdClient(), idArticle, artvar, layer));
    artArtpackingUnit.setFlgShippable(newFlgShippable);

    artArtPackingUnitRep.flush();

    // Reselect View
    ArtVPuLuType artVPuLuTypeAfter = artVPuLuTypeRep.findOne(new ArtVPuLuTypePk(idSite, idClient, idArticle, artvar, typLu));
    cucumberReport.setMessage(artVPuLuTypeAfter.toString() + " ---> " + artVPuLuTypeAfter.getFlgShippable());
    assertEquals(newFlgShippable, artVPuLuTypeAfter.getFlgShippable());

    // Restore original value
    artArtpackingUnit.setFlgShippable(oldFlgShippable);
  }

  @Given("View selection without flush shows old value for first view query")
  @Transactional(propagation = Propagation.REQUIRED)
  public void viewSelectionWithoutFlushAndFirstQuery() {
    String idSite = "RL1";
    String idClient = "RK1";
    String idArticle = "40067022";
    String artvar = "1";
    String typLu = "EURO";
    Long layer = 1L;
    String oldFlgShippable = "1";
    String newFlgShippable = "2";

    // Change Data in base table
    ArtArtPackingUnit artArtpackingUnit = artArtPackingUnitRep
        .findOne(new ArtArtPackingUnitPk(generalHelper.getIdSite(), generalHelper.getIdClient(), idArticle, artvar, layer));
    artArtpackingUnit.setFlgShippable(newFlgShippable);

    // Reselect View
    ArtVPuLuType artVPuLuTypeAfter = artVPuLuTypeRep.findOne(new ArtVPuLuTypePk(idSite, idClient, idArticle, artvar, typLu));
    cucumberReport.setMessage(artVPuLuTypeAfter.toString() + " ---> " + artVPuLuTypeAfter.getFlgShippable());
    assertEquals(oldFlgShippable, artVPuLuTypeAfter.getFlgShippable());

    // Restore original value
    artArtpackingUnit.setFlgShippable(oldFlgShippable);
  }
}
