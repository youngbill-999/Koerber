package com.inconso.bend.inwmsx.service.api;

import com.inconso.bend.core.service.api.ServiceDesc;

/**
 * The endpoint description of the Sample-Service
 * 
 * @author dhochstrasser
 *
 */
public class InwmsXDesc extends ServiceDesc {

  public static final String      SERVICE   = "bwmsInwmsXService";
  public static final String      SAMPLE_EP = "test";

  private static final InwmsXDesc SINGLETON = new InwmsXDesc();

  private InwmsXDesc() {
    super(SERVICE);
    putEle(SAMPLE_EP, SampleInput.class, SampleOutput.class);
  }

  public static InwmsXDesc getIt() {
    return SINGLETON;
  }
}
