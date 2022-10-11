package com.inconso.bend.inwmsx.logic;

import org.springframework.stereotype.Component;
import com.inconso.bend.core.config.BendCoreTextCodes;
import com.inconso.bend.core.exception.BendException;
import com.inconso.bend.core.service.api.CoreInput;
import com.inconso.bend.core.service.api.CoreOutput;
import com.inconso.bend.inwmsx.service.api.InwmsXDesc;
import com.inconso.bend.inwmsx.service.api.SampleInput;
import com.inconso.bend.inwmsx.service.api.SampleOutput;

/**
 * Sample controller as entry point of the logic of a Web Service.
 * 
 * @author ANRUPPEL
 *
 */
@Component
public class InwmsXControllerImpl implements InwmsXController {

  /**
   * Default constructor.
   */
  public InwmsXControllerImpl() {
  }

  /**
   * Core of a controller, entry point for logical implementation. Sample with definition of return value.
   */
  @Override
  public CoreOutput executeService(String function, CoreInput input) {
    switch (function) {
    case InwmsXDesc.SAMPLE_EP:
      if (!(input instanceof SampleInput)) {
        String service = InwmsXDesc.getIt().getService();
        throw new BendException(BendCoreTextCodes.BEND_0003, service, InwmsXDesc.SAMPLE_EP, input.getClass().getName());
      }
      return doSomething((SampleInput) input);
    default:
      String service = InwmsXDesc.getIt().getService();
      throw new BendException(BendCoreTextCodes.BEND_0004, function, service);
    }
  }

  @Override
  public SampleOutput doSomething(SampleInput input) {
    // Implementation of logic
    return new SampleOutput();
  }

}
