



public class MdtDataHandler {

  pcontroller
  imInventoryPrintManager.printImLbl(BendUserManager.getManager().getContext("SITE"), input.getIdLu(), input.getIdTerminal(),
         codeCache.getValue(PrtClProcessCode.DIALOG), codeCache.getValue(ImPrtTypProcessCode.IM_PID_LBL), input.getTypLU());
 
 
 
  @Override
   public void printImLbl(String idSite, String idLu, String idTerminal, String clProcess, String typProcess, String subContext) {
     InputPrintJob input = new InputPrintJob();
     input.setIdContext(idSite);
     input.setClProcess(clProcess);
     input.setTypProcess(typProcess);
 
     // if the subContext is NULL, then use the typeLU found using idLu and idSite
     if (Objects.isNull(subContext) || subContext.isBlank()) {
       final ImLoadUnit imLoadUnit = imLoadUnitRep.findOne(new ImLoadUnitPk(idSite, idLu));
       subContext = imLoadUnit.getTypLu();
     }
 
     input.setSubContext(subContext);
 
     Map<String, String> map = new LinkedHashMap<>();
     map.put(ID_SITE, idSite);
     map.put("id_lu", idLu);
     input.setSpecParams(map);
     if (idTerminal != null) {
       input = reprintUtils.addPrintTerminalPara1(idTerminal, input);
     }
     input.setPara2(PrtConstants.DEFAULT);
     input.setValue2(PrtConstants.DEFAULT);
     input.setPara3(PrtConstants.DEFAULT);
     input.setValue3(PrtConstants.DEFAULT);
 
     ******printServAction.execute(input);
   }
 
 
   {
    "typProcess":null,
    "idUserAudit":"yub",
    "inputPrintJob":{ 
                       "idContext":"RL1", 
                       "para1":"TERMINAL",
                       "value1":"IPC7301",
                       "para2":"*",
                       "value2":"*",
                       "para3":"*",
                       "value3":"*",
                       "subContext":"LBOX3",
                       "clProcess":"DIALOG",
                       "typProcess":"IM_PID_LBL",
                       "specParams":{"id_site":"RL1","id_lu":"025000056485"},
                       "specParamsGrp":[]
    },
    "inputPrintFile":null,
    "inputPrintLabel":null,
    "inputPrintLabelExt":null,
    "inputPrintLabelSeq":null,
    "inputPrintReport":null,
    "inputPrintReportGroup":null,
    "printAction":"PRINT_JOB"
  }
 
  @Override
   public void execute(InputPrintJob input) {
     if (LOGGER.isDebugEnabled()) {
       LOGGER.debug("Print, send Message to {}", PrintServers.PRT_PRINT_SRV.name());
     }
 
     PrintJobSrvPayload inputWrapper = initializePrintJobInput(input);
 
     ****ipcSend.send(BendPrintIpcDesc.getIt(), inputWrapper);
   }
 
 
 
 
   @Override
   public void send(IpcServerDescription desc, Object data) {
     internalSend(desc, data, false);
   }
 
 
 
   @SuppressWarnings("checkstyle:IllegalCatch")
   protected void internalSend(IpcServerDescription desc, Object data, boolean onlyForCurrent) {
  
 
     // depending on the flag
     IpcQueue myQueue = (onlyForCurrent) ? ipcSenderHelper.getIpcQueueForCurrentContextOnly(desc) : ipcSenderHelper.getIpcQueue(desc);
 
      // init our message with the current contextMap
     IpcBendMess mess = ipcBendMessHelper.createBendMess();
 
     // produce the real message as String (writer is used twice)
     StringWriter writer;
     String dataMessage = null;
     if (data instanceof String) {
       // in case of string directly without jsoning
       dataMessage = (String) data;
     } else {
       // normal case convert via jackson
       writer = ipcSenderHelper.getStringWriter();
       try {
         ipcSenderHelper.getObjectMapper().writer().writeValue(writer, data);
       } catch (Exception e) {
         throw new BendException(IpcTextCodes.IPC_0001, e.getClass(), (e.getMessage() != null ? e.getMessage() : "??"));
       }
       dataMessage = writer.toString();
     }
 
     // set the data
     mess.setDataObjectAsJson(dataMessage);
 
     // convert the whole thing to json-string
     writer = ipcSenderHelper.getStringWriter();
     try {
       ipcSenderHelper.getObjectMapper().writer().writeValue(writer, mess);
     } catch (Exception e) {
       throw new BendException(IpcTextCodes.IPC_0001, e.getClass(), (e.getMessage() != null ? e.getMessage() : "??"));
     }
     String message = writer.toString();
 
     // send with a last not null check
     Assert.notNull(message, "message must not be null");
     jmsTemplate.convertAndSend(myQueue.getQueue(), message, m -> {
       ipcSenderHelper.setHeaderProperties(m, myQueue);
       return m;
     });
 
   }
 
 

}
@Override
  public EmptyOutput checkIfAddressEditable(BwmsGIBaseOrderInput input) {
    SG.assertNotNull("input", input);
    SG.assertNotNull("input.idSite", input.getIdSite());
    SG.assertNotNull("input.idClient", input.getIdClient());
    SG.assertNotNull("input.idOrder", input.getIdOrder());
    SG.assertNotNull("input.numPartialOrder", input.getNumPartialOrder());
    giOrderUtils.checkIfAddressEditable
    (new GiOrderPk(input.getIdSite(), input.getIdClient(), input.getIdOrder(), input.getNumPartialOrder()));
    return new EmptyOutput();
  }
