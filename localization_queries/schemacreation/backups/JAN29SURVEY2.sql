PGDMP                          }            survey    15.4    15.4 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    public          postgres    false    230   .�                 0    17188    anonymous_session 
   TABLE DATA           Q   COPY public.anonymous_session (sid, sess, expire, anonymous_user_id) FROM stdin;
    public          postgres    false    245   U�                 0    17161    anonymous_users 
   TABLE DATA           ]   COPY public.anonymous_users (anonymous_user_id, created_at, is_active, nickname) FROM stdin;
    public          postgres    false    244   b�       �          0    16524    country_names 
   TABLE DATA           J   COPY public.country_names (id, iso_code, language_code, name) FROM stdin;
    public          postgres    false    221   b�                  0    16852    establishment_localizations 
   TABLE DATA           �   COPY public.establishment_localizations (id, establishment_id, language_id, localized_name, created_at, updated_at) FROM stdin;
    public          postgres    false    237   �       �          0    16835    establishment_types 
   TABLE DATA           H   COPY public.establishment_types (establishment_id, type_id) FROM stdin;
    public          postgres    false    235   ��       �          0    16815    establishments 
   TABLE DATA           �   COPY public.establishments (id, est_name, city_mun, barangay, latitude, longitude, address, contact_number, email, website, created_at, updated_at, is_active) FROM stdin;
    public          postgres    false    232   ��                 0    17086 	   hf_tokens 
   TABLE DATA           8   COPY public.hf_tokens (id, apitoken, label) FROM stdin;
    public          postgres    false    243   ��       �          0    16475 	   languages 
   TABLE DATA           9   COPY public.languages (id, code, name, flag) FROM stdin;
    public          postgres    false    219   '�       �          0    16457    localization00 
   TABLE DATA           X   COPY public.localization00 (id, key, language_code, textcontent, component) FROM stdin;
    public          postgres    false    217   ��       �          0    16595 	   locations 
   TABLE DATA           t   COPY public.locations (id, parent_id, location_type, name, latitude, longitude, created_at, updated_at) FROM stdin;
    public          postgres    false    225   3�      �          0    16447    municipalities 
   TABLE DATA           D   COPY public.municipalities (id, municipality, province) FROM stdin;
    public          postgres    false    215   ��                0    17028    sentiment_analysis 
   TABLE DATA           �   COPY public.sentiment_analysis (sentiment_id, response_id, text, sentiment_score_positive, sentiment_score_neutral, sentiment_score_negative, sentiment_label, entity, question, date, language, metadata, created_at, updated_at) FROM stdin;
    public          postgres    false    241   5                0    17317    survey_questions 
   TABLE DATA           �   COPY public.survey_questions (id, questiontype, survey_version, content, modified_date, title, surveyresponses_ref, surveytopic) FROM stdin;
    public          postgres    false    249   R                0    17394    survey_responses 
   TABLE DATA           �   COPY public.survey_responses (response_id, anonymous_user_id, surveyquestion_ref, created_at, is_analyzed, response_value) FROM stdin;
    public          postgres    false    251   �       
          0    17308    survey_versions 
   TABLE DATA           _   COPY public.survey_versions (id, title, description, creation_date, modified_date) FROM stdin;
    public          postgres    false    247   �       �          0    16533    surveytopic_types 
   TABLE DATA           H   COPY public.surveytopic_types (id, type_name, display_name) FROM stdin;
    public          postgres    false    223   I!      �          0    16751    tourismattraction_localizations 
   TABLE DATA           �   COPY public.tourismattraction_localizations (id, tourism_attraction_id, language_id, translated_name, translated_ta_category, translated_ntdp_category, translated_mgt) FROM stdin;
    public          postgres    false    229   �!      �          0    16732    tourismattractions 
   TABLE DATA           �   COPY public.tourismattractions (id, ta_name, type_code, region, prov_huc, city_mun, report_year, brgy, latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity) FROM stdin;
    public          postgres    false    227   �?      �          0    16827    types 
   TABLE DATA           .   COPY public.types (id, type_name) FROM stdin;
    public          postgres    false    234   pD                0    16873    users 
   TABLE DATA           �   COPY public.users (user_id, email, hashed_password, full_name, language_preference, country, last_login, created_at, updated_at, is_active, is_verified, role) FROM stdin;
    public          postgres    false    239   qE      &           0    0    attraction_types_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.attraction_types_id_seq', 11, true);
          public          postgres    false    222            '           0    0    country_names_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.country_names_id_seq', 1, false);
          public          postgres    false    220            (           0    0 "   establishment_localizations_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.establishment_localizations_id_seq', 1, false);
          public          postgres    false    236            )           0    0    establishments_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.establishments_id_seq', 5, true);
          public          postgres    false    231            *           0    0    hf_tokens_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.hf_tokens_id_seq', 7, true);
          public          postgres    false    242            +           0    0    languages_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.languages_id_seq', 8, true);
          public          postgres    false    218            ,           0    0    locations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.locations_id_seq', 52, true);
          public          postgres    false    224            -           0    0    municipalities_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.municipalities_id_seq', 1643, true);
          public          postgres    false    214            .           0    0 #   sentiment_analysis_sentiment_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.sentiment_analysis_sentiment_id_seq', 1, false);
          public          postgres    false    240            /           0    0    survey_questions_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.survey_questions_id_seq', 126, true);
          public          postgres    false    248            0           0    0     survey_responses_response_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.survey_responses_response_id_seq', 1023, true);
          public          postgres    false    250            1           0    0    survey_versions_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.survey_versions_id_seq', 1, true);
          public          postgres    false    246            2           0    0    texts_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.texts_id_seq', 5581, true);
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
       public          postgres    false    229    227    3361            �     x�]�Mo�@��˯��U���.�MEX)VV��KQ5�b�"���#�i2��$3O��zB��)��^&�c�8N��@g���A�H�^6��T���[<��'�*�Mf?ʮf�$�7l=F���}���Ey��N�w��Xr9E� �j�/0o?�{�D':��4|��5A@�����L�TmWH���@!W���u%0�g��"�'�&���R?Zg��a$���*ڡj#vEz���p��+�7Zvi�E�;׬QW9L��uNp��#�@��C��>df[����\"         �  x���Io�8�s�+
