package com.inconso.bend.inwmsx;

import javax.sql.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseBuilder;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseType;

@Configuration
@Profile("unit-test")
public class DerbyConfiguration {

  @Bean
  public DataSource dataSource() {
    return new EmbeddedDatabaseBuilder().generateUniqueName(true).setType(EmbeddedDatabaseType.DERBY).setScriptEncoding("UTF-8")
        .ignoreFailedDrops(true).addScript("init-schema.sql").addScript("init-schema-gdl_graph.sql").build();
  }
}
