--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.8
-- Dumped by pg_dump version 9.4.8
-- Started on 2018-03-09 22:58:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2158 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 179 (class 1259 OID 42256)
-- Name: abogado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE abogado (
    id_abogado numeric NOT NULL,
    id_usuario numeric,
    nombre character varying(15) NOT NULL,
    apellido character varying(20) NOT NULL,
    direccion character varying(40) NOT NULL,
    telefono character varying(12) NOT NULL,
    ci numeric(8,0),
    ruc character varying
);


ALTER TABLE abogado OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 42348)
-- Name: clase; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clase (
    id_clase numeric NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE clase OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 42197)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cliente (
    id_cliente numeric NOT NULL,
    id_usuario numeric,
    nombre character varying(15) NOT NULL,
    apellido character varying(20) NOT NULL,
    direccion character varying(40) NOT NULL,
    telefono character varying(12) NOT NULL,
    ci numeric(8,0),
    ruc character varying,
    estado character varying,
    CONSTRAINT ck_estado_cliente CHECK ((((estado)::text ~~ 'activo'::text) OR ((estado)::text ~~ 'inactivo'::text)))
);


ALTER TABLE cliente OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 42321)
-- Name: documento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documento (
    id_documento numeric NOT NULL,
    id_expediente numeric NOT NULL,
    id_tipo_documento numeric NOT NULL,
    descripcion character varying(40) NOT NULL,
    fecha date NOT NULL,
    documento bytea NOT NULL
);


ALTER TABLE documento OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 42378)
-- Name: estado_marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estado_marca (
    id_estado numeric NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE estado_marca OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 42340)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evento (
    id_evento numeric NOT NULL,
    id_marca numeric NOT NULL,
    descripcion character varying(50) NOT NULL,
    fecha date NOT NULL
);


ALTER TABLE evento OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 42295)
-- Name: expediente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE expediente (
    id_expediente numeric NOT NULL,
    id_cliente numeric NOT NULL,
    id_abogado numeric NOT NULL,
    nro_expediente numeric NOT NULL
);


ALTER TABLE expediente OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 42211)
-- Name: factura_cabecera; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE factura_cabecera (
    id_fact_cab numeric NOT NULL,
    id_cliente numeric NOT NULL,
    num_fact numeric(13,0) NOT NULL,
    fecha date NOT NULL,
    monto_total numeric NOT NULL,
    tipo character(1) NOT NULL,
    forma_pago character(1) NOT NULL,
    iva numeric NOT NULL,
    CONSTRAINT ck_constraint_forma_pago CHECK (((forma_pago = 'E'::bpchar) OR (forma_pago = 'C'::bpchar))),
    CONSTRAINT ck_constraint_iva CHECK (((iva = (10)::numeric) OR (iva = (5)::numeric))),
    CONSTRAINT ck_constraint_tipo_factura CHECK (((tipo = 'C'::bpchar) OR (tipo = 'R'::bpchar)))
);


ALTER TABLE factura_cabecera OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 42227)
-- Name: factura_detalle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE factura_detalle (
    id_fact_det numeric NOT NULL,
    id_fact_cabecera numeric NOT NULL,
    id_tramite numeric NOT NULL,
    numero_item numeric NOT NULL,
    precio numeric NOT NULL,
    descripcion character varying(40) NOT NULL,
    iva numeric NOT NULL,
    CONSTRAINT ck_constraint_iva CHECK (((iva = (10)::numeric) OR (iva = (5)::numeric)))
);


ALTER TABLE factura_detalle OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 42269)
-- Name: historial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE historial (
    id_historial numeric NOT NULL,
    id_abogado numeric NOT NULL,
    id_marca numeric NOT NULL,
    fecha date NOT NULL,
    operacion character varying NOT NULL,
    detalle character varying NOT NULL
);


ALTER TABLE historial OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 42386)
-- Name: marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE marca (
    id_marca numeric NOT NULL,
    id_expediente numeric NOT NULL,
    id_estado numeric NOT NULL,
    id_pais numeric NOT NULL,
    id_tipo_marca numeric NOT NULL,
    id_clase numeric NOT NULL,
    producto character varying NOT NULL,
    titular character varying NOT NULL,
    fecha_presentacion date,
    fecha_publicacion date,
    concesion date,
    vencimiento date,
    observacion character varying,
    imagen_marca bytea
);


ALTER TABLE marca OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 42356)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pais (
    id_pais numeric NOT NULL,
    pais character varying NOT NULL
);


ALTER TABLE pais OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 42282)
-- Name: plan_pago; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE plan_pago (
    nombre_cuenta numeric NOT NULL,
    id_fact_cab numeric NOT NULL,
    monto numeric NOT NULL,
    vencimiento date NOT NULL,
    fecha_pago date NOT NULL
);


ALTER TABLE plan_pago OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 42173)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rol (
    id_rol numeric NOT NULL,
    descripcion character varying(30) NOT NULL
);


ALTER TABLE rol OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 42313)
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_documento (
    id_tipo_documento numeric NOT NULL,
    descripcion character varying(40) NOT NULL
);


