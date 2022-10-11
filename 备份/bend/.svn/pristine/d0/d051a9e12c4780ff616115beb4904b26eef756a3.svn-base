package com.inconso.bend.inwmsx.it.workctr;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.workctr.pers.gen.WcWorkcenterParaPk;
import com.inconso.bend.workctr.pers.model.WcWorkcenterPara;
import com.inconso.bend.workctr.pers.rep.WcWorkcenterParaRep;
import io.cucumber.java.en.Given;

public class WorkctrStepDefinition {

  @Autowired
  private GeneralHelper       generalHelper;

  @Autowired
  private WcWorkcenterParaRep wcWorkcenterParaRep;

  @Given("the parameter {string} of workcenter {string} is set to {string}")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void aNewRoutingVersionIsCreated(String paraName, String workcenter, String paraValue) {
    WcWorkcenterParaPk wcParaKey = new WcWorkcenterParaPk(generalHelper.getIdSite(), workcenter, paraName);
    Optional<WcWorkcenterPara> para = wcWorkcenterParaRep.findById(wcParaKey);
    if (para.isPresent()) {
      para.get().setParaValue(paraValue);
    } else {
      WcWorkcenterPara newPara = new WcWorkcenterPara(new WcWorkcenterParaPk(generalHelper.getIdSite(), workcenter, paraName));
      newPara.setParaValue(paraValue);
      wcWorkcenterParaRep.persist(newPara);
    }

  }
}
