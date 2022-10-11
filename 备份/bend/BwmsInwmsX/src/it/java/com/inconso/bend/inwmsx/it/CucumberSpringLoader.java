package com.inconso.bend.inwmsx.it;

import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import com.inconso.bend.address.config.BendAddressConfiguration;
import com.inconso.bend.advice.config.BwmsAdviceConfiguration;
import com.inconso.bend.article.config.BwmsArticleConfiguration;
import com.inconso.bend.bizcal.config.BendBizcalConfiguration;
import com.inconso.bend.bpsched.config.BwmsBPSchedConfiguration;
import com.inconso.bend.core.config.BendCoreConfiguration;
import com.inconso.bend.core.logic.BendUserManager;
import com.inconso.bend.dectree.config.BendDecTreeConfiguration;
import com.inconso.bend.forklift.config.BwmsForkliftConfiguration;
import com.inconso.bend.gdl.config.BendGdlConfiguration;
import com.inconso.bend.gibase.config.BwmsGIBaseConfiguration;
import com.inconso.bend.grbase.config.BwmsGRBaseConfiguration;
import com.inconso.bend.grdbasegdl.config.BwmsGRBaseGdlConfiguration;
import com.inconso.bend.inventory.config.BwmsInventoryConfiguration;
import com.inconso.bend.inventory.init.config.BwmsInventoryInitConfiguration;
import com.inconso.bend.inventorygdl.config.BwmsInventoryGdlConfiguration;
import com.inconso.bend.inwmsx.config.BwmsInwmsXConfiguration;
import com.inconso.bend.ipc.config.BendIpcConfiguration;
import com.inconso.bend.load.config.BwmsLoadingConfiguration;
import com.inconso.bend.load.gdl.config.BwmsLoadingGdlConfiguration;
import com.inconso.bend.message.config.BendMessageConfiguration;
import com.inconso.bend.messagepro.config.BwmsMessageProConfiguration;
import com.inconso.bend.occupation.config.BwmsOccupationConfiguration;
import com.inconso.bend.ordres.config.BwmsOrdresConfiguration;
import com.inconso.bend.pabase.config.BwmsPaBaseConfiguration;
import com.inconso.bend.packing.config.BwmsPackingConfiguration;
import com.inconso.bend.parmgmt.config.BwmsParMgmtConfiguration;
import com.inconso.bend.picking.config.BwmsPickingConfiguration;
import com.inconso.bend.picking.gdl.config.BwmsPickingGdlConfiguration;
import com.inconso.bend.print.config.BendPrintConfiguration;
import com.inconso.bend.project.Application;
import com.inconso.bend.reo.config.BendReoConfiguration;
import com.inconso.bend.repbase.config.BwmsRepBaseConfiguration;
import com.inconso.bend.repprev.config.BwmsRepPrevConfiguration;
import com.inconso.bend.reserv.config.BwmsReservConfiguration;
import com.inconso.bend.ship.config.BwmsShippingConfiguration;
import com.inconso.bend.slaasgmt.config.BwmsSlaasgmtConfiguration;
import com.inconso.bend.slsearch.config.BwmsSLSearchConfiguration;
import com.inconso.bend.stm.config.BwmsStocktakeConfiguration;
import com.inconso.bend.stmartcnt.config.BwmsStmArtCntConfiguration;
import com.inconso.bend.stmg.config.BwmsStocktakeGdlConfiguration;
import com.inconso.bend.stockavail.config.BwmsStockAvailConfiguration;
import com.inconso.bend.tectools.config.BendTectoolsConfiguration;
import com.inconso.bend.tools.config.BendToolsConfiguration;
import com.inconso.bend.topology.config.BwmsTopologyConfiguration;
import com.inconso.bend.tourmgmt.config.BwmsTourMgmtConfiguration;
import com.inconso.bend.transport.config.BwmsTransportConfiguration;
import com.inconso.bend.user.config.BendUserConfiguration;
import com.inconso.bend.wmsbase.config.BwmsBaseConfiguration;
import com.inconso.bend.workctr.config.BwmsWorkctrConfiguration;
import com.inconso.bend.workctr.gdl.config.BwmsWorkctrGdlConfiguration;
import io.cucumber.java.Before;
import io.cucumber.spring.CucumberContextConfiguration;

@SpringBootTest(classes = Application.class, webEnvironment = WebEnvironment.RANDOM_PORT)
@ActiveProfiles("integration-test")

// @formatter:off
@ContextHierarchy({ @ContextConfiguration(classes = { 
    BendAddressConfiguration.class, 
    BendBizcalConfiguration.class, 
    BendCoreConfiguration.class,
    BendDecTreeConfiguration.class, 
    BendGdlConfiguration.class, 
    BendIpcConfiguration.class, 
    BendMessageConfiguration.class,
    BendPrintConfiguration.class, 
    BendReoConfiguration.class, 
    BendTectoolsConfiguration.class, 
    BendToolsConfiguration.class,
    BendUserConfiguration.class, 
    BwmsAdviceConfiguration.class, 
    BwmsArticleConfiguration.class, 
    BwmsBaseConfiguration.class,
    BwmsBPSchedConfiguration.class, 
    BwmsForkliftConfiguration.class, 
    BwmsGIBaseConfiguration.class, 
    BwmsGRBaseGdlConfiguration.class,
    BwmsGRBaseConfiguration.class, 
    BwmsInventoryConfiguration.class, 
    BwmsInventoryGdlConfiguration.class, 
    BwmsInventoryInitConfiguration.class,
    BwmsInwmsXConfiguration.class, 
    BwmsLoadingConfiguration.class, 
    BwmsLoadingGdlConfiguration.class, 
    BwmsMessageProConfiguration.class,
    BwmsOccupationConfiguration.class, 
    BwmsOrdresConfiguration.class, 
    BwmsPaBaseConfiguration.class, 
    BwmsPackingConfiguration.class,
    BwmsParMgmtConfiguration.class, 
    BwmsPickingConfiguration.class, 
    BwmsPickingGdlConfiguration.class, 
    BwmsRepBaseConfiguration.class,
    BwmsRepPrevConfiguration.class, 
    BwmsReservConfiguration.class, 
    BwmsShippingConfiguration.class, 
    BwmsSlaasgmtConfiguration.class,
    BwmsSLSearchConfiguration.class, 
    BwmsStmArtCntConfiguration.class, 
    BwmsStockAvailConfiguration.class, 
    BwmsStocktakeConfiguration.class,
    BwmsStocktakeGdlConfiguration.class, 
    BwmsTopologyConfiguration.class, 
    BwmsTourMgmtConfiguration.class, 
    BwmsTransportConfiguration.class,
    BwmsWorkctrConfiguration.class, 
    BwmsWorkctrGdlConfiguration.class 
    }) })
// @formatter:on
@CucumberContextConfiguration
public class CucumberSpringLoader {

  /**
   * Cucumber hook to always set the user before any Scenario
   */
  @Before(order = 0)
  public void init() {
    BendUserManager.getManager().setIdUser("AUTO_IT");
  }
}
