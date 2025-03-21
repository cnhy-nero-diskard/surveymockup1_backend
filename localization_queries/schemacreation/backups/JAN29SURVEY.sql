PGDMP     '                      }            survey    15.4    15.4 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    public          postgres    false    230   #�                 0    17188    anonymous_session 
   TABLE DATA           Q   COPY public.anonymous_session (sid, sess, expire, anonymous_user_id) FROM stdin;
    public          postgres    false    245   H�                 0    17161    anonymous_users 
   TABLE DATA           ]   COPY public.anonymous_users (anonymous_user_id, created_at, is_active, nickname) FROM stdin;
    public          postgres    false    244   P�       �          0    16524    country_names 
   TABLE DATA           J   COPY public.country_names (id, iso_code, language_code, name) FROM stdin;
    public          postgres    false    221   N�                  0    16852    establishment_localizations 
   TABLE DATA           �   COPY public.establishment_localizations (id, establishment_id, language_id, localized_name, created_at, updated_at) FROM stdin;
    public          postgres    false    237   k�       �          0    16835    establishment_types 
   TABLE DATA           H   COPY public.establishment_types (establishment_id, type_id) FROM stdin;
    public          postgres    false    235   ��       �          0    16815    establishments 
   TABLE DATA           �   COPY public.establishments (id, est_name, city_mun, barangay, latitude, longitude, address, contact_number, email, website, created_at, updated_at, is_active) FROM stdin;
    public          postgres    false    232   ��                 0    17086 	   hf_tokens 
   TABLE DATA           8   COPY public.hf_tokens (id, apitoken, label) FROM stdin;
    public          postgres    false    243   ��       �          0    16475 	   languages 
   TABLE DATA           9   COPY public.languages (id, code, name, flag) FROM stdin;
    public          postgres    false    219   �       �          0    16457    localization00 
   TABLE DATA           X   COPY public.localization00 (id, key, language_code, textcontent, component) FROM stdin;
    public          postgres    false    217   ��       �          0    16595 	   locations 
   TABLE DATA           t   COPY public.locations (id, parent_id, location_type, name, latitude, longitude, created_at, updated_at) FROM stdin;
    public          postgres    false    225   ��      �          0    16447    municipalities 
   TABLE DATA           D   COPY public.municipalities (id, municipality, province) FROM stdin;
    public          postgres    false    215   H�                0    17028    sentiment_analysis 
   TABLE DATA           �   COPY public.sentiment_analysis (sentiment_id, response_id, text, sentiment_score_positive, sentiment_score_neutral, sentiment_score_negative, sentiment_label, entity, question, date, language, metadata, created_at, updated_at) FROM stdin;
    public          postgres    false    241   �                0    17317    survey_questions 
   TABLE DATA           �   COPY public.survey_questions (id, questiontype, survey_version, content, modified_date, title, surveyresponses_ref, surveytopic) FROM stdin;
    public          postgres    false    249   �                0    17394    survey_responses 
   TABLE DATA           �   COPY public.survey_responses (response_id, anonymous_user_id, surveyquestion_ref, created_at, is_analyzed, response_value) FROM stdin;
    public          postgres    false    251   
      
          0    17308    survey_versions 
   TABLE DATA           _   COPY public.survey_versions (id, title, description, creation_date, modified_date) FROM stdin;
    public          postgres    false    247   '      �          0    16533    surveytopic_types 
   TABLE DATA           H   COPY public.surveytopic_types (id, type_name, display_name) FROM stdin;
    public          postgres    false    223   }      �          0    16751    tourismattraction_localizations 
   TABLE DATA           �   COPY public.tourismattraction_localizations (id, tourism_attraction_id, language_id, translated_name, translated_ta_category, translated_ntdp_category, translated_mgt) FROM stdin;
    public          postgres    false    229   �      �          0    16732    tourismattractions 
   TABLE DATA           �   COPY public.tourismattractions (id, ta_name, type_code, region, prov_huc, city_mun, report_year, brgy, latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity) FROM stdin;
    public          postgres    false    227   �5      �          0    16827    types 
   TABLE DATA           .   COPY public.types (id, type_name) FROM stdin;
    public          postgres    false    234   �:                0    16873    users 
   TABLE DATA           �   COPY public.users (user_id, email, hashed_password, full_name, language_preference, country, last_login, created_at, updated_at, is_active, is_verified, role) FROM stdin;
    public          postgres    false    239   �;      &           0    0    attraction_types_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.attraction_types_id_seq', 11, true);
          public          postgres    false    222            '           0    0    country_names_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.country_names_id_seq', 1, false);
          public          postgres    false    220            (           0    0 "   establishment_localizations_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.establishment_localizations_id_seq', 1, false);
          public          postgres    false    236            )           0    0    establishments_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.establishments_id_seq', 5, true);
          public          postgres    false    231            *           0    0    hf_tokens_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.hf_tokens_id_seq', 7, true);
          public          postgres    false    242            +           0    0    languages_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.languages_id_seq', 8, true);
          public          postgres    false    218            ,           0    0    locations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.locations_id_seq', 52, true);
          public          postgres    false    224            -           0    0    municipalities_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.municipalities_id_seq', 1643, true);
          public          postgres    false    214            .           0    0 #   sentiment_analysis_sentiment_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.sentiment_analysis_sentiment_id_seq', 1, false);
          public          postgres    false    240            /           0    0    survey_questions_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.survey_questions_id_seq', 83, true);
          public          postgres    false    248            0           0    0     survey_responses_response_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.survey_responses_response_id_seq', 749, true);
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
       public          postgres    false    229    227    3361            �     x�]�Ms�0��s���&�� 7�+R�:P�/EE�i����c;����;����<w� Ԇ�MI���UZ��I�\*�t^��PDR�	���3��o�dQ�����~&o�%=w�{�ng�C����Z�Nw�a,��#vz����?���T���wG�|��f���0��[Bj�M���mƱ�,Ib�3t����h0�MBf$�MF�B����Pi�/��.؞Ƈ�N_�,��ʣE����;����b ��'�MN��I�o����n\         �  x���Io�@�s�+*�3��7���-�$P�R4�1��@���=tQ�^�PF�H��g�of64o��W}�>��uف�|��� U�ܞ|IlY>�>�}I�*��B/�z[���T��s���*��:�%b ��"V���9�$MΒ���U�.��ڟ%��f5,�������Jof�g�.�b�,��wk_]�8�<�	��
PN0Y�	�j��3�ד���a�<:�48�iқ<��QzC��x�\֛&��1��?Nj	�! ��N�!�� <Ӛ)�	�o;��``~���&8��qjn�A���z�Grt�S[g�vP4���@im�G�BN�v�zyg��t/>,�k$���]�0��ְC�6�qr!v2G����T�Z��dP������!\#�F�޹�����`����6]٢�J�fGL�/��;�EV�oY��1Yi��KM��R�v�K� ����l���zu��I���!o��y�<�)㚞s|�� )���x��6 I��:)���q�{�����l�����F��̟��U�bd��+׺!�ű�G8o�tTS��)�!
Fzc����<cy�wf��I�ͼ�_?7o_��㶞�|��H}���θ!��� �\�[�Z�Y� X:����G��b@�_���W�CYJTڔ�Y��{U-�u����q��0i�&�\ -8;+<�Z�g7��� ��δs�=���hڞ8X�#9%;��yM2�Rp߷hF��A� �?��O秧�� ��,         �  x�u�9�0��7��ŉ��!JBBH4v��3o�T��qx����}M0n}$lg�/�u����]�䯭]EG}9/?>_�rh��M�	��y�%��"� �:�]�o�������e��n06�"�6Z�e�l	�+�Hx���][4 e��A 
8���S�����I		 ��u9Ǽ!�5ݓI��l�\�_��p�C��Ú�t���`+0��Gy�+Ε��n���t����!𬘥�^��.��7�|�t-g),�ɬH�Rӕ�=⍆��]�S1����	/4��s�Wa����Tts�(���madyԳ%+v�Br�]��t]�2�����i�n"�J�k��bAia>�mH����\���:Q<�+*�96�lBO ��a��LN:&���ےt��k��qp��mw��CX�g��,O[B��5u���b�;[j�q��T���"����O��������r�	�q��      �      x������ � �             x������ � �      �   *   x�3�4�2c# 6�2�M�lc m������W� �>�      �   �   x����
�@F��S����h�&�Em�L:������	������9�aQK�!�ݍ�lh�d��iXY��k��i;��n�p���ٮ��wi�e��$Jؓ-DX�I����^�r���\�|�7���:+k�ϒy'+����C�s�%�< ���-�z
ޒz��Z���k��x����)-�0^��f         q   x�3�5r+Nqˎ0�wsw)v��3��Ȱ4�/+�6s�(H�*�pNLJO31ӎ��t���/p�
3�(	��J	�ȴ��r�wͱ+()���tq�O+JM����� �� �      �   �   x�3�L��t�K��,��,-�2���|��������y\Ɯ���o��y�u���8���L8�9�M_�lΚ��qfp�r�Qb��剙�@�gF&�%;,��`ɊK{,Y�`igf�9gQ)�ņ��/6^�uaǅ�@.��bN�����s�l�=... �NDF      �      x�̽[SY�0�����ez"���������m����9q�P6�����>q"� n�e0l�����1���$����p2sU���E�����i#�V�Z+W��\��R嫮-��-�&=�.���k�h�(3Be߄#���2BFDj��F$`��SZS�I�6�i���Èjw±�n���We��>���W]������h�Qj07ύ��O������~����8��庞���~J�i��)xF?�����w��/�t}Z�Ut[�����l���������������e�6��o3���g^e���������������=���S��^�霄 �n|z��p��n|r7>������g�L����B?���������n�k7�A-���{����j�5���<��s�jz0����k����``kAk�43f��X
Ug7#eg�E�&#�vkk*�5���wۓ歩F��=k���/A-�5�5Ŵ�Q�v���h~5LM�w����@�������s���ǉ��j�;�K������%���8q����8�w�=�� _�B+f_���6�h`����Ï�	�Z���c���wg_S�RM%+��E۹��������vJۉ�ߍ������Nb'N�6������������o���:�]���N|\Ӭ��o;}�k�qU�q��A�\��j�95�( ؇�|���^1�p$���')p����h4� 4Є��DD�S��X��N���2���pӭ@�Vs8f���[�5��q��5��3z.��t:	�6΅���?��o�����jZ3��aKa}�"����W#�Ѓ�Hx�h΂`��!��Ӱs�/H�@^���������
���ױh�u����r�J�b8w��JN*�t���mv����zT��Ϛj҂�@ߤ+&$���φ�dDhd�/4�A%{�
|
��_9}���?i_T~Y�9��8���<���ѥ���.jgO����dK���z������^�����e�orP%O�H�x0}��H+ag�p�W3�������N
���H���rG�����a�h�+����� |���J��,�u��f>-��*8Z!] '`�����p�MO�a�G#k��ţt�J��/������	hX�ǝ��K�D��a��m��:Aɳ:R�&�G3���ɣ�`n�;����MY'�y)�=v�%��2�� ]27�Xk�����x���=L~ZXC��S�#7�v46�8J%�����S�����~`�_uȁ%�#�p�<|�)�]@�Kv'��	ir�9`��A&�^��MhM.�.�s�ύ�ʁ�6p8��%�2 �-�� pf�U&~/;��t��$�2��2k}�Ι�ۇr�'�m�@�᫻��xs��@��djC�M�-��w�믬/���6
������S?�p��)8�$1�}�3?ؼW��}��D2Of�w��CI�6������8-�K_A�{|+,�� ����Õ�ڰy�IfN�~��n5���l�p��ć��O��3�C��M�L�<8��3�r.�Sz ��m����"�W\��Q�f������T6���Z�e	������| r/ݳ�n��N���?��e��Ow����ր~z7��۾��.��KW�]b�p=�M,���#u�Q�@����/�&>춿��n#���T"����B��ۡi�n����~��M��?��S��U��@&Ğ�+��T$4%�f'fm��F2�MA宧�v������ﾠ��ӈ�<r�B�v��LW��D��v�s��MZ�ݜ�>�$zw�}��n�u.;����C)���(�Q�"�?�t�ś��F��7���S�7Eq�
�dW��k�M�[v`B-��%�V�s@*���U+��ۍKO���f#Sm6�W1��F����}�&�xR�@Xz��W��xd2���B���n�Z��5Ƕ��V�In��W�Є=�M�I/�z�(j=2�Jf�v$�쟛� [q�f�(o0�[c���)�!-�ڟ����_Yؒd�]ݒnQeAK���$�+O`I����N�Z�HG���h�����oр��VL��m	�z��+R뒿��u	����sߜ;s�̹�����L&�,L��[N��L��R�L�okV��]e;,~�V�-���+j[7#e�ZT���ª _e�\�=ښ�� �JW� �؈�WM�m4Z�I�1�N�qr۶}�Yo�1�&��(��L߂N��z��TUL�B
oM}�����Ə��H���!�{��4�
�y�����@�d=���oM�SR�Z�2Qbyn���|GWԴ`����R� �⥋r��,���d��8�55#��~�O��֔�Rͦ�b���(�9d1%
`���=}��e�V
����L^����@R�/��_QH��T(@���|�TV���c��*.�.�E���ǉ����?���1V�E�n>�'������*]���_�%��<��[Џ���t�>'�g� �&�O�yQ��6���'��r'�z���k��]�L�^��H�ȉ����!�9UN�~@-7���/Y3�H��n.>�s:ȱ���N�|�n��K~�[sk�x7ή�_ңa�1|N�7�sl���(��u]>���������Mt�\ ��-Ja�	9x!=��'i mJ�k���h�1`�D�Ɨ�{&<��a�q�m�9�ѐ�=�)�Z��C�	9|1�Ғ&����[M-�ew���&��4�׀R����+B=I���s����N���*GRX���8@N$r�Ot�x��@��U�_v{��`h�]>v�v�)��W�oD7�����;�����Y!���vz作@�n��
t����^/�~�%УeY�^D�yO'�H��D�4��޹3�ä��φM���aח�j���#��ϓ̨4���vz41:� ����J�y�?/a��H۞�E�����6�!݁`��Kr�!s:�KVӣ�~9d!=G���/䠥���`�+�����Dr\���8K{q�nD"$6Y�~|>o{D)�PX��QI�}�2��E�Q�Ɠ��fd�a�)�`�'�`���`m�m?�~H_ ���3�����3�ۿh�`d�������`�@99��z0F�]�^�#���N�j��K�
��Q�ͼTs�^/Uv����Kv|��*�,��Vq��m��m��J=��U�#��Թ�[���J��.�U���Է�[��?GUBc;��oȧR/��V�*GU뽳��I�Si4 ��ш��l��p��B1xL�iOK��⠙�̷s;j柖��?�� ����R��Í����,�H��;�|�'�V
x�Q"��I�� ]2�K��o\�3*ܑ �W#u���������馦+��|���B�+����;��YC$���	�&r4�/�M���Ā)n�54��p,���<�ha�F-f�{M�/ �A�6oƂ�;2,<�$[PO�*�2��Y<�?��֎����F$�r~t1F���h��s��O����HP�9�a�pGnyP��gW�?b_wn�_��gW`������g<��@�2��s#��y4:�N|���#	n�5e�á���Zq�~�q=�	��[˽J��gQ�Vq��	`<Or��h3y�pT;Nv��)M��\ǻ�$�Ek�x
T@/�Y?ϳζa��� ӧ�%T�,�I��Q�`n�R��y�vm&v���l��g{+={��φ��89O��+�L���~b�<����?)�$gr��p(����$�<�{6���tݕ �<��X�3�5z�d�����9U����3��y��m'7>91 �ОM���F0z0&l���յ��~`$ύ�6�~�۲�ݙف��Rf��pl53�&s�������Fg� �z��]����e�<S��C��0ϖV�3�s� ߝ'���ޅ<]�^�����Ǎ+3�*�M��M�%���F$X����sF��"h%ϭ����H y������tT�L(��鰛�    x=s����Ye;ơJ!D<�zv�q��6ׁ�$�<��6�˻H 㙔�1�4�d7�L�ps��I���n����LlW�����n<�t%���~�f�E��t��l��
�Ѭï'��M�`e�Q2��]�g:�4�^�x
��*9�����/��:�4�MZ4ٚ5��F]�U��ڿYv�@N	��df��[)�Y ^~
��C@�`�%�#P��'"��\(	7�~lԵ�'#�D�M"	v��G#w�����=$��݊��Tdų����q� yF�Kf�?Ǯ���&�L�Qoi�?M��<��s��C�ή�9;rB����[��&�3Y���~D�L�<��OO.�1D�.� �2�Kl34�/07�q{k*D�"�f�.jq��fI�Ҁne��GL��E���|��I h���`Lz>�Vrnhm�@I`K3< ��
����|{���5%A\����� 6��blM�X����92�`�VH�:�n���=`���Rخ���p 弶5��"8��lw�(��*0Mǉ��s=�56nMJQ0N8�L��N�An� �(zG����|���o���8!Q�j��,,�;�-�VOj���s� ;�����}K�Ӹ��"���k�ߠ�fGA3��r]�����v�xNc�#/Ci���%�Fw�j�9/�YɆR��D$�I��-h:�'��m��l��}0�q|M���UEp���V�K�Yf�C�h#7'��j�L����L��.��Jk�j�i�t��o��B����(�c��vɺ.`�Qun�/�rA�r��E�%� �^��e�vz��xY����F�^���Kz�A7�i��?	W�����+4�y���T[����[ꓮ��Je�e� ,h
b��K��4���	��&!D�s�=!�#��ԕf�[&�Plt�"�x�JGR�II2��������]�O�kQL��'��N�_w�.��A1��8N�&f14yS����t�� �������l�:���܎�9n�4�Nq@��Ӆ���|g�� ]S2�LX"~�#����n���@e/��p�y��C�C�VZ��}��Z�4��*�:��|E�Rv���Qj�h>I�
����2�a��N����G�{+wYH�ዎ����˙�>]}EtNt��J��b`�.$w��>$�w��b�uBj@o��9�� t8@j�h �qkAxUĖ�{� ��<�#[S��Nr:����E}���T��v��u�"|W�Ѝ~���э��-�4jU�p�?����IQM��]��m�<�6�q����6�~�n�igo�j�ȶ~/�q�����������Q�LM�X��k���b�X:���r���#<��bx0�C[w�gʽx,�bX`#p[�0����#������,hhFP��N_E1�,t��xu%���+�!'/��C����)s]T���v��Dʕ�-̺|?��
���M���r�+[�x��v�K�3��={sܷ&`�-���82����K���WW�Õ6�>��ގ�/h�����o%�e�<�P(���ts
3����0�D�B�+΋PŒ̿~�>@�q������e�>o7���Z�Nz]O�PEYebSʔB?�f�&���O2�Vr $�)�����8��X��SSOqFUT����'�G���k�1.�X�r��j�����o&���a�"�֯~�9�J�����wڋq:߱g�^�6�j���y�����ɞ�������
�p긽M��rz��E0��B������Z�:x�!�0��	�+px���!�xcB�������.F�	MF�@�fUS��F�ѵ/Z�%����"Hl�����
mڌǢg>81oy���S]��謺�g����N���:�F�g/IRr�}��y_'�� �8vxa*+0�{m�R5	�S��q�)p�
�"Ɂ�(��vX*�����4Wc����A�?�����ϭz$��#�����Ϯ�Z\����X�e'�n@r�Ĭ��怩��E��ގq4u�h<��y�̥��Rx�C=��|5[Ñ���ڕ��^�t���GBn��-_�%�m������g����ܵsWex�q�� �/4\���)`U���M�Zq�7��j=�M�����m���uM�%��a4���N��z�
�3o�],�b46�˾q��.�
�S�Պ��,C����������G3��X*��q;%�+����ۼ"N��0�~EIe�5E'��|w)�5x�3)C!�)�}�^��+����q';�A
���B��qrX;N�MO�yH�
rY,������w80�I����+̉ro���t��PG���������L�]�Gw��dou� ՞}>���X$t\-���ycpd���F�ۆd���ˎ^��YμNeH�u��I0)��_p�h���V�J�Z`\�{T��յގ'.0�'�1�$[`�6Ni�^����{���V��9�y�ϙ&�����G�9����
��-?��T�/0<������3R�\#yX<����,�s�`�6F������sR��8\�3��"W��ǂ������_����zE@w��iAC�3�:<�'�&���^�ۈ1����P#�N�0�N�������+����Qx-��k2�n4�i��Z:���g��B�D��J�i)�.I!v���Ϻɴ<��Ma9c������ti)#E���.��_ O�9bV��zBlr;��4�)[S�
�r���p�YD�B���JԈ?���[tw �N�>^V��T�_7\�S�����i8^A� �Wd����Y�����HC����V�l�k%o
�]�@��Ikœ�- �-�W�m���l�˖\��� w8�~���r��,�b�F�ݺ��˘�	��T&���J���dMѤ�2�Oϵs��'�I;m\�,��r<1<1�/L��;�&0D�_����D��4��+'�*� �e�_�.E���2�I��ꄍ�3.adT�'^̩Kґ�g���utϞq��xn��&\�O�hL��k?)��	;�Й^w��۽	�S�.�'�ʟ��.m/loh�D���A?�W:֤  w:����q���������nx�4˭cd�Y'�/c� `��_���G��V'��A��P!�1@�>��!�Ϡ�?'I���n���o��g�>��h�u!y�Z��|mƶ�¿���)�#�h
�㎔	��(X��a,I)��+˚0�G�|�9��
?����c'bZʤth���C梠B~m6�=Mv 4�;(�*;+Ǐ�W�:?��t.j��~�h��/��Bh����J�"�jT�$��hjUh�2������Bz����:9��h�Ú8g"�ͨ��S���7������9�=�
ڒ,������7�p�v�R�����n6��i��G�-τ��u��φ�6+�]6"���\h��F�W!b��J�m����ט�#�1�}Z��=�<~���]�(1hO�j�:��`v����O�s#m�3��>�ڨ�G��ԟ�I��J�ev�#~���Ʃ[*J	�7��*
3,��3��`,9Mu��ҥ��4��o
�ȍM��:frã�6=#����r.���S4;��uj���hw��Q�|�(�lp�+|J%ѧK9�O�a�I�B��+"R��&3<	�q���g��Sٮ�sc��_�W��>���2{�m{�]h)��I��M�}�:[���\�<u��X�L���
�*"XM�O3����+�ᷙ���/���>+X ;���eg������=u�×�����录�*L�3�����)E�L��̫���<�Ȭ|�4��r/=����`�j��x���� �sSy�+"�����ލ�>XX�[�	�&�a=�`Ю�G���	��M���z�c,�'��h�z��;�P7N5(F�:*Q`��K�yS������1��t����+������Vs����ñg��������\/�- =��G/���d]O�$�5�Jf���v��M�?���M�    i��M�hҽ<%�v1mٱw6�M�i�����h�]�p�E4���Y2j-}9\H�HW6�NShfDŌ�aM�D�fc�p�JU���KB[���e/���m�X�4Z��&���hd�LGA�N{%ܪ[j��)�X�B0\����rԡA���[O�T�)�6˯��X�
�MlSk��j�t��_Dh�9�����]ol6�{�r;|��������`��ͅW+��'�Ҟ�N-���t S� ��(���K�[�tv�}(1UUπ���&���/�Q�x8���G�����l�U�yvk*�����dBAV6����e�1����d�p�����6/��`ɼ\UQD���v��8s�O�r�I�7�$|���c���ȹjC�>�t,�m�-0�vgl�gW�]QUq�n�ΧdN�s���}�(�mB~^'�~�HZ ]�����H���2u�3�YI�ߓ���mN+X����Y����6���h^x2��𘚼rn���%�ʶ������R�~��J;"�n�s��eS���uq`э����?ʌ�,� m=ŋ��)}gyK�9�5ڥ�-#�71%ڲ�?�+�<b��%�@k5���YB�S���
nԓ��d�DG��em���Q�^�MT��L�Xr'��ܼ��jd�E�o�'�O�Y+�9���b��Kv@�`<���4���)g4�.��Y����jX���nP���T0�Y�j`뺅x�v�VAS�kk*�����m�Q���
��Icdd�� ՒK7�WA>���GL�ڽ�.y�UV��F�4���D�Ń�������\�4R�!�P��<�5���d�w�W7fs�#����Ħ���tM`��6�w�[b!P[A߈������T%�\�5��X��P��|�"��YٞY��5E��Ӆ4�G:�㾙��$�/�h���#�3\�{֏�#{&1=53RMߣ4���p`��q7@}Z�r��Q��!Ֆ@�~|�ʒVJ���S�T,EP_�R���ۙ�a&������b6��L�g8��������2�V)�ί§�@��X/�}��J��"���Tfv@��_�C�GUE*P@Bb7>M&�_2�ovq��{7�>s0��G+ّ�w��֓@�lF���C���������ɱK6'G��uJ�@�)���d����T�)�u]�0�8�ۧ;�^���v;��C[�?�
;>b��X��d��@X���$�\�78�[����VZ�HX�K�Ay��6rHqH���B�ِ�)�p���>G�8�Ӻ~���c� vjg.QQ �mL���p�WH���R9��X�N�L�e9
��R��ꡏs�cn8�ig�T�7�=�gTN���t�&�w�R��l����q�
�@�	I) �:��~-�N�)+.G^LI6�j�\�o�I�!�u|Ue��v$����5)����ٱ��O� �����)S��߾�-��$����^�NET�,uq���� 0� �S�볲`iO���c�)nw�&�������*��bu�tQy$↣�Wɖ ���z.pT6T�MU�#��E�q�;���\���q�0�Y�۹�=P�w4x�b_u\_b��灈��C�� �6n�k��H��|#��"��V)D��,��90r�p���A-�H�QS���ER��H���e�s��h�&��6b'�\'f��k����@DP�(�ҢG�b�w���eX���F��ЙX$b����#�	t���/�5�.�\-���x��-r�p���Μ���kڕ��n���kg�]=s���	6�W���I��;�����"͜e���rU!��;'�;����ܬ
|!y���,��zF�k>�����<�l!���v��Y��(����+	(ϝE���V�xtܑ:���������;ϵ޽��2K y����,�{X�G��^��~A�#�X�w]���&�?~2��2�0�k��A"σ���h�{�D��d�v��
�����)5��X��A8��ur�K��V�7s����r�o��bn%:\��Iy�u<�B�DH���m����'�$�����Qg���$@<�r{���f�V���@��wP��e�L��[���9ػw�(~	$Ͽ��C�X�4�m[�_}(�-�uXQ.�	,ϻ�����:� �_�H�y�Ty*	��<�yv���􃃹Tfc �Jv`4��<l�;��`��P�sC悾�D����m:����a�>��_��te�<�6b�<�b�DH���}�Qj/�_�zd��o���y���?"��Ϫ�r���S��� %n�=�C��I��&&il��w�\N�X���3���˝�B,���_��ps�W��Wq	A�r�W���`R2t���:����ל�gk�ӓƳ�go�bQ-<ǀ�t7�6������������|ΐU*����(��C�.>b<��!���{p�ŅӒY'H��~NK7��� ���A����W��d�9_�~� s�z����v͉�SĈ���V<�sG&�:2��p��{Lf�Ì�0sܟ�������L��cH�K~Q)����㒟gf��@��Y�{f2�.^��ҙ�W�^���._o��g�}{���N_�`�$nF��Ȥ�wEjښrg$��Y�$v]�>Aq�����b�	�px8��0t�LSf��+M��جGeT�@�Q��Ŧ��8����ce��=���5��`�Q���\���X�1���(h� �+0��@u�Zl CT�DA��{������(�s�L���W�J�i�.6h�+�/_n8�A�|�*�=��p��7��`WJ������Y*ow��]�Q�l�O��V� U��e,7tuEa�+�3��ǖ+��{�Uu}+��TKl\y�2�Y����D̻�9	1�rx���Ζ�/� :�h�b`�=gL��<�eFU��P0p9��$nH9^R"��P�K�N$(
t\�g��6(E����K��������I����� ��Ux
{�:.��&���GGK�s�h�,C&@*��T�u�H�m�܌��Ӹ|,r�e��1߰M�s��Y��S�C��\���K( Za������0`�E�!W67Qh4�S����)+Y�����	1%��	��hp�cie["��(D3I��Y���Q�]�`���Q�e��'$XOh�R{H�ى��j;}Ԡ�|{������M2���-V��-��t�
�����$��G��cP>�ח�ߪbV/D9H��/CQ���C�����/�e�����G��E���9��0<y��R�����!��f������J��o	��>�_c�U ���Y�F-A�fĠT�f3���盝T�1ȫ��AU���Y��ߣ����p��W��6�!x����m|%`�Qa�hĢ=_���56�aJ�a��z=@""�Z«�X�bL ��v��u�����p�6nU��:UO\"�����K���|��$\D�?�`�CeWU=�T����M9�J���u-�TI6F�?Z��ѩwZ��Ϲ�N�����t��c����������~��p��Q,N�r��,�Q�N���5�+�����I-7�F�Q���WY1i놕��\��SØ1Ѿ�z�C���K��� ���fW��~�}�H�>��X'{
�����}��w��W���x݅��b��p�ٚz��A�F�s�.F�.��K۠�(`^0�_ݽl�	�����uon� -�w��9ZX��f�V��<3��V[Yt��xn(�)PT�vj�����U�t�{p���`l2� )��7��O�j����O�C}��uwo�M61�WJ���2�b�������]���p`����֞������ۉ̫��z2�h�`�)^@��(����t���g���Nd�C��������:��>^��V2�U������0��I���ǆ�Y]9���u�+mG�N��m�ۏ���e�K?Ȯ�e;�x�:�&pQw/�v�5#@ɶ�wJ�ު�n�Oy�I��U;�s�C�H6^��Tw��S �[w�����e�s����[�C◃{����    ���d:��J��ػm	�s�v�,7�nb��L��=�_��AQ�ֻ�S��x󋅮S�o�L�|���b3��m��sɦB�� W�sa�e��0#g�n�%M'?Z�ev�k7�]��v�/mgr��/�f�,�&�b��Q��v����oW��/в�Z��9��d��3aEo���ؾ�V �Qm��U/R+ٷ�i�+#��e����fV��ǣ�9��o¶�0� 
�`�P��� ��Ӄ��X�l����[�p"䳥T�+���⤎0a[Z��J��晭����n2Z¦�b|�����^����J>o��2�6�7`f�)�ЊH���d�V�ޭ���XHǣ�a�}1n�/t�(mz��]~��d��_�s!e�j�l㸈�8��\`����yk��t�Z�n�U&��¤�Q-B�x�l�*"7�9ߍ�<sd���e��3k������p���}��	� ���n�i��%�h���J���cl�=뱈�.bV�얀�A��W2�UnV�X��q�0=F����s����*K�H�æp�3{�q�d6[�x�Xvќ>
��%��L者�ڢ���ޚ45���T���(S/yX7LV�͸+�=径du��՚���cmR����ܦ9%����{�����2+0�Fɇ�oD����0�q�N�p�%���iO��ǉqa��=��7�n*P����=l���ݯX^�96�.'1r�~~���īoܓwt5�}ns�8���2�%�p�x��4vC*v���W�tp��z�$!�v��+-FuA��e��<5��u~_��4J{7W�a�؋4�r\яOُ󴖿n�2y#�O�M�
ªO% ��!�r�ӝ�u�-��DG�RFQWT��sw%��J�^�u�,��;�4�=�`��ʍ*��ķ�w��?l�jtM�z�[���,i,`ZL��3މn��:��8<��(m��P=����.�1&�� _�p=~d�ʍ�a+W�M��`;��cz���4�3[�^�;�5��֚^�i߹ 4p��+���fEW�kt]F}�����L�rg_�͎��ȽN��t{�5�{a�IV;]�.�)Ƣ��9�Vnb$e~���O�ȔF|/����`��6_��T&(��6�%����F&0܋���{k�~��C&-��zTp��)����.<%�J�x/gy0��Fϲ�[�Z�Nپ~濗Y0U�M ���Cl9h�y����Q��~`;�7�eD5t���6�J�%^�[.�>�0ǉ�E�(���@VdC��yA�h�M�4�����j�FK�uƾ;�j����'����q�
e:�� �O�L�q�|��}G�6�m�g8��������8] �]��;0V����^�:%���׻��N�V��
���y2���d(�z�Y���: >�R�|t8�~�i$g�� �{�ә��Z��0�"˰2a��Wvv�`l2;��F�����P�%e4���5���uc�ON�# ��h)3����[}��OG� 	�����VƝFrF�p����]J�1��gQ @��;tD���=�)��
g�u�x�F�gyw��Ռcٺ���?`���{��َ>7�C�c���yu��`y*N�B8������H!u̲�}0B��P�)l�P��p�W�D��e����~;9eW�20�A��2����~�#�B�,�H�,l�aE�^QT�Ef��@+m-���01�]��32Z8d��,k��*�:8%[􊁤��"�����g�BĈa��rI����mL�d�i4�CP����؄Ҿ��7�&	ﱛyJ)�	��IZÊ}�?: FB�@8�bDɔa����7���8'׮S���ʎA	�n�"���������>��e�0��ab�9���|i[:NJ�=����P�t�2Ӄ��
v%�]�/�<#�`ڀ��U3d~���;�r�u�ա�Sߓ�B%�Qa<�j�ӓ_��Y���txI�*��1���򕴡�{��F�<s�8�9��x������_�BK
��h�S~[q�o/ұ)n��[!-�S�dG��{H�d�0�1Aڶ������7���>[�;��WW��W���|u���W�+t����|u��|u������W��:_���|���|����W�߬���Z���3u��Rt�����|������:��7��|��|����|�����U:��:��D���ߢ��������=:��su>���|��\���O�|��V����:���:��_v+b��t�#�d?��������ȷ=ɮ{����9�GY1g�!�S�y1U�1��t�ն$�{!ɵ |S�3�}m��|�	7���=�w0X����W����*�ku9i�4��p�M,'1���n�o
$�b�@����7���&�l[5��9e����Ո �u,B�Z#u���r}�l��23c��9�M�h�nj���6�[���0�(�;�0B�̀U�!H20�?z�]�"��/G�u�m�
��M�(o��-ؼn8�(���7�o	�Qh���=N������p�i�p(x1�L@4�������<�(r��	O0lz��S�ZF<7�����W�iW�_���o^�Z��I�M�Z|���c�:)[cx6��11�b�Qo���{��e��$���~��s��aA˵Ǳr&��X
F�����q�S10K&v���r�ɣ�m�'m�qr��ꠖ{�q������56��Ƞ;¢����n4&l�Ok8���O)���G�у��~�Fq��GS R)��,�6�X���	�a��4@tt�Jj�i~=�<~4:A��ب����?��i�Ch��r�v�
���;R����C����`d�ǃ��$@�e=����朎�d��񣙴�K�1�7�m��/.%L*t�bU ���^+�_~-<�����5�XGtT�U���s��'x��4���Vju�0��.t^�K`2l����4`��pN������`��L:�^9H�g�O@di<Fx0רx���b���G����̃����L������SLyݖ�"(� ���I�e�O��{k)6 '�U�^68�
���Rx(}�6���"���:m����o���tg�?E������mt�U��?���]A�kόj�\���G��v�ƝM���p�}���gfy�==���.$����H����9����v�?��[�	�h��%�'��w	���|���f�a�ٰ0�:9��1�������<�}~�������'e>���ɟ�i���
ݻ��s���c'���_ƚNv��J�aM����C�]<���>_U�fU��5�a�����[�S�d��#'Gzf�y��:}&o�D>��u^��o����!����:�?�a�0�����s����>���őџ?�[�����(*���ҟ ���?h�����;a��d����=�m�o�=/�*�o��\7p�7N!�%�=�[bH`m ������)ʇ�O���`K�M*/�ذ7f? �D/��� ����6��'���Wq�H��+��	��R?�;�(�z���IѨ9��[�:22��Zз��A���]U#׷Ͳ󖾭�緞W�"�[{G�RE-
�1ʇ�dm�:�O���L�Q&'�k�ֆ-}\�qW�)5n8�z0�ބ����MԱY�.�}+|# �w�i���t�ћZgz'֤G0�����d8� 荡&+�b
R]=ʩf��Ț����o�&��;T  �#F�����'��;.U<��nj���,@d�9X��x_M����	�0Ms���dUeߺ~������?`��p�\��)) �c���,Ǐ%]����;VU�8=�e׌�-��f��`�Hn��Ie��Tc�V����r��п#�y8  �h��%0����-3����8XD�E���]��,l2�0��,��5�-7X4;{�883 ��Y-H] ���]�*���a���t����q���p���8�x��5�Mcls��Z~�f�LV���<�%-��4�Ҷ��[��pM�    ��*�x&�H	���m*Ĩ�)F��v�����:w�m_�<hC���)���֔�jN`e?<�b�0��%������ki߆M����j,�  ��0�
�5� f��:~3q�:w�fG��5s<�c�ǐN~�ccxb:�Q�X��N�� �7�ء�~���z��#�Պ�80�?�����۸(��lq+mMݢG(�a��p��"	ӛ@�P4`� 
�(����0
vX��v�m'��l��E�u v��=1l�L�<,��z�`�5��4�&�"�dpTP��1�ߥ���4\��C?�����k^h�<o�;�sՔ��m)��� -�t���$Y.��.��_R��bz�ӽ=IM ��V,"`�Y��]%m�m�c�ɝ4C��]��Ԓ����l�*�	2�Q�ڊ�#c%S�vaC��-�7z�k��u%m�dwO�a�'�*pڤ�w�K[I��tWB:3�wFk�i�I잍�o�h�Up1_&a[�����N���@~|s���@> ���lB����a��X�8�
�hv*�YF
��@G+K�J��+6Ζ'���M�M F�����|���/�V��lY�4��=�¬CLiݔ���I;���'�T)O�A� ��ږ$�������o�F�;�7�r	{]	x�E�8�K���52�����<�=��ܵ$������n~�	�5н��fy��xv9A��2C�m]e!�ٮ�ڞ���Ұ6Y�ɤ}g��U��(e����F���� jv�4�MLXe%��K޷K�ܼFi�(���P��N(�j�jٿ�c2���N�L��$Vk��#5�ѥ+�i#��Rb-��s_����mi+x��)�ɵS�x5J����r���f}T�i͕�͊�h��(+�D���Q�����	�����
���r�Q��]+����w����sY�N��ie����V�JK{��W��젖EJge�é���e,�dUnuG��S4�:����ũ����Vm'q� �QCa1�w	�i%/� ��RS#�xQ�m��B�x���m��g���N/�m'fg��9��b�˪#��@h��%E�s��jlрh �}�&N��WF�µa�j�ZP5W�['�����{X:�ݘ���S�0-�����-ͨ�H��Ff|�p'�\��}�-H��4+I .�--.�e���pI�-S��K �a�3[���-���ʂK��_�/�g4��ϷG��1/x��P�Յ�碁P�)�^�Rc��9��9w�o��_<w�������W���'1AT��=T
m�r��L��M Sm�~�c�TY30oY���& TI(��ݜ2���0���"^vQ��.�(5u4�f%�\�Wy��rBA�j6 h+��`���z�Z*���&�|�(D�P,���������潃�'���VV���h3ӻ�J�dg�0o	�U�G�X$�����@��"|0�0�l�cL�4>$�+�ȓ����ٺ��}=_�o��'3O�LN���|j��� �@�:#A[�RE	`�a�{�{������YXx�`���M���H��	%�)�
��9w��鳶\:wI�ku*�dJH�J�H��bB����Z��L�Z&�eW��������(7��4��H�|�j�5e�h�����n1�խ	4�W��#Ь^�V�V�Y��j6|,���4S��î����EA���xK�G�B��?N��6Ǽ�b6�^wqV��s��cT0)S$��I��x)P�I��3nk��v�t���Sr-o��WL��n(\���T|�j�ZeXQC{��7���h�t���W��s��(��B��O��0
�ʾ�����@)���u��R��S�n���o}�������S��V���N�g7N�����oEL������b������_�5���7��G٣�bUg�B+�b�o�\q.-������
 U
*{T��@�U�3��k�T�r�(5�>?G3K��3ؕM�FҟRm��S�Z$5v3�%6�H�-���aH�оVMqNitM�wM�rˣ�4��ʝ%ϩNI��& �X����pn }A6�쥧m�m8Z�s���L� �"^	/#���bS���y��߲�� 3;�%#ͬ�����m�e諥t>���B;�N�S�Zǋ�A\O����`��)CR,O�I���	�V[�LL�;����U`�Sy��U����b��A��T�t^�����ou�s�G�hIry0�MX(��lP%5T&�&��s�����*d�Ե�Y��D^�y]WYH^{t`-Jl�Ug��	�PY@N��u	p*F���a�f+z63���p�2-��6F��_"��L�F���åX@l*�8�x�Ė�۫=㠑�y'�5EtG����	;������M&@��[LZ�JmuV���� Vwf�)�L������ܼٶ�K��}s�exD q��w�V-����q��_A
^��H���&P]��k�x~�(QVܹQ��J�5y�Z U�NԱmڲ!�I�^�'^b�Ҽ��L�dD��?�[Z7�]� Oy��1܅��hx�d
:!M`�"at�Mme�ۊ��J��#a�[R�g�J-�l�0�������Mm��oD�@�� ��.聐u��gC����h�[�-�Vք*H��F@���0�U��� Z�-�b�"Ʒz��c?+wr�n_��@�0�ˑ�M�CA���~^��A�k8�w]u�]CS�u��	��h$�J������8L�ł��� �DX�A<#�o����_9�Un�t��&o�&@dnITUЬ_(~%�3��ڍ��ݟ5���m�L4q�?4n�%�ڝҜ���|�S��5�]��;�]�k^+�9T�g��p:�y0�[�,�腞^=xg��p
@e�CWW���H@���A}������E�1$�f�2&�ևy<���SL>9H̗g�a�����[a6�����Ȭ|(�t��?z^~�ֶ��3����8c�~z��2����*O�Ix�Y:��C���Ǚ���û���.�~�{�R0�����TK��9b�\49�I�aQ���n|�q;Mx�Ꚃ����ųC<G���(
Z��Hc�{b�<�J>nc���V�{+�2��.<�0�r���!g����i�D>��奿��0�1�n��n���_K��X}ŹQ��An�^Mg��0��V���?1bBz��� чa7�Je��a��z�~e���,Z[�`��q����\�]����qw9��(��k��G����"jӰH���ܳN����_U�I1Q��b�g����CWeR��,w�^u����xyn���:ad<����I���s�c�ǃtx�|����#��r�Dd�?��幧���'�@��{¨�3"����%K�&��w�,���Č��0��{J�п����Q���N͏�:�Q���}�ܖ7�q �k���|�)+fL�/�̇�WV�s��,��
��_���'>������ �!ߋ�7QnE�����(+�����R�YYʝR������0���``i�%�3�O����l˜��Y1�2��۳�+8t��A�𒫎C�y{���h ���h	�G�������k��V�����k�s��.���:�0�N�'�Y>I̙f�B�ӌ��.kO�E��2NY��e�rx���f�@8�SyO�A�.�������@n@u�}�?ဤg"ۆ�Ї?��[@�0|��\����r;�g���.�"g#���0D�d��]������z�p��ZD��Vj�~�"�/�tdڧ����c�*�p�J<���T��b(\��/���U��Y��Ⱥ��#���-�[ju>zD `�g��̲+F,��������=o����P������DUdB�^��wFc4p���`���ł���`}�3tr>��a����О{�&E� �F��V�A�x��
Pnu�?�_����5e���#,�$EQ���1�T���X��G�+�<�錈��K�B~ИMО���\ٚ~3v�\�;�����S��\��E�D�0�ֶk2���r*>���1W�m4N��P�nrtx`���w~�X���    7���4�|;�J �c���9K��.��#.~��j�[#\�]�ߖS��=��ƒSdb�		�;+~��S=u��˙��\��J�ﵴ���������r;��^������U�SO�[1R��XJ80�@Xh�k��I�3�}݉D���0B�������I#��5z�r�`�l֌;���SN��'��z,��8�����(o����ez��P2�d����@%�q��Z� V~�Z�����*;-��������V�����v�G�����8f{9��꬘�f�+�\g��Ne�i�es��7�������O�����-�ǧ��?|�q0�/�)aGfb�p��y&d^%�φ��	0^wc�ζ�����4):��;%��ϔ{�%H�wPʀ5t�\��_������Z�:�g�T�K6�d7�%)�(Oe�z<��^1L#r�n�c!�U�G��ֿҮP���S�?7��E΢}i����~e��cT��Q݄ V��-Z8rKQP(u�Ni������T�5P�_��_~��\Q�1:mVأ��8L�̰�8�[�W�8#���$��=�}���7H�3�4	�!*��o�z����������eʾ�BK�]e�
`aE2X
y`%6VX@c��P��� �1��^c7�ΐK5��鯴s75T��ݕ֣́���)}��I�kmYأ!�d4Uz"�j�n9�Q�5�\Lh4�*��"�:*�8��y���w��j�k�gok������vU��W`W@VU� m�]a�ϬLz߇c�&�j���������cE��͂���O���f7۩Ȏ�;sw{?��4hҞ��{Ltv�����x�T���ۃ�Q��ux�7ӗ8x��k�'o�� �3���g^Qr�Q|>�<;L�}U���oЙ���n%����n����	h���F'&��&q�u�W���e�y�Q��n����`��D�֬����OIP� I��;����Q���E|C�4�H �|�m�qh�c-�~	�&��o�$���i z��r��Q�B��#�y�ˢ�'�㤭n�Z�M%
'�S�Ը@�N[�w�q��a>*\ã�-�YU8���oU�[���G�>�8�{7(�و��?����U�$x�zW2������qJ\�x��u��R�x!dɋ�F%I/l�.���V"F������%�q�T�Rs�z�E;����PJ�+ A=� �O�3���%����g�9��h���Z�e�5��bbC��]X��
���/��+����d�.�$w$+d�e��3�C�:�-/�*�z:-_��T-Yo�~v�M׸F���\��V��|9w/\]��vrfҽ�����d�R����΋���:�����:�x��p#��'__����/,1�Ȯ?���d�%�>~HY�ް��x��n�l����S<��KM���3��� *%����:���U�է欲��y�r�%E���5�JA��w�����ğQ������5�����S����K���d tw'0IM��I�������픸��!-_�m�[c�L��"���J�߰�O�K�e�����/ӥM�.][!ץM[�;��T+�fم�M5�ڪB�4�ջ�)ɨ �N���1�جcZb-��+�MP[]���u�oE���F�4<a�kk�}���B<?��wVg��nZ���V,�m��8�R&h��d��4�j�G*�Ds����NTaՏ�6����Uz��JR,�ZW�De�O�-F�tc�)!}k)��a�k���(���H��'U�=��ʟ�c��^���є�ȕ�%o��[Z���V���ۑ�۽R[�Qh��^2呁��D4�c:�彰r]ҁ.ҳZ���Ů�ű�7���J�Y�d4���˙��U�&Ot�+�ꨶz�qy/>�9�1~{2��\��jy#�H�m�[x������ɳ�)k�N$v5�.,����D�2@��5�}��/��I��z�eZ��W���ub~T�G�n\�ԫI!E��J��+�3�r��tZ���E�/˩����qa}Q��䭲h��`e��]X5r����:�ם�"*՟kt�)5g���l�>��L�{��䓫�X�@�]�@�8�
�ϟeq�U���;�F)f�B5��E|�bL���\bF+j陕�F|J�q�-#>�R��%��\%&+��ٯֆ�E����϶���j�E�"=�>8.,�_�+L#~Q/V�FȐ�1�{�I�p�W*�tl�G�2���t�pm�
0W�Y��2��*
i�y��FW�}M#�3�L#���J/3�`���v_�B�U�E|��k�o�L%�����=O������W��_����)�W��뫐맴��j}Ե��B�'[_ 
[߃�:�ߪ1A�q}�����]K;�˰	�[�� ��[)��^�l[�S&�g�M�Wv�·	���W)S�� #Z�|�r�[�+_�Z�+b��UR�J4v�;�����1u�:(ռ�T�kr�R���Z�J����FaB�UI�6�im|[��f�)L[��Z[AӖ����VĴ婜��CUq��,k0#�:�Jn��U�T8���W%�q�_z�{��J�^ؚ��[MH����H�e����y���Q�j�WĔ�.����k�Z�6-nݫ�*r4��	4,Ѫ�V(p
���Z��J1s�e��V-_�R��ŌA�j�H����jyhr@rm�N_\�G�rxrc����������xҜK�Z���z���%X�Nl�zng��.h���(��Bf-_���*�Z��*���F��Z�
��|52�ֆ+d���ȕ]�h��?��[�M�WSHv2m[y��8��ϰj�j�*ǿ֪�Uh�j����q㼬���(��߼V��� ��Ǖ�v�C��ʍ�\�5u2�1g��-�D��\�<ڙX$��U�����h, ,��h�(j�(�~�_=���G�R�~U;�Z+m�~�fr�
�6�@���dP��7��? ��U����0W��^}�ϗ)�Ɵ/���@0����S��'Cp�"u ��� �=���e��.Ҕ�@�5@��k5xZ�UȠ�\��J�^����L���
��2����W�? ���������~s���? �>j�?z�������U�:�諭�܌$7�:�e2$�`(�*�Hx��B �[[#aJt�iZ�K�E�A~�yxMb���Kw��{��{|�mC'�}�%�ͷ;�)�>��]���r����K�OQ�@��q����ģ�8�*��S��j�4?�ᩗ�(�@��������Y��g���.�Q�	 �dBnx�hl����'J�cR!7�v��!����܉2`�L8Nv��9N�i�?�����B�``B!7�3N:7ܑKv��RA�R��Tȍ���:����Ǐ�xp�DD� �L, �ц�$Gi�R���00�p���?��a�%�2�p�����Ϲ���'�T(�t�5'� �H��4ѿ#}���!�U���,AD�%�����\�y�7P-�>��^�L���{�X8M��۽�����,e�+f�FY��n-3������Hf��a[w�g�`�u&����N�`6:X�|��������2��<���p���ٙ�8)��F8�ѳ8)��&8����3=�����G��/8~�`�=��[Yɦ~	�
5�� ��w�A
��^@�<�T���h���6;������L���_*�pw���O�$�K��l�c;;���<]������U"8����}���O`ҙ�g�1a�u75 ��K��h%����)6��$������P��h;�?(���N�n��O'��
�NGk4l�co[��m�`~������D0�AeA	@����M+>��1�]�1J�� ��»r�|ÃʕE� �$�n�+�,*�X ����L��]Tʮ( ��ۋtz���?�M��h�����H	~��+���2)a�c"�� �K�#�
��dPS6�b�!">�,�TX�� 4��x;�RZM��8�Ra��0с�l���c۟y4rm�*-
�!=dfsU%6y4U����K#t�r�.L=£�Q���
P+�$��Øj��"�b�Yоn��~�c�S    ���U�\,-aD}G3�T��OT��M:�������+�ʊO���<6)�����d�٭� ֈ6��Vj6B������hF0�f��CɌ`Z��oFH�No���LZʘdF0m3�a���hJ��Υґ��%%�x�56K`��L�%&��Z�@C,�dA0`X��xˇ�J*!�|`ZB���m$+� /�dB0�j��	��*�U":��z �Ҫo����

@��K�BG�-3B�[癴�B!<wl��x�J��ΐ}gk���e7Hb(8�]eF�{F��:,�lD5@��D�?�#��&�v@؍ՅM���r$���������3�Ki[4�� â��lME�z ģP�q�*�P��1'� ϧ�J#�>/ZmC#�41��s�A�]ibhK>�A@$ XLA��ʈys���y����5J##@��Dӗ &��x��Fii.1ARb�H������Ba�P�)ln4<@)�ƛ��������U���躊� ��F��զ�� Ԋu����,]8	���ѩ,�4>���=K��pY�禱k%��x���C����Ha�&'O�<��i������9�Jk' f���H�כ�s��D7�;��T�@'YT�7�����JC(@3�e��v�R3�0�I��4
ؘ(�8��.�F8��pȝ��Pi,�L�Q��6���,�Ji8TL����v�.��"�ӌuy�Jk*�d⏕$�ɵ9_f�<*�YP1YȊ8�o�?�w����|��V@�d#.��Q��>M���j�F�X[�ï��"�]e�mW'~ai�\ˍߟ�T�+l��<@)�Yڽ�$�`�x*#-����M��R�vR�V@՟),�C�����1�k��g�ʲ+���i�^�zT��#�3KP���擄��zeW˕Obk.�S��Ni�L:n�SQ�6ʉ��d�uɣ ��ƣU��-��I E۶��J�1@2���2���P6�4��JiOTL2n�3� ��T-�m��΢��R~u��P2��=��	o/;�������#Sڜ�ۃ0�ED�L�R�nR:^���T��D�q!���-�#T�!��0�JX��k��!�C�Ș\�'ߒ�����7?��x{�G�4_#��(��"�)7�lڕ��1�eV�[�]�=�Dv�M;��y�*�ׅ���d;5ZLeV:*�7s��<�֎����=��=_F�2���U��nD�p���=���(��BW
�fT���v�s���BW	�߄�M_@sx�2����zF(�9|<z�+ET- ���C�-�qo�8���F <nԃ���c��#4L���K��$�R+��[N���v `s��G?>�{"ET'�}��p�v�9��#u�ً�ӓk���RL���рs{���p�)׍��'@�m�����]��u+e,d7���7���{+Oǖ���q)
m��b<JY��2s�R�b<�7�s���R�b<��(���sR����.��wOI�2&ާ�?���V�1�B���t.�������R<���)X#�.Ɗ��~o��� +��=�*n,|Ul�w����D��h'p�� ��]MEE1F�ȝ����})t1F�K�����R����wkn��������_�&U[����E��\؁�O�N	{Jdɭ%��O�l��L�؀�\�0���U�?`�Aj���_8s�9�Z�dﯾs�NW�HKs�ys�1ǵ�����ܻ摇*�+7�ǌp��IM�%��^Y!Z������ �^MO-����~Qyh8��Ѣ
��� �[�%�ڈ6�q���bY �'�$R��\��[ ��!'���H-�%]L���w��<mDQ�j10���4��l4��DW�9�pO��O!S=dM�%���IFD�P0,,~�C�u�,c�Ḛ�`>Ⱥ��E�E�^�M�i�PB	�dX��m�͊x��Lrs��9^:����
�R#����I#yGk�7��o�3'��)�;܄�}c����c�Eޠ��k.CGf�Bڠ��M�5i���;iG�!mȔL�m�x�.�)Z��!�S�,S6t}kQ6�bC(M�� 	�FтM`��@ʠ<������'�W#R��įS�~�E�T�b�a��Z���e�7�u�YDC�&��ۈ���@�7xv���HA��/�HCN�W��s��BOͣ#x�+����	�1/�L���9Sl]y=��i��E^����
��j�6�h�@�$9��k:VqB�M���T	!pFh��J�A��7�PͲ��SP!C�%P�҈*x���uM��os�ㄅ�0_�"�_�ˈ�ֱ\ޜG��"Fm�q�:L�k���z頾"�d�r�X-.((F���<@������{��oԑo
F���@�����0=�:U�a�5A+uV��@G�Xr��Q��b�utlP�μӡ�ƨ\����^Ka�'����.�F�1t@OGK͋E�A~`BR�j�j���ԼX�����:�3���E*T�j�}�H5�'xd�S�ł�����Ԅ�杂E6�LHj�(R���+��%Rf�&z�����у�����;ǿ��돴�O��Mu9�N��9"%g����l�j?����eNu�oh�#�)�[�߻?�#� �Ҫ`&t1v���� �	՗���#Z�jOvJw/��cU�������Q#�������ǘ���v��#����
>��	�k~�B�1�x�)�dc������؂�-:ٺ�~��B5Q}�уǜO;�~�����H���ڜ��W�_R��y��S��'"����Q'�_�#�H�������.��2��#l5����}[w�F�b!����/��ӭ���`k�#�9^����������Q����a��v*?̒�X�1�FX��JS���khXښ,X���GJ���.b[� /��/�U���Q�?�K*��Y���8��b9/�1��fK��y���������(��bخ�G?=�@|@�"�P��	����l��)����.����
��q�ᚣ����3TG~���-����M��\��:&��Y'[;�D@�nCS��\@�aC�{C�M6��;���k�!���IĄĜtC��ڠLa����lQ����Bb P#ٙÁ(#љ�(#����
�F2���	�F�
ρ�CG��t�+A�5��-�Z�3PHd� j���H-�HI����~�7���Hd���P@e���ylF⫝�B�`$�������C���F� n$�Z�:��2-���y�Ӓ������H���T@i���E��nk�7����9A 5RiH8� j$ϰ� 6j���,�H��#�A@e����, 3�kx�)�H�5���F
ρ!@)���x��Cg`#!֌��񏄪8cF2��>�:#��H/&�i�v"��@kf:i���#��EI�FJ����4�;��TF����B#���`���*%�♥ #=���pFB���B@`�C-�]s��4��������~wĘ��H��+�B@f���$��� k'
0)0<!Q �b����$+rZ��0kf2)�f����H���@@����5[�~�[��4��k���7�z��	H��:�R	8��v{R�9/���HϵZZ�4];�]�`�����u!�S�l���*�L�,��t���Pr�?�%�O'V�B��B��|�
�>Kk�E{(
C"�#V��e�~
�^e
uc1k��eM���*�^h�4����@��`�-0�� �b���,��Z`�O��a
r��-`��� $������~�z^�z�|�I�]
�lv��X鯡Id�oo���TD+"����3f��Q+ 읖�O��g�5|�e�.H̵�J	��D�#��-��8�����Qa[��z����*�V+b�l#�Umz��J�����k�d��b�e���:9j�!̹C'L�ȡ;tB���5�#�:5Yu�N�.B-���\±���H5<H9T�X��w�ī�#��<�����$�f:��)���x��<�e}�#'��3��S�ɸ��d    �q�wf���Mf\o?��m����ɞv� ��RL��Ɓ�n�_��}�`Z��Ig�� ����#Gxf��f�gzg����5��p'�鮃)��w��:����]ͭ#��^�f�hCVu<��f�|���`����5���p4�57t��	4W@ʰ�G3铉���)ܮx2�={*�������M!'"�'G?��0:�TǫK��o,|��gNu�yC����w��~���4'�1��u���+�ϴ,O]G�7�ud�T�P���z,��3�~�1�F�p�0}s[�4 �����s?2�~԰�ƽ'h�2#S��% ���!�B���}T�ܝ��wg�P��4Px��v�2Z,?�mu~�[�Y-�����1����{g}�<2����~�H�N�]��l�j�,��q�4)��t�b� Q���|s[�a!&�	A�f�p:T��+7_�-,�p�d(��T�b�� !����oY��?���]���{�H����XV|�˓��A��͗G�y�l��<' ��˳�Й�^��z��J��ܝ���p�"L�ziF�R��oЩR�7��������4
����p����7�G.U.�XWL�P��4�{-@縢�>���TL�\9��&���I���������t�3Ng�d&�Q	8Nd�m�T�̀k.YJ����;��÷��c���D
pg�W��b���0��d_%��e�|��|l�(�
1��ƺ�k
�7�֐{�1��qh����qiү!���ɿR��*��A/�p0�!���tBņ���:O'N���H҄�{��@�v!
�!����4x�Q������"mp�:���Z�-j��T�����`:iӪ��L�Ј��'�	�K�l��"P8����g�m57�ޛA���xO蛷�K�oCܽP%o!��Bټf�#`�ʗ�Я��שQ������4����GR �H�У��q~���9��%+tɺ���`ia]�Gk�l��W	r_��D���ܰ�,k� j�f봯Z��(񛗯���9�ΙGkC_�j*n3�,j��`�Y��i �C��Y�p*�!�fP���(3����GB�qIG9��_��:W��=����rSl�2�c,:�e1<v�A�4��"yh�y��P���o�c�����y������~0@�N-��7e�0���e��>@F�E�
�V�[E۩l��Tb׭�o.�\��@l�k�G�vdF��Fkr3�~*C���	�ѐ8����r�������d�\�5��"��J�㺠�?�&?(mj�z*C������X�mh[Ky�Gj�8O����m��n�oz��e�Xik�ܟ����c�OJ���N���c�x6��M�8��C�+0���\v냸����2@{SC"E�=���Mi����T*O:�2i�shۿ8
�HC'���pw
�e���[i���������;���)�-�Bʝ����;Ћ�[a���S+�+��{����ORi���H��OR���q"�]�_��xxJ��<���;p�L�-����r�H@�?��!P�μ�PQ�"IkB���W'�J�X@��!�j�˽W�J�f�IkB����W�j_�C߄Ԣ$�!Y}���(�[%b$	1VǊ��h���pw m�) H׫�iS��L1Zi�n�Fh~s�Z(B�`ک�;:D��`0�Ě��fh���d
r����aD<�D��Th�d��1��Q�Lk�l�s�ve�:4)7m1�9��
���|��(��*$��;��d%X`�- ��"//Ϳ[�	2�Ԯ9iM��|{���KJ뎀�I+B������r�H�N�5!��̭�㕷����F����n~x�tKi�h�4$4β�.�W�/�V�_�<Q`c
]���v�f���k�*�~)�\�vf��X�E�l�� 6k57iq���v����mF�a�8,��'n@{���k�@٠��J�=�d khwitw���4b"kh�z�l}cyd��R��hT!k4LLVF��ʍcI�$������f��IkIG[�&�8I?TZ��$MZ�$]y�PP�M#i�$����Ҹ]"iҐ��v����{`� 3�q���+�+�ɺ(	�"�v(D�L!��5���S*WnC!��0��D籈H�!Cl59*�A�����S�nc1#�c��H���<�"��&[*7hh&��֤�@��m�J��6�Cۅ����������Ȇӵ��w���+�%oDs�A����I�0A����V�D2�����U���2�Geh�3��*� 4�2��O��$T�A�����\6MDj"Q+d�ܢ��^���Di�j��yj2'�{�L�@��m���d����Eh�b13��a��=�|U0���l�^g.����B�B���EMb:�Z:In�JۘQN��=2�F���ߵiiV��`��d�ɂ����d��\c-��#i+]7g���wH�*^�呴%�	x�&�o����}��6��w�X�|w$�	�Cfbt�	�3�7�C�Ǜ���}�zw�8��Q�Yn����do"�V�?J�����.R`*�h� ��(r��l�}ps��$�*^H!���Z���9�L��g㉌`���1�9��M��!�
\�z+֙=W����	��_�.`�Х˛�f���D����!@����a�po%:8<����Ԙ��p{%0]hd� ׶S�Ĩ#(�iʱ�~�%����}Q�|�%�Op���h�X��v��������/T�A�Sզހ�
[N1��XnÁ��)��訢}���p�ڤ��fZ��o�D�A#Úo�k(���D����2�yP�|�h���$�ē'(2ݧ�t|K�OnS2��-�F�4�M-�8���4U����`�e��`$B
�L����[�[�1^�MA&�v��@���u��?�U�Q����Ͱ�C��Xr�Q�"��0\�Ikr���3����	��V��j�T�m�`r�_���F=�fP�� r�YZ�u0aЌɘ�x&[�L-O3��s�+���w�Tw����eo�R�l�E@�=��ρ;<����A-k�L�CR(F��Y?  JU=���jV ��YDThyӷ���<6��R�� ��@���is�I�  )1�� Fu��	�=���5hRa���xYƧ� ��j��4(�&��z2��u�`6+f~=H4Z8��I"y���������H@�� �f�w��UG���cJ�����_)[McEG�y��on����<�L�V!u�^qf�Y���xu`��+!n30�*M�M�����v��V�w��L�x�Vv�+�/vJ�;��v7nH~��;A�ǜ�E��~�0d@�BRӈiȠ�y�������׶��ix��6��c"�/�K����dR�����OP��.'��:�g��A�\�u�iظ�S�)�b�k��sJ�8��6�a�:=�$�79=�C�\ �4�g#�z�d"�f�&���KJ�6#}{}G�Mc��(��G=���+���L�<��n�ٜ9�9�����5]�n:�C'�|���i��4t����K�e�4v�=��Qi�/L�D �G	�w 6ۗS|W�Q.��<6�����֩S�$�<j\�� !�L����)�ٴ:B��<
�X<��0PA��*p��|s	�X�֘m�^̊�P�t[�ӥ/��m�i���2���Ҙ�y}�D?Mg����I7�,	��!���E���P�����}H�f�ĳ��8��������|����G2�� �'.9��yhD��jG)��Q��Gd�w�t|�!�">9�.%�daӨi5�=s�ju��HݽZ�	���琘h|J�YR4��W�3�;�!�m]L���^q"IK�E<7����i5.�nZ��Fbcҋ���O��n�ޟƜ�"P��r������3��R�h���[OsM�!�WGj�2ӝ�v�����3w0�o�q4�@�nHi���
��Edat6����;�!��C@r~����p$5�cO��$��L���    ��"*8'�g�_	�~v��sI"i�e,���ޝ�!��L�� ��>��Q��]Ŏ��6s��L�m��D���!�O�D`{#�B�7G�7�?��C}���q�(h���w�	�iD�
y]�������"
��T5��c��_��e�X��S4���H�\������<L�6K3 yBzc�u�Ћ6H0Nu��b�Y89�U�$��:;h�I伏�����2�^�uO��L�6�(�ɟ{�.���R��h?O�Z�5����Bzqؙ`J�ɓ'�|3D�А酟	)TѸ����q1e�S"a�=s�m>4�p^Sh!@[C��xªp��~H�!%NpIk��f��@ڮ =�v��Yt4�u��B*	9r1m��UnkR��HG��F�e�x���&����17s*A�(��ß��
�o�ɜK�l߸� uR��HGSP(�-����f�N2Es�>�m�p�B��M�\x_��0:_}�Z�/�H��b�Ja_�C�a�5d#a@s���p*1
{��� ���y������W��w�j�$S�8e��R����y8� g�j{T��u<�*A�L%@�����<�b��nkd��uT*%�{�2���	H�=q�@QW����ˏ�**��q��	8�h�T,�0�^%7yqܿT_W&.�/�7���'of-xK��@��*��n:�Jw��u�4t�<Ql��ۅ�wgFw���"z*Y��� �Lp���:T2����k�I�P���K-��X��}�؇�le���~��t��(�-8��L�w���w�kۅ%�>��q�\��X�ƿ�ݥ9FU�5ޏt0�TM�$r{8��Y��q'��
���%�6t��r���[����2��d,�F����=	��q�J�r�r�M��(�R�or�-�5�&X�x��L�;����I%^�]J�v��v�I=�>���D\*5+��G>����/�6@�����6g���P������(������o78�l�����J��~c��4Y3�J�r!�*5���[l@������ӏl�T��7\u�=!��u #���ɀH%a%���#��R��Z�T��@2-���B�%�~c�-�e�v���TEMaD=>}��T��`=��K��C�nRah���[��s P[�U�bYn�p�T_$Cw�$"R�1ȷ��;9��%��Q�Ɍߊ���Y�)��M4�U�Q�EXVO��ϊ���/J�/�����)�n4�hȅQ�z\}Z�a_�;�:d�F!�݀F�rL�ل�15��Z� ����%t�0W{��偖�.1�tǣx�-R -����A��s��	�)��'�0aX�A���@�!������Y�ie��Q�B�G�no�n�R_K4֐�:��]|�	�>�=$�O#м�!�Ί��L�.�����!O$�
xKC"u���P;['�Ԫ�!�����+�����d)ze?�?ˍ��4{��^�q#��@;����3n�T�T4͜����I�����"'�փ}���`�N/�e� ���;kWv6�W�/�V1���~X�2��~��^!��G����ނ�̗�OL��].�
�sJ�iݥ�S7�������h"����4i�WP�
���e�I��ΘN�F�����_^6�W�nyYnA����Mj���VnQ�bd�ʓ/�V�Mt��Fp��y�v��T��pڢ�F���r�F��f�ԅ-'_h�4����_+/O��V6��MQ5���,wk���l�/78z��;��yL�vs�0������I���-7�Q^�V����ޫy�Y]o��Ga`Qk��t�>�UTW��C�^A�-"-uвzS2d:��M�5�&m��J˘�ޠ��h|�PT�4��fd��U����> �>���/�[�z%��6��P2)`��A�>m�����8'	?O%h�����pda>&u;:�v`eb�`���7I�A�u���쀌�	���r<��ٖ�T F��RjØ�1�3~�#W;�rL��"�@��A�ԙ�FԭT�yȿ����~8�+t)��'�sp��U����2^VĴ�z�E����C�o|z$f7g7�_N)ݷ��,�$^����o�W��:�]7?㢽�����3ZyEcGħ��F\�1{T��W��P b>9{I�}��3� �oy2�fJ-�An��Hĸq"2S�>�j��*O��,�{���(#l��c�p��4++�=�{U/`g�.��UCG�t)s�I��yr�[�K��Ǹ��/@�|�yIġN�# &�c�}z5���k4%hy��lD�k�x�Cgmz�(@�!AD%�Y�*D��0��W��F���-պ�/� z�S єFJ[�H�r��ˌ��ԩ 1<��L�v���~�D�+yM��/
�ZL�ȯ�ҙ�h�T3���p��5�Is�8�/|s-Ϻ'ckӱ3�[���u�ϥ�C�4����t踎�������+��|�*s�T�*�����%�H ~0�$7>��!���]�c�^x��t���%j���"V-�ߛ����T�'��j2�Db5�'�?.�5��B��P�����ݫdi���:	��K �5Q���\Bb�W�\��d:4P "��f���p9�%�����޵I���?�zBWǂb22�D�,��n����.wc�ݝ_~[�����9�f��4�����4C3��/��}��^�Z���𻇳�7e4�=���@�j�5����@�:�(9��T�yxw~���i���[R�Kpm�C��[��@�򌠧�o�yO����x���W��O����ݩ{�63�B,G��[���@�@��[�4�O%���w�T*�h�Xx*o	�@�&��q=�f��v�S���Ӎ���h�%se�kL�MwG��@�����SK�Z�)-�7��KH��.��,�Qi.�jz ��ә#{�v�N2�*`BĬɚ%W&�������^[~���Z�<A r�F�������d�?fȻ-�4(�(�rpKxo}�	��܎�3������qK���ZI�%�r�������yN���nyg���Eq��bk���T�ⴋ��	BX����v,SVs-�ZMo-��֘�@�&��B���|��0&��Nې[BS�lmπ�	�&G���[j��zVl	����$�X2P��m��4���Djs�U��&y��mґ5�yqs!̬���G��s�g#(�wt���6-jK-1^��,��Zd5OY���![���!��X�
-u&�[�CK��O�h	]ׁ?�%�u�HӃ�#���R�aM-��q�������4�:KvB��;��:| ��V۝��i��e�BAK�&�hH�O�&԰�˔�Z���U���_E2�x�Y�QQD6КlY�v;��h��T �d�:�(�z�/K�뺸d�S/�FaM�z�E����A]��w��5+�����(�a�yԙ2[������b��
�bT���n��3R4�S��	~�'%�o��$x�Z0D$g�$l�W=n&�Mg<��<F%��?J��"��\�+Ќ9��y�Kx�Y�y��4y���J8��6=G?M�����$T��<N���lPQ3�	�o@@gQ��T(�s7��2�D�r��9_R#�6���G��x_ēI��[A�D�v���S�����gG9������gG���$�us��(5���D�=�8E������9�!����$=���-X$_����9��p8<$'��N�s��.�S����˳4�I��4_/I��t�Ǖ��-��UƢ��q�z[V���r�b����Whz�7.�����y�zk�:���UPu9��P0�ո3�wmB�h
g/�����4��H8k��E���Ѻx
V��N,�+Fl1#;����)�q���(t��nf��L��
~|j�ΚcC��������� F��YM��V����wg������x�j���s[��>0C�����!܃�Ƌ�!'@uh��x�2�O%���T�_�FM+���:uթ�Uo    �`�ZN՛�l�!��#�&�B��¿�)Z����������q�9�� (j<M�-��ה�f*�k�v�&L�Z���/V	�ܸ-��@���7u��C ��Fy�8Ȏ�XX9�_ݽ{�O	vF�{�ecv�rcMn1rߖ"7���7`gW���#'�� L�ǌl�e�\yy`ɇ�e��>�s(<*_|U�����@ebY�Ԣ��{Q��@n��/�`2D��l�/_y6��ɷ�o׮�]�����2�@��tyb�Me���ޱ��7+�ލ��m��n���I0�r{8c����&X-���̐!�N?k�
���$�D[4�����,Pc�����V���1_���P���n�Lӂ5P�h�a�ۅgh� 6���j��h	�0�����k�e�ֺx��"����j3����L���F����d���	�T��{@�NW��0@�.(�ق�f��������0�RC &�{\����3˄��(�:��N�Y,��`wd�#8��>�х�Xs}�0�W�Xa��r�0����������8,��HM�iN��pXi\-�\����Mقe-=��v��X9WB�ʦ,�mMF�Ϊ�ҕ�P�ҷ�����YT�Hw��&#�"�}��|�����V #�J]���M�ݙ�/��r'���E*)c��Ŵ�1����07�N��ȷ0>aLɸiF-F�%me�ֺY��3L�+�el�6�D'ic���qZ(20&�X?u^���-�撅�ɑ	�
Z�F�@e�:���BRK�gP���7_�~��|e�L̫%R�k�����`���e�����Ŭ�^C�1:�M��:�j����_��L<���2B���j�.�R�_��?�l�m--��KF#0/Ik8�=�3��Q'�o�g�F��E�ki320��~r��^�=��)�DWLQG8�}��34�[�b�Muq1m\�I����	�)��a�Po2��I�FEm2@�n&�v�y:�%2���v�6�%�1,�p*����|�2��O2����8BL��C�3[�Xk��ưҹr���İ�;*������D�O3f" �*!��0�$z�͐��Mȣ�A��9�$��9�t�����B���as&�9C�~$md�&��M�+p��S���C�.㏆�9�DĒ#w!�
���*��U��y�q����/ܣ�n��*��S�xQ���y�b�9��ќ.�h	�|��|ŵנ5�Wr�Q�j�u[]�Sؙb�#�#���ԕ�X|�~ۍ�UH��;_P���B�����"��F�|�朁� �X]�E���K���c7�ܯ�q�;��b��9O�>�̏��2������^��:�ϐ�� ���>�SI���̜�\\��Y�<��֒��9��sw�!�v�V�)��ӹNãF�l���A>�����Ɛ@���y.��2�S�B8I#�l!�*#�����2ޱ �q��x��N����B�L<�oT�Q�ת5�M����zY�L6�L~u��P�+��v�����b��y�^+L&m��o,#N�?gK~�t4���2�9�O���r�[�͐�<b|Ee0���5�6����L���gaK>�����ʰ�?52o!((�!�EF�\�Kʸg��Z��y3��-��Fdm�h�� ��,�)a1�X��]��}�d����A�g
���-���F�w}X8h�i�ǘ�E���πd��E�L+L�e	�~�z$Cw����p�Yd!�l�o.Q�4z��<�^a��zi���B7]�kͰڻ��l(�
b���@�&�/%��]����'2�f��|�J���@�2�k���
C�0n�*�*��a�A�y_���uZ��̺4l�-��w,��g��^{Ssñ\�{���J��{��&���ܘN�I�G��3�K}�D@�"?���:3	�n�����X��� W ̷�Ha�ZF.���Y�L��}�9�zY�x����D7�>��%�ۿ�G/$t7\��]��3�d.��g�p�#cꌧ/��q�P��Mt�Ώ���t�>�I�#1��`�xꑆ�$Y ��Z�Sg��,�O�T2�XO��B3�f���׳U~t�T�u�,�?���a�� t<�����7��������#m7��W��b�u�|5��^%�.^g��wG��س�{���u�v�	���;��)�̩�/�?��Y,�����1��#���3�_〃5�DH�8��'����J��d���	(Os�!�v`d"PUc2Z8�����޵It����74�atҩ���ՉU�Á"T�������A�k����;�{�p޿�uח;iA�Y�h�	��U��{�lodQ�OU睽W%yz0!��=f�3{#|E��4٩��@BbEu���ހ>p�`�8�����.5��:[������u�z󻏞T�oC����������ށ����[�*��u�1;�����r�k�����h��N��/]ǜH�XFkr;	��.n燷����s��v�6Xk]o�W�R�������p�<ru�tq�����d
���/B/���B��$�e_Y��_a�١�x
�
;����O��4D�h�t	앷	�9�mXU@r�|����d
/���2����ގ�c%��q:�|�O���������R���l'Bp��9R��M��J�H,�{��p�v�j"FZ3��p����幷�/��T*���ch��鿷[��]![w��p��%ߍ͖/��-�U�=$�W�xVyv�~���L�����m��/d<,O�6�b�<9"�9�Bh��[W*c�������aB;��*Y����G.W�N���
��\<G��<�O(&�2@6yg��80F��n��6���֡:��,-B�I��1�du�������N
ʀ�����3	����60]�FB$��30k�=���߯0��^��֙��ɴ�]�	=hN����J�͉`�rA��v�'�w��3i���>�!�e�^6�{;g����fvI(?�͹]�ʐ�������?r	���qyD`Cq�3�钉<t�H; ����,Օټ�"r�*��!�ܼ�?y�d���׳�
�K��+�XoE�!ґ�p����~������%�=�wq..����%瓙���S`h EV��4YMJIn� :GCDg0�ք��EF
-n���'P&d�$�iZ��+�Eg��s�7� P��Ļ�y:�U�S�[PdI�֍O�SX����-�C��?,��d�3p�iJE�O�s�9$䔷9C�k@�A�5&Zg��cL*T��C��#n��u
�I���B�ȡ��S����B�l��R:l %���ٟ�g�	 %���y�d��yƭ�@����~������bb���S)S=6����ᶐL��|�����<�c�u�5��`�i�H�� �>
����E����ѯ����a�1U��f	��c�l
�`�T��b������z��y�x\6Y%.��L����Ϸ���X/�!����v�� ����E�>N漟빈�����Y������֔l���~�#�tx�%�U>ҟ�O�S�2|@���jWt�."����I�|�Wx?����]���p�VB�V¢�WG)�3�gq==2S���X��-D�8>:3��_�N7���9�C�Zaka?�����i�e�{E5�X@uU�(�0U���KYGӌۥ���N��XP��$w��9>L�G���TF�n]'?m�»�9�h.뢟`M���s��[����Q��F�wd�+���Y�O��{?F<3�:�7W��v3M$���Z�U2V�W�������������k��eXL�h-_B�s�g0�y��,m-Ao|�שɀ b:LT���1��-p�T�J&��gX\�6�J#��e�nVo��(��һ�N�|,�vI���ֵ��[#�����~���e�K{;��p�Z�:��Or�W���N�{"���; �Hy��B���*����M��k��M�q�v�\2���O璨Tu��@�JD4l��M05�!�P    %��t�1����nA��Y�Ƹ�uƓ�4�|���kvNP�%A~:q�4�?��N����/J�C��S��:���h�\N��]n��Jߓ�7_�K�!�M�u�=�V)jxSGࢬ>>v�I�����$�cϞN�~p>��8*�a������JS�1$��%��=���Y}�9�:��#l/O�ݰ�}"k��q�����J�\|D����Y6��qB&'\r��J���z��|B��C�<�t�OY��<6�я��fO�k>��F�Nt'�v��\?�M-s��jr<���Ymj�5�#�����T�Y������JT?eS�� i3`�~j�yF��d�{�������+�T?d|��r�>��~�82zp��'�vc���L��1+P���hMǎ�/y�
��l:m�̂���`h������5@��8���_�B=������juh���$��_�Q���}����͠����P�����1��vR�� ��6��W��k�8k�Xp���w�g4xM�T�?Bs.��7��n�������[�V�9
/9�JN�*�|�A#�l/�:����Q�gboh���I��w�}1��x>��C:���޵)���~�ߗJ� ��ݽ$���n쇏��Z�Wo^'�,O�}��7ܫ��ԾÏ+|����|�l� 4T���\74���!���.�;�ы~ϖ�M�\�A	
3��3A�h���բ���,�Z�*}�*�˃Efd��_�]�Y��v�Z��Dyd��{f�m��K�;��j:�>o@��#d�����2�f2��������V�wJ˕��wO�[�@mY;��ʏ
;k�4�{w�ok�O�t @�twv��FxA����D�rc������x��q{��0�����[�*ۏ"R.�8x�\�L��Y�����1����eAh?_�lS���{>���L���G��|΂;���٥��^<1��t9�穸L�G9���g��7ӱN�T�Ȍ�t���de^6�5cjF#d`����0�����+c����+7��|-�h��Yi��~��cq��El��K���"p?�g�ÎPD���p���v~�?�03��@�����v���^kLG+8�d �o��k�pF\:�A��?����%������;��Fؠ��I��V�꠫��������k�����A��~J�w� }F.!�MQ^P�(����1���/���ǘ�7b�h�6����,��a�ҫ��|#(�e�0u~K��SjB��3K�]�tA����s*G0d6��ᮞ8���|zG�p�S`��']^7���-�g���Gð�m>���EW��{�{G�1��t�;\ڡ�r҉@�drq� �;M>�gݛ�=�8�&W�mtn��N�)�q�꘾�p
�wX�C�g�����>�>�p3`��L͸�'\�3E�"��`�&��D�U`���;�G��g��/�ݧ!���D��-*��I�7{��^��I��g�h�'�D�t�r[���Zz�*p�]p��,����~+n�.B0�S��w4��x��  5Go�1��$;�'3����Eq,�ꊟ��
s#�Ν�'��??F�Pšc P����%��L���~�=ڡc&��&����'�KX@ÎEG��8���9�y�M� �xp�rj㥲�aѓ�A�k�=�9C�i'�*c�+ v3	>]Ҵ�tL'$8�,��8>$zd�,�ag�3H��3�8Ѐs�S�NXh'�F�Y�d?_H�dL�ͅ4�?���G�M(Hu2�y�m�i?U��R��_<T,{�k��~�9i�)����%}r	����gs�T<i>����?�t�);���Ľ�W&b:��yF�L��[�MG��� ��b����&G���K~D"�Ԩ�a�f-7�Z�5 ��)����'HK����#���w<�v��X� ���D6�>K�9Ă"��GG�9����`>���քk��wy�HO���uo��gPt��j�/m�q&f���9�1dwb �!�4󫁧Ra���#Ƨ�Q�c��Ns�*��ͩ�Il�`gu�,x�0٠;+Y�%�����2:.ɧI�5���Շq�c�<:f�7
ꢴ��T~P�E��)�g}l�)P��%��*�9R;�k|�]�^H�^tG�&>-�y��!d�Lܗqz�Ǹ��%����J>DGVt]v�ᅺ��cu�A���\i^�[�08�0�`,�3����X��u�D�w�V�4�q�(�t�b��_X 2!8%�T��
"Zɧ���T	{����
a���?Cl���K����ؖ&̀��8t+h-q��;o�c���lU��S����5/�ʼ���E�ˆ�{5�=��� V�N�͐m
vf�������5�dV��T��;s}rxi�7�m��s����+�����xg�Y�0�9��c]�Z��1���_����.���̊HtH[�����[7�s_.�w��t���A����3�SD�z��Qr�Y!�8���Ϭ'�.Z�.0#O� a#'�	�4��*���?+X[���X� oAP�5+dSq��8�8r�0�F�.����v�pw<�t�h,K��Ra;DX�[%z� �6�?�C� ��?%�����,8Z�c�_�]�����_e!���jL:��}���G*tDsO�G����9���� +�k�ǀ�U�� ��� �!��2��3/aј>8��ƅ����/�{�qtc���|��T�u�wb������t�g����y_�S���⳴�
n'^��k�6�ta�w��fh}��@ER/�ŉ�݁��y
ӰZB��/?��:�`)�&T�l��'t�{��*뇃���N�>*��?�w �z��J�X�b�,�
a �� �����jU{��텥����r�B�ۗ+�C�<�O?�?�=.��A�A�[L��B۩� "u�{�N���B��Ȼ����"]!�^�d�������������4��q��!t
��;+7~[�}��j�2~���*
��������{�N��`�L
��#��>.�(�
;ze��]�0P(D�?٨�[�����:����d6�V}���v~|$&�!{z�������\%_�����XTW��S.���NCҸ�^!����!U9];E��K� [>!݁����ѭq|m!t�V�;�?H�����a����J�--�:����j�w�tk�u�@���3�xc}iy��� ���\����R?lRo~g�
a��!�sO�qA\�|Ne��%s��p���ˍqN��K%��6���d0�����Ƣ�b&tq-9�k`Y��XTVф��B�l�?��a�2X\Yป:��w�1��3�ɸd��n�� �Nmju�����������w�!�[W��#�G���z�L�PW�=L���P���\�ݦ�Upi����6�����ĥ�M{�&~*�B�|�I��O�m�!Sq٥l�"�3��h@�Y�3z=�3�,�7���sқKN�9<��:�͙8��v����|�� ��=h�<mM�;-%ۖ1�8a�6B�U<��%b6����u����Τ��Ra�h�"��L(���o�l����v�8�6z�i�e����PW�#�L�j�0o���Ї�jG��v$��ʀ�	�: )�P:��.%���q C6�Q�XO5�w��$�yCM�ި\�a����)�bP3�Ј�E��r�ڬ)�^��h�X�ӳ@+A�t(�������?��I�U���H0��C�t��9�8�Ab�P����^3V��{`�bQ����?�.e�[��xV��Iu�ɷC����)������ng�\(��B����#�w�+;���g��p&b�� !�_�}�du�ry���y��nDh�B�Ev���fP1C�5� �x|278@Ij)Ѭ	1͌!�i	,$�&�C����%��-�^��J]�[R�ʘkp{"�"]�'��a�[;��o�j������c�t�҈���_���7���1��߀�D���$�k��K4B,*�zy]65�1`_h��R*Yp0��A�?K4����t_�	��f��_��^S�$�b�,��h#!|-    ��+�>�	Ly���r���{Д�dp&�U*����q����9�5�����?o*j+;��ゟޡd��HsC2h~��}�z^��+���Ow<KSl �E�:JnB�2��9)�7s���u��s�bR�(M�ȣn*IB�S��[�)����Vk�Qj�>M�g	�P�-5�I�ѵY �r6Gt{�B����sh�}��r�!o$��w��{��A�̋݊Y%����C�X�L:��k{��x�I��:BVɯό�d�F���!q�� $�|�#��R����h�e�P���	Y4(�y�n�T���U.���/W�ߍ͗�Aݸ~{g�~Ԇ�2pV�A���ʛ:��,(vށ����^��_(o<���Yf�
���&d��V�{S����"Q�P������ $�r����5�G	�C�>���Z9"��v����!�Y�x���
D6�Qm��9r�4	,q�	J;�"���w_���SB�;/I�{��Y�N���QOV�zh]qA�C�LF귟�(�'	�d&��
�G�y##9���8���oc6LL;��r���N��\g:��g�˒�𸷱���32MuI�N������q�g��c������I��[4�����Y���rbF����`��L8��+,R�n��#cދ�oQ���(4gw��{�3�Ea�c�-��a�vn�oS�,H�c�g4��nN�.r4�V�ء��5)��	���>jWi��7�\R�r�y��LO��	%hp�Z%����~�?j�����]q�)&t
m�)�9O�y��ZSĂE�E��8���äZK4!ˡD�y9ȭO�p&�.o��#!�G��#�w��!��%ф�'HW�&�y�@�9�蠓HQO�����ȗ���A�#�c��#��L��x�����&3�17�2��&���s"7�����5/	uQ bT�^q���)�n��(hA6�)�zT����Q0�<� L�ƫ����9f_����D�3�5����}y\K���D'�[ [͋C�iR��s�kO�>�D������+wBp��͝ғ����55t�f_	���Y6�i��n���ƈ	�B�� F�<�����E#I){~�<Q,�#r�S2���V?Σ�4Oj0�0T�] �aP$��(f����-d+f�
�ht�`�wJMp����͒e�4��-L��������v%ҲQ�'A��:���.�6���m>gV{9r�t�Z,����k8�y���_��4�X������7/?��B�������_>v���&X&Rο� �3�y��Bi�F{�,�T��g2PZ�I@z]f)��1�T'���>r�K`k7A���G�J�f�ƒ���R���O�w>UQ;5T�R �.'0�������Ěh,ìcTZ�#�T�
D#=]*7����5����Ұ�nyEޙp��.X~U#��	��Ҡ��"ꆗL�9o,]�<�M�V�J܋����d�B�����T�7%�&��n��5Nd�G��q�C^BT�vwkl��փ�i����M���2�%C�O�>��Ds͎$��^�!�Q���4�/J��$өS(�%�Pv��w�����x��^6A�d9'3�n�^��?zo��q<��?^�gY�D�+w�%N�${g�� ?R�<
cU9C�N5��yR�A�|�4�Ǆ@e��"G��ami�z� f��"�qi�!���gX��P�����ӏJ��/���~N����~��Ș,'|�u�W�y�KS�9{W�����rB��zco�q���7YR��g�1*�״0o�VO��� �q� �S�/4���'B��)�K�;+��s��/�������t�� ��N���Q�rweT�d��'��o�@(]_�)��>������ŗ �N�z7�AU��(�cRϨ����V���|y��K$�r��0�kG�/&�@�h9/��iwq`w�|�vV|ٵ�jS���0����S��%�%�yJk=�_a����X�4�]���u	,Y�w�5����/��r��"�* A�8��.���81�YF=h�b�L<�,����s���?�Rp��<a����P�X;N��|(�y�ʑ��I�)�ʗ��l���ӓO�,`��4(�a��8й��GF�Y�l�gۉ8�q���1a�9v��8Gh�HB�CB���L܄@;�>���c���[�f.�ң������"D���O$\꧇zM���8�q"霌'�9&kg�n"Օ�ZG�5�o<��%���m���<�ph��t�7�� ���V� `?�	�,��&�㼬�P��	r%��d�8��2�	��J�� �qI��P��B2�#Vx�+�FD�Z����c����+��w$ϡ}����e	�!�Y)���#�}ï��k� "�h�:�7�?�ß��������4
^�(�*Z�븎Wh��8�{�v�/2�&��W=d  !b3�[��>j� ޖ�yȄ�"P]��is�C jE�����;�k��Bu���yQ���߁e�.�[
5�C����]�����CKQ/l�;�Іba�EZ��`هN#A�5�2��y�R�F��a�Vx��5�d��-�"HPD���
Ak�X|==v�#!31���.�^j"MVq��KM��*��_j"MV���KM��"���z��4Yő:.5�&�,~��4Ye�:.5��E���R�Xň:/5��U���D"V1���&����_j"�k���&����/5����]�R�X^���_j"�;��KM$j}C�_j"Q�뱞KM$jy-�~��D����.5���Z�R�Zߡu]j"Q�+��^j~ǥ&����إ&�����D��7���Db)��^jj^j"1��R��&fWj_jbV��w]jb*��}M�j<�E:��t��L���o�v���?9�����2��V�X, �[�D<���G�~|�~dB���_?�GݮDg����dH���z�c�3	�}��g�z~c��u{R4��h S�m�9�����5�����O��2tv���`U����9�ͷGs'���o�~��`!�8�z�7j�Ϟ5-��;�M^�Mǳ��N�@=���Ϝ}���J��O�L��!HS�!�R���D�_� #�$�����ξ�SF�)�6��_����tk���=p�C��w>�?G��ڈM#ޣ��r?��=� ��e�K��:���x����갟�}_��i�j ����&ݸ�����s�KE�%�N����PmI��8<ZD
�X<*�auԤ9.��p�;�|Gu�f ���G�4���T��y:� Q*��Ș�9L-�xS.x�d3	� 'ܓ��gӼ�ha:P�er�C� ��}87�W��p�N���ޕ���4��WT��؇vX��0	����8A��L?����9#����/�0�;��ɇ�����!�RX�{8A&h��N9g> ����u�e�2� X����)�v^}f^~}w�Cd�P���	^;�&�#(¶�MQ݌Cf�w����_�֌i/4�+�1�~\�4W{��?\$�)�P.��i��`���=���W���(�4>�T�	)���7�v�D�=A龜��6�ܷ��Mj�ו�r�?��Wo]7v��z]쉆��l@�ƼP'4�T^:È0;�����+2��<�������w���8{s���%XeB|��SW��}������$�9ۻ����V��4_2�����^��\��\�]{D���r�~xw��� �l�B;�F^�>�Z��&��V�Ցpp;��勷-�ӏ6�?X����ڬR;Ԝ�`6������	P;�� ��|��S�v&}�`���ЩZ$"͡�Ȁ0j��#�U��E��]�uܐ�����K���#�IT��/��.��F�ە�� ���݁����)�*O=&�85?,�� a��wևʏ
u��[*�����"$}쮟s�U�&�M���/�3b׈�.�C���"d�����<��L�{76O����]·{�{�re�	m��q���ᝥ{�+/vV��P�y������N�	�����o��;��o�A9�ނi���0p��{�    r�}O��F@3\xA�uw�"�O�^���N���`���+��������y�������ۅۅ��}��n�0�g�3H_E�*��*sR;���`pa	��c�}C�	\;��n��ϋv}v�=n���.�&�������5�*#�aC�{�x��aeϡ���]Ҝ�4�Ƈ��]�6�� 0��f�x�5��pԣ`��{BW�p����d���ͼH�x��s'��F��L�1"J���E8��-r�S���(oĮ���aD<�8B`�=%�B(�&%�$@!�i4�<!��&���|��(X������Ż��_$�T��>�6!DT(�y���fd^�S�U���睧A��i.s*�r��$��G.�tU�2v��j�Z�v�	�Ip֒�4�.Y/�5�5�Q5:�9KN�	��|퐇�!�%m Ԝ����|��vȃ�Q���&��.%���*"�aʬ"���d����vz6��Yڴ�+��&"��t4�?r���t�<��YUE��*��;�\_t� �2��4�"YW�}=��up#��(T[�5�Ǜ�;sI43���_�R�[�I����$��j����_]�#�k;'�gҙ�~Xb�㥹<�)�QS!�,J���+G~͢�"��܉�R�����͙XLA��q	��r�����2�K8�\
�}�d�'HO&��Rd�Sh�C>�m:��e\��F�a�Au�Q���̣8��)�y Ỉ`�vs&	c<��y��q�cB��|Ν �ɪ��jA>w�Q��܀�;��:�9��	�Ƙ��ߏ�1�Z��;T�m\w�X�,	˘eA[INN<�����!��!}?�E��>�IF��7O��p{Q�y��j>>aL�!y��*r��挳�(9�'\/�k��{�W�3v�_��HЭK$���O�H&t��k)�У����<����T���ɣ�A�M�����a�3�ϩx���}��@����~JlNw��1��_r�-ao)G��~�'<���B�ռ�l<���i�6Q�.�R;���<��<o>Gh,Ht؈9��nPG5'3O㕇�]�C��3��c���$t�!p=�O�V������g&�:���Q��!6�'`�}}��*!.��p���&��M=a���G��g&��������1�a#uĠS����@L�n"� �+Ho��[�@h��	?��@ʽ*�M���#i�Gr�QR:�%� �x�+���k������R��H=U��'�7����`� d�j��e0l���x��i�x]c��L�}=d�t���9����+�:��q(��a�� �~��"Kl�Ju=!�K�����m�/�#3�P����~�.K}��x�9�9�yVK�J�~�Rp��M}��8�~}8�Y��5��J�����)Gu��J�ڞ��<�*�P�����M���*�4@Bz�Q^F�	��ru��|�X���}�-��ez�iNj���*CWH=Y�T�P����ȣ�-xqa^�Z�Do���o�1��+�%�0
�s_j�%G��ٷ����B�?~3�?iW����e/P�'�9
iz`Js�!��\��k&������x&��	\c���Ea-�xֶL� ���Z 7���%Y|�y!5�뿽h��"�/Y
X�kT�҄Ec��� �
��K����)9G!abSҴ@]���̴����b��B�����L]A�3(b�o�*f�\����:�ۉV�+�� E*�ܭb��^?]+M�����g�A� ����h��X�@����7� ,y�ԼX�>X!o��6f�]�S��,��9b�+���84,�Uר� �P8G�	���u1��i��,�Ɠ.����~��ȳ�B�̊K�o��)$��"�<�4UWXJ	g.$#�0�,����/	�Z��la�����8
Lm�HӮ�g#$��1zȑ����$� ��@���|X>`()�M�!cZ��EV�fQ~L���tg�$uZ�x�H�m:��L溸s��&O�wN�t�㩳䊗�ҩ}�GN�~ASp7�Q�O=P�]�<қۅ��A?�u����x��S�@=��W�8���`�o^��H�˅K'�ڔf�;�y��c�X�a^��wJ�O�ه�i��5�l��7�T�D������Y�M����<��� )}{R{#���$�&j_�x��P��h)�{U���^ꇲ���!��iܻ6��j��X҇*C�*�i��~���py�ee�By��-�呧`.LW���b��K� ���E��ݵا����ʷ��J:`k�9�|��ۧC��p���ѴY�˒������y���m��w7���%�|wn-FOw�F��8i�_�:T��yr� �G��>u4�]���c\��ڏ9]Wu<�WL��Cd���hi���򅳛3��49�q'�A��ם���k��{@k�,"ʙ,yD�D�+�!8n�9�<��C��tj�~Z"!\��:�N:s*�B]���Qx�B�L�����7����ea���O�D��~�7���)׃��Y���Z�&��ڜ�<SV��v��OAt�au���=�
����9�÷�^O.�,�|从�ղ@~�.�*�H+0���7r��_��=��\z�����Z�[�h�Ë_՞��ʰ�m��e���<-�p�~EQ{��;,����Q�>�m��<���l	�1����S�ď�~�	�<�?VhԪ��X�9�e����e,8�
��L��7}XP�|�a#���M�%gr:�i�ը^Y��Jt4���J��P$�7"� ̸:�\m������rj�<���iQ����4JO %� l�HZ�U�0�Dd�t
����y�֜�(��x��I"��ʹ,�:�SO����xw"y�k*7�q1z�>j��8Zu��(,�(��i G�l�er!�(�� P:������q\i�a�����/<���u���~e�	G����,�1TmM��Am|��UJ�H;#Y�>$]V/N9{Wn�=VEkn�x���/�Kչ�
���f����Y	B�*�(��X��T�Z�s���Q��j�,;Y�yx���)��.���K Gqp�r�v�#-D��Gi�cGНvxgyH����	 9�Hzm�Y��ޒ����7�K'��W�.�u� s\��Y�@D�;�K2DV����3mV]%��4]{��V�g9�T�>��a��	�:��7��k(�^�.,�)���i`6ʆ`����ؕ��GO��	�o ^z���@���7���p��b �s���@*�g���%�yG��5������
�=�Mu�T��^ñt2�W������ ��'��$�83���V�8����[$o$�G�_$:E����`w�T�k��@:Y�/^$����[-��NG>����/�V �L��sϸ��)�Kثn�N=tc�؟�K�s?R t���F�'��ӧr<s�(�(b�5x��-�?��.l�OA���X r#T��d���?�G7Od\*f�X�o�|{���J�fӎ�9�Y�^%A�CM���y���W���N�	�0�"�@�g�;�mŗ����i	d�"��W���ٔ�J2[���E^�<���ރN˜�#�&���T�	C�Nx�M*�d&��c�jG"&��0{P/@,=jT5��`P{��{D�i��V�<�P t~�o8/ᶂ:�W������^�{A�j`����d��~s�qk�`��Gk��Mꟽ�
�N�|G}[ި{�f�SjGٺ�5�5���7�Ix��t��92�Y)!�!�֣�XO�CP���K�:��i�,(��n��M�/�����s��H������W��{A|n�O�M���p�������޳҇�>X�*�d\؝�x76K�*٬R*Un�x[Xj$����+�+�yC���h�2��jhAj3�1��5`��'��������x��U#D��݄�H�����h�����'��z�Zv2���3��K���"��b �9�ʈ�$ˋ�7�6���3w)��9�NxB�}�؜q:]J4Bqf��6g���z��o6�/����    m�e�QiEйF�Bm�PJ������l��!��z����쥥�nз!����h1�BO`B+jr.��z��I�no.�)���:Z���f���hB�Ʊe4ϯo�5R�)����
���n�?̀#|����L���}��Б��5~�͗G9z�s��/��W��/���'L�gl�F0j��~�*Y <y��M�ɄƠe1C�f�?M�<�a����{�˥B#O^���p.�_h�M����Y c��J -�k�cY	x�������۵�Fqd�g�+��H��e����h#�!�V���m70��cM���1810&67��`��0�����؀'�_�:�����Ow5	Z	��q�9�]�Tչ�w��S��Jk^�b��$"DX�E;������kF���&��@>�� �!��@C:�_�=	�" IB)� ��(��;�⇓o��ށ�����m���y��կ��0�.Z��/�c�Dj_H�8ͺ'���MG'ήk��!ˡ���{x��k��=��k�)@�g����� �B:F�@��t���{�ń󀍑$�:��V�5|�k!T"��n��^�{�r;ċ0��4&�-�\2f��LM:Zq �+�c�Ⰾ!S���8�{�ACssƞ����j�4��5�Q�V��&;��s�X����7�9�ءo\s��C�x�3�g��~צ�d�G�Ï&!�1m�A���z��}��c���3��`�!�śuyٙ8�ͺ'�s�8��u"�q��2-?,�~�,�{�SB�IY�����Qd�KC�^�O3����ga��ˡ��~�׃�T<��6#�TI���,�~��a1�b�6�����S�N?�|�؁�"�q�٬��z��l��g�P�#@hO�1�1��R�Q�~Q	t�g$���f$���3�M}�I��	���8��ŀ�?^I�D��I^%��8Vq�<EY�Te�S'��f�!h��V5�γ�6�y�.>#V[`��Q���.7�sk�y���<=��;�5x��*��V5 ��|��Ҵ�cP%�}�55P�~83�n���_�9uP��΁k�{�����N��1$d*�g��V��|�`��ό�֭���5�p���#�����Wg�W�۷ﯽ[��xx�ݛ�>BZ *����:e?��9�?+J�h��ə�̉p� �}g�@fW�관G�!t��ƜU:Z5 ����Q�p�����t:;�*�8���9����=���&��D�G�'�J(����Z̀'^9��<�Y�)to}� JʐpY_2���3�s�}�K�l+��9��م������[���C���~�ĞUR��n�_�.��;߱�5nZ�O.֖aC6i����2�F֋i�������{P@s(�v;P�9��lO������!(�[��p��X�&�u�# <�Q<���	ө�)���ĤU2Zmbt����8�{>�N���b�����l�:�gk�B.ա� ���+0l_��� ��' ���1�R���! ��+�5�� �FU~G�Շ��i0v�f|b�Ze��f��[q8����`����c+��_i�)��E򱌣���"��Ey��p�\������f}|�k�,�\����@||��k�.�'��/^YC��n�5ō�o��K���L�v6VÂ:�'�T��(�)��85���_��͈WYh���KP�x�*>%����#���^�qV�G���n����]quV\ël�K����.7@|BiH~uç+�b�94h����͢��������	��0�{��`��\b=D�UW��!�h��7�-Ħ�_��*����$���k6���� �DB w�-�-�~A1� I�$9����D��JB������>���3� �D���L���^쎟�����p�G��G?S�s��<Tƃ�3g�V �1Oػ�	ˇR��h�XGK�^���B�x�I�����E*�7�c��s+��Ғ�]�3[�y�Y��3`K^����)��v������c-��ryL=o�Ny���8H3�&�t��h'A�.�3-�]����N)8�����IzZ��+ӿM�b/����HI�<޹7�|0&��)2:%�@��%��u*��ęh�6o����O�JPuog�|'�H�w��T�0��.f��_���̸ �]�!�͡S���[���O���(FѲ��9�/�x�.�~o��t���%.E��)҂��tǷ�5v�;U�o��II+� v]]|a�Q] )hD�k��<%;��#�7^>�x�x�p����6���B��'�0��ˍ�/U�^*Rҕ�	�w��{`cm����]��f�)í�s��1���4���͑K[W�oVƂȱ$�h��K	�}3לd:|���|�)�:0F�D|&���"u��z�Ҋ�酯���VS�kŁ����ӴPh��̣�kusdБ)*:őƣdo�ʠ/$�u���֕Z_R���!w�Gg�n�"��T7I��jx<zp�.��7���:�=$�="6�q�=J%H��X6��9��(�L{-�|�i��`�� qZ�X���r��#m+��Xoshft?%F��e�TH�MMl�IBg,�`,�Xe���P�[�-�
����$��l��Bؼ����1� *8��)V��)��h��	���%{�i�p�
��~�D8UC�1k�����$#�T������d@�Ln�]ɖ|��j0≄*�;]�jd"U�&�2j��fa2�����K��j�e��G��Հ�ex��l��N;��˴��4 ��VkF����>g�r��ٻCf.�v�ϚI�OB9e�Z6R3@�8,�7L/�W���
�Zs�ni���+ޮ�^Z~��:�S��8�<Sp�Բl��yK�p�8?>.r²:Uc� �bL��"f#Q ��&�%��`�k��=b�)����Vm%�$�6�s;��]��豧��BtT�Q��N�U���x��t�y���p�r�J/����лc6�����z�PPU��x�"W�(E li�� �1�F\@�.�\ �M-3Kb��D]�D�5��[�X!�?���`n��	t7�M69s9�B��%!�x�����\�"��L16��( D�Dz���	Զ�8i���P���:ܘ�X"�ht��Xk��@."n�)�:%��p���4 ج�DuJ�B�.�%�|�$��<o�"�ˌ���QZ�s����З�x��S��z���u>'�w����2f��T����R��Ql%>Q͒-O�F�?�$%���s����i�Bf�9I6�p&	 '<��0A��N�s�z��6y��ܟ#Z�;:#p�������(F�.�Z\�|d鎤�,�Ŭ?+Q�8ݑr&�n�c��*-��nA��l��ؙ�D�3�YV2d��ر�l���X<)�m򂟌����T���T�8�3��������\�͛l�%� ��v9�URr�f<L>�����d�gM�n�j�VcfN�-fe*pT2���cF*O��T�v�R����K�����Z�Oi��7������,�YG��9:��D	�y��oq��w/&��UD��~\��\�S�vQ�Ĥ�1�a�%�����7&��)b�<��n���/��� 1ٴ��o\���/�45:�35�6���DLo�%}w|s��f�ގ����*Đ�*G�	yͣ���6 �a�S�O}��J���y~�MV1����=7�ՉMv��g��?Q$ ����_2I��s8�>��U.H/�/�Σ"�o�)j��*������}S�W�e�Qz0aD
��X��N\i7�"5\^��h�*�w��7�}'��D.��< j�e�Q	@�'_X
`҈�oØw0�p�\�@O�):�y;4ų�-�g8��S��;��4	y?ޖ�eO,��z�5�ag:T������By���0+	�����-�rdhl�9H�c��YB}�W��<]�h��~]q����y�Fs��<u!��E�Y���a��b��+s*��q2c�T71�87����ƅۏ4.������;[՛������0Q�["+����ϻ�ŕ��acmt��^Š b  ����E:֜��$6`�?/_���)��<�PO�P�@�`����Y�lqr�����L���k���a�8�_�=�����ϡ{�����r}���i����C��JpiSܚތZp�)�I�mB���;,}�3gd����2w=��ΫN��Y�z.�
�{�\�����|ٚ"J�(�a���k��@�����\H9��mґS���,K��ƪ�Y��vp�6�+���6{~�^C�?A�5�;�*�>��^��0{�cߕ�d�-�U>V�쮃��0�W�R�l�����V Jc���+�[B;�����p�d�\���1w|�޸��0�V����[F��4���vzz����F��J��/�,�$�󀜘��[W�7.��wg����c�_h�2�����˙wo� -qJ��N��y@��{���uF}�2�ؼ[a��� y%��'��|�+,	~r���;B|���-��Y�xV�Ս �' ��>�e���[a�N}��(�`�����QEG�g�k���0Uyf;?��L�?��)"��Ľ?�T��n�;��lvg��9�Ar�2�\���aŠ^K�)�x�1�x]�q��w}�����
�0���^��U��/�v����n1      �   �  x��WIn�F]�NQ�$5�Y���Am8�M��V3�X�*��1r��$'ɯb���A;��������U��]�֏���(����ʛ���h�	�'�j-<2��B�P�ϘΤL��ڲ�D&u~W�*yS4�сu�r*{�<5F��u�q�J&��+2�Nj����yr���Llj��ѸH��ri�f����f��B61�}Wm��㪻�y�.�!׵va�����h-�Y�%�MJ�?-}��E��@�ȑ��e�����"T�!J�����{L~)n���b J�'\��L%��q�J�
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
,��͕OH1'S���8��}�A:�A '>����VJ�LX+`�bٜ�ݲ#�x� 	O�9\�ɰw^M-OJ�sՔ�'������6Lꭨ�(�`�����zAa"a>�'���t����a�	�^�9$�UH^Ns�9\�`9�7�9���ڤ��D`Ar��=]�y���m�l�hn�����E���<U]�H�����:o��j�厄��"�j�m����~sK�-���������ؒj�o��O��/U�����y��y����hi��            x������ � �         Z  x��X�n�8}&_��V�C��^F.�Ī�cȉ41�/ͶI�1�s�LS�J
�^km{ߠځk�qZ%�h�#U���,�krF���8�k�4k)2k��G����2��(
�,OpX+�i&Ep�(�F�z�7�@-U�"������K��Q���ઈ|�c}����*�^�?P�:��I��>I�ݒY��ባ��	�Ί���!R��nGRM�
��x_�Y���AK�@ݠ:	��آ8^��=�﷝�|<l��.�xM@�aRM��a��H+��ð؟d�p�����D9��(���-���eI�,#��Ũ��F��C��ٚ���bv���@>���+)Fs!�E�瑽�{� w��51�������� �Ah����IV�4L�}�� `5��Mm��(��$��6���u�3}�V�q%����_R2��l�㍺ �4��C�ϣKGkp#�~`�� ���l&3x���)\��s"9,�|T�9��q�y\� ٠���Qո^�Eſ�'�k��r�t�bl�p'I5�c���6�>�5��H�&�E]��YZ&I�g���ۭ�85�_�D՚�� 9�װQ�X� ��v$
�<5\�M54�tL&~��f�&(HK��h���q�t����i�f�?TE��l{�'P�.�IG����U�]`ڤ8�p���(����D�0�HY��܁X�`�#�m��ō ��&E�i��N7�^�ݨι�6��I��Y�8���e��A	H�W�%Hn��N��(��v�29 �H�Z����-=�p\B�Iwa�O�l���0���1	�Q�0]=T�_%�ք���"_BV&q��1L+�y�fq��D+�7�j�GT�� ��l����s_[{� �*8��4�(��p9r��Ք���A ���0�Et)��[��bO�h�a� ťI<�$S0�RЇO�¸<7���Y��6� ��������gc.ڙη�2����"�>g�4�<�j}��R8.rZ�E�q�K��A�X��#�ˎ��t����kQCi�F�w�o|�%j��}A�DG�)��m'`�̊0�yT8"���?j�
�\�6f7�����n֚%]8b#�G��떹f �s��(�EPS/�_ ��պB���&���|����V��/Tϑ}�t�h�����M��k�{Wn�X|��«0��6���r��7���ͽ�_']��{���N,�s����v�r��"+"��?2����:G\oځ�!㶐�i&��
[�9Es?�`��S��A��r���	Z�&,��F�z�q�`_{�\]����6����k���n�n���U�H�:vO�%��(�� a�ys�]�,㬨�{hC���3�7)�̎��W6>W���с�3�,�9B�F�)�o)!z(T#6��wm�ewԭ�����mK8�K���5a�Tk��q�D"f�K\^��>W��t����Ċ{�G�_�[��`h����3>��=W��s����>v��3����#Ð�^{/���Tr��3�ί�����u�2����nw�ӧTYVG�_y�]��{>%8"��kҼ3_Ml�b������LY6��I��xe��p����8�>            x������ � �      
   F   x�Eɱ�0�ڞ"ėL\r� ����D� ��2�{
{m����X�0��e�5
����}MU?'�      �   p   x�5�K
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