package com.inconso.bend.inventory.service.transaction.api;

public class InventoryChascInput extends InventoryTransactionCoreInput {

  private static final long serialVersionUID = -3476276613546115174L;

  private String            idQuantum;

  /** if set to {@code true}: the transaction will affect the reserved quantity, otherwise it will affect the free quantity. */
  private String            qtyType;

  private Double            qtyMoved;

  /** article variant in the new quantum */
  private String            artvar;

  /** stock type in the new quantum */
  private String            typStock;

  /** lock type in the new quantum */
  private String            typLock;

  /** batch Id in the new quantum */
  private String            idBatch;

  /** special stock type in the new quantum */
  private String            typSpecialStock;

  /** special stock Id in the new quantum */
  private String            idSpecialStock;

  /** QC status in the new quantum */
  private String            statQualityControl;

  /** customs status in the new quantum */
  private String            statCustoms;

  /** value of the first separation criterion in the new quantum */
  private String            sepCrit01;

  /** value of the second separation criterion in the new quantum */
  private String            sepCrit02;

  /** value of the third separation criterion in the new quantum */
  private String            sepCrit03;

  /** value of the fourth separation criterion in the new quantum */
  private String            sepCrit04;

  /** value of the fifth separation criterion in the new quantum */
  private String            sepCrit05;

  /** value of the sixth separation criterion in the new quantum */
  private String            sepCrit06;

  /** value of the seventh separation criterion in the new quantum */
  private String            sepCrit07;

  /** value of the eighth separation criterion in the new quantum */
  private String            sepCrit08;

  /** value of the ninth separation criterion in the new quantum */
  private String            sepCrit09;

  /** value of the tenth separation criterion in the new quantum */
  private String            sepCrit10;

  public String getIdQuantum() {
    return idQuantum;
  }

  public void setIdQuantum(String idLu) {
    this.idQuantum = idLu;
  }

  /**
   * indicator if the quantity will be moved to "reserved" from available stock, otherwise the quantity will be freed up - unreserved.
   * 
   * @return String of type that is altered (AVAILAVLE / RESERVED).
   */
  public String getQtyType() {
    return qtyType;
  }

  public Double getQtyMoved() {
    return qtyMoved;
  }

  public String getArtvar() {
    return artvar;
  }

  public String getTypStock() {
    return typStock;
  }

  public String getTypLock() {
    return typLock;
  }

  public String getIdBatch() {
    return idBatch;
  }

  public String getTypSpecialStock() {
    return typSpecialStock;
  }

  public String getIdSpecialStock() {
    return idSpecialStock;
  }

  public String getStatQualityControl() {
    return statQualityControl;
  }

  public String getStatCustoms() {
    return statCustoms;
  }

  public String getSepCrit01() {
    return sepCrit01;
  }

  public String getSepCrit02() {
    return sepCrit02;
  }

  public String getSepCrit03() {
    return sepCrit03;
  }

  public String getSepCrit04() {
    return sepCrit04;
  }

  public String getSepCrit05() {
    return sepCrit05;
  }

  public String getSepCrit06() {
    return sepCrit06;
  }

  public String getSepCrit07() {
    return sepCrit07;
  }

  public String getSepCrit08() {
    return sepCrit08;
  }

  public String getSepCrit09() {
    return sepCrit09;
  }

  public String getSepCrit10() {
    return sepCrit10;
  }

  public static class Builder extends InventoryTransactionCoreInput.Builder<InventoryChascInput, Builder> {

    public Builder(String idSite, String clProcess, String typProcess, String stepProcess, String idClient, String key, String idQuantum, Double qty,
        String qtyType, String artvar, String idBatch, String typStock, String typLock, String typSpecialStock, String idSpecialStock,
        String sepCrit01, String sepCrit02, String sepCrit03, String sepCrit04, String sepCrit05, String sepCrit06, String sepCrit07,
        String sepCrit08, String sepCrit09, String sepCrit10, String statCustoms, String statQualityControl, String idUser) {
      super(idSite, clProcess, typProcess, stepProcess, key, idUser);
      object.idClient = idClient;
      object.idQuantum = idQuantum;
      object.qtyType = qtyType;
      object.qtyMoved = qty;
      object.typStock = typStock;
      object.typLock = typLock;
      object.artvar = artvar;
      object.idBatch = idBatch;
      object.typSpecialStock = typSpecialStock;
      object.idSpecialStock = idSpecialStock;
      object.sepCrit01 = sepCrit01;
      object.sepCrit02 = sepCrit02;
      object.sepCrit03 = sepCrit03;
      object.sepCrit04 = sepCrit04;
      object.sepCrit05 = sepCrit05;
      object.sepCrit06 = sepCrit06;
      object.sepCrit07 = sepCrit07;
      object.sepCrit08 = sepCrit08;
      object.sepCrit09 = sepCrit09;
      object.sepCrit10 = sepCrit10;
      object.statCustoms = statCustoms;
      object.statQualityControl = statQualityControl;
    }

    @Override
    protected InventoryChascInput createObject() {
      return new InventoryChascInput();
    }

    @Override
    protected Builder thisBuilder() {
      return this;
    }

  }
}
