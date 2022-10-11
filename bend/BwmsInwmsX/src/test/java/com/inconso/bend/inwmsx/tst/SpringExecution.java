package com.inconso.bend.inwmsx.tst;

import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.address.config.BendAddressConfiguration;
import com.inconso.bend.advice.config.BwmsAdviceConfiguration;
import com.inconso.bend.adviceitf.config.BwmsAdviceItfConfiguration;
import com.inconso.bend.amr.config.BwmsAmrConfiguration;
import com.inconso.bend.amritf.config.BwmsAmrItfConfiguration;
import com.inconso.bend.article.config.BwmsArticleConfiguration;
import com.inconso.bend.batch.config.BwmsBatchConfiguration;
import com.inconso.bend.batchgr.config.BwmsBatchGrConfiguration;
import com.inconso.bend.bcon.config.BendBconConfiguration;
import com.inconso.bend.bizcal.config.BendBizcalConfiguration;
import com.inconso.bend.bpaction.config.BwmsBPActionConfiguration;
import com.inconso.bend.bpsched.config.BwmsBPSchedConfiguration;
import com.inconso.bend.bwmsgipi.config.BwmsGiPiConfiguration;
import com.inconso.bend.bwmslurequest.config.BwmsLURequestConfiguration;
import com.inconso.bend.bwmstcswcsitf.config.BwmsTcsWcsItfConfiguration;
import com.inconso.bend.config.config.BendConfigConfiguration;
import com.inconso.bend.core.config.BendCoreConfiguration;
import com.inconso.bend.dectree.config.BendDecTreeConfiguration;
import com.inconso.bend.distrib.config.BwmsDistribConfiguration;
import com.inconso.bend.distrib.gdl.config.BwmsDistribGdlConfiguration;
import com.inconso.bend.forklift.config.BwmsForkliftConfiguration;
import com.inconso.bend.gdl.config.BendGdlConfiguration;
import com.inconso.bend.gibase.config.BwmsGIBaseConfiguration;
import com.inconso.bend.gibaseitf.config.BwmsGIBaseItfConfiguration;
import com.inconso.bend.giprocess.config.BwmsGIProcessConfiguration;
import com.inconso.bend.grbase.config.BwmsGRBaseConfiguration;
import com.inconso.bend.grdbasegdl.config.BwmsGRBaseGdlConfiguration;
import com.inconso.bend.grprocess.config.BwmsGRProcessConfiguration;
import com.inconso.bend.hoi.config.HoiConfiguration;
import com.inconso.bend.hoimsg.config.BendHoiMsgConfiguration;
import com.inconso.bend.hoisap.config.BendHoiSapConfiguration;
import com.inconso.bend.inventory.config.BwmsInventoryConfiguration;
import com.inconso.bend.inventory.diff.config.BwmsInventoryDiffConfiguration;
import com.inconso.bend.inventory.init.config.BwmsInventoryInitConfiguration;
import com.inconso.bend.inventorygdl.config.BwmsInventoryGdlConfiguration;
import com.inconso.bend.inventoryitf.config.BwmsInventoryItfConfiguration;
import com.inconso.bend.inwmsx.config.BwmsInwmsXConfiguration;
import com.inconso.bend.ipc.config.BendIpcConfiguration;
import com.inconso.bend.load.config.BwmsLoadingConfiguration;
import com.inconso.bend.load.gdl.config.BwmsLoadingGdlConfiguration;
import com.inconso.bend.lsacollect.config.BwmsLsaCollectConfiguration;
import com.inconso.bend.lsamsg.config.BendLsaMsgConfiguration;
import com.inconso.bend.mail.config.BendMailConfiguration;
import com.inconso.bend.message.config.BendMessageConfiguration;
import com.inconso.bend.messagepro.config.BwmsMessageProConfiguration;
import com.inconso.bend.messageprt.config.BendMessagePrtConfiguration;
import com.inconso.bend.occupation.config.BwmsOccupationConfiguration;
import com.inconso.bend.ordres.config.BwmsOrdresConfiguration;
import com.inconso.bend.pabase.config.BwmsPaBaseConfiguration;
import com.inconso.bend.packing.config.BwmsPackingConfiguration;
import com.inconso.bend.parmgmt.config.BwmsParMgmtConfiguration;
import com.inconso.bend.pickdist.config.BwmsPickDistConfiguration;
import com.inconso.bend.picking.config.BwmsPickingConfiguration;
import com.inconso.bend.picking.gdl.config.BwmsPickingGdlConfiguration;
import com.inconso.bend.print.config.BendPrintConfiguration;
import com.inconso.bend.priority.config.BwmsPriorityConfiguration;
import com.inconso.bend.rackmgmt.config.BwmsRackmgmtConfiguration;
import com.inconso.bend.reo.config.BendReoConfiguration;
import com.inconso.bend.repbase.config.BwmsRepBaseConfiguration;
import com.inconso.bend.repprev.config.BwmsRepPrevConfiguration;
import com.inconso.bend.repres.config.BwmsRepResConfiguration;
import com.inconso.bend.reserv.config.BwmsReservConfiguration;
import com.inconso.bend.ship.config.BwmsShippingConfiguration;
import com.inconso.bend.slaasgmt.config.BwmsSlaasgmtConfiguration;
import com.inconso.bend.slsearch.config.BwmsSLSearchConfiguration;
import com.inconso.bend.snmbase.config.BwmsSnmBaseConfiguration;
import com.inconso.bend.stm.config.BwmsStocktakeConfiguration;
import com.inconso.bend.stmartcnt.config.BwmsStmArtCntConfiguration;
import com.inconso.bend.stmg.config.BwmsStocktakeGdlConfiguration;
import com.inconso.bend.stmperpet.gdl.config.BwmsStmperpetGdlConfiguration;
import com.inconso.bend.stmreceiv.config.BwmsStmReceivConfiguration;
import com.inconso.bend.stockavail.config.BwmsStockAvailConfiguration;
import com.inconso.bend.tectools.config.BendTectoolsConfiguration;
import com.inconso.bend.tools.config.BendToolsConfiguration;
import com.inconso.bend.topdist.config.BwmsTopDistConfiguration;
import com.inconso.bend.topology.config.BwmsTopologyConfiguration;
import com.inconso.bend.tourmgmt.config.BwmsTourMgmtConfiguration;
import com.inconso.bend.transport.config.BwmsTransportConfiguration;
import com.inconso.bend.user.config.BendUserConfiguration;
import com.inconso.bend.vasbase.config.BwmsVasBaseConfiguration;
import com.inconso.bend.vasgr.config.BwmsVasGrConfiguration;
import com.inconso.bend.vasgrgdl.config.BwmsVasGrGdlConfiguration;
import com.inconso.bend.wcppriority.config.BwmsWcpPriorityConfiguration;
import com.inconso.bend.wmsbase.config.BwmsBaseConfiguration;
import com.inconso.bend.wmswcsitf.config.BendWmsWcsItfConfiguration;
import com.inconso.bend.workctr.config.BwmsWorkctrConfiguration;
import com.inconso.bend.workctr.gdl.config.BwmsWorkctrGdlConfiguration;
import com.inconso.bend.workctrplan.config.BwmsWorkctrPlanConfiguration;

