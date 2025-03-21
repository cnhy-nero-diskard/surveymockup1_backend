PGDMP         )                 }            survey    15.4    15.4 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16436    survey    DATABASE     �   CREATE DATABASE survey WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
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
       public          postgres    false            �           1247    16928    survey_topic    TYPE       CREATE TYPE public.survey_topic AS ENUM (
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
    'FINANCE'
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
       public         heap    postgres    false            �            1259    17161    anonymous_users    TABLE     �   CREATE TABLE public.anonymous_users (
    anonymous_user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT false,
    nickname character varying(50)
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
       public          postgres    false    223                       0    0    attraction_types_id_seq    SEQUENCE OWNED BY     T   ALTER SEQUENCE public.attraction_types_id_seq OWNED BY public.surveytopic_types.id;
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
       public          postgres    false    221                       0    0    country_names_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.country_names_id_seq OWNED BY public.country_names.id;
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
       public          postgres    false    237                       0    0 "   establishment_localizations_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.establishment_localizations_id_seq OWNED BY public.establishment_localizations.id;
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
       public          postgres    false    232                       0    0    establishments_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.establishments_id_seq OWNED BY public.establishments.id;
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
       public          postgres    false    243                       0    0    hf_tokens_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.hf_tokens_id_seq OWNED BY public.hf_tokens.id;
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
       public          postgres    false    219                       0    0    languages_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.languages_id_seq OWNED BY public.languages.id;
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
       public          postgres    false    225                       0    0    locations_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;
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
       public          postgres    false    215                       0    0    municipalities_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.municipalities_id_seq OWNED BY public.municipalities.id;
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
       public          postgres    false    241                       0    0 #   sentiment_analysis_sentiment_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.sentiment_analysis_sentiment_id_seq OWNED BY public.sentiment_analysis.sentiment_id;
          public          postgres    false    240            �            1259    17317    survey_questions    TABLE     _  CREATE TABLE public.survey_questions (
    id integer NOT NULL,
    questiontype public.qtype NOT NULL,
    survey_version integer,
    content text,
    modified_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    title character varying(30),
    surveyresponses_ref character varying(10),
    surveytopic public.survey_topic
);
 $   DROP TABLE public.survey_questions;
       public         heap    postgres    false    945    954            �            1259    17316    survey_questions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.survey_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.survey_questions_id_seq;
       public          postgres    false    249                       0    0    survey_questions_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.survey_questions_id_seq OWNED BY public.survey_questions.id;
          public          postgres    false    248            �            1259    17394    survey_responses    TABLE     -  CREATE TABLE public.survey_responses (
    response_id integer NOT NULL,
    anonymous_user_id uuid,
    surveyquestion_ref character varying(10),
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
       public          postgres    false    251                       0    0     survey_responses_response_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.survey_responses_response_id_seq OWNED BY public.survey_responses.response_id;
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
       public          postgres    false    247                        0    0    survey_versions_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.survey_versions_id_seq OWNED BY public.survey_versions.id;
          public          postgres    false    246            �            1259    16456    texts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.texts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.texts_id_seq;
       public          postgres    false    217            !           0    0    texts_id_seq    SEQUENCE OWNED BY     F   ALTER SEQUENCE public.texts_id_seq OWNED BY public.localization00.id;
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
       public          postgres    false    227            "           0    0    tourismattractions_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.tourismattractions_id_seq OWNED BY public.tourismattractions.id;
          public          postgres    false    226            �            1259    16750 $   tourismattractiontranslations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tourismattractiontranslations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.tourismattractiontranslations_id_seq;
       public          postgres    false    229            #           0    0 $   tourismattractiontranslations_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.tourismattractiontranslations_id_seq OWNED BY public.tourismattraction_localizations.id;
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
       public          postgres    false    234            $           0    0    types_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.types_id_seq OWNED BY public.types.id;
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
       public          postgres    false    239            %           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    238            �           2604    16527    country_names id    DEFAULT     t   ALTER TABLE ONLY public.country_names ALTER COLUMN id SET DEFAULT nextval('public.country_names_id_seq'::regclass);
 ?   ALTER TABLE public.country_names ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    16855    establishment_localizations id    DEFAULT     �   ALTER TABLE ONLY public.establishment_localizations ALTER COLUMN id SET DEFAULT nextval('public.establishment_localizations_id_seq'::regclass);
 M   ALTER TABLE public.establishment_localizations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    236    237            �           2604    16818    establishments id    DEFAULT     v   ALTER TABLE ONLY public.establishments ALTER COLUMN id SET DEFAULT nextval('public.establishments_id_seq'::regclass);
 @   ALTER TABLE public.establishments ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    17089    hf_tokens id    DEFAULT     l   ALTER TABLE ONLY public.hf_tokens ALTER COLUMN id SET DEFAULT nextval('public.hf_tokens_id_seq'::regclass);
 ;   ALTER TABLE public.hf_tokens ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    243    242    243            �           2604    16478    languages id    DEFAULT     l   ALTER TABLE ONLY public.languages ALTER COLUMN id SET DEFAULT nextval('public.languages_id_seq'::regclass);
 ;   ALTER TABLE public.languages ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    16460    localization00 id    DEFAULT     m   ALTER TABLE ONLY public.localization00 ALTER COLUMN id SET DEFAULT nextval('public.texts_id_seq'::regclass);
 @   ALTER TABLE public.localization00 ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    16598    locations id    DEFAULT     l   ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);
 ;   ALTER TABLE public.locations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    16450    municipalities id    DEFAULT     v   ALTER TABLE ONLY public.municipalities ALTER COLUMN id SET DEFAULT nextval('public.municipalities_id_seq'::regclass);
 @   ALTER TABLE public.municipalities ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    17031    sentiment_analysis sentiment_id    DEFAULT     �   ALTER TABLE ONLY public.sentiment_analysis ALTER COLUMN sentiment_id SET DEFAULT nextval('public.sentiment_analysis_sentiment_id_seq'::regclass);
 N   ALTER TABLE public.sentiment_analysis ALTER COLUMN sentiment_id DROP DEFAULT;
       public          postgres    false    240    241    241            �           2604    17320    survey_questions id    DEFAULT     z   ALTER TABLE ONLY public.survey_questions ALTER COLUMN id SET DEFAULT nextval('public.survey_questions_id_seq'::regclass);
 B   ALTER TABLE public.survey_questions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    249    248    249                       2604    17397    survey_responses response_id    DEFAULT     �   ALTER TABLE ONLY public.survey_responses ALTER COLUMN response_id SET DEFAULT nextval('public.survey_responses_response_id_seq'::regclass);
 K   ALTER TABLE public.survey_responses ALTER COLUMN response_id DROP DEFAULT;
       public          postgres    false    250    251    251            �           2604    17311    survey_versions id    DEFAULT     x   ALTER TABLE ONLY public.survey_versions ALTER COLUMN id SET DEFAULT nextval('public.survey_versions_id_seq'::regclass);
 A   ALTER TABLE public.survey_versions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    247    246    247            �           2604    16536    surveytopic_types id    DEFAULT     {   ALTER TABLE ONLY public.surveytopic_types ALTER COLUMN id SET DEFAULT nextval('public.attraction_types_id_seq'::regclass);
 C   ALTER TABLE public.surveytopic_types ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    16754 "   tourismattraction_localizations id    DEFAULT     �   ALTER TABLE ONLY public.tourismattraction_localizations ALTER COLUMN id SET DEFAULT nextval('public.tourismattractiontranslations_id_seq'::regclass);
 Q   ALTER TABLE public.tourismattraction_localizations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    16735    tourismattractions id    DEFAULT     ~   ALTER TABLE ONLY public.tourismattractions ALTER COLUMN id SET DEFAULT nextval('public.tourismattractions_id_seq'::regclass);
 D   ALTER TABLE public.tourismattractions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            �           2604    16830    types id    DEFAULT     d   ALTER TABLE ONLY public.types ALTER COLUMN id SET DEFAULT nextval('public.types_id_seq'::regclass);
 7   ALTER TABLE public.types ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    16876    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    238    239    239            �          0    16781    admin_table 
   TABLE DATA           �   COPY public.admin_table (id, username, gmail, e_password, last_login, last_logout, session_duration, is_logged_in, role) FROM stdin;
    public          postgres    false    230   �                 0    17188    anonymous_session 
   TABLE DATA           Q   COPY public.anonymous_session (sid, sess, expire, anonymous_user_id) FROM stdin;
    public          postgres    false    245   :�                 0    17161    anonymous_users 
   TABLE DATA           ]   COPY public.anonymous_users (anonymous_user_id, created_at, is_active, nickname) FROM stdin;
    public          postgres    false    244   ��       �          0    16524    country_names 
   TABLE DATA           J   COPY public.country_names (id, iso_code, language_code, name) FROM stdin;
    public          postgres    false    221   ��                  0    16852    establishment_localizations 
   TABLE DATA           �   COPY public.establishment_localizations (id, establishment_id, language_id, localized_name, created_at, updated_at) FROM stdin;
    public          postgres    false    237   ��       �          0    16835    establishment_types 
   TABLE DATA           H   COPY public.establishment_types (establishment_id, type_id) FROM stdin;
    public          postgres    false    235   �       �          0    16815    establishments 
   TABLE DATA           �   COPY public.establishments (id, est_name, city_mun, barangay, latitude, longitude, address, contact_number, email, website, created_at, updated_at, is_active) FROM stdin;
    public          postgres    false    232   B�                 0    17086 	   hf_tokens 
   TABLE DATA           8   COPY public.hf_tokens (id, apitoken, label) FROM stdin;
    public          postgres    false    243   �       �          0    16475 	   languages 
   TABLE DATA           9   COPY public.languages (id, code, name, flag) FROM stdin;
    public          postgres    false    219   ��       �          0    16457    localization00 
   TABLE DATA           X   COPY public.localization00 (id, key, language_code, textcontent, component) FROM stdin;
    public          postgres    false    217   I�       �          0    16595 	   locations 
   TABLE DATA           t   COPY public.locations (id, parent_id, location_type, name, latitude, longitude, created_at, updated_at) FROM stdin;
    public          postgres    false    225   S�      �          0    16447    municipalities 
   TABLE DATA           D   COPY public.municipalities (id, municipality, province) FROM stdin;
    public          postgres    false    215   �                0    17028    sentiment_analysis 
   TABLE DATA           �   COPY public.sentiment_analysis (sentiment_id, response_id, text, sentiment_score_positive, sentiment_score_neutral, sentiment_score_negative, sentiment_label, entity, question, date, language, metadata, created_at, updated_at) FROM stdin;
    public          postgres    false    241   U                0    17317    survey_questions 
   TABLE DATA           �   COPY public.survey_questions (id, questiontype, survey_version, content, modified_date, title, surveyresponses_ref, surveytopic) FROM stdin;
    public          postgres    false    249   r                0    17394    survey_responses 
   TABLE DATA           �   COPY public.survey_responses (response_id, anonymous_user_id, surveyquestion_ref, created_at, is_analyzed, response_value) FROM stdin;
    public          postgres    false    251         
          0    17308    survey_versions 
   TABLE DATA           _   COPY public.survey_versions (id, title, description, creation_date, modified_date) FROM stdin;
    public          postgres    false    247   *      �          0    16533    surveytopic_types 
   TABLE DATA           H   COPY public.surveytopic_types (id, type_name, display_name) FROM stdin;
    public          postgres    false    223   �      �          0    16751    tourismattraction_localizations 
   TABLE DATA           �   COPY public.tourismattraction_localizations (id, tourism_attraction_id, language_id, translated_name, translated_ta_category, translated_ntdp_category, translated_mgt) FROM stdin;
    public          postgres    false    229          �          0    16732    tourismattractions 
   TABLE DATA           �   COPY public.tourismattractions (id, ta_name, type_code, region, prov_huc, city_mun, report_year, brgy, latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity) FROM stdin;
    public          postgres    false    227   �1      �          0    16827    types 
   TABLE DATA           .   COPY public.types (id, type_name) FROM stdin;
    public          postgres    false    234   �6                0    16873    users 
   TABLE DATA           �   COPY public.users (user_id, email, hashed_password, full_name, language_preference, country, last_login, created_at, updated_at, is_active, is_verified, role) FROM stdin;
    public          postgres    false    239   �7      &           0    0    attraction_types_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.attraction_types_id_seq', 11, true);
          public          postgres    false    222            '           0    0    country_names_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.country_names_id_seq', 1, false);
          public          postgres    false    220            (           0    0 "   establishment_localizations_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.establishment_localizations_id_seq', 1, false);
          public          postgres    false    236            )           0    0    establishments_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.establishments_id_seq', 5, true);
          public          postgres    false    231            *           0    0    hf_tokens_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.hf_tokens_id_seq', 7, true);
          public          postgres    false    242            +           0    0    languages_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.languages_id_seq', 8, true);
          public          postgres    false    218            ,           0    0    locations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.locations_id_seq', 52, true);
          public          postgres    false    224            -           0    0    municipalities_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.municipalities_id_seq', 1643, true);
          public          postgres    false    214            .           0    0 #   sentiment_analysis_sentiment_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.sentiment_analysis_sentiment_id_seq', 1, false);
          public          postgres    false    240            /           0    0    survey_questions_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.survey_questions_id_seq', 32, true);
          public          postgres    false    248            0           0    0     survey_responses_response_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.survey_responses_response_id_seq', 248, true);
          public          postgres    false    250            1           0    0    survey_versions_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.survey_versions_id_seq', 1, true);
          public          postgres    false    246            2           0    0    texts_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.texts_id_seq', 5541, true);
          public          postgres    false    216            3           0    0    tourismattractions_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.tourismattractions_id_seq', 34, true);
          public          postgres    false    226            4           0    0 $   tourismattractiontranslations_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.tourismattractiontranslations_id_seq', 784, true);
          public          postgres    false    228            5           0    0    types_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.types_id_seq', 20, true);
          public          postgres    false    233            6           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          postgres    false    238            %           2606    16786    admin_table admin_table_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.admin_table
    ADD CONSTRAINT admin_table_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.admin_table DROP CONSTRAINT admin_table_pkey;
       public            postgres    false    230            C           2606    17194 (   anonymous_session anonymous_session_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.anonymous_session
    ADD CONSTRAINT anonymous_session_pkey PRIMARY KEY (sid);
 R   ALTER TABLE ONLY public.anonymous_session DROP CONSTRAINT anonymous_session_pkey;
       public            postgres    false    245            A           2606    17167 $   anonymous_users anonymous_users_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.anonymous_users
    ADD CONSTRAINT anonymous_users_pkey PRIMARY KEY (anonymous_user_id);
 N   ALTER TABLE ONLY public.anonymous_users DROP CONSTRAINT anonymous_users_pkey;
       public            postgres    false    244                       2606    16538 '   surveytopic_types attraction_types_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.surveytopic_types
    ADD CONSTRAINT attraction_types_pkey PRIMARY KEY (id);
 Q   ALTER TABLE ONLY public.surveytopic_types DROP CONSTRAINT attraction_types_pkey;
       public            postgres    false    223                       2606    16540 0   surveytopic_types attraction_types_type_name_key 
   CONSTRAINT     p   ALTER TABLE ONLY public.surveytopic_types
    ADD CONSTRAINT attraction_types_type_name_key UNIQUE (type_name);
 Z   ALTER TABLE ONLY public.surveytopic_types DROP CONSTRAINT attraction_types_type_name_key;
       public            postgres    false    223                       2606    16531 6   country_names country_names_iso_code_language_code_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.country_names
    ADD CONSTRAINT country_names_iso_code_language_code_key UNIQUE (iso_code, language_code);
 `   ALTER TABLE ONLY public.country_names DROP CONSTRAINT country_names_iso_code_language_code_key;
       public            postgres    false    221    221                       2606    16529     country_names country_names_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.country_names
    ADD CONSTRAINT country_names_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.country_names DROP CONSTRAINT country_names_pkey;
       public            postgres    false    221            /           2606    16861 X   establishment_localizations establishment_localizations_establishment_id_language_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.establishment_localizations
    ADD CONSTRAINT establishment_localizations_establishment_id_language_id_key UNIQUE (establishment_id, language_id);
 �   ALTER TABLE ONLY public.establishment_localizations DROP CONSTRAINT establishment_localizations_establishment_id_language_id_key;
       public            postgres    false    237    237            1           2606    16859 <   establishment_localizations establishment_localizations_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.establishment_localizations
    ADD CONSTRAINT establishment_localizations_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.establishment_localizations DROP CONSTRAINT establishment_localizations_pkey;
       public            postgres    false    237            -           2606    16839 ,   establishment_types establishment_types_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.establishment_types
    ADD CONSTRAINT establishment_types_pkey PRIMARY KEY (establishment_id, type_id);
 V   ALTER TABLE ONLY public.establishment_types DROP CONSTRAINT establishment_types_pkey;
       public            postgres    false    235    235            '           2606    16825 "   establishments establishments_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.establishments
    ADD CONSTRAINT establishments_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.establishments DROP CONSTRAINT establishments_pkey;
       public            postgres    false    232            ?           2606    17091    hf_tokens hf_tokens_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.hf_tokens
    ADD CONSTRAINT hf_tokens_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.hf_tokens DROP CONSTRAINT hf_tokens_pkey;
       public            postgres    false    243            
           2606    16482    languages languages_code_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_code_key UNIQUE (code);
 F   ALTER TABLE ONLY public.languages DROP CONSTRAINT languages_code_key;
       public            postgres    false    219                       2606    16480    languages languages_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.languages DROP CONSTRAINT languages_pkey;
       public            postgres    false    219                       2606    16602    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            postgres    false    225                       2606    16454 "   municipalities municipalities_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.municipalities
    ADD CONSTRAINT municipalities_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.municipalities DROP CONSTRAINT municipalities_pkey;
       public            postgres    false    215            =           2606    17037 *   sentiment_analysis sentiment_analysis_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.sentiment_analysis
    ADD CONSTRAINT sentiment_analysis_pkey PRIMARY KEY (sentiment_id);
 T   ALTER TABLE ONLY public.sentiment_analysis DROP CONSTRAINT sentiment_analysis_pkey;
       public            postgres    false    241            H           2606    17324 &   survey_questions survey_questions_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT survey_questions_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.survey_questions DROP CONSTRAINT survey_questions_pkey;
       public            postgres    false    249            L           2606    17403 &   survey_responses survey_responses_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_pkey PRIMARY KEY (response_id);
 P   ALTER TABLE ONLY public.survey_responses DROP CONSTRAINT survey_responses_pkey;
       public            postgres    false    251            F           2606    17315 $   survey_versions survey_versions_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.survey_versions
    ADD CONSTRAINT survey_versions_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.survey_versions DROP CONSTRAINT survey_versions_pkey;
       public            postgres    false    247                       2606    16464    localization00 texts_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.localization00
    ADD CONSTRAINT texts_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY public.localization00 DROP CONSTRAINT texts_pkey;
       public            postgres    false    217            !           2606    16739 *   tourismattractions tourismattractions_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.tourismattractions
    ADD CONSTRAINT tourismattractions_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.tourismattractions DROP CONSTRAINT tourismattractions_pkey;
       public            postgres    false    227            #           2606    16758 B   tourismattraction_localizations tourismattractiontranslations_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.tourismattraction_localizations
    ADD CONSTRAINT tourismattractiontranslations_pkey PRIMARY KEY (id);
 l   ALTER TABLE ONLY public.tourismattraction_localizations DROP CONSTRAINT tourismattractiontranslations_pkey;
       public            postgres    false    229            )           2606    16832    types types_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.types DROP CONSTRAINT types_pkey;
       public            postgres    false    234            +           2606    16834    types types_type_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_type_name_key UNIQUE (type_name);
 C   ALTER TABLE ONLY public.types DROP CONSTRAINT types_type_name_key;
       public            postgres    false    234            J           2606    17358 ,   survey_questions unique_survey_responses_ref 
   CONSTRAINT     v   ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT unique_survey_responses_ref UNIQUE (surveyresponses_ref);
 V   ALTER TABLE ONLY public.survey_questions DROP CONSTRAINT unique_survey_responses_ref;
       public            postgres    false    249            4           2606    16889    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    239            6           2606    16887    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    239                       1259    16742    idx_city_mun    INDEX     O   CREATE INDEX idx_city_mun ON public.tourismattractions USING btree (city_mun);
     DROP INDEX public.idx_city_mun;
       public            postgres    false    227                       1259    16746    idx_devt_lvl    INDEX     O   CREATE INDEX idx_devt_lvl ON public.tourismattractions USING btree (devt_lvl);
     DROP INDEX public.idx_devt_lvl;
       public            postgres    false    227            2           1259    16892 	   idx_email    INDEX     C   CREATE UNIQUE INDEX idx_email ON public.users USING btree (email);
    DROP INDEX public.idx_email;
       public            postgres    false    239                       1259    16747    idx_mgt    INDEX     E   CREATE INDEX idx_mgt ON public.tourismattractions USING btree (mgt);
    DROP INDEX public.idx_mgt;
       public            postgres    false    227                       1259    16745    idx_ntdp_category    INDEX     Y   CREATE INDEX idx_ntdp_category ON public.tourismattractions USING btree (ntdp_category);
 %   DROP INDEX public.idx_ntdp_category;
       public            postgres    false    227                       1259    16748    idx_online_connectivity    INDEX     e   CREATE INDEX idx_online_connectivity ON public.tourismattractions USING btree (online_connectivity);
 +   DROP INDEX public.idx_online_connectivity;
       public            postgres    false    227                       1259    16741 
   idx_region    INDEX     K   CREATE INDEX idx_region ON public.tourismattractions USING btree (region);
    DROP INDEX public.idx_region;
       public            postgres    false    227                       1259    16743    idx_report_year    INDEX     U   CREATE INDEX idx_report_year ON public.tourismattractions USING btree (report_year);
 #   DROP INDEX public.idx_report_year;
       public            postgres    false    227            7           1259    17051    idx_sentiment_analysis_date    INDEX     Z   CREATE INDEX idx_sentiment_analysis_date ON public.sentiment_analysis USING btree (date);
 /   DROP INDEX public.idx_sentiment_analysis_date;
       public            postgres    false    241            8           1259    17049    idx_sentiment_analysis_entity    INDEX     ^   CREATE INDEX idx_sentiment_analysis_entity ON public.sentiment_analysis USING btree (entity);
 1   DROP INDEX public.idx_sentiment_analysis_entity;
       public            postgres    false    241            9           1259    17052    idx_sentiment_analysis_language    INDEX     b   CREATE INDEX idx_sentiment_analysis_language ON public.sentiment_analysis USING btree (language);
 3   DROP INDEX public.idx_sentiment_analysis_language;
       public            postgres    false    241            :           1259    17050    idx_sentiment_analysis_question    INDEX     b   CREATE INDEX idx_sentiment_analysis_question ON public.sentiment_analysis USING btree (question);
 3   DROP INDEX public.idx_sentiment_analysis_question;
       public            postgres    false    241            ;           1259    17048 "   idx_sentiment_analysis_response_id    INDEX     h   CREATE INDEX idx_sentiment_analysis_response_id ON public.sentiment_analysis USING btree (response_id);
 6   DROP INDEX public.idx_sentiment_analysis_response_id;
       public            postgres    false    241            D           1259    17195    idx_session_expire    INDEX     R   CREATE INDEX idx_session_expire ON public.anonymous_session USING btree (expire);
 &   DROP INDEX public.idx_session_expire;
       public            postgres    false    245                       1259    16744    idx_ta_category    INDEX     U   CREATE INDEX idx_ta_category ON public.tourismattractions USING btree (ta_category);
 #   DROP INDEX public.idx_ta_category;
       public            postgres    false    227                       1259    16740    idx_ta_name    INDEX     M   CREATE INDEX idx_ta_name ON public.tourismattractions USING btree (ta_name);
    DROP INDEX public.idx_ta_name;
       public            postgres    false    227            Y           2620    16891    users set_updated_at    TRIGGER     }   CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 -   DROP TRIGGER set_updated_at ON public.users;
       public          postgres    false    239    252            Z           2620    17337 2   survey_questions survey_questions_modified_trigger    TRIGGER     �   CREATE TRIGGER survey_questions_modified_trigger AFTER INSERT OR UPDATE ON public.survey_questions FOR EACH ROW EXECUTE FUNCTION public.update_survey_version_modified_date();
 K   DROP TRIGGER survey_questions_modified_trigger ON public.survey_questions;
       public          postgres    false    249    253            U           2606    17196 :   anonymous_session anonymous_session_anonymous_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.anonymous_session
    ADD CONSTRAINT anonymous_session_anonymous_user_id_fkey FOREIGN KEY (anonymous_user_id) REFERENCES public.anonymous_users(anonymous_user_id);
 d   ALTER TABLE ONLY public.anonymous_session DROP CONSTRAINT anonymous_session_anonymous_user_id_fkey;
       public          postgres    false    244    3393    245            R           2606    16862 M   establishment_localizations establishment_localizations_establishment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.establishment_localizations
    ADD CONSTRAINT establishment_localizations_establishment_id_fkey FOREIGN KEY (establishment_id) REFERENCES public.establishments(id) ON DELETE CASCADE;
 w   ALTER TABLE ONLY public.establishment_localizations DROP CONSTRAINT establishment_localizations_establishment_id_fkey;
       public          postgres    false    237    3367    232            S           2606    16867 H   establishment_localizations establishment_localizations_language_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.establishment_localizations
    ADD CONSTRAINT establishment_localizations_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id) ON DELETE CASCADE;
 r   ALTER TABLE ONLY public.establishment_localizations DROP CONSTRAINT establishment_localizations_language_id_fkey;
       public          postgres    false    3340    237    219            P           2606    16840 =   establishment_types establishment_types_establishment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.establishment_types
    ADD CONSTRAINT establishment_types_establishment_id_fkey FOREIGN KEY (establishment_id) REFERENCES public.establishments(id) ON DELETE CASCADE;
 g   ALTER TABLE ONLY public.establishment_types DROP CONSTRAINT establishment_types_establishment_id_fkey;
       public          postgres    false    235    3367    232            Q           2606    16845 4   establishment_types establishment_types_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.establishment_types
    ADD CONSTRAINT establishment_types_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.types(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.establishment_types DROP CONSTRAINT establishment_types_type_id_fkey;
       public          postgres    false    235    3369    234            M           2606    16603 "   locations locations_parent_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.locations(id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_parent_id_fkey;
       public          postgres    false    225    225    3350            T           2606    17043 3   sentiment_analysis sentiment_analysis_language_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sentiment_analysis
    ADD CONSTRAINT sentiment_analysis_language_fkey FOREIGN KEY (language) REFERENCES public.languages(code) ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public.sentiment_analysis DROP CONSTRAINT sentiment_analysis_language_fkey;
       public          postgres    false    3338    219    241            V           2606    17325 5   survey_questions survey_questions_survey_version_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT survey_questions_survey_version_fkey FOREIGN KEY (survey_version) REFERENCES public.survey_versions(id) ON DELETE CASCADE;
 _   ALTER TABLE ONLY public.survey_questions DROP CONSTRAINT survey_questions_survey_version_fkey;
       public          postgres    false    247    3398    249            W           2606    17404 8   survey_responses survey_responses_anonymous_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_anonymous_user_id_fkey FOREIGN KEY (anonymous_user_id) REFERENCES public.anonymous_users(anonymous_user_id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.survey_responses DROP CONSTRAINT survey_responses_anonymous_user_id_fkey;
       public          postgres    false    251    3393    244            X           2606    17409 9   survey_responses survey_responses_surveyquestion_ref_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_surveyquestion_ref_fkey FOREIGN KEY (surveyquestion_ref) REFERENCES public.survey_questions(surveyresponses_ref);
 c   ALTER TABLE ONLY public.survey_responses DROP CONSTRAINT survey_responses_surveyquestion_ref_fkey;
       public          postgres    false    3402    251    249            N           2606    16764 N   tourismattraction_localizations tourismattractiontranslations_language_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tourismattraction_localizations
    ADD CONSTRAINT tourismattractiontranslations_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(id) ON DELETE CASCADE;
 x   ALTER TABLE ONLY public.tourismattraction_localizations DROP CONSTRAINT tourismattractiontranslations_language_id_fkey;
       public          postgres    false    219    229    3340            O           2606    16759 X   tourismattraction_localizations tourismattractiontranslations_tourism_attraction_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tourismattraction_localizations
    ADD CONSTRAINT tourismattractiontranslations_tourism_attraction_id_fkey FOREIGN KEY (tourism_attraction_id) REFERENCES public.tourismattractions(id) ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.tourismattraction_localizations DROP CONSTRAINT tourismattractiontranslations_tourism_attraction_id_fkey;
       public          postgres    false    229    227    3361            �     x�]�Ms�0��s���&�� 7�+R�:P�/EE�i����c;����;����<w� Ԇ�MI���UZ��I�\*�t^��PDR�	���3��o�dQ�����~&o�%=w�{�ng�C����Z�Nw�a,��#vz����?���T���wG�|��f���0��[Bj�M���mƱ�,Ib�3t����h0�MBf$�MF�B����Pi�/��.؞Ƈ�N_�,��ʣE����;����b ��'�MN��I�o����n\         �  x�͖�O"I���WL�l��~pD��*ؙ�Գm�Pp2��ffw�;ziۇJ���_>�>��4o���}�^F��h�uq>HU�h��'v�x�}R��,�<�=��m=�;R	��I�˼����`��@r�X�����49IV�n��]г�?I��尘�ں����^?����8It�(v��fu��奋��sQ�@� ����`Π�J8��8�{�L�ǣ�o�c!�'��=z�WD_�W�y�i�^�������ZyH�"'�Hc	�i���ُ9G����k;|�A�����N5h���n�)���L�xǔ5O1D�1�4Dc�P 
)�p��Y�85�/�8^�c�{L0)x�mzq�����bG�t<�u�^���$�9�ui�uA*P ��֖x$,��c9�Yk8��37��eæK[4�R����sy(NZ�[de�{��ȉ#�4�ͥ�Fj���Ķ�\�o�3���uyq��w{m�ۖ�S,DuL��0�������}�40�(A���ֶ��1�nr;��Q&&����>���EO�;�"�Ye9c<�)?D�騦�q����q�P0�+���3��{�9o������6}+f����I��C~�/�CqV�-AR2;�x9�@h �N
��t���~���b�=g�p1)�������K����J1n釜og(�\U�BK�O�Y\� X:������9�ŀ޾u�Oo������)7Ys���.�� ��ɸSF� �41���G@cg�'X�>��f<���=m�h=�h�֚�&.�8%���yM2�Rp�O��#���i��[²����k���<� 9��n�	>���y}N.du=�J0
�R��6�A��",4�_��5�~�з����?)�'�         �  x�u�;�TAE��U���U�N6"!$D�Db�g�K��n�餢�N�{�hƼ�M��6Z�e�l	���B�}����Jo����r�5�+�45��9�}����r���֮����!i94s��eB9���d�}	����o�vE���Ƿ/�>���EARve*(���I�95�=Ʉ��9)!"�Q6Q�7���{2I���������;d�8�)�MWE:�rs �~�����\�X�Q�rN�>���jH:��z�"�q��wH�J�2�b;�̪$= 5]��#�)��ڕ;�����x�Y�:'�|ko,���>�p�;hFF��n�����n.� N�х[LוO �=M�v�&A5��v��J��C����6��+�S��R�ژc��&���qj�s�0qdߖ�s\���v�� ����z�-+��P�����GU1�G�-u�q�z���"����O���d:*��؟�����e��      �      x������ � �             x������ � �      �   *   x�3�4�2c# 6�2�M�lc m������W� �>�      �   �   x����
�@F��S����h�&�Em�L:������	������9�aQK�!�ݍ�lh�d��iXY��k��i;��n�p���ٮ��wi�e��$Jؓ-DX�I����^�r���\�|�7���:+k�ϒy'+����C�s�%�< ���-�z
ޒz��Z���k��x����)-�0^��f         q   x�3�5r+Nqˎ0�wsw)v��3��Ȱ4�/+�6s�(H�*�pNLJO31ӎ��t���/p�
3�(	��J	�ȴ��r�wͱ+()���tq�O+JM����� �� �      �   �   x�3�L��t�K��,��,-�2���|��������y\Ɯ���o��y�u���8���L8�9�M_�lΚ��qfp�r�Qb��剙�@�gF&�%;,��`ɊK{,Y�`igf�9gQ)�ņ��/6^�uaǅ�@.��bN�����s�l�=... �NDF      �      x�̽[SY�0�����ez"��E\�������m��s�<��l�GH�Jr��ĉ@l0��ۖ�l���������?p| F�������T�.�p����L��2�Z�2W�ʕ����Bon��FZ�X0��f��/c!��W|�j�v�Q=�?�Ѡn6Nh-�-v��N�`�0���FL��G�us�~0��8���o5~_���G*�c����X"?��>ͯ��þ��Ԃ��~����)ݮ}ʤ���~�>z؝��x���i�O�m���oT��Wv���F'����ڷ�֟����e^�ͼ�t�S{Ý�������Z}*�����;�"�5= ��ī�ž���;�����N��N{{{w7�pm��Nb�ɮw�$^g7Fv�;�uj�t'ѫ�<�\P��1l��	�FH�C���VX�XDk��������HX3�fa	o�%��Ruv-Zq��Z�pps*jh�7�Û��/�N��?��9}Ո^7Z�gM�2�e0�E7��"ᖸ�9�݌�������)��V�}#X�q"�qb���,�;�q��ǉ9��D}I|�x�qb��>Nށ?�'6>N��`O�-����Њ0dؗW�{;C�
`������I�Z���C����|��`_S�QM%���E۾��������zB�N���������vr;A���4�����������oe���]���v7|\լ��o��[��q�ظ���^��f�93B�A�'�6Z+�d��ha�OR�:9p��l6Z 4؂���짚�k��E#l�׳��������I�����z�����/�>4cg��sH����M�Lq[�h�S%�VI?~	�J;�֡�0c�-��g)����|5��A=�_q�����4l�k���$H��I��ف�<8���\W%��7��:�����$��G
p�/��j�2O�[���������b����[�5�"�hƊ	Id��j���[�(���F9�D&.����𥓗Ϝ���E����#����x�>М���.�׾8s^;}�oM
d�8��2/��f�F$dc�Grx	�7~���	��A�<�[
h GC���rX	;�6 >|1�O��H��%L��_P�9\��ߝ8�?��u�_����r��U�28˟F�]C����O�r�
�V�.�0}Z�Yc8+_M+a�����х�L�J��/�om.8�G�aMu�.9	�K6�lG"?�J��Б7�9�Y�wM&���0n��w�}�e�D(
��4�-���� \�t���b��d�A\Nh�����ԧw���~Jw�GV�G����Qjș�b��q�?���N9�Dp<;�����2=Ev���p;2!MN�"L�=��$�~��	���%���}p.���>9pQ��]�d��ŕ �.��&��F�×����d�^��xv�?�5���/�x�Qv��]Ɏ7����8���0��L�B�{�����������z1��Rq}�g��<�$�r��a��w*so�gG��#S����̰E��u8��f�d��ץ��f�=���i6�;/�p�6l�l�����^��{��}��N6A8�f#{�G����ى�Ԇr��U����9�K)= �?׹���Ȗ�/���(\3��jwvb:�J�k�G���qNL���k> ����ʹ��L�ዪ?��;�w:n�t���׀��Nr}�cu�C����!��"ế�\�]�I�#F꒣>�DC��x������>T�� r��S�����]=M+w:��t�/���Nrb��!��N�k)��^5�;dB�I��(OEBsQ�vn�mz�HCF��)�����N��~{���U�p�9�#�-�1h'�_�t�kL�kz'1��ܠU���z�c��A�o'ѿ��^gs#Oޗ�II��.���l�|{�Ҩ���S�����-PUZ�4��'�b��-78���Ue�V�sP�=���V93����"U��F��l�*a62���U�0"��Mf�V�����:���dƣ�w��S��k-�v#�9m�-r�T��&$�!b�-z֣@UI�YQ�0˴#��ܸ�"�K7cFe��7�'-�k�����H>���$��iS*��ꢖ$SaI
TÒ���/ ��E���y���"Q�9�9��bA��-��b	����ח�֥@uI�,�ɳg�9s��3���ِ��02�dd�05��No�;)73��13��7���Kؙ`���Hn��6P]Tۺ����jK�.�jp��Ү�����QS��H/� Z_5���l�O
��9���m���z�ը��Е�@��x�tp2N�;�lO5��*����wx��|�����W�1=,Ԕ�]�0o?~y����X���W@�6)��E��cyn����\�k�jZ0�W����Y w��y9\�
`��!�[��������xts��]ͦ�b���(�99d)%
`7{�=y��e�Vn\�Қ�L^����H��_.\��ص|e�P��/@����+Q����M��jQtǹ�q����ӏ�rŕ)B�������������׭��W�n�� >�k����=��I�>ȵI�14/������ǉ�J���ɱ�順����e���ƨק'�.r"!��;l��BUҬ�Q�u�}�K�L>�R���f��� rl�o���E7�w*%�Э�5o�gW���ш�>���Y�R�i��ĺ.�d�Xψgp�wh�&�B���-Ja�I9x1=���h �J�k���h�1`�D�Ɨ.x&<��a�	���,�hH�

�W-��˄��vi�&��O��ީew��NM(�hb/���ǉ�z��=Y� Ee��ԇ�U����i�q��H��(�j����d;��ҫ����޵�#���t��nߖ���^�}#��E@7���Nl�m����2�� ~xؾ�+��Z(v�P������Z��}�@�(�-K�����{:�F��=#e�����a&��~�m�Wn���U[e~ ���<Ό�SZ�!h�W��O��X�>+4A����"�����y\D����P`�����(�=dN����`k@YL�E�ѭ��39h��,� �v�<�p��6�H�+�}gi/.ЍH���&�[o���m�(�k�8�!� �O@���A|��h��ݺ_d��y0p�'���'�6O�o=�� ��@�d��֌���/4ݚۚTtU��8 ('�P\f�Ȼ�[�r>�?��N�6�q�Tk��ZU��K5?���Re�������vT��E���Qu��o���U�����Q�:�pk�[U�3�%���Q��=rk���JhlGՉu�TDߚ_�j�w�>�{*�v�X,�7;o{Oh�	bj��8�?	�⤧%B�p�l�,�s;j�V��?7�� ���>)γ�f���|�k���A���X'<m�����$�s��=�K�F��Vh\�3*ܒ mP#u���������ɖ�K��|���B�+����;��Yc4����	�r4�/�5���Ɓ)��52Z�H<���<�ha�F-f�{M�/��5��m^��B�dXx>H����U�3d��5�p8?qt7���>������_��W]�<z4r��H�JΡ;�xF:�KCP�G=R����=��	 χ���o�c#@���R��e�Y�G�u���pl��:3���<kʄá���ji��q=r�zأ��? %D̳�KT\�sϓ��m��iG�N�<�����|{��hO���%<�y�6�\0}z�����=I�;�Zj�7��.ara'�(�֎z��ܻ��>�dx7�.��󴋹
�t����K������)	&9�;��CY���6+���#X�++�}[��G��g�{���諪�9U.X������ٮɢ��<���ɍON@�3�G�p5>����a X�_]2�� yn����iύ�d��f�]�+����ۏnl<7:r��cS�ud�>���L�� �a�-��gD�A�;�����=x�s}�+�����Wv$]��|���#���F$X����s���"h5ϭ�p�z$�<Sz�{�+��j�	��Q    �;�_�׳wK���U&1U�!�y�#18��> ��X�������w� �3)'1�4�h'�D�p�;)���N�k���L��lW�����N"��蔰t5�Ҏ<Y�K���p&�^6MD��h��W���r��9X���gn��>�肄���"�WU#gr��P��pY���E�ţ�o�X�Y�`�K@A�7+�\H�)����z+��׊��Oa�y�
��zT�s��DdV�	Ǣ����ͺ��d�H�I$��3��h��#/�C����q]��AE�P<��OJ��gd��dV�s�r�%b��Ԛ��6��b\5��='�`9th ����''��MI��Vo:�hs��`,"����}zrp�!Zt���\@��X����L����0�$��+iq��fI�Ҁne��G\��F@z6h�%�E4��z(.=�tQ�97��E��I`�3< �F���}��m{؜� .���Fk B\1	��&\�����Z(x=,[�"��W[����E)l�|��+�}^�|�Ӣ8��L�j�v	b������뇹�ś�7����'d&c@'� �P�i�#lg��d����7zZ��(m�%m����2G��S��:1�\4��a{�����t��tZºa�y-��t�,�(j�^�K�5y�Oi��� `(���D�讝A�0�6+�P�1���=NuEM'�$���|��`���?N�*���p	ۊ}i����_�8����r�zC&�)�c���|��_��ڢ��:����t��t9{�8
�a�ݲ��cT�[�K�\��4�.Eѹa/��ֶ��E���^�6^��*i�Q�����ҟ��Ms�����O�Ut����2c�~�%9Օ0��pF�֟���o�RYd�@$���ؽ����lm�AQ�"xN�9螐ܖ�P��3�-^(6��?q�<q�#)Ǥ$��q^_���.ā'ɵ�(��pѓay�C���	��^@Kؠ��I�H���)��ǂ$�(>@'l�k$Y���Wڨ��Ȟ�VZqJ ���n\-��[��隖a/b��[�D�Pq5�;H �}<g�nDZ��WY��b��Z�7�{�����U��p��/�ϕ"`�;�Z��Ӈ�)�WH��9�{�v�o�=��]��B��u��>�=\ʮ����J�s��v���:K�]j'��Cy��.E\'����#ь50B���C�7�	�)���z��g{ts�P�IN�s����`�_�^l�>G/�w���ܞ��(��¿B�
_����u�?�>	#�-1���9���g���
0�޴�[��t�N����� �>�q������&��g,S>֬�����"�Σ  Z�s�c���P
�xh���N����/����D&w�	�(P�>&�O3���!	�s8�U�p��|H�x�Օl�#�.��x�K��S���uQS���6�ER��7mq����I+��c�૳��\�f��s�_&a^,�<z�w���Q�����$�K���һlZ�<��%q8\�a��;x����i+>=1'A,{�q��}��Lw1�0S��΋#����O�mX@({�y�X������׮p�Y������톝"VP���D�k��4�(+l۔2�ЏZ���${���L-J��;�[g�W�y2V��Ԗ�S�Qj@��)�ϳ����&c\��� ���mJN�;P���>��K�����V��nx9}����{��B�5�ڌ��[��˞j_����(���J�`	��:ڵ/�)�wD�P]�-t��]y�������wS���0����R�GQ1&T��;��a	_)��@�hhb0����0��X(7��}�,���ԕ@b��l��/(Th�f<=���y+X܄��K�Dg��v8��#O�/��z8Я1n0zdI�z�k�W4/�:q �Ǳ�S]��)�ks ժI���8���N���) x�$V� ��8 `��n���N���4n9����nit~nӣ1-��&&�$�|v���r�׾��C,;i(�wZ��%f%����I]T|��GSϏ�@���N]8w�4��04�.�W�-�9(._:y���K��H�<rS�n��,�m㷍�/W�<u�̷g.�il��	ĵS���x��3���5U" �k�\h�Y��0߫��?4�j'v����%��a�\՛�N�O=6��kAv˾�7"߸Zb�5�ة��jE`�i�!��}���Nw��ΉÙL~<�Oθ�����i~�m^'�+�F�_QGlm	�I,�^�w�N�P2ų�۫�vŕ���aw�S� <��(�R#�Q���i9	� ߋE@��]��<�g1�_ǻ��2s��]��oo�3{����ノ�l�m�G���hwem?ݑ{:	��{�X$t�dǻ�d^�� 1�����A��X�}~��K��#+�ש���Κ;	&e`��������m�b��U�GEX�Y]��x��c|�,�I���`����a���,!zl��R����i�q��]~����(������H�����ϹX*<#E̵����\�?���<g vnc$>��{<+�Z���:�(r�[�p,ȨXZ��5)�I��Wu�/�2��q3���qR�b"�ꅿ�s������pj�Yq�셿�<w^�dA���e4��"h&�0.4Y:�铧��B�d����R2�\�B
�.hfşu�ix4�["r�x�Ӎ���
�RF�:��]�Q�@�sĭl7�����fi�S6�-�別���=�31+QP3�nѯ�݁8:A|��B�z�n����s0AAh8^A� �Wd�����r�l���!��ry�G��u�7��.x Q�u�I������4~�D��eS�Z�	2���������"˻Xƾ��.g�2f�v��g�)f����t9YS4���"��sm�\8
Ie2NW8(K4�|�OO��s����	��l'�A*Q"!� �^~%�bPeY����Rd�-�����^l�q	����8�RN]��$�8��m��;���(�s��6�
|2Lc��\�I�^��bgz\�X�{*l��]<�O��?�]�z�������:�H^�X� ����k`��[���`�[���=��Y�,��ut@�1f��}x�����5�5
e'�za����| ��O��3"a����hX8���9J�0��?���'EÐ��+�bM�k3����/���L���GS0��w�L� H�`!����$o��h�a"pӍH[�|ޯ���hA(��9���j���Bzm@����i����A�U�i9~�F��ɖ�31���cG���5x�C�+��`(A�gJ`�Ua��:���S�������߿�����w���N�-k✊��b��N�.J�`��������dhKF��2��V�D"-�i#Da�
�7�y��NR4t$�ny*b�����6�P솢�E#
:̅&�i�#V}q����i=}��<�#ڧř�����ݟަ�C��Ԙ��]���=�r8����B~�]�r&�w�٧t;��(2��c0)T��.v�o���8�b�E(�]�5"Uq��=ꄥ ��_���t����C��M��ѡ�ɡ�|�L~dLզw��]�'Ӱ~�fG}S��!-���Α�3����L�J`�O��t)G�)=<"iR�y�%�Tf�ɎL�a�a#���7�K�\�����l�/�+։Ȍ�ObF�ݕ�ݥn4���8��M�{�>_���\�~� -���=�c�*����
h
|�]����Y΍�e�'���e?L�W��`��Ƚ��]�{��{+w���?��z�v�_�0�Ϧ���L�M�}�/n��lb2��a������̫]U�4ߤs������F������M�U������^��N����Ղ�/��j��C��{�R�����$�v�R�`8��欇i걓uT�b�)[��27l��u9w��F(�q�@���]@��������J�8(w3j��~0��ro����7���J����{�\ݐ�M����.Ab�P�+d}�ӡ��Ah��_�)    4��^�S��){k�Җ{gsĤ��mQ̽��OЕ�YT���|CF͐�/G��!�c��f�I
͌j�q3������x(R��r���Ж�?�oً�*�D�.�>��f=�	��[ٟ1�QH��^����hA
4��CAW�/*�uhP�)�V��pUzspE��&=oQ!��mjm�Zm��RJl�d����$cכo��=�Z��e���{�͈j0}̿�«e���Ҟ�N-���tQ S�(���A{ї���������TSUb{$61<xY�����<�-&Χ�g�<�b�ӛӡ 6`��%����/���6/�#n 3����܌$�y9l���嚪۰hћ��N'��~�쐋N��WN��B>?V;�����5��)�ܮ��#�aw�6~v�����l�v��B�A�8+��,�g�[�M��뤜��7�AWb�L��Ri��L��tVR��d�eq���J`��YW���6�d�h^x2��𐚼pn��$�%�kʶ������R�~��J;"�����eS���uq`э�����ʌ�,� c=ŋ��)_�K��М���̖��x[��m���e���"s���Qr,!�	�
���E�8�/Y� ё=wI۾G>{��WT��|�I������P�������ԉ��2��L�X!عh�Aa �2�#ZILӘX�rF���+�u�	�y����[����I0�J�e����[�wl�j�e������	�]�`��^�0]����FFVnRP-�tcJp�c��z�$�=[������=0¦q
�$z/�tޗ�D�g�͠�y��F��	�F�{L�{�zuc6g=jh�(h�!l�}0v��	l���`�Vek<
c��[_U4�=�j��	��c�= K[��^��RD>Q������^
^[�0h?}�A��h�v�?s��B���S�w�{G*�O0d���fF��Ww(M'�7�9z�P�ލi�'�R��� y?��~eI+�X�Kҩ`*�"h(A)t������0�g�v׿V�0���p6�3�Y��ܛ��ӟ��$V)�ͯ���`��x�}��ˠ�"���t�͠Q�$	<�H���T����N���~���I&X����|�,�F�I��]K]0�Q@^RT:�<4AQ��+'&b�c�'G��uJ�@"����d�ͭ��pK��b�qV�Owν&:��#�fP�N���*�q|Ě�����r��P�H�\�opT�1NIo.�ш�D@�-�m�␈��B�ِ��	�p���>G�v�u�:eK��A���\�b@֛�0ٽ�1_A �xr�rE����Dd9
��RY���9�17�3q�����3��C� y��"�w�R��lP���q�
�@�II) �:��~-N�)+.G^LI6_�d_�o�I�!�u|Ue��v$�9���jR4�-³>,g�2h^?Q��~�ǒ�L��V|�2z�ܱ�أ��zaQ���y���v��N���;K{կ��Hq��5I�(�d� �d�/& �QgHU�G��pT�*�$>��GeC�^������r�Qǻ�Ϩ�śo8�&4kq;w�J��F^쫞�K���<4p�y�����F�5Vq$�B��C��Cc���c�9c8�Hv���Vx$ਭ���"�
H����`���9UZ�B�Jo��j��sA���5l����@DP�(�ڪGb�w���eX|�\cz�L�T<5�ͷ���p��V}��݀~�y��x�@<{��\7\`g�S'����v��\㹯/i���3M��^hj�`�y��ܟ���J�����n��Y&P�-WrPAM�k
��?���ͪ�'�gh^�(f�/�;J^���y�����iG����Q�g	ϣ�09!WP�;KȐ�V�|pԙ>�������݌;ϵ^Yqb�%�<�z�iK��{�A>�&��bN^��(0���]�� ��D�G���Yf Ơ��s��7H�y�#:�f���t�Muk�I�� HЧw���#莕����m'����a�~3w��/,�f�+�V�å�T�]�s�*�L��Y�#L�01p09+�vZ[v����f�gZĳ(';56d��D��ZT�
X([v���Ҁ/��^�q��%�<�zd�h���`*׾��r_.l��谢\�X�w]����2	� ���J�y�Ty*	�<�y�����n���l:�>��˽K����K��l(��!sA�N�gwm�6X����N����ۻ����a����-����;�gc^n0J����sY��^k�9�0O�����/�� �Y��!'�/7����3	q�-*CN8$�Po�r'9Ec۠H���r2΢%����,wZ	���e�5�Bi�fs/��/¾ˉ��@���d�~Q�u����׬�gk�ӓƳ�G�h1���c@{���Bv�wob��t�y.�/(�?�Sd��h�u3����#������b�b���gq�dV�	��߂��U� A"l��Y��ыI��+T2+�/�F?J��s�z����vى�SԈ᠒V<�sG&�:2�����{Lf�%Ì�2sܟ�"����?.�֩ǐ��R\8. �ǥ ��*�ɳ���dV�� ǥSW/�� ��.^i����|{��N^�`�$�E��ȤYpEjٜƖrg$��Y�$v]�>Aq�����R�	�px8��1t�MSf�(M��|C��8����N�/
��U�@Añ2���"p���A�v&('�����k"q�����	 ����T���2D�L��_!s��"&
�T�|UEL���W�J�i��7j��K'/^l<{�Q�x�	e>4^�_�H���n!zNI��
�q���͆���s���}�,c�(о��>0V�/e !-W"����:'��VKl\�2�Y����D̻�9	1�rx��ȎH�x�qk�d`�=gL�U�2��TP,����N7�/)	���q��Ew'E:��*���s��ax�%�KYz�x���	��.b�H��ɢ
Oc��V�\��C����h�~nI�1dv%��J�N�-���}���En����#���q�9˜}Jy�y��~b�t	@ˬ�`����,��0���&
��{���?m%��2>!��8�_�y,-oI6��9
�LQ�|Ve@-a�r�=Xc�nDT�B���I	�cZ���2vv�v��v?5���%����E���y��b`��.]��F.ƭ�t5I9���O��%�[S��(�����e(��xh�SS��%��,���ڿxt+�Q4�|���=�'���k�?�5_o=ۚ�tQ-y��-��Pç�k�W�r]�6���P��ҮEJuh�@?7�|�Ӂj6�O�T�B��^�=:k|�����l��gZޑ��W�Z��F<���)_�8LiWPR��HTDX�B�$�վ(��_i'�����-��]�D�a���=իz��ސ��A�ȯ��;��/A�"���ϴ�hR�X[U:B3\�4�k��Nֵ(P# �:�����o��ß����-��t�K`�����ȏ����4�G��#cX���*�Y��Н��=k�WX3��SZ~t�n���ZaŤ�V��r�:N�`�D�n�I7��R���Pʉ��
"c�z}���N�4�Y��1����@)M��q]���\L�y�p�lM�=҉� �c#�T7�H�j�	�0
���Ww/8au�w��ˏ��er�Z��wx��A��D�3Syou�%E�`'��iM��F%��{X�'�U�t�w�{|*{/%��ǒS���y�����p?F�w��]~�KN�Rׇݵ���X)�5���Y�]��2�<���S��Z�ٟ�̾Hr��7�ߍR,�ť���>�?��2�Mg�s���k�b,�pI�[��M������������;���?;+��_�D�Nr#�ۏ���e���˭��:�y�z�����i���d"�����������O����O%9��X�V"<x�V�Rݳ�1@��s�"5�[��e$9�|��-�!����W{��$^g�    ��J���;�I�s�8x�o71�B_6����/��(O�m���N���B����9>+߷R\lf��M�b�v.�T(���K,��\��8{w�i:�Ѳ.s��;�9t�O�-�q�<��:�[�=Z�I���գh�I��� ������	�2	t-E��,z��P2��LXћ,��@,&���
$�*�-\�� u�5L�^F,{e4b4�r�<��؇>�	ۜ�x,(|�YB�����Zs\�#d�����Cl��!�-�נ��9�Ia�6�i�z�+��6ߵF��H��1�V�HT�oJ	r�*�T��ʬ{C�
�0�-�VD���&ɰ�����p�'C��a�jF���Ÿq�Ѝ��<!�tH1����ɤ�_�3ae��_&8."+�~5X|������9mb:[�M7�*yN�ia�ۘ%s�f�a�kT���F��9�dp����Ѐ����u��Z$lgvվ�NEZ�Ác�7��e�C�b�H%RW�16Y���xTBq�dvkЈ� b(�����+�ֻ�i�6L�Ѡ����;b����8R�%��e\�/�͖@/^�-�hNn	ȒAy�פ찮�{��7�LM=�z�{�u5��4H^��h3�
oO�/!Y��B�&�Zz,!�nl�\��S��.��ۘZ9��R�k��Bx��Fԛ_�	ӟ��d	']�-�ɞ�D�|��&��Q��wS��"vG4��a'n��"ϲ�v;��3��Kv?&^�x㞼���Rʹ����fh�KD�4���J���ؙRΛ�tp��z�$!��ث,Z��Z��.�yjd��2��(Ii��
W�a�؋4�r\ӏ�ُ󴖿n���F�.�:,�U�J@&ۆ<�=Aw��]� .ۊ8J�3���;�=�	W�	�<����������/M&
E�Y�`�r�ʲۉ�����[�][�~k�c�1�ˇ�� ���w�,��.#��?J�@ax�T�n�껳K@z�I�?�+\�Y�R�=l�J ����l���0`Lϰ���rfk[�x�j� _�Z�+��w �.�t�r3�Y���*]�Q�o=��>D��VJv�lvD&F�5�@���k����L���u�M�0�%�1�r#)�f�G�4�{�_�:�G���}���B`�Q�a�X�J�hd�{�Òuomկp�v/���bJ$����Oɯ�^���<l��Fϲ�[�Z�Nؾ~�WX05U�M0���Cl1d�y����Q��~`;�7�n�4t���6�j�%
��[.�>�0ǉ�E�(����@�dc��yA�h�-Q�4��>j���t݂��N�Z)!���P~(q��B�Nh,��SzSx>�9|�Y�M�@�&��?��(5t86A@xB�i���?�g�����^I$�����U�����Q�G�725��d(�~�]�o�9 ~�R�|l$�~�i$g�� �{d2��g�ZM�0>�eX�0V�+�fb|*7��F�����^P�%e4����U����`�ON�# ��`1�f� 9�������;@F�i��.O8��B�(�;�۔�ct�=��@�h5��{9�&��'h5{�s'Sl/Κs�x�F�gyw��Ռcٺ;^�t�c����++��~7�C�����y��t�`y*N�B8����Ƹ�H����:h�o�`K�<�5��[��W�d�1+.F��5�f$z®e`���8ئGuf��Q�:�lBf�yJea���V��݊jU[�Yq:��J����z���.D��	-��ɬh��*�:8%[��Nm�E2L�@/��0��� ?:咚R��gژ����l��f)�wo�	�}qMoM�c�
�R����n+�%�� H	��x�#S��N�K.�X��;�\�Oh�7*;%�Չ|Fߓ���Ǣ��Η)���]��氻W�m�H:)E�{�,V^�Cu��g�L�"�)ؕpv۾��<�iJx�>V͐�a�/;��9�IW�~zLy|OJ
��F�񄧪�voamD�ff,�G.��%}B�l�Ǆ{�W+T҆���)�̡�F�t��|��������~A
-)����O�UP���Z�cS��ݷLZ(���Ɏ=w�:��0�1Iڶ������7���?[�?��W_��W���|����W�+t����|���|����5|����:_���|��|�����߬�5�Z���3u��rt������������:��7�����|����������U:���:��L���ߢ������=:_�su����|��\��O�|��V���:_�:_ Pq=j��t�#�d?������UUڞ�ɮ{����9��X1g�!�S�y1U0��p�ն$�{!ɵ rM�3�}m��|���ěc�9=�w�`�����������ku1m��4��H�-,'1��ЮGnQ
$���`����7��l*4M�j��N�)Ӥ�wmFɮcbw��+ܜ��kcC���oè(̉lbEkhv5dP#�9aб�MC��|��a��U#l\ZuB�'� ���G�}.��1�b4xSg��.��p���r��6k-Ђ�몁�Q�I�~�����f������k��kN�`	�A�6!��C�S�$@�-O�!��!a���E� ���	��C��|j]ˈ��4]>y��t�ҷ�����lM�n��×[�K��>������������ cf'�X~��<��`�|G+��A`Rˏ�aT_hȿ��~�db��i-?�:|ߞԮ��>�i���G{���Qc�ȏ�#,ڭ�`m>��Fc�Fp���n'}���)M��@;����Տ�)�``�p�TJb��N�,������{ :�;i%��4���8�$ol��HA�h�x�!4�	9g;K�㇁B�G�iD��z�թY���V�`d���2��)0��i�zfM���9!���3-��`Bo"��X_\J�T�fŪ �×}V>��ZxfS]%�k:̱�������g���D�iZ#�k+����A�]�ޟ�dX����4`SpN������.c��l&�Y�Ow�NBdi<Fx0תx���b��������ڽ�@������cLyݞ�"(� �����f�N�����i6 '�U��>68�
˽��x(}0��K�I��[ymr#={���.�d�>F�gOR��}l�E?��7���[F�kό��\����ٍ�ƝK�s�fq�����4�gvi�==�{�ȽKa�Ǎ���	�sNM��]��{0���,ЌK�La�o����vw�����ܓa��r��c4�F/L�y��� �7��}/0�_�|�1y�?���=��o'1E��;��Nfs/怌5��Z��Ú�	+C��9���j#�tE��5U*�D�}�K��~wN�S�{���٧��k����ۓ����y]p�O�Y#Ic�C%5��u�B90`:��>n�f1,`mi�5|�iO �?}
��:�?uO�=�PT2�)9�?B^?L��C}���=cw����u�>�{�\��=/���o��lp�7N!�%��[rH`	��i��N�4�C�Ln� hA��s 6�����:ه�e&�.���kw	�����R���NbF��8 b�X %`X�w�6(#u!�A�\���c #3�x�|���������Z��mV���m=���r���;���*�hQh�S>�#dkԑBʬ=gڸ��09�_&�6b�����^�q�)��C�������n���Ru�둫Aн#L��#���ˍ���8�[�=���u͸	$�	�@o�X��S���QN5�F֌�ԟ��5Io�ܢ��5�mf��<a���r��tSKob������� �}��k+n�`�T$�i
�3G�x&������������	�[#Qr��QR <�:+�Z���z:e�w��Aqz0+.��8o�4�'����H�� ]���%���N��A��p  ��?M`���)0�[f �u	�?p�����f��؟Y�d.`~Y$��k�[��hv��qpfD�o�uhb�w	k���Yq�¹�����KZ��SW�0����6�39��'?\��a&��@2�gI��'��M������?�X�    d)A��٦B��Z�.og�߭s��{���F7�A���i�՜��~xn�tazKk0]���M�i�FL����j,� ���
�9� ��u�fۉ���L�������:��0��҉܈�.���D��	 ~�z����i>�=��8����#;�oN�$�Da�(`�EQڜ�N�p���"A����^��cA�`Q�F���f�(�a&�u&N��9�z�E�u v��?2l�L�<,��z�b�5��4��"�bpTP��1�߅s G�/ig�����ue���F/�p���κj���DJ~�'H�;��'=E��Y��ǉ�T0��^�toOR�*��x�,іTI���x��N��O#.glj�Ux�[&�J{B��a���b��Xɔ�]ؐ�eK�ޅZ(�]I�6��ݓ�m��I�
�6i''���^V�Ē;ݕ������Zy�x�g���)�b\,�I��9;�W�iR�(�o���p����M��;^B�",���Y�^�N�����9�'������Ұ�6��M��)$�s<c��;���A��90�3�ՠ� �FV%�;,� CO<l�0�SZ7%,�`ʎ��G�)0Uړx��@4�q���:m�^u�@��k�7l��'��F����<�"K���]�g�̪�æ}�@`��<w-)��Ⱦ����O�F�et��%,����.ǈ3Zb�{��,D4(�j��i�y�����M��;3 }����Va(�/��4/��m��`P�S�e�lb�*+��Z��]j��5JsFI�����Ai�PV���m�a5��db�'�Z���)�.uXQL�]�ke��28,P$��m�X��N�L��RǫU��p(���,C4�
L���oV�G;�$My�Xi&"�����/D,wL�����U`�'�ÎBn[� DD<��L}��Bw
��.+�u���UZ�KD��?a�,P�8+N��0�o-aa'�r�;¥��ְ���.A%X��w�j��@��
�1h��8�+y������ċ����ūu�*l��f?�D���=h1;t�	ƨ��XVѷB� gP,)���Tc�Dq�M�8�^u�
׺E��NhA�\�o��
�r��a�h��\t�Ƙ��i��lt�lFuF��52�ˤ;!�|��� �Ӭ$��p����|T0���[�%A4x�LF�,��u�l-r� 
�+.�z	�=ۚ�@��n����^�ϡ�[���ł���SV7����Fs�;u���*�]9�ԙ�'�����_b���{���h+�6ꪊ�6 �g�~�c�VY30oY���, �H(��ݜ2�/�1���^vQ��n�0=}8�a%�\�Wy�>9���Pu
�	U�0���>���w$h�ɧ�2��1K7�?�q08��qg�Qv��U��>���-�R:��q�[�cU� ɣ�#h+����F��~�ɝ&�x%y2�P2V"[7:�t�����@�ݵT����W����ZG��`$@/P�^�H�V�T	F�qwer7sW V�Q!"ݘ
�0tS�i4���6%�%�
��:s������t� k��Mɔ�H�)�"�JmJ&lJl��us���$���̟��i<�Q��q���A���n]HA�7���ߞ9{�ѽ�o�h�l�4kP��iV�� �ǆ�Bq�fJ�Bsؕ3ߞ</l�2�����k�S���1���ͧ�]��ml�\��L
�	�`Rh+^
�`R��y�m��Κ.��J����y@�)���+�v���SmU�+jh�A�A��A%M���3���{J�C����	T�+�F!P��Pq#��9P���߈9�f��h��G�#�z��>1��F�_�֩N
�ӟ�T���'v��v�7�"&���4�mz>B�KDh��ҿg��Fȣ��`���P��|��7{.�8�֢s	Ts���a��=�V~p�*z�_4t*z�r��@��ÙEr��Ώ��O�v��)��I��u�MkRc�T'�sR!��SS�S]��❇���Ҙ=��n�rg�s�W����	@*ֶ�D��ߛD_��G��W��6��Թ��Hv`u����М�T�etx����*��N�F�H��/`��˷A�C�j)���%ï�R��G��T<����ף���=sʐ�z�p0u����"S�N�����UE���T^bz�wwmoi1@֠�Y�y��?
@����ou�s�G�h��Iry0�MX8�|àJj�L6�-z���#���W��kP�6߈M%��)ٯ뫋���F�;6�ߪ�3��s�.�O��u	p*F���a�fz63���p�6-��&F��_"��L�F���ÅxPl*�8�x�ŖE�۫=㠑�'�9MtG����	;������M&@��[LZ�JmuV�곅� Vwf�)�L�-����ܼٶ�K�ľ9�2<"�(-��U�E �)"7�~�+H�k�i����K��B���%�J8W"J�ըE�W�P�t���hӖ9C�b!�3��d�$#��y�Һ����𔧩�]�|������$�(F'j+���V�j+yζ�	����Ϛ�Zh�>aX7�e�����߈2���bG l�8���=ʟ�
\����SlE+���X
� e>��-TI���*������h);5�՛�p�Y���pc�:nÆi^�F��
zD,��J��_#ѿs�|Unt�-q֩�&h�Zb�`�k�W~�0Us�n���p��X0�*��~���t�ʡ�q��3�7Qx�� �sK����f�B�+��9�>7�s�v&܌:7�S��i6�p#x5h/����<�ڞ�\���j��I��\�:	ϡ�f��]��}���^處�	�J� T�8t�Ey�T*���l��P��C�v��x�n��nf8�arwm���/�`8�ԣ��|ev�	�o���	�	��^8��dv�Ce�ke���ʃ���՟9d�U�G�ӳ��y�x����P}lN�s�����,��O>��}�ަ�_v��+�K���<g&�'�"�as�ԫl��RgVv��ӄ�����-�Q��%P<7�sTm]I�����;���'�*�����v��w%��,,C}I��c�.���krF���xE��y���/g6=`̶�|��|i����WS�x<Vi�C��p�[ư��r��^@��c�1!=p��4 ч��Nr�ʚ�&�<�����#���j��sobYdѺ*��� ��p庘��TG{*�UEy=_�?�_MS-�v���?���8�5E���,�{G+YO<��$���g�3���Uw'*�c�6�#��Ֆ�O*�4��<�Ġãԣ��E�n�s$"{��)���?N.=���FU_�qE�F>-�X:4����.`yl�fD\��>X���u���3}�me�p~"߅?��M��˯ංA��_v ����0O�X1c*}Yc>$轲��+Le���W@��2��<�4�4π�UE��^@��J+��}`x<�%Y�\Eh$�R��Rnw����ɥ��m���K+.��9�y��הd[���֊yX/����z����AG�6�s��o(9/c��@�`���	-�����~Ar��:bm��
v��}mi��X�#V'�����;�d4�'�9�,R��1�eݱE�,�U _�-�����
�#:Q�Ա�n#�O��=ah�p�T��#o�	$=�6���>�!�o�|D���`��5h��</7��w;�ܔ8���!J'#��"���e�����������:���Q��aC�#�>݌T6����T��CT��Ȥ ��JLC�:��_���(�rNG�%��tMo^�P�k�)ԣ>�|dV\2�a_��H��y��/(���侦�`d�$��` ���"W�3�c�k���8n��-44��������d<�X�Ԅ��k�(r9�&�ǵ9���P�r�����	sW��Ŗ����D�c��Č_R�<�c������3"�G).X�
�Ac6qdH@{�C�ris�1���r���Ȏ��_u�r9@p��Y-��m�d^��T|�}�e���h�*n�c�=��p�qy���H3�nP��i    ��v��@����S��]НG\�g�n�F�h���UR����ƢSdb�		�;+}��S=u��˙��R��J�ﵼ�������T�r;���W�����U�SOMX1R�X�80�@Xh�k��I�3�}݉D�f�0B������I#��5z�p�`�l֌;���N��='��z,��8����(o����+�y��W���G�L�X�lE����-�vG/4�Z�V�W�*���r��C�R�wϽ�2�þv���+�����:��T7G�J�\G�r:���v����%��f^d�Y6��g��������ܔ`�W��V�mCH�!��.���It��\oue�
��g�gZ���ly�I���,�M]\��rz�w?��\k	Ǿ���EY�a�*��0Qh����&��PN_ҋǔ��V�'���^����~!�N�7�؁u�E���ᱫ1���钇��k/V��E��[�,~�B(pc����Z�pQ�.����G"O�x���PU�� �d�S��-����?��|�ȫ��ѾLҗ���p� �In�
�*�֨�����K�������� p�~j��|��)z�S�TZ؜�uS_��YQ|�,�U�`�Ճ-W����u+li�x���*&��!6T��'8IaAj��������{�c����|j�o8��?d�$W��m�U�=�1�)���T\������a�l�^۟}�.k��*;9x01�^s��ܓ�CÔN�/{�u�OX�y����Ӏ�S�����	���9���Nz/�b�r��B'��E�}G��i���R�Hf�����TW��Cb{�0��M�m���6�qL�[H���D+&�8��s�X�3F�<���_]������&#� V蟝ĵH���4�}$<��#�{#�v2��@�����#���P��>*��htJ���s-�
�'r�r�9�1ݛ��Uӎ��ؚ�7��3�m7ôA(��S��vH�@��VJҌe/M�h���|-Y!��쓽}�Oh�h�2+�h�R�Q�a?��F?諑���I��R
���3�43rB��+l��؍`Z^�$��I�赮"��n1Z�=1wN})M�\�)�(�b&6_U\p@U����l�B�<��5����� b����Z7y�hR�� ���
|����rA�D��RyZ�a���C-Z(r�B�a�Q�;�yU���X�&7���0�g�G7/�5���?r�j<�<ڽ�}�JS:����;A	#���&�}��B��a�j�/hy�	T'Ylj�n���"׸^���\��A�Ш�������"����	�}��!����1�g��=��a��ցRk�������i�ƻ�1L(ʊ$�/{��ۼZXx�9}n�%�$��^��xn�';1�[�$�O9<5��t�j'8�'Yo�����^�q�t���w�r�1s(�c���Yn'�h6�����L�;�N̉� ��J�3z�P �������ٮI7Bq}����x�x!��'�����uL��\$����=��Nb���S��NV�ޮ�`奴8�^j�T �,�sՒ��ƹG���\���Ss"�ܧ\},�@�����a +�gg���^�2����x�Q��n=R`�ںRl`{a��<of��'�;�Ij��LR��6o��Ni���
���hs�N�a�H4b���_ߋԯ|�����. {㛊7~]���o�o|���j�+߬8����VWS앏�,�c*�p���7��@��x�Ӂk�� ]�qo�:_ɷ�Yq&|=
7��o����U���^Q˃��i����B��j���7Lvhp
�S��W��>�c�:���h��^0�އV�voc�ڇ͛��j��H�����g�-ԃ�F�+ )a}s)����7�X�ċ���Gi�G��xR��	\P�P�\������D�<c�K�ۖ��;��ʮŗ�vx�Wj�0
MY5ۋC�<2��� �
��0/�\�t�K��V-�{W���؊��~��s2�M�q�v���,��ʒ:�}���	5)=�9�T��.�F<��~nPh���H�mY8F��"��+(��)'�&<�

3ޑ�R;��X�U�}��/��I�/{�eZ��W]���ub~P�G�n\�ĲI1E���nc�.J9{�	��l�bn0V��2*d�⸰��Mf�[��۰��K.�9�Q��]
�������5����3YvT��L}�ýDM���g,%���V�K�E����ϲ��K*π��6���_�K�"~Q1�3ZI�H��iįT���2�)��\b	�Ub�r��jm��]$PL�l�H��6\�.��3/MKP��
�H@ԋ��2$`�ϋ��ZJ8�J0ۥƑ�L�����3\[��ÕaV+��L#��b�o�4�ޝ�x�����b�UI���F�0fI���J��*�"�*Q��7}��m��Z��G���b��R���n�Ԕ����W��SZ_	f�>�Z_	\1͓�/���~b�o]��9D\ߒ�ca}W3��2l��V+4@��V��_Q�����g��}���]��a$�h��W��<4Ȉ�.�\��֢��_�V�J���Ŕ�2�]�Ρ,��yL]��5o����ܼ寖�j�ּ�Qkmh�Q���5R��dZ�V���
Ӗ����VԴ�)���0my*�p�PSZy3+��h�Σ����5*Ne��׈z�u�-Þ�/�Ry��6��s�]��ioh*mY~�\{#�q�=��S+p%LY~_1N4e]5�xs$�&�iq��+��є�&аL��ߧP�V-�O��J)s�e��V-�O���f�R� �O��y�[���\�ӆ��Q�ߘ�-�2��ƬW�X<��f-mI��I��
hǶq=��D�*j���*��bf-���*�Z��*���V��ZYM�����2�ֆ+f���ʕ]�X��?��[�M�_[Lv2�[����8��ϰj�kK*ǿ֪�Sh�j����q6��[ܙ#)�"���6��e!�����v&B��ƍ�L�-s2:2g��������4Q�+�T<]���'��@8n5<�Z7
��+M��h_jW��ӑPH��u2��+�h&W.hct8�^���C(�P���0���s�x�d��|�����"@_��ڂa��a
��eN���� 8u#�z��B����4e��g�-AP�/�����U2�KW����W��Kq�d�WCx��?/�����g$j �_#���kd��\�a��~��n�=��C��+�DT�? �Ԇ��7��FL��L�<Q�D��	PW�d[[4B	�1=2}	��1#��G���$�M�y�T�=>�,��ǃ�6tb!���Rb��B��<��Χ�=�;4�^<z�|�;ǎ:FG'u��V�s �g�0�O��O���)��~ (�~p8����F;�9|:ÃKy� g{B~d�p|����'�
 �v�����;L}�O�Aʝ�' ,��R��/f�R���OC��}<�&��``�B~�g�t~�3�����!�
 �v��h氿S;|>u�`��- 8���h�M�Ì@鮈;``;�Qj���x���n��3 ,��t>�9w���c�n��;���� �H��ѿ3s���!�W�" P]������'�<p�bc(��9 �tk`���̲e����]����s�vW�v�o�T�.�~e�b3`���������F�K��{r���/�������;ź��x`)�������]<���P��	zn�N�n(� �=78)��2
9�1!��Ϯ�fg�ss��qҍe0�]^Υ	�nj(� ��;{/���{ϠoZ���x4�ݍν����9@���SH�7�n@�����H��tWC�8&ٹw���5����'Z��5��T�On�����y�Ύ?ɎS�/*Ԁ�h(C��J>�ro��W��$���r],�m����c��l7PW����@U�B��>~�c�mO���Oa��D&w��h�;�.��l��s�J���Vy�R��m�Y���w����+��3 (�v:^�P��R���@��!72��}���+� ��ۋ��N�J;6��\��H�C�% �g���-P%�q    � P�KXyЈj4�����
���
��9�b�&">�,�t����;�}�|J%7c�TK7K�: �:���VUz�3�F�6Ѣ�=���m�c�������6�x _�ݺܵ�(j�I�N����$��ߘ��:ĵa��8Yоn�}�c�Wl����9�Z#���f�� cd�6<5ZtcC�}�a�+�.���ؤ�J���#No�amv��`�t#l<���fSiF�H9����U��k��m����CK���mF0̈vM	��йtw$#�i�h<КoH`��#�Lk��o�Z	<�t�$��X��"Z4�[>5�����)��D�Ɋ �K�F2!��	A7�����r�����vf= ~i�7�FB���E7@���(u��[f����˼�|U���s���ȍ��$�����6�Y�mv�$���UfĂg4z���E͍�HЖHy�~�-�Ÿ��Wܤ�/F�?`9�k�(]��󸔶E@cmdX�����h�Y�yJ#NS�9��6F��6=��Oic��6�6����+M����� ��41��?D`�0h�0`19�J+#�b{D͋�I�_�42�{�h����i�B�UZ�k��]b�H�Z�����&��#��4P[��hx�r̍��	������@���躊� ��F��զ�j4�nj��]:� ����T�J��𞅤+\�9���v�B�a�|����]��S O��4Eu'fa��:�����Eϧ��M�9�q��ȝ�q*M���mYT3;ɒS��JC(@��ˮ���)���xlJ�(`c[�ǉ�vY�v¹�V���HF�4�N��Q��v��,	�Ji8Tl��˚���]�>M_1��q*����m�8M���2$�Q)ͪ���,�����D�F��z%�U�Z!�q9lA������yW`M?�����Ė��H��e��޻��?�Z_�<�y�r̳$��)�*�(TFZ����j%%D���T%���SXƇBEiUq����l�o��*ˮ�
{�ck�Pmi, ��|��,���O8���V_��]�Z>�u�u�N���d�J�0`g��� e�i�\�iJ�lQg�<
���<Z��вr+�h��Vi<H�9n�Q�b6�B�aT�Q)�ɀ��[�! �c���H���A�C)�:ÍP��qk����Zr��ѭ�G��92�5n���3YJ�Ai�9tJ#4�c����iJ8it��-��Pi��lo�ɮS�����_C\����[�[��}�b���o-�(��kd2�
���8|��,lee��PܖXy�rl�(�,i�[b5���I�ţTY��.,�'sԙ��j*sgQI���������v�z��
e
�+/r�����fta��8��ݏ�))t� �h�����yî6�W��R���H��khY��Ѿ|�(U�������|��<�]'wV�R?Kk���f=tN9f[$J��x�8�AJ2,u�Z���$��ocA6�O�~֎��?�"�ɉ�E18b;�|pԙ>�����գ�)�ӹ��l��=lD�l8���F����ݶz@�_�ޭ��,Y~��+j�|CG�ؒ|��	�ff���������P��<*�i�ɒm0�4��؀���al�"�����mK,���Y�kUպ�*�{�/�}"Ύٴ\�2�-WV����]�܊yոe�2��r���ʍww��ޘ���8���(���/V�^���h,�s��W�I�z4
�(ӣ��͑��	�.<y{n��K�`O[�\�,o�LC�����Յ���O=�
E���H�_l�^%�#I��*�6j�62��`id�4�nj�Q&Q��讵���B�������$t=B#�����'$t=B����ww�G*���)z���T&��%Z����WDː4B�A
S �a�����#Z؋���{ıg����P����[� �ns�j#�0��Mc�q�e�H����t��n��*D�F��X=�e]�Og�M�Uy�DQ�j10�ݩ4��l4ٓ���s�9�e?<O!s�9d]�e������$�F(��IB��`�,c�G̰�`>Ȼ��E�G�^�M�Yz(��MVhm����1�ޘ�9y����9e�B���B�0�5E�w�y�^��1{���9�)��Kk��K=�-?\9>2
Gi����M�֥m��I;�iC>W��Ƭ'�IO�z�Y�Rl���[��},�"i�4(�6��lc�� J�ב��g>~9��kg'�^Z��S�*X��"��w��j$�z�qh�E<�j��I��b��W�x)���)�4���ʸ�A��.���=:R��{�r����:�E^��접3%�կ���^ �q���Je��z�;��9py	I�y�C'*�H�#�D�>�*!�������f{s�,k>U�5VPI�#����>65�r�����ìʐ1=(~G�w� ��7gQ/�����&�5�Qw���tP_�u"�E�#Q
�1$6u�����A��>��{��7%s#'��d1,:B.r�c�CI�tV��@GSX��r��b�wtBlPu����sC*p�5ïa�0��`=n��#�: ���V�b�iRPH�^-2M�
I݋E�	8��>��D],2��W[��E�	�8�#
OC>�:�S
[�;��lPH��(2M�
I��B��R 9	�E�=�|������s��:G���W��^���q����H���Jև���}|�mڣǗ9����቏��xwy`�Τi�`�� 3����?O4클'\_�:���ק*�3\{��t~��� V�ݏ�|���:N��6ٴǮ�z�U|�U|�U����3�������y���)l
�ۘ���#?
}l���l]i?\c�ZI�L@�sh�a瓃Ο���O�?=��׳1��kD��Ԉ	:���6�'&�쉒�gPg�_�#�H������s՗��>���2��g����>̣L������h��~�ݜ��4��G?��9]���ϰ1�y�!,ZB�iA�Y�K4�K^�c�`�{� �KG��Q�����b��
�"S~��.a�[0�_R	m��Ɖ��y��I]�Z��ϻ`H���4~/�h�DA��a����1��	� E�#�0O�o
"�0���W���:�S�+=�%\��O{J���T�5G���p)g���h�4"�[o��S��\��:&�vX'[?�DB�iCS��\B�eC�kCC�]-6��;Օ�k�a�י�QI�BB'ݐ��6(*,_�#���+���(��dG�IP$��qIoѮ�4Ifv?6	����(t�����\	,I>��k	�$���L	����H-	����P	�$�_�M-a#��W�J�Hʫ��FB@_����Fԇb$*!�u�#��N�Ne�@	��L�w<�+��B������$���Z*�$�8:k�M�m��&8I��$P�J#©%P�<�b,C�8I��X4I��"�ABER�r	�����|J�&��N�	����4I����K8H2����IB�U'! �񷄪�8$��Jo	I�uҋI�$��OC$a 	�n�	I��?�А�%-���=)A�4�+��$T$��j�}	!I�Q��B�V�R�S~f)	��G[�	�$ĺ�+$$��r��LҠ +�J�$���1	!I��*�BBFRgt@	�$����$$F'$
��H��I���%�0��Y7�����к1��B����~��ɀ�͕ �F���Q���:9 %x���H�8		}ao )�����ۓҬ�yi$L$=�Ohbh'i�~���������WRȧ�����*	�J�DP2����5���Ok�҉U'��푐���0��tD�ҚlDB���HD �vE�j���Oáګ�P7��]^֍�j��X��qKs5>HHX �(	���z�K m�I��L�F��� :,T���i3�u$ �6���\�s����S�Lb��рT��$JOA���~{u(�d�#�Ya��T�1S�[a�|:x�>k��^���\����O8��_c)�S�    ?y���
k&��L̡#n�"F�&Ѯ��0p�3�VB���H1I�KVM-4._�4�р�`�]&a�$��2	ќ�������e�]&m��t���)�ζ�L"5� �Lr�c=�e���̛��F @$;����R$���'�9����\�>=�^P�����N��N�ӎ�}�;�cl2�z{����#'�uB��H1}���˻'��t���N&�O�C n{g��_���f���M�:�4\Wӱl�g&����%xHB�[Z�<�e�nkJ���A�My�1p>�Kv��5]����&��� ��t��O 	�>bC��Ri7-Z�2�]�t*z?T�a4�������D�����pm��ؤS��-O��h���al
�9��3��;���y_.��TМ��4�/� ����b�L��4t4`|7EG6L��$���c!�� �y�c�I�t�0}��q �A_m�I�OF�=,�y�� ��hd������9�b�i�z�O��R��d�4�3W�R}K�����뗫c�ʓ�_�F�U���Z���x��E���>�.�ۯ�+���I��E�wR�*GgCT� UɟơӤ�O�4)�� q���|��A������f.��0��굧oK�6\:J�4�NzR�=Az �?�������CNk[��}7�4_9��e�w�2�P��bet���������䇙��ut&��׀ ��RCT	QݣC;3C��z�)]/i:UJ��4�I�R@>	�����O�j���p����7WF/T��XWB�P����5Z�����;��m�:媁�4L��j '�uzn��o6ד�9ݩc���%�$�}���7�o\s�R"�o]H����A��۞hL�eP�;om�ꊽ����aȾZ�?EH�FD��U�{�|��)�Ra�4l��sߜ�F�nm�!�!�4�!�*Q�6�"�T��������e��*6<f�}"u���D�f�-D0R�Q�_耬O�Go���H��!����(�n�G۲6�ƠS��O���ͫ��r)F#.��ͦ</��G�D��~"���5����A���x���oe�N�D�=���jODP�_��>0�K�Я����1�����;<������ ����й��^�;���.E�Kэ��_��Ety�-sa�^-��/%��pˍ(�*������l�	�A��!*A���5t�p!ǰ�yz�6��������g��.@��gQ
��$O��Y�t*�!�4�qHU�?�3�����f\�1����wm�����O�맜���!#�;ƢC�Q�ag�A�"��G���MUIA���,��/:oΰ�o���� C��X�� ���F����Ad>����	�Vռ�e۩lo�Tb��goΉ\��@l��G�vD#�O�59n���,$��4�h�6�+�F}��$
(���p�����n*���$]�Y4��@ySې�S�D�F��`cԶ�mM�I�����?��^Q�v�˺ՠ��}��c���s��v�s��kM:���ҧ���4�������t5e����m ��s��� �-M���p���9<����$3�B2��e=��m��hHbM��{"@�Sh-�Mݾ��S���z��ΞC9���&/��|�y�+�r�vX�ϓ܊��U^���=)�_Je��ț�_J�.���I&�=�_��| xJ��,��v���X48�b��汐��9B���u���&E�֌"�/>�M�։�Y+F���g���V�&=�֌�ϗ?L�9����I�� H����X��+��2b���ߗ�胭�� ��1S@��W�ӡ�#D�b�֮��Fh~m�V*C�`�)E�]]��E2�m--��cd"���>FR8�ȏ41@�����<�AB�s��?6��t�.ֆ�Ԧm��~��y�����*H�F�0�[�W�V:B"��	 ���»W*A&Z:M"g��Wn��}vAk�9kň����2�Hmk1���fD^��^y�����ʙE&f�8a4�S�^��5�+4�2�~��W^T�U'��<�`]���v�4]C����?UF �vFPv"�&S�jy�������C�����}I�0,?� ���^y���(����+��-YC�c;+�Ԧ1�����y��͕ё�3�J�q���01U�+�6N�$�m�'���ԅ���$�Z[H:��4k��=�U�IҬ�L����;�f H�/���h�;�fIoKh۸f6ӫ�߾�X��[-A�F��.��A���"�v�����0}�z�-���^):O�d:�r�8I䨤�	U��J�t�M$HR�J�N�5 x0E\yɶTm�&�<L��s�I;A��m��N�����⨅���C�;���l��Z���$��?ؓ�Q7�����=.Aw��&LL�=!Bg�6qB����b|��o5��)C{\�f�S�3@�*C{@�<_O�A�9� kI�9�+�L�f�F��m��5}��L�v�	�O����ߧ���o�P\E#�ܬ������2P-�{�|� U�/���&��B�h��t�t7c4�Sb:�Z6�n�Z�)�{M��W3�C�{cA�Zu9=\q���5[pB�9��o���c���:����qcV����z����%.��-#|H����ͼ;�#�>ڸ�����ݑ5ft����' ι��L�o��N����T�kGkg�9b2`��'{����(�:"7�]��T eѐ��(rl�}xs��$�._H!��5ZP�Q�ݘM��&��TN o���Lm�6�5Æ�0X�C����,�k��k������0{����� .���>��ipo�!@}���a�toe��9~{���q�-q{e0=�xdڐ�m�V�1GR`�c�5|�Ŗ�s����p��-k~l��=F�Ƣ�m�*�`(�~�7~��d�����,T�j�)�r��B��G������Cס܏[�Բ��%� z��1#,Q�������O�\���F�|��M�~�mB�}ڟN`	�mZ&oت!m�#��|S��F��%4U����p�Ug�`$CJ�\��換�6_b>�⛒J ���A���y��?��ģ8e���tmg�쌣6|Um�E\�Ykv�7���2��	�6W��k�5T�m�ar�_��F��fP��3 v�EZ�W`���1-�"L6�Z�g`c����*��ک����<כ�޶���.��'{���wxT߃u�[6ֵ!P�KQhF��  ���}F�U �e1AC�Z@��o�xs��j�.Y{ M��u�ٴ��R$ �=NL@�* �N:�G��e�ƀM),����t]���P��m�T�DSo<�N����̯���A'\��7I�Oc�B�D�s�{���!� 	���*�������s�ִMj�E6l�ŗZ�vj��(���ߝ��p~Ixc�ػk�:v�<��x���Dmp&�� � �'�����`�%�b���]Ԙy���՝���������3;��m/=T�V�7��O8�x!�1d@�BJ�5d�^���ZƩ������z^�n�ͨ����Sߥ��V�G6��⣝���_y�&�U:K�3�� G�ֺ��6��i�k#�*��R?N�'@ؙ�To2��MNo2�Ɛ?�;����k�F2�v��ٽr�ִ��oϠ�X'5f��r>�z��,0�9������杍�S�|!L��t�E����_?U��[���Wח_h-c��}��E�K�Wa�'�>J��ف��r�������e���(��1�A����r�З�

@�Zl�Mi ���H1�(8�`���@q-�k��W!��4�c�Z2�~3|8�%��鶑���Q�m;5S�u��Ik�ȼ�X���Nr��n�s!�Y�C����>Cq �����!��}�̇`���s�;g��7�I�7��>Ru��>q�y�CU�֎R���^Ȑ������b!>5�.#�da�8���z�6|C�n]�<����HL41�bHD,)��j���͵��F.&����ny2I[�    E<�v�D�i'�4�bc�����e�Σʙk;wf0g�E��*�z��oG�3��Ru���WOk]�!͍T�F뢢鎴�a{��|��,�L�W~M6��R�����nY��b���&�F������]y{m%I]:�ؓ&�E���4ac�)b��s,y���#���n�b!�$���%�;�޻�d!w�i�8�S�_�=J�<���Q��g��c)�����H"�Z8����lOR*d(p�{���ɹ00t��+�AG���|�����䫈�E[4��\,��^G��K�>��x5.�bO�tck�d}I�?H���0��%�9���'��1F�oX�
�h��\�*ֈ�E��ZEMq:n����D��Q
2�/�\f��zÓi�iߦE��}������h���'� �ĺ�� �AzqԙJ��'Ox�f��Ӌ>
R��q~s�rʺ�D�
4��47}h Ⴁ�B����7���O��
BJ��֌�ͦ���SCz��f����h��6��4�l�4��Ŵ�pG��VE:%62�(C'�7&��1�߇��)���������0|�L\F�`�����:��L	������:B ��;)M<̽������s��cP4}�x�}����B��Zm`	�@&�6�V��|R�@�	��~�L���(�!z0B�>d\����:᩻.}ϧޗo:��IH�p~���S����y8� gy j{Ԗ'L<�:A��	��|	�y: u@�L�hqT�5���&*���C�\e��iO�;P�-V�����N�Z�y&x���^*W�R���M�@�Oա�����wx����ì`	��ީ����aB�t�=P�C�+��fY�U�qgvl���.bv��e��x���)�K'Cy?A�g��~��J�ꤨ�`]j�)�r���,~窓��{ӥ�����w��ޭ�"��.o��	,:}�;���D���Mp���s�u�%�G&�N��-����xV�|�	��R�1��f�tZ����g�{�=�N��g�k�,u�7��3I@�d��,��^��a,5����+_Q�i0�J$�Nw�ߑt<m-:�j�Rֵ���n�Q�q/�'"p�Ԭ���~z��#	H�p�����)j��z4�q�%U7ыN��v�s��,��1K ��+�7�Xʲ5�AuVy�m�r��]$��b���������&0�4�n4��${1B���@��9�=�H'a-����~��Szjk�)6�)��Z��V���� �U��o���*j�c�Y��NE/��K�t�8L�6$�\L �5���Z��
�Rx�<�K��"ݙ��LU��0��r��t�;�(�����+�÷��<�7�@�����	��z�a)�K[C=2�(���6��f��2Ѱ�9f���þ�w�W�e��8v�)�����	����&�~h%�����.��]�yӔ���$ӝ�[�mQh!|x�W��'��'P�@@~�Aa�|�G
c�-�m>+�`穕��G�ݼ�9�iJ}m�DS��|�z�����C��a�i��6e�yYcЛ�2��屖A[&3䓩��OokJe�����֍���jo����o�%�����l~e?��V��i����T�f�;�vj#A������h�;�S?���@@�^&��Z�Sm5�;��2.�.=���/n��S->�Z%����a�����"�
av�ޯ�n��4�V���L����R�̠֬MYw���U�m{��`.�,n��kM:�TK���Ȋ֤S_gL'{�rC��,���sv��AmA����Mi��%VnQ�bl�*S��V�-|��Fp��}�v��U���pƢ���E<�r�Ǖ���-���pi�_W�\Y�|;9�5l���j~{E[��6}�1��\np��w�������ViXk�c1�����S,7�Q��kwל������Y_o��Ga`Yk��t�>૨.Ԇ'�ݒ�CGLY�e�6d�t�/7o���q�^k-�z��kx���bYkҪ�7��!nVk��7t�p���06�~IG���;�(��;�zCɤ��{�U�������7@��c�<��ų{6f���MP�E�����+;� �ڤ�E�ޮ�=��al�P,�~�!x<D�-�� �Z/d�	}c g�Ǯv��9E`��`��M�;���[�|�P߷����pW�P^�.��U�O���7����i��|}����}9�����|oZ���`���ˡ_��-���*\���4�c_�׀!������W^����@��d��שA�U�σ!4�D@�^�k�}�-"@�[����S�~eP�	�1n�I��ƽϡ���*�<8/�=�@\T�s�^8�o�G�^���3t��z�j���çt)s�I��v�P[v*���}+_�����%�>ͮ�`������Dnڎ�ќX��ee3z^���:k��E	2ib:���W!^�G8�?Ǉ�0�7}b�^i��q��~
$��Hk���4)_m�x��bP�<�9&�g"��;遝�����|����O�)���*ǋ�����x6wM�zfu�o���
���\���r�#Ϻ�b�0���+@�&�gJʡ`Z�ub:]&�#z�!:�:�]x�?��� U���`t2v<��O�ٍ���w@x�`F����==��b�[�&��Ֆ���.��Gk��u�	5�xb�:��W�Z#���!(Kufj��%��fBrAͼ�
A��9�$���'(g��9P�>k̆ ��,WptE�ʣ3������9�rwt�6�Q�'�b�q���v����n����7vV�Ψ4�ա�0?����!��� [�wwoW.+?���7W�zMECP�a3u�BP+E+zqA�&�h9��T�yxga��!A�-)���hʀ!��N��[yF��󗵢���B
pk�z���K[�G��$��}E��T#�+����w��H�E(MP�Vq���y�J��N孀�JQ��	�6K���t� �դ� �7i�es�kL��wG텠���d��S+�ڢ)-�׶��Hs>]�pX$���\��&�@&g����:�$�t�U���Y�K�Jr	�����^[��'f-@�$ �l#�|��|�2��y�e�V��I�����!(�}�	��܎$s�c��ڑ�q+��`���
�D9�k�ם#l�<'���oyw������ak���\�ⴋ��BXӽ�)�v�RVk=�ZOo� G�֘�@���S��B��?����Q6(8(��A�H���iH��g��	�'G������fVl����d�X6P��m��qY�@)��Ƭ�X�M��S ��IG�<<���KafK���7y���J{S}D٦UBm�'�빟�haAˢ�H� T<lKQ�4��Y��n��|krhC�2��I��o�:�[�D�BQ�/xzp|�ް��^"��4u�������:O�.���,�N��UOF��Nڏ�N�
Z�ˠ�yS��D4���Y�X�UJo�w��Y�*+H��"9L�(�ި(bhM��`��� ���C*��*`�w�\#ٗ�]\rѩ�ɨQX�ۢ^f#vs�W��](g�ʬ�s7�a�lu���V`?!��g��~��ó�i퐛cߌ�_8�Ox�!��N-P�)(%� tn����OGx"��(���CL�p�M�|�˺�gs�@��x���T�%D�ٟ��P�?���؁��.u��g~x��β�B"Rp��m8�s�S*��˴�@A������.�d"m:PGJ) ����H�����
9W9Gj��;�J#�6�|��y�'�i���|��0�)Jf����O�/?��T�/�)^;�{�o� �����?���}�=�J��S�޿�K f��g�f���셂A�G���߅����g��G�ɱ��S�������q����4O��b$����fp�X$���J�ζz�+}Q���X��*�:��5�B\��W(��.:"(dQ�K�vF�.�����s8�C�kW�����D�vKC�E2/���`    vrsa������}r�A5��X4��Rw_������M.�Q8$�ɱ�gEm`Zm�Jr+�T�����@3�ք��ݛ�5�v�G������Q Fc��CU���������{s���g��|�|���[�ɡ0������Ֆ]Jh��W �Amx����QRxTGKKc<J|m�1�a0�x���%�Vz\�>�Ex}Ҩ]���#��:�X4��m����x=���WV*�&T�į�Z�-�r�<�2sC��5�U��P)L��Es���P�qDX._�^��P���
,O��ڸ#�?A�h��:��M {�ue�dWC�	�쥝[x|�H2��\	�?s��W���1�+[�6�7̏`g�.��g'��i��$;�};SYX�crE�jm��J�+�Wn���6X�\10��|��V.�U[�G�!�)3�ۯ�T.�����ە�o�/�]�T�t4Ɗ�X��LerFLe�ƻ��cת��ߍ/l��~{<i91��@�rg4�i�$�!]-&0^�!��<��S����MG��WpӸ�U<�U�*>&��Un����B�΅��Ѽ���;wF�X��0��ڻ�p�ꋝ>�IZ��,�V�1Z�Ω���|),[g�ۢy�y�N�e����!.�ȣ�8I��:H~��V��ڸ��W&��P]3.��V�]6vv�#�� %S���T�*p��~���G*x�1�ü�m��+�!p��7�ή0�����\�j�f��ݱ��������q8b�_`y����-�𶗞lU�f��ej*��tn�PV����ٶC2���_Xi��{���ŌD�>æ Sq�f�ӑf؎Dg$7��VUIW4GdX���l�[�N%�e�N�:LPk����\�x���#�6�ƢY���նC����0	͟G�0�-2�bI4��1����7�O��d�X��y:Iͨ�䒪�^�ho�C�=�4�d?���f���~�k:����� �b��us�~��:�`�g�[`Tf��	�V����L.	{�(����P���7��~>�x)�k�GZ������b�n�)���^���0����+���\��x4��N%��\=����D=	�	�N��l^m���"U��G���P�hS^mm��R�Eb�*��h~	Ib{7fA9Z�!%_gOCEr>R�i�u�L��῜#�s�
��5�	y�㯊�+�o*����s<���9�[�Ƹ�&!�T�'CeΉqFpb�IsN��3nsGQ3N�c���ťr���^��Sf�XP�x�c���.�N�<߫H����1��/��`a���&���πd4'��p3�0:P�S65F1N2�x���p�R�^ ���+��F��{�-!6����6�Үu��9g�kx�l��7f9ş���De�%�D5/Gr���y���h&<P� k��z	�\�k�[��:�tt�#��Q&eY��Ɯ��Ȉ�;�L�[�,ns������}C�j/�$�F�!�q����.%*��h~�o������Gsp���,G�5���!�.�MB��,?O_��s�﷓d�R����U/s�B�+�A����栄�P�`_�NC#W̾�G����Am���s���W���N�G/p��G����Kb�G����;<����1�ʠ�'�'N�����ЁP��e]kė�wY�C;��*PK��|�3�9(5�q��F駭��K�-��"��:F�a�S<z�C�J=�?�	����x�;��C>���n������h���1=NW]��������)c�|X3��*���j�M����LrЛ�%zn����::I��;j�Aq�^u��"���_\�޻"��d��ܦ��j��R梽���okU����c�2�Q�K0g�y<�cHM�a���M�M��}����zl�bX��:}kC�Hr�x�$�5,a�f�a[�3���oً@�� ڻ�4�(HD]+`�#����u4�̩^��l	�n7�{׏����!��Y��~�q��	T��/a}C�t����X?m�W����qt8
�.��n���7�O(?R�
g�9Ɓ+�N�?����M7�U;e���Ň�6�u�E\v�l�q��]��R�F�}t�j���!�X��G�R)������[����}���꟱��yZ����<p�-F�w"�K��M~��-�M��S���N�(=p|���Ng�:p�<��qN�[?��! I�����Υ��]GN$3�a�0�����0�}*�x,�����-f�	���}�H�-�&S'!�I����J9\���:�.L>�Υũl���'s��9߰1u'3����:Ip�=��S']����l�?�I�� Q��`��^x걆�4[ �;�Zg3�OBa&�]��t8��;���·��g�g��h���y������M��H6���=H�;�������f"������A�t�.F��.��篈k�[�Nm����ǻ/L�]v�	���8��i�̩�)��8�Y^w?�4x��ߗG��c���h��U�dH�����ޗ'kS���p�åI(s�e�w`l"P�f�9�|�W�jS������o����̇�)�64���&���=^ؽ]vv_Ad��E����!j���e�#xl�dhX���"ģObź�����ǻ��rb�����>_R��"����;ꯈ��;�aB&H	��	���.얏'b�L���)�y�K������w�2\_q��������í�������ŝ�������g�&L�	;����"V��	M��Ѐ;��^�\��Y�����V��V��U:�U�*�lϰ6[ū��g�J~�<�S?<X6�UF/m/��*����� ��6���K_�r�T9��}���Z���g�k<�J�KO�O~�W��K��t��7��?r6�����J�ƭ�O��VF^WF��T��;z�ӥ�FNg��#x[|��|���v�ډ<sFGp�ܐ}�o�!˯�.��띴S�ȫ6V���6��2�v��4--U�~21t؉���)��.���Ax>�cߍ�U.��)�Wo�c�W�|\}|��Y����7�/!:T��L���ӝ�숼��a�F;��]�XQ)N2J��at��v�:y�����Xe��I�P!QT�g8QT�E��W�&o�� L�۝������&T�u���Ch>ij�-���5�%�N�u2P���S�K�%��E�O<!�xM�b��8����3&�,���]΋L��Ѓ6�,�P���sB��9l3.hܳN��n>u*�t���z�Ě���`M��z��$�J�s�L&��瘌�b�~��4��<&��8�]���L:̤�pxпs�,ӓ۸�ar�*u2�Cp}3/���, ��3!�w�9H�0uW���݊�#�#�i��������K��#��{��f�\R�;�'%�c��?f3`|a�V��[MNIn����3���(k��E�N�<n��P�d�4�y!)^������>� �O �x\��<�1�Nes��I��v}��*I���2J�X_cAR0������\:��A��T�x�{Y�. !g��Y.\
�
�:�Wsٌ/W�x��o�߁���P��8Z@t�2k��"�l�( R:H��]���w�S����Ƭ��9�����n.T��;�����|[�Y9�����Phs-����Fᶠh�@}���SeV��9�#�g�D�wMp�p��%�T������������Q�	E�9_#-R�>b��:93�(�l ���KT��j�� z����"��1W�u�}g>&򩊺�c�j�G�/���� �zw�'q�i�XT���5ך�͐dG;���m���i�L8�OO?&��l,�����)ci�0c�E���pq��]�o�p�VB0V�bs�GI<�3���g��~d��M1�د[��?q|Lf� �_9�����y�C�Zisq/�����iA�u|�5鯱��"��QQ
��z���n�9�6��:��A���L�n��`�L�4��a�b����5*�    K�Ւg�/)��@R��l>��%,�|�g�j�u��c�_Eծ�P���~ɺ�h:B}.o.B'�_?���Dr-�@K��Ɗ��P����r]㊰]`&Kj�V�� ���Z�gPb�߳U4�p����2����+n2`ȇ������˘�s�8T�Te���3,.�M���\%�b�[T�>�ĳ�a��u��e����]r���yy���(�5�yӄ�_/mdYā�����·�$�\{W|l��X��	_�'R�����ִ�-m�L�Y��N ��A�f�_��n�����y	�[��F���N}:W&�aTn��)	���+9]���5�Np�6�]>>iS��םL��4�q����9�U�����LJ�h�s"�����p��޻����=G���J�+��l����0P�{L�t�����i'ً�͒���:Wq���0�O��=.�'Y{�D*��ɗGP�����e�98=Y�:�Ա�$�G�\��ǟ���:�T��	�$l(C��Ӹ�&������y����$��hV��D���Q��*{��{�^f/�0y�@2���'��]��f�i<�Q@<��9�p�G�Fld��ɔTD��M��G���/nRY�C�g��<�-m�we�+�_~Ny��A�9�7<��7��D5O�Ĕ�BG�l3OM8����́wo������y坚��_,�܆,Gf�%?���˻�u����}L��1�+���h�c��~��/L�6qf���M0<�݂�:;�y�;������kP�c�|�6�V�|??��E�Gl�c?f߈�C4h;uЂ����7� �NJ�D��V6�ڃ�=�� mܺ���^S������܅�6��Յݫ���G����F;u���ˆ��+d@`GS�D#�j/�J�c�1��������SN����r��$z�ÇtΗK����(����x��������M��~�����B�����4�/�wG�t۟�w�qŃϓt�_�Sm���A���uC3�|?�ύ���S;�l�:�������	<b��(a�ke���,�[���ϫW^T����r}�ڷ��~���������/k�i����Hp=��J��7���2��Er��N+���H��B���/kC��K+�ɾw�&~Y;�mY�k�+�K��c<����k���>i� �,�����4��ʏ#��r��2�"��\�yzo����;#����Vyo��l?�H���Х��Hu��������0�����uB��g���N�PV�g+�g��3��G�.���ə��B{���:=ڱq]��>����S�J:�J�1u�����%6���1uF	�1X�g�x.��!��c���V�R��U�>�F�3���V���oD��)���vi�^��Y�Ψ#1p+(�k�c�U	�-���(P�q�8�U<#������
�2;�[�~���=�׆a-�ͱ@�x���S��w3tވ��x"Ƀ���[t5�	^aws�o;}:6�]�O�� �N������"*�u7
���s�<R0����c\��`�_��k���b�:��K��]�Q�o�^�M�<���T[�EI�14=���u���Ɠ$��SGSܚ���}��ɴ�Wn������~������7�X@��+��=덽+��EA�B��.�P�<�ĠN9��{N�e�س�w<�8�eW����x~2$��%j`���n��r��xw?��}<{4���n���q����g��E}���^� �a��wُ0��zM�˻�C�)�NZT@]������Z{�n. L�N�͞���ۂ=���=P�s�\�cl�����F��E�{�2�����y�r���TrԙG�X�i�\��(g3=��6TQbn����T������8t ��p����٣���С�;th��j���ox�����4�X�q������'�4��*נ:e&�����S��vC�6b7��˚֛uB£���Ǉ������5�βa��	{*�p�������Ĉ<���I����Ph�{6���;٠�%=��I��S%�,�z��K���ʃe�v�.�N�S����_����Q�y6f�'��!�ٯ��!�c����}�7�5�21�4J��2u*i����8�a,��������%ǂ��A<���h�a���}-�*�����nr]T���D��B�1�M�?�w�9� ���L6�}��s�Eԩ���p�a�'X���1���քk�8py9���䣽o�0�ϐ�8cT�^�(�L�BA��~�	�}H�� ���X�*3¯��L	��Q���pa�8M������Il�`gu�,�Xe�A79V��|/Em�|\�O��K���5�q��H}t�jl�Ei9�
���ţ�)�gsl�)p��e��*�9�;�k���^(�^�uG������"b�(�+8=�c�
�ʊc�[�u%���ϻ�.;����V����נw�9���4/�-h�b��L8˙��Y�7"��u"�;c� zk���Q+�O:o��X�*�/,1���@*�|�����Kj	{����"c���?�b���K����ؖ&ʀ���8|+x5y��:o�b���lM���S����u�_�Xx��?_�7�߫ߣ
:c���ۦ`gFx
y�: [NfKܕ*� w��O�_����}Mع����SGՁH�~{gќY�4�y��]�|e<vF����/]>��H�JHtH[������n����\Xq:��9݋����֊�� J� ����B�s�/V��EO]��]`>?!��M��~c季�ְ�+� aނ��r^ʲ���q|�遃"0ݺ�o'x�AvʐO&Si��7�r���X)�K��\^j�%y�Y}	�d~��7Cr���h���B�j��>�2!�E]q�����?ҡc�{������N �WV���avW��:������@df^4¢1}h���s��wK��p���p~�65��n��"$�S&ƌ�4J�A	�`�����y�g�N����6�ta�7vgy���@G�(���[��7��S�a�E�')��s��RO���f#O��]U6���-�LThѿ?�@���=��T�z�$[� �� �����UnU{}���������J�\��g��[��<�Ϡl���^ES�<Ò�X�A��S'D�{��N���b��������B:|��	�&���{��w�+gW�04
4��� �#��_l�^�emh�����������Qب��&���vX���h�.ä�2z�탲��J���G��u�B!
�����UL�}���nCHvhC>�aշ9�n��Gbj°g��ݹe̮Q���!�h�PnA�e�uh;�2@���4�p!k��UF���2���Q4J���I��K`�g�;xr�/=tK��#�n��~�I�2�|0L~gf���i���]���<�=�]m�激nm��!85�~�OVxW�M�J�P����:
+��&��_��!(	Rk�fĥ�'LPF;[�p<��OP߻�1��rs�b5�ְ�F3x�P�\�X6[N|�"�''{M"{;�ú�:�QY�Z8�%.��U���S�dOÛ����˖�&9��6�ְ ���q���E.s�q�b�z���<6|��eꔾ*�QB�Ǆj���z�6���K�U��Qg$.�l:��0��9B��N&{�(ږ2�]ʆ-b;c@G����ݘ�i��h�܂��Xv�`��C����ۘM�(i��ݍ����Ӂ�Q���֬�J�ss���a�O)�\�c?Frj�tF�$�/X�T�4,fj�f:�Fτ6*����fp0D�>n;��n�Ǟ�\�
}%�"��fsi���}x�q$�lG���`���	�+�<�R���0d��$pS�I���1o�0Ե���V��
�Zj�x�����6k
�W,4�:6z����Z5��F��ᣂ��3%���~F�{�yVu�5�؃1�O    +򀿊2V�5z`�b�Q���/y�/�U�ے�aZ�&R�6���#����%������ng�?���lW�6��|�wb�~ꐦ�F����G4!{�*Lp��w��:]Y9���A^��dT'\��n.m�v0��:�]�bݏO��@�[JkFLcHhZ�+��C����K����6�UrR��W���*�:�ĞH�,B�Ic�fD���i����o0G/��3]�6�-�<F��Lq���>hCc�_�]�Y^E��u��e!��E}�<�/����/6r*Yt0��C��H4��5���N3�6�� �z������j��E��p`��q{�/0���P�{�l܃�� �3�J��X4{����x�G�.R��E	Λ������wX"�1�ڔ���d����<�Jq���s2��)6� զCb7��d���;�,t�r�bR�(Meأ�\����!.�oŧ�oT��־��.�m� �ء0[j>��%�uX �j6G
�3b!�HL�9<��<�y9K�7���wSc��@���h��J�Ԇ���|P��'w��Y&��uE�RPV���/B,��!H�y��G\*+�zT7���6�'�?
(�hP'����R���z~�rv�:����Be��_��~}�
jCH	8��!�JDN�N���{7����w}W��*�Y�$,3F�XTF
�q����bo�0t�O��(7�
lg~���	R<_�Vzw�2ƣ��!wNatC��� �ce�sÈs�-vz�
�lT�eŜ�q�È����2�� ����$=縔��+@����Y�4�ͮ��qO/VYºt=II���L$��O�㓔w,W�s
�#Լ�����$N����ۘ���I�PZ� q�Q7Y��z��zy���m,qc��S�Aһc�}&�p��35���l��m<{|���y�`=x�S����8��,����a\i��tk7�0��^�~�jm���9�|'I�<F_4�?�����"fh�&��6ŋ��9d5���ws&p��Y�Jd�g�|֔B��;�}�.�TIo�|I��I䙒3=A>&���j�58��������N"ߕ�1%�Nɣ�����ąGZ�5e,�P�Y�X�#a:�yL���B�Jl�?����.�ݕ�%r$��(x,����`�$��]��I�d!�g�tR�	�՗_�Ł�hR���إ�ȭ8�S(.���+���:�&Q�<����@�1��>���'X�^��Ĩ���,Ja� ��&PЂl��4�M�Ϡ`�y�A��-MԮ_��5a_�'L���Z��p��"��40��;�vzqx�8Oj��r�r����Q���^e�e��=�}m{�������:��t�W����ogW(8��Õ��-��y=J�Y�W��kgv^>% ��T���*���m&7=bS�*c��"JO�`���s�չE0�5�EIj\Ktl!kX!00�V�͠�p�@ [|��t����&��.�-YV� �������^ؘuN�=��j� �G�KOil�ɿ6��J���|��:Jm�F��5��8���/)8��%�5}����G>����,g4L�<��W�� ka�L���D{f1�t�B(M�h/?�/�����uR�^WXJ|F�+���b蹯>=����AP��էl��ٶG�d0�E�T��/�����;?(Y��VY�rR	�ʞ���zF��&2�:��:�yŅ�P42ӥ��j��#>~�E�Bq���OYn�����U!P�ɲ�)p�G�k*˨^v0��Y�Lx�S�V7�|/f�C�'��e���5~�PBhj��換Lƺ���#W<�#ĵl�6�7�l�ݜahm^�pD|������ �h���5;Ɛ��|ʆ@����i<�_�����f��$��C�!�
/�}��N&S`���)^&�9�˞D�.�� ����'��?�����(���t�Ξ�1�d�� 3�G���a�:g���&�3&�B
6Ș�`�Pt� �:/�q����& ��% 1���ٜ�{�@���x(0<��5���N�b��T�V��]r2�׮����L�9����W��5�x�0g�����c���&�^]�[i�aXڝZ�R�֏s�֘����kZZ����,4@���~���f��[S�Dh�<��s{������3����*�o�4Sy6n��ep-�_�ޚD�=�a홴���9J_��^Zݹ_�9X����@����n�5W���I?��B�CZ�����K}L⭔�����8��b2l1퀖󂹛v^�>l��@v�<�)a��0��J�JӁ�%�%�y�k= �_i�߆��9X�g�<�_ڭ��`u,[�w�5����\ ��r��"�+ A�8���G��81�YF=h�c�N>���Q��9���?�sp
�r�0�� �^�g��l'IJ>Pظ�vB��d�4�xH�N� xt��́�X/u�x�0K�L�\&ң #v��]���Tr�8�����MI��i9�1��҄0���D6��':��rl��n���a��!=
���e�,B���є���P�����?N��c�t� d�|�Mezr��Q�L� �{)w���	�&�^z>[�qT������V� `?�	�,��!�㼬�Pʳ)v%��d�8�r.���	epC �\R�7�������	��N"��_Gx1��U@�:���lq��튋����ɬ���	�\���I�k� "�h�;7�?������L��#�<
޸(�*Z�븎y�8����Ŀ��Q��z�@�B�F�[��>n� ޖ�y��h���xE΋/���! ��P�൨����TE��H�;��Bw/��k,��o)������"<�fZ�fa����7����E_�=�4�XÛy?��,�J2�.���׽]�pM�M��/�E��*�0@Q�V�%��c���M���.�/5��8�إ&�bI�/5��H�إ&�bK��^jb-Vq��KM��*�D_jb-VY��KM,fE����bV1��KM,f�#�/5��U�����,2��闚X��Y���Ŭ���KM,f�v׿��b����KM,f�F6v��ŭ_��KM,n�<6r���-����/5����إ&�~B�\jbq�7��KM,n����Kͯ�������o�����O}C��X�������X�"��KM�KM,a�V��$��J�KM�*���KMBgR��SM�?�泹���i�@2�uӎ�7N��iv�[�/4Pq' ���!�_�G�i����{���'�ߏ(�:oK�1��{��Iu'�.���B`��u�H.������ ��o��no���`��M������?fs��(q$�}��9>;��f��:M&�����ׇ
Gө��$;�1���8{z�7��OSKn�%%�d�?f��?&3ǿ�P�ȁg���D�Sm�On.w� ���1y)}�D������ �/x��9�:N�6H��Ie>���g_�[w�=����t���s苯Hl�ʥN�������/�_�nϑ,��ôE��#^;{��:�� �هAˇ�n�s�)��9xJ$���Yǲ�t�PmI��8<^D
�X<��a�0Ԭ9.��p���|�u�f �e���hp�����D6�T�-�1�?r�Z�f\���R.*A����u��Լ�ha:P�ej�C���}83�[��p�N�����k����[���؇qXI��$�{@P����{f�f��`Ɯ�����ge�ͥݩ{�7��p�
�`)��ޛd� �S�3 |���
ԅ� ��,y~�v~��0�k���˯�fmx��J�ܚ���3I1$A�uwx��f6����=�/��ծ�R{ax\�	�����}���<�N��ry��f�Fo���0�{�1�p�6>���@a��1�6�HI��=��	�����61�����pߊ�O4ɨ1XW^���}1�al�v�
مA��'�����B�4�S��aF�٩��v���N��u���삳{i�ٝ�=X�Ufķ�6}i���G��O>�MA��݋��jH*le���%�1!��yp�학��깉���l߫����w7    ����T�A%yx����?�3��@[u�!TG��m��T�߰�<�>��
>�v��,�ơ��f�9W�6W)�Q��y�@/*wQƙ���]a;çj���*�aԖ�G��2}�m���+�!��Ǖ�g��#�IԹ�//�-G�F�ە�� �,�a�#;��t�2��!'p~X
��.>�9n���/5�vo�(��'�Ȉ����ꌳ�:>�n�o��@e��� �8O"Ƌ���zr��d�:y���w{}@v	��+�
����y���gY�^�]��t{�޻�s��ٷ�o��l/=d��������ғ�����R_���q�,���c����G[���.=e���z��O��S]'�d,؁�t�V�ED�(�An�yF%�nތ������V�٭�ݭғ���[�W)�����b�f�aԕ�i^��`p�*�Ƿ���
�8��n�E!ϋqv�=�f�Uzɺ�ɗ�[�����*�툡�?<U�����p�|j�',���|�r���$7> �"��o�f���z���J0.T����1"�#͋)��|q8wƋ`D��T#�d[�{���Eζ�.��/����_#��� ;�Xq[���J�)�߀/IP�gM6���$��W���Vq�]q�z��N�'�1�~��}�"*�мtA�P#���f�y����y�	и���;�͸�@�L���J��i�0N5��t�f2���"çK�yML�����g'��c��@;�v�a���sW��"�C���y�5*{tc�R�R��ȫ�"2�h��n�P��ӻ�Ͳ��T����B2��и/�ϲQ��SdUy���c������A��3��T],��q���s�o�5���Hm���o<�.���x
j��@nE'�v�^2��*�������4G��v�%Oes{��Ě���xp��EGAL5���()6�{�G�'D������9G�'��6f3`1�S�eX�N`Ժ�/dz�N�����$/�d
�՛�e=Q*$å�Ƨ�X�|��l*_ȹ\]�&�l7���ㆻͣ|�u�S��@R�����l�x([�<��^���<�>w� &��:n8�	KDY�S�pB��@H�u�p�	/�1���1�Z���;\�M��q,u��e��d''Y�`Hq�S�ƐN�!}�<�E�B��I$~���$�^�_c��뫰㆏OS�DȞ��k�1��9��Q�˂���]�ȑ���F8t�2I!��3(R�	��Z�?�x�1=��������J&/L��ѷ��f_�}��0�)��x2�Se�>�K![�qߧ6fN��1��_r�-aoG��~�<�Ly�����	7��l<J��y�6Q'.�q;�0��~P�Y��<��0�a3�D3:�6�>N4O�+ٻ܃f������/�$L�!q=?М�&vG��ߏ)�&����2C�F��1��=�W	q��g��j�;.����f�="(T>� ^0J����c�$����O��"�8��D*A���J�?6w�� �<N9� R߫����?��{q$7�!��\��0��~�?��m,��x�� e���]���#�7���N�A02\�������~���x]c^����zȔ����g����H}qu�9�lG�z� �~_�"�b�Zu=)�K_����_���0^X���y_o���,���g���0�Y/�G���ƷJp���}��8��7��kT��Щ��{ӎ� U*�=	y�/��T_^'(7���$� I�q��2�ao����T��k%:���Sb	�t�,��f8�پnX�]i �d	RB�6�6���n�ʀ�К�I��"{�f 3X>Y�Q����q��[g��=��3���͠���]��K2���}� �(��)͋��^s�Q�����3Q.�#�����x!�8��M�d8�W�F�^<c��;�#��}��O�Zf�eK�p��QX�I}� �tH��/J���<&6eMK��Ȩ�4<���^Dl�0e�*��A�=��0�劥��Y�N��_(R��nse��Zy��7��o�<�H�����	�(�0�ҁ<=CnvaX�ɩ{�0}�"�6���>�Χb�YX���Ė�¡a�8Ȯ��=�
��ܛ����i�K�/��x��r�8�������~�%y�7�d
	���9OO��R���K	�X3�5��G��g�H�
t	Y�0G�>g�G��x�Ӯ�g#$�1~ȑ����$� ��ė��|D>`(��M�#cz�	�ˢ�Ϣ�,����t��4wZ�������i�;]��<7}l�s"��d2s�]�r^6����Ib�/h
�F<"���j��K��zs{�s3���R�>���.y(�g��9"�X�>�4��¥��o�3�J��y�gb�Y�a�/�n.q?���f �������rmx
�"�.�_:���b��v�Œ_$Šo�BC�`w�!R������/#3J�-�s�����k��Pv�$�[�ͻ��M\���K��`u�q�4���~Y�>�N��L_��֠2�������Q^Clga�-=�.jwm���m���ʍ��KK&`{�9�|���G���Ap��4�tX�+�����6��}����o�w^��������*Z�m����Cq*֬�
�P��򓣆A>jם������V���
���f�骿`��fc��D[��/x�/�ޘ��d�O:�p�Ly'�{������#�H�r&�q&��Ib��v�'!�)�NB�N6���<m�.�a�M'�;�̠.��7�(���!�j.��KyT���-aY����S8�d&��~�_���A��<o�f-�u�l�r��*�@;��g ��X�V��F��B���m̚�m��'�S��g�#��D�nY� KWp|�+���o<�"tq�~K{���Z7��s�ג\�E��^��P�Y\���/�_&�+���r���W6u�_i���"��h�=�꽾f�.�]��.˖���0	�,��A�(�u���G�`��*Z�����0���/QZ�L�@Ua���8��*�?y��g.y{�}Ʌ��zZ5��A�c�M������8�y���H! 3�iW&g5G��4?N�>�[*B��v"��HI�[�`��U���0�Dd�l����y�ќ�(S��x�i&�/�"�:�SO���Oɓ���\��t���	��9|��h7q�K���
�a�J��Wȅ��
�)�@��F����q� ��_|\���09����0��U\�:Z,�������vF�<P�?ĺ���vv/^۽;�!������jw�5ז'k��4&I��~�˓l%4����@�t����݁!������t��>�vjk�X�T�Ǒ�rq{�og�%\B9�7)�o:�B�:z4��v�iG�W�5خ�� �s/X���+�ա�*�N�|�M �����E��N���M�9�-l���A���%f�R}rO�HP��UW��;���OT�ʳ>�T�>��a��	�&�17���(�^�*-�����I0mC�|�������1	�� �8��xE�0���_lǄ��Ci���wR�>��U\R�w������f�؈�P �il�ˤ���g������.�ă�����3����D|4�mVCFp�+��H*���{�hHL�
>#^�����Y�9��d|H<�����o�|G�:}��~z��#5�jW y�)�6E�#	{��1��o�s�=�G��r̝���tzc�x��|
�5ʘ-�Ѷ�'�Qڅma��i(L��7����&Y���짛I�r�����诟~���#Z�VjG��"i�����!c���y���W���N��a^D�K�&�2wԷ_����:��.��̷��Ӻ!8���a�Ca��s�����Yn9/9~&-�Ԁ����D59Ԥj�0$�{Ƥb-4i��=n�v,F�كzxb�Q�j�����[m�c&M�}�����a�Cs��n���~J��~9�g��^԰R�_�L ��#o.6oN��z}��W ��    a����P�3�����ւ��7��v�{��h��76�6�4�ΦS)/�?�-�/Gn>�$C}5��z<<�A{
>���Һ<r�!�_t��q�&񇦯U��iݩ(�~���¥ڃ�f��i��S�� #�[����!g�<��x��UYlvo���%v�^���u�lV]Z�^{������SYi�.�V�C�*�c���S�����+F�5��'�ͨ�����{���(�,�l~E?:�g����%bC�ErB6Z!�� �{д�%O�`��	�m��6ln6�!�������d���[眪���]����̸��s��\�;7N/$����p�`���]�ּy{k��Au�#�{g�J��AE�:��b-i!+ ���[F\�I�Uq�$.c����R��9T-��}�ј��K$4���~j��2�rc��y�w�'?Ae[�EieuT�:�V�MzJ	�T��=s�2���S�f�5{���8톰��O��"`B5�[C�P[��n�16$�:���up�x
X&1�F��%ϿY[IR�TU�\����찳��5H���>�E����o{{|��o�_~�����~��K|���	�r/�Ur��B:��;vb�ΐ������j��S�s�_X2�v��e�{sO��;'�aͥ��;?6�CI(�2�D�*��r���û�
xs!S��*:�Lk*cZE��pG�7o.��!�1L�f��$"DX�Eۗ��\�J"��S��o?X�ȿ�D�/�$�t�_ I�G|E�<�Xd	�M�z���"���O�(��1B���۟�v7gi+ī_׽;`�]�Dj_H�h�Ծ��q$ZtO��K�?��I�]��?B�C�×h��Q��	����5� �#�\`��z b!�� ��B:���=�b�y��X��F(�u��M����?���޽��x�֜��9�K&�����D+`y�t�V�1di2qGtO9hhn�؋�&�!�FԱ�=J��Y�(5��ٽGk���qÙ��qÙ���Xg�4Vo��S��4^�O"B�c�� S����s���/+d����`�!��[t��l��S �y�26�&����xٖ� ��U*��<�)��*DY���A�H	dV���}�f
��������C��<�4��T<��6+��I���R�����x��8}0��Y�om��Z?$p�����UD��U�f���SF8�1I�Z��F(� ���XI0��R�Q�~�	t�W$���V$���+�K����	���8��ł�?�$pY�x�U��6�U�1OQ,�Y��É �YzZ'cT��|��ڹ}O_�ωQ����	D��޾��s���9;�3<em����uzy�j@`}�򇅻��A� �vsr�ܯ>zn���٭�?;uP�_�@���H<�#A�bR'p	�Z�Y�c�0=_����EAh��Psu>��{����qt �S��V���y�t����ە�>BF *�V����:e?��:C�5%@����LH�D�v yw��̮35iE�!�Ԡs��� ���'�������B���$d#�t�(��<�g��y ��
&����A�7N�SPB����O�t:�<f��S��B@��A�ec���g�@��Ѯ[���N@�g�C���U0n*l,�-���2ovKW�`h}S�;q����%��bm6d�VO�JE���`�(�908�!�ʁ��F��5^y�ţGŞ�;����(�[)��\KX�&�u�# <��<���3��)���Ĥu2Fmt���j�8�{!�NQ�o�|Xl��4f�Rq����	�\�ݨA�kW`"ؾ�A5�}A�O�4;�b�SZ�'*� tw�h���A�]2��;���?�IO���6�7��u�FmVy��G����W�)�r�?��(��H>�q4�^�9�W��8��䚧�?�n�������X�s��6���
���pn8��xe��݀k�k��/�K	���\�v֖Â:�'���(�)�8u���^� u�'��0�P(V����8>%N������W�t������ܵWܺ'����`x�}iC~�����4$���ӕ����_<���+>[�x�[^'y,k���c3P�k�!
�:���*������b��W�H���8fI����*�4@,�����G�x��ORL$X�� I���j��^�!KJ��>��G0B�b�Q.Q�3G F�6 ���'�jg)�B(�;�<��h�g�>8�5<8k�~h���I�~�
�����KG��J��B�x����l��E*�7�c����aaA�.۞�o?Y�,������~
�sg �Z�ѷ�`�:���U��C4��1�bgx��<I ��Lv�D_�N$�4]�g^�;#��1��Rph���Ǉ�YzF��Kw�;vFL2K� ���>�d���_F8GƤ$/&��mRB�Ѻsk���x��P��{�w�9IEʾ�了I?�0�龵z���Q	�|C֛C��0�7G߽~�/-�1��}B&�_`�lU���`���]�K$\�x�(򂞊tǷ�92NN��<{�R2�8�]O�o���95�R0�8�O׷V���M�M��_�G<�I�a�����3����	9������/U�^:Rҵ�	�w��{`co��-�m����3!����#p�Ah��Ս�+�׮o��cY��R����f&�d:|�����I�D">^Gґ:�z�TiErz�4�b�6j
z��zA�y�
�� �Ytq-o-:2GŤ8
�x��mR���nN<ؼ6��K:��8��N�������5��g"��M�ຆ���+��=��P���:	��n�${Z�,�,�@Nu�iO��Ce'9c�l�N�U���/z9�ꑉ�lq��	�ݏVU�G�c�72fS�FS�6]�%a2l0�K5���P�[��U���V�x4���V��V�im��y�i1�Z�Ĵ �ఘS�ڣ�s��6�0������L��}��t���cZ�~*���+��*F6Z1 �ޘ��e�����d�]Ŗ��I5�D�U�.^5���YG5pv���Y��!���$��d��r�a��A5�w��1]�`�p�
�+H��՚5� "~h̔@9`��OBV.�v��ZH�R9e�Z.R3@�
���ޫX�� e���l�4h��5o�9t�J/-]���Qj�"@�2/�Z���2o	� Ο�G�b,gR5�!�b/���+b.R%�,M�Ė� ��y��݃��'��o F�U�����@ԲveΠǞ��s�1����$M���u��{p��������JX�^ M}�w�\<��qA����)��㑏|+�SG9a�_��Sm�4{��0��2�,F[]֕]B@\C��7kK��磵T �cu��!��æa�+�7��D"o>r�K ��4S��,R ��H�)6v�m9NFm�
�5^��k,��#kbS�"�&xѐ�iRrJd�;G��%� `��5)�ź��<_Ҳ)�?�y<�
E��K�ü���);�����x���s�
�zOC`�/��-'K�f���QgKo�������f��'@#��k��\��9�����b!3�c�e�	F�/�$/LPb����^��M���3L�L{�dn�Q��C1B� �(��I����#˴��b�-���*7ř���XvK�0��V�Vv�ul��d'ΔED;��CѮW��Fy�'��I�mS��TD\ޗ��v�+��`D��p�b�w����7ۮS�4�5�rl����(L~i����q�XC�E�����0�j%aejpT*���F*��b�Uҽ��)��F@-�R�7�J�����9ï������ut�����a��A�00:�g���W�1|�rlg~
��>���\�Өvr�Ĥ��a�%����wn����`)��v����[���l��[�͟&0r�%��Ft&g��9�����M���o]�<���#��1���scB^�����Ȁ�4lz��S�j������Oຩ�[�r)�s�\_�T+~v���S�a@@�l���R���{ �   ��5�je�e��yT��2��We�a@��D���}z�,3J�&�H��k�wԙ+�S����ǲ/���B� ��^DT֗�eӛDM<�*� +�
��KKLy���� �8)=�Ӕ0�g@�HBS<���zc��?v:��; ��� ���2 ��%V��Y��]�v��I�      �   �  x��WIn�F]�NQ�$5�Y���Am8�M��V3�X�*��1r��$'ɯb���A;��������U��]�֏���(����ʛ���h�	�'�j-<2��B�P�ϘΤL��ڲ�D&u~W�*yS4�сu�r*{�<5F��u�q�J&��+2�Nj����yr���Llj��ѸH��ri�f����f��B61�}Wm��㪻�y�.�!׵va�����h-�Y�%�MJ�?-}��E��@�ȑ��e�����"T�!J�����{L~)n���b J�'\��L%��q�J�
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
,��͕OH1'S���8��}�A:�A '>����VJ�LX+`�bٜ�ݲ#�x� 	O�9\�ɰw^M-OJ�sՔ�'������6Lꭨ�(�`�����zAa"a>�'���t����a�	�^�9$�UH^Ns�9\�`9�7�9���ڤ��D`Ar��=]�y���m�l�hn�����E���<U]�H�����:o��j�厄��"�j�m����~sK�-���������ؒj�o��O��/U�����y��y����hi��            x������ � �         �  x���Q��*ǟ����d�
�U_6Ŗ,��n�����;h��9Y7�4Z�����u�rrP�������U�oR)|�Gl��f4R_��`';��D��%䍞19W	��$J����V��d���&	A���0��S���	#k� w�oX� �"�jӊ�(!���G��:��mDϹf9�O�w_���W��J���1��pH�ޥ��n�zm=�܎F����)�4�RHP�:.5F3�`
�U�ي��Vjam<���7�C �,��f\��*n�PvFG���-�*�r��&��#1�I#:��JR�-e���5R��35	{���l��x{6�R��>̅�u�'?�-c��*���M���|V��D����:jgVCYŲ��Q��I^"��h�\�^�5:�?�����Z\Iw�kxB�J�,>EJ��r�N_�B������{�@�&[q��q�9�@��/����6�Ϸ�V��-}^q}�e��*��������ܷ�!�?´at���)����5-0�>��F��zԯI~�wh�-<��ww_�v�Wf�,����LK����a數o���q��E���X@Ū�h^1�Hey����p�v-&�~��~;�!�y'�1��$`��Y�Ǯ�̯+Թ"E�����A�{dSL\�ˉ�������baugε��hz�!J�.�O`w�����"{<Ѯ����-y�G���n�����o��^ �UY�4)
��X��h(ۛ2:���q�ΖQ�5�sڅ�_`
w��~�d���l���}b;���Ȏ���Η�����Y��XL/�ci�%˳��ЄA��ec��y�3���}��]꿿��W���(O	\46@r�Q��N����'�R            x������ � �      
   F   x�3�t

u�q�4202�50�52W04�24�22�36562�DHY(Z�Zꙙs��qqq �\f      �   p   x�5�K
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
Lw�TrN/��&������U\C)҇������B������ȇ���]�X�b=��3�A%���)�j[���̡��.Dz������8�l[�V��,t��:�>8�7������l�9ϗt�����������B����+D��n         i   x�342�L�L,)qH�M���K���L,NIa� �PG?� W��<� Oπ O?�`�?N##S]C]CS##+Ss+SC=KK#|R%�i��ũE\1z\\\ �V#     