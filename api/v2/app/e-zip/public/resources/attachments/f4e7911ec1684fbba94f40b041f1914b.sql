--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.15
-- Dumped by pg_dump version 9.4.4
-- Started on 2018-02-06 18:59:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 251 (class 3079 OID 11756)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2432 (class 0 OID 0)
-- Dependencies: 251
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 170 (class 1259 OID 133680)
-- Name: bpm_diagrams; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bpm_diagrams (
    id bigserial NOT NULL,
    type character varying(50) DEFAULT 'activity'::character varying,
    name character varying(100),
    slug character varying(255),
    description character varying(255),
    cover character varying(255),
    created_date timestamp with time zone,
    created_by character varying(255)
);


--
-- TOC entry 171 (class 1259 OID 133687)
-- Name: bpm_diagrams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2433 (class 0 OID 0)
-- Dependencies: 171
-- Name: bpm_diagrams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 172 (class 1259 OID 133689)
-- Name: bpm_forms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bpm_forms (
    bf_id bigserial NOT NULL,
    bf_activity bigint,
    bf_name character varying(100),
    bf_description character varying(200),
    bf_tpl_file character varying(100),
    bf_tpl_orig character varying(100)
);


--
-- TOC entry 173 (class 1259 OID 133695)
-- Name: bpm_forms_bf_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2434 (class 0 OID 0)
-- Dependencies: 173
-- Name: bpm_forms_bf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 174 (class 1259 OID 133697)
-- Name: bpm_forms_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bpm_forms_roles (
    bfr_id bigserial NOT NULL,
    bfr_bf_id bigint,
    bfr_sr_id bigint
);


--
-- TOC entry 175 (class 1259 OID 133700)
-- Name: bpm_forms_roles_bfr_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2435 (class 0 OID 0)
-- Dependencies: 175
-- Name: bpm_forms_roles_bfr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 176 (class 1259 OID 133702)
-- Name: bpm_forms_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bpm_forms_users (
    bfu_id bigserial NOT NULL,
    bfu_bf_id bigint,
    bfu_su_id bigint
);


--
-- TOC entry 177 (class 1259 OID 133705)
-- Name: bpm_forms_users_bfu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2436 (class 0 OID 0)
-- Dependencies: 177
-- Name: bpm_forms_users_bfu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 178 (class 1259 OID 133707)
-- Name: bpm_links; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bpm_links (
    id bigserial NOT NULL,
    name character varying(100),
    client_id character varying(50),
    client_source character varying(50),
    client_target character varying(50),
    type character varying(100),
    router_type character varying(255),
    diagram_id bigint,
    source_id bigint,
    target_id bigint,
    command character varying(1000),
    stroke character varying(50),
    label character varying(200),
    label_distance double precision DEFAULT (0.5)::double precision,
    convex integer DEFAULT 1,
    smooth integer DEFAULT 1,
    smoothness bigint,
    data_source text,
    params text
);


--
-- TOC entry 179 (class 1259 OID 133716)
-- Name: bpm_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2437 (class 0 OID 0)
-- Dependencies: 179
-- Name: bpm_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 180 (class 1259 OID 133718)
-- Name: bpm_shapes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bpm_shapes (
    id bigserial NOT NULL,
    client_id character varying(50),
    client_parent character varying(50),
    client_pool character varying(50),
    type character varying(100),
    mode character varying(50),
    diagram_id bigint,
    parent_id bigint,
    width double precision,
    height double precision,
    "left" double precision,
    top double precision,
    rotate double precision,
    label character varying(100),
    fill character varying(30),
    stroke character varying(30),
    stroke_width bigint,
    data_source text,
    params character varying(1000)
);


--
-- TOC entry 181 (class 1259 OID 133724)
-- Name: bpm_shapes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2438 (class 0 OID 0)
-- Dependencies: 181
-- Name: bpm_shapes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 182 (class 1259 OID 133726)
-- Name: dx_auth; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dx_auth (
    auth_col_id bigserial NOT NULL,
    group_child_id bigint,
    map_id bigint,
    dx_read bigint,
    dx_write bigint,
    dx_edit bigint,
    dx_delete bigint,
    dx_default bigint
);


--
-- TOC entry 183 (class 1259 OID 133729)
-- Name: dx_auth_auth_col_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2439 (class 0 OID 0)
-- Dependencies: 183
-- Name: dx_auth_auth_col_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 184 (class 1259 OID 133731)
-- Name: dx_mapping; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dx_mapping (
    map_id bigserial NOT NULL,
    map_profile_id bigint NOT NULL,
    map_table character varying(50) NOT NULL,
    map_type character varying(20) DEFAULT 'data'::character varying,
    map_xls_col character varying(50) NOT NULL,
    map_tbl_col character varying(50),
    map_dtype character varying(50) DEFAULT 'string'::character varying,
    map_pk bigint DEFAULT (0)::bigint,
    map_mandatory bigint DEFAULT (0)::bigint,
    map_ref_table character varying(50),
    map_ref_col character varying(50),
    map_ref_fk character varying(50),
    map_ref_ignore bigint DEFAULT (0)::bigint,
    map_active bigint,
    map_col_alias character varying(100),
    map_grp_seq bigint,
    map_sk bigint DEFAULT (0)::bigint,
    map_ref_contents text,
    map_col_seq bigint
);


--
-- TOC entry 185 (class 1259 OID 133743)
-- Name: dx_mapping_map_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2440 (class 0 OID 0)
-- Dependencies: 185
-- Name: dx_mapping_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 186 (class 1259 OID 133745)
-- Name: dx_profiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dx_profiles (
    profile_id bigserial NOT NULL,
    profile_name character varying(50),
    profile_desc character varying(200),
    header_row_idx bigint,
    col_offset character varying(20),
    row_offset bigint,
    map_header bigint,
    has_merge_cell integer
);


--
-- TOC entry 187 (class 1259 OID 133748)
-- Name: dx_profiles_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2441 (class 0 OID 0)
-- Dependencies: 187
-- Name: dx_profiles_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 188 (class 1259 OID 133763)
-- Name: kanban; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE kanban (
    panel_id bigserial NOT NULL,
    panel_color character varying(100),
    panel_card_filter character varying(100),
    panel_title character varying(100)
);


--
-- TOC entry 189 (class 1259 OID 133766)
-- Name: kanban_forms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE kanban_forms (
    kf_id bigserial NOT NULL,
    kf_diagrams_id bigint,
    kf_status bigint,
    kf_form_edit character varying(255),
    kf_form_view character varying(255)
);


--
-- TOC entry 190 (class 1259 OID 133772)
-- Name: kanban_forms_kf_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2442 (class 0 OID 0)
-- Dependencies: 190
-- Name: kanban_forms_kf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 191 (class 1259 OID 133774)
-- Name: kanban_panel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2443 (class 0 OID 0)
-- Dependencies: 191
-- Name: kanban_panel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 192 (class 1259 OID 133776)
-- Name: kanban_panels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE kanban_panels (
    kp_id bigserial NOT NULL,
    kp_ks_id bigint,
    kp_title character varying(50),
    kp_accent character varying(30),
    kp_order bigint DEFAULT (1)::bigint
);


--
-- TOC entry 193 (class 1259 OID 133780)
-- Name: kanban_panels_kp_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2444 (class 0 OID 0)
-- Dependencies: 193
-- Name: kanban_panels_kp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 194 (class 1259 OID 133782)
-- Name: kanban_settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE kanban_settings (
    ks_id bigserial NOT NULL,
    ks_name character varying(100),
    ks_description character varying(200),
    ks_api character varying(100),
    ks_image character varying(255)
);


--
-- TOC entry 195 (class 1259 OID 133788)
-- Name: kanban_settings_ks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2445 (class 0 OID 0)
-- Dependencies: 195
-- Name: kanban_settings_ks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 196 (class 1259 OID 133790)
-- Name: kanban_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE kanban_statuses (
    kst_id bigserial NOT NULL,
    kst_kp_id bigint,
    kst_diagrams_id bigint,
    kst_status bigint,
    kst_color character varying(20)
);


--
-- TOC entry 197 (class 1259 OID 133793)
-- Name: kanban_statuses_kst_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 197
-- Name: kanban_statuses_kst_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 198 (class 1259 OID 133800)
-- Name: sys_captcha; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_captcha (
    id character varying(40) NOT NULL,
    namespace character varying(32) NOT NULL,
    code character varying(32) NOT NULL,
    code_display character varying(32) NOT NULL,
    created bigint NOT NULL,
    audio_data bytea
);


--
-- TOC entry 199 (class 1259 OID 133806)
-- Name: sys_config; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_config (
    sc_id bigserial NOT NULL,
    sc_name character varying(255),
    sc_value character varying(255)
);


--
-- TOC entry 200 (class 1259 OID 133812)
-- Name: sys_config_sc_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 200
-- Name: sys_config_sc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 201 (class 1259 OID 133814)
-- Name: sys_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_labels (
    sl_label character varying(255),
    sl_created_by integer,
    sl_created_dt timestamp without time zone,
    sl_color character varying(50) DEFAULT 'var(--paper-blue-grey-500)'::character varying,
    sl_id bigserial NOT NULL,
    sl_sp_id integer
);


