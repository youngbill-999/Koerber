package com.inconso.bend.inwmsx.it.general;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import io.cucumber.java.ParameterType;

/**
 * @author PJOHNKE
 *
 */

public class GherkinParameterTypes {

  private static final String GHERKIN_KEY             = "key:";
  private static final String GHERKIN_NULL            = "null";
  private static final String GHERKIN_IGNORE          = "ignore";
  private static final String GHERKIN_TRUE            = "true";
  private static final String GHERKIN_FALSE           = "false";
  private static final String GHERKIN_TODAY           = "today";
  private static final String GHERKIN_NOW             = "now";
  private static final String GHERKIN_STRING_REGEX    = "\"[^\\\"]*\"";
  private static final String GHERKIN_INTEGER_REGEX   = "[+-]?\\d+";
  private static final String GHERKIN_DOUBLE_REGEX    = "[+-]?\\d+\\.?\\d*";
  private static final String GHERKIN_BOOLEAN_REGEX   = GHERKIN_TRUE + "|" + GHERKIN_FALSE;
  private static final String GHERKIN_DATE_REGEX      = "((" + GHERKIN_TODAY + "|\\d{4}/\\d{2}/\\d{2})([+-]\\d+|()))";
  private static final String GHERKIN_DATE_TIME_REGEX = "((" + GHERKIN_NOW
      + "|\\d{4}/\\d{2}/\\d{2}\\.\\d{2}:\\d{2})([+-]\\d+|[+-]\\d+\\.\\d+|[+-]\\d+\\.\\d+:\\d+|()))";
  private static final String GHERKIN_KEY_REGEX       = GHERKIN_KEY + ".+";

  /**
   * Nullable integer parameter type {Integer}
   */
  @ParameterType(GHERKIN_NULL + "|" + GHERKIN_INTEGER_REGEX)
  public Integer Integer(String input) throws ParseException {
    Integer result = null;

    if (!GHERKIN_NULL.equals(input)) {
      result = Integer.parseInt(input);
    }

    return result;
  }

  /**
   * Nullable long parameter type {Long}
   */
  @ParameterType(GHERKIN_NULL + "|" + GHERKIN_INTEGER_REGEX)
  public Long Long(String input) throws ParseException {
    Long result = null;

    if (!GHERKIN_NULL.equals(input)) {
      result = Long.parseLong(input);
    }

    return result;
  }

  /**
   * Nullable double parameter type {Double}
   */
  @ParameterType(GHERKIN_NULL + "|" + GHERKIN_DOUBLE_REGEX)
  public Double Double(String input) throws ParseException {
    Double result = null;

    if (!GHERKIN_NULL.equals(input)) {
      DecimalFormat decimalFormat = new DecimalFormat();
      DecimalFormatSymbols symbols = new DecimalFormatSymbols();
      symbols.setDecimalSeparator('.');
      symbols.setGroupingSeparator(' ');
      decimalFormat.setDecimalFormatSymbols(symbols);
      result = decimalFormat.parse(input).doubleValue();
    }

    return result;
  }

  /**
   * Nullable boolean parameter type {Boolean}
   */
  @ParameterType(GHERKIN_NULL + "|" + GHERKIN_BOOLEAN_REGEX)
  public Boolean Boolean(String input) {
    Boolean result = null;

    if (!GHERKIN_NULL.equals(input)) {
      result = GHERKIN_TRUE.equals(input);
    }

    return result;
  }

  /**
   * Nullable date parameter type {Date}
   * 
   * "yyyy/MM/dd" or "today" with optional +/- days offset
   */
  @ParameterType("(" + GHERKIN_NULL + "|" + GHERKIN_DATE_REGEX + ")")
  public Date Date(String input) throws ParseException {
    final String FORMAT = "yyyy/MM/dd";
    Calendar result = null;
    String rest;

    if (!GHERKIN_NULL.equals(input)) {
      if (input.startsWith(GHERKIN_TODAY)) {
        result = Calendar.getInstance();
        result.set(Calendar.HOUR_OF_DAY, 0);
        result.set(Calendar.MINUTE, 0);
        result.set(Calendar.SECOND, 0);
        result.set(Calendar.MILLISECOND, 0);
        rest = input.substring(GHERKIN_TODAY.length());
      } else {
        SimpleDateFormat format = new SimpleDateFormat(FORMAT);
        result = Calendar.getInstance();
        result.setTime(format.parse(input));
        rest = input.substring(FORMAT.length());
      }

      if (!"".equals(rest)) {
        int offset = Integer.parseInt(rest);
        result.add(Calendar.DAY_OF_MONTH, offset);
      }
    }

    Date date = (result != null) ? result.getTime() : null;
    return date;
  }

