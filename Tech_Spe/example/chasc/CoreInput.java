package com.inconso.bend.inventory.service.transaction.api;

import com.inconso.bend.core.service.api.CoreInput;

public abstract class InventoryTransactionCoreInput extends CoreInput {

  private static final long serialVersionUID = -2381066709122019003L;

  protected String          idSite;

  protected String          clProcess;

  protected String          typProcess;

  protected String          stepProcess;

  protected String          idClient;

  protected String          key;
  protected String          idUser;
  protected String          typRef;
  protected String          idRef1;
  protected String          idRef2;
  protected String          idRef3;
  protected String          idRef4;
  protected String          idRef5;
  protected String          idRef6;
  protected String          reasonTransaction1;
  protected String          reasonTransaction2;
  protected String          storageAreaSrc;
  protected String          storageLocationSrc;
  protected String          storageAreaTgt;
  protected String          storageLocationTgt;

  public InventoryTransactionCoreInput() {
    super();
  }

  public String getIdRef1() {
    return idRef1;
  }

  public String getIdRef2() {
    return idRef2;
  }

  public String getIdRef3() {
    return idRef3;
  }

  public String getIdRef4() {
    return idRef4;
  }

  public String getIdRef5() {
    return idRef5;
  }

  public String getIdRef6() {
    return idRef6;
  }

  public String getIdSite() {
    return idSite;
  }

  public String getTypRef() {
    return typRef;
  }

  public void setIdRef1(String idRef1) {
    this.idRef1 = idRef1;
  }

  public void setIdRef2(String idRef2) {
    this.idRef2 = idRef2;
  }

  public void setIdRef3(String idRef3) {
    this.idRef3 = idRef3;
  }

  public void setIdRef4(String idRef4) {
    this.idRef4 = idRef4;
  }

  public void setIdRef5(String idRef5) {
    this.idRef5 = idRef5;
  }

  public void setIdRef6(String idRef6) {
    this.idRef6 = idRef6;
  }

  public void setIdSite(String idSite) {
    this.idSite = idSite;
  }

  public void setTypRef(String typRef) {
    this.typRef = typRef;
  }

  public String getReasonTransaction1() {
    return reasonTransaction1;
  }

  public void setReasonTransaction1(String reasonTransaction1) {
    this.reasonTransaction1 = reasonTransaction1;
  }

  public String getReasonTransaction2() {
    return reasonTransaction2;
  }

  public void setReasonTransaction2(String reasonTransaction2) {
    this.reasonTransaction2 = reasonTransaction2;
  }

  public String getIdUser() {
    return idUser;
  }

  public void setIdUser(String idUser) {
    this.idUser = idUser;
  }

  public String getClProcess() {
    return clProcess;
  }

  public void setClProcess(String clProcess) {
    this.clProcess = clProcess;
  }

  public String getTypProcess() {
    return typProcess;
  }

  public void setTypProcess(String typProcess) {
    this.typProcess = typProcess;
  }

  public String getStepProcess() {
    return stepProcess;
  }

  public void setStepProcess(String stepProcess) {
    this.stepProcess = stepProcess;
  }

  public String getIdClient() {
    return idClient;
  }

  public void setIdClient(String idClient) {
    this.idClient = idClient;
  }

  public String getKey() {
    return key;
  }

  public void setKey(String key) {
    this.key = key;
  }

  public String getStorageAreaSrc() {
    return storageAreaSrc;
  }

  public String getStorageAreaTgt() {
    return storageAreaTgt;
  }

  public String getStorageLocationSrc() {
    return storageLocationSrc;
  }

  public String getStorageLocationTgt() {
    return storageLocationTgt;
  }

  public void setStorageAreaSrc(String storageAreaSrc) {
    this.storageAreaSrc = storageAreaSrc;
  }

  public void setStorageAreaTgt(String storageAreaTgt) {
    this.storageAreaTgt = storageAreaTgt;
  }

  public void setStorageLocationSrc(String storageLocationSrc) {
    this.storageLocationSrc = storageLocationSrc;
  }

  public void setStorageLocationTgt(String storageLocationTgt) {
    this.storageLocationTgt = storageLocationTgt;
  }

  protected static abstract class Builder<T extends InventoryTransactionCoreInput, B extends Builder<T, B>> {

    protected T object;
    protected B builder;

    public Builder(String idSite, String clProcess, String typProcess, String stepProcess, String key, String idUser) {
      object = createObject();
      builder = thisBuilder();

      object.idSite = idSite;
      object.clProcess = clProcess;
      object.typProcess = typProcess;
      object.stepProcess = stepProcess;
      object.key = key;
      object.idUser = idUser;
    }

    /**
     * Sub classes have to create the concrete object.
     * 
     * @return Input object
     */
    protected abstract T createObject();

    /**
     * Sub classes should return the concrete SubBuilder.
     * 
     * @return Builder object (normally "{@code this}")
     */
    protected abstract B thisBuilder();

    /**
     * Setting the reference type and id1 and id2.
     * 
     * @param typRef
     *          Type of reference, must be valid value from corresponding {@code BendCodeList}
     * @param idRef1
     *          id1
     * @param idRef2
     *          id2
     * @return current {@code Builder}
     */
    public B withTypRefAndId(String typRef, String idRef1, String idRef2) {
      object.typRef = typRef;
      object.idRef1 = idRef1;
      object.idRef2 = idRef2;
      return builder;
    }

    /**
     * Setting the reference type and id1 until id6.
     * 
     * @param typRef
     *          Type of reference, must be valid value from corresponding {@code BendCodeList}
     * @param idRef1
     *          actual value
     * @param idRef2
     *          actual value
     * @param idRef3
     *          actual value
     * @param idRef4
     *          actual value
     * @param idRef5
     *          actual value
     * @param idRef6
     *          actual value
     * @return current {@code Builder}
     */
    public B withTypRefAndId(String typRef, String idRef1, String idRef2, String idRef3, String idRef4, String idRef5, String idRef6) {
      object.typRef = typRef;
      object.idRef1 = idRef1;
      object.idRef2 = idRef2;
      object.idRef3 = idRef3;
      object.idRef4 = idRef4;
      object.idRef5 = idRef5;
      object.idRef6 = idRef6;
      return builder;
    }

    /**
     * Setting transaction reason.
     * 
     * @param reason1
     *          actual value
     * @param reason2
     *          actual value
     * @return current {@code Builder}
     */
    public B withReasonTransaction(String reason1, String reason2) {
      object.reasonTransaction1 = reason1;
      object.reasonTransaction2 = reason2;
      return builder;
    }

    /**
     * Setting the source storage location
     * 
     * @param areaSrc
     *          actual value
     * @param locationSrc
     *          actual value
     * @return current {@code Builder}
     */
    public B withStorageLocationSrc(String areaSrc, String locationSrc) {
      object.storageAreaSrc = areaSrc;
      object.storageLocationSrc = locationSrc;
      return builder;
    }

    /**
     * Setting the target storage location
     * 
     * @param areaTgt
     *          actual value
     * @param locationTgt
     *          actual value
     * @return current {@code Builder}
     */
    public B withStorageLocationTgt(String areaTgt, String locationTgt) {
      object.storageAreaTgt = areaTgt;
      object.storageLocationTgt = locationTgt;
      return builder;
    }

    /**
     * Return the sampled object.
     * 
     * @return Complete object created
     */
    public T build() {
      return object;
    }
  }

}