--
-- TOC entry 202 (class 1259 OID 133818)
-- Name: sys_labels_sl_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 202
-- Name: sys_labels_sl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 203 (class 1259 OID 133820)
-- Name: sys_menus; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_menus (
    smn_id bigserial NOT NULL,
    smn_parent_id bigint DEFAULT (0)::bigint,
    smn_title character varying(50),
    smn_icon character varying(30),
    smn_path character varying(100),
    smn_order bigint DEFAULT (1)::bigint,
    smn_visible integer DEFAULT 1,
    smn_default integer DEFAULT 0
);


--
-- TOC entry 204 (class 1259 OID 133827)
-- Name: sys_menus_smn_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 204
-- Name: sys_menus_smn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 205 (class 1259 OID 133829)
-- Name: sys_modules; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_modules (
    sm_id bigserial NOT NULL,
    sm_name character varying(100),
    sm_version character varying(30),
    sm_title character varying(100),
    sm_author character varying(50) DEFAULT 'KCT Team'::character varying,
    sm_repository character varying(255),
    sm_api character varying(255)
);


--
-- TOC entry 206 (class 1259 OID 133836)
-- Name: sys_modules_capabilities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_modules_capabilities (
    smc_id bigserial NOT NULL,
    smc_sm_id bigint,
    smc_name character varying(100),
    smc_description character varying(255)
);


--
-- TOC entry 207 (class 1259 OID 133839)
-- Name: sys_modules_capabilities_smc_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 207
-- Name: sys_modules_capabilities_smc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 208 (class 1259 OID 133841)
-- Name: sys_modules_sm_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 208
-- Name: sys_modules_sm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 209 (class 1259 OID 133843)
-- Name: sys_numbers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_numbers (
    sn_id bigserial NOT NULL,
    sn_name character varying(50),
    sn_value bigint,
    sn_length bigint,
    sn_prefix character varying(30),
    sn_suffix character varying(30)
);


--
-- TOC entry 210 (class 1259 OID 133846)
-- Name: sys_numbers_sn_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 210
-- Name: sys_numbers_sn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 211 (class 1259 OID 133848)
-- Name: sys_permissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_permissions (
    sp_id bigserial NOT NULL,
    sp_sr_id bigint,
    sp_smc_id bigint
);


--
-- TOC entry 212 (class 1259 OID 133851)
-- Name: sys_permissions_sp_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 212
-- Name: sys_permissions_sp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 213 (class 1259 OID 133853)
-- Name: sys_projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_projects (
    sp_name character varying(255),
    sp_title character varying(255),
    sp_desc text,
    sp_creator_id bigint,
    sp_created_date timestamp without time zone,
    sp_worksheet_id bigint,
    sp_id bigserial NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 133859)
-- Name: sys_projects_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_projects_labels (
    spl_id bigserial NOT NULL,
    spl_sp_id bigint,
    spl_sl_id bigint
);


--
-- TOC entry 215 (class 1259 OID 133862)
-- Name: sys_projects_labels_spl_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2454 (class 0 OID 0)
-- Dependencies: 215
-- Name: sys_projects_labels_spl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 216 (class 1259 OID 133864)
-- Name: sys_projects_sp_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2455 (class 0 OID 0)
-- Dependencies: 216
-- Name: sys_projects_sp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 217 (class 1259 OID 133866)
-- Name: sys_projects_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_projects_users (
    spu_sp_id bigint,
    spu_su_id bigint,
    spu_id bigserial NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 133869)
-- Name: sys_projects_users_spu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2456 (class 0 OID 0)
-- Dependencies: 218
-- Name: sys_projects_users_spu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 219 (class 1259 OID 133871)
-- Name: sys_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_roles (
    sr_id bigserial NOT NULL,
    sr_name character varying(100),
    sr_slug character varying(100),
    sr_description character varying(255),
    sr_default integer DEFAULT 0,
    sr_created_date timestamp with time zone DEFAULT now(),
    sr_created_by character varying(50) DEFAULT 'system'::character varying
);


--
-- TOC entry 220 (class 1259 OID 133880)
-- Name: sys_roles_kanban; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_roles_kanban (
    srk_id bigserial NOT NULL,
    srk_sr_id bigint,
    srk_ks_id bigint,
    srk_selected integer DEFAULT 0
);


--
-- TOC entry 221 (class 1259 OID 133884)
-- Name: sys_roles_kanban_srk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2457 (class 0 OID 0)
-- Dependencies: 221
-- Name: sys_roles_kanban_srk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 222 (class 1259 OID 133886)
-- Name: sys_roles_menus; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_roles_menus (
    srm_id bigserial NOT NULL,
    srm_sr_id bigint,
    srm_smn_id bigint,
    srm_selected integer DEFAULT 0
);


--
-- TOC entry 223 (class 1259 OID 133890)
-- Name: sys_roles_menus_srm_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2458 (class 0 OID 0)
-- Dependencies: 223
-- Name: sys_roles_menus_srm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 224 (class 1259 OID 133892)
-- Name: sys_roles_panels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_roles_panels (
    srs_id bigserial NOT NULL,
    srs_sp_id bigint,
    srs_sr_id bigint,
    srs_kp_id bigint,
    srs_kst_id bigint,
    srs_checked smallint DEFAULT 0
);


--
-- TOC entry 225 (class 1259 OID 133896)
-- Name: sys_roles_panels_srs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2459 (class 0 OID 0)
-- Dependencies: 225
-- Name: sys_roles_panels_srs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 226 (class 1259 OID 133898)
-- Name: sys_roles_permissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_roles_permissions (
    srp_id bigserial NOT NULL,
    srp_sr_id bigint,
    srp_smc_id bigint,
    srp_selected integer DEFAULT 0
);


--
-- TOC entry 227 (class 1259 OID 133902)
-- Name: sys_roles_permissions_srp_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2460 (class 0 OID 0)
-- Dependencies: 227
-- Name: sys_roles_permissions_srp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 228 (class 1259 OID 133904)
-- Name: sys_roles_sr_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2461 (class 0 OID 0)
-- Dependencies: 228
-- Name: sys_roles_sr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 229 (class 1259 OID 133906)
-- Name: sys_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_users (
    su_id bigserial NOT NULL,
    su_sr_id bigint,
    su_email character varying(255),
    su_passwd character varying(255),
    su_fullname character varying(255),
    su_avatar character varying(255),
    su_access_token text,
    su_refresh_token text,
    su_sex character varying(30),
    su_dob date,
    su_job_title character varying(100),
    su_company character varying(255),
    su_active integer DEFAULT 1,
    su_created_date timestamp with time zone DEFAULT now(),
    su_created_by character varying(50) DEFAULT 'system'::character varying,
    su_invite_token text,
    su_recover_token text
);


--
-- TOC entry 230 (class 1259 OID 133915)
-- Name: sys_users_kanban; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_users_kanban (
    suk_id bigserial NOT NULL,
    suk_su_id bigint,
    suk_ks_id bigint,
    suk_selected integer DEFAULT 0
);


--
-- TOC entry 231 (class 1259 OID 133919)
-- Name: sys_users_kanban_suk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2462 (class 0 OID 0)
-- Dependencies: 231
-- Name: sys_users_kanban_suk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 232 (class 1259 OID 133921)
-- Name: sys_users_menus; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_users_menus (
    sum_id bigserial NOT NULL,
    sum_su_id bigint,
    sum_smn_id bigint,
    sum_selected integer DEFAULT 0
);


--
-- TOC entry 233 (class 1259 OID 133925)
-- Name: sys_users_menus_sum_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2463 (class 0 OID 0)
-- Dependencies: 233
-- Name: sys_users_menus_sum_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 234 (class 1259 OID 133927)
-- Name: sys_users_panels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_users_panels (
    sus_id bigserial NOT NULL,
    sus_sp_id bigint,
    sus_su_id bigint,
    sus_kp_id bigint,
    sus_kst_id bigint,
    sus_checked smallint DEFAULT 0
);


--
-- TOC entry 235 (class 1259 OID 133931)
-- Name: sys_users_panels_sus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2464 (class 0 OID 0)
-- Dependencies: 235
-- Name: sys_users_panels_sus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 236 (class 1259 OID 133933)
-- Name: sys_users_permissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_users_permissions (
    sup_id bigserial NOT NULL,
    sup_su_id bigint,
    sup_smc_id bigint,
    sup_selected integer DEFAULT 0
);


--
-- TOC entry 237 (class 1259 OID 133937)
-- Name: sys_users_permissions_sup_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2465 (class 0 OID 0)
-- Dependencies: 237
-- Name: sys_users_permissions_sup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 238 (class 1259 OID 133939)
-- Name: sys_users_su_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2466 (class 0 OID 0)
-- Dependencies: 238
-- Name: sys_users_su_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 239 (class 1259 OID 133998)
-- Name: trx_tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trx_tasks (
    tt_id bigserial NOT NULL,
    tt_title character varying(255),
    tt_flag character varying(255),
    tt_sp_id bigint,
    tt_desc text,
    tt_due_date date,
    tt_creator_id bigint,
    tt_created_dt timestamp without time zone,
    tt_slug character varying(255)
);


--
-- TOC entry 240 (class 1259 OID 134004)
-- Name: trx_tasks_activities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trx_tasks_activities (
    tta_id bigserial NOT NULL,
    tta_tt_id bigint,
    tta_type character varying(50),
    tta_sender bigint,
    tta_created timestamp without time zone,
    tta_data text,
    tta_file character varying(255)
);


--
-- TOC entry 241 (class 1259 OID 134010)
-- Name: trx_tasks_activities_tta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 241
-- Name: trx_tasks_activities_tta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 242 (class 1259 OID 134012)
-- Name: trx_tasks_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trx_tasks_comments (
    ttc_tt_id bigint,
    ttc_sender bigint,
    ttc_message text,
    ttc_id bigserial NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 134018)
