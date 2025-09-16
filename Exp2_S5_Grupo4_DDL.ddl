-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2025-09-16 11:14:09 CLST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE AFP 
    ( 
     id_afp     VARCHAR2 (100)  NOT NULL , 
     nombre_afp VARCHAR2 (100)  NOT NULL , 
     codigo     VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE AFP 
    ADD CONSTRAINT AFP_PK PRIMARY KEY ( id_afp ) ;

CREATE TABLE AtencionMedica 
    ( 
     id_atencion           VARCHAR2 (150)  NOT NULL , 
     fecha_atencion        DATE  NOT NULL , 
     especialidad          VARCHAR2 (150)  NOT NULL , 
     monto_pagado          INTEGER  NOT NULL , 
     metodo_pago           VARCHAR2 (100)  NOT NULL , 
     tipo_atencion         VARCHAR2 (100)  NOT NULL , 
     diagnostico           VARCHAR2 (500) , 
     modalidad             VARCHAR2 (50)  NOT NULL , 
     rut_paciente          VARCHAR2 (20)  NOT NULL , 
     rut_medico            VARCHAR2 (20)  NOT NULL , 
     Paciente_rut_paciente VARCHAR2 (15)  NOT NULL , 
     Medico_rut_medico     VARCHAR2 (20) , 
     Pago_Atencion_id_pago VARCHAR2 (150)  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX Atencion_Medica__IDX ON AtencionMedica 
    ( 
     Pago_Atencion_id_pago ASC 
    ) 
;

ALTER TABLE AtencionMedica 
    ADD CONSTRAINT Atencion_Medica_PK PRIMARY KEY ( id_atencion ) ;

CREATE TABLE Comuna 
    ( 
     id_comuna        VARCHAR2 (100)  NOT NULL , 
     nombre_comuna    VARCHAR2 (100)  NOT NULL , 
     id_region        VARCHAR2 (100)  NOT NULL , 
     Region_id_region VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE Comuna 
    ADD CONSTRAINT Comuna_PK PRIMARY KEY ( id_comuna ) ;

CREATE TABLE Especialidad 
    ( 
     id_especialidad     VARCHAR2 (150)  NOT NULL , 
     nombre_especialidad VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE Especialidad 
    ADD CONSTRAINT Especialidad_PK PRIMARY KEY ( id_especialidad ) ;

CREATE TABLE Institucion_Salud 
    ( 
     id_salud VARCHAR2 (100)  NOT NULL , 
     nombre   VARCHAR2 (100)  NOT NULL , 
     codigo   VARCHAR2 (100)  NOT NULL , 
     tipo     VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE Institucion_Salud 
    ADD CONSTRAINT Institucion_Salud_PK PRIMARY KEY ( id_salud ) ;

CREATE TABLE Medico 
    ( 
     rut_medico                   VARCHAR2 (20)  NOT NULL , 
     nombre_medico                VARCHAR2 (150)  NOT NULL , 
     fecha_ingreso                DATE  NOT NULL , 
     id_especialidad              VARCHAR2 (150)  NOT NULL , 
     id_afp                       VARCHAR2 (100)  NOT NULL , 
     id_salud                     VARCHAR2 (150)  NOT NULL , 
     Especialidad_id_especialidad VARCHAR2 (150)  NOT NULL , 
     AFP_id_afp                   VARCHAR2 (100)  NOT NULL , 
     Institucion_Salud_id_salud   VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE Medico 
    ADD CONSTRAINT Medico_PK PRIMARY KEY ( rut_medico ) ;

CREATE TABLE Paciente 
    ( 
     rut_paciente     VARCHAR2 (15)  NOT NULL , 
     nombre           VARCHAR2 (150)  NOT NULL , 
     edad             INTEGER  NOT NULL , 
     direccion        VARCHAR2 (150) , 
     id_comuna        VARCHAR2 (150)  NOT NULL , 
     sexo             VARCHAR2 (15)  NOT NULL , 
     Comuna_id_comuna VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE Paciente 
    ADD CONSTRAINT Paciente_PK PRIMARY KEY ( rut_paciente ) ;

CREATE TABLE PagoAtencion 
    ( 
     id_pago                     VARCHAR2 (150)  NOT NULL , 
     folio                       VARCHAR2 (50)  NOT NULL , 
     fecha_pago                  DATE  NOT NULL , 
     monto                       INTEGER  NOT NULL , 
     tipo_pago                   VARCHAR2 (50)  NOT NULL , 
     id_atencion                 VARCHAR2 (150)  NOT NULL , 
     Atencion_Medica_id_atencion VARCHAR2 (150)  NOT NULL 
    ) 
;
CREATE UNIQUE INDEX Pago_Atencion__IDX ON PagoAtencion 
    ( 
     Atencion_Medica_id_atencion ASC 
    ) 
;

ALTER TABLE PagoAtencion 
    ADD CONSTRAINT Pago_Atencion_PK PRIMARY KEY ( id_pago ) ;

CREATE TABLE Region 
    ( 
     id_region     VARCHAR2 (100)  NOT NULL , 
     nombre_region VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE Region 
    ADD CONSTRAINT Region_PK PRIMARY KEY ( id_region ) ;

ALTER TABLE AtencionMedica 
    ADD CONSTRAINT Atencion_Medica_Medico_FK FOREIGN KEY 
    ( 
     Medico_rut_medico
    ) 
    REFERENCES Medico 
    ( 
     rut_medico
    ) 
;

ALTER TABLE AtencionMedica 
    ADD CONSTRAINT Atencion_Medica_Paciente_FK FOREIGN KEY 
    ( 
     Paciente_rut_paciente
    ) 
    REFERENCES Paciente 
    ( 
     rut_paciente
    ) 
;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE AtencionMedica 
    ADD CONSTRAINT Atencion_Medica_Pago_Atencion_FK FOREIGN KEY 
    ( 
     Pago_Atencion_id_pago
    ) 
    REFERENCES PagoAtencion 
    ( 
     id_pago
    ) 
;

ALTER TABLE Comuna 
    ADD CONSTRAINT Comuna_Region_FK FOREIGN KEY 
    ( 
     Region_id_region
    ) 
    REFERENCES Region 
    ( 
     id_region
    ) 
;

ALTER TABLE Medico 
    ADD CONSTRAINT Medico_AFP_FK FOREIGN KEY 
    ( 
     AFP_id_afp
    ) 
    REFERENCES AFP 
    ( 
     id_afp
    ) 
;

ALTER TABLE Medico 
    ADD CONSTRAINT Medico_Especialidad_FK FOREIGN KEY 
    ( 
     Especialidad_id_especialidad
    ) 
    REFERENCES Especialidad 
    ( 
     id_especialidad
    ) 
;

ALTER TABLE Medico 
    ADD CONSTRAINT Medico_Institucion_Salud_FK FOREIGN KEY 
    ( 
     Institucion_Salud_id_salud
    ) 
    REFERENCES Institucion_Salud 
    ( 
     id_salud
    ) 
;

ALTER TABLE Paciente 
    ADD CONSTRAINT Paciente_Comuna_FK FOREIGN KEY 
    ( 
     Comuna_id_comuna
    ) 
    REFERENCES Comuna 
    ( 
     id_comuna
    ) 
;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE PagoAtencion 
    ADD CONSTRAINT Pago_Atencion_Atencion_Medica_FK FOREIGN KEY 
    ( 
     Atencion_Medica_id_atencion
    ) 
    REFERENCES AtencionMedica 
    ( 
     id_atencion
    ) 
;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             2
-- ALTER TABLE                             18
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   2
-- WARNINGS                                 0