// @formatter:off
@ExtendWith(SpringExtension.class)
@ActiveProfiles("unit-test")
@ContextHierarchy({ @ContextConfiguration(classes = {
    BendAddressConfiguration.class,
    BendBconConfiguration.class,
    BendBizcalConfiguration.class,
    BendConfigConfiguration.class,
    BendCoreConfiguration.class,
    BendDecTreeConfiguration.class,
    BendGdlConfiguration.class,
    BendHoiSapConfiguration.class,
    HoiConfiguration.class,
    BendHoiMsgConfiguration.class,
    BendIpcConfiguration.class,
    BendLsaMsgConfiguration.class,
    BendMailConfiguration.class,
    BendMessagePrtConfiguration.class,
    BendMessageConfiguration.class,
    BendPrintConfiguration.class,
    BendReoConfiguration.class,
    BendTectoolsConfiguration.class,
    BendToolsConfiguration.class,
    BendUserConfiguration.class,
    BendWmsWcsItfConfiguration.class,
    BwmsAdviceConfiguration.class,
    BwmsAdviceItfConfiguration.class,
    BwmsAmrConfiguration.class,
    BwmsAmrItfConfiguration.class,
    BwmsArticleConfiguration.class,
    BwmsBaseConfiguration.class,
    BwmsBatchConfiguration.class,
    BwmsBatchGrConfiguration.class,
    BwmsBPActionConfiguration.class,
    BwmsBPSchedConfiguration.class,
    BwmsDistribGdlConfiguration.class,
    BwmsDistribConfiguration.class,
    BwmsForkliftConfiguration.class,
    BwmsGIBaseConfiguration.class,
    BwmsGIBaseItfConfiguration.class,
    BwmsGiPiConfiguration.class,
    BwmsGIProcessConfiguration.class,
    BwmsGRBaseConfiguration.class,
    BwmsGRBaseGdlConfiguration.class,
    BwmsGRProcessConfiguration.class,
    BwmsInventoryDiffConfiguration.class,
    BwmsInventoryGdlConfiguration.class,
    BwmsInventoryInitConfiguration.class,
    BwmsInventoryItfConfiguration.class,
    BwmsInventoryConfiguration.class,
    BwmsInwmsXConfiguration.class,
    BwmsLoadingGdlConfiguration.class,
    BwmsLoadingConfiguration.class,
    BwmsLsaCollectConfiguration.class,
    BwmsLURequestConfiguration.class,
    BwmsMessageProConfiguration.class,
    BwmsOccupationConfiguration.class,
    BwmsOrdresConfiguration.class,
    BwmsPaBaseConfiguration.class,
    BwmsPackingConfiguration.class, 
    BwmsParMgmtConfiguration.class,
    BwmsPickDistConfiguration.class,
    BwmsPickingConfiguration.class,
    BwmsPickingGdlConfiguration.class,
    BwmsPriorityConfiguration.class,
    BwmsRackmgmtConfiguration.class,
    BwmsRepBaseConfiguration.class, 
    BwmsRepPrevConfiguration.class,
    BwmsRepResConfiguration.class,
    BwmsReservConfiguration.class,
    BwmsSnmBaseConfiguration.class,
    BwmsShippingConfiguration.class,
    BwmsSlaasgmtConfiguration.class,
    BwmsSLSearchConfiguration.class,
    BwmsStmArtCntConfiguration.class,
    BwmsStmperpetGdlConfiguration.class,
    BwmsStmReceivConfiguration.class,
    BwmsStockAvailConfiguration.class,
    BwmsStocktakeConfiguration.class,
    BwmsStocktakeGdlConfiguration.class,
    BwmsTcsWcsItfConfiguration.class,
    BwmsTopDistConfiguration.class,
    BwmsTopologyConfiguration.class,
    BwmsTourMgmtConfiguration.class,
    BwmsTransportConfiguration.class,
    BwmsVasBaseConfiguration.class,
    BwmsVasGrGdlConfiguration.class,
    BwmsVasGrConfiguration.class,
    BwmsWcpPriorityConfiguration.class,
    BwmsWorkctrConfiguration.class,
    BwmsWorkctrGdlConfiguration.class,
    BwmsWorkctrPlanConfiguration.class
    }) })
@Rollback
@Transactional
// @formatter:on
public interface SpringExecution {

}
