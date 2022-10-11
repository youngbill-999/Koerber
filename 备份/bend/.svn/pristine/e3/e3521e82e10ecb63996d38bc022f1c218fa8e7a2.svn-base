package com.inconso.bend.inwmsx.it.general;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.core.service.api.BendHasher;
import com.inconso.bend.core.service.api.CoreInput;
import com.inconso.bend.core.service.api.ServiceInput;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public final class WebserviceClient {

  private Map<String, Object> serviceResult;

  /**
   * Calls the given webservice and stores the result.
   * 
   * @param service
   *          name of the service e.g. InventoryTransactionDesc.SERVICE
   * @param ep
   *          name of the end point e.g.
   * @param input
   *          given input, wrapped as ServiceInput
   * @param <E>
   *          any CoreInput that must match the defined service
   * 
   * @return this object to provide a fluent interface
   */
  @SuppressWarnings("unchecked")
  public <E extends CoreInput> WebserviceClient call(String service, String ep, ServiceInput<E> input) {
    String userSecret = "AUTO_SECRET";
    String user = "basis";
    // demo to show how to add custom header Globally for the http request in spring test template , like user header
    TestRestTemplate template = new TestRestTemplate();
    template.getRestTemplate().setInterceptors(Collections.singletonList((request, body, execution) -> {
      request.getHeaders().add("user", user);
      request.getHeaders().add("timestamp", "1");
      request.getHeaders().add("BendSecret", BendHasher.getIt().hash(userSecret, user, 1));
      return execution.execute(request, body);
    }));

    serviceResult = template.postForObject("http://localhost:8500/" + service + "/" + ep, input, LinkedHashMap.class);
    System.out.println(serviceResult);

    return this;
  }

  /**
   * Returns the result of the webservice call.
   * 
   * @return map containing the result
   */
  public Map<String, Object> getResult() {
    return serviceResult;
  }

  /**
   * Extracts the data from the result when the webservice call was successful.
   * 
   * @return map containing the data
   */
  @SuppressWarnings("unchecked")
  public Map<String, Object> getData() {
    return (Map<String, Object>) serviceResult.get("data");
  }

  /**
   * Extracts the output from the result when the webservice call was successful.
   * 
   * @return map containing the output
   */
  @SuppressWarnings("unchecked")
  public List<Map<String, Object>> getOutput() {
    return (List<Map<String, Object>>) getData().get("output");
  }

  /**
   * Verifies that webservice call was successful.
   * 
   * @return this object to provide a fluent interface
   */
  public WebserviceClient verifySuccess() {
    assertAll(() -> assertTrue(isSuccess(), getErrorCode() + ": " + getErrorMessage()), () -> assertNotNull(getData()));
    return this;
  }

  /**
   * Verifies that webservice call has failed.
   * 
   * @return this object to provide a fluent interface
   */
  public WebserviceClient verifyFailure() {
    assertAll(() -> assertFalse(isSuccess()), () -> assertNotNull(getErrorCode()));
    return this;
  }

  public String getErrorCode() {
    return (String) serviceResult.get("errorCode");
  }

  public String getErrorMessage() {
    return (String) serviceResult.get("errorMessage");
  }

  private boolean isSuccess() {
    return (boolean) serviceResult.get("success");
  }

}
