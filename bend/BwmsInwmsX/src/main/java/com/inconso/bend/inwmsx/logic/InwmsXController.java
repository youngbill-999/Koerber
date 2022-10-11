package com.inconso.bend.inwmsx.logic;

import com.inconso.bend.core.service.CoreController;
import com.inconso.bend.core.service.api.CoreOutput;
import com.inconso.bend.inwmsx.service.api.SampleInput;

/**
 * Sample controller as entry point of the logic of a Web Service.
 * @author ANRUPPEL
 *
 */
public interface InwmsXController extends CoreController{
  
  public CoreOutput doSomething(SampleInput input);
}
