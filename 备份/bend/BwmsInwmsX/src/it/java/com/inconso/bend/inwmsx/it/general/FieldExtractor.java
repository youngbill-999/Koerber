package com.inconso.bend.inwmsx.it.general;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author PJOHNKE
 *
 */

/**
 * Wraps a Map with value type "Object" and provides methods to cast/convert its content to the required type.
 * 
 * Intended to get a more convenient access to the fields of web service result sets.
 */
public class FieldExtractor {

  private Map<String, Object> data;

  public FieldExtractor(Map<String, Object> data) {
    this.data = data;
  }

  public String getString(String key) {
    return (String) data.get(key);
  }

  public Boolean getBoolean(String key) {
    return (Boolean) data.get(key);
  }

  public Integer getInteger(String key) {
    return (Integer) data.get(key);
  }

  public Long getLong(String key) {
    Long result;
    Object obj = data.get(key);

    /*
     * Instead of the actual expected type "Long" at the moment the value has always the type "Integer". Further investigation necessary.
     */
    if (obj instanceof Integer) {
      result = Long.valueOf(getInteger(key));
    } else {
      result = (Long) obj;
    }

    return result;
  }

  public Double getDouble(String key) {
    return (Double) data.get(key);
  }

  public Date getDate(String key) {
    Date result = null;
    try {
      result = GeneralHelper.parseJsonDate((String) data.get(key));
    } catch (ParseException e) {
      result = (Date) data.get(key);
    }
    return result;
  }

  @SuppressWarnings("unchecked")
  public List<String> getStringList(String key) {
    return (List<String>) data.get(key);
  }

  @SuppressWarnings("unchecked")
  public Map<String, String> getStringMap(String key) {
    return (Map<String, String>) data.get(key);
  }

  @SuppressWarnings("unchecked")
  public Map<String, Object> getObjectMap(String key) {
    return (Map<String, Object>) data.get(key);
  }

  @SuppressWarnings("unchecked")
  public ArrayList<Object> getObjectArray(String key) {
    return (ArrayList<Object>) data.get(key);
  }

}
