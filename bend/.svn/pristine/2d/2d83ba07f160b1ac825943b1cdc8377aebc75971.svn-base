package com.inconso.bend.inwmsx.it.grbase;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.advice.pers.gen.AvAdviceItemPk;
import com.inconso.bend.advice.pers.gen.AvAdvicePk;
import com.inconso.bend.advice.pers.model.AvAdvice;
import com.inconso.bend.advice.pers.model.AvAdviceItem;
import com.inconso.bend.advice.pers.rep.AvAdviceItemRep;
import com.inconso.bend.advice.pers.rep.AvAdviceRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;

public class AdviceDataHandler {

  @Autowired
  private AvAdviceRep           avAdviceRep;

  @Autowired
  private AvAdviceItemRep       avAdviceItemRep;

  @Autowired
  private GrDeliveryDataHandler grDeliveryDataHandler;

  @Autowired
  private GeneralHelper         generalHelper;

  @Given("advice {string} created")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void createAdvice(String key) {
    String advicePkNum = generalHelper.getNextSequenceNumber("AV_SEQ_ADVICE_NO");

    AvAdvice avAdvice = new AvAdvice(new AvAdvicePk(generalHelper.getIdSite(), generalHelper.getIdClient(), advicePkNum));
    avAdvice.setStat("00"); // Statuskonstante?
    avAdvice.setTypAdvice("DEF");

    avAdviceRep.persist(avAdvice);

    grDeliveryDataHandler.putAvAdvice(key, avAdvice);
  }

  @Given("adviceItem {Long} created for advice {string} with: idArticle = {String}, typOverDelivery = {String}, typUnderDelivery = {String}, numItem = {Long}")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void createAdviceItem(Long numItemAdvice, String key, String idArticle, String typOverDelivery, String typUnderDelivery, Long numItem) {
    AvAdvicePk avAdvicePk = grDeliveryDataHandler.getAvAdvice(key).getAvAdvicePk();
    AvAdviceItem avAdviceItem = new AvAdviceItem(
        new AvAdviceItemPk(avAdvicePk.getIdSite(), avAdvicePk.getIdClient(), avAdvicePk.getIdAdvice(), numItemAdvice));

    avAdviceItem.setQtyTarget(numItem.doubleValue());
    avAdviceItem.setQtyTargetOrig(numItem.doubleValue());
    avAdviceItem.setQtyCanceled(Double.valueOf(0));
    avAdviceItem.setQtyActual(Double.valueOf(0));
    avAdviceItem.setStat("00");
    avAdviceItem.setIdArticle(idArticle);
    avAdviceItem.setTypOverDelivery(typOverDelivery);
    avAdviceItem.setTypUnderDelivery(typUnderDelivery);
    avAdviceItemRep.persist(avAdviceItem);
  }

  @And("advice {string} reached status {String}")
  @Transactional(readOnly = true)
  public void verifyAdviceStatus(String key, String status) {
    AvAdvicePk avAdvicePk = grDeliveryDataHandler.getAvAdvice(key).getAvAdvicePk();

    assertEquals(status, avAdviceRep.findOne(avAdvicePk).getStat());
  }

}
