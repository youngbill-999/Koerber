package com.inconso.bend.inwmsx.service.api;

import java.util.List;
import java.util.Map;
import com.inconso.bend.core.service.api.CoreInput;

/**
 * Sample input for webservice calls. This model shall only contain setter and getter.
 * 
 * @author dhochstrasser
 *
 */
public class SampleInput extends CoreInput {

  private static final long   serialVersionUID = 1L;
  private String              s;
  private Long                l;
  private Double              d;
  private Boolean             b;
  private List<String>        list;
  private Map<String, String> map;

  public String getS() {
    return s;
  }

  public void setS(String s) {
    this.s = s;
  }

  public Long getL() {
    return l;
  }

  public void setL(Long l) {
    this.l = l;
  }

  public Double getD() {
    return d;
  }

  public void setD(Double d) {
    this.d = d;
  }

  public Boolean getB() {
    return b;
  }

  public void setB(Boolean b) {
    this.b = b;
  }

  public List<String> getList() {
    return list;
  }

  public void setList(List<String> list) {
    this.list = list;
  }

  public Map<String, String> getMap() {
    return map;
  }

  public void setMap(Map<String, String> map) {
    this.map = map;
  }

}
