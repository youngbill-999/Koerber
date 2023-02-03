package com.inconso.bend.inwmsx.it.replenishment;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import javax.jms.*;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;
import com.inconso.bend.core.service.api.ServiceInput;
import com.inconso.bend.inwmsx.it.general.GeneralHelper;
import com.inconso.bend.ipc.service.api.BendIpcDesc;
import com.inconso.bend.ipc.service.api.BendIpcSendInput;
import com.inconso.bend.repbase.pers.gen.RepConfigStoreOutZonePk;
import com.inconso.bend.repbase.pers.model.RepConfigStoreOutZone;
import com.inconso.bend.repbase.pers.model.RepReplenishmentRequest;
import com.inconso.bend.repbase.service.api.RepBaseConfStoreOutZoneInput;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.inconso.bend.repbase.service.api.RepBaseReplenishmentRequestInput;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;

public class ReplenishmentWebserviceCaller extends ReplenishmentWebserviceCallerExec {

  @Given("run job REPU_RES_HIGH_LVL")
  @Transactional(readOnly = true)
  public void runRepHlRes() throws JMSException 

    // Strategy2
    /*
     * IpcJobConfig config = ipcJobConfigRep.findOne(new IpcJobConfigPk("RL1", "REPU_RES_HIGH_LVL")); // SchedulerFactoryBean schedulerFactoryBean =
     * new SchedulerFactoryBean(); // Scheduler scheduler = schedulerFactoryBean.getScheduler();
     * 
     * Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler(); scheduler.start(); JobDetail jobDetail =
     * JobBuilder.newJob(IpcServerTriggerJob.class).withIdentity(new JobKey("REPU_RES_HIGH_LVL", "RL1")).build(); CronTrigger trigger =
     * TriggerBuilder.newTrigger().withIdentity("trig_" + "REPU_RES_HIGH_LVL", "trig_" + "RL1")
     * .withSchedule(CronScheduleBuilder.cronSchedule(config.getCronExpr())).build(); scheduler.scheduleJob(jobDetail, trigger);
     * 
     * JobKey key = new JobKey("REPU_RES_HIGH_LVL", "RL1"); System.out.println("JobKey:" + key); JobDetail jd = scheduler.getJobDetail(key);
     * System.out.println("JobDetail:" + jd); scheduler.triggerJob(key);
     */
    // Strategy3
    /*
     * ConnectionFactory connectionFactory = new ActiveMQConnectionFactory("admin", "admin", "tcp://ifbbend06:61616"); Connection connection =
     * connectionFactory.createConnection(); connection.start();
     * 
     * Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
     * 
     * the code wise to send message need to send the messae to right queue and it works!
     * 
     * Queue queue = session.createQueue("jla-REP_REPLENISHMENT-RL1"); MessageProducer producer = session.createProducer(queue);
     * producer.setDeliveryMode(DeliveryMode.PERSISTENT); String msg =
     * "{\"contextMap\":{\"SITE\":\"RL1\",\"OverwriteLanguage\":\"EN\",\"ID_LOCALE\":\"DE\",\"ComponentName\":\"WMS_INWMSX\"},\"dataObjectAsJson\":\"{\\\"typProcess\\\":\\\"REP_DETERMINATION\\\",\\\"idUserAudit\\\":null,\\\"data\\\":{\\\"TYP_REPLENISHMENT\\\":\\\"RES_HIGH_LVL\\\"}}\"}";
     * sendMsg(session, producer, msg);
     * 
     * connection.close();
     */
  }

  /*
   * public static void sendMsg(Session session, MessageProducer producer, String Msg) throws JMSException { TextMessage message =
   * session.createTextMessage(Msg); producer.send(message); }
   */


}
