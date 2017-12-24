/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     12/23/2017 2:46:42 PM                        */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('IZDELEK') and o.name = 'FK_IZDELEK_SPADA_V_KATEGORI')
alter table IZDELEK
   drop constraint FK_IZDELEK_SPADA_V_KATEGORI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KUPEC') and o.name = 'FK_KUPEC_JE_LOCIRA_NASLOV')
alter table KUPEC
   drop constraint FK_KUPEC_JE_LOCIRA_NASLOV
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('NASLOV') and o.name = 'FK_NASLOV_V_KRAJU_POSTA')
alter table NASLOV
   drop constraint FK_NASLOV_V_KRAJU_POSTA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('POSTAVKA_RACUNA') and o.name = 'FK_POSTAVKA_SESTAVLJA_RACUN')
alter table POSTAVKA_RACUNA
   drop constraint FK_POSTAVKA_SESTAVLJA_RACUN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('POSTAVKA_RACUNA') and o.name = 'FK_POSTAVKA_VELJA_ZA_IZDELEK')
alter table POSTAVKA_RACUNA
   drop constraint FK_POSTAVKA_VELJA_ZA_IZDELEK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RACUN') and o.name = 'FK_RACUN_JE_KUPIL_KUPEC')
alter table RACUN
   drop constraint FK_RACUN_JE_KUPIL_KUPEC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RACUN') and o.name = 'FK_RACUN_JE_PRODAL_ZAPOSLEN')
alter table RACUN
   drop constraint FK_RACUN_JE_PRODAL_ZAPOSLEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('IZDELEK')
            and   name  = 'SPADA_V_FK'
            and   indid > 0
            and   indid < 255)
   drop index IZDELEK.SPADA_V_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('IZDELEK')
            and   type = 'U')
   drop table IZDELEK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KATEGORIJA')
            and   type = 'U')
   drop table KATEGORIJA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('KUPEC')
            and   name  = 'JE_LOCIRAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index KUPEC.JE_LOCIRAN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KUPEC')
            and   type = 'U')
   drop table KUPEC
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('NASLOV')
            and   name  = 'V_KRAJU_FK'
            and   indid > 0
            and   indid < 255)
   drop index NASLOV.V_KRAJU_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NASLOV')
            and   type = 'U')
   drop table NASLOV
go

if exists (select 1
            from  sysobjects
           where  id = object_id('POSTA')
            and   type = 'U')
   drop table POSTA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('POSTAVKA_RACUNA')
            and   name  = 'SESTAVLJA_FK'
            and   indid > 0
            and   indid < 255)
   drop index POSTAVKA_RACUNA.SESTAVLJA_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('POSTAVKA_RACUNA')
            and   name  = 'VELJA_ZA_FK'
            and   indid > 0
            and   indid < 255)
   drop index POSTAVKA_RACUNA.VELJA_ZA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('POSTAVKA_RACUNA')
            and   type = 'U')
   drop table POSTAVKA_RACUNA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RACUN')
            and   name  = 'JE_KUPIL_FK'
            and   indid > 0
            and   indid < 255)
   drop index RACUN.JE_KUPIL_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RACUN')
            and   type = 'U')
   drop table RACUN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"USER"')
            and   type = 'U')
   drop table "USER"
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ZAPOSLEN')
            and   name  = 'JE_PRODAL_FK'
            and   indid > 0
            and   indid < 255)
   drop index ZAPOSLEN.JE_PRODAL_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ZAPOSLEN')
            and   type = 'U')
   drop table ZAPOSLEN
go

/*==============================================================*/
/* Table: IZDELEK                                               */
/*==============================================================*/
create table IZDELEK (
   ID_IZDELEK           int                  not null,
   ID_KATEGORIJA        int                  not null,
   NAZIV                varchar(20)          not null,
   OPIS                 varchar(20)          null,
   constraint PK_IZDELEK primary key nonclustered (ID_IZDELEK)
)
go

/*==============================================================*/
/* Index: SPADA_V_FK                                            */
/*==============================================================*/
create index SPADA_V_FK on IZDELEK (
ID_KATEGORIJA ASC
)
go

/*==============================================================*/
/* Table: KATEGORIJA                                            */
/*==============================================================*/
create table KATEGORIJA (
   ID_KATEGORIJA        int                  not null,
   NAZIV                varchar(20)          not null,
   constraint PK_KATEGORIJA primary key nonclustered (ID_KATEGORIJA)
)
go

/*==============================================================*/
/* Table: KUPEC                                                 */
/*==============================================================*/
create table KUPEC (
   ID_KUPCA             int                  not null,
   POSTNA_ST            int                  not null,
   ULICA                varchar(20)          not null,
   HISNA_ST             int                  not null,
   IME                  varchar(20)          not null,
   PRIIMEK              varchar(20)          not null,
   TELEFONSKA_STEVILKA  varchar(20)          not null,
   constraint PK_KUPEC primary key nonclustered (ID_KUPCA)
)
go

