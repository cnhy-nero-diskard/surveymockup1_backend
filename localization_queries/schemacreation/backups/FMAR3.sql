PGDMP                         }            survey    15.4    15.4 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16436    survey    DATABASE     �   CREATE DATABASE survey WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE survey;
                postgres    false            �           1247    16696    attraction_category    TYPE     �   CREATE TYPE public.attraction_category AS ENUM (
    'Dive site',
    'Church',
    'Structures and Buildings',
    'Festivals',
    'Museum',
    'Beach',
    'Industrial Facilities',
    'Farm',
    'Golf',
    'Sport Complex'
);
 &   DROP TYPE public.attraction_category;
       public          postgres    false            �           1247    16686    attraction_status    TYPE     z   CREATE TYPE public.attraction_status AS ENUM (
    'EXISTING',
    'UNDER_CONSTRUCTION',
    'CLOSED',
    'RENOVATED'
);
 $   DROP TYPE public.attraction_status;
       public          postgres    false            ~           1247    16674    attraction_type    TYPE     �   CREATE TYPE public.attraction_type AS ENUM (
    'Nature',
    'History and Culture',
    'Sports and Recreational Facilities',
    'Customs and Traditions',
    'Industrial Tourism'
);
 "   DROP TYPE public.attraction_type;
       public          postgres    false            �           1247    17240    component_category    TYPE     s   CREATE TYPE public.component_category AS ENUM (
    'whereStayArrival',
    'WHERESTAYARRIVAL',
    'SERVICES1'
);
 %   DROP TYPE public.component_category;
       public          postgres    false            �           1247    17296    qtype    TYPE     �   CREATE TYPE public.qtype AS ENUM (
    'OPENENDED',
    'RATINGSCALE',
    'BINARYRESPONSE',
    'CHECKBOXES',
    'NUMERICAL',
    'MULTIPLECHOICE',
    'STANDARDTEXT'
);
    DROP TYPE public.qtype;
       public          postgres    false            �           1247    17020    sentiment_label    TYPE     ^   CREATE TYPE public.sentiment_label AS ENUM (
    'Positive',
    'Negative',
    'Neutral'
);
 "   DROP TYPE public.sentiment_label;
       public          postgres    false            �           1247    16928    survey_topic    TYPE        CREATE TYPE public.survey_topic AS ENUM (
    'Accommodation',
    'Activity',
    'Services',
    'Transportation',
    'Universal',
    'Finance',
    'ACCOMODATION',
    'ACTIVITY',
    'SERVICES',
    'ATTRACTION',
    'TRANSPORTATION',
    'UNIVERSAL',
    'FINANCE',
    'EVENT'
);
    DROP TYPE public.survey_topic;
       public          postgres    false            �            1255    17330 %   update_survey_version_modified_date()    FUNCTION     �  CREATE FUNCTION public.update_survey_version_modified_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        UPDATE survey_versions
        SET modified_date = CURRENT_TIMESTAMP
        WHERE id = OLD.survey_version;
    ELSE
        UPDATE survey_versions
        SET modified_date = CURRENT_TIMESTAMP
        WHERE id = NEW.survey_version;
    END IF;
    RETURN NULL; -- For AFTER triggers, the return value is ignored
