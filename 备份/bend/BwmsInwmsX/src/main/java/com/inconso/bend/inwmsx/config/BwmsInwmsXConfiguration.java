package com.inconso.bend.inwmsx.config;

import javax.sql.DataSource;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.orm.jpa.JpaProperties;
import org.springframework.boot.autoconfigure.transaction.TransactionManagerCustomizers;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.jta.JtaTransactionManager;
import com.inconso.bend.core.pers.BendRepositoryImpl;
import com.inconso.bend.core.pers.JpaBendConfiguration;
import com.inconso.bend.inwmsx.pers.model.EntityLocationBwmsInwmsX;
import com.inconso.bend.inwmsx.pers.rep.RepLocationBwmsInwmsX;

/**
 * Component Configuration to ensure that all components are detected during startup of a spring application and to specify package locations for
 * Entities and Repositories. This class is also a realization of the standard JpaBendConfiguration necessary to enable static weaving etc.
 * 
 */
@Configuration
@ComponentScan("com.inconso.bend.inwmsx")
@EntityScan(basePackageClasses = EntityLocationBwmsInwmsX.class)
@EnableJpaRepositories(repositoryBaseClass = BendRepositoryImpl.class, basePackageClasses = RepLocationBwmsInwmsX.class)

public class BwmsInwmsXConfiguration extends JpaBendConfiguration {

  /**
   * Standard constructor
   * 
   * @param dataSource
   *          dataSource
   * @param properties
   *          properties
   * @param jtaTransactionManagerProvider
   *          jtaTransactionManager
   * @param transactionManagerCustomizers
   *          transactionMangerCustomizers
   */
  public BwmsInwmsXConfiguration(DataSource dataSource, JpaProperties properties, ObjectProvider<JtaTransactionManager> jtaTransactionManagerProvider,
      ObjectProvider<TransactionManagerCustomizers> transactionManagerCustomizers) {
    super(dataSource, properties, jtaTransactionManagerProvider);
  }

}
