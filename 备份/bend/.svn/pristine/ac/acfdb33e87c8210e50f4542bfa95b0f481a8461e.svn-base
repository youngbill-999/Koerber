package com.inconso.bend.inwmsx.it.gibase;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.distrib.pers.model.DiDistribTrip;
import com.inconso.bend.gibase.pers.model.GiOrder;
import com.inconso.bend.gibase.pers.model.GiOrderItem;
import com.inconso.bend.inwmsx.it.general.CucumberReport;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.inwmsx.it.general.GherkinType.GetterFunction;
import com.inconso.bend.load.pers.model.LoadLoading;
import com.inconso.bend.pabase.pers.model.PaPackage;
import com.inconso.bend.picking.pers.model.PiPickingOrder;
import com.inconso.bend.picking.pers.model.PiPickingTrip;
import com.inconso.bend.tourmgmt.pers.model.TmTransportVehicle;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class GiBaseDataHandler {

  public final GetterFunction<String> idPickingOrderGetter = key -> getPiPickingOrder(key).getPiPickingOrderPk().getIdPickingOrder();
  public final GetterFunction<String> idPickingTripGetter  = key -> getPiPickingTrip(key).getPiPickingTripPk().getIdPickingTrip();
  public final GetterFunction<String> idDistribTripGetter  = key -> getDiDistribTrip(key).getDiDistribTripPk().getIdDistribTrip();
  public final GetterFunction<String> idLoadLoadingGetter  = key -> getLoadLoading(key).getLoadLoadingPk().getIdLoading();

  @Autowired
  private CucumberReport              cucumberReport;

  private Map<String, GiOrder>        giOrder              = new HashMap<String, GiOrder>();
  private Map<String, GiOrderItem>    giOrderItem          = new HashMap<String, GiOrderItem>();
  private Map<String, PiPickingOrder> piPickingOrder       = new HashMap<String, PiPickingOrder>();
  private Map<String, PiPickingTrip>  piPickingTrip        = new HashMap<String, PiPickingTrip>();
  private Map<String, DiDistribTrip>  diDistribTrip        = new HashMap<String, DiDistribTrip>();
  private Map<String, LoadLoading>    loadLoading          = new HashMap<String, LoadLoading>();
  private Map<String, PaPackage>      paPackage            = new HashMap<String, PaPackage>();
  private TmTransportVehicle          transportVehicle;

  public TmTransportVehicle getTransportVehicle() {
    return transportVehicle;
  }

  public void putTransportVehicle(TmTransportVehicle idTransportVehicle) {
    this.transportVehicle = idTransportVehicle;
  }

  public GiOrder getGiOrder(String key) {
    if (!giOrder.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return giOrder.get(key);
  }

  public void putGiOrder(String key, GiOrder value) {
    cucumberReport.setMessage(String.format("putGiOrder(%s, %s)", key, value));
    giOrder.put(key, value);
  }

  public GiOrderItem getGiOrderItem(String key) {
    if (!giOrderItem.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return giOrderItem.get(key);
  }

  public void putGiOrderItem(String key, GiOrderItem value) {
    cucumberReport.setMessage(String.format("putGiOrderItem(%s, %s)", key, value));
    giOrderItem.put(key, value);
  }

  public PiPickingOrder getPiPickingOrder(String key) {
    if (!piPickingOrder.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return piPickingOrder.get(key);
  }

  public void putPiPickingOrder(String key, PiPickingOrder value) {
    cucumberReport.setMessage(String.format("putPiPickingOrder(%s, %s)", key, value));
    piPickingOrder.put(key, value);
  }

  public PiPickingTrip getPiPickingTrip(String key) {
    if (!piPickingTrip.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return piPickingTrip.get(key);
  }

  public void putPiPickingTrip(String key, PiPickingTrip value) {
    cucumberReport.setMessage(String.format("putPiPickingTrip(%s, %s)", key, value));
    piPickingTrip.put(key, value);
  }

  public DiDistribTrip getDiDistribTrip(String key) {
    if (!diDistribTrip.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return diDistribTrip.get(key);
  }

  public void putDiDistribTrip(String key, DiDistribTrip value) {
    cucumberReport.setMessage(String.format("putDiDistribTrip(%s, %s)", key, value));
    diDistribTrip.put(key, value);
  }

  public LoadLoading getLoadLoading(String key) {
    if (!loadLoading.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return loadLoading.get(key);
  }

  public void putLoadLoading(String key, LoadLoading value) {
    cucumberReport.setMessage(String.format("putLoadLoading(%s, %s)", key, value));
    loadLoading.put(key, value);
  }

  public PaPackage getPaPackage(String key) {
    if (!paPackage.containsKey(key)) {
      throw new IllegalArgumentException(key);
    }
    return paPackage.get(key);
  }

  public void putPaPackage(String key, PaPackage value) {
    cucumberReport.setMessage(String.format("putPaPackage(%s, %s)", key, value));
    paPackage.put(key, value);
  }
}