-- Name: trx_tasks_comments_ttc_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 243
-- Name: trx_tasks_comments_ttc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 244 (class 1259 OID 134020)
-- Name: trx_tasks_labels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trx_tasks_labels (
    ttl_id bigserial NOT NULL,
    ttl_tt_id bigint,
    ttl_sl_id bigint
);


--
-- TOC entry 245 (class 1259 OID 134023)
-- Name: trx_tasks_labels_ttl_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 245
-- Name: trx_tasks_labels_ttl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 246 (class 1259 OID 134025)
-- Name: trx_tasks_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trx_tasks_statuses (
    tts_id bigserial NOT NULL,
    tts_tt_id bigint,
    tts_status bigint,
    tts_target bigint,
    tts_worker character varying(100),
    tts_deleted integer,
    tts_created timestamp without time zone,
    tts_slug character varying(255)
);


--
-- TOC entry 247 (class 1259 OID 134028)
-- Name: trx_tasks_statuses_tts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 247
-- Name: trx_tasks_statuses_tts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 248 (class 1259 OID 134030)
-- Name: trx_tasks_tt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 248
-- Name: trx_tasks_tt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 249 (class 1259 OID 134032)
-- Name: trx_tasks_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trx_tasks_users (
    ttu_tt_id bigint,
    ttu_su_id bigint,
    ttu_id bigserial NOT NULL
);


--
-- TOC entry 250 (class 1259 OID 134035)
-- Name: trx_tasks_users_ttu_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--




--
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 250
-- Name: trx_tasks_users_ttu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--


--
-- TOC entry 2082 (class 2604 OID 134037)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2083 (class 2604 OID 134038)
-- Name: bf_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2084 (class 2604 OID 134039)
-- Name: bfr_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2085 (class 2604 OID 134040)
-- Name: bfu_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2089 (class 2604 OID 134041)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2090 (class 2604 OID 134042)
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2091 (class 2604 OID 134043)
-- Name: auth_col_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2098 (class 2604 OID 134044)
-- Name: map_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2099 (class 2604 OID 134045)
-- Name: profile_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2100 (class 2604 OID 134048)
-- Name: panel_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2101 (class 2604 OID 134049)
-- Name: kf_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2103 (class 2604 OID 134050)
-- Name: kp_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2104 (class 2604 OID 134051)
-- Name: ks_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2105 (class 2604 OID 134052)
-- Name: kst_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2106 (class 2604 OID 134054)
-- Name: sc_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2108 (class 2604 OID 134055)
-- Name: sl_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2113 (class 2604 OID 134056)
-- Name: smn_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2115 (class 2604 OID 134057)
-- Name: sm_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2116 (class 2604 OID 134058)
-- Name: smc_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2117 (class 2604 OID 134059)
-- Name: sn_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2118 (class 2604 OID 134060)
-- Name: sp_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2119 (class 2604 OID 134061)
-- Name: sp_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2120 (class 2604 OID 134062)
-- Name: spl_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2121 (class 2604 OID 134063)
-- Name: spu_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2125 (class 2604 OID 134064)
-- Name: sr_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2127 (class 2604 OID 134065)
-- Name: srk_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2129 (class 2604 OID 134066)
-- Name: srm_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2131 (class 2604 OID 134067)
-- Name: srs_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2133 (class 2604 OID 134068)
-- Name: srp_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2137 (class 2604 OID 134069)
-- Name: su_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2139 (class 2604 OID 134070)
-- Name: suk_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2141 (class 2604 OID 134071)
-- Name: sum_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2143 (class 2604 OID 134072)
-- Name: sus_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2145 (class 2604 OID 134073)
-- Name: sup_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2146 (class 2604 OID 134082)
-- Name: tt_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2147 (class 2604 OID 134083)
-- Name: tta_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2148 (class 2604 OID 134084)
-- Name: ttc_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2149 (class 2604 OID 134085)
-- Name: ttl_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2150 (class 2604 OID 134086)
-- Name: tts_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2151 (class 2604 OID 134087)
-- Name: ttu_id; Type: DEFAULT; Schema: public; Owner: -
--




--
-- TOC entry 2344 (class 0 OID 133680)
-- Dependencies: 170
-- Data for Name: bpm_diagrams; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO bpm_diagrams VALUES (58, 'Graph.diagram.type.Activity', 'Simple Workflow', 'simple-workflow', 'Only todo and doing task flow', 'c79bfa2e7aefb5e53c3583c4f91c3d5b.jpg', '2017-12-21 18:28:18+00', NULL);
INSERT INTO bpm_diagrams VALUES (59, 'Graph.diagram.type.Activity', 'Backlog Workflow', 'backlog-workflow', 'Task flow follow backlog activity', 'a8d9c3891901e10fd6306b49d130ec3b.jpg', '2017-12-21 18:31:50+00', NULL);
INSERT INTO bpm_diagrams VALUES (57, 'Graph.diagram.type.Activity', 'Classic Workflow', 'classic-workflow', 'No diagram description', 'b17c6fc7226f0c5854632a408d6d6788.jpg', '2017-12-05 09:39:42+00', NULL);


--
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 171
-- Name: bpm_diagrams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('bpm_diagrams_id_seq', 59, true);


