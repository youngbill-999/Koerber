package com.inconso.bend.inwmsx.service;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedHashMap;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.logging.LoggingFeature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import com.inconso.bend.core.service.api.BendHasher;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.core.service.api.ServiceOutput;
import com.inconso.bend.inwmsx.service.api.InwmsXDesc;
import com.inconso.bend.inwmsx.service.api.SampleInput;
import com.inconso.bend.inwmsx.service.api.SampleOutput;

public class SampleServiceClient {
	
	private Logger   log           = LoggerFactory.getLogger(SampleServiceClient.class);
	
    public static void main(String[] args) {
      SampleServiceClient me = new SampleServiceClient();
      me.execute();
    }

    private void execute() {

      // build up the input - in the general part for the moment just the user
      ServiceInput<SampleInput> input = new ServiceInput<>();
      input.setData(new SampleInput());

      // make the rest-call with our input and getting the general output in which the Funk1Output is contained...
      Client client = ClientBuilder.newClient(new ClientConfig().register(LoggingFeature.class));
      WebTarget webTarget = client.target("http://localhost:8500/"+ InwmsXDesc.SERVICE+ "/" + InwmsXDesc.SAMPLE_EP);
      Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON).headers(setupHeaderParams(1));
      Response response = invocationBuilder.post(Entity.entity(input, MediaType.APPLICATION_JSON));
      ServiceOutput<SampleOutput> output = response.readEntity(new GenericType<ServiceOutput<SampleOutput>>() {
      });

      // some error-handling (of course, this is till now not complete...) - and as result of the call a sysout of the output
      if (HttpStatus.valueOf(response.getStatus()).is2xxSuccessful()) {
        SampleOutput out = output.getData();
        if (out == null) {
        	log.error("fOut == null");
        } else {
        	log.error("Result of call: " + out.getResult());
        }
      } else {
    	  log.error("Error: " + response.getStatus());
    	  log.error("Error: " + output.getErrorMessage());
      }
    }
    
    private MultivaluedMap<String, Object> setupHeaderParams(long startTime) {
      //
      // get the user secret - mabe call the logon
      String userSecret = "hugo";
      String user = "BASIS";
      //
      MultivaluedMap<String, Object> headerParams = new MultivaluedHashMap<String, Object>();
      headerParams.add("user", user);
      headerParams.add("timestamp", startTime);
      headerParams.add("BendSecret", BendHasher.getIt().hash(userSecret, user, startTime));
      return headerParams;
    }
}

