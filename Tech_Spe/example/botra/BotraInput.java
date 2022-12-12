package com.inconso.bend.inventory.service.transaction.api;

public class InventoryBotraInput extends InventoryTransactionCoreInput {

  private static final long serialVersionUID = -308653429260639941L;
  private Double            qty;
  private String            qtyType;
  private String            idQuantum;
  private String            idLuTgt;

  public String getIdQuantum() {
    return idQuantum;
  }

  public void setIdQuantum(String idQuantum) {
    this.idQuantum = idQuantum;
  }

  public String getIdLuTgt() {
    return idLuTgt;
  }

  public void setIdLuTgt(String idLuTgt) {
    this.idLuTgt = idLuTgt;
  }

  public Double getQty() {
    return qty;
  }

  public String getQtyType() {
    return qtyType;
  }

  public static class Builder extends InventoryTransactionCoreInput.Builder<InventoryBotraInput, Builder> {

    public Builder(String idSite, String clProcess, String typProcess, String stepProcess, String idClient, String key, String idQuantum,
        String idUser) {
      super(idSite, clProcess, typProcess, stepProcess, key, idUser);
      object.idClient = idClient;
      object.idQuantum = idQuantum;
      //
    }

    /**
     * Setting the target load unit.
     * 
     * @param idLu
     *          actual value
     * @return current {@code Builder}
     */
    public Builder withTargetLu(String idLu) {
      object.idLuTgt = idLu;

      return this;
    }

    /**
     * Transferring the reserved quantity.
     * 
     * @param bookingQty
     *          actual value
     * @param qtyType
     *          should be <code>"RESERVED"</code>, if the {@code reserved} quantity should be transferred, otherwise <code>"AVAILABLE"</code>
     * @return current {@code Builder}
     */
    public Builder withBookingQtyAndQtyType(Double bookingQty, String qtyType) {
      object.qty = bookingQty;
      object.qtyType = qtyType;
      return this;
    }

    @Override
    protected InventoryBotraInput createObject() {
      return new InventoryBotraInput();
    }

    @Override
    protected Builder thisBuilder() {
      return this;
    }
  }
}
