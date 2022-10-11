package com.inconso.bend.inwmsx.it.wmsbase;

public class WbClientAttributeConfiguration {

  String attribute;
  String description;
  String defaultValue;
  String merging;
  String updateable;
  String nullable;
  String nullcheck;
  String regExp;

  public WbClientAttributeConfiguration(String attribute, String description, String defaultValue, String merging, String updateable, String nullable,
      String nullcheck, String regExp) {
    super();
    this.attribute = attribute;
    this.description = description;
    this.defaultValue = defaultValue;
    this.merging = merging;
    this.updateable = updateable;
    this.nullable = nullable;
    this.nullcheck = nullcheck;
    this.regExp = regExp;
  }

  public String getAttribute() {
    return attribute;
  }

  public String getDescription() {
    return description;
  }

  public String getDefaultValue() {
    return defaultValue;
  }

  public String getMerging() {
    return merging;
  }

  public String getUpdateable() {
    return updateable;
  }

  public String getNullable() {
    return nullable;
  }

  public String getNullcheck() {
    return nullcheck;
  }

  public String getRegExp() {
    return regExp;
  }

}