ALTER TABLE tipo_documento OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 42370)
-- Name: tipo_marca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_marca (
    id_tipo_marca numeric NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE tipo_marca OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 42243)
-- Name: tramite; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tramite (
    id_tramite numeric NOT NULL,
    precio numeric NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE tramite OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 42181)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    id_usuario numeric NOT NULL,
    id_rol numeric,
    cuenta character varying(10),
    password character varying(15)
);


ALTER TABLE usuario OWNER TO postgres;

--
-- TOC entry 2139 (class 0 OID 42256)
-- Dependencies: 179
-- Data for Name: abogado; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2146 (class 0 OID 42348)
-- Dependencies: 186
-- Data for Name: clase; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2135 (class 0 OID 42197)
-- Dependencies: 175
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cliente (id_cliente, id_usuario, nombre, apellido, direccion, telefono, ci, ruc, estado) VALUES (1, 1, 'Marcelo', 'Caballero', '15', '15', 15, '15', 'activo');


--
-- TOC entry 2144 (class 0 OID 42321)
-- Dependencies: 184
-- Data for Name: documento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2149 (class 0 OID 42378)
-- Dependencies: 189
-- Data for Name: estado_marca; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2145 (class 0 OID 42340)
-- Dependencies: 185
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2142 (class 0 OID 42295)
-- Dependencies: 182
-- Data for Name: expediente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2136 (class 0 OID 42211)
-- Dependencies: 176
-- Data for Name: factura_cabecera; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2137 (class 0 OID 42227)
-- Dependencies: 177
-- Data for Name: factura_detalle; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2140 (class 0 OID 42269)
-- Dependencies: 180
-- Data for Name: historial; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2150 (class 0 OID 42386)
-- Dependencies: 190
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2147 (class 0 OID 42356)
-- Dependencies: 187
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2141 (class 0 OID 42282)
-- Dependencies: 181
-- Data for Name: plan_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2133 (class 0 OID 42173)
-- Dependencies: 173
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO rol (id_rol, descripcion) VALUES (1, 'Cliente');


--
-- TOC entry 2143 (class 0 OID 42313)
-- Dependencies: 183
-- Data for Name: tipo_documento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2148 (class 0 OID 42370)
-- Dependencies: 188
-- Data for Name: tipo_marca; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2138 (class 0 OID 42243)
-- Dependencies: 178
-- Data for Name: tramite; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2134 (class 0 OID 42181)
-- Dependencies: 174
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario (id_usuario, id_rol, cuenta, password) VALUES (1, 1, 'marcecv', 'rosperra');


--
-- TOC entry 1983 (class 2606 OID 42263)
-- Name: pk_tabla_abogado; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY abogado
    ADD CONSTRAINT pk_tabla_abogado PRIMARY KEY (id_abogado);


--
-- TOC entry 1977 (class 2606 OID 42218)
-- Name: pk_tabla_cab_factura; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY factura_cabecera
    ADD CONSTRAINT pk_tabla_cab_factura PRIMARY KEY (id_fact_cab);


--
-- TOC entry 1997 (class 2606 OID 42355)
-- Name: pk_tabla_clase; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clase
    ADD CONSTRAINT pk_tabla_clase PRIMARY KEY (id_clase);


--
-- TOC entry 1975 (class 2606 OID 42204)
-- Name: pk_tabla_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT pk_tabla_cliente PRIMARY KEY (id_cliente);


--
-- TOC entry 1993 (class 2606 OID 42328)
-- Name: pk_tabla_documento; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT pk_tabla_documento PRIMARY KEY (id_documento);


--
-- TOC entry 2003 (class 2606 OID 42385)
-- Name: pk_tabla_estado_marca; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estado_marca
    ADD CONSTRAINT pk_tabla_estado_marca PRIMARY KEY (id_estado);


--
-- TOC entry 1995 (class 2606 OID 42347)
-- Name: pk_tabla_evento; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT pk_tabla_evento PRIMARY KEY (id_evento);


--
-- TOC entry 1989 (class 2606 OID 42302)
-- Name: pk_tabla_expediente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT pk_tabla_expediente PRIMARY KEY (id_expediente);


--
-- TOC entry 1979 (class 2606 OID 42241)
-- Name: pk_tabla_fact_detalle; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY factura_detalle
    ADD CONSTRAINT pk_tabla_fact_detalle PRIMARY KEY (id_fact_det);


--
-- TOC entry 1985 (class 2606 OID 42276)
-- Name: pk_tabla_historial; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT pk_tabla_historial PRIMARY KEY (id_historial);


--
-- TOC entry 2005 (class 2606 OID 42393)
-- Name: pk_tabla_marca; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT pk_tabla_marca PRIMARY KEY (id_marca);


--
-- TOC entry 1999 (class 2606 OID 42363)
-- Name: pk_tabla_pais; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pk_tabla_pais PRIMARY KEY (id_pais);


--
-- TOC entry 1987 (class 2606 OID 42289)
-- Name: pk_tabla_plan_pago; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plan_pago
    ADD CONSTRAINT pk_tabla_plan_pago PRIMARY KEY (nombre_cuenta);


