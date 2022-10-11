package com.inconso.bend.inwmsx.it.general;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.Calendar;
import java.util.Date;
import java.util.NoSuchElementException;
import java.util.Objects;

/**
 * @author PJOHNKE
 *
 */

/**
 *
 */
public class GherkinType<T> {

  private T                 value        = null;
  private boolean           isIgnore     = false;
  private String            key          = null;
  private GetterFunction<T> getterForKey = null;

  public static <T> GherkinType<T> of(T value) {
    GherkinType<T> result = new GherkinType<T>();
    result.value = value;
    return result;
  }

  public static <T> GherkinType<T> ofKey(String key) {
    GherkinType<T> result = new GherkinType<T>();
    result.key = key;
    return result;
  }

  public void setGetterForKey(GetterFunction<T> getter) {
    getterForKey = getter;
  }

  public static <T> GherkinType<T> ignore() {
    GherkinType<T> result = new GherkinType<T>();
    result.isIgnore = true;
    return result;
  }

  public boolean isIgnore() {
    return isIgnore;
  }

  public T get() {
    if (isIgnore) {
      throw new NoSuchElementException();
    }

    T result;

    if (key != null) {
      result = getterForKey.apply(key);
    } else {
      result = value;
    }

    return result;
  }

  /**
   * Special equality check intended to be used as a filter predicate that takes the "ignore" option into account (always returns true, if isIgnore
   * equals true).
   * 
   * @param obj
   *          object of comparison
   * @return true if considered equal by taking the "ignore" option into account, otherwise false
   */
  public boolean checkEquality(T obj) {
    return isIgnore || privateEquals(get(), obj);
  }

  public void assertEquality(T actual, String message) {
    if (!this.checkEquality(actual)) {
      assertEquals(this.get(), actual, message);
    }
  }

  /**
   * resembles "Objects.equals" - with tolerance range for Date/Time objects to be considered equal.
   */
  private static <T> boolean privateEquals(T obj1, T obj2) {
    final long TOLERANCE_MS = 1000 * 60;
    boolean result;

    if (obj1 instanceof Date && obj2 instanceof Date) {
      Calendar date1 = Calendar.getInstance();
      date1.setTime((Date) obj1);

      Calendar date2 = Calendar.getInstance();
      date2.setTime((Date) obj2);

      result = Math.abs(date2.getTimeInMillis() - date1.getTimeInMillis()) <= TOLERANCE_MS;
    } else {
      result = Objects.equals(obj1, obj2);
    }

    return result;
  }

  @FunctionalInterface
  public interface GetterFunction<R> {

    R apply(String key) throws IllegalArgumentException;
  }

}
