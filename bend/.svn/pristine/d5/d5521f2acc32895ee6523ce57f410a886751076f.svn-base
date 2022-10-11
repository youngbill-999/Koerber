package com.inconso.bend.inwmsx.it.general;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import com.inconso.bend.inwmsx.it.gibase.GiBaseDataHandler;
import com.inconso.bend.inwmsx.it.inventory.InventoryDataHandler;
import com.inconso.bend.inwmsx.it.topology.TopologyDataHandler;

@Component
@Scope(GeneralHelper.SCOPE_CUCUMBER_GLUE)
public class GherkinTableCell {

  private static final Pattern PATTERN = Pattern.compile("<[^>]+>");

  @Autowired
  private InventoryDataHandler inventoryDataHandler;

  @Autowired
  private TopologyDataHandler  topologyDataHandler;

  @Autowired
  private GiBaseDataHandler    giBaseDataHandler;

  // Replaces references to data handler objects (for example: <lu.id:MyLoadUnit>) with the corresponding string representation.
  // A leading and trailing '"' is removed. This allows to provide empty strings or leading and trailing whitespaces since
  // the cucumber parser removes leading and trailing whitespaces and converts whitespaces only to null.
  public String convertCell(String entry) {
    String result = null;

    if (entry != null) {
      if (entry.startsWith("\"") && entry.endsWith("\"")) {
        entry = entry.substring(1, entry.length() - 1);
      }

      Matcher matcher = PATTERN.matcher(entry);
      StringBuffer sb = new StringBuffer();

      while (matcher.find()) {
        String tag = matcher.group();
        matcher.appendReplacement(sb, convertTag(tag));
      }
      matcher.appendTail(sb);

      result = sb.toString();
    }

    return result;
  }

  private String convertTag(String tag) {
    int pos = tag.indexOf(':', 1);
    if (pos == -1) {
      throw new IllegalArgumentException(tag);
    }

    String getter = tag.substring(1, pos);
    String key = tag.substring(pos + 1, tag.length() - 1);

    GherkinType<String> result = GherkinType.ofKey(key);

    switch (getter) {
    case "lu.id":
      result.setGetterForKey(inventoryDataHandler.idLuGetter);
      break;
    case "piOrder.id":
      result.setGetterForKey(giBaseDataHandler.idPickingOrderGetter);
      break;
    case "piTrip.id":
      result.setGetterForKey(giBaseDataHandler.idPickingTripGetter);
      break;
    case "loading.id":
      result.setGetterForKey(giBaseDataHandler.idLoadLoadingGetter);
      break;
    case "distribTrip.id":
      result.setGetterForKey(giBaseDataHandler.idDistribTripGetter);
      break;
    case "topStorageLocation.storageArea":
      result.setGetterForKey(topologyDataHandler.storageAreaGetter);
      break;
    case "topStorageLocation.storageLocation":
      result.setGetterForKey(topologyDataHandler.storageLocationGetter);
      break;
    default:
      throw new IllegalArgumentException(tag);
    }

    return result.get();
  }
}