--
-- TOC entry 1971 (class 2606 OID 42180)
-- Name: pk_tabla_rol; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT pk_tabla_rol PRIMARY KEY (id_rol);


--
-- TOC entry 1991 (class 2606 OID 42320)
-- Name: pk_tabla_tipo_documento; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_documento
    ADD CONSTRAINT pk_tabla_tipo_documento PRIMARY KEY (id_tipo_documento);


--
-- TOC entry 2001 (class 2606 OID 42377)
-- Name: pk_tabla_tipo_marca; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_marca
    ADD CONSTRAINT pk_tabla_tipo_marca PRIMARY KEY (id_tipo_marca);


--
-- TOC entry 1981 (class 2606 OID 42250)
-- Name: pk_tabla_tramite; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tramite
    ADD CONSTRAINT pk_tabla_tramite PRIMARY KEY (id_tramite);


--
-- TOC entry 1973 (class 2606 OID 42188)
-- Name: pk_tabla_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT pk_tabla_usuario PRIMARY KEY (id_usuario);


--
-- TOC entry 2010 (class 2606 OID 42251)
-- Name: fk_id_tramite_tabla_tramite; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_detalle
    ADD CONSTRAINT fk_id_tramite_tabla_tramite FOREIGN KEY (id_tramite) REFERENCES tramite(id_tramite);


--
-- TOC entry 2011 (class 2606 OID 42264)
-- Name: fk_tabla_abogado_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY abogado
    ADD CONSTRAINT fk_tabla_abogado_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- TOC entry 2007 (class 2606 OID 42205)
-- Name: fk_tabla_cliente_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT fk_tabla_cliente_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);


--
-- TOC entry 2016 (class 2606 OID 42329)
-- Name: fk_tabla_documento_expediente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT fk_tabla_documento_expediente FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2017 (class 2606 OID 42334)
-- Name: fk_tabla_documento_tipo_doc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT fk_tabla_documento_tipo_doc FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documento(id_tipo_documento);


--
-- TOC entry 2018 (class 2606 OID 42419)
-- Name: fk_tabla_evento_marca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT fk_tabla_evento_marca FOREIGN KEY (id_marca) REFERENCES marca(id_marca);


--
-- TOC entry 2015 (class 2606 OID 42308)
-- Name: fk_tabla_expediente_abogado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT fk_tabla_expediente_abogado FOREIGN KEY (id_abogado) REFERENCES abogado(id_abogado);


--
-- TOC entry 2014 (class 2606 OID 42303)
-- Name: fk_tabla_expediente_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expediente
    ADD CONSTRAINT fk_tabla_expediente_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);


--
-- TOC entry 2008 (class 2606 OID 42219)
-- Name: fk_tabla_fact_cabecera_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_cabecera
    ADD CONSTRAINT fk_tabla_fact_cabecera_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);


--
-- TOC entry 2009 (class 2606 OID 42235)
-- Name: fk_tabla_fact_detalle_fact_cabecera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura_detalle
    ADD CONSTRAINT fk_tabla_fact_detalle_fact_cabecera FOREIGN KEY (id_fact_cabecera) REFERENCES factura_cabecera(id_fact_cab);


--
-- TOC entry 2012 (class 2606 OID 42277)
-- Name: fk_tabla_historial_abogado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT fk_tabla_historial_abogado FOREIGN KEY (id_abogado) REFERENCES abogado(id_abogado);


--
-- TOC entry 2023 (class 2606 OID 42414)
-- Name: fk_tabla_marca_clase; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT fk_tabla_marca_clase FOREIGN KEY (id_clase) REFERENCES clase(id_clase);


--
-- TOC entry 2020 (class 2606 OID 42399)
-- Name: fk_tabla_marca_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT fk_tabla_marca_estado FOREIGN KEY (id_estado) REFERENCES estado_marca(id_estado);


--
-- TOC entry 2019 (class 2606 OID 42394)
-- Name: fk_tabla_marca_expediente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT fk_tabla_marca_expediente FOREIGN KEY (id_expediente) REFERENCES expediente(id_expediente);


--
-- TOC entry 2021 (class 2606 OID 42404)
-- Name: fk_tabla_marca_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT fk_tabla_marca_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais);


--
-- TOC entry 2022 (class 2606 OID 42409)
-- Name: fk_tabla_marca_tipo_marca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT fk_tabla_marca_tipo_marca FOREIGN KEY (id_tipo_marca) REFERENCES tipo_marca(id_tipo_marca);


--
-- TOC entry 2013 (class 2606 OID 42290)
-- Name: fk_tabla_plan_pago_fact_cabecera; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY plan_pago
    ADD CONSTRAINT fk_tabla_plan_pago_fact_cabecera FOREIGN KEY (id_fact_cab) REFERENCES factura_cabecera(id_fact_cab);


--
-- TOC entry 2006 (class 2606 OID 42189)
-- Name: fk_tabla_usuario_rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT fk_tabla_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol);


--
-- TOC entry 2157 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-03-09 22:58:50

--
-- PostgreSQL database dump complete
--

