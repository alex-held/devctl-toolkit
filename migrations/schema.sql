--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: licenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.licenses (
    id uuid NOT NULL,
    tool_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    body text,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.licenses OWNER TO postgres;

--
-- Name: schema_migration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migration (
    version character varying(14) NOT NULL
);


ALTER TABLE public.schema_migration OWNER TO postgres;

--
-- Name: tools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tools (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    name_with_owner character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    discovery character varying(255) DEFAULT 'github'::character varying NOT NULL,
    description text,
    readme text,
    topics character varying[] NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    stars integer DEFAULT 0 NOT NULL,
    watchers integer DEFAULT 0 NOT NULL,
    forks integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.tools OWNER TO postgres;

--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: tools tools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tools
    ADD CONSTRAINT tools_pkey PRIMARY KEY (id);


--
-- Name: licenses_tool_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX licenses_tool_id_idx ON public.licenses USING btree (tool_id);


--
-- Name: schema_migration_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX schema_migration_version_idx ON public.schema_migration USING btree (version);


--
-- Name: tools_stars_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tools_stars_idx ON public.tools USING btree (stars);


--
-- Name: tools_url_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tools_url_idx ON public.tools USING btree (url);


--
-- PostgreSQL database dump complete
--