/*==============================================================*/
/* Index: JE_LOCIRAN_FK                                         */
/*==============================================================*/
create index JE_LOCIRAN_FK on KUPEC (
POSTNA_ST ASC,
ULICA ASC,
HISNA_ST ASC
)
go

/*==============================================================*/
/* Table: NASLOV                                                */
/*==============================================================*/
create table NASLOV (
   POSTNA_ST            int                  not null,
   ULICA                varchar(20)          not null,
   HISNA_ST             int                  not null,
   constraint PK_NASLOV primary key nonclustered (POSTNA_ST, ULICA, HISNA_ST)
)
go

/*==============================================================*/
/* Index: V_KRAJU_FK                                            */
/*==============================================================*/
create index V_KRAJU_FK on NASLOV (
POSTNA_ST ASC
)
go

/*==============================================================*/
/* Table: POSTA                                                 */
/*==============================================================*/
create table POSTA (
   POSTNA_ST            int                  not null,
   NAZIV                varchar(20)          not null,
   constraint PK_POSTA primary key nonclustered (POSTNA_ST)
)
go

/*==============================================================*/
/* Table: POSTAVKA_RACUNA                                       */
/*==============================================================*/
create table POSTAVKA_RACUNA (
   ID_IZDELEK           int                  not null,
   ID_RACUN             int                  not null,
   KOLICINA             int                  not null,
   constraint PK_POSTAVKA_RACUNA primary key (ID_IZDELEK, ID_RACUN)
)
go

/*==============================================================*/
/* Index: VELJA_ZA_FK                                           */
/*==============================================================*/
create index VELJA_ZA_FK on POSTAVKA_RACUNA (
ID_IZDELEK ASC
)
go

/*==============================================================*/
/* Index: SESTAVLJA_FK                                          */
/*==============================================================*/
create index SESTAVLJA_FK on POSTAVKA_RACUNA (
ID_RACUN ASC
)
go

/*==============================================================*/
/* Table: RACUN                                                 */
/*==============================================================*/
create table RACUN (
   ID_RACUN             int                  not null,
   ID_ZAPOSLEN          int                  null,
   ID_KUPCA             int                  null,
   DATUM                datetime             not null,
   POPUST               int                  null,
   constraint PK_RACUN primary key nonclustered (ID_RACUN)
)
go

/*==============================================================*/
/* Index: JE_KUPIL_FK                                           */
/*==============================================================*/
create index JE_KUPIL_FK on RACUN (
ID_KUPCA ASC
)
go

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" (
   ID_USER              int                  not null,
   USERNAME             varchar(20)          not null,
   PASSWORD             varchar(20)          not null,
   constraint PK_USER primary key nonclustered (ID_USER)
)
go

/*==============================================================*/
/* Table: ZAPOSLEN                                              */
/*==============================================================*/
create table ZAPOSLEN (
   ID_ZAPOSLEN          int                  not null,
   IME                  varchar(20)          not null,
   PRIIMEK              varchar(20)          not null,
   DAVCNA_ST            int                  not null,
   constraint PK_ZAPOSLEN primary key nonclustered (ID_ZAPOSLEN)
)
go

/*==============================================================*/
/* Index: JE_PRODAL_FK                                          */
/*==============================================================*/
create index JE_PRODAL_FK on ZAPOSLEN (
ID_ZAPOSLEN ASC
)
go

alter table IZDELEK
   add constraint FK_IZDELEK_SPADA_V_KATEGORI foreign key (ID_KATEGORIJA)
      references KATEGORIJA (ID_KATEGORIJA)
go

alter table KUPEC
   add constraint FK_KUPEC_JE_LOCIRA_NASLOV foreign key (POSTNA_ST, ULICA, HISNA_ST)
      references NASLOV (POSTNA_ST, ULICA, HISNA_ST)
go

alter table NASLOV
   add constraint FK_NASLOV_V_KRAJU_POSTA foreign key (POSTNA_ST)
      references POSTA (POSTNA_ST)
go

alter table POSTAVKA_RACUNA
   add constraint FK_POSTAVKA_SESTAVLJA_RACUN foreign key (ID_RACUN)
      references RACUN (ID_RACUN)
go

alter table POSTAVKA_RACUNA
   add constraint FK_POSTAVKA_VELJA_ZA_IZDELEK foreign key (ID_IZDELEK)
      references IZDELEK (ID_IZDELEK)
go

alter table RACUN
   add constraint FK_RACUN_JE_KUPIL_KUPEC foreign key (ID_KUPCA)
      references KUPEC (ID_KUPCA)
go

alter table RACUN
   add constraint FK_RACUN_JE_PRODAL_ZAPOSLEN foreign key (ID_ZAPOSLEN)
      references ZAPOSLEN (ID_ZAPOSLEN)
go

