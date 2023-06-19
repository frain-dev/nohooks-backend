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

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    last_poll_time timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    configurable_type character varying,
    configurable_id uuid
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    firstname character varying NOT NULL,
    lastname character varying NOT NULL,
    user_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: render_account_configurations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.render_account_configurations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    api_key character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: render_deployments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.render_deployments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deployment_id character varying NOT NULL,
    object_hash character varying NOT NULL,
    render_service_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: render_services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.render_services (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    service_id character varying NOT NULL,
    object_hash character varying NOT NULL,
    render_account_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.services (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    provider character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: webhook_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhook_subscriptions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    convoy_endpoint_id character varying NOT NULL,
    convoy_subscription_id character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhooks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    event_type character varying NOT NULL,
    payload json NOT NULL,
    status integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: whitelisted_jwts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.whitelisted_jwts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    jti character varying NOT NULL,
    aud character varying,
    exp timestamp(6) without time zone NOT NULL,
    user_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: render_account_configurations render_account_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.render_account_configurations
    ADD CONSTRAINT render_account_configurations_pkey PRIMARY KEY (id);


--
-- Name: accounts render_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT render_accounts_pkey PRIMARY KEY (id);


--
-- Name: render_deployments render_deployments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.render_deployments
    ADD CONSTRAINT render_deployments_pkey PRIMARY KEY (id);


--
-- Name: render_services render_services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.render_services
    ADD CONSTRAINT render_services_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webhook_subscriptions webhook_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhook_subscriptions
    ADD CONSTRAINT webhook_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: webhooks webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhooks
    ADD CONSTRAINT webhooks_pkey PRIMARY KEY (id);


--
-- Name: whitelisted_jwts whitelisted_jwts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whitelisted_jwts
    ADD CONSTRAINT whitelisted_jwts_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_configurable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_configurable ON public.accounts USING btree (configurable_type, configurable_id);


--
-- Name: index_profiles_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_profiles_on_user_id ON public.profiles USING btree (user_id);


--
-- Name: index_render_deployments_on_deployment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_render_deployments_on_deployment_id ON public.render_deployments USING btree (deployment_id);


--
-- Name: index_render_deployments_on_render_service_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_render_deployments_on_render_service_id ON public.render_deployments USING btree (render_service_id);


--
-- Name: index_render_services_on_render_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_render_services_on_render_account_id ON public.render_services USING btree (render_account_id);


--
-- Name: index_render_services_on_service_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_render_services_on_service_id ON public.render_services USING btree (service_id);


--
-- Name: index_services_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_services_on_name ON public.services USING btree (name);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_whitelisted_jwts_on_jti; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_whitelisted_jwts_on_jti ON public.whitelisted_jwts USING btree (jti);


--
-- Name: index_whitelisted_jwts_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_whitelisted_jwts_on_user_id ON public.whitelisted_jwts USING btree (user_id);


--
-- Name: render_services fk_rails_0fcb96adc5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.render_services
    ADD CONSTRAINT fk_rails_0fcb96adc5 FOREIGN KEY (render_account_id) REFERENCES public.accounts(id);


--
-- Name: render_deployments fk_rails_39c1f3b789; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.render_deployments
    ADD CONSTRAINT fk_rails_39c1f3b789 FOREIGN KEY (render_service_id) REFERENCES public.render_services(id);


--
-- Name: profiles fk_rails_e424190865; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT fk_rails_e424190865 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: whitelisted_jwts fk_rails_fb288e0065; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whitelisted_jwts
    ADD CONSTRAINT fk_rails_fb288e0065 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('0'),
('20230617044757'),
('20230617105153'),
('20230617172518'),
('20230617205232'),
('20230618062335'),
('20230618160227'),
('20230618170032'),
('20230618171524'),
('20230618181856'),
('20230619080041'),
('20230619111134');


