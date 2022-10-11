package com.inconso.bend.inwmsx.logic.aspect;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;
import com.inconso.bend.core.config.BendCoreAspectProperties;
import com.inconso.bend.core.logic.log.aspect.LogEntryExitDefaultAspect;

/**
 * 
 * This is only a test aspect.
 *
 */
@Aspect
@Component
@ConditionalOnProperty(name = "core.logging.aspectj.example.activated", havingValue = "true", matchIfMissing = false)
public class LogEntryExitExampleAspect extends LogEntryExitDefaultAspect {

  protected LogEntryExitExampleAspect(BendCoreAspectProperties bendCoreAspectProperties) {
    super(bendCoreAspectProperties);
  }

  /**
   * All methods that are not in final classes in the package logic except for core and implementation of the AbstractTcsTransportPlanning.
   */
  @Pointcut("within(com.inconso.bend..logic..*) && " + "!within(com.inconso.bend.core.logic..*) && "
      + "!within(com.inconso.bend.transport.logic.api.AbstractTcsTransportPlanning+) && " + "!within(is(EnumType)) && " + "!within(is(FinalType))")
  public void allMethodsInLogic() {
    // EMPTY METHOD
  }

  /**
   * All public methods not final.
   */
  @Pointcut("execution(public !final * *(..))")
  public void allPublicMethods() {
    // EMPTY METHOD
  }

  /**
   * Main Pointcut.
   */
  @Override
  @Pointcut("allPublicMethods() && allMethodsInLogic()")
  public void pointCutLogEntryExit() {
    // EMPTY METHOD
  }

}
