package com.inconso.bend.inwmsx.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.inconso.bend.core.service.ServiceProxy;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.core.service.api.ServiceOutput;
import com.inconso.bend.inwmsx.logic.InwmsXController;
import com.inconso.bend.inwmsx.service.api.InwmsXDesc;
import com.inconso.bend.inwmsx.service.api.SampleInput;
import com.inconso.bend.inwmsx.service.api.SampleOutput;

/**
 * Example of a simple sample service with one endpoint at SampleDesc.SAMPLE_SERVICE_EP
 * 
 * @author dhochstrasser
 *
 */
@RestController
public class BwmsInwmsXService {

  @Autowired
  private ServiceProxy   serviceProxy;
  @Autowired
  private InwmsXController controller;

  @RequestMapping(path = InwmsXDesc.SERVICE + "/" + InwmsXDesc.SAMPLE_EP, method = RequestMethod.POST)
  public ResponseEntity<ServiceOutput<SampleOutput>> service(@RequestBody ServiceInput<SampleInput> input, @RequestHeader HttpHeaders headers) {
    ServiceOutput<SampleOutput> output = new ServiceOutput<>();
    HttpStatus status = serviceProxy.callService(input, output, headers, controller, InwmsXDesc.SAMPLE_EP, InwmsXDesc.getIt());
    return new ResponseEntity<ServiceOutput<SampleOutput>>(output, status);
  }

}