END;
$$;
 <   DROP FUNCTION public.update_survey_version_modified_date();
       public          postgres    false            �            1255    16890    update_updated_at_column()    FUNCTION     �   CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.update_updated_at_column();
       public          postgres    false            �            1259    16781    admin_table    TABLE     �  CREATE TABLE public.admin_table (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    gmail character varying(120) NOT NULL,
    e_password character varying(64) NOT NULL,
    last_login timestamp without time zone,
    last_logout timestamp without time zone,
    session_duration integer,
    is_logged_in boolean DEFAULT false,
    role character varying(20)
);
    DROP TABLE public.admin_table;
       public         heap    postgres    false            �            1259    17188    anonymous_session    TABLE     �   CREATE TABLE public.anonymous_session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp without time zone NOT NULL,
    anonymous_user_id uuid
);
 %   DROP TABLE public.anonymous_session;
       public         heap    postgres    false            �            1259    17161    anonymous_users    TABLE     ;  CREATE TABLE public.anonymous_users (
    anonymous_user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT false,
    nickname character varying(50),
    current_step integer DEFAULT 0 NOT NULL,
    has_completed boolean DEFAULT false NOT NULL
);
 #   DROP TABLE public.anonymous_users;
       public         heap    postgres    false            �            1259    16533    surveytopic_types    TABLE     �   CREATE TABLE public.surveytopic_types (
    id integer NOT NULL,
    type_name character varying(100) NOT NULL,
    display_name character varying(100)
);
 %   DROP TABLE public.surveytopic_types;
       public         heap    postgres    false            �            1259    16532    attraction_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attraction_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.attraction_types_id_seq;
       public          postgres    false    223                       0    0    attraction_types_id_seq    SEQUENCE OWNED BY     T   ALTER SEQUENCE public.attraction_types_id_seq OWNED BY public.surveytopic_types.id;
          public          postgres    false    222            �            1259    16524    country_names    TABLE     �   CREATE TABLE public.country_names (
    id integer NOT NULL,
    iso_code character(3) NOT NULL,
    language_code character(6) NOT NULL,
    name character varying(100) NOT NULL
);
 !   DROP TABLE public.country_names;
       public         heap    postgres    false            �            1259    16523    country_names_id_seq    SEQUENCE     �   CREATE SEQUENCE public.country_names_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.country_names_id_seq;
       public          postgres    false    221                       0    0    country_names_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.country_names_id_seq OWNED BY public.country_names.id;
          public          postgres    false    220            �            1259    16852    establishment_localizations    TABLE     D  CREATE TABLE public.establishment_localizations (
    id integer NOT NULL,
    establishment_id integer,
    language_id integer,
    localized_name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 /   DROP TABLE public.establishment_localizations;
       public         heap    postgres    false            �            1259    16851 "   establishment_localizations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.establishment_localizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.establishment_localizations_id_seq;
       public          postgres    false    237                       0    0 "   establishment_localizations_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.establishment_localizations_id_seq OWNED BY public.establishment_localizations.id;
          public          postgres    false    236            �            1259    16835    establishment_types    TABLE     q   CREATE TABLE public.establishment_types (
    establishment_id integer NOT NULL,
    type_id integer NOT NULL
);
 '   DROP TABLE public.establishment_types;
       public         heap    postgres    false            �            1259    16815    establishments    TABLE     *  CREATE TABLE public.establishments (
    id integer NOT NULL,
    est_name character varying(255) NOT NULL,
    city_mun character varying(100) NOT NULL,
    barangay character varying(100),
    latitude numeric(9,6),
    longitude numeric(9,6),
    address text,
    contact_number character varying(20),
    email character varying(100),
    website character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT true
);
 "   DROP TABLE public.establishments;
       public         heap    postgres    false            �            1259    16814    establishments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.establishments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.establishments_id_seq;
       public          postgres    false    232                       0    0    establishments_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.establishments_id_seq OWNED BY public.establishments.id;
          public          postgres    false    231            �            1259    17086 	   hf_tokens    TABLE     �   CREATE TABLE public.hf_tokens (
    id integer NOT NULL,
    apitoken character varying(255) NOT NULL,
    label character varying(20) NOT NULL
);
    DROP TABLE public.hf_tokens;
       public         heap    postgres    false            �            1259    17085    hf_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hf_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.hf_tokens_id_seq;
       public          postgres    false    243                       0    0    hf_tokens_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.hf_tokens_id_seq OWNED BY public.hf_tokens.id;
          public          postgres    false    242            �            1259    16475 	   languages    TABLE     �   CREATE TABLE public.languages (
    id integer NOT NULL,
    code character(2) NOT NULL,
    name character varying(50) NOT NULL,
    flag character(2) NOT NULL
);
    DROP TABLE public.languages;
       public         heap    postgres    false            �            1259    16474    languages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.languages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.languages_id_seq;
       public          postgres    false    219                       0    0    languages_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.languages_id_seq OWNED BY public.languages.id;
          public          postgres    false    218            �            1259    16457    localization00    TABLE     �   CREATE TABLE public.localization00 (
    id integer NOT NULL,
    key text NOT NULL,
    language_code text NOT NULL,
    textcontent text NOT NULL,
    component text
);
 "   DROP TABLE public.localization00;
       public         heap    postgres    false            �            1259    16595 	   locations    TABLE     Y  CREATE TABLE public.locations (
    id integer NOT NULL,
    parent_id integer,
    location_type character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    latitude numeric(9,6),
    longitude numeric(9,6),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.locations;
       public         heap    postgres    false            �            1259    16594    locations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.locations_id_seq;
       public          postgres    false    225                       0    0    locations_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;
          public          postgres    false    224            �            1259    16447    municipalities    TABLE     �   CREATE TABLE public.municipalities (
    id integer NOT NULL,
    municipality character varying(255) NOT NULL,
    province character varying(255) NOT NULL
);
 "   DROP TABLE public.municipalities;
       public         heap    postgres    false            �            1259    16446    municipalities_id_seq    SEQUENCE     �   CREATE SEQUENCE public.municipalities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.municipalities_id_seq;
       public          postgres    false    215                       0    0    municipalities_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.municipalities_id_seq OWNED BY public.municipalities.id;
          public          postgres    false    214            �            1259    17028    sentiment_analysis    TABLE     @  CREATE TABLE public.sentiment_analysis (
    sentiment_id integer NOT NULL,
    response_id integer,
    text text,
    sentiment_score_positive numeric NOT NULL,
    sentiment_score_neutral numeric NOT NULL,
    sentiment_score_negative numeric NOT NULL,
    sentiment_label public.sentiment_label NOT NULL,
    entity text,
    question text,
    date date NOT NULL,
    language character(2) NOT NULL,
    metadata jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 &   DROP TABLE public.sentiment_analysis;
       public         heap    postgres    false    927            �            1259    17027 #   sentiment_analysis_sentiment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sentiment_analysis_sentiment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.sentiment_analysis_sentiment_id_seq;
       public          postgres    false    241                       0    0 #   sentiment_analysis_sentiment_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.sentiment_analysis_sentiment_id_seq OWNED BY public.sentiment_analysis.sentiment_id;
          public          postgres    false    240            �            1259    17317    survey_questions    TABLE     `  CREATE TABLE public.survey_questions (
    id integer NOT NULL,
    questiontype public.qtype NOT NULL,
    survey_version integer,
    content text,
    modified_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    title character varying(100),
    surveyresponses_ref character varying(10),
    surveytopic public.survey_topic
);
 $   DROP TABLE public.survey_questions;
       public         heap    postgres    false    954    945            �            1259    17316    survey_questions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.survey_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.survey_questions_id_seq;
       public          postgres    false    249                        0    0    survey_questions_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.survey_questions_id_seq OWNED BY public.survey_questions.id;
          public          postgres    false    248            �            1259    17394    survey_responses    TABLE     6  CREATE TABLE public.survey_responses (
    response_id integer NOT NULL,
    anonymous_user_id uuid,
    surveyquestion_ref character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_analyzed boolean DEFAULT false NOT NULL,
    response_value text NOT NULL
);
 $   DROP TABLE public.survey_responses;
       public         heap    postgres    false            �            1259    17393     survey_responses_response_id_seq    SEQUENCE     �   CREATE SEQUENCE public.survey_responses_response_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.survey_responses_response_id_seq;
       public          postgres    false    251            !           0    0     survey_responses_response_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.survey_responses_response_id_seq OWNED BY public.survey_responses.response_id;
          public          postgres    false    250            �            1259    17308    survey_versions    TABLE     .  CREATE TABLE public.survey_versions (
    id integer NOT NULL,
    title character varying(20),
    description character varying(100),
    creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 #   DROP TABLE public.survey_versions;
       public         heap    postgres    false            �            1259    17307    survey_versions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.survey_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.survey_versions_id_seq;
       public          postgres    false    247            "           0    0    survey_versions_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.survey_versions_id_seq OWNED BY public.survey_versions.id;
          public          postgres    false    246            �            1259    16456    texts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.texts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.texts_id_seq;
       public          postgres    false    217            #           0    0    texts_id_seq    SEQUENCE OWNED BY     F   ALTER SEQUENCE public.texts_id_seq OWNED BY public.localization00.id;
          public          postgres    false    216            �            1259    16751    tourismattraction_localizations    TABLE     �  CREATE TABLE public.tourismattraction_localizations (
    id integer NOT NULL,
    tourism_attraction_id integer NOT NULL,
    language_id integer NOT NULL,
    translated_name character varying(255) NOT NULL,
    translated_ta_category character varying(100) NOT NULL,
    translated_ntdp_category character varying(100) NOT NULL,
    translated_mgt character varying(100) NOT NULL
);
 3   DROP TABLE public.tourismattraction_localizations;
       public         heap    postgres    false            �            1259    16732    tourismattractions    TABLE     �  CREATE TABLE public.tourismattractions (
    id integer NOT NULL,
    ta_name character varying(255) NOT NULL,
    type_code character varying(50) NOT NULL,
    region character varying(50) NOT NULL,
    prov_huc character varying(50) NOT NULL,
    city_mun character varying(50) NOT NULL,
    report_year integer NOT NULL,
    brgy character varying(50) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL,
    ta_category character varying(100) NOT NULL,
    ntdp_category character varying(100) NOT NULL,
    devt_lvl character varying(50) NOT NULL,
    mgt character varying(100) NOT NULL,
    online_connectivity character varying(50)
);
 &   DROP TABLE public.tourismattractions;
       public         heap    postgres    false            �            1259    16731    tourismattractions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tourismattractions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.tourismattractions_id_seq;
       public          postgres    false    227            $           0    0    tourismattractions_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.tourismattractions_id_seq OWNED BY public.tourismattractions.id;
          public          postgres    false    226            �            1259    16750 $   tourismattractiontranslations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tourismattractiontranslations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.tourismattractiontranslations_id_seq;
       public          postgres    false    229            %           0    0 $   tourismattractiontranslations_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.tourismattractiontranslations_id_seq OWNED BY public.tourismattraction_localizations.id;
          public          postgres    false    228            �            1259    16827    types    TABLE     f   CREATE TABLE public.types (
    id integer NOT NULL,
    type_name character varying(100) NOT NULL
);
    DROP TABLE public.types;
       public         heap    postgres    false            �            1259    16826    types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.types_id_seq;
       public          postgres    false    234            &           0    0    types_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.types_id_seq OWNED BY public.types.id;
          public          postgres    false    233            �            1259    16873    users    TABLE     �  CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    hashed_password text NOT NULL,
    full_name character varying(100),
    language_preference character varying(10) DEFAULT 'en'::character varying,
    country character varying(50),
    last_login timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT true,
    is_verified boolean DEFAULT false,
    role character varying(20) DEFAULT 'user'::character varying,
    CONSTRAINT email_format CHECK (((email)::text ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text))
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16872    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    239            '           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    238            �           2604    16527    country_names id    DEFAULT     t   ALTER TABLE ONLY public.country_names ALTER COLUMN id SET DEFAULT nextval('public.country_names_id_seq'::regclass);
 ?   ALTER TABLE public.country_names ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    16855    establishment_localizations id    DEFAULT     �   ALTER TABLE ONLY public.establishment_localizations ALTER COLUMN id SET DEFAULT nextval('public.establishment_localizations_id_seq'::regclass);
 M   ALTER TABLE public.establishment_localizations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    236    237            �           2604    16818    establishments id    DEFAULT     v   ALTER TABLE ONLY public.establishments ALTER COLUMN id SET DEFAULT nextval('public.establishments_id_seq'::regclass);
 @   ALTER TABLE public.establishments ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    232    232            �           2604    17089    hf_tokens id    DEFAULT     l   ALTER TABLE ONLY public.hf_tokens ALTER COLUMN id SET DEFAULT nextval('public.hf_tokens_id_seq'::regclass);
 ;   ALTER TABLE public.hf_tokens ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    242    243    243            �           2604    16478    languages id    DEFAULT     l   ALTER TABLE ONLY public.languages ALTER COLUMN id SET DEFAULT nextval('public.languages_id_seq'::regclass);
 ;   ALTER TABLE public.languages ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    16460    localization00 id    DEFAULT     m   ALTER TABLE ONLY public.localization00 ALTER COLUMN id SET DEFAULT nextval('public.texts_id_seq'::regclass);
 @   ALTER TABLE public.localization00 ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            �           2604    16598    locations id    DEFAULT     l   ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);
 ;   ALTER TABLE public.locations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    16450    municipalities id    DEFAULT     v   ALTER TABLE ONLY public.municipalities ALTER COLUMN id SET DEFAULT nextval('public.municipalities_id_seq'::regclass);
 @   ALTER TABLE public.municipalities ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    17031    sentiment_analysis sentiment_id    DEFAULT     �   ALTER TABLE ONLY public.sentiment_analysis ALTER COLUMN sentiment_id SET DEFAULT nextval('public.sentiment_analysis_sentiment_id_seq'::regclass);
 N   ALTER TABLE public.sentiment_analysis ALTER COLUMN sentiment_id DROP DEFAULT;
       public          postgres    false    240    241    241                       2604    17320    survey_questions id    DEFAULT     z   ALTER TABLE ONLY public.survey_questions ALTER COLUMN id SET DEFAULT nextval('public.survey_questions_id_seq'::regclass);
 B   ALTER TABLE public.survey_questions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    248    249    249                       2604    17397    survey_responses response_id    DEFAULT     �   ALTER TABLE ONLY public.survey_responses ALTER COLUMN response_id SET DEFAULT nextval('public.survey_responses_response_id_seq'::regclass);
 K   ALTER TABLE public.survey_responses ALTER COLUMN response_id DROP DEFAULT;
       public          postgres    false    251    250    251            �           2604    17311    survey_versions id    DEFAULT     x   ALTER TABLE ONLY public.survey_versions ALTER COLUMN id SET DEFAULT nextval('public.survey_versions_id_seq'::regclass);
 A   ALTER TABLE public.survey_versions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    246    247    247            �           2604    16536    surveytopic_types id    DEFAULT     {   ALTER TABLE ONLY public.surveytopic_types ALTER COLUMN id SET DEFAULT nextval('public.attraction_types_id_seq'::regclass);
 C   ALTER TABLE public.surveytopic_types ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            �           2604    16754 "   tourismattraction_localizations id    DEFAULT     �   ALTER TABLE ONLY public.tourismattraction_localizations ALTER COLUMN id SET DEFAULT nextval('public.tourismattractiontranslations_id_seq'::regclass);
 Q   ALTER TABLE public.tourismattraction_localizations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    16735    tourismattractions id    DEFAULT     ~   ALTER TABLE ONLY public.tourismattractions ALTER COLUMN id SET DEFAULT nextval('public.tourismattractions_id_seq'::regclass);
 D   ALTER TABLE public.tourismattractions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            �           2604    16830    types id    DEFAULT     d   ALTER TABLE ONLY public.types ALTER COLUMN id SET DEFAULT nextval('public.types_id_seq'::regclass);
 7   ALTER TABLE public.types ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    16876    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    238    239    239            �          0    16781    admin_table 
   TABLE DATA           �   COPY public.admin_table (id, username, gmail, e_password, last_login, last_logout, session_duration, is_logged_in, role) FROM stdin;
    public          postgres    false    230   ��       
          0    17188    anonymous_session 
   TABLE DATA           Q   COPY public.anonymous_session (sid, sess, expire, anonymous_user_id) FROM stdin;
    public          postgres    false    245   ��       	          0    17161    anonymous_users 
   TABLE DATA           z   COPY public.anonymous_users (anonymous_user_id, created_at, is_active, nickname, current_step, has_completed) FROM stdin;
    public          postgres    false    244   n�       �          0    16524    country_names 
   TABLE DATA           J   COPY public.country_names (id, iso_code, language_code, name) FROM stdin;
    public          postgres    false    221   ��                 0    16852    establishment_localizations 
   TABLE DATA           �   COPY public.establishment_localizations (id, establishment_id, language_id, localized_name, created_at, updated_at) FROM stdin;
    public          postgres    false    237   ��                  0    16835    establishment_types 
   TABLE DATA           H   COPY public.establishment_types (establishment_id, type_id) FROM stdin;
    public          postgres    false    235   ��       �          0    16815    establishments 
   TABLE DATA           �   COPY public.establishments (id, est_name, city_mun, barangay, latitude, longitude, address, contact_number, email, website, created_at, updated_at, is_active) FROM stdin;
    public          postgres    false    232   �                 0    17086 	   hf_tokens 
   TABLE DATA           8   COPY public.hf_tokens (id, apitoken, label) FROM stdin;
    public          postgres    false    243   ��       �          0    16475 	   languages 
   TABLE DATA           9   COPY public.languages (id, code, name, flag) FROM stdin;
    public          postgres    false    219   \�       �          0    16457    localization00 
   TABLE DATA           X   COPY public.localization00 (id, key, language_code, textcontent, component) FROM stdin;
    public          postgres    false    217   �       �          0    16595 	   locations 
   TABLE DATA           t   COPY public.locations (id, parent_id, location_type, name, latitude, longitude, created_at, updated_at) FROM stdin;
    public          postgres    false    225    �      �          0    16447    municipalities 
   TABLE DATA           D   COPY public.municipalities (id, municipality, province) FROM stdin;
    public          postgres    false    215   ��                0    17028    sentiment_analysis 
   TABLE DATA           �   COPY public.sentiment_analysis (sentiment_id, response_id, text, sentiment_score_positive, sentiment_score_neutral, sentiment_score_negative, sentiment_label, entity, question, date, language, metadata, created_at, updated_at) FROM stdin;
    public          postgres    false    241   "#                0    17317    survey_questions 
   TABLE DATA           �   COPY public.survey_questions (id, questiontype, survey_version, content, modified_date, title, surveyresponses_ref, surveytopic) FROM stdin;
    public          postgres    false    249   ?#                0    17394    survey_responses 
   TABLE DATA           �   COPY public.survey_responses (response_id, anonymous_user_id, surveyquestion_ref, created_at, is_analyzed, response_value) FROM stdin;
    public          postgres    false    251   h1                0    17308    survey_versions 
   TABLE DATA           _   COPY public.survey_versions (id, title, description, creation_date, modified_date) FROM stdin;
    public          postgres    false    247   �<      �          0    16533    surveytopic_types 
   TABLE DATA           H   COPY public.surveytopic_types (id, type_name, display_name) FROM stdin;
    public          postgres    false    223   =      �          0    16751    tourismattraction_localizations 
   TABLE DATA           �   COPY public.tourismattraction_localizations (id, tourism_attraction_id, language_id, translated_name, translated_ta_category, translated_ntdp_category, translated_mgt) FROM stdin;
    public          postgres    false    229   �=      �          0    16732    tourismattractions 
   TABLE DATA           �   COPY public.tourismattractions (id, ta_name, type_code, region, prov_huc, city_mun, report_year, brgy, latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity) FROM stdin;
    public          postgres    false    227   }[      �          0    16827    types 
   TABLE DATA           .   COPY public.types (id, type_name) FROM stdin;
    public          postgres    false    234   2`                0    16873    users 
   TABLE DATA           �   COPY public.users (user_id, email, hashed_password, full_name, language_preference, country, last_login, created_at, updated_at, is_active, is_verified, role) FROM stdin;
    public          postgres    false    239   3a      (           0    0    attraction_types_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.attraction_types_id_seq', 11, true);
          public          postgres    false    222            )           0    0    country_names_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.country_names_id_seq', 1, false);
          public          postgres    false    220            *           0    0 "   establishment_localizations_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.establishment_localizations_id_seq', 1, false);
          public          postgres    false    236            +           0    0    establishments_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.establishments_id_seq', 5, true);
          public          postgres    false    231            ,           0    0    hf_tokens_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.hf_tokens_id_seq', 7, true);
          public          postgres    false    242            -           0    0    languages_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.languages_id_seq', 8, true);
          public          postgres    false    218            .           0    0    locations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.locations_id_seq', 52, true);
          public          postgres    false    224            /           0    0    municipalities_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.municipalities_id_seq', 1643, true);
          public          postgres    false    214            0           0    0 #   sentiment_analysis_sentiment_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.sentiment_analysis_sentiment_id_seq', 1, false);
          public          postgres    false    240            1           0    0    survey_questions_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.survey_questions_id_seq', 184, true);
          public          postgres    false    248            2           0    0     survey_responses_response_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.survey_responses_response_id_seq', 179, true);
          public          postgres    false    250            3           0    0    survey_versions_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.survey_versions_id_seq', 1, true);
          public          postgres    false    246            4           0    0    texts_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.texts_id_seq', 5589, true);
          public          postgres    false    216            5           0    0    tourismattractions_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.tourismattractions_id_seq', 34, true);
          public          postgres    false    226            6           0    0 $   tourismattractiontranslations_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.tourismattractiontranslations_id_seq', 784, true);
          public          postgres    false    228            7           0    0    types_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.types_id_seq', 20, true);
          public          postgres    false    233            8           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          postgres    false    238            '           2606    16786    admin_table admin_table_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.admin_table
    ADD CONSTRAINT admin_table_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.admin_table DROP CONSTRAINT admin_table_pkey;
       public            postgres    false    230            E           2606    17194 (   anonymous_session anonymous_session_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.anonymous_session
    ADD CONSTRAINT anonymous_session_pkey PRIMARY KEY (sid);
 R   ALTER TABLE ONLY public.anonymous_session DROP CONSTRAINT anonymous_session_pkey;
       public            postgres    false    245            C           2606    17167 $   anonymous_users anonymous_users_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.anonymous_users
    ADD CONSTRAINT anonymous_users_pkey PRIMARY KEY (anonymous_user_id);
 N   ALTER TABLE ONLY public.anonymous_users DROP CONSTRAINT anonymous_users_pkey;
       public            postgres    false    244                       2606    16538 '   surveytopic_types attraction_types_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.surveytopic_types
    ADD CONSTRAINT attraction_types_pkey PRIMARY KEY (id);
 Q   ALTER TABLE ONLY public.surveytopic_types DROP CONSTRAINT attraction_types_pkey;
       public            postgres    false    223                       2606    16540 0   surveytopic_types attraction_types_type_name_key 
   CONSTRAINT     p   ALTER TABLE ONLY public.surveytopic_types
    ADD CONSTRAINT attraction_types_type_name_key UNIQUE (type_name);
 Z   ALTER TABLE ONLY public.surveytopic_types DROP CONSTRAINT attraction_types_type_name_key;
       public            postgres    false    223                       2606    16531 6   country_names country_names_iso_code_language_code_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.country_names
    ADD CONSTRAINT country_names_iso_code_language_code_key UNIQUE (iso_code, language_code);
 `   ALTER TABLE ONLY public.country_names DROP CONSTRAINT country_names_iso_code_language_code_key;
       public            postgres    false    221    221                       2606    16529     country_names country_names_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.country_names
    ADD CONSTRAINT country_names_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.country_names DROP CONSTRAINT country_names_pkey;
       public            postgres    false    221            1           2606    16861 X   establishment_localizations establishment_localizations_establishment_id_language_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.establishment_localizations
    ADD CONSTRAINT establishment_localizations_establishment_id_language_id_key UNIQUE (establishment_id, language_id);
 �   ALTER TABLE ONLY public.establishment_localizations DROP CONSTRAINT establishment_localizations_establishment_id_language_id_key;
       public            postgres    false    237    237            3           2606    16859 <   establishment_localizations establishment_localizations_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.establishment_localizations
    ADD CONSTRAINT establishment_localizations_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.establishment_localizations DROP CONSTRAINT establishment_localizations_pkey;
       public            postgres    false    237            /           2606    16839 ,   establishment_types establishment_types_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.establishment_types
    ADD CONSTRAINT establishment_types_pkey PRIMARY KEY (establishment_id, type_id);
 V   ALTER TABLE ONLY public.establishment_types DROP CONSTRAINT establishment_types_pkey;
       public            postgres    false    235    235            )           2606    16825 "   establishments establishments_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.establishments
    ADD CONSTRAINT establishments_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.establishments DROP CONSTRAINT establishments_pkey;
       public            postgres    false    232            A           2606    17091    hf_tokens hf_tokens_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.hf_tokens
    ADD CONSTRAINT hf_tokens_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.hf_tokens DROP CONSTRAINT hf_tokens_pkey;
       public            postgres    false    243                       2606    16482    languages languages_code_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_code_key UNIQUE (code);
 F   ALTER TABLE ONLY public.languages DROP CONSTRAINT languages_code_key;
       public            postgres    false    219                       2606    16480    languages languages_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.languages DROP CONSTRAINT languages_pkey;
       public            postgres    false    219                       2606    16602    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            postgres    false    225                       2606    16454 "   municipalities municipalities_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.municipalities
    ADD CONSTRAINT municipalities_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.municipalities DROP CONSTRAINT municipalities_pkey;
       public            postgres    false    215            ?           2606    17037 *   sentiment_analysis sentiment_analysis_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.sentiment_analysis
    ADD CONSTRAINT sentiment_analysis_pkey PRIMARY KEY (sentiment_id);
 T   ALTER TABLE ONLY public.sentiment_analysis DROP CONSTRAINT sentiment_analysis_pkey;
       public            postgres    false    241            J           2606    17324 &   survey_questions survey_questions_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT survey_questions_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.survey_questions DROP CONSTRAINT survey_questions_pkey;
       public            postgres    false    249            N           2606    17403 &   survey_responses survey_responses_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_pkey PRIMARY KEY (response_id);
 P   ALTER TABLE ONLY public.survey_responses DROP CONSTRAINT survey_responses_pkey;
       public            postgres    false    251            H           2606    17315 $   survey_versions survey_versions_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.survey_versions
    ADD CONSTRAINT survey_versions_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.survey_versions DROP CONSTRAINT survey_versions_pkey;
       public            postgres    false    247            
           2606    16464    localization00 texts_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.localization00
    ADD CONSTRAINT texts_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY public.localization00 DROP CONSTRAINT texts_pkey;
       public            postgres    false    217            #           2606    16739 *   tourismattractions tourismattractions_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.tourismattractions
    ADD CONSTRAINT tourismattractions_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.tourismattractions DROP CONSTRAINT tourismattractions_pkey;
       public            postgres    false    227            %           2606    16758 B   tourismattraction_localizations tourismattractiontranslations_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.tourismattraction_localizations
    ADD CONSTRAINT tourismattractiontranslations_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.tourismattraction_localizations DROP CONSTRAINT tourismattractiontranslations_pkey;
       public            postgres    false    229            +           2606    16832    types types_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.types DROP CONSTRAINT types_pkey;
       public            postgres    false    234            -           2606    16834    types types_type_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_type_name_key UNIQUE (type_name);
 C   ALTER TABLE ONLY public.types DROP CONSTRAINT types_type_name_key;
       public            postgres    false    234            L           2606    17358 ,   survey_questions unique_survey_responses_ref 
   CONSTRAINT     v   ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT unique_survey_responses_ref UNIQUE (surveyresponses_ref);
 V   ALTER TABLE ONLY public.survey_questions DROP CONSTRAINT unique_survey_responses_ref;
       public            postgres    false    249            6           2606    16889    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    239            8           2606    16887    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    239                       1259    16742    idx_city_mun    INDEX     O   CREATE INDEX idx_city_mun ON public.tourismattractions USING btree (city_mun);
     DROP INDEX public.idx_city_mun;
       public            postgres    false    227                       1259    16746    idx_devt_lvl    INDEX     O   CREATE INDEX idx_devt_lvl ON public.tourismattractions USING btree (devt_lvl);
     DROP INDEX public.idx_devt_lvl;
       public            postgres    false    227            4           1259    16892 	   idx_email    INDEX     C   CREATE UNIQUE INDEX idx_email ON public.users USING btree (email);
    DROP INDEX public.idx_email;
       public            postgres    false    239                       1259    16747    idx_mgt    INDEX     E   CREATE INDEX idx_mgt ON public.tourismattractions USING btree (mgt);
    DROP INDEX public.idx_mgt;
       public            postgres    false    227                       1259    16745    idx_ntdp_category    INDEX     Y   CREATE INDEX idx_ntdp_category ON public.tourismattractions USING btree (ntdp_category);
 %   DROP INDEX public.idx_ntdp_category;
       public            postgres    false    227                       1259    16748    idx_online_connectivity    INDEX     e   CREATE INDEX idx_online_connectivity ON public.tourismattractions USING btree (online_connectivity);
 +   DROP INDEX public.idx_online_connectivity;
       public            postgres    false    227                       1259    16741 
   idx_region    INDEX     K   CREATE INDEX idx_region ON public.tourismattractions USING btree (region);
    DROP INDEX public.idx_region;
       public            postgres    false    227                       1259    16743    idx_report_year    INDEX     U   CREATE INDEX idx_report_year ON public.tourismattractions USING btree (report_year);
 #   DROP INDEX public.idx_report_year;
       public            postgres    false    227            9           1259    17051    idx_sentiment_analysis_date    INDEX     Z   CREATE INDEX idx_sentiment_analysis_date ON public.sentiment_analysis USING btree (date);
 /   DROP INDEX public.idx_sentiment_analysis_date;
       public            postgres    false    241            :           1259    17049    idx_sentiment_analysis_entity    INDEX     ^   CREATE INDEX idx_sentiment_analysis_entity ON public.sentiment_analysis USING btree (entity);
 1   DROP INDEX public.idx_sentiment_analysis_entity;
       public            postgres    false    241            ;           1259    17052    idx_sentiment_analysis_language    INDEX     b   CREATE INDEX idx_sentiment_analysis_language ON public.sentiment_analysis USING btree (language);
 3   DROP INDEX public.idx_sentiment_analysis_language;
       public            postgres    false    241            <           1259    17050    idx_sentiment_analysis_question    INDEX     b   CREATE INDEX idx_sentiment_analysis_question ON public.sentiment_analysis USING btree (question);
 3   DROP INDEX public.idx_sentiment_analysis_question;
       public            postgres    false    241            =           1259    17048 "   idx_sentiment_analysis_response_id    INDEX     h   CREATE INDEX idx_sentiment_analysis_response_id ON public.sentiment_analysis USING btree (response_id);
 6   DROP INDEX public.idx_sentiment_analysis_response_id;
       public            postgres    false    241            F           1259    17195    idx_session_expire    INDEX     R   CREATE INDEX idx_session_expire ON public.anonymous_session USING btree (expire);
 &   DROP INDEX public.idx_session_expire;
       public            postgres    false    245                        1259    16744    idx_ta_category    INDEX     U   CREATE INDEX idx_ta_category ON public.tourismattractions USING btree (ta_category);
 #   DROP INDEX public.idx_ta_category;
       public            postgres    false    227            !           1259    16740    idx_ta_name    INDEX     M   CREATE INDEX idx_ta_name ON public.tourismattractions USING btree (ta_name);
    DROP INDEX public.idx_ta_name;
       public            postgres    false    227            [           2620    16891    users set_updated_at    TRIGGER     }   CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 -   DROP TRIGGER set_updated_at ON public.users;
       public          postgres    false    239    252            \           2620    17337 2   survey_questions survey_questions_modified_trigger    TRIGGER     �   CREATE TRIGGER survey_questions_modified_trigger AFTER INSERT OR UPDATE ON public.survey_questions FOR EACH ROW EXECUTE FUNCTION public.update_survey_version_modified_date();
 K   DROP TRIGGER survey_questions_modified_trigger ON public.survey_questions;
       public          postgres    false    253    249            W           2606    17196 :   anonymous_session anonymous_session_anonymous_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.anonymous_session
    ADD CONSTRAINT anonymous_session_anonymous_user_id_fkey FOREIGN KEY (anonymous_user_id) REFERENCES public.anonymous_users(anonymous_user_id);
 d   ALTER TABLE ONLY public.anonymous_session DROP CONSTRAINT anonymous_session_anonymous_user_id_fkey;
       public          postgres    false    244    245    3395            T           2606    16862 M   establishment_localizations establishment_localizations_establishment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.establishment_localizations
    ADD CONSTRAINT establishment_localizations_establishment_id_fkey FOREIGN KEY (establishment_id) REFERENCES public.establishments(id) ON DELETE CASCADE;
 w   ALTER TABLE ONLY public.establishment_localizations DROP CONSTRAINT establishment_localizations_establishment_id_fkey;
       public          postgres    false    232    237    3369            U           2606    16867 H   establishment_localizations establishment_localizations_language_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.establishment_localizations
    ADD CONSTRAINT establishment_localizations_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.establishment_localizations DROP CONSTRAINT establishment_localizations_language_id_fkey;
       public          postgres    false    237    219    3342            R           2606    16840 =   establishment_types establishment_types_establishment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.establishment_types
    ADD CONSTRAINT establishment_types_establishment_id_fkey FOREIGN KEY (establishment_id) REFERENCES public.establishments(id) ON DELETE CASCADE;
 g   ALTER TABLE ONLY public.establishment_types DROP CONSTRAINT establishment_types_establishment_id_fkey;
       public          postgres    false    3369    235    232            S           2606    16845 4   establishment_types establishment_types_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.establishment_types
    ADD CONSTRAINT establishment_types_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.types(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.establishment_types DROP CONSTRAINT establishment_types_type_id_fkey;
       public          postgres    false    3371    235    234            O           2606    16603 "   locations locations_parent_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.locations(id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_parent_id_fkey;
       public          postgres    false    3352    225    225            V           2606    17043 3   sentiment_analysis sentiment_analysis_language_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentiment_analysis
    ADD CONSTRAINT sentiment_analysis_language_fkey FOREIGN KEY (language) REFERENCES public.languages(code) ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public.sentiment_analysis DROP CONSTRAINT sentiment_analysis_language_fkey;
       public          postgres    false    3340    241    219            X           2606    17325 5   survey_questions survey_questions_survey_version_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT survey_questions_survey_version_fkey FOREIGN KEY (survey_version) REFERENCES public.survey_versions(id) ON DELETE CASCADE;
 _   ALTER TABLE ONLY public.survey_questions DROP CONSTRAINT survey_questions_survey_version_fkey;
       public          postgres    false    249    3400    247            Y           2606    17404 8   survey_responses survey_responses_anonymous_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_anonymous_user_id_fkey FOREIGN KEY (anonymous_user_id) REFERENCES public.anonymous_users(anonymous_user_id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.survey_responses DROP CONSTRAINT survey_responses_anonymous_user_id_fkey;
       public          postgres    false    3395    251    244            Z           2606    17409 9   survey_responses survey_responses_surveyquestion_ref_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_surveyquestion_ref_fkey FOREIGN KEY (surveyquestion_ref) REFERENCES public.survey_questions(surveyresponses_ref);
 c   ALTER TABLE ONLY public.survey_responses DROP CONSTRAINT survey_responses_surveyquestion_ref_fkey;
       public          postgres    false    251    3404    249            P           2606    16764 N   tourismattraction_localizations tourismattractiontranslations_language_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tourismattraction_localizations
    ADD CONSTRAINT tourismattractiontranslations_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id) ON DELETE CASCADE;
 x   ALTER TABLE ONLY public.tourismattraction_localizations DROP CONSTRAINT tourismattractiontranslations_language_id_fkey;
       public          postgres    false    219    229    3342            Q           2606    16759 X   tourismattraction_localizations tourismattractiontranslations_tourism_attraction_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tourismattraction_localizations
    ADD CONSTRAINT tourismattractiontranslations_tourism_attraction_id_fkey FOREIGN KEY (tourism_attraction_id) REFERENCES public.tourismattractions(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.tourismattraction_localizations DROP CONSTRAINT tourismattractiontranslations_tourism_attraction_id_fkey;
       public          postgres    false    227    3363    229            �     x�M��n�@���.�:�s�g�" Ū�J%n���i�y����&'gs�{?����:��1�3��g�29�8}-=?K���
����@Y5p���O>��<?�U�P2{�%�����[ΰ�����]��r:%>����)������˧����ϫ���� �l k��!7��@j+��?��m['�N�?E�WLt��R7\g��P�١U�����e�m��}�&�X�h�e��,��;~M�I#��HQ6� �$���EР%��1��e}��\$      
   �  x����N�0�5<ʺ��/�;�LJ��WZ�
	َ�J�K
�w��4�Φ�Ζ�O��8�������8�փ��F��LL�j�g������ ߤ�4�����W+�}�Z���t�A= �0@�Ŭ�d����YP���6�>��[WE��f�2��]5_�bQ�3��:˳�9�mG[�i%���Xb$p�����`��X"s��ٿx�.�xF����ιo�����I�v��n��E���ʣ4?�����+�$Z!r	H�8�CRj��7'b�~œOg�M��Ϟ[�e�&k�6��M/�Ƌv*�'r��h��J{-Xz�N���d��=��4Ge�1�]&ƠF+j�Ys-�ܝz�ǭS�I�w�0g�彭�4
�R87�Z�\h�ag�pq��,�y��x2�	o� o%+Gzw���"U�a����ʣ��r��4 �PC"A9�@h�e�JO�;�_���y�b6l���IuzQ^���Ͻ+���gYz"'�G;#�s��j]9=5��t�*�{^�b��?���e��g�i��0}��vo�Lo�A�����DNz��b��xb*'�3�
�"\q������h�.���.��m��t���0.�O��8�����!K��DC�t�>�$����0�yN�q���?����T�      	     x�u�In\G�׭S�l����;'H6	� F����G0�d���n@�Pb�(�äXP�5p� ^�*��˅����˭��VP��/�|���/�����.�~�/�K��ꓡ.#h�F������Lփ�~+xC�?�����+��ؽ�}$*V�^4 �<���O�F�oD
�8�?&<h�C���Ȣ9G�[Mq��'��+ҭЭ֫�SҾ~~���]W>4'�F����>��\^�EWe"�svצ�*�|^��2l �R��C��W.qhD�b]��f�i��D���d�G�'�Z]��	�9��ɗ�
�s��u��m%�1(�X� ��|ZO�}�	�<�X�&�A��|cɯk��ӊR������\u��zX��8 5c��-E����5��I��&�ႅK��|�c{��^Ve��`�}$�:�h�9G%��~b�}"�I\�]��k^SV��w�{��z՞�VY��y��
wۓH[9QmM��Yp�"p6}<Q)����F�����qB_�!;�U��O@l�'�
���Lڪ|���v�1��t�JO�H�eh�\���cٹ�b��LuQ�������J@ʭ����a�^��e�|�nA����0��T��N)�\6;�2k]V�V�]�eB�V���Ħ���Hq�s��R~�,��dn-��� �4�;hN��=���R��p�o���e�?j���+�M�v�Y�'g���\D�pf�(��ζ%�I�����&	�ɐ��!��a�#�5}t�S�`a�?�8O�)��zs��:ioo�{�(�1���������u�m���>FYd�>��������	ZG[��7�?�iU����wP�UN�I�7� ���K-��v��U��������׶x�9/Ǩ@k�M���[��OT3�E��K�G���q��#/n�EZY���'5R��k����(�K)��)�n�adU�|�	k�Θ��xRp���2Yv��e�v���O�����$s��|'i�<(:sC�J��d�E��P�'��~�|����|>�      �      x������ � �            x������ � �          *   x�3�4�2c# 6�2�M�lc m������W� �>�      �   �   x����
�@F��S����h�&�Em�L:������	������9�aQK�!�ݍ�lh�d��iXY��k��i;��n�p���ٮ��wi�e��$Jؓ-DX�I����^�r���\�|�7���:+k�ϒy'+����C�s�%�< ���-�z
ޒz��Z���k��x����)-�0^��f         q   x�3�5r+Nqˎ0�wsw)v��3��Ȱ4�/+�6s�(H�*�pNLJO31ӎ��t���/p�
3�(	��J	�ȴ��r�wͱ+()���tq�O+JM����� �� �      �   �   x�3�L��t�K��,��,-�2���|��������y\Ɯ���o��y�u���8���L8�9�M_�lΚ��qfp�r�Qb��剙�@�gF&�%;,��`ɊK{,Y�`igf�9gQ)�ņ��/6^�uaǅ�@.��bN�����s�l�=... �NDF      �      x�̽[SY�0�����ez"�#@\���A��g������9q�P6�����>q"� �����`�6`�e.��G ���	�D�_8���JU�֒D��}N̴�J+s�re��k��[[�67���-j4]m�BU7ѠV��*�	GU�����T�ڵH@5k甖@�mՔ���6M�*�±�n���W|�V���ɺ�k�"?ٕK��'�����yi�td4?2��:N�+J��I����T��9��g���i��qO�o5���ym@�m���[+��[��3��V��9p�5�Y�Ɏ���:Zx���&f�ƺ��ϳ�O���\܃O��wjE�{z ���Ձ��G�ك��A��AG{[��>�:�}{�d���o2;���6�|~�v�n�^�2w���-����wjlj4�4��ڃ��e�9R��^�»�dk*e�ݎT\Д65؝�hʝݹ������OZw�ni�;Z���_F����\{8�Sv'��a]Q�Q�U�I�U��[��ӟ��?M/ҿ��f~�~�|��/�O�o?M���䧙�g���Χ��s�	�8�rZ�4�2O�w0D� k��H�}�N(�*������4�"�J�l*�X��/����ս�����s�~�n�'���V��q������������x�a/MϷ�廒�{��b���~��۔����e>~�v�^���pT"�`�6Z#����Ha�OB�Z1p��h�Z 4Ђ�HGD�S��X��N������p˝@�Nk8��3{��
�A��^������
]�u�	��.���?y�7��%�*��'ۇ6M����V���n��i����$<E4���V��N��� ��A��8p~%칶���_4��X4�:�Kc���x%\��rUV-^*�!�rI݉��g��V5�D�gE�(Aj��oӌ%��+j��GMm�"4��ˍbP����Bw
��n\��勪/k~'F"8b�\@s�&"�zE����B�_�$�G�zO�T���p�����ʿ���m|�JiY
H �����a1���m��s��S�Ӿ��N@����H�xn�+�7�{4��&{�;rG���ne\g��x�{ԓY���!F(�h	w������
������:z`����J.=��P%�K���#~��i� �#������v��#� ��q����J�{6�͏�����q�]|(����e���1�� X\�] K�G%{-a�f����O+��������M�]?���㛹�q\�\*y���.�������{��K,88�G������"�^pz8�DH�S�����J0	�
�~hB�bp�ɰq�K�t~b@\T����I�/��1lq��3�2�ى�����7x'���lf�2��1�A�A�#�'��{��������6�Nȳ﷎�^_�̟�m[�R"�O����'� ��l��6��x�'��ef|�a|6���3�dq�`�鷙���u�+*�`O��Ā�$���Wb��E6O6�̣�����od��õ�M��Q�Iv����Jfz�$�#�iq����QfHLE�RB���:Z]���J=8
ی��ٓ���&S����,C�A��sb��@���ٷ3b����wj�A�Ӄ���o���% ��?Hltnt�_}�� D�X%\�k���DH�b�g��h�c�������Ǯ�?�H]�Z�t�Zk�9�|A�1��/s�����ﲸ�R�k�w�	�'Ă��<	�E��ٙ��B�[RTA��W�.��]G�w_T\�i��1l1��@����+_b"\s�Ń��
�nѩ{����D/���~���p���Q\��Mz���7)�
�o.y�=%go�����n<��� ���Ȍ���+��爐=�+��V�0u�"����F�\m�,�6ҋ����gP"�Pu��V����<��Hgʣ��缪�J����v��v�E���W�Q�=�u�E-C{�,�=�+�f�z$���;7 [q�zT�4���)�|�V��9��a����*�I�+�v�G�_UT��K4I��3h�p��K�D�a\G���)���۝�oр���L��n	�z���B풿��v	�����o.�o8q�ѕ"��%�NJ&S��������_U��	���U�tWUB�����jh�UE��ۑ�?��XRUqQ����K��C�sj "Du� �����w�f�?If�$.@n�Ϸ�m�"��B&X	���[�AC��;尧�Rb����whTln�~d�#�V ������+�]��/�ª(:��ϳ;����2~PZԐ��a�j��*�]]T҂\�yQXL��+W����� |��۠ �Դ��7�5?�"�sr5s-$s-.GѠ/�!K	Q ���må��R[ʸ��%)�L޼���H\�OWo^�p-o" �����x�QHױ�]{�JQd�\�4��i����%1����H��3�i����W���i~e�V���¬������}N���A,Mz� yQ��&���g=h��ɱ�鈂���^i�g�ƨ��f��ą���!,Z�Y?�����ꗬ�x$�d7,Z����'�N�>O���/d57捶qf2I�����9�[��N��I��\>��1������� ������¾b�br"A�� :�ʗ�%�E#��$�4�T�3a���M��(t��GC��T��Mq�Ҝ�L��KI�7�}^8jrN-��s��Pv��^J�Oӯ�,�{�@A�.�;��Iq���9�l�Q�>����~=<���
��zo��`l�]>�;�Ť)2�K�7���[tK{�����~?z����������^� �b7���H�m�my����Ѳ�쭠ˋ���I���Z�4��� 3�ä��϶����qۗ�b������ϳ̨<�����1:� ����A�y�?�b��H�[�M������
l�C����V��C�tP�8��!1d19'��{/Ġ勲t`��������d�B�o�,�ͅu�%�&�{�ΗL�(�2�pq�@AB��_���>	��d����{T�{�<8�����3؛g{O������ g��ނ���/
4��{�7#�1�Q ��Cq9�#��x]�q�guR5���Z�}���f^�����*3��W�ɮ_��J=�]s�9G�㎁�َ_�J=�=p��GU�s�n���*u�vɭ��pT�������sT%4�����x*�n���Q�x���|V�Tp�h4�6[o�'4ޅѕ�PޟS��h���4㛅vvG��SO���PW����nVM��g7p���#�7�}r�
/hA-J�a|r�q�6��\�F��Rh�Q�*� ��#�/C�/����^--���#���G7�_I���K"���g��H8�~Ђ-�h_���Mi�Q���k0��(�X��(y��� �������_��5�ܭߎ��DXx:H����U�d��5��[�>�K+����Ԅ VL�6�(����=�9}2�|"@%�P�p<�]��Q(O��S�������! O��S�=&��'��<�O���g���������:�u��c��<i�������(�<�:�	.��^%�a�0O���b�s��4�Z��ܣI�4م��4���]�O� m��9} ��f�<�ZǆM(WL��WQ�2�'i~�����!VIp�4m;L6�De`������7>d����pb��W���ɻ�Ě'����`�EJ8���G[�P���yeez� yv,���<y2�z++yJ,������L�L��F�|E�ɎO���'h�!���#�<�r����v��~`.H��c���vd�{3oG�������ԛ��'.jl<5Z�W`j�M!�3��{.��v4���%��"h��{��<A�������^�@L�6��ܸ2�)�A��A��X�D�4� �*�U�6�3������q>,� O���=��	�GO���Qz� �g��    
���Utb�U)���]ǉ�1N ���� �'Vۡ�y��x"�N9�=9���'��Ag��e��z��xfGaF����A|� �<�w	H��'i�<����p:�^6MD��h��W���r�!��2�(Oܶ�3]|��	�އ®���ZL�v����2.?-j��Ev���@�*�*>�_��y 	� \|33/B��./����!X�`�-R#P��%7"��b(	��~lV��
7#k�Ts��y�^�xܱbKş�%	��ND��F�"�(���7%�S��'d���W�}�F�%��OW�նv�Ӣ����='�a;Th ��j��7'��M �|����LZ�ݹѰ ��'p���¥1�hQE�ZrI�c��"���0��΅HY$8lޒ��v�45�V�����[�-�t ��ZL XT�@��c��9@�:�sC{{$ |H [���4�Q@���ڛ���9�r�v��!��`+�����n�@ͱ��wB��)���{��p5%� {]��@vͭp��t����y����D��F�� R�i(*N�~��Y��ywV���r�B�3B t"b�F�;�t�xN��4پ��b�ӌ@h�)��0\D�wd��UL׉�1Bz��{�5���T�qA�%������M�f��j�q]�����t�xNc$/��t�v��3�q��f%J9��Ҟ��ڢ�s�	Sw>�f0N�S��7�x�hU\.���h�����8:���p�zK*�Y�c���|��Z��E6�4u�D߷ɺ��9{%��1�\{D]Q��:7�v�(n�j�Eѹa�{[��P�~����kT%�5r���� ���6Y��d ?�Lў���uƒ�pOp	�-���ጓ՟�$�7�TVY&¢� f�^�[��m�-U	!��d�A��ľ@�RW�j��LhPld�?��������`�gY��&f�$�Z1�������|ETP�y�ZB�N�8E��A��M��>trЍ�#t��E'�_p,�:*r;2縗R�8���~������a/��r�7(R����V8�W8����e-�n���b�o(��Ji�ߔ�U]��Z�W_���>[��ў|rKɥ�rKI�+$�c�� ��_;i�w��g�ﳐ��]ǋ/���2��<����������.��]N$~a}"�8�U��
��1
�HTcD4�P��Ģ�`���e���K 6�ރ!����ٝ#�t�S���.�CG)�Ջ�D/��%�j�,�I�'�C6JZV�y���%:b9����5��#*�H�#�&y�m���3����>OVw:�{
9��? g�h������c,S>V������"�Σp@�|��i�������ћퟳ��8�8���}�xD��룳�i�-( |���N:��i/����y�U����"�1�}֐��.�Kuax;�_%��z�']��i��z�6|�x�I���<��D'̉�@����goN7]XjKbA�$�̬-gSn��+�âJ��;��D�j�����;b�+�[(���H�g��8]3���0h��͆]E�8'BI2��%�����w����ݰ[�J��]�u4�Be��M!Q���0�7ϴ~�ɏ�!�N1��{K#�'#UOMi<�	U�P��Na�,x_��py����X�Wۥ��w 3Y�B.�m��W�խ���8)}����;���h�ћڵ���{�eO�/t��wNU��%P��S�����?��PU�-t8�x��͞�w�˳�џ0�����'P0&Tف��1o�E�aQ"aX�-J�Y��fUS��F�Е/ځ$�@�.$�%��*+�;�
�1	�E�|�b�
7WOu%z���~�͖ɓ��«.�[�]gI�z�k�4/�:q ~	�ñ�	SU)�)ص9�*�$�&8�Zc�)p^	����j$`N�$QCͭ��q��X�v�r���@�%xO��s��*���1�&y�3�W�͡_�>����_5hA�4��������1����#"�\;ϟ�z��
/a��1܀�z{8�Pܸ�p�����7�H|<rS6�|�̶���+7<�o\��⍋�M"<~�⚩P^h�����B��J7 ���\m�Y�_0߫��?�*w���7���ۚ�rKm�+~�	VO�`�X�EknW|ck�]V#����11���܇�܇.{����B:?��'�N������4iW��'�-NF(_QGlM	�I���_�����gE(\g�'�W��+��:�ؓ�� ]���B��ir\9M���ωi�uļ��}%0O���EL�׹|�^gN��[�N��ƺ2��ן�t�fz�3?��'�[ǩ��� �<�H�"W�^��qn>��0G�:1�����Iǘ�E����� �Gz�ש��t�=�L��\T�o8K4�n������u��=�u�m�-O8�`�OZd:I���l�҂�B79L1��%�C���#�sj�3M0�;�=�("J�"vn��$�~���ϹXJ<#ݘko�&�|"`I�8ؽ�-��d���E!}Ը(\,3��Tm�2,2
�fuJd+���˦5�NL���@���"��z�o3Ɯ���C��pb�^�p��._�W�U�A�� e4��N�K�Й�q�ɐ1.4\�
5^o
�!d\�*�t��K��+���L��������9���n�Z����M�6�(�&@1#ۍn<!2�FG���9C�9b)z8֪�f!�oc$
jƟC-���G�:>NR��T�_7^�C�e�����p���A&���]g�'�sg��
������M��)r��\&�u�8j�oq}ջڏ���Ժ�E�Z��.G7/~� ^R7��Hƴ�t�2�,�N�,�2ɔ�FR�n+k�"����x:�F̅��T&m�����D3�7���p�|�d0�6����~�t��%��q�i'���bPE\g��ׂK��2��~RnDu���.ae�lnN��S��#�+� i���9�A	
���#ns�
t2Fc�u����^�:����np���Q�3��^����M�,Twuoyo[�'"Ǘm���2б&@ ��m���������5�\�����d��T��mt@f��}8	�����7�7E7�:����| ������"�	���$iX8�ѽw��������_���.�X�4�����S���X�>p��cd	U����#$�z�iti��`,I��WU�`�-pSk��~��WKO�
� �N�P�s+v��EA5�: �ڪ�{��@�|�P~UqA�;��u���r1���~�h���/��bh�%�%��b	l52lUg4�24�?�}����7!�M������J��&���z;����o"�������Ym�AZ҂�� �IZ}�(� �1h2\ߨz+��(:��<��4��u�55m�4��E@���$���b�UW�*)�uCO_c:�|׸�yu!����q����\b����T>/w��=�� �����W�
�3y �>�:��G��ԟ�H��J��v1#~����G�[.J�ZP���*�,�(��hl9M�L��ң�R�
F���7	q�'Fs3��|�B~|R֦ѝ���)�?I�Ӂ�|���ONa�v�x�Ղ�������R��J�O�t��S�@#�&ň�W��2}Mf|.�O��=\Ke{/Nez~a_�NDz�x3�nt���Z�H�ga�V4m�q�djFRs���BZc9<ա�*��c4:�l=���]ώ��<�g~�|����YB���/�=G��G��N^>��z��_�0�|Ȥ�N��̤$M2�3��"O&>�Y�x4<+��0=���!N/������0\���.5�Jp���
��⯏�7Z�D��	t1��hx�P7!�o���;�J:T�Eh�,<�Y�S�c)ꦩ�d!R�HGe2l�ޝu9�����#�`܀�v �S��NX�����# %�<}i9�O�<�z�9Z�;�����V�c��d��7$w�)t=1K�:���A�:e�����2M��    ��}{�f��RҲ��l�TӠ�=���Q�	��f=�(��b�oI�4��p11�&YY�h��̈�iwÊ��m���z(Wl. /mY���^W)!Z��vj��&�W�)��LGA�L{=ܮb��	�X�B0\����r��A���[o�ED��9��=Mj0�"Ch.���b�V�H�/��I�[�JƮ6�j��=�Z��g���[�M�(0}̿fë%�piGd�
��b�,S�(��ɠ����[w��}H1UW�`π�A�:���-�Q�h8���F�����l�e�yaw.�����dBQR��� e�5Ӥ��4$�P���q�MZi��i���vk�ޙi���}?Az�U+�߼��ϏՎ� �mE�x��w(f�����]0��=ENEu�Y��#��r�9!.�b"��Y&�7��uR�畤EЕ����pn��T�/#S�[:#��R��y	�ؼ5k��nRKڌ�'KR���+��VMJK0����l��:z��)%�7I0Ȥ#��5�c��l`��c�hxR�����L��b��S4��Y���]�-���ר�f�l���������6���,�_W���Ќ�[a	��)xV\-zP����b�sה��䳷IAzEQ��3a�bٝ��rs�ʑU�x���9�bd��,Stv�v��qP ���F�&���Ѵw��b�{Fx>`��g�YP�N��T2��,c5�an!�1��eP��ژ
F��ivq@�i��epcd\a15i����PP-�tcJp�S2�=b��޽tه���=0B�v�$jC��(�vgYBC��[𽑇@D^7��ܰ���ז1��{�6$J�(�ZWrP5����a��˒�Leގ��K�ġ�ᨮ*c0��aX9��I��������y"�)��0����PB��mZ$,�% ����E!��2�c�A#
c.12!p�I�"��2�c&�H��`�Ce�4�	Ȅ*/q	��k�� |`Ei���"��|��x}��L��TYVW	�Ŭ\`򧋡f�|{$�w]�>����Ǽ���@�3��Ԡ�|�,��Zk1M�z���Q5����E���FƧE,;���Xs�edաY����H����Wח��������C�fD5��vW��w�����RZ�h|�ED���g7��#���`f�*�G.5��r����+ ������SV��6����l���r@oւ���ȴ�|�FP�/P��M�b5���a ��x]s������HD5�c��G@=�1��?^�*���S��6�����vQ9�p�7�덗/�x]�(.6��t��Q����B��L*l���7s�{H�`9���јL�(Wt��w��;�Y����	�?N=0�� �)|̽p���i�:B�`�4�� ��Q�0Y�P�:K�!+ē>�J�v�'ҹ��Ӿ� ;O�γbE
 y�u�\����c��� �Ŋ��(V&�(�<��N��L�}�d��C0�j�Vz7O�����,�x�i'{�\�H�'������8:F�{F���}+����`����+k6}�,'�c���h�s��X���I�?F==t2�(�uqZ��$����wN ē(wv(~c��!p#p�֢'��z��df��	���<;V<� ��_�١�X;��vlm<���-wtXy�,O������1� �O^L�y���� �y�s�r�χ�ǋ������dv9y�1x2�$�Ɠ���Mq-���í�\H�s��������?\��,�9���ny
�E��!y2��Ƌ�\:y)���k�sC�nf��<�&�mJ��'U�Y8ٹ�'�_�9n�3d&��Oz�4����O��)�#茧o�����]��lḖ6(A�b�U��U\���w�ㅻ<�s<+��-�Z����ע�'k����'K�٢���T��S�� �������u�C� �K�-X��u��p�rZ������'rw�P�� �'q�mI��� �K���[�A��Ř��A�?� ��W���WX_4�~ q3��w%,�l$��t��E���B�Z��]�t���	��.�qa�+�kz���? 	�k�w�o����Mp]���u� (�.�yb��1ܐ<�:�Lzŕ�p]:�����p��۵������oo^�C�uF�B�v��C)8���aK�[�f�,�pw]\?AX��o�R�	�w4	DcD�)|�.�t��*
�hnU�"
*����/���y+Ϩ�������b�tυ L;
/�������!�D��E� x�y�)��D�J�((����y+��(l��3�,��p�ompE�X|�Q�Ҩ\nT�7\��x�R�r��	�|h����;~p*��z���m�P��V��� ������R�{35���[Y\5���K)H�cèo������(���W�Ƀ}�(�;qg��\�t.��·+��#�_bAt�A�z]ðWN���:�fF�3�XX��
c�r�)�_A�H��8������
�~�v[1�w�XY�O��Kiz�����i�M�[UD����;�2<E�=����ʇ���	��	=N:)kD�	�Jd\��N��9[0f�V5�Bkc�X��u#O�奱������|5��K�&�	@�9V�����l�,ϟk����M�H��Fo�6ڍ���	1%�ـJ_oQh%�����Z��B4��ɚ��v��PJ�3�o1�ZT���cԩwc=���XUw#Oh��|�z�&i�(�ta��)��bI���o�����Q��lP6j��8��R�k���.�����6K��"E�_<�X��.���O�ޢ�/��Bq���q�{2O��T(�vjo�����.�o3�|ʿƼ� ����v[����r;�Q�1�U��"f��|�����+E�r!��t���|	��|��E�Y�3% ��]�+��+Z,Q)ʛ)sZ+\��[���($7�Z�&�XMC1�b�Ji�Ոݹìںr;1��G��S��'.��������p|��l�l~����s��*�d=�T���
U�E:�*���a���?�7��k꽒�s��''s���o!���q�i��Ȫ���'sSo?/P���$��}��<�~��NJ��=D��J�oV�Ol�5��hn~��u5,�,Q�u���e�m�Y��� �a�HωI�\��C�w�ᰂ}&G�b��E��I���w =M��q]��A.&�{4^0"�����l���|���H�l��P�(`^0��{сs�����{���ٶ&����f�Vt�3�V[U��t~,�HPT�Nj�˃xg�n�O^�O�f&]0�c�S�C-�8���dlcF{����&fѤ���p�C�B,=�=��=X?\��b�OFO^��c�9��6���d^%����㝧h�⻑ss����g�n�d�c���ӕ��3�e��pK	��>~�=?�5�¢��ذ3�ǋ��|�(�Iv����#"~~��SٮA�Ntl�{��8�YpA���sJ�ުK��O<ˤ�^��q�cy���A�Z�^l�A�����g#w!��q��ZF'�� >/�!��������7�����n�ك���s�qpl7Z71�y �<����Y(c�}����.��b���q�;>'"߷����bt����m�d(���>���(�3�q��_�t
�e]f�z�� q��+ڱ����u~�2�}�r�`��O��^t�\	�v���òZtm[�}���!<���9&,�M��׵X��MK��Ȏn��˃�
έ����H l�+#a3������O�y�CK�� б��-�	��i��(�15��X�U��~�o�Ծ�n�|�o���8�!V��]V���W��w��.����p��֕6��pDu���'Ⱥ��b�[(�e�z&�Z����t4	�m���]�Q7��B*^մ˴��4xW7�����+@�q�g�LtZ��������DǶȒ�ONݡ�𷭻s:&�T�UM�Hs*L�OF������ߦ��|7R:p̑�]�%��fMbVB�U���ᐙcQ�J    9nC
��݅���!
�n��p�^])Ř���Y�E� t3�׶��n�~)�4q���c�Y��Mw(Z~k����U�G��[_٣���-3���/b˶5��.j�Ҳ8��$����{��л��"u��=`3��0���aaBM�4*%ͯ#$��Z����-?=�!5,6FV��*�ʬK��Q)g0FRNfF�0�9-��L�V��a�%�dB+���v��|��vMRzF�fڦ���-�X�5�����e(]dc��R������>�6��i ���J�97��=����K�(|�0%)�B��LzΛ���,�Ǝ9��7��^��x��g�.3Z�6�e�}�=$�R�y�Jk�ܤi�mv�~|�~\����)�7n��6W�e�b\�Dlȱ��d36l�.p+�V��Qԕ�h朦ma��Jy��e��7��>�C��t���6�Չ&7���[����ǋ�5���op8f�YUXd:`�Lk�3�Dw�P�j􅇃�Po��q�*C�S�ef�ǘ��#|A+�{dU҃� +[(>Z{0��0`�^�Ja�k��M�o�x7����~�� ���H�J�LR���I�2�����ه��TIOv�hv�Ll��Ȁ�D�k�^< �L�*ƊaЦ��{�a_��,��y��?�G&U�;��=�m�����@E��E��6�$�u�1�&O���,�-�$��!�Υ.:�aʽ��
\|J>{qgy0`���Zﲆ[��Ι�~��W0Օ�M ���Cl-��}��2�U��2a;���Ѣ��j�&�*�%^Q�4.�+�m@�"L+�gAVdc��)�H�-M׭�^j����Y��w�Q�p!��d4??M�L�d�95��Gr�r�
kS�Z4����|��MN� dNc60V���v/]�t������|�����Q��ɷ�e�/�Q*hn8?�I=��@|������V#1�X�ld����l�M��dX�V�'�v�xj6;��J�͎��~PN%e4�z��M���t�b�=NB# t4��y;t�X<���i':, ���ק�FbB�p�������#��舳(X���Ͼ�/��NPk���N��~*a�bu���������3͂�_N8�����A�C��pc#�5h_@	������:��X(Ƅ�ά#~�3e5�p���S_��]-h	��:K c+��U#�=zŵpD���GΙu[4�٢�1���jDe
�Ո���+�PneYQ����X�^q!�'��!�=�D��B��#��Ԅ{�+Cw����n��zŀSJ4])���ΰ���ڏV�fk���uLͤ�i�
C�������|q[mI�c�+%�'�+'n;�%�h	��X�%U��NLK6�X��;b�\{ιkr�kP�Z�Z7��$���(���C0�@a��`�5���tij:��T1ݣ�6�*]��Vf1�z�6�VB�����%]b�C.�&��F�k��v����r��Q�Ǆ�$�P1Y�9�K����MӬփ���5���ιjL�5�!�U
5m����F�<s�X�)��x�����&ȳ_�@K��h�Sa$Gq��е)nf�Z')�S�fG���:�Aa�c��m+1��+d����W��e��3�|u��|u����_+���2_��e��rd��_!���Z���W�|��F�/G����|���2_�?+���J������W�|�����'e>߿@��#��~������|�J��U��)���[d>���2���G���Z����e>��\���O�|�������|���|~ŝ��azN�
��������[[YYh{8R����1<`�梬�j�9ЮF��pNLUL��`U���^CHr-�V��g_@��Y߮E�-��rY��V��q�r�Tza���"�a���!�E�>me���;�Z���X(���ٟ�@�� ��j�vm���t��޵k\vˁ¸�:��psV8��^fz���0����e�٭�F��s ����r'�F�x�[ZH�02��'� ��{紽��U��H�ʲ�]��c���TZ���-���o0��-��!
���\R��	VWVU����$mB�!��H`M`v�=�@/�>����U܆'6�s�m#�
��t�������o�℩�ɚ$�4�x=đu���1<�c�阘m����r��^D�Vұ���/x��θ,(��8֐�����
�� �*�d̒��RsJ~2��Бҡ�&g?o�*��]��{sC�P��Y�'F��`�J�v�1a#�H|^��I��~N�
�+��)%7ؕ�AqC��9`����-�6�X���	�a��@������'��K[�����y�c����t���O����(�/�lk�p�0P���+���Ps�]�Q8�jF��r:��-%q� ��-�1�6�v�K���-��|*�=�lcð���0�����s��|~��p̦�RL�t�c�U�	T�6:C�,f:����ѴZH�FZ����D\��y}0����^M[i�N:g� ?�%�=9\Ǌ7�t"3�~���>��H�x�p`���49g�Ĝ��;����������P�������㩁���y@1���Lz1�7gFtn�؀��W�_���+\,�~J�t�]v 7E��h�-�Ɏ��yv�ޛ�{��/��$w��I��ѫAV��hz;3��^׎Պ��]j��ۙ�N�ƝM��q܃#���gfm�==:z�.'����D�o�s�SS�7���g����5c����g���	���~���h�Q�ٸk�ub��k4]�F'L=Oy��<����p�OH|�y�?���C�z� >K����c31�'f��4��Z���E��	+��9�r<��}�!!��Ji��>����������g3���֙����[����;8��<MpQ��g�x<��h���g����[�h�������Xİ����7�y�#����9�����3w����x�srH���a��������F�ֿ?�3t��H��ﲃ+��8�JL���.��;����x�sK����s�s��Q&�M8�A��KXl8�o?"�� �� pui�MZ�#���Wq8�B���30ʣ�!8!f������eD�.�kP->BH��1,#S�8��.yTg)����5by[��d��*z~��*�إwDQ+�Q�Ќ�:DM�:\H���LWQ&'�$ֆy\ qW�I%n��ij0�ڂ���Tu��Y�.�}'|+ �w�I���^����Jgz/֢Fv�@�T���d8� ȍ�#�b
R�+ʩ���Ș�2�o�&���{ ����RsDk6�a�0~�&���M�9 �:M ~��`��r��}5wz z>�4̙����UW|k���
�z���m��vy)) �c���ǏU�::if��^r{�+nh�;8oE�� %��q�q]t̷�º����]%��N��~F�Kp  ���@`���)0�[� �}	�?p��������ȟi�4$.`~I$��kV�n�hv�Pqpz .D�o� uh��s�}��^q����+�G�u������pq����6��s�v��r�2��
y�әǻ������[ڮSv�
/�T\�o1�ǅw2�������B�PZb�.�3t��ƽ[�{����Fv����s&nkV���[1]���A���~�v��oú�td��`�KiF�ߝC �G�]�;�ݻm���e���9�ñ�ZH��� �1<��ȵ(q,"F7r�L �ۨ�Pc?�p5F�� ��>N
�{ڏ�B�;G'�.���@6[<J�sw��x�q0`�H��6�K(�e�)�,���y�c���d�ʎ�ntN�^����:,v�w<�L�LH<,��z�`�5���4��"Ԣq� ��c^�����o��\�~����ݾ�Nh�}ެ<�h���;R�=A��?�Y�\.�]�?M�����t��;{� d٭XD�[��6N��a�9�y+w�}�9cP��`qآs*�'�F=Pj+��L��bI��K˖((�Y���n$m�a    wG�q�'�j�K;3mߗ��"&���i�l�����_b�l}[UO��gF��ER�/Y�D<I�I�$P�"!{eW��@g�s���x	��Z,G�c�3��[���?�����iY�vl�mO!y�}����xm�kat�.t��`��Q��/��YJ�:D����̚�4i>�J9��0eV��&fX�U��	�f~��xڊ�a+�0����Yd�5����##�6�}�����9l-I��ʾ����F�e��qX^2�O.g�3Zc�{S"�j��g��k���̚63 }-��F�(3�N�5r�5ʁܥP3S����Y�(��[u�]j��5JsFI����{@h�P2g��߶0���$#+�uӜ�Uqd�a��L�f}���%m���@� 㔷-motXe�vR�F��á��Y�4��~
�b=:`MR���,������B�e�	1����
j�尣��F< -"^��S��N��Оn��Ȁg��64�����&��sfP�
��32���:	�����2j(�#\:)�a����T�H|G���8G Ԩ��0�ƻ�s�1�~�Y9WS!�h��5S�Sꪑ�&q�~����0;h';t�9F��+�YFE��B� wP,㯘��b?7i�����٦�3�j�ZP]E�[+��휭{�:�ݘ���S�0����-[��:[����er>:� ��,)F�@ܸU�Z�>*]�R�� �-S��&K �mؙ�M��6D�ye�%C{��{
��{�����q�w����s�@��M��Xkax�/������+�_��p	�|�_�k|D��C���_�ڀ�.�Fmeq��x����xU2m�-k�_7\ Ղ�b�nd�������P~i�]��Jn�Gɥ�riVr�U���6�Z�Z�x���B�Jt@�ֽP%t@ �=@�T�3�|
)�xA�tCǋ;'#��;�w�d�_g���I'<�g�Y)����-�J���GBG�ֵ<u%�`�0�l�cL�4=悗R�#3%"%�u�3�I��K�2���p+�y��xv��R�pK	лV�NBH�ֽR%	`�0�Í��t�XJG�,,<��1�a��rWk&�Ę��&e!p��.�|��U�Y��1%]�D2������Sҁ)�A����)݅@Γ􊦋�y��ʍF���l�Z���u!y5ߝS�1C����K��l|�Wq�Y����ך�K�
ں׬Y��2c�5����n^��ኋ�׋h˝����~�kY�C������]�ª���i��f�`)V^}����Ne���(!R�{�%D
m�F�D
0^Ǹ�Av�Y�]
~��j�xsPD����Ba˴�2�)2W������#�mP�����%�>�{���d�(��µ�>	Y�(\�쫯h��+�;�Q��*��0��N]���U�)���m��JL��=��X���A��JZ�؍���_4���?��~g�+a^®��J�!�{I�����w�
��ž�siƹ������ם�R-Ye���򠨵6�_G�t*z��KM��Ona�\F{���D�s��������q7�q-5�Lv�<�!�����F�4�xgn.�_�4�1�cT�,{Nu�%/�l. iy"{-��/�Γ���)���@jq.3=�AYąW@ˈr�������yd�߲��1[�#ͬ�����i�e�!t>��RN���'�a������e7���S��X��'S'�Z���M�Ը���"���"D\d*�1��r���!,��;K9M�G��]����~�i-h�$��Y�B�f�vb�ds ֢��l.v��J�qm�����_�~]WU�_;d`-rl�Qg���PU�O۫u��d������v�lf����5���]���D0����CWcwS7���;�nY����3�� @�v�h�Q,��Ye��<;9u�r���d��NZ�BmqVʳs �;3̈́B&��>v��3ۖk��sbZN���}ZL�Q��R]��X��?��to,���}��H6R�U��]�DYq�$"]�j����k��t���Hӆ9M�j!�S����$%��yɐ�Q��L
x����pR���u�	�4�9�\�j#�����T�s�DP�`
�l�����ayX-�����T.��VF��)v\����@Ȱ��QS��e�n;�V�A��5��
��nA]����6FD볣�P�XD�Vm��u�g�!��o��uL�4]�	߆?�X���ʟÑ�r輕vt�-1֩�&�[��@;�k�{
?p���F[���8��Z4a��D�y�=�_9��v�t��&o�@dnITUP�_(~��3��kGx���/���C�v>��8��Z����)V�sJ��9�֚��ޝ@/�5����o�Qq:�}<5�a�_�BOo��3Wz���ǡ�+Jkx%�R��3�<t}I:C����)�a��az,�q�pk���+I`8���Ē'���wtf޹f�/��pL���GO�{�h��礣�p�gYMei��Q���p}	V<3��c�:3%�=gs�xq]�gg�������=����R-! ǝ���
�Ⱥb�T4;�IbQ���A|�Q�M8�ꚢe��{`ųc<E�Ԗ�(
Zt�Hc�{b͓I%Nw�L����u�6ԕ�.��0겹��!g����y�D>£广��0��A��A����L��X}��Q�En�^�g{�0��v���?3bBz���)�@���Ab�ʚߧ�yLϗ�����j_f�y4��&��J	��� ����X��T��{=��GQ^/7�c�Jn~�ju(X$h�A�Y�i���W%RL2����xhoI"E��ZW�U���=��.
醑��jJ�'�ZʏOyNG�0��4�$߷�#��b�Dd�W>�����Tn���kTu�	wdm��*��C��{� �c�?3!�&���S0��k�?�K������t��D�ߗOBm���6� �1��a�R�b�T���|H�{e=W��¹ѯ����=�<�$�O�u�E	��^A�	��݉>0<����H�"4rK񰲔�]$F��mr�a~81���Ҋ�vg�}~��K�-srzo�<l�`z����t����s�:�%�e�ah��p?�-0Y>B��/��xG0�X;䷂���w_S���t�}��D���}|dW��b�$1g�U
�O3�⻬=�a�8e�)��i{�����<uL������Ʈ�0�u�r���#g�	$��:���>�A�o�]�E��@��5���</w�w���sS�n�WP�݌0��K��+�n���\�܈���N��N��e܎t�vt7�i��9ѩ�	���ˑNA(-LC�:�?�n�FUg9�#�ȫFUQ�w(��6|
Ԉk���H����B8��)l^����� _@8	��n��`D�$��!���·�Ӛ��۔��8�w���ߙ��Ka�d4�u-`�[�soߦ������n5i.,}������&�]�)�sYj<��nR���1~Iu>𪎅?x��2�S�Έ=Bq)@�F�*��"�.�g�dA/�w�Ì�_��(���d�-�!�m�6�P��3���k�C�'ؗE�
]ЍƩ��CJ�K�����4�x�U��f�ogY	�����$����<��W8�v�1�UӅ���B��6V�"�VH�Y黝����\�����T�!|��]�\i��p��ǖۉ����G��Fu{L=5m�HM��c)��Ha�1V��3�&e�`�u+�h�6�`X,%��r��&�l��`��-x;f�fԱ}���gZA�cq�ϧ����Ey�����ߪE���z�!�^���K����tJ����ʵ2�$��:��Æ�A��I.�4�R�\,f_y��{�C��i��fV
EV+������W�Q�T�I7S�[^�-����Fi�m0����/9U�UE�Ͽy�+�+����0j��^�fOӘs�g���uF{��-61�>�Ǵтr�`�[Y�|�    ��T�Rq��-��'s>8y�u���(mHff�dz��Gd^%���I�i8�_�b�Ў�����GT]I:��;%��ϔ�=�;HtvQ�Mt]�9Z��,�T�q�j]ϳ�0�%�|r�����R>��k��K��XHiW�ä������� J�(}N���߰�Z�b@5�d�_U%�E�@��0�
�3�I	G�!
M��ñ�9�o��j!�aWQY�����vW�P:����ށS�+��J0���́����N������%���}Y0��3T�1�4��1*W$��W>_ӈH�	�4ri㎛2�f��0k��a4�TkA����:+�h���Q�!?�t�w�V8�Wr젦���r񶢃�����{�5���0�0Z�$��U��<C-ZK_�]q<�j�C�z����b~v���Z;ʰ+M�~��x���Rμ����fD1��9�r�����S
4�J|�f4;}�c�s���*y�h&ؚd>\'2����	�=yw�X�zu����8M�����q��,�Zޗib@�%ӽ���Eg�a��è�jf���2�ݘ�eg�8��_2 o��$��K茄������9(p�ݷJs��b�>e;���ޟ�i�]#�/�Ȅm/g�1 Ɯ�M?qh�`%�~	2%�o�l�ɏ� ��t��Q���;���,��3ϲ�IS�"���J8$���שp�ݦ�o	����B���w�����o�E6_�
g��t$����ѯ�IBV>H��~���;�iu����\h��kdl
��R�f���(jϊ�;�	Y5ᮗ�'W�z'���"ڙ������R�w�&15 Kw�ZOo�x=�xg�jي�R
EΝ@^����o���s�k�+�ͅ�k�+�2w�՗ZP4D�|�x�Q�{ƞϽ�>�B:���J�Z'VX�i�J����(6�l\-\Hj��C;�{�)�,��-���W�YAvX`+�]�v�tM�x��Jgs�TV�+G�a'�_$��Y��R,�覬�J.���c���j�%Y*VS����|
�H��^������T���B*��{T��u���?�0��:��?l�$A/��Eq�u%_R��	�#���@ p�i��=e�bu����@&P�%=�8Do.�6�Sު��s_dt����5C�d��Z[ɗ�����OK��qHR�jܑ�µ����#��rI_�pOT��Т����Gt��ߝ<\�G�;�h1D'��/T�$��u�L�
���2R(d&�[�fH^�NGP�O���˱���hI��~��E��%����T_�7- �q�]+G��IޣBQ�'}���(��}�7(6�~����b7f���Y\���|s�����b���k=��רD��Kߡ$2
%i��J�;�{����'*fE����br���䋓��Xx������5�Bt�cC�y(X
w����T�Ov�N,(�}���i��~���qS���\�qv��X�lJ=�a`\�lR�<��M�uD��W�í$*K�}�]}X�Vh�����=3[����1�nb���G����A|�"��CLx7�:0S@����Ǽ�_gE�C�*r�D��t(���O�k���dJ� cz25�ưP�\�l~i�m%��K�&0�>��'����ֆ�/�q�kR�<���\Ժ"�a[��5x�:~� �v�����W�l������9�П��ɬ}���<e�;�����y��)�7m�-s|񪟴m��M����ۑ��.fۙ���n�ח������h �VC?���:�T���J�씦����{��c�Jf��{�������jD�j�1�Pё�M�.��!�	SVλt��b���ue�ѡ���T�(k��e�`�^��;UQkg��`"8>����ڶ;�#�s��fĶU����3�To��7GI�b�K�����R����J�����x<#c�����R㮝����֓��D"4��j_�Xf��nU��J.*�В��J
�-���׌��$�X3⫖Ǩ>�h|�B�Xg�1�V"������p\T+�.-��zs$pK�����B͈�Z&"�4#�j��L���\s8��H$(c��[-��er��6|^��\B+�󖔖�ۀ�,S1��J�d�b�畊����>��I�=M�R��$�ʹ�%z�K�gׇ�jJ��V2W�$W9�r乙qx��>�W#Ћ�C|5ҷ��ZD���M�b�_���h�Ó�'I���Ք|c���_��5*W��j-��k ��S�PқXs��ЮޣxXR#8�L� D�8��8/��cQ+�3�5�a� ��l����X$�=�ׅ��l�h �tЬ�(j�(�~n6]@h��|��lR.��A5֊@o^��ܼ��1x�qPu"�?]�B����ڮ�P�vB׋�������@_k� gÄ5�սO����� ���{Luu�A_�BS�? }1�PC��X�Ưu]���ͯ��ͯ�zL�����J����������n��s�x]�����PA��� �7����(�C{�;�D� ����Zqɵ���;�='#�;{��^ ��@C{{$L�=1/}	��Q-ȟ�:�	v\�z�iw8
�:���	�[����فOr�1�-ݓON9gx�G��arL�Jږ]�G�/�
p�����9��yi��S/�Q����ܻ��շJ��<��F�' 8�	�����8'�O�
 ǸB~b3��1����ԉ<`O8Mv�^-�&;�ӟF��8�A��) ���?���]�d.d�� �q��D:7إ�^Ξo��B��l�[��Fj�0�ҮrE���q���8���+d�� �q���ܳ��}��'��)"w�='� ���iZ���ig��WY�E &����䁎ܳU�Z�
�g�+dLv�^7t�݇�3;��pc�p�>�fs�5Q�H�+��t�'~>y1�Y�p�ћ�;^y�I�yD�E��U%����w�c��h��Lw''$9<� �zv� NHnx����Ȍ NHdx�������vfq;�n�h���/dlx�;����������o e�;�0���/�oZ���x4;އ;]G[#��� A&�O�/�ox�;�'���K�r5<� �Nvv9�y���t��C���&Zpv��gv���>�Ig��e�\S�+z�P_ơF�����W<�Or�z2�/<����Q�ԅJ�D/�%�M�F�'��e�䤣��C�ʪ#~�1v�4����l�3��(�٘��_<ܞ�Nn��D�l�l��2�#��A��"p e����-*�Xd j1���B��}TH�� ��Ӎj��s��=�$�x4Bv�\�8����B��\@�0PЪ� \�.��+ ��j��7�-�c��%r@cr�Gp�)����CP%d��: c���sF9P�3�F,6Ѧ0B�c�ar�����(\<��6B��>����F�L
�a�V�Il�1����nǼY1�`0�����N�6,W5��=aD}O�QU�.�T��j-*���(��ps��a�6�q7<6!���@7xą�� ��1�:���B�ƣ���FХj��BI����/ZH�Nm�v�tZH��F�M5����ۨJ�\��#)t�K��@in�
�#�t�M\��T%��X� I��[�[������C��@7��!���LZ��5�
A�Tj�V�],26Ѣ3n��@/����p�5}_QF hx ��r(��F`&Y�H��v�kp0b�-;�=%��9V�EtG���ejĂ�eP#��$��HP�H�?"�h��\��[\�ȯE?`����?�-y\R�"�1)�b	4���B�c�iʘ�W�c(�9��N�R#ξ��ME#/U1��s��ݻT���ЈAh�����0F�"2	���H�� m�-_�؝�5������q����寑*q�y6q'������F@���n��/H8I����_���4�6#!V6��H�v)I ��8�-�,�ޒ�l�����G'�T��X��,�T�\�7�C��
aVc����Hq    �&�����YIJ��S��J����q(� �2m��s��L/-w��)U�NƲ�Xa�eࡥ�P�f��,L8o��da��<6�j�1V�i��Y��p!r,�--�TY
8{������Y��Tq
��3�I�)֬8�"��ty�Rm*�d��`��uX_`	xTR�*�b��U����?M��(�~�|��V@�x#n�yP�ʝ�YC5�l�XL��/��"�5��6˧��<�����ݫZW\=�y�rԳtz��)�.��(dJZ�t΁�U����Kf�9�g�r�U��P�OV����3��y�Y'��L���{������a����׌��b���a���bW����Ilc�i{�=��ꤺa�θ��U��$p)�>g��
��q];x�R�1�er/	Kѱ��Z�� s�{G)��@(�_���J�OT�3�M3� �;T�-�*%����J��#�d�qo��O�[�j�'Z��T��k��y� k���o��r�Jh@Ǹ��$eF�[it��=�T)o��nS�����_ýb��E@����4��l���l���u��{�<J����X��(U�Lىe�,u�cq]6`���e��jӸ�V~M+S%�R��v��p@��/�Z�.M�C��N����q�4�S����]�0B?�JW?���n��в�AB�*t�Uoz���M�]�B�j�7�p���9<d�]'����>�^y]��Z�xɻC8l�&ָ /���������M �ݢ�}u�yDXj�{E�����Dl.F��'��'BDu��Dߢ(\���>�J�v�qzv�/-�T��t9�7kpoi�N:e��:�}.�b�V��n����Y63Co2��ן�L�=]�!�8��h���fw�Хh-�����[B�R4���C'3�B�"��ݮ�=��$L��m=ʌ�ק��[�����ٕ�L߬O)��2��K�"Bw8�x,�.J�"�ZF��M�@�hL$�O&��2�]��TV�"TL����]�B�"T4b<�:�}+�.E�h�|�t�R<�"��ke�W�4�p��II�TG��E���C�V$�~��	�"Z܋�w����RDKv(̧&�[@P�n]�(��h�*�_�6MRr�0��N��@�9��p"=&J�&ꪪ�B���wj���B�������(�����&�hQ�{�-�|Ѕx�2C��@��^���hJ"*��qa�[��If�}���1�"�� ���-r)���z 4���C)J�"ÊZF�FVd]ٝ���tE�����(4fd�0�>)$��R���qw��Ò��p��o�i��r,����hp�E��D8��6*���"В�M!2�9iW�Cژ��}۝���$���R��.`��E׷e�X�c(J�nc�VF�6�@�����q�����'�R#2�����M��3�	������:怍4�B����pX��$�{��:�����x�`�`��wB�EN��/E+j%܅ Oɣ������M%ɺ�g��b�/�@�-��e�L04��9}a�s��	a/�z��ђ�f>Y���40`6#���?`���m�,b��[��.u�ZR��{�>g��HK�Y������2����}n�~�٘8t0YA=s��W��� �^'/��'$6UY�ن��;pyE�ny�I�Bl�#ل�>O*!�"Im�A�Ȉ�y�,+�T2d� #-�s���X���6ךN���Q_��YGH^���z�y�r�!T*�W���F �m׫hH��'�_�<r��@��Ġ�6�nBE3��5�A����"ɹ���1\,X�|���0�`��*�5s��	�1��^�\�՚:7H�C�t�!�����%��GV"k�=X��i�1R�eg%9;�5��Ť��"� ?���<X�����Z�3�O��"����>Y���<���u����%<���<S�����I�E�A~@1	?R�Q_!a���@�}_}}�:v��?������߯�~:�v��X]��Q�8�,Y��Z�_2���2�:ҷ78��[�����{�f
veE0���U��L�>@Z��R���� ��z�]��{�����痞YJ`%Y�h�g�=AH��[�����ݹe�]�;�c	�o^�2F���c��߿9r�����<l������:��d�6���:a}z�����:zr��׹>�́��_P��K�)N��6#����A����?��0�U����.�6��#���l!S��6�n�Xlaf����_��g�,�����~�:Y\r��t�
ZY��V����a��6+?�ҍ��� a�W������^#@+���d�B�+�*����S�/�V���Q���K*����k��x�)�mL���P�?�!T�*�/�^`�ʂ=�v>��c q	� E7�G`�Ϛ�D$p�gϯ7����Wz&��)�O{
���T�5G��xIs�|���D�-��M�Td�@�b�3��	��Ɨ�Q"�i3���w.�h7�������&����F�5e��ujcXe��РU�DE��t����|:R�Bb RR��p ��::N@�"�-�UW�&����&P�����SG�H9
�JhI�1�_t� �Df
���Gj	Ԥ$��rԤ0�:oj�)d���P`EJ^M�)|�A/�֌�DH9�Bnk4!BJc�0<���Z�:=)��x��z���Y��������Z*�$�8�H�&���@N�jr�@JJiH8�@J�gX�e@%%3<K�&��W8�H	�U.�3R\���jR*k����c`Ԥ�/� �04pV &�fT���������b�+}�v��ր�IY�C$p �&҉����:�6���EI����GO
Ԥ����#�)���c_`HJp|\@�LJ�0�!K	D�<�pk:Rk�WH9�"��0w���A- V~�I���cCRU������p@����@aR���8)�!�$�2,���̚HRBk�8H	�g���5K~�[�����50 z��^J���>��J%��fP�e�F�D�sm@��C)ӵc��=�W�|�	!�g�f�k#����(�$����9���'��C�|8���*eK(%�����4��oiX��� ���PZ%��u�Sx��UT����]^V��|Ce���G��� � f Т8�f��A/�M/�z&4-��S�h5PPA�Y��Lw��$�8����/m�It���wb��T��k��g�:8!�.��������(bd�s6���*a�Hc�a��1�[;�89�����]�|}"�a�/�1B���q#��
̡2n12�2�K�*�V���'y��L��k�d����e��m�8j�!ʹ]L������ ���4@2뚪�]�M�����k>i��v�.���qn|����u���1�ټ�d0 B�9\���HR�e�8���_$����w�4zAu$ҿ�YY�#�JY�����u��ɬ��߰���Y�3��`���v�.g��C�1�NhL٘L.�
��;$V���R��5�&okH�pG���Ng2��Ҿ���>.�C�:�����.�t�HC��� Mmȩ��A�r�E�Q(`�k�k8�t�gk��tl	Hz,�9�L�(�ܐ�ႤT����V���Y,�2# �zb�㭑�#�Vu`r�A�r�zs���<����
�7=��P*���cdl�B��7��Gp�]X?,�F����훿�Vd�TkR;3��:-���@�t�>I��O��fP@���~d>M>԰�ƽ��x�E3S��! �&V��O��+,���;��w�S��%�V����^��3R�<����Ի��Rz7;���*����c������(zn���%���Գ�ٙ�Hy�O�PeR��	t�b�I�� �BX>]VD��!����C%�q�֋w�E/U� |�@=!�&=ؾ?���S.k����.��W..A�E��L�W��o��P����g+���9#�i�2{���H�9M�K*!�{x`wj�Wc�UK0��%�@�J!��&ХR�'Ib�Tb�i:MB��    {�.\B������K&�S%_`
��o�.x����4R1Ur��{�&l�f +����v��L�3��:���	��l��oy��͂k.�J������l�����X}�^�
x��W���^��A����J�?ME�|��|m���b������
��ik�{�1��	(����vi�_"䞦���R���*D��.��0�!m��L���FÆc��u�I�>�	Q��DwC	7���b4�w��>�A�e��D\z�
�d���l��8��*�Zx?M��6�d��&����:*�t�L�$qA�1��L"g,�	8{O��˷9�ɷW��,U���{�Po!Ԟ&�l/��c`p�'j,�_w��'G��"���Hx˻�},�	�z�;.���A���f�t�����p��Vyo[f�^%��5�q��_��M�tQs��rX@�s�^��AkR� ~���xؑ#X��Z�Z�P3q�lԹ���d�\��y �"��d�"�Js�?M�M�_�O����%Ŀ�t�#z��ɇ����m����YN��Ӕ!�c�7<�#�VyP6�/��<<��=�h�����͋*�`m^`O�6{6(��5Vh�'G���#�{7r�O� ��Ư �*�l�L����Y��U7^n^r�hņ�ך����D��Fp�\���($�Va6�4�6��
���Ͽ@%��"��*�o�ύ %�qM��_�+�55I��! 4uZ����m�7�'~�f��P��{�X��"�V���>��
+$����_�����R����u}�D.��;~��O���������LGG���I�O����2A[SC2I��§?�8�����t>����Ǳx�?X
�HC��=���)��ц��\�{c��}��tl�B;�3�i�|z�xt�	~���J?�|f�u���"��`�u?IE�Ţ_&؎��C����0蔴�E���F�{!�C�?p�[.	��/G��;/wT{T�HV�I䇅�Չ�R:#+ń���r�U�R�Y�GV��ㇹ�Ǳ��[��;��5�d4L �O
��~�p�$�� ��h�C���>�5��ǻxD
�z>��<B�)A+��hi��ƪ�`�J)ilo/]���L����v����^A.!%Z�E�h$Q_ʁmq��\ &�9Z�g�"̈́������	�h��s�ϣ4�]���eI&iQDqol��r��2Ak �;B^Y��&d��MrV�	y��껗W��큐�RL�wz�T�ɥ"M����L�+ӷ+O��]~]����D4g$L�wC���J�$� �q�wq~���J������
mL�k4�C<�R���k(�:�s���Op������Eɖo�b-�p��7{gu{iI.�J
74ˋ��H�|��7�ȿ��v�G��ߣM�XC�+#�K��J���96���KYJ�QE��bbbgd���\8���	O�W�;>ڬ�4+m�h<iV��GJ�]�YiQ�w^)m�D���H��y�\)�&�4+�Dz�PĻ��p������wo�V����EV�<ڮ9��.B.k��n&/�\��D�C��VJ�cQ΅��L�r4���&��[�g���b��#ƀ��S#l��"n�aC*�2/��V��{�68��}��{(�0l�X�"�P��A��"p��r�va���Lt���D������u����v�-tF)%��������W�&����f;���
A���v@�9^O�B�9��jI�:���2lK�vԊ�7��=���%B�(�Z;h���=�^����V�UD�����"�XD&�����C��c`
����mNG>�����t6�vZ+�����2)vbT���}��p8��j�s�]�x��Oz���ƚu�L!�OgA�׋��1'����tt\�Vh��#�ޡ�|��#+� xs�����#8bbA�qԳc�E>;��L��� 9 q�>g��(�x��U�oQώ`G�����`�X�'��зH�Q��X�v���EC$���p�d���(\���,b-�ml�u�����T�T"�Hf�T�(����t�7i�|��*t��4�g��R^8��I���}����-]�V�p�hN}by�@��ԃF\pV	�VƠ�ˋc/�}rT)K�^M�'<2m����[�K0`sȱ�
?�`��ٟ����zs��-+~�+�=�ۍ���M�~S��9^��z%� ʬjUO��	[��Rh������y븡}�k1�Z��v"�l�O���A#��'f�%�!��H��=@��,6��c�w%��'(/D�����o|q�����|��6zN��U�OF��E��+P��AG�,.���H)̳y��?o�m�A<��fQ�6�Ψ�D߸��_�(�(N���9���팖�q��/˥ډc;+�f���Jb���"���2����|��~�g�l�m�}hQ/��Y!�O���MoVy�08b2�/���Ƽk��l���
��~�]������c���m��m7X8�3t��ã�n7��ƪ�jb�K��RE,G��@ɪ�>_�IiS�*�":i`2���ލכ��l�j�P�&�.]ҋ67Q� yą	$W& �	~%p�Ѹqoc�MJ,�/��T[���X��e�d�XCw<����D��Cl�Agl��I��c�B�Lұ`��	�  :��m�~g;_w{��;rB)�~�	J~��R��j+:J�[��{s�/�]�cD�}�б{�齙�Ǒ�j���+1n%����mTc�$`�0�J�v��<��vyy�qag��vyi{����[�姒����G`�s��E� ?D4C��T4B5�WÏ��Q���)x}�0������a#8 ¼��s�|�U����V����S���� �Re1��6��UJ7S/����?e�"qR�!��H�c%��_���Hv'R�du'�l�� �ϟ��������Ε�W����|;�|Gڨ6C^��9��g~�ѕ�Jv$9o���֧ϭO��abbN��v�鬞��9*�6QM����RJF��{�3���m��7��(���f��ߕc�۞��OQ��n�ָS�$�<Jv6}�� !ĨN��۔B�L���8��!L��܎���
h�e@���䘵�D�o��ý�_
6P��������R��zS���l��fb����g��Y?B�X�N86��� ����*r�_��@�b�![�>M�`�beN[�o־/�l��������ˌ�F��l>��!����� ��V��G7 �۝:?��~���c�C��h��MXgn^����{ת}/aY|�Dc�2�XH���]_�4]������΄ּ�+��3���D�s�o��P8�����U,L
#\&�xSy�r���)����ˁ���"=�ig��M����JO->�5��4;�30\�-w���'�ϻ��Ƹ�	\����P�Ҿ0�*�t�����(J��Bo��?\��ťw��ԔC�=b;�p>��DX�V��`�N�c�%��l�P/�Sl�����jG�{w�r+��� �����Q��ཊ�U��r��N�i�o��$��AC:�v��II�;���oVֆ����ۻ�y�	(X�A�w��il�\����gec�s����qK������X��Q,�X�Yo'����q�K�l�# �<@z�c��y�Ћ6 �6D0���Y�8�Y�$��:+h�)�^E��c�y^�u�L-�&�(����y��F�O/@����V�U����V �_d6'\����^n�Mh����)dѸ����R˚�D�
4��]w������A	Z����V� g9�C�)��CZ#�7�K�i�����hs��������+d�Y�)��E� �F�ڤ�Y��A��t��/:�����'��9������D�U8|�H�m&�p��=��&u�,b
����8I5�#��x�{�IO�Ǜ���04}�z�C����|��J��V �k�4���}5��:QK�@B���+t�0
c���� |?3O0PO=p�{5�tת�����I��*�����a@�b���.��|�T�$��:�*��!`�E�    y>�F������ݮ�R%�;܃_��SD��c��r��|���� U%PI4��O�����R���������eg��������*y��!j��������g:u蔪�g�A����x�Q�Fnޝ�^{@�E�*T�� 0��4�ѵ�b(�'l��x��`���(�9���Z|����z��
�;���cӮ��<����	ޭ��ծo	.�|�#���X����?����GUl��N��*uJb���I�J�KX�]V?�h��@��`u�*��>w&:	:U��e�i�"y�;i�-AP�b,�,w��$�A,5�H_ɥU�i8�N���Ց�g$�O�I^e-eU�)�t��=�vc~"��*�J���Ͽ9z䫓GJUp�����9hZ��x�qS7Q�*��p�s��4~Y�&U��S,eX�Ф�ˉ��eק���$��b���ދ���ݑ&8�2+4��$�1B��y�@��9�#�Ha%������J�=śT�9@�V~%Z�����!w.���>�KY��FԹ�ˇ��^no�Х��w����l���	ju҂Ć`U8X�S�%�:���N߉�R���-/�NN�C	�R�*��y��5|{O�s|	��4
9����u�Y1�5�#�)��~pk=q��C��;0�mV��/���kx^�a~)Ĺl��z ����BkM�ӫ�VH~�G�2�J�ٞ7��@<��D��x8,R -�/��A��ssu��0Jxa�ϣ�r�1�p�/�q�sT�Dթ��o����w}�h�!�� ���D3�}4vH7|�{����LN�tg3lc`�XK�,�3�ɔ�BoH��������I*�Ґ����W�k��T.�Y+���~��,����/�x�ƍ�s�u����]�Ð�4{�C?��{$Q �S7ۊ��V��\�k�gz�Ǩ;p�yٿ�zu�택��T�w??�\�^���^!���;��[=E����v�>>U��S�\�\�W�ť~��N�Tʶ}�E���U�H�����\l�-)E��~F8ٛ�;*�v�{�w�Ζ?Ʌ :X:�	%b�Lug����t���m_�.�a��Nڝ���~H��X �W�N:�YAn=;Y'\��ݴ�_���J�[�J��?��{~}��%�n�vǙ���+���+�l�q�O�Ov�;~�Hfy�!'�Ry\c�Y���8��J�ձ��L�w�+���t����R�n�iU���n��p�����Ϲk�$6�����<�Z�0�z}��~#��}�:/��[������z�;�r�m�Cz�ֈ�J�����S-ϣ���/JL�Ú\��j��WlAYA�
�b�c7.��Q�/lE�v�H����нAp9)Ko�����l	�7�ҨL��gSK�5~!�lL�z7_Rr!��M��D<�|�����[JU7`����zW��W��ߍ)�}��Y5���(����t0�NW:��*�]D�[[�A��H���mnw�1�e��pŪN�콚W����VK�� &�m����=C�վ�ีWTj ��:(Y��4��������<
>Jɘ��`�o��PR�4����=�����>�g�>��}(�[xvU��V��!qX��a�r�',8���
] ����t����\��=(J78��G�7���:��"mM�`�r���L+`���"���>���
wH�U�b7��j��:0�3qޱ؛f�.H�,4���:��V�;W��o��wx<o4? ���]G��@ݣpi�E��E�~�/PŋA�<�
��������hR���`l�k\�J�w�s�����2]�4�4�w�U�O�q�ژ�R����@���_z��QU����<$H���� �%_���`=l2�f.-��Y.wE�1����<rڸ�����/�����&�a�㱛}��Pn��y?�`+�P̨U���[=�A�J\%�:��r�6IR���w�� �!�7<��l�=�b�	~@��`� (y�cو��NDaQ��,� �SY�!,��a/�x����5�_�.`����^JY��u�"��7��cY��Mw��6�Ξuම��v��K2ݙ:����N8�N�ٯ]��y��W�x�%���8��	��|�--ۀ#skչ���HDm:���J�u�u^'U�-:{���X��ʻ`���HxJ�<�J�������î���0���wp��7�K� 5��p��`oz�::\���-�&O$VCx~��9Tl`#41 ��.L�ݻƺV���"|BG�H���FCꗘ򪋋
��^���@�L����6�@��_��..��ڻ>�1�����{�c�� ��,?�&�������p;}s���_��2į�+d��Fj�L��/�ECe���W~�g�������B����fwnޒ�{BЗHi�dEӗx"������^�;I��/��1%3$��X_�k�h¥���K|� m����R���DN�7o��xm�����_�3uO��,���%���E��]�@7��^t�R�U�z�pN��!�'��%rBV)��v=��Ⳮ�g���q���Ƿ'�ػ�.{�GG����#�`�{ ��x���_ɭ��"
¬'C��aSe.�b�� ��Ցgc��V*A[p����?�,r1B�� 	d^^�c��7@����@���D�y�!�'�y����|r�C �K|�'�>Fz�n'��i�p�DLz�bb�M/1���9���$9�J���!�H�xۢ�Y^ؚM�inǀ���/��wd�OX�T
Y��km�U�w�8|k�����P*	,���Y�P�%�al0pP��:7��Ħ����0�" �Q��0^s��c�K�5�����Z &4>�9.�$%�^����v�HpCoɖ�'��H��6��^����K7Q���km�Ut�8|3��%7�T�xؐ�ii��w���R5a�|#D�ġ�=���K���u�-X��QD��k����V��!��.��q��n�s3�+i>��%`����<3ZLg
�~<��"��B�V����;��R��D���Z���]\b~�"������"6�F�q�s���N�g
 b��	�<�d�� ��upɆ�����'�ݬ�%�����G���g���\�S�l�����L][��|�ד��2��\	�bT��cv��i�,�`�|b�����@��I	@
s�����ҫr�nB�?^��82�ʣ3�oz��	��7�ʗ U$�ܞ���e��D��y��E�S���r@Q+g���ި/jҋ{����᜝�����&r���`��p�Y�������<���u��U��	�o(�a	|a�&^���W��I<��&��~�L'�K9��X��z<��e���mS��R�&�5YpeA����N>kKsN��-��T�2�&Xw����/���ـa/��4m�(K��R��Q���-:��z�hݟ-�w�+ 1���x����}�9�L�'�]��فq����7�s� �A� �#x�y������{`�G/2�'�i���w�N����twiccy�%�H{����A����-^K�q1ZC��w�e��ZCきk�gp�^|Zy��ݹԳ����f�@e���.?�^Z�UY[k�*3.����2ڶp%�Q�?޼�&�3՛�V��|u�P���j'�D�q2ٺ;�w}\"ko
�e�����z��H��I��^��Ѻ&���/l$����?F�oR.�L�-�
A&�׭�\6=p16�wwբ��Bj+hpo�:1�x��T���֧�`����]am�#�?�Z�8�\�֦�*LT���\�=DU�w� R��8V���3I[�65է���W�f��B�͐U��fU�3l/�	�=Ѩ��q;�og��(�5�p}��n<Z����[�K�ژ���M5��Bo0͵���І������CL�������2�h[�gP��x_�AV��H�����>�;���U�;����b��p=�_`T~ro2�_�^�X��z4��F(    n�nP/ޔP��k6���D6��.��O��޻�#;	F�������ivm��\8B�4��K.�[��Ȯ\{?:��3��*����e�Beihه�%���>M�P|\���rg������%�S\�b���r��\�%D��=� ���A���J�x�����w��2�����\���O��2w�}�軑[;��ߏ�o��es�y�0��@�r[�����U��5�'�5aw�9\��N�V�d1j�FB�cõ��A4\7���h�����>3\y_��|��#˴pI+��.s	��3xuI&l�A"����.�3vo*�ȴ-u�p�E�!F��J��l�7����C�����V$��V�C�v6�B.�
׵���/VA�l��X�>��#�)l�5~?���OA�ܾ�nz���eT�:_�������w����x��S��>�C���׸���,�c
h��6Ӹ+@�OQ�
S���c��v�õ�o��m�nM60̹��I�ӶĴ�Җ*VcK�i :R�����Όc[	v�4vg���dG�ȯ?H�����s��y;�ICz�Tne12%eu%�\ƂP���I��"�����Pݩ�Zp+wQ{��d\�Kg&��"�M&�g�ΣQL���67�
���y~�9{��~��B	W��(�����=/m�|�?So/S2�X]�Ti/ �E.[�uͤ2E�a�2���(N�T��_�h�[��5�k|�>rs��2�U�Ε�dN�IV�/�3*��b�jg����j�O���?��n6Sr�ጧ�ֺ�2�v]��X!��pkK�Π��/Y=_���D��F�G�Ө�����4�8�\p��6Szr8y�@<	�,R	������+U�e�\"���rXh��j�S�h�X��3�0��RC��!\�
���h�)&c0��n-f�@x),�x1w�_ |�@e���~��U���-Z��㡚U~IA�ʝ��Y��{}��y��m�|��?
`���x+�^��:)8.Ȕm��Uy!Gt*���kX���<��	��T�����	���>�UԱ�s+���I�W��\]d�X�*V���L�IfAK�=BZ��UQ�b��A`��Ӳ6jY�f�?�L��iYpa����2�v d[Zt%����nSW���ï%�K
JŊטa*�D�o��URT�x�tú���U�G�å�������l�6�B{��q����֧��ŏ���n�kNZ�*2��1���۞O )"+��J�c���]��3���������I��*�.�nzm�-�1�s��Q�gM���!��EZS�FC5���hQJ�{I��i�i)�����̤A8��'��5��;���Z�I����X��}[d�p����_�Z�ս�SC�d�Z�
 D�M�~\�W��~՗�����+���{Bq��R�"���L"o�k,&O)�����x����j�t��(X�c$�SE]���f�wN��oQ��ŕ�u����EA�%����t|<��F�Q1}=�S�w��9x2�skQf��ly���^��E������]��Q���m�` %��oq#�s������I�V���a�H��x2�!��;��W�n`�(%��~�<^�g��Eގ��r_��/���)��Epv߇�W_�f�^}��
X/���nmoЅ�������b�<5g�yio
_���r�ܷ����upsPf!��,��7������z��=�6�*^�ST֍�U�d�go����Z��1��	�p�0��f��V"W'�$`��O^��Y�euGP����5(+;0�G�?$���]/沛Ç�5/b��k����3�EYt-!����A�����2u{}+g�������|i�
w�S
�B�����K�K��t�-/|�5��6�%@[;x�؀B�:�-�#���C��D��u"[/ ^��S�EG3FP��[�F�� ���C��^ ?�,��/YI׏J�r�w��B�;�볿�%�����D>{�>������v�~���G��%��� :�I8�w�L"�D�l��No�d�!�S��7�i�������#��9D'���?�ru^,�w_���J���ϛh[��mp�;<��wջu���Ǎm�~'�+7���L&�
W��xy�0�U��*\`e�
7� Ԁ�:j%m�6b�;h�N�nl�|���-�W�H]�Z�.�DU�����p��c'��bfAc��`��!��;��B���)"�`�9�8B��,�`^C`מ�$�А�i���m����B��ۘq��� L�bkd�w���TpQ̼!�{�g��v���&��y!%ﱭÝ�a�id�No�sNΡ<�Lׯ�8����!��79.rj����T���#����[�O�������W��8O���*�� l���S�) ��S��&LNݐ9��Mm5(������Ǒ���7,IFg������'o������o�m@BIpb���O�,�KŅg�<Z������ܻ���HS.3.:�h�!Nß2���k�&;3�	�SM��΁�R6̤��x��8cg;άOem�om�ٹ��l`�xt���V+��u�#�<��Q8��+.��T6����;��9��[����9�Ou�R�J�^���2�j���~s@�At��J���~\�vO��ŬIXNG"�9N"��}��)��3�g�]gؾz��L���}��{X��z��v�D�_����?�Iu�YL�����o��>�m1}�ȥ�[�n�*O�Ƈ�n���lS��i�����4�mϝI�˧_�D�}x�/>�Ʊ$�:3�p{�K8c�~C��W��N���;�g�0��}2G����ۑ������K����v�ag^�gp5���3��k�4��Nd�Vwfҿ�Y�1�Gצ�G{{�'���ŉ�̟:�����4��J4��d'\!��N��o��jSܻ����)�S������hR}�	��gh¸>k������x���	�����+�T�d^g���=a93}.y�����g,�Ƽq�f�:e?1pҧ��)聺'-gKM;>a���_���mMR���Lٍ0p��N0_&�%v�>̕>�Z8Խҝ��Jup����C�xK��4����I[����P)�:M6S�� ��5��W���k�(�W���ڻ�3��V'��c�!G<�L�{s~���!?�c���h��Q0yY��|�@6U1�������%&����?�� ��ՄU����T��~�[`�|(�����w}�y���}(�� �ػwE21�՘'�;�kU4_�u�����ʥ��ռ��>]q��X��G/��4���BMTe���78�|��E�3\]��#���S�\�/MN�pWG@p@�w��#�X)P�7P����j��kH|����ӳ��z�����{��Q��!ٷ�'�w.���)5�}݀���ʰ)u��"�u�ٛ��V��W.��ce�y���3�����?V.���ە����d�������旦&`�x���N�ژ.��<T/��\������/�����`�����2�-���S%j�V)���^���<�1�R�m`h�_���,w���,wF�+��>�����S�.�]��?�9͋�=ʴx�ߙ�������0+��4j^����>�/�3~���Ӝ��6���Va��?�sa�MO�:�U�V�z-���z*D��՚��wn�E�z����$��H܇�6maS(
"��[�K�0m�
C���7+�	T;���Vaz�pA�<X����
�2k��[�)>�w/>ݙ͈}Û0�V�z[ �~ZD+��F���-ۡ�2OOy�į���A��]�������G�X��H�Va���0W�c1���M1QY�W�����1��})��)���=�fh3}��k��w�Vl�����������T�N�Nʳ�q �#�ń�]��8�o����<�]���z�`�g����]v����o��������,8���@j޺�1���æi�EçY���	SVR%����	��=;���a�s������l�G��.�����)�ޡ�    gm�xg����]�SI;�a�;��u��X$��?�s���	��}�y
����8�<��:�����n���ɞ���mg3>�����a�ľt`w���Z~�)���V�,�Hv���Sip��Xa'��2�}{5A��^�y�}��@�Iw�CڠK�c�3o�Ȥ;]&Va��zPg�gɜ�7��Lqxs��5`���2���B�Wh�"��d���q����Iiش�bk�Y6Emk}�㌝��p�F�Dr�s��Vw*�)����~��@�ϱ;�.+Z�u�LU�0H;?>e��aG�53��&�,�:9�Hfm����r[��d�_(��M����Y{���dKa�:�p y�g�;g9׳�_"�c�Ӂnﰩ* p���	CM��/����(��z��[W"EO������Ob��4�=yn���{&B�Fa>�T&�%���tgs���:]^r�>�s4��%��n�W|P7WXF�K��S���r/{KN��?Oz��p�5�vө�L.�Oy� ��I�;ϯy�#L���lo�]o.��+�5l����(��x)͚�>�iLg}7h��@5a��Y�.���>���a���R)�������ï{΃�\s}0�Tw��.A:��S��c?��+En,���1\ʰ�'e��a���Ce��g��˹��X�������?o��"~[�	�l�Y��Vo�%���	�[_+PNp��ʾ��-���S��z۸R��2��8� k]��z�+���"���(��=�����}]M>�|WÒ�z*�@��[�q%�a�Z79�2&/�����|�0K��������V�����HE���b�3Q�J����a|����,fn�DF4q�Ɗz��� f�Z��E�'�n�b�� G�-�+u��6�2�tK����绺�.�;��5ah1��Ň�C�cu�ڼ�X��A�ي r��҃�̘�r����vy�5�����|ȱ��;�������g!�:^f�nV�2�4�_ ���n�L�ˌ���i\cf-��?���"���O���pM�*Mx�9�v_tucͰ�m��{�_�}����;!��~����/����b��d�u�|7:.�����YINw�; �$��\_��߻5!	T��/�;L�J%�3^)�WK�Y��"5�{��"A������hy|y���ݺ��?P(�D�#gɔ�ɋ`.,���)��]��`g�Zl��(��7	}ŏ���5��yp� �?�\��߅�f%�Ή K6`�s��W�#r���݊�����gU |���Xq]��vV4�ALc`�e�)��k^����􁱏7/��}xY�+���������ĈU��Q]�'>��h�S�<���|�M�O	ro�[*�Yx%
/]m��B����Ms�L��@eR�����{�f=Z�Y��D�����k�D��g�$�P=�%��xYl�lp2�p1�Y���>7���(�B;�:C� D5����ݝ���V����w�+��+�K;�z޽\���ޣ^���?=�?�M��}!x�Jm�NF��I�"�����B��������k�C*}��	���;������%�zkRc#G$�"��/��z{��?Vv_��y5�3��?V.�,L��Ayrk>��ض��(0X�/�ԕ�+TF	��:��]� $���ݹ��j�Y?�������ܔ�s��*̂���<��nj���{���+�
.�ʦ���@�<��Jm�\F��JC��,3�E\A��}���Wv�w�c�p��D����_�rK��5Dn��.��n������*<۝c�U���q<̳6#�����P�I���KC�g/�;�^O~�p��Y�q_6.�QY�������JA���;cٰ]Z�6�xϖ�w%���	�{ۻ��2��T��^��M2\��ƒêa�2qPf\k��4�@xpY$ESلl� 8�?��a�e�q��z�\2љ�ൎL6k�.�{�,���X�Z�FZi!�B�q]X��Dֽ�e�u&6x�)���ܜT{�-lS��M5�����4�Ȫ�6㾚ߍ�dp�¥�M[��5�xW�f��8�3gO�ݒ�L�e�e����(��hEpft�!#=G������Vf}�J�eN�����9�z�z1� J윙g3e��~�h�wv��(�ᰬNV�	?N�\cz@d�FE���1���� m!1�K�˜�����b*�z��*̈́æ?1��|�.6��F�=M�>.^7}�l�Лy�ם�plmJ���\��D��:)UP���v%���t��l`�r1�~U~�f"��71j�����8~����f1\�Q4&�5�uQpL�)X^������	�C��5N
M��ը�Ԙ|T��K��Rٚ�"�g[F�2!�Y(Μ �����]V��;a��$���!����U�n�/�����L�5�pg�]oj
����~?���'�|�HmpK�_�Ĥ�ćV�u�^�#\��5��jʿ�\�S�N~UFM#��[.�I��Bܞ���[�� �\ ���ޮ ��oJ��H]�]�WKpC��0 ¾�� eL_(7�^��2����d�54����U'p��Z�Y�@����7�	�D.Dl��F���P8�E};���h�C�.sp,��+WǅEYŁEP�5�YXP�׫sx���Q�}���ʥd�B`xԻ�ڽ:[��]Fl|�7p����}���7�B���Him$D��V�
۰�}�����>T���� Ie0'�T)���D�Ap�y�ժ~T�:şo*k�:�7�Ew��H��HsC�d��俴'�eq���s6��H3A���T��I�+��>��i������|��y s�� �4�f���$킸L����n1����g��B�
��<\.��&ٵ: �2`E��j$��@�_������ �þC����ޫy08{��D��꓾��Lu|�y�����=^��t�����������+@,�ޓ������3n8b�$�Q�D�����_�Q$�� a��{�r��ٹ�Z���3����|e�5���l�}�f�b���,�@��9U�*��tv݅�F������Ty���'fxc4���	Q̴�'�{S���"Q�r������W0���[��7�c<J�t��t�j��4Ov��ٙD������;��Z�V4��k�9�Hpa�(*mҊ� ��d*'�X]���g��>۝���wvuU��t#5B��9�7�p;)������4���s܀�-o�%� ��S����6"$41m
��#+����L��=�3M�:��m�(���Y�t���<�g��1�܎��x�4���):���~}�cГ\��+���Km�
�Tǡ[9!�+:(�ދ�ߢ�G�8.�s��s����f���ń*E��Y�D��b��H��ws�w��WE�BM3>kEl^ǹ��5��9��5X+�OBXA�A��
+p�m|~:�z���,�#��N���|e�扺i%<֔�����9V�T���<������ ͐������F�l	S>�<�{W� /�)	�p�BVg����P�b��ˎ�� ǿ���W����A��G��v�F~�s(���CG�D�M4�	;�{�#�(�M�d��ʇ���"��]�]�6�g�����c�������F� �(xT���pc����O�Ǫ�oP��3w�����E�l�����(�xH����?0�Н��y�����O�=��/+oU����}��oom���/l/�B�(QA��'`;8����E�	r�и�7�o�):�8bO�6�օ�7/¸&��[a�2^��g��g�շ���e����i�����wf��0HF��s�k��b=̦�kr�l��l�/St�����[eCi���0���ϯO[g��dF������wO)�6ͯ?w�����!j*�����i8�~����):M��4|y�����G�$I2��z9~�ȉ�ǏP��v9���hOP�b�n�G{y	@��*��B>+	���M���-��B41�T�t�葯m�CǏ���޶    %L%�^HO���������&j���Z
dy�퓊����sߴ��b�l�F� vd�o����K�]�P���8x�%xX��[B�2� �#l�p�M!P2�P�E�[*Kh^�}Kyc��w=�)L�卲���}�9t�"廣��O��7���6~�c{����,��!�����ݸ��pc��y�q��� q+�=֔����a0�aL�l�`M�Y���4��f~�R�t��9+���g���l"	��N.Ɂɭ���Y��%�k���bG�D��!q�����ƒ��k[���]��sl���]����!�_-�_��*@��-��V�@U.4�EF�?aB2�P�^.!��}�S�9��:â���oS����76�h������T}��c2�Vo������/�oX{O����C�Y{W��g\ڽ+lzso�1ơ�7Q ������kD#C�"���)ju6�����"Tg��ь0T��<�Z�OQ繽�Se�N���w���_%���*/���t��e��;��q�ʞL��l��K�)][�./�>.��3�K��_�&v������d�oŰM��;�J׶�~�.��o�t��!8�iS��LƁu���0_�i�u��ۋ!��\����*wv�8�a�<�*>�Լ��%�%�y�:q����8��oX����~�~ûv����]̽[zV�[�1��w�`���>0r$X����1��a.�4�9�?�Yꡈ�y��rr��0�{�%�^~�o��X�N�.�0&��x&G�'N��+Wl���X�Y��Ƭw�AA�G�@�2��q����N& k�:�t��n��(����9�Q; &�1@�3�l�b��h_c;����R�m�i��%_<
��L�nX!�?H����~y0w0��N'R�������d�3�Y�e�xܝOr�%<�t���h�a��2y�g��
C����f�D���<��q	�Myr.v��+����M10.���]j\C�Z`|D��%�FD��,��r�z����]���%y���yܮ{�P9?"����� ��s�G�t]MЩ�'
[�MrG"�����|z=������y�vP�^4��؏Wy�cب����;��R�K= 0��Q����Gm���8Q� n+^rKB~��Vэn�[�y/�T�j�!0���x��X�bj�%~J��퐩��.��Yc�ѡ�����[xA1�k�f�qهN#A�5�2����iH��nܭx��V!\ӵ&o�A�"�dܮ0 a���o���}&�M(6����CM�ɸ��Pi2nI�5�&㖤�CM�ɰ-��z��4�#uj"MƽH��&�d܋�q��D[�����Hĸ���P��ᇚHĸ��}��D{���5��qY�}��D�Kx��&1�ݵ5��a���~��D�kd}��HԸB�j"Q��Xϡ&5,���j"Q�Zߡ&5.�55��q��P����{����HԸ���CM$j\��:�D���7j"1�.��jjj"1�n��CM̸]�}��w,��PS�T�8S��ԗ�\&�q�#eNd�M ���
~�-�+�d�1୪�X@��ĩD
��s��r><x���-���_�cvg�#q
x�W�$�	�A�ױ��$V����g�P����f��i��}$��i�cs3�?zq��(v2�c��,;������L������c�S�d�79d�=f\�/־n��_���S]��%�N�e��3��鮿pO(xd�3kJ�R�6���͞?0�Y�}&���dp�_@��-���w*�E��D��I��<~��'���|��I�'{z�����8�M�c��9v>��>�d��U�+��<���x[��ܟ�}_e�4+�f �Y�&��Rv±���3IG�9r���傔Y�3�T�ȶ$ׂ^O"�L�wX�:kV�@L��}b}�
u�e �d,���h�;2�N��L&	[���gmJ��\��M����&m4���O������f�A�@������������^�x�5Z�{Ð��4�>��s5֡MVR�`&��>����_r���,�D��N�}xY�f�-�M<b�	F�W���Kqe��8{A�R����'=o@^(�P�Ƞ�������')
m�����z�V��{B�{��6')�-(���Nrی��|��%k߇W���ij,4�+M1�x\���W�/��)�P.Γܴ�h�M��?��=���-TG�Y�,H�46bU��(�{-dO,;�z�xO ���c����4��0���@�L�~剻���G���o�Uh�^�z��9�6`qs�P�5�T/u�!:�'~���W��t{� b1=o�]����O���L��U'��=^ݏ��������]��!���v�/�I	At͓��nL�\�޹4��������U����_*C��3U�6QI^�>�Z��M�?`����#a㶗�*���OmO�`�K���JmR{��p.�ܚ��V(Bm����7��(
mN���..���J���9;��Mw�s4@B>�� �ڡM^J�a�+�I���Lj����q���T�_���jZUfh��;���Ҽ�LZ����2�t��v�ve�	cN��ܹ$����q{m��X��Ҝ�´N��eV���k�������}��$wm�ԥ�8�e����;��ߏ�s��w��D��b`_�ig�)/���"��^�_��b{����K;���ff�����O�����2�]~��� de�)R/��O�~����{���l�w��l\w�/����U�6�I��xL�m�^E�����S]PS�-����/^oo�^�*>�*>��}��{�⨫O_
�W+��jFJm�z�
c�h���d(rmb���:��/������u�V��^�X�Ꝧ�Ys�"Վ۔�W�����YW�pj�4_.M��F�j��q~�0��F���e�?����}�{�i��G�YS�"b5ҺHs��t���wg��E��^�)".����0ɡ�+m�|e�q��"�QD^$\	����!S��!zI�B>Sx�����,m���F�"i�0��P޹|o������?����2*�ꊛ��T^�o�Ѭ����g�p�Y>ەI���%��k>���j�B�մu�W���x��^i�a�y�i�c�c�h����]�F&�L�K� �|�#�bd�\�����̩�%�Ҥy]	�&���I�-MNC0���)�d���%(��F@��ҭMl����k�^�	�i�IF���[�8���gv�b:)���$�������������:���jtr������V��b�� �h���Id�B�6�>�Y���n�t�\&{��3�9^�/��X9J��fCd�l�Zܙg�������c�>�N&ΞJ�O����XY�qa#���ݕOw&�L7�lRN�J��� ��;�9�j�,Q�g�IO��o3�\>ks�7�<f:�Tgռ�h�1�����#����oקS��c��������>�=��PFxT�+�f�2h���M�ډ��&��C(&h^�b�j�C�b��
L�y�I��!��wmZ�*	������fN"����ÏI!1��B�*qs���}��H����$^4�#�⏵-�Q�U(L)q!d�󐌎�[���c���d��?{ny�����a=	���N!Ŏ�{ą��o)���I�T�/�����t�� `��#9[�?a�?�@簞�D�#n�Y�I�Z��?&ק��L1A�\�d�Z���6�+�>q6�t,��?U:*�95�t�{������<���_��=~ɋ���c2�%6"�"�����*E�4/����}x�?�>�?�"�+A�y�����d\8@�<Cq�u�����0�]Fܯ�T�'��O%"�q���,(rM̀zDRH�FQh��W�Hv_����?S�h
�Ҡn�'J	����V�n0�eH��D��Ќj�眱F���֤�^l�W�P�9$�4b�KH3״�Ac�П���#wxy����j�����F01\15�X�����p
8^B����~�EG���ٜ��)J�U���l�6�CT�    �O��~��#�n�$}�L��1���?�^�ӌl�~^�g}�<�z]�󂡧�� tZ��Ge���_�m)$��:�@:���h�S�S��쫁o��MZ�w��TJ�����q//��{-?��d�zެ��&$��x�8���N�VwA�e˭�6za�]8��vQ����fZ�0�z� �e!	$-+�G��p!<8�xI�W���>�|�-��47��q��Zk��#V�K�?���}$d7�/��"�r��X_bj(��FD5�4iE�q��0P6�f�}p�K���}E�C��:E���
�s����nP��挆���������̎����A[b�˺:�:����hz�Z���d M��M5�1.�80���E�Nm�J�<����Oj��yẌ>p�Tq��5D�\2Ԡ)M�2ǳ
�p��E] W��Ǉ��pV���n@���V�Y?��
V87�!��b���/��ekW����lAuww������#"n�C��M�Tv����=���sܻ�l�nԩg���5<�rч+�kEE��	�On�Kh�9HBZ`�G��z8tXą�o. ��b�}��k�󗌏�
r	�_�����3��6^sXx#��@q}�P�Or��E�	2 �/�02|��X�~�����й�f��/�W�V!�Ǵ,w�t�%:���BTet��_��n�TP��r�����t�GH6��(��[��FG�5�O��>'!h�C����ڭ�� {��\&�{Í{�'u^qs[����ʝ_v�e���v#�Vwp�ݳ���~pX���ٴ����k[��.�(\��!��Χ�vsࢫgp{i���wes/Z�lW"��M�<Z��8��f6���� �S	Q��Ut{� �)y���i�>^�A>�|v����>��G�w�e��I�;?�^�0��q�Y���n��J��[Ң\�T|�G=��#<{>��ni2���B2-��f�]-��:�H�Wp� #F��`��!Sp�G��eS�4\c؏�tl�$����oɑ3V"k�'/>�?�Rp� p�	\H�T&�����\�Y+��rɴ�8�3)��u�m�Z�S�O\��Y�l2u��9\���G�5�d-:�,�R����(��j$��\�v�Q&iH m���#��R�������0S��c}���<��g�~.D��Z�k��
��J�H#-Y�>`UV/OZ{Wo�=REk.3=�/���չ[
]��� ��q�
�.U�X��8��ry�o@!���88Y���V54�6r����n��]��]x�W	7lR �%���A�*[a��:F놶����� ���Y���Ks;�em��x� �aフ�J�m� y� �2���P���#�]2�ze��#�"F�_,m�x�{�����U��.*|�U�G�6]�胀[��Ӹ�U\dR�U��P6ʀ`"��;�Ww?�D o@�������B�o@�=��^�Fi;=2 �9�`�P���7��F�f��_�xW��	GQS��Ը��p"��4&��v!"L��/a��poyN%��(�M��"_E��F�y�[a�K���8��&�2NcB%���_HXH���o1�#���~���#_�<�P�R�0����܅�TF�>0���Χ���]��#������TW��=��DN�&B�(�W��(eð�Qq�Xy�p6�������e�t"���=&�E����W'���Ԉ�h�.|���H۵z��~��hM��R�.k|$=�t��scKB]g�#�]�\��:��(��ۻ�yԣTCh6e���g�9��ﯽ�P��Gpl�j�eٓ��[��RHu��C�`|��T��o�G�ގD(���[0�,@T-�2�-�f/��(��e��;Ϛ4p�
�����9-�u��S�z��^��hA�J(He|yX1ؑ�6�6nL���x|��G wP�LHo��B�K�7���M}�꘶�c�-��w6F6F���sI'�;�ɳ�#{(�����&��1���r�Y�Cx����%ٴ���x^��F�k����C��t�.\�����תOz!	���F�����=2&���4�^izo���� q�Wm����뻳oߏ�r�u1?z#��2�Ը3�\���lS�3R�{Q��])]�]QW��ˇ7wY����3 �Ӯ?����W���{<�p���Ցʝ{�SO11�yB�5�d��p�s�^�ƒ�"x�a.�9�	
�=I�K3܈Ø!;7FW)h��$�)֧�����U���sl_�U������K�b�.L���n�D�p�Q�U�($�n{��m6�Y0�*q���ɓ���!,~�[��Сxn=O��%d�����+h�.�F-w^L3B*�F4^s��^��m�6�/���U�Z ���~�_�t���2ٳ���i��GO~���7_=|�ء/ؗ?<��V�.��G�2��	�H5��	c?~�<0 ���Y�B��5Ql+MM�����E��*KO*������Fah��*��|}��^>�V@�2�B���5�\G�2�(܁�;w��[X�kt�tJ�Y�����]���7"�s�'/?��D]��z�������pi�zė���U\�5�Qs-�Q4}������UOl�߇�wɻϖ?��n^��7n�+�V]�D~��0\���@X�D3�k���E�%΁i���e�z��=%�{x׵��x������eNkc�< ,!a�< !a=��t(v�d�5#�S�(v㚁Kȼ��?\l��=ϖq�#�/oyA<�C�8��c �8��04�z&#���H��Ƃ�e�9$�ha�r+�H{���|��O�m�ѯM=^cO�{�ƞ�1�x]{�4���ͥ��F4��,B��γC k�~��q��~�2tvK�x���0\����[�oF��T��۵DZ0��Z~ ��/�D6-$���s^J���36`I���s����ky������>��U�O�zp��puy���?eVm�?f2q�Lt%�F���',���P6�S*�v�����8�?�/��$�A����K�Z�4F�:�٬RO��*�� �vDZ���i��G���_5"�vD�9���Q�X�v�sJp�����=2����Ǫ�^�B��Z�ÿA>`�W�2��S���?`U�=`�g�ʐ	[�RϜ@�����+ջ��ꅡj�����o|s^��Vsj������&B}J����� u����š���O������"��y6;8$ȵԚ���?V��g�O�Y G����^^a�v�+oG��͋/^�����wKo�M�m/MV����z]aTs �ŷ�k�B]�u{�V���,� �<�͏1#�4��w���,WZk�c6 ��|�,�9��4>ø��sm����;5�2�z&`<�w��~ ��*z�A�g[�<4�_�
�k�x�^mxډ�v����J�@w���_Y����w�a��)���9�9$t`م�h��):����]��t�,���`8_$Oe��q��������k�p������`DQ:��ָ��{Q�Nj�gۈ}��(lV��lM��tL�3�9Sv��|+.�����dJ�Vk:�W��p	w�2������"y.k׳���3���J%��|}ڱ��h���57՜Ap�pDpj}��K��N@���!�K�,g�+�9��*����٭��o���j�S�����+���
k�f�S������ݪŨT~�r������Re=3k��}4���N5b��5�;�����Uꩩ���~��=�
�Ga���;\��n{_Y�I�ъ�� �����@o�tm;+�K�	�l
<.���P�8eUzj)���U��\EM�����$%ݸ�o�]�95B�Xh���.܏`��/���7���� ��U�����O�U�_�P�Jĝ�'r�� �p"u�N��/�l���_���ּ�n���9�X�4V�ڧ�T�7�<��v��d�?�����A�e�ƒ��S�{}w�ػ"gL�L�0�N��?`����d�ϑ?!�2ɡ����    ��b-�Lѷ�ݜ���쏙�` B$�;��k7r�b&Ӏ��G�W�I�\�o$a� ½�Tyof|*�c��1�t�����%�����:� /��h�P�c?}��1�ғk$��2	<�&>���{Dr�!��]��{8U}<���RljI&_f�DRגK����Է�zw���h}�s�LU{d��B2��H�E��Xr�I�4��C��Mr�%�����Gtb�i���ʟo��ɭ`x�}Mr�)y �:>���vm�M%��9�+�[Ӓ��J��f��H#͙f�[g��y��p�c{�mf�'۹ !��	�8�@��\��K�? ��u;��_8�R����0�HH�v�Z��Vծu����4h���Ha�V��7�7ۭ�}�`ͤ9�l�sa�S��Z�ZO&{����Zߴ�WUm���W=�X)�}��|�T�1+6�(�-T���p�ӧON$�5~�G%��Lw%r>\"�45�R��(��po��Y��5{�� �jk�C�� ��0I��Z���e�l3�{�uD�T��l�H��>��Ͷ
�&?<��>6]/T����d�������~�U����]�z��]��l8�B_�.bX�x�!�7�ٚx���}����;)��E{�ۭ	Q�A:Ɋ�%�{2c�ԗ���[�.�:�	eͮ�&^o���z����l��J$����)�hz�5�vK�z
����z������[��d�;�rA�$:�����.��Y��	.��8��0iʡv4�P���i�M©����PB�~zC�%�)�0�W�~�첩�b��7���7�P|:��۝I�h&�h�!�WBǩ՝�fb
�����(���U�ʝLHm}�Q�Y�[gCE	cl>峍��Y�͇Xd�M9��f2
N���H���Z�;J����1��.��@����>�̐�ʻ��" *��7���p� �P�����ٖp,�l�Ͷ�@[�H�S���Fh���y���Ba��"^t���ht5�N�:U��!I!FB����"�U���@�Q�GW���N�@�YjȄzku5�Z�F����"��eF�*�XBOE��b-�O��t�w��n���x���Q"�Q���T}6�:%�	��r�X�qS�i��cC��P�^6��C�Oa�� 6��O���N���Y_��ӌ���ņ���1�V���o�a�)
��?T�.�t'��k�J��j�ڂvQlD����	*h+�S�*�%	Q���Y�`�_��(�A�A^쒴��3�ls�	a/�YE��s�!T����ϝ��H�Sj?w�	a�1����\�\,�E�}�PMq��6k�̖n���[���2[貯l�!��G���v�n�)	B�n�%*u1=hB7e����t��d,U���$Qy�`|H��(۟g��-J�De���9�R�j�Ա��������l�Ƥ��
���i���Nt��n�K2��/�b��)��8kg�}C-���a��'�����vz�!A����Y��+wO��?N�݅�
�D��>*�I���f�x�H�4ŏK%G���*.)"n�ݰU�%�+`A���Qw�6��9^�;s84��(��,���F�(���M��;��ᢻa������R'�����ݦԛG{����E�K��Z$Ô��O`Ҩi/�sOq�9��a,ԟ�+D�J�)ƁO��Hcu/l�y���-��λ�$ ���_k��98爵n����ʸ O\�c�h&�TLb�Q&�n�`��!w��Pp�.�n��&�*�em��*��ĳ�깔���w�(CJD����O�`��Y �����4.�MX�����W�����X=�M�.�� �
־;�{�m��G1�AΖ>�� ��α�v������]҈��:�o��-���t��&�2�ܚrH{��{��0��20�~���=һpzv�ͱ���T�{'�ƦuFcmOhp4���7�O�Yw���p�I��|�v	���d�t���s�k#�+~_����!�v"��WDJD���f��S=�I8{�`m�o/���S��4���Dk�G����sy�+�M�����h�Lw25Rp�1'k����5�8	}�4L�	,d��c��h�n"3��X�B�{��(��ڝ�29m�MM�D���c��$���6�<�	�CC��|��k�������룸����[z�>�[^r��+��U����$���6k�p��_�6(���\H���dXW��,T��/�lӄ�dE�N�mz��	���n3k��z�/���#8�J�c*p`�,���q'̯�����q��4Rףaü�'tnQ��&�_cq��a^2R&:(b������N;e?��f7�^vT�:>�
]s��jG�a8I��Lh��J��������J;~�;~<��	���i`���B����σ�Mܚ������H�n߿6o��N�o�fｇ.p{?9,��li/����f���:�X#4�&��=�T�o�J����\��
��c��=�����h�7�Z���JY=_�ȴ�}��$>�K�2���۴p�������\�n���?���Å�hΛQ>����d���'��n6����a䬋����`�1��=�E�m0 å��k#(5ܞ�%{
/a���9p�В�3�[��������+������X�z\3��4��k���;eҋ.����|�N��N��L8�u��rK�_�A�i��"��[�g���;��EhZoQ1�V�s������%�L�B��0m�F�Y+�{�'{<*no�PU̕��~�k��ͣ����<�z�ius��
�^\���ߘ����$\���j����P���K����Ջ�j����T�w/7n2�dФ�u����ʪȽ)�# �~��_%����e��- G�Ip�,�ܩ�?��g�,�P�^���3��V�~�&�T��E�VI�xC^�%��Zu��:.�cԅ疃Ʈ�bA.�=F����6�U�=���q��P!�e�ߘ��l�iڦ�����{V����Ua��_�	4�_�XĄl�`�Plo����nv/�'�no�1-���A}~	�B֦y����)�+ܯqk[�7���;���<��%��	��"��0�� �ñLDO�F�J���(I�d7{څFM{?g�X8��q�;�#'�cM	�gWHi��ڃK�Ȱ�x�������₧� �CA��[~�6����jDRK:~�w��db�[�OT1J���ܧ��Dcs�z����Ҋ�	��e�$����v�ĩ$��io�����w渀z��s6�̪U�!���3���T��Gw���N�M���(�A,,��
úF^����*9Т�������V���¾��ϐ����!GZ��}a7>'��� ���1vʓկ:�{�-Y���PQ�`���p�pL�%�b�u�\H���pCUk�Y�����.�����ߒ��cC���(�ņ�t��b�Q���#�Y)��~�Iq3�.�:������HF�N����	�P
n:���&��7@��$�֠��!�;a	��n���N��t�*�����f"zD�M��hzJ�R4�
N��S4��ՠ��{d���Ó����������z�p��M��S�ׯ�yͣ��a�����>~O5�*U��V���w������W�=�*��Owz������W�<�zcR�4y�����U�^��3��^��������z�[K�ݙ���w`g=��>�+�K�.������S��\��Pik�`/�kK՗\����y`�t�14!` 8|�����6����Jp�d<�@�r�:zF�>�oKB��W�W7e�>;)���KEg��eٲ�B�%�����.�SP�R�/5��4��ͱx���nI�}�;�֓��B���.���͖��Sa=��L�d�`�]�]Kꦯ~`+V�Cu�4??��9���퍎��6H	��^�RiK�������\�oy�'���tBi��}"�g雖o��b�.O} �/�W��6�D\Ǣ�0\�+͕���2fZ�|��F�+R􉕣��q���40��5SEq�֎���N	�g�    GC{��fW4.��P�@[ �ˇ����M��֦�>�G�Mz�p�!4�%���A�3�D�[ps�0�m{��'g��y��Ѡ��%K���.ڥ�E���DZ7f)��g�ree.4H�:�-������mo�d��@�0enU�0(�vU-ԎM#�}w��,��e� ,�´�����w|J�]@1���ܽ� �-���wd�,��2�2G;_�%ȩb�"�����6kH7��$E�G*Ў�-/�Ѵ#G�y�kF,��
F��V��8(Dẟ�n�IѲw���М&�3NcGkgGW~ܺ_V��������YFW��U���q>Ӭ��VQ�5i4���K���^��;�1��
^ҳ�V�aWefAC(�Z-��*e�6�	���8^��/~�ݰ�;��X;��{�;;L9����F%&�DQ�U��y����F����x��(يΕ�C��H��E����&���M��n>�"p3۠Gk#��%Jm]���F��n��u��f8�	�?�c��zZ�����+E���	��I��Bi&��ǯ���� ���ʕ(������k��5M�v#(���xذ��^8��ֲ���ҏc���)���;�[�oF���G3�Hj:h�h�#s#��/�%tE��o:��h����KS��k����bU
�!~���Z4���^<�������K�������C���z4��? �T�0%�%�!��E�c�a�k�ՊƯ$R�<v6D�A��'ϩM�%�2fD�h��D�. ���^�Єp�8�l �t�;�NÀB������^�c-�h1jΤh֒x�!��B|�p���o�]h@S8�h�h��L��}�a=�S���X���J4D�(�U��8W�D�.H$�+hY���3�X�R�F��S8�h�'�Z�|�Y����6���q%3xFs��B��0J�O�cN�{�aY�.�kǽ壹�v<UX�J73�#|�y�Gp�+#���,���ϐY��$�����.����ς���CG'�fђ��D�\K��S����V����R��~�꽖���C�o��8���~��R�GC�a����_�s@,�=��eZz�e�T>�_<z�%�����$�C���
G�+����Q�"����k�����
!�����:�ϭ4�t�8'��{���k��$
����,�R'�yG��Ӿ�g��+]�{���R�}���"�qm����z�,�����qa���N"����ǥ�q�kB�(��t��x��l||]A��{��  ����RAGÏ��S��;�3A�-L���v�S����]��
J4F�� ������,�y��"V��r	V���hfxX>��C�[�������3|�%�S�l}-�̡�p�64JV�^
�*���8�`������^d�2����""
�D�s2�P��_������+�[�b�}��������z�0!�'������Q���E�q�60{���30������۞���Ԇ�~x���o���?�[Ͼ�P߃���Ĥ������ .����Ұg�V*�}}���SК^�)gk���W+��q�L���.���1���a�����dE�-���>ds�;S�[C82O�0߫���~�mi�62�So׊3d)�"���ɉ���`��C~��
��z^��)��tH��j����f�%�"��P�`N1���b[�*8|��=Ȃ�jma\�(����wIL�wo�ڽ 1w�	��Ѓd�'���W[XC����z�^.��uڮ�Y���ޝh�<�<E��0�����CokK��v*l��JO}r��qs��)�XC']}x�6tS�R�� �!�	u�F�z���!�R�Ƈ�coj�b}��av��o�n�R#w�O���5Ԫ@�1F9*������=,�o��9~�h�����@Pk�f�w����D���Z������c��[�<���?�Z�l�o�.�=A�[�uq����n蕙�ʬ��	+��O_1q�|�V~�x���0&�
�ado<ߨmf�	��p絁Jm�>4�0��a�)Ң��7���A���Y[�r}����E���ǲ3����`��Ro�����:l܇����#�j����0 z��R}���n`D��p
X{\�o�d��vcf�0�s��O<G%��7�^̖��U�jJ�a�#
2�&��J�e Cp$�w��D���RH(�Hh4!���Hh��?��uIҺ��)=E!�v4��
z��~ڶ�5��f��F�HŐ' �����X��@)43gJ��A���u��);5BLEY�ʓјnz�^�0�־�j�a�'4=֭���.&*M�s���5P�(��Z�h��9H���Ѱ����:��*��0
`�G%���w�MT@N��1���w�,V#:j7V9�̀ʆ9X7�#:�F�ůGu���좌��7tAw�t|&w���(��4��	� �XN�h�H��
B�#��zJ׮�I�J�.u���K��iO&"4$PqP��9����@0̹�NcDC ���|"B���Fw2A���f�[3�ٝ���IhW�����W%j<�X#��(�B-µ7Q	�}��ߒ
�͒� �F
�f�I�9��ݒpf�f0H���Ka@�=�Võ)��,*��޽;��>0�D�]�8��H��m�wed5���i�5��`�{�K\�T
��D(�6�0�$/<gwVZh�f"sM��q�0���ʀ�h~@όeg�q�S�����kܡ(�q�.N�}�/4qI���0t�:�YQ��σ����-�H�u���C�����;����v��@�1ơW"�u[dD��"�+jF��pLB�Kk	atfFuF��A�2h�ғ�|���p>���J���n�����s0b��)%�X�&?e̿f��%��`���\����8�(�������2d�؝E9Hb��S,	��W�g�O�w����b��*�ߝ�H�e,b�8��o�τ��M��E������(� ou��[B�qN�[<a���m�L���6��0a�8LC���:��l�/o�1tt_S�-{R3�޻ȁEa�v%d<s�o��1xxF�\�$���H��J��������]�dnI�2Cߢ0�!Y4�P�#�M��R~�Ky�B��4��^V�0)6�BX�o���{��[�����mW>�9�""�K��yN�{F�yt5��fo��\!���\�N�F����$��Bv�����_J+���rp�k8.����ך�Z��Y`��lH�� �6�Ĕ��&��W%����JD,Z����*X�4m�=�C��e͙������0@�N\�&�HL�<�����t
m[>=O4Ml�!�����\w���qZp��4LKAg�q��x,��$�Ln��/2V���������7��TKV�c�>�A�Tlj�0�e������I(KG���zd�xIc,�����>k]��9�m��9��ggF��|gLq|<�e��]eјq`I�;s�*�z�^�&t�h�cӿ拊��w�U嚰�3�5>�Н(p�ԣr!.�&S,����[Vf�-�ツg�=n��V޶s��-��(�0#KLjV$y��82§˾;Ck�.zN���2�0�Ҧ���(����H>�%M$RR`0�>FQA�^
q�hXs������E���r(�����*��A%���9�g4���[:vE��0'i�&��T�w�!rS��!��BX�9K��U���`1����w���?F���Z~��(���=��`l)�*9��37���`E�#��Y��x��S�����M�Vx������5]b�3�4����Y�_k鈴5N�&g����q�����ɜ��V8�,����XV���5	e�w����K~U�R�M*�j�]�~�/�R��y!r87+�{@nn2~ �7�m�8l�*��K߄/�E����ʁg8�%Zw5�)�!���r�xt�J��]�5��o�\���3���U;m�J�oI	��'ٳ�9ۡ�1l�b�V9�@k��򍏻�`�u�-�2�ù��� �  �pD?�-9���$��b��dek�$���rү�D�w<g�1?[\8½�h'�P`4���]�w`e2 O����k�ɐ�3�熘Sq<�0��}�V�`��Q�����R��r���Yi[��0ma��x
8�౸-3P���oNw�6/�
�NV�^�(�U͑~ǫH��w9�? �H�U��ku��J������ȧ����Ǣ���J�j ���(�aZ��گ���"ױ����<��U�v��+�Ʉ��v-���n%8�&k/�{�Ǯ� ���W��H�ED���q����2g}+��v1�0}י�ksbc��M��>�r��&���rn�m����W��٠�^^�xh���mu�y�����XU��ls�u����N�.��s2N��O�3��D�3��A����Jr3����/�:%�}�9�Nֱ�NQ�Ე��j��A������k}V�C�{	n̫���y�:﨨�JT$�}-���<c�|xp���uo�E~w`� GiA�Ю%̤�]��f��s27(L�S��, �D�W7O�q��RZ5��,��1�"��GG�[�#X�
�6������*5��U���9��A���G��$������!���[�S�+hp��c�JS���%���DD�W��u��� _>^���
]�H9�b��m�}�/��_|��      �   �  x��WIn�F]�NQ�$5�Y���Am8�M��V3�X�*��1r��$'ɯb���A;��������U��]�֏���(����ʛ���h�	�'�j-<2��B�P�ϘΤL��ڲ�D&u~W�*yS4�сu�r*{�<5F��u�q�J&��+2�Nj����yr���Llj��ѸH��ri�f����f��B61�}Wm��㪻�y�.�!׵va�����h-�Y�%�MJ�?-}��E��@�ȑ��e�����"T�!J�����{L~)n���b J�'\��L%��q�J�
�+�,�_Tm��z|�@0e�/|N@y&@VJ�!��<wU�i����}�2�R!)�vBT$@л���ևެ��{�r��b+�r��EQ>��`��.��D&yʠ	�<=cQ5!����)=����I�}����>Xg�;ϵn&���6�n�Ѹ�6��3n�ƻz�6�����gdl����}�v��辆U�:T��y�:�>����JG�<Qx�6/h�~��(�چ���m��C���	�<#"eB0�W �T��4?����M���35�)�
&�\2}"{��������%A���5ld���ĉ��@�� tY�
6���B�&0�=C��`[
�|`��bs3&$e\	;��1���S�SY"�i:�T�lsX<���?��ZƏ�Y��MJ��bA0�g'�������To-�x�w��$Bd4\?��!�[є��%���qq=SiE�2�ɹ}�2Aap�Y�{!.>�P�����y��4�f>�,H��Dq���k��߾��$�
1τa3�V �Ո�?���1X���'�\�R��µ��@l��4�o\�m;w�WT�f��JSe�� ăh&�]Q�
��6(���kZ���}W�m�=�1\��T��\�bV�	�����tE�`��Z���=P��/][�;��������?��=���?���6�k`���r��B�L<��͵��k�1�#��F3�5�Hin�y��tB�~�U��<XG�ׁ�½7�I+�FY&5(aT�@Hĕ:�}����vy����U��������5_L�Έ�<��fB�O�C|��=bP��ױ���o�9���U�Wm��>o�Ϳ�%�OR�U��
����Pc�n��K����PbI��[��4`6��D���yX��>�Íz;������:��P��s:B�PG��:ś֧}�e�>o�mWp���#	=�ו� ����e	����}<#�� ��� ��H
H�"�1��9��7E}WT���S<�?�W٥!:N�`�j�!$��l�r0[�g��v��G+�<l�ssp:��K�gn���t)_�B7����n��%���su�j6:���`h.]ˣ8����e����ww��� $'�1��җ��|�#!��Prnφ��Kb��ަ�� Q�	g      �      x��}Y��8����+�m��(e���r��vw{�^��- 3%�X�s�TMկ��%.��ۇ�6J�PJJ$��`0�ވ��r�;�j�Q�l�g}��ތ'1]pѨ��J����:�V)m݈^_f�[ը��.��/��"^�UAW��/����^��?3�<?<��5�(��G��(��o�\���5�t�DE#�'e��Ҋ��.��KՊ��r�'���R��W�nD7}���hq�\`�n>�����v�1�2{�k�� g�}��y�J���ͧj����8Wr�EK��Gy�����˩%�ꏲ�Ǟ�_V����ծ z��߮��M��8��(:�oE�Dw�*D��?�۵u����O9���*�R��~�IV��+U�öA:�>�^^���ku�J�4��l���(��z	����u���8zђ9���x�ŷ�6v�1}�V<����]���T�_Ċۛq� �#�hԊH�/���d)��F_�_tr}_���7��I��5�_d��(�U���?T_�\�CB�@�ɆS�n�I�j�U�]�����&����f�C���#D�u�WIB��TC5_�,��|���ї&��(�Gq�����&�2Bmg��N���+:��'a�=uՒް��b0X���,�Z���:�ѼO�G������N���暧E�i<���g7�e�E�v�?�K�:�lGc�L?W���$r'�����'!���i,��P�U�BN#)}�Z�\�vF2|en!QN"R͗�c#/j���ƾ�bH^9��]�A_�IȪ�۱3�����`�3�D_�e|�f(�^Jw�3}=�쌾5���I�>���m+[������իc�;
��o[5��;�͌$z�MflO_���ѯ#M��"I��8�d��b���p��U7`���E�-�R4���8��on�|CC���N[����HV����4WU�1����ݨ���t%i�to�9K�o~S]+�Ρ��o�ᮣ����M�=��Bs�"0�~Um��g��~#�A � =���f��)�^{�������'�Qt'-3q`B�7v������Zw�$e�&�}�H��.݌m�́N�r�
�.��4���0&:)6�Z"v����h��MU����L�N� �@}������N�Ϣ��ޏ��'3?���C�ч^��l���8KH�Aq���<��^Y��o�Y�D�`����h�w�M��w���1s3X��h�j�͗��c҅X7��g�A-N�tа�7P>5�E���&��~����mI����g���de�o-��>�B� ��3����� ��aFg�� �d$�-��Ӝ���"����@�&]��t�H�"	z�])C;b���v�Vk�z	�i���$��L]����0�Ĭ�;`:O����ͯrxv)����?�`q��06��+JS��$���;��~1(\cW5.F����[������$�io]��:���f���(��0�Sk,C�P��-�w��e��I����$�D�U��$����4����$ࢉ5E4��A���I�L8��z�ꏣp�b6k��+��8\~3����>t��C$x�!]�tF����N@�΢s�l4�>ƦS�x_4��Yt;���a����z�:�M�al-�@=��A���}x'�Q�X��S�;v<{X0!��8.@(���*h�ϠE=,��96���HE  j��b�4еHw#�E�n����␜զ��I���eV~��#Sz�Ž���I&E��:P�m�Hy��w�!�����Ы��d.wP9*�e�=te� h�	b=�~��	�PF �&�v�ZB0C1��k��A-�.��;H���0>f��3 ~��Q�*���+��� }z2Ic7Hd �y�����	����hV+X L�PY�����-}A{GZmh�l�E�Ȟ�]���O�4���(��l߃f�-���'�lQ��׾���~-��!{O溠k۞�#�'@��Guo�9@��Ge�밟���,H��,��N��͗_��
A�������u͠��I���3�4`�G��m	m��w�|[ېli�y9ڏ�&6����A�=��Aӹ� t���S(�~�'NXq�Z�Uy���x3>Ȓ�sv"��Oxu#qU; ��p���m�8z����8���"kU�L-�����m�f��g�*�*K���#�fZŽ�����.Vh���6��3m�G��3�zU�`"�x�r;�NR����=�.�غu�������k�ir�MG�}0��*�x/�e�y�07�ua�p�P$]�����=R{�Y�>�#g䓀�6О�f��`�%��r���1}��ς):��X/��ӦHiSû�4'ӇzD����T��j��2��f�ڭz��������^�w�y*����S�ЁMw� ��u>�.=�i����p0`F�l3���*�����w�p���A�����O΁Yx���w�h�0��V3��B���D]�"kpƑE��$��`�w�t V�`�[�XC��@�PoqR ��U��l���p<���cC�<�>��c�C���~P9PBS�0��܂i�^���E��9/�hn^7���X����"�|�Kc��%�Н\�&.I�d�R�-�&��zy��(�H�V��~(��/��wUV��eK��R������r�>|���)����6'�h6R�-���;��Z4���,*@��Јm�k/�M+հ0�iҀв��6P:�Q�N��4}�%	�\G]��ɒ�c^��Em���e]����D
F�!�x���H,��`��5������m�����}_8��m��'�l�a}�,�V��;��#K8�e��_�(�CY+�K�x���M�YZq0�Uh�U*�ޒ�|1S��Bc]H,�,����;9���tN2b�чN�_*��O���L��h]q�L������	`+�}�,׭������i�a��8���U�ZlWx}>�H[�z�:�� {^cY21T��;�3Bb���8�u?�{�e�C<���&zԒN�geI���uRÊ!1)��~[2ͱv��6)Xߩ΁V�1"h��6�:������}}���s�X�:c�E��ِ��d�R2�E�9�W���^��8�ylF
F:[���ds�4��w���1CЀ_�I>#{��$4ĚWP_C�j��<&�����'(A�Uɓ�sǪ���-z�_o'���E�8@W��Y�kH��x1�{v;S�7��Q=�@�v�[.�̂��IFie�eH��ϫ�fyȇ�ț�*�S�m[vբNq쪉>��I���b��yp���j�W�(�~NJ��Y���`b9)�D��D�	ʧ?�����/{��4L�����:�lޑ�#���Y4��YR��2�ݶT>���ٙ"dfp�MĞL�ѹ�/���NH?�,��Ae��}��~BsR9أb���<�kR�>a���'"}j���wCc�Qi��~�=ܨzV��$������X�?U�V��W ���8��:��0�K�����k��)�K���m�꾾�E��0꯮�R��_f$�ǳEе:�3�5����F�ئ{��&�t��5+%�	�D_��t�-��?��ng�9��hi��O���A�L�S8�J�hJAʊ��RG���*TL�<}	�
b�a�i��:�����	B��e|�fT��E0E��F���S8�q|�l�Q���' 
3ٞ�4OʡR԰���:Q�9*�,������(}G��F���,��%�t4=�S~o��!L��?M�_��%/��N+v��h�����[1�പ!�32��4z���:Nj�dժ�/1���^0	��V���~1+�Ȣ睊L��0-�N \���r�V|	P�v�">�J� � ���ςd�w�q0�V��WY81��b)/����w�ڵ��.��
�џ�$�	nN�'7X��VL4昔'��0����b�#_���8��ެ.�#ˊ唅S^�k`�[�F�,����Es���yU(��M��Sе�������]�>MK)�a� �w��y��X��    Fx�?�: <4>����x
�%�;pp���%j�B8�n4�|T�C�ZR�>���R;��H�]0��_zf�؆i-.��+���R(R,���eY>3s�`���N��A���y;�S
�*�A���7z8�S�&c�����y}~�5��b���]�XӉ����!���P���2���G*A#�Ϡ#�	�S�%}⭬U��c��]2;�h��X�XW^�v���ΒIX`^2�7%�j�v�ˊ�Yhl�e��H����r���ӉǷh^%������(��T*�
����7P ���vE�>�	�)o";9S��aŤ5��aIa#	c�ðM BO�i0TU�f��=i�]��+�W�Bp����/��Z�d
Cu��5�_��<߱��~�4ёL4�o9"�=��B�k�����b�p�hu����WTf#d����b+�tʧ�*z� ®�@�P���S�L�%w�8ɰd(�P�h�_r�.�k�D�e�,��1�NT߻�[���#/�W"�|�G9�+J��^
�+f�A
�E�j�#�Iv��B��^R5=�T����R�T��/�������;�E�Sa����t��S�Q#��_T#ɬ��o�C�QG^�;?�p���.�:QG$��2���E���Ql̒��宫�%�O�I|��rZ��D%0�}��tu[V^H�[h�R�l&���i^���@I�;�p�X�Zc6P�;c��ga��<�������A��E��@�/Ź�>4��u�4�qT9ɭ%��8����H.q����)�� VO���)}��<�����4v5�Z0���E_�v[b�͂�m�D�]���ӪR�(�c�[}�ܓ�X^�r�@-@4�����E�k��V�R�j�-I-|>�����$)���wX��ժ����4����9���3-%�O��zV>�N]6�F9����=�2�e[>�U�x�������~��N
�{R��*}b��ZuRk]���� �,K2K��m���o���I}��U��iY����v����.��v�~N�ђ�����'���x��F�z��[���yI�_l�����t=fց�!�=*�tP��M=0���<<^�
�H�f�E�G� ��k(�J/>.zy��R.�f�8_�yt{?��ˆ�p
_�<+vt� �c�-��$����[l�zT�Bz�ѭ�^� �����r��oY�;�ѥ���l<LG���q�#/<�P��FF��������ݱ�nl�ISz��޹�����%uw�O�`)O�G=*5� ����;�����4x���aۨ��J��HE̛�Z��Hי��B�^�es�&3�⫨���k�3��i�T.J:��>�>��&d7�#=گ����Ej���h��[j�Keq-��[�!�b��4��KGM� #��ß�[uN�r�/�5/��ӽ����Gwd����m,{+�ux𴿅�=�����n�ô�ƁHK4+���-��I�@���{�;.������p`��](F0�O�n�U��axx����������Aѻӝ�K"��<:@J�K��e��th����.+hO^��,���Gl;��4�R�6�E�j�V Ec�l���·����W*��V�Q6�αT��tD���^�-��^~�M��?���t&����B�h��x7������	*=L;*���&�h�ԙ��yN9�ca�,Fxa-ȁtGv�!T��«,��8r��`9"���.���g�E��a�@X�h��{~�wk�X�h��G
�~�$��i���x�S�2̢�����rd�P~ɝ�,ܹ�^oA�]�0uKx\�H���dN�w`R���}��0+���0���֥t�{/���^�N��{}�!�������{g ^�2^P�A�'b�08p��e=����\y=�&HGw�켵؎�ѽs�����-t�~g�k9V�ё��x�|� ��4ݸ��!�h��zV�k�3R���Ua]
��3 �������4�SO +�q�P����ER���R�dc��:\$�Q{]L�q�)�W��N���<3������$����k�ڳl�}���iP���}4d�����s�o�^� U����fH����� �"��2�fwĎ��v���E�0�d���6�<I���YdX��
�,"����<!�fc����F�ŧ�ժҚ�ya����C^��]�ړ�x�/�Z/�Jqr�(J�Sܢk[�z0�gzzz>��j5u�%�s����%Ǜ�B����۳����glXm�>���kȜ'�*�M��Gi�]�>���a�=�~1�,��\�⠊�5xQ�z�f$��>�c�@�� ׸ޯF�O��mCO��5)aB�jt�氖�%�へ�������ů�i�^��|���x��}�C�*���*��u~��b
f�G�dx�5�ëo���8�yE��?�+�ݎ�ɶ+�c��@�&�H �N�gln�b0� �i���0��xO�
��%ÕF#���oŊ���ݺ�~�
�U�1��lZ"l>|X��Bϗ���A�ˊ�X�	��mE��_��NQ��g���S�x�+���D�_�v7c��aEr�8��n�gl�v������qڌ��t�0�/J�,�}6Q������?�A:bY|��G�K�CA͚ ^�(��$��C�.���9���y)R�� =��PDXiL�
�K���<#���f`��2�`�B��8o��y�B/�ׯ��@S�:$㕖��ys"U���3����`�L��e̗�i��p?t��N���<���2���[e��3ⴵ��s�(*vt~��QGV�&�0��'nl�3U��@l���o��=�eR҂�\����ΐk�4�����aܼi�2��jڏ��\+���K��ǲ9������^�BǅА�R��u�e���<V�xq��n����]����R�(u�����js�D��ȫ,6�]�lYR��A05��.��Qn��ؠ�!V`�{�p1n�+����|0.�m�(������6�sE��.��2�&�+�v�ͦ���e�Sy�f]�o�R&�ː���?T~	?�>В�Hf"#�Hk���2� Wn����ھ�08�[A����o��R�x�L�:���K���n�^�{�K��G'U�+�w�7�=.D����ϟp ��+�RS��2���A\��#MߐE��8�mBcI���!۳˜�Wy��
����	2�`�Lzj<��,vWx�K{~�"ʲ��hsЃ�B�d�:�pr'�)��$�H��LM��b��X:H1g�0�`�p2=Mc�vvӯ�AG7m���დ�Ѣ�|W�S��o3-�L����_~I7PG�%9(��*�-��8M��Ŝ"��_�y]f�=�'Ґ,����-1���x�e��x�����8���?VC�`3�[��~��~IA<�A.p�$���ݐ�f�IN�s���$�v�`p��m�ˊK�uF�J穞wV��l@��pή�U}9go`�	R\��9�%[����r��H��H�Τ����{�>ʞ����,
�̫�*\ a�����+��������&��p�D|C:3�`g�bKZ�։r�w���L�����u�^h4��.�Ln�_�Ķ�p�C��������+����$���a���t�90���_)�j|=�4/���0����{Y�s(+�;��9]b�����[?�?��5�����0��o��RG��,z�z��M�J��6U+~	��t�����T$��� �����+�zx�q��v���*�}�]b�h8�jD�����]�x��H����|��a�6
�5
�@��8�|QM��Ө	���O��8Tĺ��t2o��§��m, u�Ê�G���/�z�$��r����KZN��!��Q�0�U��u�w:yۆ@q8N�0�C(����f��
'�9Y�:��>UК|t��0*��u�F{�C%xcg)_¤^�:A�,��Be�ޛ� }�k<�74'���¥�h��ټ�e�;    ��,����<�Ȣ�I�=���Z�r����w�@���ɊCR,�r���w�I�}תǩ;u����3�6�q��`!V���Ӥ�+�W��Ri��")8r� ��I�%
�u"���C%8  AR��S��`���,����W~�d�*mdb�N��m�lմ��ߐ
,���+�WD�g��XiK����NQ ��][�8(.�1�X�wu(�d��
/ە*x#o^iD���cR:�� ߆����i�`��� M���2D���h�;��3�5ؗ��sXu�=ش/6�ێ�	"�C�e��3^��y'G���߇^	�ԿS���H�l'	�;����V���zS:+|�0����Xo~��q���d��y;z��.��M��MR�m�ŲЀ\�k�����TL�)��M� sM�۳����f!����]k6a3v���%���\؛��2x_Jޢ`s��\D�ʜ��8"rgE�-0�w��x��5-���u�5�w�̊�����M�h�5�br }Lm�f5��(�)�gM"֌�1'y�T�8����{z�tM+�I5J8����u�]=������@�(x}i� .��~P��<�\T�9��y'E������|�E_�2������b�(R�m��iD!�L�|6N�!=cY�������|ᓔ�T��yMd:@h2d�OU�����9���I=�lx1V|�(>���CQ��+W�%n�ۂ[6���N��us$XUm�z�%S x��������-�nK�l�����DM�B1iDGNb��1��+Fg�:�zMA��kg+
�g��t�fqX��k�����˃�"�S���N��̄�f��a����Ӑ��u4�������I,��tc}WՕ��>�s�BVo�|�2���޺�`K��p	Ī�e&s>٬������K�����1�J�C�Վte=F��^'��z�=�`{�D�#����aѬ-�Tƹ$H������ �sT6��0�� ���G��C$�W�lW�hD
�":��$�C%>')H��y�z��n�e�!No��^) �H�zR]�řF[�$�������? w�h��W.ȹ��r��pyrA��"����O��S��Y��F��!��'�9h>���a(���N�u&u�W�{�0M�����^�=\ҟp��l\����b<��n\��N��}'h��;|��sC�	�53��v��@��_h穕i���Խy�#�q�@�j��z���|؍h�)�E7r�����`>y;�[��䠤~�)��\�.G#z���w,�����=���*�G8�lձ���C�q�Ud�3Å�������b�ӵ��C$B��`����ģ�#�\X��7yV���~����"�! ��K�)�\jT��� �*�����9g]�vl/�N�Hn��><⃜���W�*p�:���Y\�a�tLT� 2vi%�gr��V��J�ަI�z�	�|R��=�3jN�X�yc��)vt�zЁ�x�,k�"����i������}�*H?*բ!��F(�.Z@ґ�����>|XY��_���8��������9�:/�D���`��l�2Ѿ(>_v�eI������>^8nޭ���x���S���s��Dޱ�S{/e��i�m>���fUm��볳�N��l!\�~�gI7�6�E�vэ�v%=��90�I���ˠ�t�=QԤղ�����E-I㺭Km��)`
�t�9�B8q
��+�da�dY���1ܠ7���DV5�a-��Yx9Jע{��b�ཋ�H�I<�ĵ�o納ǩg�f�� ��J�Ij0����q����|8y����8p�F$�E1hG���8���8/[�2YZ�7B9߂9�����c��8Ŵ���8ɡ��7Bܮġ`���Ć���L���^,�D_$fNn�4�'����=?�ŋE�S�̹dp�Q��FFB?��#=L�v޳G�Z��
aJ�-'
��Ѩ��6p�z�=�5�����?���y��X���fy��4x�PJ����+JJ��@�:O*�����H�ؚ�Aa������C����ס�P`V̧K�)9H��8�h�e�] /��>v�P���l���sA�y`��I��U��7�2�R.��^��#�p��-��M����ҝxG���"�e;R;l�}&r�=��	�'��RNY�8�/\0�8D�//|M�2nf=�����C�$���_�%�&o��7���O:�gUo-�>�#R��n��`����
l��~���lg��Af�+�[ێ�`�=oc�j�%����;o������1{e�!��t��O���+zG$!��>�����@�.�ƨ\����髇Λ��`�r�V�^��t��LoFk��-�i-���G��+�����"l�2y:q��M��A���)�&�;����h89�T�E��K����z)��S��N}��~�:���G�� ��AE�G��M�p����j��X�G6U��o��$\�R�z�K��.���nԍ �]�)����0���p@�Bz $��Vn\,���\�3�b��'�N9��3�x���d�t಩���]2��5�m&�t��F$���џ���v��4�Pa��6Ƃ�h?��34e�鿇 ���`>�]��Q��*՛N�ݖ$���a��+;L/�g�L>qǁ'Lb�Uo��6.pMŐ�c���G�4�w��ip��5w�XS	��Smd�EM�p6=u�.���4�NY\���߯
���c�=y����L�](�[h��N�59-�#j�9�ج:D���k��g�|�`SȚק���}����n�&�`E�rf7��Y��iq��v��>��!�4�=P#��W,N�>�� �]�C�ER^�������I�?g�Z�±�-�������i�B;t;^
]��͔�s�=Db��^�tTO��.�dc�>NF�#{2�ah�ׇ9[R��f�ޔI|��?]#�{|0��]���y���a��3���NH~��͝�+���T�wЋmY}��J����ou
6s	Eo�d_�'��:_󊺼8��J�ŹÞ3CR�j9�Pc���I�a6�}�Av�-f���r�W|�ܔ�?X"�0�2)}B��!�s���X-'ϊ)��F�&q�ƴ�,�jO�Β.����B�v�`�ym�jIf��$��0H�fu2Hg��P�����ß��2!甊��\�1c���fr�H���7�ކHx��'�h���Q��>�'���Z\��Q����� �Q�zgf�Ź���"�g�h�q�ż �=G�8���B��3��|�>��o��J��D!�S��:�j�` ��#`3E�8P�g�ap@x~qr�E��K��p�B�v�dN�a!N(/X�� I����b���!��s
�N���N�e�_��̋Ŗ�Y7��܉�pa�Y0| Sa��I���m	'�3�P�I��?�at�l����ay^FLn��Kn§c޽���5��"<�<�c��̇�� �O$�r^�{�x����l�M5��ೈ��A�X�Z�8�ڇy�Y�p�x6�� 1�!=���sڢnl>D�������'-���.�z�m��O�"=��|�[�*.Wx�o����8D�%��ǣ��Aggơ��wC`��&�����w� )�q���J�2�J����X��p�@��y+���j�N{6\+��ٳ.��x��B 9�Yu�);Ψ��Q_��Z]+��{�F�B/��t� V���c�ݏW��8,�=]�^>��\��CI���0���FSo��Z����ΕbBlO]��,���Cq�B�jk����#PJ�:]mo���	�v������\}H1'z�y�|q�B[�s"cN�P��Щ��M5�{}����8�9�+OO��zQW����)Wm<�Y�'��ˆX�D�.�B_���I�$�汔K��Mt�Y����]�+d�M[M�e��\=��a�0��,�'�m�A>��i�l��Nol�]�X�j��Ed��
   �"�q�j)a':F��kͼ�
,��͕OH1'S���8��}�A:�A '>����VJ�LX+`�bٜ�ݲ#�x� 	O�9\�ɰw^M-OJ�sՔ�'������6Lꭨ�(�`�����zAa"a>�'���t����a�	�^�9$�UH^Ns�9\�`9�7�9���ڤ��D`Ar��=]�y���m�l�hn�����E���<U]�H�����:o��j�厄��"�j�m����~sK�-���������ؒj�o��O��/U�����y��y����hi��            x������ � �           x��[[o�~V~�NteQw���e�f#K*%9�/�m�g��HӃ�?3�m�����0|���R3��pY�6ox��lU�YԺZ1���sr]��n�k2o/��[����6����~p#B��C��c�A蹡%{�U��º��Zm�7L�i~[E�f�git���%�k�&�;u=ۡ\�v�{tWAO�#ڵ%Ъ!����'r}arxSJ����X���$���Pǚ�"ׂ�UY�H�i�
6٤Y'�B�S�L���a�|k��T��J�
��Q:��5/X]O*Q.��a� Pg��C6o;��|��,��F��m~�!Ê�y��\�<�#�ႭY���,��e�k���Y1G��a�1�J)�$��^d >���YYl��̄��+>��*A��C��n�@�`|Y k[4B�כz���m�I�0� ��ٜH�F��(T��I��m�;YC��WiΛ�IoGQ�J?IɋW`��G����v={*�3Gq���T��pw�O��j҃�C������yZ,�t��yg��iHi�Y�6�\�-^��X��p5���O�kˊL��1�. pm�y!��}#������ ���v��Xk~E�����0���ڵ�O���>��b��y�>6 ١ϡ1a`��N=��Bz�hҬ�����<��ha,�5;�c!�(#�;��'MIzΟ5�hJ�i���x��l�M��݊��ʍ-\&�ewW��֎y�%ɗ����4+^�KW@W:��+�:s4��]�N"d��y�0�F'��}٘in�x�4m�u���V"���*�J��,����T��Z�[h0���M#ඃ��1F��)�1~l���%L��	?TޑH@�bȴ��oY�^�
�u��"S�ڡO!
H #�T+�|S�X�����q�lq@�=���F�W	� ��P�2�:�CB�����[�@���v2�DT)���8�b�����J�4h$�2�˂�|�$��3��n�"i-�P������I�sb\�'pa����au�=��#�9��uζ�C �S?�]�w`He�
v����6�&����g~����Rےc�Y�]�y��J��ϲK��ՈVe��ݍ��Ad;n�D���#�_���J30�r.u��7��I�dY|m RSj"Ǿ�2��ώ턱>u��|	�~/�Pئ�~曆�m>��Y\)}jR��}��j']~t���g�i�j��2�#�c�ڨ* �vF�K�%GS].U�KL?��<?^B���Dն1|ؐ���"�M½���d��#ve@�H3�KGN�@�@��d�d�M44�湀�T4� ��Rd1W'XJ���F�dQ����Z����m�<�\�j��p2��S;hP�QE��ڴ��i�@g��u	�L�Y�0�fN�K"��K�k���"�i�㽓d�Y������V�C��}���XI�b.�9�2K	����N��k�$�"� �_�U=Y�y�ƂH"E�_�\��&�UZ,�$�ئH/�V8ɩg:�R���!$Q�0����q�k�Ĝ�_�G�)���k=U$�=7��E$����.�Mɥ����}q��Z�e�	Q#?ݎ2������T��ŌnNN�{B�(B�nͼB��&��
��f{��,��}����n?���i�z���L��9|v:Ԁ97l,=+����؁�{A��E]RW�AQ70Z�)�)�R��&ۀL<^�GI׈r�{Sρ��q�D�Fr7�jG�#���x�m"a;N���c�2q��ّO=7�R�V���w�l$�8��U�d�0�&�b��h�gٞ�������V�b���j�4l�ʒ�-�!@k�`����n8|��Q��4	j�ƫ�������=�jɬb�\h>��8�-�֭J�ܪD���q&;KM���yy�]����g��1�|�~��_���T��H��؈�����R���Ʋ�D�m3���	�h��`����Ʋ�VׯC�i�?
<p}�Px���7�C��;|{���A�dAO=J��uN"-X�և"�=r�(�n	<��A�לw����rP��.:�3Q�y��щdw��}���9�`��x��N3�1R��q�;֪u�.��y�1�����&�"˞�q�?�u�.��F��YY^�ʽfͪ�k�4�S��n�&A�RV϶�{��9lR�i#;J";(ɠ�j�פ��US��ɜϵ�k�~V	]:�"�Q�
���Tt�Y�V�4R
�(����Z�q� �M-i�:϶͝T9�WL��X0:��qS?�*���-������z&�?�B�8@IS.v���B̵z��>l�}<.Z�������o�u{��������N�?���EX]�Fb�����yՖ��x\}m4 )y�^�����+9�����Z4?�ߪB�*�x1a���E��|�mm�!�������3������ÏSEؤ��0��)�p��Ȱ���t�ӏ�9GO���L�m���kC�d�@���(�MY���(�H�qQ�J!B����X s�����N�hZ�N4;诛�l��A�xJXY�e|���9^���g��sY�C���B�U��Sf�k�{�v �nx�'�fu����[������[r^|#_oo�}�=�q�Ө��4�>�:���� ^{������(x�{x�v�C��f�VC�?_�|����O|?u�%��� fRV`v�_yu������_����f:V[���O^�x6�T�)X�����_o���c�Ⱥh&W�y���S'���L�+L�_7_��ٷ�r>����oN՞Ox��^ߛ�R�j��`����ʺ(Hb����n�L/���኶C�娥fO�FQ �Fr�5�x44Ђ�2��1�m���À͂�2��J�>		�H=��E�0/�5x���9z�3^X2�-u2�y8Mf>X�=ܡNƮ
� �=��E=ve�l0M�/[�e�S?1Q��R=�h~�`�n��7p�}�i�	����Uw����p�i�#5��*�A�Y�ø H��gvŀ�A�K��JB��v����i7=y�d�ZViM�в����O��V�S ��E�(�'�hb�0I@o��{����w��br�8x;��d�d�yʀ�d���u2 Crp��4�,g]�A� ����I�]B^�/�����@�K0p)o=����������3`����O��}�0����W�`���[π����k$T�RoJ};��`�����mP��zD�g�!��1uO�^H�k�h���t��<L�.�^�\������A��`t䮇��P��43:�����q�B�:�]�:�%���M����͒}ZX�'��R�tS�H�UV��I��xW��d{�A>��R�r�6�9��sJD��������,��F&��^̊�s�PpP`�H���X]����e�0�)�5�yY=鞏>�Q�x��6k/�yQ6Z��S�}�B��a�(R�`�̦c��y�n@px]�ƧUd��?R۝m���m�l�X�uܟ7��]>�;�r?PS%���^��4�O*�P�x���Y�'q�-�{�I��L�6b�k�M�5F�����>;;�?�p>�         <  x���[o�Fǟ�O��0s��ii����E.E�-�/JL;B���~��rJ��5bh�8�����c������e���j�a#�Ç/��l��̴����:�Y����a���3�����SA�1���;�<�.VM�QnM$���.�j�g�f�c���n�<������4הw�"��L	<�<�X6E=��r|ǻ�W#WĤJ��U�_X/�b�P�cVu�4c&%)�Vw�}B)��^�qM���(�a�[��,}�X*	�ڽ�b��1˛�z�,ܶ���a�)�TQ�_�cB�B��[_�Je����P�L��VE~7�k r'�7�ԉ�7E�� ��� ���2q �����J��E1�Bƅ��\g7wS+�v��!��:����isC�t7Rm�w������iV�6n�T�3c��	��������v��~��~v���߽���#���NR ?����M���TSa�� R �[�V���HK��������|�m�{�X��������Ț���"�WM��yc�~>lv	CJc~u��4�2̗�������$��wlX��p�ܑ��������Q���L3��Wp�Ǉm\�^�؛e>�rx�R[G�:�H� �\��,�����֜p�F�U�g�G�T(��VW	G��]��7����`g9RTx[6ed� ��BD���r���O�l!D b] �z��:�\u!Ǻ ΋�� RM:G���xU�X��R�x�8ֳ�g��g	@F�� ��,@�gQT@�ipU������%+��.*H��Ws���)f��3d�Ζ��q�V�H�"Y�f7à��xH���Y�\xy�Z���e��l�@��������R��V�t���m�ݥ_���u5��v��X.�����D ��6�+Bԩ�X绞��D �A�X'悐�Ix�<���w��u<��]r!�:ܼ�X����!UR����w0ͤ72�D"�t�l�0�� ��!��/�)�R�t,�8�zIX�Rɝro�=g�_7O3����~H$R'�]MF�3>URie"��p��R�Z�S2��$R��8BEXR&&`�khH]8���A^��6����)��wl
����Q�e\=@@&L�B��^�+�@\�@u�\!5��?7��K`	]�ux~j�B�cI���!kIRM]V�G!8��
��O��� m��g�a�G�k�H��T�3�LKJ��1�D!E���<�poj����"z�,�ٱ�
VDn�� ��O4R! �����U �h�<��gɮx	,�:�9�(W�q��\.��H�8`��S%'�R���F��4ȋ�se~,6jl�d��x�� ��>����+�>L���6�H������aD<�f�e�Ԉ�ND$�;�z���X�*q��L:����7/�� ��3�y� 8I-Q�+4$�����7@�#�u{xy-2�zzx�8�H)g`v�R�0H)�S���5á��:�X2����pM��ér'*���a4.�5�t�7�{����`�X�Fu�W���p�q�C�m�X�୺;�HF���BPHg1&�M)�h1p,\J�D���;���<n��>�����y�e羁T�D1�"@����*�H��K�=Y{��s-�9Q�"(��Z�`�H5M�iZ��p���[�,ւ�?G�}�oJ��b��(h�[|S�5u���O۾KG�V�m�uG�D��C/�`�& �e�"I+�D�t�*[~Uu:"��.�"�5�n���.N���#��lUdU9A]���x���ɧ��~�g<�y���cQSj��s�s���D��	Dl���&��<(�b{�x[^N�ڊSc�'wݾ��P��;Ĕ�ǥ�NyVU��MB&������,���α�Ye�3�6�����*��b���\�k�i�f�a�NE�
��q{��9͹�f�N�
���%�6ǝ���Bx뒆�Ǉ����ױ=[�����b���!�U�2j-�ax3�:!R�=o�#�C�DnI�o� :���@w��CD'����mQ�ǈ^����|����[�N]���Վ�C�����Y�K@c��0�2sSưn��U#)�-��t=��=�r%��k�m�����V����O���*lۚ�m��W6|#�oۙ�o; %�.QH@l5�h�˫!�^7�!��}a�=<�π�v n�f>���T�O��SF�]�x³]�\���]m��S�O�-�h���6��c��;�9���g2	/Uz��ؙ��)��~��i���c����!ݜ(���c��<^}��GT ���{�2�i܃��y�{x$�T�&�����jC��=�'>~ ��gh�'>^�F��&���891:��ؾsl`�G��Wxƈ�x��D��p���s|,�(�Q^G<cHc<Uq"���!9����s$�D%m��7�j��V��ۏ����	�ۃ�f��#7-|˒���ێv�o�����C�����汐�}D��ibOl�z*�	�ǋO��wO���
��ꩈ;�0,�)l�z*���͂=����"�@��Ȑgb��٧�D)R#�? �REˬ���nx��6��q�pJt�l�u<�t��z�g�?*p��ms8x9b;ի�)&$�L{� R+e�O�oo�A�d����О�Ma;�Y]_5�M����ӟ������v���C���=��m�<8�"R��j��Y�A�F��u�K��n��v�����v�uf�ن�r8aաy
�U�����(6�G�d'(�Η�uy�Pl�,��Q9�N�&Z�e>��o�M�!�������O���q����<����zHd�:k}�t���G�2���~ߵ�`?��&I�?`e�W         G   x�-ɱ�0������R�t����a��_�A�'��b.ͭ|)�F������j�W�����      �   p   x�5�K
�0��|��4�k�&��j��W��A�Y�331ЄQ2G:��;l%v� o���^�R�Z�7ԫ�,���ϑ���52}#�n���Aa�4���|�n���9w��+�      �      x�՝[WG���+����8BR_���9+��x֙s�:/mP�fd��Kf�'���:@��X�K�X�����5�%�Ě�p��խ�E�̊�Z�VUu���޵kWI�60��s_����uy���N�w�x��p��̿�|.���i��~�go����g_{v�<��� �S�ӧ��IV+�B�����n~۩5����]�������A�6V�(Ē��!~ԿP�H��X�7Z�H֞���X�Q_ŉB��'�#���ů�&��dۻ� +N޶��x�8�ء�6VXN=mㅵ���?jO^l�����PG�*��N��pl[��g�5�ی��I=�x�[_ne5��=��{fs�s��m��8u0��d���`����*^�1���fm�0<�������.\�v�Y6�{6�*ZΆ'��h6],n�7O�}(�����p���gE]�E�l��`zY�m�x�ޫ���U��1Ɇ��u��8hφ^g�s��H6<Og����k�ev�2�-�y��ʬe6wC,ɬ���l2��ۏ/q�0�Ie63˙8�U���Ϥ3[�m��XXf���6���^f���8\eA�!(�\���w�X6~�K�W�I6<h�d&���3����3���p�M&�g�vµ���Z�J�r���N���zZv�̠��$w�_(���/����w�|;s�U�q���x��������3����7�q�s]��6R�AO���.��˼lrzٟ���	� ����G���3Rn�^���5�uA^(U�
O�����&��~pk4<�;�o���d�}�����E��b�|/:��ދv�EC{����^t�ޯ��)�M�'{�m�~.��ĕK{����4U��ّ�\��j�j_Ca{�YF_�c3�T��;N�TK����� -ދ��_,޷�՜��1}c������n�(��?5����#���ԦB�V�?�һ���p�{AX�$�0��OB����������6��GL�Yi%C`���&���n�� �"�?��cX�����^A���Ő0�B���WP#_�>vN�$vt:Pr�M�'q ��-���u��Y���<�!���M�Cb�)�+�G�N�`;��d-ޢ��g6��l����l��<�%	0нx2�C�ʬfҧZ-�d
���UZ.�ڮ2�f���nz�.�T7�o��Z��-��+�m�Z�I����{&��k�D�A���x�������hx�z��R�1YG�U����lx Z�[.х�69��l�9i����퀚$��ݪ�c6���A-Y�:�z	F6F*AcB������
ED��Rm34o^u�c	���9����ƀ�7Ӻ{��#�T�S��ʾׂ?�� ����Ư�6F�^�ƿ��N�~�%\���kvz����
0�b�����^}�-�>;\=|�>�y�?[�֒�� �8-�`|;<V����3؎$��x[�IY�d&c� ۃЇ�	[c4���BK�
�T'�]o= )L*���\~��cG~��s.H�:�%�r���S*��p�� ��~݂^�E��� ���&��IA��[h�gy�: �nf�e���$�������"�Z]5��n�7j~�,+;�(,��h��*�a�����`����W���8@�2���oAS�ԥt���*���2��p/n�Q�bq2ZOT��k�:�mƠ���5�d�Rb�;I�}#<N�k
"�2��_�!��� !?LT�n�`un@����n����#W������*�\e�^��c]?�#�#j�O\�@��l.�����rt�b+���G�&O"up���Ώ�Z�\"C�8ZhB�����
c��E'�yM�@Ag������S76Z
@A�^6�/��n"��M�_A�Ua�˝Z7����}�u����ϯ���p����K��`�.�>�[�0�W}�@��]y�ұ�.
&u�{�u���NCNX� �c�*ư�c-6y������G�ε�t�d�Ս=Ub�c�ݾ2{��Z�z�T�9��w�^��q����Ğ�9��w���sX�*�XU7�=Gsc��a�ae�c�ݮ+{k� |�y����[9�X����
��o���dc��Y�W��*��ţ��;�;>Ku��K�x=�<ƠC��*&��_�g�P�.tM��)]��W���*���r8�*'�"������i��6؜�2;�^�ʖրI�;[A@�>�4�b�b�h���{�P�l�aA@k��Q�d�ҲŎ�#��iHٞ���:��τW�HX��JQgn��� ,[d��%��Fxg�^�㨖-
�P-ʙ	�m#wf��d��h�U��E�יp�x���֚�ƿ���W�"�h�1��pc0�r)�|�Bp�7�	n�<�l�*<����ɮ��!�7/�	G(s0L���l�N�"��;�lX��������^��*\�� �j+�>Q�S�Pb^Q�V����1d�A���3��@��+����T~dl��n{��A�n����6�V����������^=CDnP�T@7�~�=�'��/�/G�z_����c@�P1�Q?t���}��8�2۾�\1g��!�#�_�V+V��Ɖ�)Aư�r����b�Z�Ӏ�D|�0����I�$uS��ڱ�*��V��u�*㌇���;�����zOO��1��
S��h��0d���#W��K�fUk���́���]�:?_��"#�f����I��=q]`a�<�[��i��3� .R����W91�_�it�w6Uƌ{̺B+�#����s�6;�k5=h{��Уs�d�R c=�Xx&:�<�w+����&c%�����1�u�	c���J���I�R��3�@�ԅiV�R���R��a�r3�v`�����6���ά��v�`O�T���������E��V� �������Ab��m��j��Z��y�A��@`~��ۭX��artל�x�``VO<�ߞ��D����n:�v
��#����߭�8�!K�[Y(�֑z�kC�(�􊰎�-,��-\�v	k���.B���芳>H�����w��d�Mfˁ�� �}�]$Et襀��) ��w
`�X� 3�q@w
4�&E����5�@>��74 ������NeV��*6_ŮG�U=_?�AUb�ԝ�-�y�%� ؍����{�|	�A��.�����i%�����D�#Y�`� |���������T{n�)�v�e�S�1�>�xn�ݑ��"�+v��2=G����x����߭��1㥰�:z:dҋ�K�w)�"�g����}����<�G8���1�k?=��j��e�y���#�Cq6,5��]~P�����|z��2�M���n&�_���+M��%;-3S�� ރ�C���E�x�Dg����B�W��ba(H�\��Q�\�?=�.h�$�%I�B@k��'Jb��J��S
�2r4 ���A��p�0w1L�A��Zc��4W�Ư�v"��2��:�IȬ©G`���y26Oe߶��~:�"�9�����4M�l3S��\;��9�%x�F]%�Y��iqk^�-�t���lq�l�.��u�t�a���(9*Vae��i�g9�|1y�O1}c=�8��Ә�x�{��>~X���M&Ҁ�g����� C��ⅅ���4�&	G��G�`yh )p.��?{y0=������MB���aS���Ï܀�IvPKP��ƣ�|���ݝ�.|Z�K%[�2#�o˔�?�h�p�:���:�%���,}пm/[�Œ�{���6l>}�����*x/]@N?�����ڀ�-�/��P��d�Vɬm"(ׅ�l���S>���jq���(�=����b���������3ua*e�F�s�'78�A��
�� ^ ̚��,c�0D��S!��L.�.������#SY�RlD^o��X,3H^hM�����e؍����]�2&՚V�W�O�,Bb�Cg8=e��}�]���<�$�C�.."�"�:K�7q,��ǡ�6�ΙN$+x
�D�":l�4Mq�P�qU-2d�re�2+uB�2Σb �  �f���WK�[����Ϗ�in�bc8U����������E�t�k���:��9WP�c5V�Z����2�]��MN]�AE`��->���|9~
�%pTd,Ύ��	��4}�e�x����TQ�P�}�����5y��A٢�vf���'c�\�PU�ND5AC�4�Y��4b񚲐B�tY�������*�f��g:h1�.<��D��m�(��?�@��i���ǣ��/��u�A�@���bZ� 0�)���I ��hB?�.P-�~��!иG@�� ҫ�����ս�kD�F�A����
W{�{N���� |A��0��=���P�X?*���H~}^��	�4ޑ�}s8:~���B>����� �b�C�a���9�)��yaa�8�F!�a�f,>m�����u��B��%�j�z��}$�P�Э�mE2�����mpC��	�nίhT	k�M�@y�J�:N�[/=��X%�S�q�	���O[Y����K��}(_�D�5ӱX(k���]�����Ӟ�1�IV|�]���i)n��_�I.6(�YmQ4���<}i������a ��?��Q�T���ޤ�����}� ^��n�D���,7��Z�^����w=��i+�m��H����9PA,��W0H���F_Я5;}��=5T�'��j*��ц{m����[�ńV9l�'�����-����Lܮ/�ꏞe��_��A�� ��백�������T�����?�8����a\l���"��ȿ1u�'�Cd�ԎÊ������b�/�a�SpS��5e͞�SpS8og*��NЪ��Æ�I�rR(�\�`%��'J���[��!��2)��{?�D|�2��c�O�m���5"���s��P&Kb�c�B�	��I.Wy����>)���gJ���G �UwHx�ʿk���z�������$�W�M��q����Jp�@q�ڇ����*�ON�O�U_�t�,��"��g��=���/��4����v���	z�/D[ꝭ�TF�h����p����G֙�Dã�1�������q`A8,뛣p(
P����dY�w| ã&W����:F�X��R�T0�� �?������$���v�]��̓�E�M1h>͠<ji�Ҁ�H�� ��-$����Ԏ$Z�
����ɉ[#�M�	����O�_�����A޷��4ėO�bņ��|anQ2K[�m�� ��ѱI3�>���ٲ�Sޗ�j@�ذ�ʿ�#�c�ia�/����+ج5W�&��/h��sy���
�9p�"	��	6?���q�V*�+����~���>�T+��0�9Ol�﯏돧�AO�`������xV,��󳇘0:�.�%q6�ʡ`ŷ���ǡ8?_�6�0.�@�����Ы|l1�aƋh[mR�1�F�ײg[%<QcrE�&sA�h�!ku2J���o��}lNu�Blն�ͫ�����N(�LP�F)u1�JC���ypVA�)�N�	yw��y�3죂�Ҙnv�w��	xo��"��ei$SC%1�y��˶��x���:�s|0?M2���=��V���9�Mf΁��H�����������3�&��1z6e�m���+��n�����HAP�yb�V)>�;j���m�{iol+�A_�c9r`{���81���_B�i"�
�KхQ2���������s�������ό�cX���N�)�J�2�� �?�>HN�/��������G�|T�U~�}}���j�"l��0U���T�]<��a��N���Q5WpUq"U�
��H��5N��4������
��Q5W��Ñ'&W�#0�*��X�]�8�Lb�w�!��Y������E����@g�808�1�<P���{Ų;�b���R�R���)onG6� c͔���e��g�M��̛����84S�f*���X�J�	�]�Yq�4��q��fw������kqy��~7���X����cJS~#�Ǉ����3f,�?ǰJ���3�0��ȅ��R�(����׭���ç����lX(H�o�IA�9�b#03��Xy��ظ���_*%GJ)K�Ď����;� �IR_\è�&a˔��dl��P09
��#��_l�a��ܤ�ݸ3�����g Ƕ���esǇJ9�%�rc�D�9����i_a*�{�=Sn�������=%��0~�b�v+-o�P:
��8gCbo���'C�6��/�	;]n���N�U�V,	%�!�po)����Y�,��$�==����զ?�6l)�1�����*R���=%��m��}+��^.�ݎ-1wR�>8&޸*�$�����"���uTe�_V��e,�D>���ܮ���R�y�c�"b�b'���巗s�(��_ݕ��tɂ�뚻NK77
@ٟ�1�/5`�q��B�'���p$+��P�Ut	$õv૷BI\����py���@HvF�o���(�~���MZ����I0�f�o�0��A�#I�F͸i��T��H2����P�I���s"#mƜ���.���`-k�g䧔E�x�"��xėEI��_��V�6�jm��'�K2�r�-(�	o��)��I3A�I�=��`�l��5�$������.�����ה̙�;^�]'.����m6QW7Ҕ6����|.�ͿҚ\nW ��U>[O�	ʵb�f������p~�����~jQ��i������r#�ƛ��hنU�y�b�Bb�0��e��D�)v��:���9&�vD�w��ֲ����Ά6i[��4�M��̆6��m@���\lј�oj�e	K���4���#���3�8<_�$�Mx���\��	0�,��>ݙC��Aɮ�w�N�<}~%e�ÎF��r+�n3&%�7]NE�B�Q8]�-��S�X�4c&�������貂�G�2��)Nʼ����4&�"�p�a�3鴱>��צa��e0�׬�H��n�ۄv{qy򺋎�eoARA�
�D��)2�yQW�	���OֈȠ�0i�7����3����ba��g����Ț�(�����Q/��F)�h�
��t��rf�K��7�d׌�n�i���`+��gķ~_b_9}�:0���ś�Aw]�Ŏ_�Ky D����ҏ�8�*�i���R$l�Z� !JƅF�W�@)2֤��}��"��N�g�=G J,m6�k��'�#�q2<d�E�Q��W#S�\�A�.*�Y������}���M�L�y���G�o}�,�8em�t`qU���g��:8d�g�S�`�U�d%3⯘Ll�"��K<n<�d<�q(4)V:�h[�T6�E�}6�-��5�lxJl>^S����bCFz��$=�@��Xp��.�36����I�5�_�b�ۍQ�w$���)��e�>�M�Ho\\R�zH6Bxdo/Ņjö�4O(i�o��S��P='�A+�e�L`�pÖEz"�\��뢄�M�h�}�vlzf�[��{��#��
�������C�I����G}�����      �   �  x�͘Kr�6���)�L�!���d[vel�$W�R�M[�e��H{4��F��3�&9I$%k��
e�U�Q6>���ع�#uA��(� S��FSN���(2�T`H�1�$o��%��I��, ,��Y�A@N䣠N�?I�����Ԃ����ޘ�J�"�_�+�/dl��+�z�
� Ѹ�kӡ��=��N��kC84�,j�4��[���J�a�flCv�,��*2�󌧝���^L���P��V��ʓ��8˻�XBF=7�U,?�
E�`B꼔7�q��.!S2�W��#�UA��(h�XԀ�<���dR��,ZW���*��Ϟ��I��5N�8����.�W�O����G#$t�*���
/ςt��mD�︆�qei�5\X��r��\��i/C�>H>�i�C��Әg�K�`�\�uQ����lC��]8Ywt��ư?����XѮNDd{��{ FdZ.6�|��ѩi'�/ܘo��]�����!2�#b��+TFm��sx|%{���{�)�<0K:=/J��7�<z&m:ȬSRNfE��e��.�辴�@�����j�Q���+�1Z��zye�}P�-�B�zʶ���P�xc��=���ֹq�g�[νW�R-�����k�*���p�v6�$�Yn���M䯨}�S�q���K��х�W���ߪp�f��=F=�������h�X��0�a�����Ž�,/�����'����<nO��DJ�<�]�)Ħ!���>��EP���SmtdKa�b�ߟ��SҜ�x��0��
~mѮr�f5�(�
��*�6s+��A�g�d!�;,�v}1D9�����Z+��J]G�:9���cvkx �`�v�=�tUs�XXH�}�+��kZCK��8�	��>��_W(=C��bLQ ���R��N����2�l�|Y�s�}�lb����Uh9�Uڥ���)��4��F�X�������E�(Vnl��>q�jΧ��7�z��{�;8�ᙵvl��it��(������N�~����x륮f,��J��۩��I���[�\�N�Y`��,���Lt�� V�itK� Ox�1��ў���˗�]�]�\�B23%��3��C�v�ui�Mʣ���vH�GϽgl���qlt����:1H���5��y@o�
H�e���~���Q��      �   �   x�]��N�0E�3_1+V���{I$PQ�bc�)�h<alW��q��3W��1p�4������c7��Tu2�J�&�>�^8>Є�S?����Xm��K
Lw�TrN/��&������U\C)҇������B������ȇ���]�X�b=��3�A%���)�j[���̡��.Dz������8�l[�V��,t��:�>8�7������l�9ϗt�����������B����+D��n         i   x�342�L�L,)qH�M���K���L,NIa� �PG?� W��<� Oπ O?�`�?N##S]C]CS##+Ss+SC=KK#|R%�i��ũE\1z\\\ �V#     