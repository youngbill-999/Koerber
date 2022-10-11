create table BEND_LOG_LEVEL_CONF
(
  log_name  VARCHAR(40) not null,
  classpath VARCHAR(100) not null,
  log_level VARCHAR(5) not null,
  ts_cre  DATE not null,
  id_cre  VARCHAR(40) not null,
  ts_upd  DATE not null,
  id_upd  VARCHAR(40) not null,
  PRIMARY KEY (log_name)
);

create table BEND_LOG_CONF
(
  log_name VARCHAR(40) not null,
  flg_sql_log   VARCHAR(1) not null,
  flg_active   VARCHAR(1) not null,
  ts_cre  DATE not null,
  id_cre  VARCHAR(40) not null,
  ts_upd  DATE not null,
  id_upd  VARCHAR(40) not null,
  PRIMARY KEY (log_name)
);

INSERT INTO BEND_LOG_CONF VALUES ('BEND', '1', '1', '2017-02-02 00:00:00', 'LJ', '2017-02-02 00:00:00', 'LJ');
INSERT INTO BEND_LOG_CONF VALUES ('BEND_USER', '1', '1', '2017-02-02 00:00:00', 'LJ', '2017-02-02 00:00:00', 'LJ');
INSERT INTO BEND_LOG_LEVEL_CONF VALUES ('BEND', 'com.inconso.bend', 'INFO', '2017-02-02 00:00:00', 'LJ', '2017-02-02 00:00:00', 'JAL');
INSERT INTO BEND_LOG_LEVEL_CONF VALUES ('BEND_USER', 'com.inconso.bend', 'INFO', '2017-02-02 00:00:00', 'LJ', '2017-02-02 00:00:00', 'JAL');

CREATE TABLE "BEND_CODE"
(	list VARCHAR(20) NOT NULL,
	code VARCHAR(20) NOT NULL,
	"VALUE" VARCHAR(20) NOT NULL,
	def_text VARCHAR(200) NOT NULL,
	flg_show_in_list VARCHAR(1) NOT NULL,
	"CREATION_COMPONENT" VARCHAR(30) NOT NULL,
	"UPDATE_COMPONENT" VARCHAR(30) NOT NULL,
	"TS_CRE" DATE NOT NULL,
	"ID_CRE" VARCHAR(40) NOT NULL,
	"TS_UPD" DATE NOT NULL,
	"ID_UPD" VARCHAR(40) NOT NULL,
	PRIMARY KEY (list, code)
);

INSERT INTO BEND_CODE VALUES('TO_TYP_REF', 'GI_ORDER', 'GI_ORDER', 'GiOrder', '1', 'TST', 'TST','2017-02-02 00:00:00', 'JLA', '2017-02-02 00:00:00', 'JLA' );

CREATE TABLE "IPC_SERVER_CONFIG"
(	id_context VARCHAR(100) NOT NULL,
	id_queue VARCHAR(100) NOT NULL,
	multithread_data VARCHAR(20),
	flg_active VARCHAR(1) NOT NULL,
	flg_queue_available VARCHAR(1) NOT NULL,
	flg_delete VARCHAR(1) NOT NULL,
	"TS_CRE" DATE NOT NULL,
	"ID_CRE" VARCHAR(40) NOT NULL,
	"TS_UPD" DATE NOT NULL,
	"ID_UPD" VARCHAR(40) NOT NULL,
	PRIMARY KEY (id_context, id_queue)
);

CREATE TABLE "IPC_SERVER"
(	id_queue VARCHAR(100) NOT NULL,
	server_class VARCHAR(1000) NOT NULL,
	message_class VARCHAR(1000),
	flg_multithread VARCHAR(1) NOT NULL,
	flg_available VARCHAR(1) NOT NULL,
	flg_context_sensitive VARCHAR(1) NOT NULL,
	"TS_CRE" DATE NOT NULL,
	"ID_CRE" VARCHAR(40) NOT NULL,
	"TS_UPD" DATE NOT NULL,
	"ID_UPD" VARCHAR(40) NOT NULL,
	PRIMARY KEY (id_queue)
);


CREATE SEQUENCE SEQ_TEST AS INT MAXVALUE 999 MINVALUE 0 CYCLE;