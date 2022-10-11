package com.inconso.bend.inwmsx.it.article;

import com.inconso.bend.article.pers.gen.ArtArticlePk;
import com.inconso.bend.article.pers.model.ArtArticle;
import com.inconso.bend.article.pers.rep.ArtArticleRep;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import io.cucumber.java.en.And;

public class ArtArticleHandler {

  @Autowired
  private GeneralHelper generalHelper;

  @Autowired
  private ArtArticleRep artArticleRep;

  @And("for article = {string} typBdd is set to {string}")
  @Transactional(propagation = Propagation.REQUIRES_NEW)
  public void setTypBdd(String idArticle, String typBdd) {
    if (idArticle != null && typBdd != null) {

      ArtArticle artArticle = artArticleRep.findOne(new ArtArticlePk(generalHelper.getIdClient(), idArticle));
      artArticle.setTypBbd(typBdd);

    }
  }

}
