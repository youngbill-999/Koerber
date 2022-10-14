package com.inconso.bend.inwmsx.it;

import org.junit.runner.RunWith;
import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import io.cucumber.junit.CucumberOptions.SnippetType;

/**
 * 
 * the main class for cucumber where you configure where the features are defined and which formats of reports needed to be generated
 * 
 */

//@formatter:off
@RunWith(Cucumber.class)
@CucumberOptions(
    //tags = "@defaultdatabased and @grbase",
    
 
    //tags = "@inventory and @chasc and @defaultdatabased",

    //tags = "@inventory and @chasc and @TEST and @defaultdatabased",
  
    tags = "@inventory and @LABEL_PRINT and @defaultdatabased",
    features = { "src/it/resources"},
    monochrome = true,
    snippets = SnippetType.CAMELCASE, 
    plugin = { "pretty",
               "html:target/reports/cucumber/html/index.html",
               "json:target/cucumber.json",
               "usage:target/usage.jsonx",
               "junit:target/junit.xml" })
public class CucumberIntegrationIT {

}
//@formatter:on