--
-- TOC entry 2346 (class 0 OID 133689)
-- Dependencies: 172
-- Data for Name: bpm_forms; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO bpm_forms VALUES (12, 808, 'Site planning upload template', 'No description', '19d1f246a90d48307faeac3fdb31a30e.html', 'upload.html');
INSERT INTO bpm_forms VALUES (13, 809, 'Approval template', 'No description', '6f64be85304054dee25e47629da7c6d3.html', 'approval.html');
INSERT INTO bpm_forms VALUES (14, 813, 'Create SSR template', 'No description', 'fe6683b844815e3e1864772e20fab81c.html', 'create-site-ssr.html');
INSERT INTO bpm_forms VALUES (15, 821, 'Sent Data SSR template', 'No description', '73a72a7da1f948d2ae66541209894d24.html', 'send-data-ssr.html');
INSERT INTO bpm_forms VALUES (16, 819, 'Add far end template', 'No description', '6edbcdb933fae65132a71f658fb14038.html', 'add-far-end.html');
INSERT INTO bpm_forms VALUES (17, 817, 'Review far end template', 'No description', 'dbce59b50bb42ef7997246eea071a6f7.html', 'review-far-end.html');
INSERT INTO bpm_forms VALUES (18, 811, 'Update prodef template', 'No description', '6fb5ce6462d47296620683c9d779ce27.html', 'upload-prodef.html');
INSERT INTO bpm_forms VALUES (19, 825, 'Open Opportunity Form', 'No description', 'e870a901848a6d2859d15f04d6284630.html', 'oportunity_form_2.html');
INSERT INTO bpm_forms VALUES (30, 863, 'Form Done', 'No description', '4b9faff43018b7fbb9b1645917035430.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (29, 862, 'Form Doing', 'No description', 'f93d3cce7efb21ee2667d46f0249fb2d.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (28, 861, 'Form Todo', 'No description', 'b518cb7a6dc5bb53dcc7a10aee7c2e79.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (31, 869, 'Task Editor', 'No description', '11342055cc8a7c59f879c3192f35f614.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (35, 873, 'Task Editor', 'No description', 'a5d965a5d94d1368b0254e6f8d489e4a.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (34, 872, 'Task Editor', 'No description', '1661b1e82c1f7daeb026c195099ca4c9.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (33, 870, 'Task Editor', 'No description', '6b0d21713aa2bef4a4598df191880d1c.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (32, 871, 'Task Editor', 'No description', 'dfc6bab2068a87382e5e5bca931f6a2f.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (27, 860, 'Form Start', 'No description', '0217ac43eeb0d07bde0a5db69540dab0.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (36, 866, NULL, 'No description', '7c42debef080e0c31317b68fbba6e219.pdf', '41621237241-712302242-ticket.pdf');
INSERT INTO bpm_forms VALUES (37, 865, 'Task Editor', 'No description', '61cccdd90be2dbf38b439a5f0ef82c13.html', 'task-editor.html');
INSERT INTO bpm_forms VALUES (38, 867, 'Task Editor', 'No description', '2938dd470cd9f698343dec57f8029955.html', 'task-editor.html');


--
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 173
-- Name: bpm_forms_bf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('bpm_forms_bf_id_seq', 40, true);


--
-- TOC entry 2348 (class 0 OID 133697)
-- Dependencies: 174
-- Data for Name: bpm_forms_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO bpm_forms_roles VALUES (9, 12, 1);
INSERT INTO bpm_forms_roles VALUES (10, 13, 1);
INSERT INTO bpm_forms_roles VALUES (16, 31, 4);
INSERT INTO bpm_forms_roles VALUES (17, 35, 4);
INSERT INTO bpm_forms_roles VALUES (18, 34, 4);
INSERT INTO bpm_forms_roles VALUES (19, 33, 4);
INSERT INTO bpm_forms_roles VALUES (20, 32, 4);
INSERT INTO bpm_forms_roles VALUES (25, 36, 8);


--
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 175
-- Name: bpm_forms_roles_bfr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('bpm_forms_roles_bfr_id_seq', 25, true);


--
-- TOC entry 2350 (class 0 OID 133702)
-- Dependencies: 176
-- Data for Name: bpm_forms_users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO bpm_forms_users VALUES (6, 12, 1);
INSERT INTO bpm_forms_users VALUES (7, 12, 7);
INSERT INTO bpm_forms_users VALUES (8, 13, 1);
INSERT INTO bpm_forms_users VALUES (9, 13, 7);
INSERT INTO bpm_forms_users VALUES (10, 14, 1);
INSERT INTO bpm_forms_users VALUES (11, 14, 7);
INSERT INTO bpm_forms_users VALUES (12, 15, 1);
INSERT INTO bpm_forms_users VALUES (13, 15, 7);
INSERT INTO bpm_forms_users VALUES (14, 16, 1);
INSERT INTO bpm_forms_users VALUES (15, 16, 7);
INSERT INTO bpm_forms_users VALUES (16, 17, 1);
INSERT INTO bpm_forms_users VALUES (17, 17, 7);
INSERT INTO bpm_forms_users VALUES (18, 18, 1);
INSERT INTO bpm_forms_users VALUES (19, 18, 7);
INSERT INTO bpm_forms_users VALUES (20, 19, 7);
INSERT INTO bpm_forms_users VALUES (27, 36, 7);


--
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 177
-- Name: bpm_forms_users_bfu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('bpm_forms_users_bfu_id_seq', 27, true);


--
-- TOC entry 2352 (class 0 OID 133707)
-- Dependencies: 178
-- Data for Name: bpm_links; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO bpm_links VALUES (675, 'active', 'graph-link-4', 'graph-shape-5', 'graph-shape-7', 'Graph.link.Orthogonal', 'orthogonal', 59, 869, 871, 'M513.0000000000001,151.21875000000077L513.0000000000001,216.21875000000045', '#000', 'Active', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Active","operator":""}]');
INSERT INTO bpm_links VALUES (668, 'todo', 'graph-link-4', 'graph-shape-1', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 57, 860, 861, 'M391.9999999999992,102.21874999999963L392.00000000000017,156.21875000000006', '#000', 'Todo', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Todo","operator":""}]');
INSERT INTO bpm_links VALUES (669, 'doing', 'graph-link-1', 'graph-shape-2', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 57, 861, 862, 'M392,216.21875000000074L392.00000000000006,300.2187499999994', '#000', 'Doing', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Doing","operator":""}]');
INSERT INTO bpm_links VALUES (670, 'done', 'graph-link-2', 'graph-shape-3', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 57, 862, 863, 'M392.0000000000061,360.2187500000007L392.0000000000034,452.21875000000045', '#000', 'Done', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Done","operator":""}]');
INSERT INTO bpm_links VALUES (671, NULL, 'graph-link-3', 'graph-shape-4', 'graph-shape-5', 'Graph.link.Orthogonal', 'orthogonal', 57, 863, 864, 'M391.99999999999864,512.2187500000002L391.99999999999864,582.2187499999982', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO bpm_links VALUES (681, NULL, 'graph-link-10', 'graph-shape-9', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 59, 873, 874, 'M513.0000000000022,397.21874999999943L512.9999999999982,489.2187500000006', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO bpm_links VALUES (672, 'todo', 'graph-link-1', 'graph-shape-1', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 58, 865, 866, 'M558.0000000000008,129.2187499999997L558.0000000000011,190.21874999999966', '#000', 'Todo', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Todo","operator":""}]');
INSERT INTO bpm_links VALUES (673, 'doing', 'graph-link-2', 'graph-shape-2', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 58, 866, 867, 'M558.0000000000007,250.21875000000108L557.9999999999991,305.2187500000004', '#000', 'Doing', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Doing","operator":""}]');
INSERT INTO bpm_links VALUES (674, NULL, 'graph-link-3', 'graph-shape-3', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 58, 867, 868, 'M558,365.2187500000003L558.0000000000016,421.2187499999992', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO bpm_links VALUES (676, 'backlog', 'graph-link-5', 'graph-shape-7', 'graph-shape-6', 'Graph.link.Orthogonal', 'orthogonal', 59, 871, 870, 'M443,246.21875L278.0000000000005,246.21875L277.9999999999998,337.21875000000045', '#000', 'Backlog', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Backlog","operator":""}]');
INSERT INTO bpm_links VALUES (677, NULL, 'graph-link-6', 'graph-shape-6', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 59, 870, 874, 'M278.0000000000003,397.21874999999966L278,519.21875L483.40429701180904,519.2187500000001', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO bpm_links VALUES (678, 'resolved', 'graph-link-7', 'graph-shape-7', 'graph-shape-8', 'Graph.link.Orthogonal', 'orthogonal', 59, 871, 872, 'M583.0000000000001,246.21874999999991L739,246.21875L739.0000000000005,337.2187500000009', '#000', 'Resolved', 0.516197307309469999, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Resolved","operator":""}]');
INSERT INTO bpm_links VALUES (679, 'others', 'graph-link-8', 'graph-shape-7', 'graph-shape-9', 'Graph.link.Orthogonal', 'orthogonal', 59, 871, 873, 'M512.999999999998,276.2187500000005L512.999999999998,337.2187499999995', '#000', 'Others', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Others","operator":""}]');
INSERT INTO bpm_links VALUES (680, NULL, 'graph-link-9', 'graph-shape-8', 'graph-shape-10', 'Graph.link.Orthogonal', 'orthogonal', 59, 872, 874, 'M739.000000000004,397.21874999999886L739,519.21875L542.5957029881874,519.2187500000016', '#000', '', 0.5, 1, 0, 6, NULL, '[]');
INSERT INTO bpm_links VALUES (683, 'todo', 'graph-link-5', 'graph-shape-4', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 57, 863, 861, 'M462,482.2187499999989L559.0000000000027,482.21875L559.0000000000027,186.21875L462,186.21874999999997', '#000', 'Todo', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Todo","operator":""}]');
INSERT INTO bpm_links VALUES (684, 'todo', 'graph-link-6', 'graph-shape-3', 'graph-shape-2', 'Graph.link.Orthogonal', 'orthogonal', 57, 862, 861, 'M344.00000000000006,300.21875000000006L344.0000000000002,216.21874999999957', '#000', 'Todo', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Todo","operator":""}]');
INSERT INTO bpm_links VALUES (685, 'done', 'graph-link-8', 'graph-shape-2', 'graph-shape-4', 'Graph.link.Orthogonal', 'orthogonal', 57, 861, 863, 'M322,186.21875000000023L230.99999999999687,186.21875L230.99999999999687,482.21875L322,482.2187499999999', '#000', 'Done', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Done","operator":""}]');
INSERT INTO bpm_links VALUES (682, 'doing', 'graph-link-7', 'graph-shape-4', 'graph-shape-3', 'Graph.link.Orthogonal', 'orthogonal', 57, 863, 862, 'M348.0000000000027,452.2187499999996L348.00000000000296,360.2187499999996', '#000', 'Doing', 0.5, 1, 0, 6, NULL, '[{"field":"tt_flag","comparison":"=","value":"Doing","operator":""}]');


--
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 179
-- Name: bpm_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('bpm_links_id_seq', 685, true);


--
-- TOC entry 2354 (class 0 OID 133718)
-- Dependencies: 180
-- Data for Name: bpm_shapes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO bpm_shapes VALUES (862, 'graph-shape-3', NULL, NULL, 'Graph.shape.activity.Action', NULL, 57, NULL, 140, 60, 322, 300.21875, 0, 'Doing Form', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (863, 'graph-shape-4', NULL, NULL, 'Graph.shape.activity.Action', NULL, 57, NULL, 140, 60, 322, 452.21875, 0, 'Done Form', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (864, 'graph-shape-5', NULL, NULL, 'Graph.shape.activity.Final', NULL, 57, NULL, 60, 60, 362, 582.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (865, 'graph-shape-1', NULL, NULL, 'Graph.shape.activity.Start', NULL, 58, NULL, 60, 60, 528, 69.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (866, 'graph-shape-2', NULL, NULL, 'Graph.shape.activity.Action', NULL, 58, NULL, 140, 60, 488, 190.21875, 0, 'Todo Form', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (867, 'graph-shape-3', NULL, NULL, 'Graph.shape.activity.Action', NULL, 58, NULL, 140, 60, 488, 305.21875, 0, 'Doing Form', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (868, 'graph-shape-4', NULL, NULL, 'Graph.shape.activity.Final', NULL, 58, NULL, 60, 60, 528, 421.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (869, 'graph-shape-5', NULL, NULL, 'Graph.shape.activity.Start', NULL, 59, NULL, 60, 60, 483, 91.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (870, 'graph-shape-6', NULL, NULL, 'Graph.shape.activity.Action', NULL, 59, NULL, 140, 60, 208, 337.21875, 0, 'Backlog Form', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (871, 'graph-shape-7', NULL, NULL, 'Graph.shape.activity.Action', NULL, 59, NULL, 140, 60, 443, 216.21875, 0, 'Active Form', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (872, 'graph-shape-8', NULL, NULL, 'Graph.shape.activity.Action', NULL, 59, NULL, 140, 60, 669, 337.21875, 0, 'Resolved Form', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (873, 'graph-shape-9', NULL, NULL, 'Graph.shape.activity.Action', NULL, 59, NULL, 140, 60, 443, 337.21875, 0, 'Others Form', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (874, 'graph-shape-10', NULL, NULL, 'Graph.shape.activity.Final', NULL, 59, NULL, 60, 60, 483, 489.21875, 0, 'End', '#FF4081', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (860, 'graph-shape-1', NULL, NULL, 'Graph.shape.activity.Start', NULL, 57, NULL, 60, 60, 362, 42.21875, 0, 'Start', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');
INSERT INTO bpm_shapes VALUES (861, 'graph-shape-2', NULL, NULL, 'Graph.shape.activity.Action', NULL, 57, NULL, 140, 60, 322, 156.21875, 0, 'Todo Form', 'rgb(255, 255, 255)', 'rgb(0, 0, 0)', 2, NULL, '[]');


--
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 181
-- Name: bpm_shapes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('bpm_shapes_id_seq', 874, true);


--
-- TOC entry 2356 (class 0 OID 133726)
-- Dependencies: 182
-- Data for Name: dx_auth; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 183
-- Name: dx_auth_auth_col_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dx_auth_auth_col_id_seq', 1, true);


--
-- TOC entry 2358 (class 0 OID 133731)
-- Dependencies: 184
-- Data for Name: dx_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dx_mapping VALUES (1, 1, 'example_1', 'data', 'EMAIL', 'email', 'string', 1, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO dx_mapping VALUES (3, 1, 'example_1', 'data', 'DEBUG', 'debug', 'string', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO dx_mapping VALUES (4, 1, 'example_1', 'data', 'SEX', 'sex', 'int', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO dx_mapping VALUES (5, 1, 'example_2', 'data', 'USERNAME', 'username', 'string', 1, 0, NULL, NULL, NULL, 0, 0, NULL, 1, 0, NULL, NULL);
INSERT INTO dx_mapping VALUES (6, 1, 'example_1', 'data', 'DOB', 'dob', 'date', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO dx_mapping VALUES (7, 1, 'example_1', 'data', 'AVATAR', 'avatar', 'string', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO dx_mapping VALUES (8, 1, 'example_1', 'data', 'POINTS', 'points', 'double', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO dx_mapping VALUES (9, 1, 'example_1', 'data', 'FULLNAME', 'fullname', 'string', 0, 0, NULL, NULL, NULL, 0, 1, NULL, 1, 0, NULL, NULL);
INSERT INTO dx_mapping VALUES (10, 4, 'A', 'data', '1', 'A', 'A', 1, 0, NULL, NULL, NULL, 0, 1, NULL, NULL, 1, NULL, NULL);


--
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 185
-- Name: dx_mapping_map_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dx_mapping_map_id_seq', 10, true);


--
-- TOC entry 2360 (class 0 OID 133745)
-- Dependencies: 186
-- Data for Name: dx_profiles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO dx_profiles VALUES (1, 'Example Profile', 'Example profile', 1, 'B', 2, 1, NULL);
INSERT INTO dx_profiles VALUES (4, 'foo', NULL, 1, 'A', 2, 1, NULL);
INSERT INTO dx_profiles VALUES (5, 'bar', NULL, 1, 'A', 1, 1, NULL);


--
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 187
-- Name: dx_profiles_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dx_profiles_profile_id_seq', 5, true);


--
-- TOC entry 2362 (class 0 OID 133763)
-- Dependencies: 188
-- Data for Name: kanban; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO kanban VALUES (1, 'pink', 'isCardFilterTodo', 'To Do');
INSERT INTO kanban VALUES (2, 'blue', 'isCardFilterDoing', 'Doing');
INSERT INTO kanban VALUES (3, 'green', 'isCardFilterDone', 'Done');


--
-- TOC entry 2363 (class 0 OID 133766)
-- Dependencies: 189
-- Data for Name: kanban_forms; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO kanban_forms VALUES (1, 49, 396, '', '');
INSERT INTO kanban_forms VALUES (2, 49, 397, '', '');
INSERT INTO kanban_forms VALUES (3, 49, 397, 'Capture.JPG', '');
INSERT INTO kanban_forms VALUES (4, 28, 96, '', '');
INSERT INTO kanban_forms VALUES (5, 28, 97, '', '');
INSERT INTO kanban_forms VALUES (6, 28, 98, '', '');
INSERT INTO kanban_forms VALUES (7, 28, 99, '', '');
INSERT INTO kanban_forms VALUES (8, 28, 105, '', '');


--
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 190
-- Name: kanban_forms_kf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('kanban_forms_kf_id_seq', 8, true);


--
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 191
-- Name: kanban_panel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('kanban_panel_id_seq', 3, true);


--
-- TOC entry 2366 (class 0 OID 133776)
-- Dependencies: 192
-- Data for Name: kanban_panels; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO kanban_panels VALUES (69, 21, 'Todo', '#8F7EE6', 0);
INSERT INTO kanban_panels VALUES (70, 21, 'Doing', '#00AAFF', 1);
INSERT INTO kanban_panels VALUES (66, 20, 'Backlog', '#9c27b0', 0);
INSERT INTO kanban_panels VALUES (67, 20, 'Active', '#2196f3', 1);
INSERT INTO kanban_panels VALUES (68, 20, 'Resolved', '#ffc107', 2);
INSERT INTO kanban_panels VALUES (71, 20, 'Others', '#e91e63', 3);
INSERT INTO kanban_panels VALUES (61, 19, 'Todo', '#9c27b0', 0);
INSERT INTO kanban_panels VALUES (62, 19, 'Doing', '#2196f3', 1);
INSERT INTO kanban_panels VALUES (63, 19, 'Done', '#4caf50', 2);


--
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 193
-- Name: kanban_panels_kp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('kanban_panels_kp_id_seq', 72, true);


--
-- TOC entry 2368 (class 0 OID 133782)
-- Dependencies: 194
-- Data for Name: kanban_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO kanban_settings VALUES (21, 'Simple', 'Only todo and doing', NULL, 'simple.png');
INSERT INTO kanban_settings VALUES (20, 'Backlog', 'Backlog, active and resolved workflow', NULL, 'backlog.png');
INSERT INTO kanban_settings VALUES (19, 'Classic', 'Todo, doing and done workflow', NULL, 'classic.png');


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 195
-- Name: kanban_settings_ks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('kanban_settings_ks_id_seq', 21, true);


--
-- TOC entry 2370 (class 0 OID 133790)
-- Dependencies: 196
-- Data for Name: kanban_statuses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO kanban_statuses VALUES (74, 69, 58, 672, '#000');
INSERT INTO kanban_statuses VALUES (75, 70, 58, 673, '#000');
INSERT INTO kanban_statuses VALUES (76, 66, 59, 676, '#000');
INSERT INTO kanban_statuses VALUES (77, 67, 59, 675, '#000');
INSERT INTO kanban_statuses VALUES (78, 68, 59, 678, '#000');
INSERT INTO kanban_statuses VALUES (79, 71, 59, 679, '#000');
INSERT INTO kanban_statuses VALUES (66, 61, 57, 668, '#000');
INSERT INTO kanban_statuses VALUES (81, 61, 57, 683, '#000');
INSERT INTO kanban_statuses VALUES (82, 61, 57, 684, '#000');
INSERT INTO kanban_statuses VALUES (67, 62, 57, 669, '#000');
INSERT INTO kanban_statuses VALUES (80, 62, 57, 682, '#000');
INSERT INTO kanban_statuses VALUES (68, 63, 57, 670, '#000');
INSERT INTO kanban_statuses VALUES (83, 63, 57, 685, '#000');


--
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 197
-- Name: kanban_statuses_kst_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('kanban_statuses_kst_id_seq', 83, true);


--
-- TOC entry 2372 (class 0 OID 133800)
-- Dependencies: 198
-- Data for Name: sys_captcha; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2373 (class 0 OID 133806)
-- Dependencies: 199
-- Data for Name: sys_config; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_config VALUES (1, 'app_id', '21000182918');
INSERT INTO sys_config VALUES (3, 'app_title', 'WSTEAM');
INSERT INTO sys_config VALUES (4, 'app_version', '2.0.5');
INSERT INTO sys_config VALUES (5, 'app_description', 'Teamwork application based on worksaurus platform');
INSERT INTO sys_config VALUES (6, 'app_keywords', 'team, task, worksaurus, polymer, progressive web');
INSERT INTO sys_config VALUES (7, 'app_author', 'Kreasindo Cipta Teknologi');
INSERT INTO sys_config VALUES (8, 'app_repository', '');
INSERT INTO sys_config VALUES (9, 'app_token', '66c3ff424414b74560788b53434baf309a7b510c5a4ec33f65932671af73f2a5');
INSERT INTO sys_config VALUES (10, 'app_package', 'FREE');
INSERT INTO sys_config VALUES (11, 'app_limit', '5');
INSERT INTO sys_config VALUES (12, 'app_package_approval', '1');
INSERT INTO sys_config VALUES (13, 'app_pricing', '70000');
INSERT INTO sys_config VALUES (14, 'app_package_desc', 'Free account for your daily needs');
INSERT INTO sys_config VALUES (15, 'notif_global', 'You are on Free Package. <a  href="billing"><b>Upgrade PRO Package </b></a> to unlock more features');


--
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 200
-- Name: sys_config_sc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_config_sc_id_seq', 15, true);


--
-- TOC entry 2375 (class 0 OID 133814)
-- Dependencies: 201
-- Data for Name: sys_labels; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_labels VALUES ('issue', 7, '2017-12-27 18:56:25', '#e91e63', 10, NULL);
INSERT INTO sys_labels VALUES ('bugs', 7, '2017-12-27 18:56:31', '#f44336', 11, NULL);
INSERT INTO sys_labels VALUES ('others', 7, '2017-12-21 17:50:35', '#607d8b', 9, NULL);
INSERT INTO sys_labels VALUES ('opened', 7, '2017-12-27 18:56:36', '#ffc107', 12, NULL);
INSERT INTO sys_labels VALUES ('feature', 11, '2018-01-11 18:37:10', '#9c27b0', 14, NULL);
INSERT INTO sys_labels VALUES ('pending', 11, '2018-01-11 18:37:25', '#e91e63', 15, NULL);
INSERT INTO sys_labels VALUES ('closed', 11, '2018-01-18 22:50:27', 'var(--paper-teal-500)', 24, NULL);
INSERT INTO sys_labels VALUES ('priority', 17, '2018-01-19 08:34:44', '#f44336', 25, NULL);


--
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 202
-- Name: sys_labels_sl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_labels_sl_id_seq', 36, true);


--
-- TOC entry 2377 (class 0 OID 133820)
-- Dependencies: 203
-- Data for Name: sys_menus; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_menus VALUES (1, 0, 'Homepage', 'social:public', '/home', 1, 1, 0);
INSERT INTO sys_menus VALUES (3, 0, 'Dashboard', 'dashboard', '/dashboard', 2, 1, 0);
INSERT INTO sys_menus VALUES (7, 0, 'Settings', 'device:usb', '/settings', 7, 1, 0);
INSERT INTO sys_menus VALUES (20, 0, 'Labels', 'label-outline', '/references/labels', 5, 1, 0);
INSERT INTO sys_menus VALUES (19, 0, 'Worksheet', 'view-carousel', '/worksheet', 5, 1, 1);


--
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 204
-- Name: sys_menus_smn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_menus_smn_id_seq', 22, true);


--
-- TOC entry 2379 (class 0 OID 133829)
-- Dependencies: 205
-- Data for Name: sys_modules; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_modules VALUES (1, 'assets', '1.0.0', 'Assets', 'KCT Team', 'https://github.com/progmodules/assets', '/assets');
INSERT INTO sys_modules VALUES (3, 'application', '1.0.0', 'Application', 'KCT Team', NULL, '/');
INSERT INTO sys_modules VALUES (5, 'home', '1.0.0', 'Homepage', 'KCT Team', NULL, '/home');
INSERT INTO sys_modules VALUES (7, 'roles', '1.0.0', 'Roles', 'KCT Team', NULL, '/roles');
INSERT INTO sys_modules VALUES (8, 'users', '1.0.0', 'Users', 'KCT Team', NULL, '/users');
INSERT INTO sys_modules VALUES (9, 'modules', '1.0.0', 'Modules', 'KCT Team', NULL, '/modules');
INSERT INTO sys_modules VALUES (13, 'dashboard', '1.0.0', 'Dashboard', 'KCT Team', NULL, '/dashboard');
INSERT INTO sys_modules VALUES (17, 'settings', '1.0.0', 'Settings', 'KCT Team', NULL, '/settings');
INSERT INTO sys_modules VALUES (18, 'worksheet', '1.0.0', 'Worksheet', 'KCT Team', NULL, '/worksheet');
INSERT INTO sys_modules VALUES (19, 'labels', '1.0.0', 'Labels', 'KCT Team', NULL, '/references/labels');
INSERT INTO sys_modules VALUES (2, 'auth', '1.0.0', 'Authentication', 'KCT Team', 'https://github.com/progmodules/auth', '/auth');


--
-- TOC entry 2380 (class 0 OID 133836)
-- Dependencies: 206
-- Data for Name: sys_modules_capabilities; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_modules_capabilities VALUES (3, 1, 'download_resource', 'Allow user to download resources (image, file etc.)');
INSERT INTO sys_modules_capabilities VALUES (12, 3, 'manage_app', 'Allow user to manage whole application');
INSERT INTO sys_modules_capabilities VALUES (17, 1, 'download_thumbnail', 'Allow user to download image thumbnail');
INSERT INTO sys_modules_capabilities VALUES (22, 5, 'update_notes', 'Allow user to update welcome notes');
INSERT INTO sys_modules_capabilities VALUES (23, 5, 'update_cover', 'Allow user to update background image');
INSERT INTO sys_modules_capabilities VALUES (24, 3, 'send_email', 'Allow user to send mail');
INSERT INTO sys_modules_capabilities VALUES (16, 2, 'login', 'Allow user to perform login action');
INSERT INTO sys_modules_capabilities VALUES (31, 2, 'login_browser', 'Allow user to login via web browser');
INSERT INTO sys_modules_capabilities VALUES (32, 2, 'login_mobile', 'Allow user to login via mobile device');


--
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 207
-- Name: sys_modules_capabilities_smc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_modules_capabilities_smc_id_seq', 32, true);


--
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 208
-- Name: sys_modules_sm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_modules_sm_id_seq', 19, true);


--
-- TOC entry 2383 (class 0 OID 133843)
-- Dependencies: 209
-- Data for Name: sys_numbers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_numbers VALUES (1, 'SALES_TICKET', 36, 5, 'SP', NULL);


--
-- TOC entry 2492 (class 0 OID 0)
-- Dependencies: 210
-- Name: sys_numbers_sn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_numbers_sn_id_seq', 1, true);


--
-- TOC entry 2385 (class 0 OID 133848)
-- Dependencies: 211
-- Data for Name: sys_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_permissions VALUES (1, 1, 1);


--
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 212
-- Name: sys_permissions_sp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_permissions_sp_id_seq', 1, true);


--
-- TOC entry 2387 (class 0 OID 133853)
-- Dependencies: 213
-- Data for Name: sys_projects; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2388 (class 0 OID 133859)
-- Dependencies: 214
-- Data for Name: sys_projects_labels; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2494 (class 0 OID 0)
-- Dependencies: 215
-- Name: sys_projects_labels_spl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_projects_labels_spl_id_seq', 1, false);


--
-- TOC entry 2495 (class 0 OID 0)
-- Dependencies: 216
-- Name: sys_projects_sp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_projects_sp_id_seq', 40, true);


--
-- TOC entry 2391 (class 0 OID 133866)
-- Dependencies: 217
-- Data for Name: sys_projects_users; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2496 (class 0 OID 0)
-- Dependencies: 218
-- Name: sys_projects_users_spu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_projects_users_spu_id_seq', 101, true);


--
-- TOC entry 2393 (class 0 OID 133871)
-- Dependencies: 219
-- Data for Name: sys_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_roles VALUES (7, 'Director', 'director', NULL, 0, '2017-09-18 09:00:50+00', 'system');
INSERT INTO sys_roles VALUES (8, 'Manager', 'manager', NULL, 0, '2017-09-18 09:00:58+00', 'system');
INSERT INTO sys_roles VALUES (9, 'Senior Programmer', 'senior-programmer', NULL, 0, '2017-09-18 09:01:09+00', 'system');
INSERT INTO sys_roles VALUES (16, 'Programmer', 'programmer', NULL, 0, '2018-01-09 02:42:23.95008+00', 'system');
INSERT INTO sys_roles VALUES (4, 'Administrator', 'administrator', 'Role for administrator user', 0, '2017-05-24 18:48:45+00', 'system');


--
-- TOC entry 2394 (class 0 OID 133880)
-- Dependencies: 220
-- Data for Name: sys_roles_kanban; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_roles_kanban VALUES (10, 4, 19, 1);


--
-- TOC entry 2497 (class 0 OID 0)
-- Dependencies: 221
-- Name: sys_roles_kanban_srk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_roles_kanban_srk_id_seq', 10, true);


--
-- TOC entry 2396 (class 0 OID 133886)
-- Dependencies: 222
-- Data for Name: sys_roles_menus; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_roles_menus VALUES (3, 4, 14, 0);
INSERT INTO sys_roles_menus VALUES (1, 4, 1, 1);
INSERT INTO sys_roles_menus VALUES (4, 4, 3, 1);
INSERT INTO sys_roles_menus VALUES (8, 4, 7, 1);
INSERT INTO sys_roles_menus VALUES (9, 4, 19, 1);
INSERT INTO sys_roles_menus VALUES (10, 4, 20, 1);
INSERT INTO sys_roles_menus VALUES (11, 7, 1, 1);
INSERT INTO sys_roles_menus VALUES (12, 7, 3, 1);
INSERT INTO sys_roles_menus VALUES (13, 7, 7, 1);
INSERT INTO sys_roles_menus VALUES (14, 7, 19, 1);
INSERT INTO sys_roles_menus VALUES (15, 7, 20, 1);
INSERT INTO sys_roles_menus VALUES (16, 8, 1, 1);
INSERT INTO sys_roles_menus VALUES (17, 8, 3, 1);
INSERT INTO sys_roles_menus VALUES (18, 8, 7, 1);
INSERT INTO sys_roles_menus VALUES (19, 8, 19, 1);
INSERT INTO sys_roles_menus VALUES (20, 8, 20, 1);
INSERT INTO sys_roles_menus VALUES (21, 9, 1, 1);
INSERT INTO sys_roles_menus VALUES (22, 9, 3, 1);
INSERT INTO sys_roles_menus VALUES (23, 9, 7, 1);
INSERT INTO sys_roles_menus VALUES (24, 9, 19, 1);
INSERT INTO sys_roles_menus VALUES (25, 9, 20, 1);
INSERT INTO sys_roles_menus VALUES (26, 16, 1, 1);
INSERT INTO sys_roles_menus VALUES (27, 16, 3, 1);
INSERT INTO sys_roles_menus VALUES (28, 16, 7, 1);
INSERT INTO sys_roles_menus VALUES (29, 16, 19, 1);
INSERT INTO sys_roles_menus VALUES (30, 16, 20, 1);


--
-- TOC entry 2498 (class 0 OID 0)
-- Dependencies: 223
-- Name: sys_roles_menus_srm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_roles_menus_srm_id_seq', 30, true);


--
-- TOC entry 2398 (class 0 OID 133892)
-- Dependencies: 224
-- Data for Name: sys_roles_panels; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2499 (class 0 OID 0)
-- Dependencies: 225
-- Name: sys_roles_panels_srs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_roles_panels_srs_id_seq', 1, false);


--
-- TOC entry 2400 (class 0 OID 133898)
-- Dependencies: 226
-- Data for Name: sys_roles_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_roles_permissions VALUES (12, 4, 24, 0);
INSERT INTO sys_roles_permissions VALUES (13, 4, 12, 0);
INSERT INTO sys_roles_permissions VALUES (14, 4, 3, 0);
INSERT INTO sys_roles_permissions VALUES (15, 4, 18, 0);
INSERT INTO sys_roles_permissions VALUES (16, 4, 19, 0);
INSERT INTO sys_roles_permissions VALUES (17, 4, 22, 0);
INSERT INTO sys_roles_permissions VALUES (20, 4, 25, 0);
INSERT INTO sys_roles_permissions VALUES (21, 4, 17, 0);
INSERT INTO sys_roles_permissions VALUES (22, 4, 16, 0);
INSERT INTO sys_roles_permissions VALUES (23, 4, 21, 0);
INSERT INTO sys_roles_permissions VALUES (24, 4, 26, 0);
INSERT INTO sys_roles_permissions VALUES (26, 4, 28, 0);
INSERT INTO sys_roles_permissions VALUES (27, 4, 29, 0);
INSERT INTO sys_roles_permissions VALUES (28, 4, 30, 0);
INSERT INTO sys_roles_permissions VALUES (19, 4, 20, 0);
INSERT INTO sys_roles_permissions VALUES (25, 4, 27, 0);
INSERT INTO sys_roles_permissions VALUES (18, 4, 23, 1);
INSERT INTO sys_roles_permissions VALUES (49, 4, 31, 1);
INSERT INTO sys_roles_permissions VALUES (50, 4, 32, 1);
INSERT INTO sys_roles_permissions VALUES (29, 7, 3, 1);
INSERT INTO sys_roles_permissions VALUES (30, 7, 17, 1);
INSERT INTO sys_roles_permissions VALUES (32, 7, 12, 1);
INSERT INTO sys_roles_permissions VALUES (33, 7, 24, 1);
INSERT INTO sys_roles_permissions VALUES (34, 7, 22, 1);
INSERT INTO sys_roles_permissions VALUES (35, 7, 23, 1);
INSERT INTO sys_roles_permissions VALUES (31, 7, 16, 1);
INSERT INTO sys_roles_permissions VALUES (51, 7, 31, 1);
INSERT INTO sys_roles_permissions VALUES (52, 7, 32, 1);
INSERT INTO sys_roles_permissions VALUES (36, 8, 3, 1);
INSERT INTO sys_roles_permissions VALUES (37, 8, 17, 1);
INSERT INTO sys_roles_permissions VALUES (39, 8, 12, 1);
INSERT INTO sys_roles_permissions VALUES (40, 8, 24, 1);
INSERT INTO sys_roles_permissions VALUES (38, 8, 16, 1);
INSERT INTO sys_roles_permissions VALUES (53, 8, 31, 1);
INSERT INTO sys_roles_permissions VALUES (54, 8, 32, 1);
INSERT INTO sys_roles_permissions VALUES (41, 9, 3, 1);
INSERT INTO sys_roles_permissions VALUES (42, 9, 17, 1);
INSERT INTO sys_roles_permissions VALUES (44, 9, 12, 1);
INSERT INTO sys_roles_permissions VALUES (45, 9, 24, 1);
INSERT INTO sys_roles_permissions VALUES (43, 9, 16, 1);
INSERT INTO sys_roles_permissions VALUES (55, 9, 31, 1);
INSERT INTO sys_roles_permissions VALUES (56, 9, 32, 1);
INSERT INTO sys_roles_permissions VALUES (46, 16, 3, 1);
INSERT INTO sys_roles_permissions VALUES (47, 16, 17, 1);
INSERT INTO sys_roles_permissions VALUES (48, 16, 16, 1);
INSERT INTO sys_roles_permissions VALUES (57, 16, 31, 1);
INSERT INTO sys_roles_permissions VALUES (58, 16, 32, 1);


--
-- TOC entry 2500 (class 0 OID 0)
-- Dependencies: 227
-- Name: sys_roles_permissions_srp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_roles_permissions_srp_id_seq', 58, true);


--
-- TOC entry 2501 (class 0 OID 0)
-- Dependencies: 228
-- Name: sys_roles_sr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_roles_sr_id_seq', 16, true);


--
-- TOC entry 2403 (class 0 OID 133906)
-- Dependencies: 229
-- Data for Name: sys_users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sys_users VALUES (18, 4, 'said@kct.co.id', '$2y$08$VEpxVW9MV1BpUjJJRWk4NO0WrJY68fCJ1bcuenWrP8wfRkf4A5egG', 'Said', 'worksaurus_head.png', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTc4ODEyMDYsImp0aSI6IjFSRDduUTU5eFwvS0FxazJzcVFBbUMrZWdDS0JhQlAyNHp6OFNQYXdqXC9JOD0iLCJpc3MiOiJLcmVhc2luZG8gQ2lwdGEgVGVrbm9sb2dpIiwibmJmIjoxNTE3ODgxMjA3LCJleHAiOjE1MTc5NjUyMDcsImRhdGEiOnsic3VfZW1haWwiOiJzYWlkQGtjdC5jby5pZCIsInN1X3NyX2lkIjo0fX0.in88yp45aT3KuTIUNbgvuC5h9xecrl9Vcrk9IRAwSX6V47rvcvE-TAAVIgXHnSISoi5ec4Fv3BBYKLkoC3biXg', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTc4ODEyMDYsImp0aSI6ImNwN21kWlwvc2dFMytodHhnd2RUaU9UbWEzUG1yRnhzRkpBYWlTSXdFblA0PSIsImlzcyI6IktyZWFzaW5kbyBDaXB0YSBUZWtub2xvZ2kiLCJuYmYiOjE1MTc4ODEyMDcsImV4cCI6MTUxNzk4OTIwNywiZGF0YSI6bnVsbH0.w0FxwOJg8k4nymMTes7AuZXkE7UE7Uqzdw-Llz5GT-uhMMYpL-KzV5vhk6VkGty2BfLctekiu2MC7pf5gdVJjQ', NULL, NULL, NULL, NULL, 1, '2018-01-10 16:53:01+00', 'system', NULL, NULL);


--
-- TOC entry 2404 (class 0 OID 133915)
-- Dependencies: 230
-- Data for Name: sys_users_kanban; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2502 (class 0 OID 0)
-- Dependencies: 231
-- Name: sys_users_kanban_suk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_users_kanban_suk_id_seq', 27, true);


--
-- TOC entry 2406 (class 0 OID 133921)
-- Dependencies: 232
-- Data for Name: sys_users_menus; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2503 (class 0 OID 0)
-- Dependencies: 233
-- Name: sys_users_menus_sum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_users_menus_sum_id_seq', 1, true);


--
-- TOC entry 2408 (class 0 OID 133927)
-- Dependencies: 234
-- Data for Name: sys_users_panels; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2504 (class 0 OID 0)
-- Dependencies: 235
-- Name: sys_users_panels_sus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_users_panels_sus_id_seq', 1, false);


--
-- TOC entry 2410 (class 0 OID 133933)
-- Dependencies: 236
-- Data for Name: sys_users_permissions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2505 (class 0 OID 0)
-- Dependencies: 237
-- Name: sys_users_permissions_sup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_users_permissions_sup_id_seq', 1, true);


--
-- TOC entry 2506 (class 0 OID 0)
-- Dependencies: 238
-- Name: sys_users_su_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sys_users_su_id_seq', 21, true);


--
-- TOC entry 2413 (class 0 OID 133998)
-- Dependencies: 239
-- Data for Name: trx_tasks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2414 (class 0 OID 134004)
-- Dependencies: 240
-- Data for Name: trx_tasks_activities; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2507 (class 0 OID 0)
-- Dependencies: 241
-- Name: trx_tasks_activities_tta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('trx_tasks_activities_tta_id_seq', 708, true);


--
-- TOC entry 2416 (class 0 OID 134012)
-- Dependencies: 242
-- Data for Name: trx_tasks_comments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2508 (class 0 OID 0)
-- Dependencies: 243
-- Name: trx_tasks_comments_ttc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('trx_tasks_comments_ttc_id_seq', 1, false);


--
-- TOC entry 2418 (class 0 OID 134020)
-- Dependencies: 244
-- Data for Name: trx_tasks_labels; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2509 (class 0 OID 0)
-- Dependencies: 245
-- Name: trx_tasks_labels_ttl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('trx_tasks_labels_ttl_id_seq', 154, true);


--
-- TOC entry 2420 (class 0 OID 134025)
-- Dependencies: 246
-- Data for Name: trx_tasks_statuses; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2510 (class 0 OID 0)
-- Dependencies: 247
-- Name: trx_tasks_statuses_tts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('trx_tasks_statuses_tts_id_seq', 387, true);


--
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 248
-- Name: trx_tasks_tt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('trx_tasks_tt_id_seq', 205, true);


--
-- TOC entry 2423 (class 0 OID 134032)
-- Dependencies: 249
-- Data for Name: trx_tasks_users; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 250
-- Name: trx_tasks_users_ttu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('trx_tasks_users_ttu_id_seq', 222, true);


--
-- TOC entry 2153 (class 2606 OID 134093)
-- Name: idx_35836_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bpm_diagrams
    ADD CONSTRAINT idx_35836_primary PRIMARY KEY (id);


--
-- TOC entry 2155 (class 2606 OID 134095)
-- Name: idx_35846_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bpm_forms
    ADD CONSTRAINT idx_35846_primary PRIMARY KEY (bf_id);


--
-- TOC entry 2157 (class 2606 OID 134097)
-- Name: idx_35855_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bpm_forms_roles
    ADD CONSTRAINT idx_35855_primary PRIMARY KEY (bfr_id);


--
-- TOC entry 2159 (class 2606 OID 134099)
-- Name: idx_35861_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bpm_forms_users
    ADD CONSTRAINT idx_35861_primary PRIMARY KEY (bfu_id);


--
-- TOC entry 2161 (class 2606 OID 134101)
-- Name: idx_35867_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bpm_links
    ADD CONSTRAINT idx_35867_primary PRIMARY KEY (id);


--
-- TOC entry 2163 (class 2606 OID 134103)
-- Name: idx_35879_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bpm_shapes
    ADD CONSTRAINT idx_35879_primary PRIMARY KEY (id);


--
-- TOC entry 2165 (class 2606 OID 134105)
-- Name: idx_35888_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dx_auth
    ADD CONSTRAINT idx_35888_primary PRIMARY KEY (auth_col_id);


--
-- TOC entry 2167 (class 2606 OID 134107)
-- Name: idx_35894_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dx_mapping
    ADD CONSTRAINT idx_35894_primary PRIMARY KEY (map_id);


--
-- TOC entry 2169 (class 2606 OID 134109)
-- Name: idx_35909_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dx_profiles
    ADD CONSTRAINT idx_35909_primary PRIMARY KEY (profile_id);


--
-- TOC entry 2171 (class 2606 OID 134115)
-- Name: idx_35930_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kanban
    ADD CONSTRAINT idx_35930_primary PRIMARY KEY (panel_id);


--
-- TOC entry 2173 (class 2606 OID 134117)
-- Name: idx_35936_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kanban_forms
    ADD CONSTRAINT idx_35936_primary PRIMARY KEY (kf_id);


--
-- TOC entry 2175 (class 2606 OID 134119)
-- Name: idx_35945_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kanban_panels
    ADD CONSTRAINT idx_35945_primary PRIMARY KEY (kp_id);


--
-- TOC entry 2177 (class 2606 OID 134121)
-- Name: idx_35952_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kanban_settings
    ADD CONSTRAINT idx_35952_primary PRIMARY KEY (ks_id);


--
-- TOC entry 2179 (class 2606 OID 134123)
-- Name: idx_35958_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kanban_statuses
    ADD CONSTRAINT idx_35958_primary PRIMARY KEY (kst_id);


--
-- TOC entry 2182 (class 2606 OID 134127)
-- Name: idx_35968_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_captcha
    ADD CONSTRAINT idx_35968_primary PRIMARY KEY (id, namespace);


--
-- TOC entry 2184 (class 2606 OID 134129)
-- Name: idx_35976_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_config
    ADD CONSTRAINT idx_35976_primary PRIMARY KEY (sc_id);


--
-- TOC entry 2188 (class 2606 OID 134131)
-- Name: idx_35985_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_menus
    ADD CONSTRAINT idx_35985_primary PRIMARY KEY (smn_id);


--
-- TOC entry 2190 (class 2606 OID 134133)
-- Name: idx_35994_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_modules
    ADD CONSTRAINT idx_35994_primary PRIMARY KEY (sm_id);


--
-- TOC entry 2192 (class 2606 OID 134135)
-- Name: idx_36004_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_modules_capabilities
    ADD CONSTRAINT idx_36004_primary PRIMARY KEY (smc_id);


--
-- TOC entry 2194 (class 2606 OID 134137)
-- Name: idx_36010_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_numbers
    ADD CONSTRAINT idx_36010_primary PRIMARY KEY (sn_id);


--
-- TOC entry 2196 (class 2606 OID 134139)
-- Name: idx_36016_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_permissions
    ADD CONSTRAINT idx_36016_primary PRIMARY KEY (sp_id);


--
-- TOC entry 2204 (class 2606 OID 134141)
-- Name: idx_36022_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_roles
    ADD CONSTRAINT idx_36022_primary PRIMARY KEY (sr_id);


--
-- TOC entry 2206 (class 2606 OID 134143)
-- Name: idx_36034_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_roles_kanban
    ADD CONSTRAINT idx_36034_primary PRIMARY KEY (srk_id);


--
-- TOC entry 2208 (class 2606 OID 134145)
-- Name: idx_36041_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_roles_menus
    ADD CONSTRAINT idx_36041_primary PRIMARY KEY (srm_id);


--
-- TOC entry 2212 (class 2606 OID 134147)
-- Name: idx_36048_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_roles_permissions
    ADD CONSTRAINT idx_36048_primary PRIMARY KEY (srp_id);


--
-- TOC entry 2214 (class 2606 OID 134149)
-- Name: idx_36055_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_users
    ADD CONSTRAINT idx_36055_primary PRIMARY KEY (su_id);


--
-- TOC entry 2216 (class 2606 OID 134151)
-- Name: idx_36067_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_users_kanban
    ADD CONSTRAINT idx_36067_primary PRIMARY KEY (suk_id);


--
-- TOC entry 2218 (class 2606 OID 134153)
-- Name: idx_36074_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_users_menus
    ADD CONSTRAINT idx_36074_primary PRIMARY KEY (sum_id);


--
-- TOC entry 2222 (class 2606 OID 134155)
-- Name: idx_36081_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_users_permissions
    ADD CONSTRAINT idx_36081_primary PRIMARY KEY (sup_id);


--
-- TOC entry 2224 (class 2606 OID 134173)
-- Name: idx_36153_primary; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trx_tasks
    ADD CONSTRAINT idx_36153_primary PRIMARY KEY (tt_id);


--
-- TOC entry 2186 (class 2606 OID 134175)
-- Name: sys_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_labels
    ADD CONSTRAINT sys_labels_pkey PRIMARY KEY (sl_id);


--
-- TOC entry 2200 (class 2606 OID 134177)
-- Name: sys_projects_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_projects_labels
    ADD CONSTRAINT sys_projects_labels_pkey PRIMARY KEY (spl_id);


--
-- TOC entry 2198 (class 2606 OID 134179)
-- Name: sys_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_projects
    ADD CONSTRAINT sys_projects_pkey PRIMARY KEY (sp_id);


--
-- TOC entry 2202 (class 2606 OID 134181)
-- Name: sys_projects_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_projects_users
    ADD CONSTRAINT sys_projects_users_pkey PRIMARY KEY (spu_id);


--
-- TOC entry 2210 (class 2606 OID 134183)
-- Name: sys_roles_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_roles_panels
    ADD CONSTRAINT sys_roles_panels_pkey PRIMARY KEY (srs_id);


--
-- TOC entry 2220 (class 2606 OID 134185)
-- Name: sys_users_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_users_panels
    ADD CONSTRAINT sys_users_panels_pkey PRIMARY KEY (sus_id);


--
-- TOC entry 2227 (class 2606 OID 134187)
-- Name: trx_tasks_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trx_tasks_activities
    ADD CONSTRAINT trx_tasks_activities_pkey PRIMARY KEY (tta_id);


--
-- TOC entry 2229 (class 2606 OID 134189)
-- Name: trx_tasks_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trx_tasks_comments
    ADD CONSTRAINT trx_tasks_comments_pkey PRIMARY KEY (ttc_id);


--
-- TOC entry 2231 (class 2606 OID 134191)
-- Name: trx_tasks_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trx_tasks_labels
    ADD CONSTRAINT trx_tasks_labels_pkey PRIMARY KEY (ttl_id);


--
-- TOC entry 2233 (class 2606 OID 134193)
-- Name: trx_tasks_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trx_tasks_statuses
    ADD CONSTRAINT trx_tasks_statuses_pkey PRIMARY KEY (tts_id);


--
-- TOC entry 2236 (class 2606 OID 134195)
-- Name: trx_tasks_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trx_tasks_users
    ADD CONSTRAINT trx_tasks_users_pkey PRIMARY KEY (ttu_id);


--
-- TOC entry 2180 (class 1259 OID 134196)
-- Name: idx_35968_created; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_35968_created ON sys_captcha USING btree (created);


--
-- TOC entry 2234 (class 1259 OID 134197)
-- Name: trx_tasks_statuses_tts_status_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX trx_tasks_statuses_tts_status_idx ON trx_tasks_statuses USING btree (tts_status);


--
-- TOC entry 2225 (class 1259 OID 134198)
-- Name: trx_tasks_tt_sp_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX trx_tasks_tt_sp_id_idx ON trx_tasks USING btree (tt_sp_id);


--
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-02-06 18:59:24

--
-- PostgreSQL database dump complete
--