  /**
   * Nullable date time parameter type {DateTime}
   * 
   * "yyyy/MM/dd.HH:mm" or "now" with optional +/- days.hours:minutes offset
   */
  @ParameterType("(" + GHERKIN_NULL + "|" + GHERKIN_DATE_TIME_REGEX + ")")
  public Date DateTime(String input) throws ParseException {
    final String FORMAT = "yyyy/MM/dd.HH:mm";
    Calendar result = null;
    String rest;

    if (!GHERKIN_NULL.equals(input)) {
      if (input.startsWith(GHERKIN_NOW)) {
        result = Calendar.getInstance();
        result.set(Calendar.SECOND, 0);
        result.set(Calendar.MILLISECOND, 0);
        rest = input.substring(GHERKIN_NOW.length());
      } else {
        SimpleDateFormat format = new SimpleDateFormat(FORMAT);
        result = Calendar.getInstance();
        result.setTime(format.parse(input));
        rest = input.substring(FORMAT.length());
      }

      if (!"".equals(rest)) {
        String[] parts = rest.split(":|\\.");
        int signFactor = 1;

        if (parts.length >= 1) {
          int offsetDays = Integer.parseInt(parts[0]);
          signFactor = parts[0].startsWith("-") ? -1 : 1;
          result.add(Calendar.DAY_OF_MONTH, offsetDays);
        }

        if (parts.length >= 2) {
          int offsetHours = Integer.parseInt(parts[1]);
          offsetHours *= signFactor;
          result.add(Calendar.HOUR_OF_DAY, offsetHours);
        }

        if (parts.length >= 3) {
          int offsetMinutes = Integer.parseInt(parts[2]);
          offsetMinutes *= signFactor;
          result.add(Calendar.MINUTE, offsetMinutes);
        }
      }
    }

    Date date = (result != null) ? result.getTime() : null;
    return date;
  }

  /**
   * Nullable string parameter type {String}
   */
  @ParameterType(GHERKIN_NULL + "|\"[^\\\"]*\"")
  public String String(String input) {
    String result = null;

    if (!GHERKIN_NULL.equals(input)) {
      result = input.substring(1, input.length() - 1);
    }

    return result;
  }

  /**
   * Nullable integer parameter type with "ignore" option {IntegerExt}
   */
  @ParameterType(GHERKIN_NULL + "|" + GHERKIN_IGNORE + "|" + GHERKIN_INTEGER_REGEX)
  public GherkinType<Integer> IntegerExt(String input) throws ParseException {
    return toGherkinType(input, parameter -> Integer(parameter));
  }

  /**
   * Nullable long parameter type with "ignore" option {LongExt}
   */
  @ParameterType(GHERKIN_NULL + "|" + GHERKIN_IGNORE + "|" + GHERKIN_INTEGER_REGEX)
  public GherkinType<Long> LongExt(String input) throws ParseException {
    return toGherkinType(input, parameter -> Long(parameter));
  }

  /**
   * Nullable double parameter type with "ignore" option {DoubleExt}
   */
  @ParameterType(GHERKIN_NULL + "|" + GHERKIN_IGNORE + "|" + GHERKIN_DOUBLE_REGEX)
  public GherkinType<Double> DoubleExt(String input) throws ParseException {
    return toGherkinType(input, parameter -> Double(parameter));
  }

  /**
   * Nullable boolean parameter type with "ignore" option {BooleanExt}
   */
  @ParameterType(GHERKIN_NULL + "|" + GHERKIN_IGNORE + "|" + GHERKIN_BOOLEAN_REGEX)
  public GherkinType<Boolean> BooleanExt(String input) throws ParseException {
    return toGherkinType(input, parameter -> Boolean(parameter));
  }

  /**
   * Nullable date parameter type with "ignore" option {DateExt}
   */
  @ParameterType("(" + GHERKIN_NULL + "|" + GHERKIN_IGNORE + "|" + GHERKIN_DATE_REGEX + ")")
  public GherkinType<Date> DateExt(String input) throws ParseException {
    return toGherkinType(input, parameter -> Date(parameter));
  }

  /**
   * Nullable date parameter type with "ignore" option {DateTimeExt}
   */
  @ParameterType("(" + GHERKIN_NULL + "|" + GHERKIN_IGNORE + "|" + GHERKIN_DATE_TIME_REGEX + ")")
  public GherkinType<Date> DateTimeExt(String input) throws ParseException {
    return toGherkinType(input, parameter -> DateTime(parameter));
  }

  /**
   * Nullable string parameter type with "ignore" option {StringExt}
   */
  @ParameterType(GHERKIN_KEY_REGEX + "|" + GHERKIN_NULL + "|" + GHERKIN_IGNORE + "|" + GHERKIN_STRING_REGEX)
  public GherkinType<String> StringExt(String input) throws ParseException {
    return toGherkinType(input, parameter -> String(parameter));
  }

  /**
   * Converts the string parameter from Gherkin to GherkinType by using the supplied "convert" function by taking key-reference and "ignore" into
   * account.
   *
   * The option "current" indicates that the data of the current record (last created/updated) shall be used and is mapped to "empty".
   * 
   * The option "ignore" indicates that the attribute shall be ignored as a search criterion.
   */
  private <T> GherkinType<T> toGherkinType(String input, ConverterFunction<String, T> converter) throws ParseException {
    GherkinType<T> result;

    if (GHERKIN_IGNORE.equals(input)) {
      result = GherkinType.ignore();
    } else if (input.startsWith(GHERKIN_KEY)) {
      result = GherkinType.ofKey(input.substring(GHERKIN_KEY.length()));
    } else {
      result = GherkinType.of(converter.apply(input));
    }

    return result;
  }

  @FunctionalInterface
  private interface ConverterFunction<T, R> {

    R apply(T t) throws ParseException;
  }

}