�Ô����8���Nb�P �*˱%Gv;E������Lz������QZ���$�]}Ye�H�z���*��j�u����{b���I�=��"/J��]#�3R	�E�w���$M0�@ �G,�*���%����:>�r�/��v���}�n��x���y|����E��.���u��������� (��Bɠ�D��8��<��q�P������������j�з�����{�f�^��8&G;��� �6Rʩ�!8��Am�p��N�	���G�/���	���;�o&�֪�2�n�h�y��㤖@�R��Di,�3��"�0��LK�-/��O��]�'h6ÆAo�DN��vj�,�.��P�P�����#a!�;wyg4z�r���u�fk[6ۙ��Ɋ�<����Y�!J�8��h.55RKE��Ζ�>�h�����?��ƶӴ�v�;�[�)A���I���`��1Oc�F�����Xa���3.��|~=-����������[/�b�����(O��v��X���<}lM�Y� X:����<W�������]�Q����kު�~�C�S�����e�)�E L�X���G@cg�'X�~���<��x՝u��^7�[M;S+}"�dG;=��I�W
� ���3>h��y��Mp?Z<�w�{�lԷY�d_��^4�S���y$%c�kB<��	m �@�uRh'����	H���P�_/�����y�;         �  x�u�;�TAE��U���U�N�A	 �����pӍ@0�T�ީs�]�Fse�㾁�7���3[���:CC����W��֮�������/i94s��@�r����<�J��_{�.�7���?�����H�����'m��l��N��*�asRBD�l�>�1oHoM�d��7�-�+s�w��qXS ���tl��@��(o�bŹ���? R���W�C�YI��V�]��!n��hƼ�MUI�l���4��|RIk�0�Z��L��$�zMHMWb��7&Dt�ʝ�����Ox�YC?'�|�ʲ����b�7���Q��[��2��-ȅdt��u���F�@��IPM��]&:!Ă��|�ې��?Z��&F�J�D�T�6�ب�	=�x�G�z29���
�o�ֹ��l��뿕�CD��²<C�eeڢ*X�����C՟@�gK]gܡU�=�u���'�h2�]���r�	_{��      �      x������ � �             x������ � �      �   *   x�3�4�2c# 6�2�M�lc m������W� �>�      �   �   x����
�@F��S����h�&�Em�L:������	������9�aQK�!�ݍ�lh�d��iXY��k��i;��n�p���ٮ��wi�e��$Jؓ-DX�I����^�r���\�|�7���:+k�ϒy'+����C�s�%�< ���-�z
ޒz��Z���k��x����)-�0^��f         q   x�3�5r+Nqˎ0�wsw)v��3��Ȱ4�/+�6s�(H�*�pNLJO31ӎ��t���/p�
3�(	��J	�ȴ��r�wͱ+()���tq�O+JM����� �� �      �   �   x�3�L��t�K��,��,-�2���|��������y\Ɯ���o��y�u���8���L8�9�M_�lΚ��qfp�r�Qb��剙�@�gF&�%;,��`ɊK{,Y�`igf�9gQ)�ņ��/6^�uaǅ�@.��bN�����s�l�=... �NDF      �      x�̽[SY�0�������D��;H�����n_��{�9'�C�F=BbT���'N`���Fc��0�2[�#6 ���	0"�/��\U��u�Dw�}N̴�J+s�2�r��K����Loj
����h ��f�*��A���}�h�v�=�߷��j2�h́f-�bh�\�_���Z#���"Ժ)J?�g���}�K���N����e�����pn<�Kk�6N��sC�q_�IrI�u?�����j�>�S��~� ?͜<��=X>����ҧ�^��-e�����Gٱ��wK�\������oe��e^̽�tg�#�����ѧ�\.�����[�,�5= �����r�������^|h/�j�=��->�>�8�~��d6���o2[�{���&�|��Uv�Wn�Y��w��_[FPӃ�o�V��hXk���ۋZS8��13��wt��T�:�)�`h�z(�=1���3���h'��۟�l��4"��V�Yӿ�~j�홶p�9�m�kw¦�G��aj��+U}��>M�?Mn~����?M=�4�N�4�E_�&�~�\���OS���§ɭO��g�lp���"i�e�~og�f�n��Z=�4�ШU
�<�?}ϧ�I�E1�*�T"������{;�;k;�;�g��8���M�,�,�&v��i�Ka�Ik;[�����N��o��e?�v��u��m���ۿ��W5���A���mƟ�Q#��}8ǷA�9�5�G�k}��ʁ�ȝ@����fD&"��j��R�ur�W��	_�7��n��c&	?�q��\c?H��_90�C�K�N"�;���~��r���~�~�v�S�C�aF��l+��R~�y�jD�z�?c 	O�� �5DU~8���K��Ɂ�<8�J{��{��a�1�����(�/��p������Ke�5m�nG[ܳ�k�բ������ 5�·hƊ	Ix��j��Л���ܥ9��'�����<�s�/^���E�5��#��ƅX�>��\����\־�xY�p�o�
d����5��&�%���#9���/�G]���J�F���p��kP+!g�p��Ws���Ƀ��NB�
���H���Jg����Q�x�;�����0|��ЭJ��,�u���>/��*(Z!] '`�����p��N�:������scK��>�*y_J�o	�а&O�� ����%�W�#��%�R�H��N�-度�ù7��;ʾ˙�N�y)�=w�%�H�Kv�.�V�B�K��z�t�xRˍ��'?/����9ՙ]?��8N%O����S���K�`?�ǯ:����H d�G�?�{
H�z	�p��&�}���V`��
/~hB�rp	g��Υw27�'.���Q�������r���W�����Or���<��>�<�Ȭ�g��2��1�B�A�C]G���a�C9�ө5m6���g�on���ޟ=��,���TD��	�+/M�A$����M�������ۗ��i\���L��~z�Z��M8����f���ץ��f�=���l�v^��JWm�<�$3�f^?<x��y��N6A8�f��'١GCK�ɑ��r��U��G�9��)= ~���`�u��+���(\3��zwfr&�L�s�G���qN���k> ����O�g�N���?��e{O�:��u���ր~v/��ױ��!��KW�]b�p=�K����!u�Q�B����u,�%>�u���n#���T"����b���Y��4��2�����xL�.�{-�ٻx�a�{B�8�KS��\����zk�ް�!#P�T�z�j/�I�=qۈ���K8��;�#�-�1h'�_At�kL�kf/>��آ]���{�co�A�o/޿��^糣Ϗ?�.�r5
kT�	3=r��/�Q!��$�7'���_Q\�4ٵg�b��R�7E	����'Ea�
!�&���S������T���E�Ff����f#BD���,��*��t��1��x��*?����lh-����h�ۦ��4!AaSo�K��+�Z�̲R�Y��,����-��t3j�7���	�~�֌�y��a����,lI2���,�,hI2�$�),I8����Ӣ��0��{^w��pDk�mO�h�hm+�XĶ�c���kR뒿��u	������x����ۏ.H�%�L22Y�.k���������� ��[]Nw�E�L����1\n���_YPۺ)����J$UV� ��]si7�`h{FD䃨*]��׀���~�h�䓂1�N�qr۶}�Eo�1�f���%P`?������N)⩪�Z�+�=�-^*6�?��#�f ���Ҵ+��/���h&���|{ց=!e��5�!%�������9����#�r����p��\�Õ�`�$��E��Q��k~�E�g�j�Z(�ZX��A_�CS� v��s_߰��J�U]\��׶{Hj��ʍk
�U]�
��+"g���J�u,pGE���(��\�4��i����9����H��g��T]P>tr\��V��+C�lw �'4v�ir��N�����d�)4/�z������t9^���X��tHÅ���e���ƨ�矦��ą���!�;UN�~H-7���/Y3�H��n.:�w:��c+M}#��=�,ݜ�/��B��ּ�n�]���G�vc���o���N��q��|��c=#��)ާ���� �)�!Z+�}'����D����+��1ZKL�FI$i|��g ��N�=Ј��GC��TP�Ma�Ҟ�L��i��4�}�g5�����s��Pv��^J�O���4�{"OA�.JP;��Ia���9�l�Q�>����n=<v�W~���K�#���t��mߕ���^!����2�[�I��w6v{�{d��G ?<l���r
-�y�(�Ezgsg�|�L N+�-+�����{:�F����%JS���0�8L*��l��_�3��RPm��x$3�y�����C�n�f!F� _�\}�h�0��e�i;���=�v�Y�MtBw ��β\zȜ��4�3 �,��"��Nr��tU�X f�J�N��;[�H�+�����\X7Z"\l����|���R,CaG1$���˜<��a5�� 4c;�
HO�'=���<��y��t�1 }����g��/v�/v~֠��λ�)EW%���`��
��iwygY��Z���:���|/�*�F�7�R�-,y�T�u���R.���U�g�5��sT=l�;�n�E��ԃ�[�?�J��~�U�-��ԙ�[�?�J}��U��sT%4����|*���oկrT��;�?��=�F�)��M����	w`CL�!��'����D�*���|;��f�i�9�s'��L�Y-��u�I�1:�E�)0{G�o �$�J/A#J�a}�8@�L��C�wD�7.��*ܕ �W#u/CT/����^皛���C�IÏ"�_
I���K"���g�H8r.�*`����h�����i��`�h�±�JP��	��Aʹ���4��k�ۼ�ʰ�t
�lC<���'���kl�xa��AZ;��9������Ey_���.xϕ�<=�"A%�P�p<����a	(O��@��������CW`�����Q	 Oxr�@�2��sc��u<>�N|���Ƞ7O�2�pV�xj�8J?O�>�zܣ�>�"�I��*.�9��I�Yhm���k'�N�<�����|��hπ��%4��i�a6�\0}^\F�����,�J���i3��e���'kG=�_��_��}6��ޔ��i�E\yg�'�+�٥�̃i	&9�;��C�xx�1/����X�++�}O�Ӱ���g�{���$X]Q�S����돇��2]S�y򕱓�|1 O�&���#?��`yzu��L�䩑c#췧=;ړy;��_�luM�e&�d�=��������D�B�{ ���'Jk0��lke�<!:���y�^����=��^�@N�.�pܸ2���ċ��;r�z�^i�A�UN�m�9g|	Y�����[��'J`�=��Q���?���^    �g��̃��>xb�q��*�����D�nm �I�ybu1�˻H ㉔�r{�_!O����$���^����LÌlW�����^<�t%O�?Y�����p:�^6MD��h��W���r�9X}���'n��>M肄�������JN�n����?�z��E�ߚ�@�.�*瀼�o�ݸ	��S.?��!�V
n������,O0��	(OՊ�Yv1���c?4�ZP����D��D�<�K�F<�X�����{H���1n�<��6�'q�I��T#@���̲���n�p�3�&���47�Cω6�H(������	�~�%�~�7�:�h{��@4,�T������2A4�2r+�$ ������0�;�3!2I�����ᖛ$mK��13D�1�VT1: үFLX��@��c��9@�:�sC[[$ rH[���4 +������m����q)�7Z�Z��I�4A�f}'��X�Ђ��!��0F�=@x��"����.JA ��`/�p 弶=��"8����j�v	"������뇹�Ś�����
'd&#@'� �P�i�#lg��d�L��7zZ�|��(m5Em�����n��5�ub��h�t��^yM��#�i\�i�e��o�M�����Cz�.AR��a;@<�1�����4��/]D����(s^`���S����颶��Ğd¶�O�����ħ�u%�V�a@ .b[�/�2��G;�9Y.VoɄ?�x��2z����UZ[T�OS��}�n.g�$�B8F�k����U���.�-7ͰKQtnX���>vQ�~����W$��Zk����~���ǛtӜ�����p]�3��J�X��HA�E�>8�Q���>���T�Y&	� v/���B#��Y� (hB/�:��J]i�!�e�%�FW��Z���ґ�bR��c�4^W���.ā&ɵ�VL��'��n�_w�.��A1��8N�&f4ySl��q�Q|�N��7��z%lY��Q�ۑ=ǝ��t˻ݸ[������kJ���	K�oQ�Y}��p�������%#�n�Z����P����J�i��3��e̃#>_|��ݹ�v��9^HҽBb.7¹p��E��%x�`pz�	>z�y8�"�x%��ϣ��(�Ή��_�>X�,���^�gև$��_Ylq����p�D3F�� �Z,~�^^U���41<&���������8<uQ&j�B/�Ez�]h���Ust��t{"{t��s?�Z�D��O��}FTSdDy)rD['ϰ͝%d`�	�io����֝8{gM#'@��}��V��Zw���tMQ�(X�&|�Y�5�Q]1D,�G�A�\��I�������ޓ�q3��W0�G�t��3�����l}���J���(�����s@���${ye1�D��Hz�~��4e���b]Xގ ��I�r޴�I��Gƭ�Z�ނ��,�������p��üX�y2�w���I�����(�K����b�?%
O_]QUb�t��^G޾�5|ƊO��� ���B���t|���S���}�E��h���'��^q^�*�d�����+�e���/{�y�a��5�2w;��h2�*��R��Q3�ݛDf:?q�Ԭ�@H�S.:��őq�*���8�K�~�'�|�
��MF�<b��A,��mJJ�;P���~	!��~����V*o�����Q����=|{%�bD��6�)p�#|�S��=��EeEE,��IG��:��
*�`@����k����}��cvq:;�#fW��T�C��*Ƅ*�w?3?"�S]lQLX�H��`�h�#¬j�`�P�(��E�dS �R@R[�m���S��P�-��X��G'�-oqz�+��Uw��l�H��_�)^�p��`�(`��$� �ܧh��u� �
 �c���B���� *U�p_�q0U
םQ���-�X��kW����"z��1I���1�:��5�jt~n�#Q-��&&�$�|v���r�׾ǂ,;i0�wZ��%f%��Lͤ.����GSǏ�@����_�t���0����W�-�:(�_;w���kוH|<rS�n�,�m�7����;��7�_lh����k�@}���7�K�*D@��h�҆� ��a�W��k2,�<����u���[��|So�;1?���g�
��X��hj	�}�j�]V"����16�Y�����:݉�;'��ҹ�T.1�vJ�W��q�yE�xua2B���8�`k�Nby���r�{��wZ�B�)�|�^��+�������� .���Fy��N�o�gg�4$��\��"��(�y��c������*s���xt4�w0ҙy4�����c:�}���n=�_�8Lud�O`��G:	W���|2�a�V�n��at�}D,�>���%H�����T�D ]gϝ�20�j�g��I`��t���U�GEX�X]��x��c|�<�I���`�����a���,!zl���S����i�q���~����(�@����H�����ϹX*<#E�5���E\�?�@�<e vncK|4�u�t^J5��u&P�j���X�Q�0�0�kR"�X^��._6-hh�cfT����D0��0�T��jn������W�r��Ex�_�!��2̼�� C p��a�Lø�h��]��
5Yo+��d\�"��]�2̲?�&�2�h�7��!�>�_��\K�RԊ�����% �D �#fe�1�'D&w��H��=c��.G,��Z�@�� ��m�DAM�s�Y�Mw����
e���cõ?5\�	�0L��
�ٴ"�x�'�sg��2�����=�M���),r��Z'�O
� �7�����@d[]��E�������o�ɗT$y��7:��]���N�,�2Ɍ�VR�.'k�&��Q�xz���G>�L�i�
e�f�o����|�`z]�!4����d5D%J$K#�^iq�1�2/s��w)�\�V�OJDT'06O��i����9�bN]��$�8��m������(�sG�����d��4����z������"�ȱ.j�&T�I��x���+�����������&�H^�X� �����k`��{���`�;��C��Y�,��Mt@�f� >���O���~�����Z� 78%'@�(& �3��B�H#<�2��$7��R>�C�������aXօ�k�&��y
�>�K�^�tr�,�)��w�DX/p�`!��$�K^_Y֌	<B���-�6��kx�:v"V��LJ�Ɵ���d.
�!�����dB㻃�l�9~�J�����Q���cG���4x�B[]m�P�/�V��&1u@S�B���������-�������NNA���&���~+j�ۙ��7ؿ�{��s�i{��%#X~�E����f��0C��+�l�k�s��[���h�f��=mQ4�jD@���$=���B�UW�*)�uCO_c:�\��yy.����q�����İ�=9�}^�<y��A���?�_ʍ�kX�d�><��j�2�R
"��*ݖ�Ŏ�-��W�bXl�(�%�k޼�F�(L��#O�'Ý��4�=~�s�v���0:x��)�#76|<5\��ˍ����!��+�D
�O��o:�5����9z�jN���`���,R��J�O�r��S�@#�&���WD�2{Mft�hM.��_Ie��Od�f_�NDz�p
3�쯵�t�Y�@���N4m�q�hbFRs���AZc)2�c�*���`4y:�l<���Y͎��<�g~��|����YA�ч�/��VW��|?��쯾Va��I�u=<�J)�d�g^�D��Tf���ഺ����>��g�oR�8�a��+�o��]�5�%x��ʫ _���^��^����z�ʗHP5�N�!�v���&$z�6�w�I�I� �FF�9�q�z�$C�$ՠ�G��D�MֻS�.Ep�MqjD�"�p�b4����>|�>�x���<� ���É�G��V|x{�r�[ z�������n2��'v	ˆ�X#3��^�J��,�.�i2    ���4����)Y���iˎ��)lRM�ֶ��G�'�ʆ�,����m�%�f�җÅ���te���fF�P̸��Ht�mS,.�C�jsyIhKҟݷ�pS�Mi�CK���]��Ϙ�(��i���tK�V� �U�� �+��^�:4��r��i��*�=��fy��5�ڋmjm�Zm��R��m2��Nw���M-:`�a�V��ڿ4��~3"L��jI�4R�٩�±;��.�,H!%
h/��"�]~JLUE�3 �а�i�q�@�z�$�}���o0q>�>��Ay^؞	��#e,�P���0��hYu̴i�1�9��f\r��CF�dZ��("�E��;;�t���'�����u>��������\��IO;��v͎u�s�� WTU�F��9��)��,&�@�%�z{!Y'�~�HZ ]���|���~Y����YI�?����m�*H��f�Y����6���h^x���𘚼rn٦��%�ʶ������R�~��J;"�{=�]���r�7���Z7��3�|`(3�؃��/V�Z�t�.�Bs�k�K3[6F��la�J�e[�W�y�¯�́�jhG�-���g4<�.d�Ӽ�d�DG��m�!��S�^A&*�}&�W,��R^n^_C5��"�7���S'F��p�2E�a�X`��P��h%1Mabi�M{�[� ֝g����＠�'�`*�s���ƺn!ڱ��UP���ښ
F��ivq@�i�{Up#t��bj�Y�3DA��ҍ)�U�O�������Kf���2����y8��!�x��y_�u^5�F
0�j�[g���w�������l�z�Т�����@���	l�Ц@�nyk,
c�ѻg���q@U�.��bQ���-�Zo�w)�jQ������^
^Sda�~��F��X�v�?w��F�š9S�w�zG�s�0d�4��fF�������͝<��ϋ�Z�;�T:������@����R�uE�)o*�"�/�R���ו�c&�̽���a6�ɑL�'8���ٷ���?f�	�R�]X�O١�É>��H;�����R&S��CrD��K�1D�pTUY
HH��g��sf��^"Βx���g�{0���i/�z#	낙�h�%E�Ð�&hA��p�ʉ����%��-T�:%E aJ��1����=j�q]ע�=����ι�DG0x��	�����OE�Î�XS ֬7�"'�3U���Ey����qJZh{�Ո��$ʋ��C�C���pȆ0�����Oe�9
�1���۔-S�S;s��²����nq�|�I�[X W*'X�0��#��,�B����W=����sڙ<��������!j�<]fI�]�Tb:�k"9iܭ�?�rJR
H�k�_ˤSjʊˑS�ͷZ"W��s�$��:��2�H;�Hnk����DDx����X��GJ���X┩~Պo_E���V{TWQ/�"*ݖ�� ��M a �)��YY��'P��1^��{X��N��N����*a��$0�4颊呈n��J�I���s����z�l���t=O�����gT�bM-�k�	͚���ҽ�������#}<D�t^ 1�G���*����7�y(��qhl��Bt��"��#g�ɮ��5�r�H����Q=��wN��V-ߤ��F줒��R�l2�x� qz�������|�����,`�ja�Q=x1t>����lr��G]#����n@���<UK<rD �<�En.����s�w]��p����i�څ��翾�� ���j>�?)�y������ݤ��L2��[�*䠂�z�4|'�#��U�O"$O�<;Q�R_�w��6����>M-O�!�����O �F9frB�$�<u�!'�<74xҙ:������Ƀ�;O�^^qb�%�<�z�������`.�!�D1�/�bi�B�Ӯ�[ �`"��'��,3 cP��V�$��4�a�f���t�Mvk�	�� p����ϩQt��u������_�O�J����V�~3�s+���uL���XB&B�̳�c�8����
���<�.�=虑 �$��E���2X�K"Q��|�ʖ�~��2 ��S��w�(~	$O�ޡ�X9�ζ��=��cV��A�Ӯ�up�צ�@�ы1	<O�*O%��'9�����O?<�Oe6��U�C����Q{���O�R�2��%z�7�lӁ��l����zo�;3?�q���)X{'B�d��F��\8z)�U��6ߐ�����$��O�9aٙ�G�_H�� 9��C����4�m�"������t�ӷ���i-$�����-�����ϾJ��K0r�c/����i��}�������y%<O�R�'�'Ko�f�P-<ǀ�t/����q���*���\�_Pn�~>��*�n�f���G
���Ő�|�=	8O��i�,�$fi�����A�D��Y��ыI��+T2˜/�F?J�����Y	�[��S��čҁ)bD�P@�V<�sG&�:2��p��{Lf�5Ì�2sܟ�5��?.�֩ǐ���R�?.���%?O�*�ɓ���d�]�ǥ�7�]��߮�h��.~s��?��&�(7H܊ ��I3�Լ=�-��H����I캰}��>�'%�����2�p$�a�*&�����W�(�?��E��(����N�/
���8����ce���G���0�(LP�\���X�1���(h� �k0��@u.Xd CT�DA��<W]Q�D���\uE�h�v��R �_��ڥ�ڹ�W���A�z�y>4��_�p���n!zNI����q����F�����R��PY�r���+
�F��X����0<�\���C���;e��Xb�ʻ���El'b�}��I�����mFvX
�Ă���������1���U��B���T�w��!�xII����^vw"AQР�گ<�n:�A)���A����ǎg��OzՕ�= 	8^T�)`�Q�글�||�:s-��M#NY!�L�T���8�-���s3��O����B�U�s{�|ö0�#g��O11Os�Ol�.� h�5� �_VÀe�\U��D��tO��r⧬d�"�b�'ĔD'��1������R���4��gUD�"F)w݃��F�
_(�5�xB����*u������ݮF��O��w�i�(y}~�$�)l�b���oJ�����Q�]MR|��8�Sz}	�V�z!�a���x��/Z��T0I/-���_<���(�>΃�`OF�ɣ���O���7;/v�$]TJ�fxKh=��)���� ��v/��X0jaj�"�:4[��=��t���A@^�D�r>��
���5���C��jx#ۤ�����w��qV�^��~وE#z�0B�kl�Ôv� %�&z�DD��*���X�bL yV;���}���ڭp�6���S��'.
�������K���|��$\�l����3-��U=�T����M9�J���u-�TI��ױtt꽖{�S�wL�S���Ct�7�.��q��w0�Z����㉷��(\|t�S�\g>��Sҽg�
kn)�`Zˍ��mԳ���5VLںae�)ר��(fL�咽u��>���=,? %�؄� 2>@ޠ5�39�u�g`0/z?/���|J�htO���u7^�b��G��Kdkb�У��27>�Kv��V���4F����e'�����}������\[s�����T���<3��V[Y�U	v27��(�T�����A�%���n��^uNLg&5�X|��Ps/�~<��H��{��o��i�R�����+³g8������X&�������\�W_ks��2��������S���Q����t���g����Me�#�͡�ӥ����>^��V|�{�x��x��I���ǆ�Y[=���u�+��X'���_ڏ���m�O?̮Md;�y�:�Vw?�~�='@�X�;%yoUEY��Ǟe�i�j�x�cy�	���Z�Ju�^� ��s�@�	��(�-#��C�oi�����ߋ��t�    ������B�Jv�l7�nb��L��=�_��AQ��{@S�ǝx󋅮S�=��L�|�Jv����6�۹dS�T2H�{.,��AbfD��݋����G˺�Nt��ߡ�}�A����q&����x���^�m֯E����]m?��(@�8е�'���C���3aEo���b1��V �Q�n������a���H l�+#a;������9�>��M���`A�����њbz�� ����`�Tb�-��l)��J~�C��&L`{QkՃg���:�������Fk��Z�o�]<��+9�9��S�)�n�~&a����T���a[Y{�q�炷c!�jF���Ÿq�Ѝ��4&�tH1����ɸ�߈�!e�j��q\��8��T`����e{��t�Z�n�U&Ҝ�¤�Q-B�x�l�*"��9ߍ�<sd���e��1k�����p��쪝�·[�bbw��e�C�b�p%���b�ez�c= ]Ĭ�٭#���ٯ$�FnV�X��q�0=F����s����*K�H���p��(�*~�l����ebٵ��Q��,�gz��k���z{��ԣ�S�\W�<L��E`�0Y�6��������i�Wkp���bR����ܮ9%���������2+0�Fˇ�oD����0�I�N�p�%���iO�ϧ�Ia�J�Л}7�(bwD��6�i��Y�y����I����_��1�j���]M���mj6Gs]�uI1ܽ��$�ݐ��)��ѻNX/�$d֎�zŢŨ.����Қ_��u]�ߗ�!)��^�*2�9{�&Y����)�q����S&oD��W�����S	�dbȳݓtgl�u�2QĭT)��+*��9M��wLj�a�W�:�
��I�^�L�n��x�F�ew�;��;wx5��B����c�1�ˇ�6 �
��w�[,��.#��?J�@ax�T�n�껳K@z�I�?�+\�Y���=d�J ����l���0`LϰzVc9���u�^�j��c��ݎ�� BH�R)lRt��N�e��{On��e*���(�-[��@]��k����L���u�M�0��%�1�r#)��f�G�4�{�_�&�G���}�2A!����I$I��42���dİb�[[��2i�]���c�]L���,�����S���,� >���Y�r��A�������2���`�
�WbQ|���</S18<�P�l��������X��RɰĂ��z��%����8Ѿ�����;�U�Ъ�|^|Zxs�0M�}5�o��l�n��w�Q�t!���pn8~��B��h,��sjSx?�;�Й_�Zam�w4�짓����$] �]��;0V����^�:�"Q���ǳ]���F�$�早^�LV������:�x���+���GsF�Fr�q�0�G:������S-�+��e�NNLg���h�ޞy�� ������3�������,�i�)h��3o���k0��X�$!�V�����HN(�ҽ�G�<����,
���#�����"�	Z������K���9�A�e�݅���;l�j±l�o�:2|���kk��~�*���'��������T6���pf����	��B�e�5�ǀ�c��a�ք
`l��_5�c�]G�[��p�]-��, ��8ئGtf��A�8�
!��2���Q�Q5yEQ�J�e,���b��H�kTt!��Lhᐉ'��!t'������l�W$�U�0��z�t�)D�f ��)���,�}�����L?MF~j�"�V{��/n�M�I�{�V~��~�$�aǾ� 	!�Q k5�dʰ��i����~���k�M�FeǠ��n�"��������>��e�0��ab�9���ti[:NJ�=����P�t�2Ӄ�	�
r%�ݶ/�[r��%4j�����ŗv@�뤫C?=�<~ %�JX��x�S�f�7�7"M�
3
�#W��:#T��c�Cī�+iCG����y��I#p:TS����D�u�g� ��\�����.(Xq�,ѱ)n��[%-�S�dG����:	�0�1Aڶ���:_�o����b���:_]):_�o�����:_ݯ���N��Օ���������|��P��%:_}):_�o����7�|��V���:_}):_�/��|������:��7��|��|�_���~;����t>�iu>_�:��E�������{t>�/����\����:��Z����:�������������������'�ɿ�?�KumEE��E�Hv�c�� >0�!?ʊ9Sɨ�΋�2��묶%9�I��[����h�{���H�9��.鑿��a��ׯ^j�����|/���X�-l���!�b4���T�C��cD(�H��Q���P��Th
�h�l��N�iRڻ6#�ˮcbw��+ܜ��kcC���kè(̉lbEkhv3hP#��0�h���ݎ����E1��2n�:A��8Ȁa��;�j���Q�j$pGg�֮��pܱ��|��6k�Ђ�릁�R�I�~3�����f�оֿ�	VUTV����4mB�"��	H`M`v�=y�@/�9����U܂'6�s�qm#����x�ܵ�Z�k�4��S˓5i�iP��_pd]'%kO�؎z:&f[�>�kw�~/|�����c���_h�\��uX�rq�\G�)-7��Q}�!�j�T̒��f��x��C{�I�v����6��^w�<�9�����"76쎰h����(��	�A���:N����s�V���v�0E髟�S\�����TJb��N#,����Ž� :~0e%�����{?�"ol�����?��逳�%���l�
ݟt�1�qW�f�냵Z��-.����8` �Ӗ�̚V�s:�%�uNϥ�\*�	�i�Faq+aR)X7+V0�������3��
9]�a�uDGE/P%O��=4�i�'
O�*)][i����p�B��� ��V�h�Iv�1��	���*��ʤ����TG��4@��c�s����9�G挟�ʬ�f&�7f��7F��b����y@1�ԽLz>�`Ǝ��_O�99�2?����W8X���C��l_N�����[h��9x�l�'��)�xv�܂�G����Yu����L�*z]{fT+�Jv��nf�:�Kw6��>��q�e�SH���%��hd��u<����[c���眚����u08���#l�[p,Y8:�]�O`�F����7k���F�!��I��t�f�0�<���`�o:��A >���#8�&N�Շ�+t�^|��̓{��Nfs/f��4��Z�ոC��	+C��9�t8��}�� ͪ
i��>�%�A�������A'Gzf�y��}&o��D>��u^�������!����:�?�a+0��ߜ�����r�>O�ǑП?�_���g�> (*���ҟ ��?쀡�>x�;a����v%?�{��l��{:ޅ��S����=@��8��w9���[�x�v�u�P>���,�4�����8|�Q'�����K{m��_<|��z����Q, ��!�0�7�[�����A�����cXFf��U�6:��[�ӷ�j���Y���o����畫����E�T�F�BS���7A[��Sf��9��uԇɉ�:��aK�h�UuJ�Ny���7��%�uul��p����f��@�7]n��ލ5�L�k�X2�p��P���1���T3�hd�K�Y�7Z����]*iM��F`�M����]�*�@7�T�  �����
��w����N�Dχc���9sT}�g���o\�`�ZI���1�vk8B�]Ք ϱNƊ���ǲ��΃NY����W�̲�F�6�[3��@	0m\n\����R��!:J�F˝vS�6�`_�9  F���v�� n���%���"@*�>�/�"fa3��0��]$� ήIo�ɢA��C���8m�Ղ�����-��)�f��+�.��i���h�ÈP8Z��t0���c�j��e3Y��y<KZ��8i8�m{u�j��j1�#�    U �L�����m*Ĩ�9F��v�����:wj��V������=c��X�ϭ�.Lon��kt~���!훰iY�A��P�Q���gP �� \�o&N\�n��`"6�f��p�����o� �|lO,B'r#JR K҉# �;����1\��|�2�Zq'�]�v ߞ!N���@Q(�f���=s�������$Lo�����`����a,�ǝ0�Q��:L�댝L�s����������İ�0!���-�����kҠ���P������y��\>:�pM��i���7�\o�B�y��Ἣ��}���{����=~��d��w���|I3Њ��O��$5��[�����mq��a�=�Y'w�}u9c[Pˮq�2>U�
d�(�KG�J�$�,-["o���B��Jڶ�,��o��O�Uഗvjҽ/�%EL���]Iҙق3Z+O����x�v��X�a������+�4�_	��7O�^��C���^��;^B�#,���ف^�N���-s�O�������a�m��dۓO^�^�@l^��Z�����[���Ȫ�y��`艇,f"J름L۱4i>y�Jy��0a׶�$a��U��	�v~�v�x҉�a+�����'Yd�3������Y�|ش���3:�]K�>-�/j�vӓ%H����ݴ��%����qF+q�u����d\M�=�9��am�p�i��@_�@9��Q��K'��t�6ʃ\0�٩��T61a��L�,{�.5r��9�$s�CR�ݠ�c��id���	Ȱg]2�ғX��ۏ�G�:�(��ЮJ�����}(d�򶥭��v�X&�N���(�v8�?�]��5�
L뮄oV�G;�I��б�L�@4�?h;?�b�cB�|},�k=�vbpϊ�Eă�{����,t�����2�YWak^�����W�g젖%Jge�éu�͝,�dUnuG�tP4�����ũ����vm7q� �Q;Ca�w�e%/���F(��.}���պj�Iܳ�`�K�}�������#Tڈ%�,���{�M�3(����W��E����&M��w�lu�
צ�V��Ђ���:Ql�\��֑��\t�Ƙ��i��ltl��l���寑]&�	!��c�����f%	č[�������,5�2n	���e�0Zg	$7�{fk�;�QX^Yp���k���Μ��|g�����{��Z]�~.h�����U,56�������V~����/^=�5|9��k|D���C���/7m@[��Q[Qش0����G<�J�5�5���@�d����S��u;�[X��.*��Э�f��Ҭ䒫�*��Z�PЁ�P�
���`�OF��Z*���&�|�(DFP,�����������í'���VV��:���[e�t�s���Ǫ�#@,.������<uE�`�aD��ǘ�irD�WR�'3%#%�u�3�Q�F�:-�$~��Hf�>;�������:n!za���mŕ*BH Sc�_��O?��t���HS��njw�&ML(��aV�����]����+�թ��)Y"�P2�%�/&�LJl�a�u{��e�Y�x�O7.6\�� @ɨ�Uݠ��@Z�GP���F�7����-Ʒ{4a��d�kV� +h+�Y��j6|,���k�$-4�ݸ�͹˂(��і���T�\��r��y%�l>}��nc��Ǩ R���
"���@"�jϸ�Av�Y��OI�|�9(#\1�6��peڎS�y��j�aE��6������%�>�;���t/1:Pr煰�>Y�(�U�՗����J���햨Sn�ʌF�zt;��Gx���j���m����:�%Ou�?�qb7>o73(b�M�ަ�ä�����
�!���~�z�=,Vu*��/�fϥ	��Zp.�J�_1;� R�Xe������c�ס��^��&���xn�\��s���X�s���
}U�K��w�Mk��Ɩ�N��0�Bh_�^qNitM�wϤr+��4���ʝ%ϩN��y�M R���'�������l=�O�ڊ�h
�6P�2����!�E�ZF���Ħ"-����+�e]Ebv
7JF�Y}��_�����WK�|2"~]��|=� ��a������dמ��S��X�Г���L�(���w�����(@���ӫ.>��=�� Y�Rg����( )�5*��������ь7���`���P��ŠJj�L6b�z�-�a���*d�Ե��bS��6%򺮲�����4Z��8~�2���S̡���vW��T������6�lf�����zȴt�;)�~�`N3�	�CWb��H�t�[ n�����%�+�8��ZwTKizN��S�NMݮ�d���ŤU��Pg5�>��`ug&�RȔ������͛mK��O�S,�#��b��Z�\��|����b)x��Z�w���%�P�V��w�eŝ+�U�Y�W�Pw���3hӖ9M�r>�3���d�$#�}�y�Һ��Hx��T��.d>G��S�	is	��0��AFl+r��<gWB[R�g�J-�b�0�������Mm��o�2j��M�# ֗]�!��φn.Su��)��Zhm�	T�2��t��a�l��� Z�-�b�"�7z��c?+wr�n����a�W#�[�����������p����
7����T~0���H��µ����?p�*�F[�j�8�kF4a��D���?��~�PV�Q���I�a��%QU�A�~������j7�K�v1Ԅ:w��a��i6|�����jwFsZ���m�h��\w5��$vq�y���P;��ӡ�É�rf�E/����8s��S *{�����G*^�{&~���/Jg�!y/�`�|?�h?=��8��1���%0�b��ab�<3�ķwd�	��D^8��Tf�cy�k�`�y�Q{���O���℅�������x����PyjJ�s�����<��O=�<x��'_w��+�K���<g&�ZBE�æ���L��R���Ⳍ��i�s|�P��(�ϿV<;�STMmQ����G{�4��'V�3����v��-��*lC]Q��c�.���rF��똥J�C<Z^�ˉC��%^�%^[��8��$��W��e?�V1���l�{�h�xl�SS &�
|��$��/�%֨��=Z���|��<�_Y��EF���"��V(H4�� ���+��B7��8y�Sή�(���zndP;���ZD�	��{�e��q��
)&
]������x��D�����ܫn�W=�,ύwR@�P��GWS�>���@nt��d��O�Or�yD��AN������T�<�4u����0��℈;�2�y��ҡ�l�u�c�?5!�&�����0��s��7u��ok����.�amz|_>��r �ڰ�G,��JŊS���!A�5�\a:(�F����.'牏�y�x��(H�v���M�[�����,J��*B#!��rV�r����8��I.5�o'F>XZq��̱˯Z]UQ�eNNﭘ��|��;�8t��A�򒫎C�i{���h ���h�G����3.'��#���`�?����~+]�u?bu�a�?�>>�#NZ�|��3�2���Q�]֞�E��2NY��e�rx���a�@8�3yO�A�.�:���'m΁܀�|�?ဤg"ۆ�Ї?��mۋ��a���M?���N@��`G#]��"g#���0D�d��]������z�p��zD��6j�~�"�/�tdڧ�;���b�*�p�J<���\��b(\��/����U��Y��Ⱥ��#��魁�ju>zDX��_p>2ˮ��/@
��&���{��NByDr_�s0�sUu0�Y�Cz��M��-��Aw��	O����L���a�d4����	���nQ�R�t�ks���� �v��Cy#�0���,ai')
�
E�g���:xT��<J_	�)LgD��� A+���D�A��Y�˵���0#G���?�#9J�>�y�� �A�N[dM���l�&���,����<s���F�Tq�!%�!G��v����E    �y<p�*|N�ͷӬB9�����$���<��G8�v�5�eۅ�]9�.ܷ�m,;E&6�����g;;�S�۹�ٛ˅�dC�^K;�	i��p�I�+���e9��O[��1�Ԥ#5�ŏ��#���8�V�0��+0��םH�a��a� �����O�4�9ڃqX�3���͚Q�
�yƉ�y�]X��>����_u���n�Z�j�]�1���s���]R��>�S��E<�P���'�d7ա��r�O�SI��
����I�c��r-5� ��T'e,y�~��������ëV�}Ct�/;��hhi��d�rLG��������A�Ifrd�<��jT��u����H���^v'z�?����Mf~�n����e�'h��ܣKz: ������'����{�e��U����q4c8��6ی��E�<��"�1�4D��t�K���Ķ�b�2LX�D�a^��ma�թ�W��+��Ns{��p,���ʵ0�d?��z�g���P�w�'���u���W�Q��I�U����sm���yC���vN�\`�����S����Թ�;���ݷ��~����$�����Q�>�ҙi�Dp��/�)%����
b�ʂ�}(�,��l�9ϿT�Wԗ��'�1���,��O����{�SOw�n�?�}���ZP�%�L��*[�����{@ʮ���x|��0�?z�y8��p(�Nfj�hr��e^%��F�^ ��������?b=�����N��N�:�eHyO�@�{���c�W��:9O*X:�v���Y4(��M?wK����SY�q�5�4"w�_#�ڀs1�h>��Y�1�'SL$p8�X�0J1�HT�_Y��Ux��1�F X�v���z�B���p,pF�G�w��.�#DT�W����%8l���Y[�&�H�K0�`�]�{�g�z�-?�1}���U�����ڄ7��3�4��G���b����ڗ����J���l@)�V�yv��+̌��a-(0��Yeņ �UG9���Ǆ�v���N�OԔ���.��L8�7ƶh�%��71�6�+z�-y4�����G����t�M�2$R}I �@�q�����\��3Ce�����������պ��E����U��dU��^�k,=����p,ج�wp+�C�����+�_�+*�oG�]J��Q;a��lW�^(y�ف�'����<�v))�9���oc�Q�2����	��}�� ��=3��`��`��ϳ�T�]�W��/�~]�ؘ�V
���ٞv�$��&
��lv���5J��H�@u�78��ѓ0�K�A�+樂�6���1��*��$u^��P.t��o���¥9�t1�ay@��¡�p d�5�0U)���� �}�PS��V=
Q�{43��e����}(��o>��p(B%P�/3\�t]�)�95C���44Pز���nD�N1_8Y��������� /�j�����8��#��wo�jA�R��Q��{0I�%���}���B`�a�J�^`�n�����Qj��tro�k\'���\��^)B�6��dn$%����|����9r�����z?��9��h���^�e�5��c�QVRA���
������+�����VX*J��3&��=pήMPJ���*�~:�T-�o�����^�q�t���w�r�1�(o����n'�h&�o���\�;�N��#����3���o���G��)7Bq}�����x!�����ƣ��M4$�����|��Xq{�"C������BE ��j;Q)�}l�}2�>�5���>5�!rͫ���eh�a�RК`%
��?|Ջ9)���0� ��}BȠ���t�7�,����6�<���"���I���ۼ^Ԡ�B�Q=��Kţ�g{����H$l�����E�S��f��)?���tiS�K�V�ui�֥�j+�ʴYv)vWS����2��//c��P������ZM����k� ]�qo���o}��b�v��n4L����F��w�Sx!���xt�؁ꦵx#����2����)L���؉J�ȠVy��N4w�w/��D�V�woc��
�7*ЫT���кB'*;ɡh5"�����y\!f��A?�8�+��Q�C ��TgOBA�=�
�ʟ+���^���VO�J��ǔ���߇H̕|�hw���{���Д5��8d�#O[颬��=���uI�H�j�Һ�q*/����)��WZf9'�ش��\Vg�*���MѬ�R|�s�sE5��k%�s�B�寪�@�n˂7R�C��A�N�at��k�tc��<�ک�F��s�[�T~�?MR��-ӂ@�F�T��`�պq���^$�e;w:�1�9���O�yom�3����,�Q>OG��E5h2x�Oْ]�k_qa����D�R��ޠ/��T�R��O�9��Tes���g:�K�$�\}��#
�j����WH�EG_Q��^��f�b�)Tc�Y�'*�t�^�%洢֑޷RӈO�#n�e�'S����0◫�d�1���pa����2���"���pQ�H�[��0<)l�_�+L#~Q/V�FȐ��A��I�p�W*�tl�G�2���v�qm�
0W�Y��2��*
i�y��fw�cM#s�L#���J/3�`͢v_�B�U�E|��k�o�!L%������O�k[���W��_���WS�����W!�Oi%����k%p�4O���(l����C��-�>��w=��/�&�o�BT�o����{ڶ.���O�v�·qC���W)S�� #Z�|�r�[�+_�Z�+b��UR�J4v�+�����1u�:(ռ�T�kr�R���Z�J����FaB�UI�6�im|[��f�)L[��Z[AӖ����VĴ�oCUq��,k0�"��:�Jn��U�T8���W%�q���{��J�^ڞ��[MH����H�e��������Q�j�WĔ�.�����k
���6-n߫�*r4��	kX�U�W�P�V-_���9�b�,���+�Z�j��g�-��|�2%��'������ڠ�d�H�j����,_M!��74f��c�#���|5E�N']?+������ܮ)1[Ь�Q(���Z�QoU��~�Uf-_�R��r�0�jd�WȨ嫑+�vieUj��d�������÷�s��$�~�U�WST9��V-_�BcV[�|���U=���3I��}����w)��\<�|���@�Un�Cm�����9��k�T�����*ei�c��wyT�*�
�����<W����q�����x����v�Q��Z+m�q�fr��6�@���dP��7��? ��M����0���^}��W)�͟��Ֆ@0����S��'Cp�2u ��� �=���e�/Ӕ�@_5@��k3�����A_��G*�|� }-f��fP ����ǵ�"8���G��k�x]���k_!,�د�Q��CM<t�t�i��@7���r.��yx/�a�O��Q�6D��8��	S:zL�L_�z���Q�5�q�k^/�v��>K���ͷ�X��C��7����`}4��s�	��M�'��O�R�@��Iǘ��ģ�8�*��S��j��0�ᩗ�(�@��������q����9\J�( �Ʉ�����('�O�
 ǤBnl�xe�S��R'��e2�$�y�j�$ٮ��8����c�
A
��	���O8��hg.�̓K!J gR!7�>��Ԏ_N����R��b��X��Fn�0���JE���I���(��� +�( �I�����g?�LZ�xR���������i�;�'�_EA�x��DZ��ڏ�-��U
��7}s �R�����U��׵�����d�����c�m]136��0`ե�����OG/�2+��{��3�K�3�8��� �;����x`)�!�����3]<�����1zv�NJn�� �=;4%��29�1&?�_�l�f�7���^p�R��<�ﯮfS?��
5�o e��y�Bk���7-m�� ��{��`c(�� Ȥ������0�>z>#.�_*Ր��qvv1�y�    �u��C˵�FZp�ՇS[�oz���3�2���
25 ��K`j��O�>X}��L�1�s0~)_�Ucq���Ŵ{���+��Ӊ��B��h��x�1��Ǐ�G���t<�}�L� �T� 4{�ܴ������u��hQ, 2K,�_$w�7<�\Y� �L2�u�����A���@���ܻǃJ���2�`{���uR������F*QJ �����_!��(% �I	+k�BXv�tDY8���U��j��ohK�@*,Qb [b<Χ�s30&A�TX�� Lt�jv�X5���<�6�H��dA��3��[<���bp� �%��uy`���Q�(�I�N���JW�pL~�b��0�k��h_��N���b���1cRkQ��L4`�UΆ�F��c�/('0G����b0,�MJ�d:0-qa{1���M,
��ԍ�i�h��#�L��_%�P2#�����Ҿ��¡����&�Lی`�a��!�s�t$#�iI	4hM-X�x$�i��k����А�K$YLǂp3�"1��ᯒJH2��P�k8�e��Ȋ �KE#�LǄ���`���d��*c#-:��z �Ҧo����

@��K��J�-3B��J�e^D�
q�c�`��CWJ{w���3,9�AC�y�*3b�3=�A8`6#�� ЖHY�~@�l�	�X]ؤȯF�c��[�]���󸔶E@c	2,jz��L$ФB<
�����J#@q�A�tZ��1���¡�64��J#n='�ޕ&F���C�A���(���݊Ɉ0�QH�_�42�[J4	bb{����k��F@�$%�_��_�46��b�v(�J�5�͍��(��x_��I�;�o_�ר,���XBnl���Wm��BEg�M-����+�!�l�7?:����ǲ�|`�.��RvEs;eV>�x�:����)lפ���_��4IU*�a��Z��3	E��R���M�9�i���;��T�@'YTa;�RY��JC(@3�eWӞu��3�0�i��4
ؘ(�4��.��N8��pȝ��Pi,�L�QI�v���,e�Ji8TL��E��v���S�!D8�H�ǩ��N&�X�p�\��e��G�4�*&Y�u�m���n�+����
�l����.��4kk��o�]� 9�JK,�^#�n�"�������n��\\պ��Y@��b�%�] ��<ģPiyo Ln��Y���PM��Na���U��YNg+g/<�T�]��n��:V%�J�Xn�=� ��Y���q|'�����+���|�Xŝ���duJ�0`g�qg�J��S���L�Vg�<
p]�y�J�1�er'	KѾ#l��x�L8<�l ��:�V�G��'*&w&A �-,�n-�2e�F���#�d�qg�%��Yqj�GZ�>���Șh��y-!g��`z��fs�Fh@Ǥ��8��;it��=��Pi��L6�d7)�t~|�!n����" crqg�|K6v�a
���:��U��|�DF�pg�Jɧ���vV���mـ�(Ŗ�l�E��H�%�wҫ�(Un����v1j��ʬtT���$9}<0��$�b݄|ф|�˫F��W!�s�	]��N���R
])@7�Q����޻57ue����~��/_C���k�tф�9'6��ɣ�X�,��$�ɒm0�`06`�6#�m|����?Hm[�`Q�g�1�\k^����շO��՛�k�1�m̱��d���	��7e��jП��uɚ���������G@~�=2"�i�Nt��wq\X�8z�ب~�n�'O�[�ם���D�F HɄ�I�+�^w"7���l�΅e��xsbo��Q����[�%Wl9Ǯ�+~������KKFL-�/^�K��)7���Y*
]	�U���J�6��FW0�b�Bj�,�<-]{��r����w�g��g[5ŬYå�7F�j4
��ٍ�u#t5�X����g��!�	��?wq�X�0���~�4Q�Y����Z��74��WK���x���_V�]��qg��:�M6B	�F��BB�`,A���~B��2IZw��"w0S���������s#t5B�價��#!TX+V���
E#��DKP��!Z�����N�>MO5����~Q~h8��Ѣ
��� �[�%�ڈ6�q���bY �'�$R��\��[ ��!'���H5�%]J���w��<mDQ�j10��4��l4�DG�9�rO��O!S�dU�%������FD�P0,,�����>Y�V��a��|�uSa�\��!�
�r�桄�ɰ"A�h����͙����s�t*K)���F�	�_�F�V#o���6gN��34ÿ	G5��B�g�R��A��\��̄#��Aa��@��6Y�?����!S2�ks�w�HO�j�Y�d����[��9�BiZ7H�6�l��� R�_��?�9��jg'~�Z�[/�@�
#��U;|����G�À8��"R5I��F��b��khlF
��|aDrZ8�"��_�p"x��,�C_�OU�O��y���7vP˙b�ʫ���Hc�/���X��b��iÎfqTA^@�3��ڡcua��ф�>N�g�������q{{�,k>U 2�H%-�����X���6V;NXN�/���򌸪+������-bԖW���F!1:��Q��+�NF|!�Ũ��A��!i�
��Ƚ���ހ:�m���������ߠ�<��(�a�Ϊ��h#b�BJWVlՎN�jT�w:��������+��#L��2X��A~�H9��H��h�z�H��LH�^-Ru����T<p�_'xf�v�H�J_M�o�:|��Lxj�X��A�����U�S��F��	I�E�N~`B~����$@J�l��@�}_}}�9v���<������߯�~z�n�Át�|͑)93��fCU��!]�O�/s*�}{�����xo�o���4�P��kb���E���?;��A��/E�~Z�jOv�.�^z�Ǫ���%WK	��F�������_�1����|�~����*>��	�k~�B�1�x�)�dc���#'��|l���l]a?\m�������ءΧG�Ͼ>�١�'��z�3ݴ�
��A*�#��zj2�D��}ar�4��D�+�W��TI0ȭ�z���R�-���0�f�	�߷ugk�!�"��n�B�|�u�!?lM�7���#������L��gXE�8�?-�j����,Y�%�h�%�T1�Y0�ʽJ�V������������"��
�"���]�/\��`�#��ژ���-��"p�n�t��w�:i�:�-�^@���z,��
x��c��O )���~j�P��Q?=�;� �֪����,�ҏ�ګP���*�9���K:C5�g@m�!��x��*�5��,�ch�u��#J4�64U��m6��14���`��S]���}��Q�DLH�I7����/����+�I/$P 5��9H�2�9N@�2�[��� m$3�� i���(>t��HGa�X#��¯8#�Df
�F
������!@���yS،D�;�TFʫ��F@`$��I/F"�Q ��P
��2������	�F���#�)���2�xZ�Rq��I���
(�t��H�6�m��&��VC2'�F*	�@��c�F���%@��w8����\�dFrO>%@��J��H��90h#�/�0�ah� l$ĪQu#9��P� g�H����[@g��*��p#�VOC$`0h�L'#�֘�@@c�հ(i�H��ѓ��FG��H���c_@h���ql��R�S<�� d�G[��H�U�W�t�E��a���� X1�U 6R����w�YȌ��P�6d�Da#�'$
���4��dUNK"`2f�L#�V�q)�?(�7�1�fk���ckT��{y�����^K�8���^CR*���nOJ�*�0�zB� C����Ǻ�����!�|
��:��A% ��ސԘ�S@��    @N�'�5�������/T��PH�A��SaZ�giM6"�hEaHD ����*���O�!۫L�n,f����k�U�Be��ͣ��r|� � hQL�F�� �l�P=��f���)@�X LA�X�Lw��$�8�t3�/]ϋ�AO��0�u�C��.+�58	!�,������(bE�QW�~�L0j���r��1����o�����6U)A6�Hpd7��Rg���=*l�VO���CE�lE��McD���E�A�8Y	�~�LI�
K�M-f\6�ܪ���t�����M'D}�^�?r�S�U�鴩�"���:��%;�nӉTÃ�3A���Xx�N�>B0o/� ��L2n�J��qOt�3�	/��=�^P��ԟ�N�m�'���S�=�&l2�z����#'��:N���>ߍ�eݮ������4��Ɠ ���G��̂�ń���2���ū�#����N���R����>.�C#t����3��[G�ս͠Ѻ��x(�����du�z��k�έ� h�k���h�#���aC�eҧI7-�R�]�d"{�T�!4�����BNDVO�~�9�qt©�W���g
4�X�8:	Ϝ��y�ܛ�?�|(��H�q*hNLc��뀇�eV��iY����o��Ȇ�ڡ$33�X��f �<�c����<a���i ��=���~d�0�,�a��{O���eF�K@�X=B� �^���P�;Q.L���T�R�������h��|췵!xջ��V|7;V~11����{gc�42����~k�H�N�Y��l���,��q�4)��t�b� Q���|s[�a!&�	A�f�p:T����7_�+,�p�d(��T�b�� !�����~Y��?���]���s�H�+XV|�K����ɗF�x�l��<' W�K��Й�2^��z�j�J��؝���pU#L�ziF�R��oЩR�7��������4
����p����חF.�/�XWL�P��4��Z��sE�}�׶S1�r��{3L��j '�v�sn��o:��8�ә�G%�8�}���6��o\s�R"��]H��N�~����M�%P�;om������ÌC�}�3�A��"�-����+����b�)��[E����ǡ�[[ǥI���{3�&�JQ�6�"�T�����K��sg�*6<f�ޙ8}JP"I��,�څ(���: �N����i7�D���#tFۍ�h[�ƙ1�������tҦUC3��\�O���Nو�I�p�g�m57�ޛA���xO蛷�K�oCܽP%o!��Bټf�#`�ʗ.�_wϯS��Yum�i$������ �@�Gѹ���;��r���%�F�[�/��º��֖� e��HK�.��r�J������9��Ӿ:hC��o^��.�(v8g�}�c����hԳ�e0��gQ���$/��Fd�©����A�C�����8�O�	��%�@��z`�\=��@3�z�M��fȐ㎱�Ps���@�eC�����g�!DSCUR�~���������i�۞��� �i����ޔ=�޷WX�S�Q�OH�*��*�NesM�k�n�|{��bC\�<*�#3�4Z����S�E���E8���f�֖+��,��UIP$�-�Z����]T�?7]�4���@iSې�S�D��@=���"�mC[���?R3~�9t����,miu�~�S����
HK����7m?�pR��ֵ��O��Ƴ9�o�q�9��\�i�K��纱[�=�|�?�Z�)B��OthJ��/��R�x�9�I{�C���Q�D�ڙ�����S(-�u��JsT�׷�8���ߎ�W��ą��;̓]�w��7�"�V�����3��5`��&�� �6e���mb�/�D"v;h����0��E�G	�v�,�[48�l��摀H9B���yy�ڢ:E�ք"?,<�L�ֱ�I+B����{���V�:=�ք?�?��9�����	�I#HC��8_�W7K�Hb��?��胭�n?��1S@��W�Ӣ�#D�b�Ү�L����x�P���S5���F�`��54�.�#���#�Èx���������b����֤�@�m��28)7m2�9��
���o~xY�A��A��{�,���?;��K���7d��5��DNZ"/�^��Һ- rҊy��qi��*Ҡ9iM��4s��x�ݥ���&��8!4���Y��4�J4Ng�~����K���/h���(�1��Q��J�F3]C��g�˿�F��y;3Pv,�$R�ly�5��������;++r�#qðx���7���Z~�&P6�����Gd�.��<��FLdm_ϑ��/��^�T�*d������ ]Y�q, ��㜤��>ڨ�4im!�hS@Ҥ'�J�f��Ik��˯
��h$M@��_�>W�J$M���жq�d�7��{=\�B�EI�y�M!r��c��]��L�`]��X��DCd�W��""���M�H䨤�U�O�OU��Ō��9�"�`�O�`����l�ܠI�y���WZ�f���g*��ZLdmF,dkU�Z��/]Z&N�Zn�&�P���x���	ڣt;}��D�c"tZi5������w��eh����a{b�UJh�eh���I:�<'�d-I;�2�l���D�VȾ�I����/1��Ү�"A��(dN�}�L�@�-���d����Eh�b13��f��=�|U0���l�^{.����B�B���EMb:�Z:In�JۘQN���=2�z����ڂ45�rz����k��2�ps<���,(W�X���H�JW��F�;�����py$m	�Cެ����#8bt���y��1�,�IcB���� i�{�M���&�t߬�A%��v�v��#&�>8ٛ��Y��#b#���
�,"��:
��  [l�G��B�2�5�R�q���(��n�$���x"� o���Ll���"�w�ע�J�ufϕ�µ�3����E��ty3Z�Ss�Ã�h�{<����<� �A�A�Ǳ~�S�n��� �L��vj�u6M9�F��_l	:���i_ԇ+_oI��� �1Z7���������9���j�#�r�Z�0Sa�)��m8P�36U�O�1]�t?�l!B�V�-���9hdX�a��0��ܞyB�<j�/��5���y�eB��4��o	��mJ6ްe#B Z�#�f���2��wMb�}<Xh�y4����<��c������k̇�[�	��pA'P�o�!��o-�(NQ��vH�!\�	,9�_�[����59�[��Ib�f��~[���A5�
*�6O0��/��P��E�(��	9�,���0h�dLK� ��y����ȃ9�'����r����?��Ʋ�m)l�͢�ɞa�����`ݠ��ue���&����ά  ���}^5�
 T�,��*�����Z|{��j�6Q{ Mo�u�޴���H �����re �:����[��4���K|�"�Su��A5GC�]�acu���:w(�3�"-t��m�H��(�lg�s�{��!�	���(������房;rBi�$4�*���k�a�i��(=��ߛ��xi�yc��k�:v�8��l���x���+!n10�(M[M�����v��Vڷ��L�x�,��>ʗ�_�,�쬜�}ssg��Z��t��X��C�+$5���ګ�GJ˨i��)xm;?���7��a=*8 ¼���T��.�L&���;��+r�[���q���UZ7�&�����>E��t��@�'����s �T{�;���&�;��`cȟ���l�Z��L��L��^�yYi�b�oO��H�i�P�R���Ǚ?`t%r�	�����:�3g7gR�B8�X�E��8t������FLC����RZFLc��3���6o��MB}��yb�}9�w�����c#�)
ʀ�@Qh��1A�ȣ����/�
@̴(�>p�R@M�#�,Σ�0������o    ��^��7��@�Uk���������+� �N��8]��Q�6�fJ�.�[�(�	�w�K��t�ˏ�;�t�i̒�����W���E�5 >D���k�i<��'}�a�}_~Y���ߑ��/#j}����FT�[;2HQ�
�>�!C�ۡ�߆��������M��Մ�̍���;"u�j��%|��Cb��)C,dI�|�W)�T��1t1a4�{ŉp$M�����{0��ٸx�i��I/^��?-���{s��@aD�ˁ���fz�2�p
Kգ��ZO5<�U��4;T���LwF��7�O�`��$~���dY�!�}~�*�����!�(����j��?�Ʌ�w7WT�C�="�X83�"llf������%��H ���D��KI;-c	厠�n�,�N2鞁x
�૰G��v;����Q�v:��RIR���<��퍔

��޸�t2.]���jP�F��q��'���*�s�N�>*�(��!��+�go��e�X��S4���H�\������<L�6K3 yBzc�u�Ћ6H0Nu��b�Y89�U�$��;h�J伏�����2�^�5O��L�6�(�ɟ{�.���R��� O�Z�u����Azqؙ`J�ɓ'�|;H�А酟	)TѸ����q1e�S"a�=s�m>4�p^Sh!@K]��xªp��~H�!%NpI���f�q	 mU��p�	l�:��:X�v�!����6@�SniP��HǠ�F�e�x�FG�� ����9� p���OtQ÷�d�%t�o\|�:�.|���)(��G��IP�q'�����W���q�Rx����?{>��W�U��@�cm�m%����!�����0����8��=DF�ч����ټ�Jx��K߫��;N�o�)\�2�P�P�?���<H����=*��:�V� ����x	�}�u@�O�hqT�ճ��:*���C�b���Ҟ�w��[�/��K+��**��q��	8�hg�Xza��Jn��)�.O\.]�o�W)O�<�Z������[U��:tH�� i�ti�X/j#�?�Ό�l�7�E�.T��7/ ���4����d(�'��d?ׯ�^�*)�5�A�Zx����{�������w}��iS�Q�[p����l�va�j׶�,*}�;�㢹D����Ks�0�dk��`*��nI��p:A�Re�N���G4m�@���+ꑯ��#�a�S�X��zu_$���?�H��������Q<��6 ҿ��Wԫ;�L��Ӟ�w$OS�J�ʷ�t�&����z�}ҍ���TjV�~���#_�<b�T	W��mΜ���F�7~S1�^PuzQ	��np�ٜ�?6g�*����%��dM̠*˅��e6g��D.�~l������O��6`PiV�hpՉwc��?rԁ��s�'"����o�~{�+]zjjP)6�ɴ�J�&����!� �U���{R5}��,����S�˃��.]:]�H���om�Vρ@-l	V��e!�U^ĥS}��针HU�� ����t�:�P�GE&3~+P÷g�<G7рV=F!aX=<ծ�B<+���zd�(�������v��d�!F}��q�i�}���e��(v]\�0=f����:�zh�����.������.4Eu�I�;ś�m�h!|x�V��3 WO�L���>��	��p��
b�-�m���`�L+U��2<�u{ktK������,�w=��&��h
��,|�?�@�ƺT:+j�3i"�4��oKd�l<��*�Mu��a�8J�l�HHR��t.xӯ韶�`�&�H�+�1�[n���s_��R����کu��qgR���i�M��O�H��N�D9M��܄k�wz�e��\z^��Ｙ_οPZ�����ayxdg�6��B���ʽ��=��/;`��.ݻRZ*���+͚�u��N�P�6k梉���Ҥ�_q@�T�/�(MZ�u�t�7J�U\m�򲹿"w�+r#�noB�&�n��B'��sLe��k`��� �E�9<�s������z%4�T�Ȣ���H` +9f# Oh�k�-l�ѿ�x�_�4����lZ������!M[@}��S�q+���2/�Mm���Έ�A��4�R^��JS~#��μz7_Tjފ7V�Ě#�� �����q�V*Y�N��\{��篕V&�M)}⢨��]W���I%.�҉��q�p�����]T����(�ne�J���ʃ5�29��j^i�F�[m��`X�X��)��s��p_ep��+(=�D��ZVn*C���|�i�z����^i��Tz���J�Fu��hQ�J�&���'�����K*�f�ށ�L~���
D,���w܁�m����ot���+����;6g���^�cR���o�av�6�Ik���]�ۙ�`d�&�H�/�Ng��A.�%0��1����0�n�����E���3P�Vh�7����ֈ:ъ�,�}3��u�;~/��	�\�z,-t��W�~1I��H�^��~������=�ׇSJ��|�q �x�(^\�ѓj
J��pmҮ����y�����AZgFc[ħ��z\�1{T��3��P b>9{I/���7�w��2�FJ-�In��H>��D�e�?�k�B�W����Ez+�k�/��)�X�W�7��J���>���8�U�Wam-�nЁ��R�/�ҲU�h>�m�P}��5�8�i��.,X]�^�Ħ��N���<e=����q]ө�S iFAQɇm��ђE,T�>�و.Ն�/� z�>Q�IiK���;�����E��{"u&H�O.n���`7}w��!��H�C�矹�ʋ�� �a��L:s�jy��ܬ�p.��ԃ��8�e��dl-:����P��`ɟ��i�0�6�I5��9�<�]p����\en�\E}$<��	�%��~K��;���0y��}G����D-T��*K��f�+c#���������L<�X�	��K`��d��� �:?�w�*YZ=����@�'�,���pMT�ed���U'5;���8�ʭm6�>RC�v	G[8��<:�wm�m1��C�>�F�+cA��~��aw��[`������/��Q�ni�L3�H�	��K`�P����KW���p�t-_�y�����2Ş��K j5ъ�4]�a Q�T���d*��;�������@�G,	�%��pʀ!\�)O\�[YUЯ�������B
pk�q��������o����=y�QX!��#HJ.���U t�}���P�ѧ�����s*��4z"<q�n�U�พ�!��t����nbr����cn�^��2S=�7��#�b��#��:��%dM���7���H��.���/URi.�lz o�Ӟ#{�v�N2�9`0�њ�Z&�������L\����Z�<A r�F�������d�?a�2.�4(�(�2�Kxo}�����N�3�Ә��s�K�Ƒj)�%�*r�W���'��yN��?���8
����ak���T�ⴋ��	BX��Y�R.SVc5�ZM�-��֘�A�%��Bv�����0&��Fې�[BS�lm���	���|�6U���|9&I�d�B����qi�@)��挫X�M��	K�#k�R�BP��G�&��{�p���G&K�L�M��x5ӵ.�#h�Uxe	)���l)��i�f=��M��oM�-a�Q��=i�%�5]�HNl\(C��"M����VS�K�5Y����=�{W<�k�Ӥ�,���N����d4����xL���ͽZ4.Q���#��/�L���.Ki	I�U$�	���E`J����0��N �4z @�W2`�w�L-��%�5]\2ቦ�1��&�Xu�"�C��ԡ�ZջPƚ�Z�S�n�� �<5{R[��|��S��1@�
�bT��cn�|3R4tU|�oD<-�I���*!	��	�Y7	[�u���g��� �QI�ॄ(* "�>�%:͘��� b�"�oy	�B��    "�~�&�p�\	G�؆#���g�T<?�����ˣ"<�f%5���P�K�,jӖ� }�&�\ƕ�[ �Kj��F��(���x2�q}+�]��*��x�L2�>
}�\0�^ޓ�v��o !����O��@_�O%������D8�\��̡�������0��B�]�H�>��s���pxHN�흜�v8�5��P7!���hҖ!i�^���c���+w[�����E���|嶬jm	�.��D��5���d�o\D�ǁg��N��|e<_���j3r��`�rg~�ڄ���^|%l�q�im�p�Bk��-���5���9P�Xu��bFvB�*}Sr�F#+Q4�2HS�̄������ޝu�4�f#���+�# ���'�����6.�?t��M�?�������2�V�}`>����-�B�S��C������%�@>�HKCCmD|��5�`�F���U�RxV�5�uz9iTn��ņK�<�H8�c
���h5��+�wVVJW�e��P����4�6�s_S^�y��̯]�Y�0�j6rP��X#�r�p>��J��Qk8��oJ+�A���B��q�����4T̀H�3��,���r㈑{���q�f�;�v���99�a�<fd�/��K+c K~L��P����C�Q�ҫ����7��+�&�_`(�����es�@�� ����~i�5�l�&߭�y�~��ꄌ��6�!�E�K�l*s������Y���~l~g�ͻ��K����*��3��=-�E��	|����s�����w�WRM�D#�\���\�� ��5ֿ{h�wu��������n,���4-XEހv�]x����2`c8�*�VY��p�sA���]�v_�m��g�)�1�>�#�@��Dn�j���M�j���pLK۽����
�B(�E#[���l��^�>��#�1�Uj�4|O��ܺ�nf��eT�:��4���쎌wg��g<��k���&�j+?̖W����|;��40C8�#(RS~�ӹ=�WWS8W��6��FhS�`O���#�	����)K`[�����*���Hg�}��D�{��*_�;wKc��W��}��|�����V #�J]���E�ݙ�/��s����E*)c��Ĵ�1����07�N��ȷ0�?aLɸiFMF�%me��Y��3L�k�el��D'ic����qZ(20&�X?u^���-�撅�Α	�
Z�F�@e�m:���BRK�gP���7_�~��|E�L̫)R�������`���e�����`�y/����et5�eh���/�}6�Lg��[�b�Xx��?��?�l�-MM��KF#0/Is8�$�ݛ3��Q'�o��"��E�kj120���rN
�^�5��)�DWLQ[8�}��34�]�b�5q1m\�I����	�)��a�Po2��I�FEm2@�f&�v�E:�%2���v��%�1,hq&����|�2��O2����8BL��C�3[�Xs��ư��r���İd=*������D�O3�] �*!��0�$��ː�\ȣ�A��9�$��9�t�����B���as&�9C��$md�&��M�+p��S���Cp/㏆�9� Ʋ#w!�
���*��5�7xau�o��/ܣ�n��*��S�xQ���y�b�� ��ќ.�h
�|�����נ9�Wr�Q�j�uKM�Sؙb�#�#ȇ���0O�P��V#{RM���|�-e�y�H�Ѭ
ߵ9g�#-MB�|ѩi�i-`���#���\��9��QrN���#��;��!�kt��DA����fod;<@����TҠb:3��)��A�|8O���,�k���]k���]��~�p��\��Q�_$h�� ���OSm_cH�ym�<h��)L!���s�x��!�x�OiB�X�8F�C<��h'����x�?�Z��7��(�k�����~H=,9(�i&�Dk��ӕ�X;p����8zҼF���&��ֶ�/��柳%E�¿U�p��'Z��@��vPF1~�2S��5�6���L���gaK>�����ʰ�?52o!(��F�������q��hm�5,���![@����P�+| �XH��b>%�f�(����`-5�2��:��[����|�z�L�>$Ӽ�1��թ��N|�2�V$���%�
C:�e��V����Q`�g�����/��L=��O4��{�Q���U4����t�[�U4�j�:$��P�-"�� �b�c�A��6ذ�D���J>��ڒ��C 3�D���Trj�$�X�y�i�,`[]�X8���!/�ֆƺ��Y��ar!�����M&��1�r���t8g�������I~���g~������X�	k3� W �.�Ha��M.�{��Y��L��u�9	��Y�x����D�>��%�˿@/$t7\��]����d.��g�t�#cj��/��v�P��Mt�Ώ�lg:G�ä���cA0�Q7<�H�d�,����өs]PzGǧt*L�;GN��y���d���,?:t&�AN�C�?rDj1 �Lǽ��qx�@�0X��t��&��bR{��P��.����ݫ��ޥ묞U��S{�w���b����N4�_��s��7E�9��E�#8�K�7ż>��CL��y�qt��kt��	�b���ч�D�o\I���|�:Ÿ`3��n �Lj�L�!C�c�29�wm]����N�t*��@eb��p��ֳ��{Egoq �Z�,�����%��{`���ACZ�w v��U���=�G��S��yg�Ւ<=� �A�1白�"�D�T��` ����:x�Jo@�x�[O�n�t�����-\��?��߇*\=��GO�}��Z{apw�Iitx��;?������qs�Nv�y����jb����%Z������1'R���_�Z�K������v�<i����6�Z�S��l/xp�h1�-�\�Y��]���m2�>�I������|i�P�4	U�WW�}ì=�BO���������_��e����,]{�m���GN�yV�\/ݾ��9��Л����҅G�Fγ���8�Y>��6���a�2�l)��h�!�N���e��d%B$�߽]h8U;i6#��Wz�������ܻ���s��T��E��b':��wo��`&[w��p��!ߏ͖.��-���=$�W�xV~v��Y�����7���z���p����䈼��!�B;��.�-���Rv{�]��*O\$d��>Z�R�;A�*$�R�<%��T���j?�䝕+��!�v�վ�X�v[�j�n��xM'm��h�Q�����N�8)(z�C��$�����t�'	�x������0����f�|F{KZ{�Dӂ~I&��m8��"h�(X4'�m��r�I����&Φ�.��t���M{����+�?�C�$�D��s,�v`�F�?Cd#����%\�]@���š�&�&��	"�8�Ã��.X�TGf�~��A��DW��r�"����4 ��!�{�H�0uW���݊FC�#����#�N:������%�=��q..����%�ә���S`h EV����&�$7g��!�3��� k�G�#�7����(
	2i�δh-�ؑ㢳{�9���} (Px�]Py=�Q�*R���-(�$M6(�²��o��#��`!�x&�ဳ LS*r�x��̵琐S�����֘h��2�0�P��ţ���l�)'�3�&q*���vi�J
���zvH鈁��v�g��M'����6g�M4��Q���f%���x�k�/�������ǘJ�걙�H�5D��dR�s�}�T�R[�ì!L{AHZ�@����YP�H���/�����~}8��덩Z/r�0Kx�GfkP�c�:]�����_����@�{�3m1�����]^��Է��mZ8�!�Se5JG��G�{�N悟ٺ��Of�}̪��m���d3 ��>�������KJQ��`���}��Ѽ�"���1\�Y����"�a    ��~z���4W+!�L�����E믎R�g,r��zzd��Mѱد[��?q|tf3^�2��n��sT/�
����Tg� ��<�*��j��`��T����T��B.eL�M�/m�ułB�&�����`�>�4ߠ�0Z�v�:y��̩G3w�t�h�(t���,��Lg�j�u��#�_Eծ��ۘ���u�0��չ��Nȿ<��i"��p�ג���bu�5�o���T׸�l�GϴX�o��b�4ƾ��%�s�{�g�ϥ�e���5�b�d�0�|��f*U��I��נM��$��^��v����x@9,v���c!�KJWw��m��!�F�����륍,�8�U�\�۹`��#�\GՁG|�S�2�6v�W����il��"�qC-��Ukb ������n��8�w�\2���O璨Tu��@�JD4l��M05�!�P%��t�1����nA��Y�Ƹ�Ǔ�4�|���ktNQ�%Aޙ8�I������Ώ����԰����?sݎS���%��3��p30T��f�|�/!�x6yΉwcZ�8��M�����D'��4m���iǞ�L�~p>��$*�a_|�����HS�1$��%��=���Y}��:�ӣl/;�.�P�>�5�긎����g%l.>"����Y6��8!�S.�Uv�a�l���^>%���xFuG:����N���G�h��x�5]�a#s��B�>��\?�Ms�Ȫr<���Ymh��#�����T�Y������JT?eS�ji3`�~j�yF��d�{�������+�T?d|��rk>��~�82zp��'�vc���كL��1+P�hMǎدxE���t�ؙ35���a��	�k���q>�?�Z�z {�ە����ć�Ij/��<d��1���ɏ�A�M�?�h��#}cl�>�DA�%�m$�<���q֐���Cg���h����Gs.��*7��n�~����k[�f�9
/9�JN�*�|�A#�l/�����Q�����ԇW�N��·b��<|�Çt��K{צ�Ⱥ����D����˒�M��~�����|��u���4?,��zT۟�w�qŃO�|��m���������f޹^$��#��q�2z���ұ�"(Aa7�p�# h�"��V� 0ހEPKS��U��bi�Ȍ,���=�;��ޭ^+ߝ(����vό��~��c�u�_X@Mg��h�yd�;�Q�9B��Hf�;�[�=_:����@���Jy�������.R[��ڭң���(��}sӷ5�'m:��k�;;Ez#����Pi�X��LÊK+�w_<�}s{������U�[�*ۏ"R.�8p��4T����zcg��c�u)˂�~��٦(��|�屙R�xg�w�QóK���xbzg�J`�Sq�N�rl\7&��~�m��c%�J�Г��\��Ɋ�
&lNk��&�F����?�sa���K�c�����h}��g4���4�j?~߱8���"6BۥIrx��gZÎPD���p���v~�?�03��@�����v���QmLG+8�d �o��k�pF\:���?�����2zLB�vϝ�y#lP��$��kdu���xA��B���u��q�ؠva?���;y�>#��Ҧ	�(m��njo��y�����cL��`�_}��{���b��t���2����:��{u�)5��
NG��ڂ.L:������s&G0d6��ᮞ8���|zG�p�3`��']^7���-�g���GðOl>���EW��{�{[�1��t�;\ڡ�t҉@Mhrq� �;M~�g]��=�8�&W��i�|Օ�SV��0}��n��3��xw?��}&}*�f�n���q�O��g��E}��Mn���a�ѷُ0��zu_��OC���D��-*�6�I�7{��^��I����h�'�D�h��`?��BT�t���YT-}��V��9*\�`�g,�ok0P�>�A j��7c0�Iv�Og�6/�����D:�?cC&�F06��'��??A�Pšc P����%��L���~�=ڡc&������'�KX@ÎEG��8���9���&i�l<8P���RY��N� �5�ݜ!Ǵb�1����.iZm:�UOy�=�nװ=M�$G��Lh�9�)N�,4�b#�C��/$Y2���B����x���&�$�:�<��6ⴟ*vf)�.�/�*���5uU
�ߜ��~��������Bo�ȳ9s&�4ⶈ���b:�����^�+1�F�<#U&�ƭ�#�Ns�k�?1G�Y�
�#~P�e?"�yj���0J���}-������nr������B��M�;e�LS�[�E_"p�%�bAvꣀ#o��׈�k���r�bk�5~滼\"��k��@��0H�3 :�h56�8�Ї���w�݇���;1�Ԑ�����S� ��?���,l����ܜ�НĶvV�̂G��C���X�{�j8(��|�ĐX� �\��[}�o��GǬ�FA]��}����<�h8?E����2걳,y_>GjGv�ϸk�����H�ħ>ϓ2�����2N�w�����b�v]� ��ª����-��A�~�{z�\���J�݂��)�y�c������~ǢN�['b�cv�w���8�cEy���v K������	�)	�BV����zI-a`o� ��K땃�Ϡ_^�^�%�Ƕ4a�uġ[Aka�{u�y{�e �gkB��J�֮��x�T��F�\�o���W�ܣ��U�y�8���A���O!��]d���l��R���T����a�^��k��e��N_8��D�_�㝅sdi���/�Mt}k�"x��:��+�_�|&V#0+v �!m����o�T�|���m��9y���#fħ� J�0���ڳB�q�/VǟYO]4�]`F���FN%^'��*�u��
�fi�4 �[Tz�
�T-"�/�>��ѭ�v�
d�y�+�H��	���J��m",䭒��c����kH${�D���Gp��+�˽��]���,�|�`U�IG􁳏:ޯBG�1w�Z9���k� |�� Xq]�<�
4�'U1�ŗɇ0�5�y�����7.xY�+��Ý�����S��K-LL~զS+=�t���2�*��5gUp;�H$^s�!�#�3�7C苎*�Zi0.NT��XxVϫP���B�X}������K18��g��<�{�KtUAX?\�צp2�Q�E�Q�q֓U$VR�2d1T�y��nP���[}�..�fo�&V�{޽\-���Q+}���y�qM�
�bR}�N����ku�w�J�G�fwV�
��& �ȗ���ԗ.���`h,d���Y̍l�S��_�Y��������W���+��]TQب�&�/]�wX���p�`R]���qQEa�P���2w�@����M��*fv�G�	^� $;�!_İ�{�f���#19a�ӳ����fW+�*��U4U(7��Ǣ�*��r	 �m�4�p!���UB���R�ӵSQ�J�߻	��K`�'����}/�`tk_Kݢ����n��5�`����8A��pS�΁�y�%{�������nm��(5~�o�/-�!��}����3�K�UV�M��Ｙ�B�$dH�ܝv\�6�A�l�ܙx?A}�rc����R�"�M�f!�f����9��h��	]F\MN��X�p0U�U4!���-p�K:L\�+wSg�8�7��3�,1�M2�ݮM�fAZ!���׳��;D�u��=�yd(�����	uUZÄj�������m*�Q�V�\Mm��H\*ٴV�a�g2.��'�T��ږ2�]ʆ-";�A�$��;�׽9���y��H�9'���$���C����ٜ��(i���������Ӂ�Q��c�֤�N)ٶ����렶�r�ⱟ-�ဴ��c�,u6}�
35@3Q�gBF~�e�?,`�����#O.�_���m!gV3�y��ug�><W    ;m�#FV�O��I���~p)I�O�����z����%$���p�Z�F��b+��L���	�F�/�,'�͚��%����8=�DM�2I�Q{�r�L�����YEk?�#�=�L�*�����!�`��[Y��0c��Q��-F@JA����v�X/ܖx�g%�ڐT�ޘ|;tɚB>�ߏ�v�Ʌ�)TXi���ظ�^�۩��?�}�3cO�P	�
�&��ߕ��������Fu#B�,�[K[o��*f���:�O�H I-%�5#��1$0-��däy(��rr	�w˃���d�R��Լ2�*�ĞH��B�kIc�vH���i��[��o�0G/��3]�֣-�F�tq���>hCb���]�Y^Y��u��e!��}�<�.����/��R*Yp0��B�?K4����t_�	��f�� M��IHŀYx��FB�
Z8��W8�}����=T���){��Ll�T	g��S�sT�,o�/��T�Vv@-�?�Ò�#�uYȠ�]:���y�3��K.?]�,M�4 �&��	��Ļ;#rRγn�ӕk��s�bR�(M�ȣ.*IB�3��[�)����fk�Qj�>M�g	�P�-5�ItѵX �r6Gtk�B����sp�C��r�!o$���&G�^̓��JV�U����tP{�&���,�������_����|��C,���H���G\*J�z�n���Cm�/�&�HȢA!�;wKKK~����҅���������"�7nＹ_�!��� ��gm�"��N�!�݇w�����=��}Ko�Z��,3F�XXF2��	+a��Y����"Q�P������!$�|����5�G	�C�>���j9"��v��)�"�Y�x��2D6�Q�s��i"X�:�vhE�I�$,'�9g��w^�vu��s�7��2D5<�XQ�u���3��~��t�&�ә\�*P��捌�,�3��n࿍	�01�
��'n;��s��\��U/K����7���4�$�;Mڧ����MÏ��v���ӧ�gnјփf�;Kˉ�j�Wt�5d~2����H5\��P���y/N0�E�:ΣМU�I�����O�?l��3�s����eAzc=�Q�ws�w��Y�
�5� ��I9�L���8�Q�JS%��������3%fz�|L(A��ip�>W��Q�~V'��{L1�S�h3N��y��#��ך"D(�,b�ǡ ��&�Z�	�X%2�+An}*�3ywek�8�|$	<�{W�R^�[M�.{�t$h����	Tΐ�:��9���G�:|�/u�x�����P��CG���@'�8ʘG��"f�/��P_��SXԼ$�E��Q={���Ƨ@��L������iP��F��,�?�W�ܺnZ�Ƙ}QH�G�q��h_�����MpM!K��ol6/�I�wVΗ�=y��25
�^?,��.�y��on�,=y7��Y]��QC-�� qp�ɻ��F��J��^�1�Y�W�ț�w_�0 6i$)ea�ϖ&��{DnzJ��]���y��f��I�˳`2�$��,��б��a���l[�&���l����%��6q��vysɲBq���������v$ҲQ�'A��:���.�6���m>gV{9z�t��,���ū;�y����Mpe,ƫ������'�~i��,e4D�<r���'�1�Z0�r�=ўi�;�JS4ڋg��2U<��ҚN��2K	gĎq�B81VǼx�葯��!��CǏ��2Ͷ9�%�/d��-|��0�|��v����@�'\N*`Z�!9_ϋ5�X�YǨ�bG6���Fz�TnX1�Ss�ǁW;�a-&���0�3��\���(Fd�7&p�G�j*��^v0�漱t�7UZ�Z�^�ԇ�'�e��^��9(!4�uw��q"c="��W<�#D�lw�ƶ�o=ؚ&h�n�4�� Q-�]2��d���>L4��(Ar{��E�zN�A���N2�:��\"e�X*�x{'�uu�`���	Z&�9�Iw�x��d��s�\��Y���9��>�J�$: ]��/q�%�;K$Ȕ �_]�(�U�Q:]�~A�UH��Nҏ	��T�E>�:���@�x1@�b�e:�ҞC�',�}ϰrz�:{�#X/��x^+���L�[��!�1YN0���u^��qM����>��.!��(�
����䒐�0`�8�k���P�����y�z����O����*�	`4�V�<Z=OQ_��Y�R��]z	5<�_%���K/���t��e�
�(��'Ӥ=�v~[�B�������<��A��^z	B�ԭ��o��P�pL��ҊWwV��,���T�j"���I0�ŴZ��n�]��}s!X;+��Zz��)a�x�Gۅ�ۅ)����<%�����0��o��"���~���.�v�������{��D�x֗�A��N�@H��eDT��ec���,�4B1�'��WzL��9�{��D)�	�r�0��Y}����'AJ>�ۼ�vL�Hd�$�x�K�N6�xt��΀�X70�h�0��L�\�ң #vҬ]6��Dr�8g	����M���r�#4k�	!�!�Ig:7!�N�ϱ=�� gb���c��K���(�c;x��Q��S	���^��/?�~�H:���d���٬�Hud��Q�L�� ��s	겄w��?1�&�Zf=���(*Hz�?��0 ؏�5����y���
By:A����n.�X?�n ���m-$à;b��|B�D������=�+�.�1��G�ڇ-Ѹ]v�P1?"����A��~�^c�GSԑȿq�0�i�BE���}��(�Q��EW��]�u�]�����	��̚Z?�������o����e,�x[�!F�@u�+b^|�ͥ���oX��y^S�C��΋
�u�x�,o�P�
��Ps;Z���Eh<0L?:��¦�sm(F]�E_	�}�4�XÛ9Ϋ�J52�6����ޮC�&�&o�A�"�`W
 �0X�����{	��	�Ev�ox��4Xő�.5��H~��4XE��.5��X���Ri��#5\j"VY$�Ri��"5\j"�(���&��5^j"�~��D�bD�KM$b�!�O��D"��z�KM$b���_j"뷻��&�|���_j"�7��KM$j�B�_j"Q�籖KM$j�,�~��D����.5���Z�R�Z��5]j"Q�'��^j~ǥ&�~��إ&�~�k��D��/���Db)��^j�^j"1��R�&fW�_jbV��w]jb*��'L5��2�Mg�ϵ'���̷qL;B�8�+��!oɿ�@��*�����'�z/�Q�Ç�t¿�MHU��k���ۑh��\�'b������L;G�o�� �����p������c�kk3����Q�d����:;�Mf�`U����9�ͷ�r����o�~��`!o�}�������LK��%�Nt���_���_�3?PO(x��3g}jD�Rm�37�9w��f���<љ��k�`�7@b�K�:�N%�qk�L�$R_?���tk���=x�C�p���}u܈M#�c��Yr?���L��*���v�LC]<L[D�:쵳﫴�"-P@^��h�Xҍ{.�<ٙ𴠞#gY�(�.(�u:�L��jKr/����"R�>��Q9����&�ip�4��A�;Ҩ4I/�L?�,��mO�:���tD���#cJ�w�Z�\��f.*AN���u�Ϧyk'��t�������py�x~r�x<���ݑ�ᛕ�4��WT��؇vX��0	����8A�5�~���sF*�}^a�w��&��D�W�� Kam����	R;�� �㞏ס.�	P;���`���*��L�y��x��ީN�yB韻3&x�L���ۺ78Eu3��޽�ξ���*�fL{�y\i�	��*���{5���N��ryވM;��3�2����po�2�O��@a��Q��GHI�����'��	z_e|������Ɵ0h�P����p���8    �q��r뺱��kbO4<f7�:�����aF�٩����^��N���u�<��̼�wu�ٛ�<^�U&ķ�2uu���~tw�'G'!���0�
[��|�lL�k�{w}�|u�|q|w�����u����_JC�䷩��yx�����?�3��@[u�	TG������.ݶN?ڜ�`����H�Ps���p.�oΖ�k&@������OMڙ���]X!;C�j���(��n�'&=���e�	r)�/� 0���1r C*M�"T��:�k��Y��%}`�X�@����û�a��e�b@uK��&�HG��,�*M=&�85w.�u���?�9�l�j�^��U���'�L���8��+�M����}�W8oĮ����EFk���{b��|�<q���<�/w�O�,��)z��+�'������,�+��Y}���byp�ݳg;+C;KOȟ��/��6������A���S0MB;��~߽�0���v����P0^�}�]�D��'��L]h�ȟ��t�v�0"|��0n�~�6��M���xk���v��v��v���&�:+��
�`~�F0�:a��/�W��������A���L�Z|Q��E;�>��ߐ��.�&�������5'-#�aC�}�xZ`eϡ.��]�|�4�6��p�.Y�	j� 
Aj3n���e�?8�Q0��>�+A�P��s2TH�f^�9ZI����ù^T#�\��%���"r��J�Y���(oĮ_"kaD<��AB|�=%tC��&��$@!�i��<!o}��vO>�nI������򥻻�_$�T��>�%DT(���2+�fd^�o�U�����흠��,�9�N���O�#�H�����N�Y�D;h��$8��W�k��^��������%'ۄGg���C%��6 j>b���Q2i.XT��A������I�4M^M��we�4yu�v2}S�K;ݛ+�,m��#K�6�]�g�	�9w�e:L�\��'��8Q��i�v:Ct�4�����r�EwSξ�������t��������$Z+�B	�})H���v׋gB�6c�%�&�Y�����������
_��� +͆�vlEFܑ#o�h7�@u��b��A�d��Tbs&�WPce\����{�\�#i�{���N*��a_ݙ�)ғI�y&�����O}�Nds�j���nGP}T�Z2�(��
s�j�Ls"X�ݜI���s��~ҍ�1!�O>�NeU�G5�"�;a�)w�j�Dȝ�Q�|���cLQ�}�Ș`�xb��7��v,U���в��$''�aHQ���ƐNΐ����Zi�&|�$#~×'�I����t�?UׄG5W�0�D��<�A1:�ns��w��S�����ɋ�;�/��p$��%�B�\�9z�A��R�G���i"xL#�.�+�,�  ��%9�b$�?��$�b?g�I�q��^�R���)�9����c|�E����\v�}�+����?]xTTsj��(fާ��X`���C��h�/������� _b=�Vk�A��\��<�0�w������O�_F�Й���x$�>Z��>K����뼆�?D�'�x����χ����xg��j��?�&p�� {DP(�f��x��(�N��s!�S:ۊh��AY�'R	�Fz+P7��%�H�扜�S3�q��9cô��[��{q$��!�Ӕ�0�g�p���m,��x��$E������~�;հ�M�p�	6B�k�A>����x��?����f��t�g�ѦH��>�S�=A��Ձ7ơhg;���z�t�=��,�1*E��,2=���"_�Q��^P��8B��^���{>�2������� tZ��g�<���o�m)$��:ɉt��p���ikp�p����)G���Jߞ��<��2�P����M���*�lBB��Q^��	��ru�\�X����-���e��i�n��V<C��`Y���P��-�G�[����4�x������o�0�+�l�0
�s?jԳG��ٷ����"�?y��h���lB�r0Fl�6�֬Q�3M�"�8��9P!m��{�>W��i!�/
��̘K|�&p������0�"�g}��1Ӝ���p#lS_�]T��Rc��g�&�-�����E��A�/MX4>l��©������9.�hb&L�J��K8��X��ɥ}�(�Ѣf�萇)\W��*�ۺ��6W,=hL��U�x�@#�.�k����OK�Y��%}C&�}��*�te�� c_8Vʐ��"���/�IK�]Uo(�OX�g����p��T���|��q�m�K�A��u���+&�Q�F��t�N-�,�,����e?]��+�+�,ĄЮ�b�4���AcJ��HYXM�����	�H3�}��5��K���z���_�3젳�3�Sm,�4�0#�i	Iq}�P�r��e�	4 �/Х�dd8���X�~��Ș60�s�U�Y�_S2}��k�ԉ���|���ړ��,������NW<u��3^:�����14�'����5��E�#��aܜ�]��]���?�	��Ӌ��dqZ,�Mu�p{%�C��L��c�?��tl�"�Ϋ�ʝ%�����4�{v��\�N��ƍ�K���' (k��,AA[��4��F�9�JMԾ.��34��0�[4���6�/f�UCR�;R�wmJ��hY0������`z�򷵡R�������-�YZ!J#O��\�.�Кf��ː�l�9����k�O�ԯ�n�R^Z��������=,����HO����2]�$�H� w��S�,�h�'�����_&�w�V���tg}���e�f����h�'k���[�SG�����^�Q,�}�cvM��V}%���3H�h_��_�(_8�9��H�#wrT�Jx]�ο޴c����E�A˓%�(�Ht�1$�M:g�W�Q]3�Nm��OCS$�KxX��Ig��S�T���50
��[H�I�C>U� u�^��,��PEN4�� �%���r=�Ú�m<P��iⰎ��3e����D�V�Ѿ:���Y��x�3:|S�����2����HASH��Q6[����)i�������DnT����3za���1��\�r���r����3���ž��l�4]����%��#j���B��w�W�9j�ׇ=��#\�z�m�-�7&r�!�*[���?�0��G�` �*
���s>�
1�l��QZ���@�c���8��<�?i��/ys�}ə�NzZ`5��A�#�M����R�8�9���H! 3�(W"gՇ���?N͜�=����w�Qz)�� a�GҊ�
@ ����%FK�S�O�����F� ��;�N�L�eq��	��x�4<�Ż�s�]�$u��h��>x&�h�qdK젰�Ң��g�)�Ʌ���*�@=�f�WG��I�q�i?@�����r��!rڇ�q&aZ�粸�P�4X6��5"V)�#5��d���h�tY�4����{0� �V���z*�_�W�'*s7:I�� ?��	�
�NU|/P,�xii�o@j2o�qp�rG�V�ik�x�d���b~g�gw�5\9���C�{!��=
Hk;��C;+�
l[�M ��E�k���\y����U'�	�:1XV�l�	�o�qm~g�5� .� Y���
D̴	X����t�y�\Y��tR����=�&��F������{y��L6�ԫ����(��d�c�������� |���@���7��� ��R �s�6��@j�g���Kr��g���)"6��(�{
�jө�}?���d�>��׹���A�{w|�%H�qfk>�>� 3p�+�ѯH"^O���(Ht��?#^ݡ�ę�WW�t��?$|H��Չ7[�#d��~���#_�<�@��v���u�aSX}�@X��z��@�A7����W t���f H&7���x&�P>R�k0�e[�%]��+��B'+�)� �F���Ɋ�����n*�ȸ
T̼'�D����W'����s�$�J������k+�!��M�/J�:�ѝ��a�E��:��w��/�    !.�Q��%��q����gS�;(�Ȍ�`Ů�/�t�	6���tZ�Ԁ���Xu;T�jN���CmR�3i���V;1���zxb�Q�������[e�#:M�}���桨���C}�yI�U�q���^�%j����/Mn �졷��[�p�^_8Z��mjP��5 T�t��;��Z���V���R;�����ѭQ���l�Kd�s�ˑ9��J	�P_�����f���;/���#����"���6���}+�N�̝���{>�_�<�=�����z�H��3�+�m��@_ٗ��xFk�3�����������Qx�}�b<���+���o�m��=��� ��#A7شu��FDfVUVE]<g��%w7��U����_\�!�����n���q�4w���i����jk�Y��&D���j�r�����Z�����j��W1�����RmjQxh�jcx��"�V�#W���y G1�Cfu<�^�a���=̓@ا�{����f���/1��|ޤ�b�5����R�E����D�9_�˚�Mҧ����5؇�Y�0>gy�Q�zT挎�G�h� U�΃]&��X�	���]�tPav�\Y�UT(]�y+����T̉������l@��daQ
iB솸���H����
�J��U=���n��Uؐt�x*x��5�(��+4q9�N��[;�1q�*|��A�o�a�ď�1�����7�b�_?O{|u�ϧc����_���	��%Cy�9^;���t��wl��m>��;�/�,"*!v�#�b7~a��[82������ꯜ�tXu�yu��jy(��\�օ��e�}n��cE�;�����
}k<�B�8*�щ��U���dȣ�N�<� �{��K�k��A�����C���;��O��"h�O�`�E�F��Q���q*�%�`���ak_�0���v�Ֆ7�l����b+��{���.X�EЧc�D#��O�(��0~�@��	g۵���e���-�{�D�I���i�Z�
��3ۜg��� �|:��2��e@���Q� ?cI&�V�:�N�c���.~�Ə�5�w���Bk.S�ܒ�%�S�ϫI/����p��ϫIFY8�=n���1co|H��!� ��2kXS��l�,59v��2k���{�!6����Cl���G�iL�i���#���
5i�?�D��G<;�!l��'�v���+���N�7�k�to���SQ���~�����i���Õ�H5��0]'r�b��\&�T�1��ohȞ�!��B��t߭��b�r��<���E���4���8�.����N*�!��B�o�����N���_��&�h�8���=�N�tA�S�f�6י'L:�cL�j��5B�����s�Ԥ�*����N���������7����o$����H�}#�5�vE�;}10�OT�G�.YL���Z?>FU�)NQP�Y�-���Я�u2�K�i2����Xy	F��eM���Ⴭ��r�~y�>R2�8�U�^&ti���ꭏ+3���%!η��E���3��籽���[uY��΂4�Ӣ��)�t.a��8ƀL��Y��
���l��u T{0Tݞ�?�pO<��������vl�����������;.B�k ��mWo]uu�ʾ�_�;tI|�<����31����}d�)��3[��CA�;g�N�2�SS�%P�p������Na4�N'�B �y��=t�nRP�o�@�bw���$�_�A{����{^O;�Y�z��҃X'�E���h|v�w���f�l%�Ҽ ��=�ؐ���\:�=t�P��r���uR���p"���~ȁ}�5m��M.Җab4iW�UO.Y'���=��7`���Ļj�;YYs���^ؓѼ���ُ%��rE�k���ĝnp��6��������R���q'��	]M@�D�|1e{o���D�oW�G���̙�l���/h�-�+��)�
����w��K�O�4���KZQݗ�
�0o�z�- �Aq^2*�dOB��'�N�w�M�g^S�CW����8���!�ڙ/�Vn���`�1F/��e�O\o�3ZVY��1�5rr-�?�R��ɺ���U����~H�P|\����w0�I�p�ޗR�ȭ!�������5̱�`�;��ogg��R�DW6�";JzJ�K��[z�뒺Ɉr��U(�;�`i�	�%=��א#�a���t�"�61�wg/��\�F�l�Kr�oU7H|�҈�Ǝk��J�s�/{�(;�v��z?�&VY^ylm#��i��c�,&ߡ�(�j�:���u��Ȟ�V��jd�M��XRq�c�����>��Xs�D�8W�,�I���%������-o
��!����㧋`҇�W��^�\D��g�@ʏ@�^/u�O��RH�P8��5-�h�g������dX�L�Ј8ً�����RҒ�{�m�G�V[���������fˇ/W1|�>��>2�D_�H������h77{i� ѼP�
�u�����R��b��$�\��t�R��S�B�Pb�����ǳ�g�
0�#&�m�;L.��ǥK���D�E�H���;�a�I<P �G�k�H
�^��������,�01z��6E��y��ʟ凨�N�8޲�B%�K�7��A��"y�\>�\`;�ɛ@���:`
aR�#��JTl�>��e/M�pL[w�#O�T9z�@����2H��۵���U�����n�Vv҉0�F��љ���X�_��
w�����KO��-�[��
�:ÿ��%*����ZG�`�J�+��w� �j��ĝ������/��h�k�lꑧի���#�f;���ba����DdQoPlv�,�Nv��P{�D{S����g�xaMۜ&����
&7�Q ���*�&g2��4����٠��3:M4:;���jp������ScI�ڜ&ٜ�X����*�cu&#Z�64fi+��T��	�@b����w��9���4r��`A-v�h��TSa
ě�- I��hs�%4(�x	~���ӔAx�g��%*�H>�9��"�ػ������	)z�@H�\���!$&�@~���PF�G|�\4!�ky��t����	�P�o�x:KCz��,|4�Ecg��Q������ȓ��t�K(O1&s�%*�d��st��Q�)��@��+?���y[���,���(��DP%��%�$t܂�h["*�ek�NdB��{:��qq�8@�/iX��L�rr��q���3 TyB�;JÇ�(O����b�G&ly��f���A�K+��Dy~W�{a�,?� ��J���5$<�X�u�vVX2!+���X���0�+KiLͰ�#�$1��1YA�16X�aK�F�\����)�0��:ֈ%cW�ٍ�#��D[BD����c;�9Ǯ=p5	�P�o��s�"�Ɉ\����BO�9j%?q����F�?�$!��g�=��'Y���]�YJ0�h����%/
`O��ŋ�.�l�v��<�cZ$[Z$#<
���-���8Fɖ6�[Lr^�dK\�,�![y]�q�%a�,��p�UR�+���}�MJ�'KXJ|��b���Jde?hB�ۦ]�S�m2�k�ڢ�*sC�Ԣ�¶o��(m�l�69\9��z�mWܱ��������kl�`�MW	̔k���b��Э�ݨ�"�1e�r�씹/�%5Bj)��М�E���5L�~W wAo��CG�qtx+atm���d��?*J�����r��iJ�g)<�6n�7�7�3��v�XW���]�u���x����������XG�B�b"'�zs�⨜d����Ԣ�0��¼�A]|f��������{s���t �U��Z$ǔ��G�Q�K�O��N�0��	aՊ��D�rr��/6�ʊ��p��Jo� ?�-~�838�s4�n,T̫� W`�c��A&�Ab�Q^o����У�K1�tk��Lb=�x�X&a��j/�z}!��QO;��|=�贊)��2zs����¼    ,�;�3ӗ'iEr� ��#�1���`[���W��aS�E�XĈ���i'<����QΖ��K$��ι�S`��0O��zZm�`���pJ"S����|����֤�A ��S� t�r}".!���e��6y����]�w�&L/�� ���Xb�P��ہO�sz���q<
c��uc�zu��I�b>��g�/�Uo��_���t�tu��I"
���!�Z���:� �[#��/��%Px�Y�(���)�������fM D�Hղ����ޮ|���cA9Y��|���SQ�c�`�tj8B���e:�9�&�2�Er������be�u��hj
I��`����ūڬ��x=tTi�$>fP����9 ��I��+m��w˼ȓ��� �Pd�i@��2Q&�ξ[��:E���~�`ɵ�z�Qqi��<�,p�&�E�fH�ɪ��l�撆�������r�g�s&9�� �N��1�\eK�ظ�9���T������;rf�x�E��):�/���1g~/�j)���������h�;b؍O)��%��.d�>3�n�&�_{`4� ��3�o1����o:y��$�F<]�Mܫ���xz���?6F?<�Y�e�W��=��,!p��)�X��y`%��˻��@}wp�쭃�R�Ck�,^�*�kT�xxwx\�&�g��A|�v��ʙ��X������h,ZrG46��g��Bo�]霁�1|e�'�uz`{-���:�t�g�T����A��
��l���i��e�M1���jC�d>c(��A�Z*;�"���@>.���E����6�&ֽ�F�|`�5@�|�FJ+���0��*=�?�ac���&(L�l��\A@i������W�ғD4OW���BgG�(?��aW?�I���������76�B�ElZ��.��P�C%w��*�ϊ��0���A	Z�_k~x�� ���J��0�2�m����(�U����瘡f>�?z���#H�� ���U��j���޽j��4W����ƍZ�z��#
bz^�3( �k��.�@�Fg��g�.��;�O��*�oƥ
��/v��V������M`G�I�G�g�Uן��ޮ�P	Q^I�$����њ*��$, Q��?�ҭӲ:�z��rR�zL�.<�.h�LwY[��A�	���#�?qfXrAU�Sx�T�4-S�K�a�È�F?�mU��ʚjwl��k)��~@ \��b�{�=�v�����e��=p|��P���J���sGp��X�:G�洰�`�������WgB�������y=�48jZ�T�#�'�w1���*�7���"�]�)i���W|R��=��g,8g'�6	�2@͇By��L�S}�^{�ـcD������\"���	1\�;o֗W��*�j�L\�1���A��I��Y��Z��^��MGQ�ګ�𻎴T���vC*;��B�:�c�<���U$C�ȁ��w{�x´je8P�}je8�.(���ր��'�6A����9O];Կ���@uN62�ߍ��`\�!�fC�#���߱�Y�Q��bcd:g�2P���f�|CT�>�3�.��,���"�<e:��P�hR��R+s���/�W7!�e�=��,Pm0&AM�wf;�P�n�ZE�/@s���b̭\��[ez��A��K�W�	�����K=����֢�
�u]g�_<���[7zXxo�aE����CϽ�\�����-쮮���w�-���n|pgW�D���cR�Bv]��۝�{�!f޾nqo���Ioo���v}���f?b�+XY�^�n�`���58��>���}V���m^�����޶8Z��.���2�&��0�. ���S0���)�d�	���K(\��������,Oָ5]Squ�l�g'GN��Qt&鰌a!�vX����(�G9�+;��>��0"����ES6�ʌ��/���loNCg$)í!��h6|�-vd;�
�[0�*X��0���Y�S������/��?r"�      �   �  x��WIn�F]�NQ�$5�Y���Am8�M��V3�X�*��1r��$'ɯb���A;��������U��]�֏���(����ʛ���h�	�'�j-<2��B�P�ϘΤL��ڲ�D&u~W�*yS4�сu�r*{�<5F��u�q�J&��+2�Nj����yr���Llj��ѸH��ri�f����f��B61�}Wm��㪻�y�.�!׵va�����h-�Y�%�MJ�?-}��E��@�ȑ��e�����"T�!J�����{L~)n���b J�'\��L%��q�J�
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
,��͕OH1'S���8��}�A:�A '>����VJ�LX+`�bٜ�ݲ#�x� 	O�9\�ɰw^M-OJ�sՔ�'������6Lꭨ�(�`�����zAa"a>�'���t����a�	�^�9$�UH^Ns�9\�`9�7�9���ڤ��D`Ar��=]�y���m�l�hn�����E���<U]�H�����:o��j�厄��"�j�m����~sK�-���������ؒj�o��O��/U�����y��y����hi��            x������ � �         u
  x��Z[o۸~V~ߎ������e��F��.����v���4)��b��ϐ�#���')(�L~�7��pH���:�H��x��k�v���[�$h�ר��ZԔd+������6�eX�{�|o���C�Cw\϶<��ʋ��v[���i0-��*в:Ŕ�Qt��%9�K�*�Z�n�6����gtK@�-:�EЪB��;��C�k��MS�َ������$���ȳ�iT�O�(n�	����qu��҈d��i�CW�/�i��uI2\�ӂ�K��0�g��dZC��[�Q2]�,PEIq�4>��a���ZOoq�pK(��)ΪsX���4��i^R���H����P�"�;�H1(��"�� ���8��\f���5��s����!q��S�ޣeN1Ye�Zg�"ƲC�-Gw����4  �@<�ƒf"��S���Xw�B��QB��4��Y��"R?�$�+0�Ƒ� �԰�C]���YO�2��L����H�n��l�&=�7�.1|��<�D٪�Vr�7Bǃ?��Lӳ�C�/Q�n�.E+,)���Q�,�4@��p-ݴmr�s#���֔K�
�#9�o�7,K)�pp�	m[�\ߚi�쿘{-���l�E�?T ٢/�1����6������0�d�	���*������Y�"�E)>�cɻ#��]��Q����7��� tg0F���M�DIݮh�QZ��@c�d�*av9�:�a�X�+Q����/�Z�����G\P����n���So�fF�L6�?�ym��(QHl;t=ݱ� ���
J�A��&4	�%��$�(I6��b1 ÈQTU�dNq�Xf�!�1N�;3�sgo0�{ &|yG*^�1���>�y�2b�UT�JpC��=Ǆ*`� ,��(�Ճp����gȀ�c@�����a�+�_$p�&!Kx5u)�9<�ܕ��vEGd}��ŔQ��f�%�sЋ-��VhX��Θ��x�8��3��v{���^(@I
�J\���[�f�k�z�4מ�1�u�Ip�8$� �	_�,� ��g� /�%��&)�n��+������m���<�o��=�J�\���Ȓ��y���ďe����� �wd�7�*Ѣ�<_p��r�y�?I�`Y��)%��L�`̳�^`@N��OV ����������~�|��E\���$սg�!]�$�g	����Q�\���)�<��(��*� V�U�<�,����Y��7S���5<7B����D��1|ؐy����k�=G�ĺFᡎ8���2�I�9j��9w[��QOu>��SZ�-�KТ�N��TQ���2��9�5�q-����<�.յAwI�a��t��_q��7=�RKZ��y��ƾ�EjԬrǌ���*E��W�k���,&Q���"e�YPf����o��� 谎���D�u!O0᧔�=�i��Wg���u^��4J�7!j��e�M�([%Q���;"�~[q�S�&�G\�ێ#D��:���撬ؙ�-Y�����=�<}�Zo
J`��t�L���Mey�Ք���<T{�@;l#e*�2����ng��I�8��Jͼ�D7A��='��$�5��0/�ks`�XM�}���`Uw��zm=J���~���T(h�����>TA8Wx�x��s�Й��خ/�E��.?�Gm`�S����?%�
>�x�%JʵDl����Ap�A`��Y���!=b9۾]C��ahq>Vk���;l�wL�r;Jު��p�F�!��]��&�1L!ic���j	_�(&��5�o��pR�9K����F����	-/t���`�l�8�����>��E�	wK�H�5��r������啺Yh����3��̐<j�M�۞��,&��=����۷Ǉ��*�řTy�О��� �RB�l�Q�a���pm�������d�36D��~��m���Q�A�C��[=�{^YdN�vzl�(�pY���S�ܞ�?J��2�$e8��S��98�|XO�{��k�;�Ҙ�����mu��d�덌LĻD֫���=��8�,d6�	lǃ�ܨ�yښ��1ω��lⶲ쉏����(��uO4��������)���B��C�-S�f���[���}�����$�x�SIx�b6x�*����j]����,�ڄ����Hh����wT��<H�����of�X��J#�B�B=\W��oy�#�_�W��|W0�'.��������ׯ��O��*�쿡���gi�f/���=�-�v!S�n^J��}��w�4 ���^E���ߣ�N����V�P�.EF/� $J�Dz	�����M�}�x����?���O?.��D��H0�a�����#B�ز�1Y��{>�2$𩻾�v���IF�W5P~�ǖJw�c����~K������5�/�Ow;4���n�'��K=	6�M4�������'�������&B|�W��eP�4e�g_��~��~�޽�®��C�C�
P���_��b�����ㅴsr�ȀV=��ٞ[}q�"�H�T����w�o�����q1�,�C+q\��}�`��i�@@���{������WEȐRMe�u{w���'4�o�?����aKvX�r�W�����^X�            x������ � �      
   E   x�3�t

u�q�4202�50�52W04�24�22�36562�DHY*Y�������9W�  �      �   p   x�5�K
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