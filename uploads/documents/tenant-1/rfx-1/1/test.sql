PGDMP  1                    |            bproject    16.1    16.1 �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    51164    bproject    DATABASE     ~   CREATE DATABASE bproject WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Pakistan.1252';
    DROP DATABASE bproject;
                postgres    false            �            1259    51456    bid_clarification    TABLE     �  CREATE TABLE public.bid_clarification (
    bid_clarification_id integer NOT NULL,
    rfx_id integer,
    submitted_to integer,
    assigned_to integer,
    title character varying(100),
    type character varying(100),
    issued_date date,
    due_date date,
    status character varying(25),
    reference_num character varying(25),
    completed boolean DEFAULT false,
    completed_date date
);
 %   DROP TABLE public.bid_clarification;
       public         heap    postgres    false            �            1259    51455 *   bid_clarification_bid_clarification_id_seq    SEQUENCE       ALTER TABLE public.bid_clarification ALTER COLUMN bid_clarification_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_clarification_bid_clarification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    248            �            1259    51468    bid_clarification_meta    TABLE     �   CREATE TABLE public.bid_clarification_meta (
    bid_clarification_meta_id integer NOT NULL,
    rfx_id integer,
    bid_clarification_id integer,
    meta_key character varying(25),
    meta_id integer
);
 *   DROP TABLE public.bid_clarification_meta;
       public         heap    postgres    false            �            1259    51467 4   bid_clarification_meta_bid_clarification_meta_id_seq    SEQUENCE       ALTER TABLE public.bid_clarification_meta ALTER COLUMN bid_clarification_meta_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_clarification_meta_bid_clarification_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    250            �            1259    51479    bid_clarification_revision    TABLE     3  CREATE TABLE public.bid_clarification_revision (
    bid_clarification_revision_id integer NOT NULL,
    rfx_id integer,
    bid_clarification_id integer,
    comment text,
    due_date date,
    created_date date,
    created_at timestamp without time zone,
    revision_completed boolean DEFAULT false
);
 .   DROP TABLE public.bid_clarification_revision;
       public         heap    postgres    false            �            1259    51478 <   bid_clarification_revision_bid_clarification_revision_id_seq    SEQUENCE     %  ALTER TABLE public.bid_clarification_revision ALTER COLUMN bid_clarification_revision_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_clarification_revision_bid_clarification_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    252            �            1259    51493    bid_clarification_revision_line    TABLE     �   CREATE TABLE public.bid_clarification_revision_line (
    bid_clarification_revision_line_id integer NOT NULL,
    bid_clarification_id integer,
    bid_clarification_revision_id integer
);
 3   DROP TABLE public.bid_clarification_revision_line;
       public         heap    postgres    false            �            1259    51492 ?   bid_clarification_revision_li_bid_clarification_revision_li_seq    SEQUENCE     2  ALTER TABLE public.bid_clarification_revision_line ALTER COLUMN bid_clarification_revision_line_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_clarification_revision_li_bid_clarification_revision_li_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    254                        1259    51504    bid_clarification_revision_meta    TABLE       CREATE TABLE public.bid_clarification_revision_meta (
    bid_clarification_revision_meta_id integer NOT NULL,
    bid_clarification_revision_id integer,
    rfx_id integer,
    bid_clarification_id integer,
    meta_key character varying(25),
    meta_id integer
);
 3   DROP TABLE public.bid_clarification_revision_meta;
       public         heap    postgres    false            �            1259    51503 ?   bid_clarification_revision_me_bid_clarification_revision_me_seq    SEQUENCE     2  ALTER TABLE public.bid_clarification_revision_meta ALTER COLUMN bid_clarification_revision_meta_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_clarification_revision_me_bid_clarification_revision_me_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    256                       1259    51716    bid_deliverables    TABLE     !  CREATE TABLE public.bid_deliverables (
    bid_deliverables_id integer NOT NULL,
    rfx_id integer,
    template_title character varying(100),
    deliverable_type character varying(25),
    deliverable_count integer,
    created_by integer,
    created_on timestamp without time zone
);
 $   DROP TABLE public.bid_deliverables;
       public         heap    postgres    false                       1259    51715 (   bid_deliverables_bid_deliverables_id_seq    SEQUENCE     �   ALTER TABLE public.bid_deliverables ALTER COLUMN bid_deliverables_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_deliverables_bid_deliverables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    286                        1259    51727    bid_deliverables_template    TABLE     E  CREATE TABLE public.bid_deliverables_template (
    bid_deliverables_template_id integer NOT NULL,
    bid_deliverables_id integer,
    deliverable_templaate_key character varying(25),
    item_title character varying(100),
    item_description text,
    required boolean DEFAULT true,
    is_active boolean DEFAULT false
);
 -   DROP TABLE public.bid_deliverables_template;
       public         heap    postgres    false                       1259    51726 :   bid_deliverables_template_bid_deliverables_template_id_seq    SEQUENCE     !  ALTER TABLE public.bid_deliverables_template ALTER COLUMN bid_deliverables_template_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_deliverables_template_bid_deliverables_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    288            �            1259    51404    bid_documents    TABLE     �  CREATE TABLE public.bid_documents (
    bid_documents_id integer NOT NULL,
    rfx_id integer,
    submit_to_customer integer,
    assigned_to integer,
    submitted_to integer,
    title character varying(100),
    reference_num character varying(50),
    document_type character varying(50),
    request_revision boolean DEFAULT false,
    status character varying(25),
    comment text
);
 !   DROP TABLE public.bid_documents;
       public         heap    postgres    false            �            1259    51418    bid_documents_acknowledgement    TABLE     �  CREATE TABLE public.bid_documents_acknowledgement (
    bid_documents_acknowledgement integer NOT NULL,
    bid_documents_id integer,
    rfx_id integer,
    acknowledged_by integer,
    acknowledgement_date date,
    acknowledgement_comment text,
    acknowledged boolean DEFAULT false,
    acknowledgement_document integer,
    acknowledgement_submitted_on timestamp without time zone
);
 1   DROP TABLE public.bid_documents_acknowledgement;
       public         heap    postgres    false            �            1259    51417 ?   bid_documents_acknowledgement_bid_documents_acknowledgement_seq    SEQUENCE     +  ALTER TABLE public.bid_documents_acknowledgement ALTER COLUMN bid_documents_acknowledgement ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_documents_acknowledgement_bid_documents_acknowledgement_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    242            �            1259    51403 "   bid_documents_bid_documents_id_seq    SEQUENCE     �   ALTER TABLE public.bid_documents ALTER COLUMN bid_documents_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_documents_bid_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    240            �            1259    51445    bid_documents_meta    TABLE     �   CREATE TABLE public.bid_documents_meta (
    bid_documents_meta_id integer NOT NULL,
    rfx_id integer,
    bid_documents_id integer,
    bid_documents_post_id integer,
    meta_key character varying(25),
    meta_id integer
);
 &   DROP TABLE public.bid_documents_meta;
       public         heap    postgres    false            �            1259    51444 ,   bid_documents_meta_bid_documents_meta_id_seq    SEQUENCE       ALTER TABLE public.bid_documents_meta ALTER COLUMN bid_documents_meta_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_documents_meta_bid_documents_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    246            �            1259    51432    bid_documents_post    TABLE       CREATE TABLE public.bid_documents_post (
    bid_documents_post_id integer NOT NULL,
    bid_documents_id integer,
    posted_by integer,
    post_number integer,
    posted_on timestamp without time zone,
    title character varying(100),
    comment text
);
 &   DROP TABLE public.bid_documents_post;
       public         heap    postgres    false            �            1259    51431 ,   bid_documents_post_bid_documents_post_id_seq    SEQUENCE       ALTER TABLE public.bid_documents_post ALTER COLUMN bid_documents_post_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_documents_post_bid_documents_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    244            "           1259    51742    bid_kickoff_meeting    TABLE     c  CREATE TABLE public.bid_kickoff_meeting (
    bid_kickoff_meeting_id integer NOT NULL,
    rfx_id integer,
    meeting_title character varying(100),
    meeting_location character varying(100),
    meeting_date date,
    meeting_start_time time without time zone,
    meeting_end_time time without time zone,
    created_on timestamp without time zone
);
 '   DROP TABLE public.bid_kickoff_meeting;
       public         heap    postgres    false            !           1259    51741 .   bid_kickoff_meeting_bid_kickoff_meeting_id_seq    SEQUENCE     	  ALTER TABLE public.bid_kickoff_meeting ALTER COLUMN bid_kickoff_meeting_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_kickoff_meeting_bid_kickoff_meeting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    290            $           1259    51753    bid_kickoff_meeting_contacts    TABLE     -  CREATE TABLE public.bid_kickoff_meeting_contacts (
    bid_kickoff_meeting_contacts_id integer NOT NULL,
    bid_kickoff_meeting_id integer,
    rfx_id integer,
    user_id integer,
    invite_sent boolean DEFAULT false,
    email character varying(255),
    created_on timestamp without time zone
);
 0   DROP TABLE public.bid_kickoff_meeting_contacts;
       public         heap    postgres    false            #           1259    51752 ?   bid_kickoff_meeting_contacts_bid_kickoff_meeting_contacts_i_seq    SEQUENCE     ,  ALTER TABLE public.bid_kickoff_meeting_contacts ALTER COLUMN bid_kickoff_meeting_contacts_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_kickoff_meeting_contacts_bid_kickoff_meeting_contacts_i_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    292            &           1259    51765    bid_kickoff_meeting_template    TABLE     N  CREATE TABLE public.bid_kickoff_meeting_template (
    bid_kickoff_meeting_template_id integer NOT NULL,
    bid_kickoff_meeting_id integer,
    deliverable_templaate_key character varying(25),
    item_title character varying(100),
    item_description text,
    required boolean DEFAULT true,
    is_active boolean DEFAULT false
);
 0   DROP TABLE public.bid_kickoff_meeting_template;
       public         heap    postgres    false            %           1259    51764 ?   bid_kickoff_meeting_template_bid_kickoff_meeting_template_i_seq    SEQUENCE     ,  ALTER TABLE public.bid_kickoff_meeting_template ALTER COLUMN bid_kickoff_meeting_template_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_kickoff_meeting_template_bid_kickoff_meeting_template_i_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    294            (           1259    51780    bid_preparation_task    TABLE     �  CREATE TABLE public.bid_preparation_task (
    bid_preparation_task_id integer NOT NULL,
    bid_deliverables_template_id integer,
    assign_to integer,
    task_title character varying(100),
    task_description text,
    type character varying(50),
    priority character varying(15),
    issue_date date,
    due_date date,
    log_spent_hours integer,
    log_estimated_time character varying(25),
    log_notes text,
    completed boolean DEFAULT false
);
 (   DROP TABLE public.bid_preparation_task;
       public         heap    postgres    false            ,           1259    51805    bid_preparation_task_activity    TABLE     �   CREATE TABLE public.bid_preparation_task_activity (
    bid_preparation_task_activity_id integer NOT NULL,
    bid_preparation_task_id integer,
    title character varying(25),
    description text
);
 1   DROP TABLE public.bid_preparation_task_activity;
       public         heap    postgres    false            +           1259    51804 ?   bid_preparation_task_activity_bid_preparation_task_activity_seq    SEQUENCE     .  ALTER TABLE public.bid_preparation_task_activity ALTER COLUMN bid_preparation_task_activity_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_preparation_task_activity_bid_preparation_task_activity_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    300            '           1259    51779 0   bid_preparation_task_bid_preparation_task_id_seq    SEQUENCE       ALTER TABLE public.bid_preparation_task ALTER COLUMN bid_preparation_task_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_preparation_task_bid_preparation_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    296            *           1259    51794    bid_preparation_task_contacts    TABLE     �   CREATE TABLE public.bid_preparation_task_contacts (
    bid_preparation_task_contacts_id integer NOT NULL,
    bid_preparation_task_id integer,
    user_id integer
);
 1   DROP TABLE public.bid_preparation_task_contacts;
       public         heap    postgres    false            )           1259    51793 ?   bid_preparation_task_contacts_bid_preparation_task_contacts_seq    SEQUENCE     .  ALTER TABLE public.bid_preparation_task_contacts ALTER COLUMN bid_preparation_task_contacts_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_preparation_task_contacts_bid_preparation_task_contacts_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    298            2           1259    51844    bid_preparation_task_docvalt    TABLE     �  CREATE TABLE public.bid_preparation_task_docvalt (
    bid_preparation_task_docvalt_id integer NOT NULL,
    bid_preparation_task_id integer,
    docvalt_dir character varying(50),
    docvalt_filename character varying(100),
    docvalt_cloudpath character varying(255),
    file_type character varying(25),
    file_size character varying(50),
    file_moved boolean DEFAULT false,
    created_date date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 0   DROP TABLE public.bid_preparation_task_docvalt;
       public         heap    postgres    false            1           1259    51843 ?   bid_preparation_task_docvalt_bid_preparation_task_docvalt_i_seq    SEQUENCE     ,  ALTER TABLE public.bid_preparation_task_docvalt ALTER COLUMN bid_preparation_task_docvalt_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_preparation_task_docvalt_bid_preparation_task_docvalt_i_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    306            0           1259    51831    bid_preparation_task_post    TABLE     �   CREATE TABLE public.bid_preparation_task_post (
    bid_preparation_task_post_id integer NOT NULL,
    bid_preparation_task_id integer,
    posted_by integer,
    title character varying(25),
    comment text
);
 -   DROP TABLE public.bid_preparation_task_post;
       public         heap    postgres    false            /           1259    51830 :   bid_preparation_task_post_bid_preparation_task_post_id_seq    SEQUENCE     !  ALTER TABLE public.bid_preparation_task_post ALTER COLUMN bid_preparation_task_post_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_preparation_task_post_bid_preparation_task_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    304            .           1259    51818    bid_preparation_task_subtask    TABLE       CREATE TABLE public.bid_preparation_task_subtask (
    bid_preparation_task_subtask_id integer NOT NULL,
    bid_preparation_task_id integer,
    assign_to integer,
    title character varying(25),
    description text,
    issue_date date,
    due_date date
);
 0   DROP TABLE public.bid_preparation_task_subtask;
       public         heap    postgres    false            -           1259    51817 ?   bid_preparation_task_subtask_bid_preparation_task_subtask_i_seq    SEQUENCE     ,  ALTER TABLE public.bid_preparation_task_subtask ALTER COLUMN bid_preparation_task_subtask_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_preparation_task_subtask_bid_preparation_task_subtask_i_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    302            V           1259    60045 	   bid_stage    TABLE     �   CREATE TABLE public.bid_stage (
    bid_stage_id integer NOT NULL,
    tenant_id integer,
    rfx_id integer,
    default_name character varying(100),
    new_name character varying(100),
    stage_order integer,
    required boolean DEFAULT true
);
    DROP TABLE public.bid_stage;
       public         heap    postgres    false            U           1259    60044    bid_stage_bid_stage_id_seq    SEQUENCE     �   ALTER TABLE public.bid_stage ALTER COLUMN bid_stage_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_stage_bid_stage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    342            X           1259    60062    bid_stage_detail    TABLE       CREATE TABLE public.bid_stage_detail (
    bid_stage_detail_id integer NOT NULL,
    bid_stage_id integer,
    status character varying(25),
    description text,
    created_date date,
    completed boolean DEFAULT false,
    completed_at timestamp without time zone
);
 $   DROP TABLE public.bid_stage_detail;
       public         heap    postgres    false            W           1259    60061 (   bid_stage_detail_bid_stage_detail_id_seq    SEQUENCE     �   ALTER TABLE public.bid_stage_detail ALTER COLUMN bid_stage_detail_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_stage_detail_bid_stage_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    344            T           1259    59959    bid_validity    TABLE     �   CREATE TABLE public.bid_validity (
    bid_validity_id integer NOT NULL,
    tenant_id integer,
    title character varying(100),
    is_active boolean DEFAULT true,
    alias character varying(15)
);
     DROP TABLE public.bid_validity;
       public         heap    postgres    false            S           1259    59958     bid_validity_bid_validity_id_seq    SEQUENCE     �   ALTER TABLE public.bid_validity ALTER COLUMN bid_validity_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bid_validity_bid_validity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    340            �            1259    51343 
   bids_stage    TABLE     �   CREATE TABLE public.bids_stage (
    bids_stage_id integer NOT NULL,
    tenant_id integer,
    default_name character varying(100),
    new_name character varying(100),
    stage_order integer,
    required boolean DEFAULT true
);
    DROP TABLE public.bids_stage;
       public         heap    postgres    false            �            1259    51342    bids_stage_bids_stage_id_seq    SEQUENCE     �   ALTER TABLE public.bids_stage ALTER COLUMN bids_stage_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bids_stage_bids_stage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    230            �            1259    51355    bids_stage_detail    TABLE       CREATE TABLE public.bids_stage_detail (
    bids_stage_detail_id integer NOT NULL,
    bids_stage_id integer,
    status character varying(25),
    description text,
    created_date date,
    completed boolean DEFAULT false,
    completed_at timestamp without time zone
);
 %   DROP TABLE public.bids_stage_detail;
       public         heap    postgres    false            �            1259    51354 *   bids_stage_detail_bids_stage_detail_id_seq    SEQUENCE       ALTER TABLE public.bids_stage_detail ALTER COLUMN bids_stage_detail_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bids_stage_detail_bids_stage_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    232            �            1259    51182    company    TABLE     �  CREATE TABLE public.company (
    company_id integer NOT NULL,
    tenant_id integer,
    company_name character varying(100),
    phone character varying(20),
    email character varying(255),
    address text,
    industry character varying(100),
    website character varying(255),
    created_date timestamp with time zone,
    updated_date timestamp with time zone,
    company_logo character varying(100)
);
    DROP TABLE public.company;
       public         heap    postgres    false            �            1259    51181    company_company_id_seq    SEQUENCE     �   ALTER TABLE public.company ALTER COLUMN company_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.company_company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            \           1259    60101    contacts    TABLE     �   CREATE TABLE public.contacts (
    contact_id integer NOT NULL,
    tenant_id integer,
    rfx_id integer,
    contact_user_id integer,
    conatct_key character varying(50),
    created_date date,
    created_at timestamp without time zone
);
    DROP TABLE public.contacts;
       public         heap    postgres    false            [           1259    60100    contacts_contact_id_seq    SEQUENCE     �   ALTER TABLE public.contacts ALTER COLUMN contact_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contacts_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    348            �            1259    51236    customer    TABLE     g  CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    tenant_id integer,
    company_id integer,
    designation_id integer,
    customer_name character varying(100),
    email character varying(255),
    phone character varying(20),
    address text,
    created_at timestamp without time zone,
    created_date date,
    updated_date date
);
    DROP TABLE public.customer;
       public         heap    postgres    false            �            1259    51235    customer_customer_id_seq    SEQUENCE     �   ALTER TABLE public.customer ALTER COLUMN customer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    224            J           1259    59357    designation    TABLE     �   CREATE TABLE public.designation (
    designation_id integer NOT NULL,
    tenant_id integer,
    title character varying(100),
    type character varying(50),
    description character varying(200)
);
    DROP TABLE public.designation;
       public         heap    postgres    false            I           1259    59356    designation_designation_id_seq    SEQUENCE     �   ALTER TABLE public.designation ALTER COLUMN designation_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.designation_designation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    330                       1259    51644    detailed_review    TABLE     J  CREATE TABLE public.detailed_review (
    detailed_review_id integer NOT NULL,
    rfx_id integer,
    templaate_name character varying(100),
    review_templaate_key character varying(25),
    reference_num character varying(50),
    score_value integer,
    score_display_name character varying(50),
    score_display_description text,
    issued_date date,
    due_date date,
    status character varying(25),
    skip_review boolean DEFAULT false,
    skip_reason text,
    required_revision boolean DEFAULT false,
    created_on date,
    created_at timestamp without time zone
);
 #   DROP TABLE public.detailed_review;
       public         heap    postgres    false                       1259    51677    detailed_review_contacts    TABLE     �   CREATE TABLE public.detailed_review_contacts (
    detailed_review_contacts_id integer NOT NULL,
    detailed_review_id integer,
    user_id integer,
    role character varying(15)
);
 ,   DROP TABLE public.detailed_review_contacts;
       public         heap    postgres    false                       1259    51676 8   detailed_review_contacts_detailed_review_contacts_id_seq    SEQUENCE       ALTER TABLE public.detailed_review_contacts ALTER COLUMN detailed_review_contacts_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.detailed_review_contacts_detailed_review_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    280                       1259    51643 &   detailed_review_detailed_review_id_seq    SEQUENCE     �   ALTER TABLE public.detailed_review ALTER COLUMN detailed_review_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.detailed_review_detailed_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    276                       1259    51659    detailed_review_details    TABLE     �  CREATE TABLE public.detailed_review_details (
    detailed_review_details_id integer NOT NULL,
    detailed_review_id integer,
    skip_review boolean DEFAULT false,
    skip_reason text,
    required_revision boolean DEFAULT false,
    review_approved boolean DEFAULT false,
    review_approved_notes text,
    review_declined boolean DEFAULT false,
    review_declined_notes text,
    review_revison boolean DEFAULT false,
    review_revison_notes text
);
 +   DROP TABLE public.detailed_review_details;
       public         heap    postgres    false                       1259    51658 6   detailed_review_details_detailed_review_details_id_seq    SEQUENCE       ALTER TABLE public.detailed_review_details ALTER COLUMN detailed_review_details_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.detailed_review_details_detailed_review_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    278                       1259    51688    detailed_review_post    TABLE     �   CREATE TABLE public.detailed_review_post (
    detailed_review_post_id integer NOT NULL,
    detailed_review_id integer,
    posted_by integer,
    posted_on timestamp without time zone,
    title character varying(100),
    comment text
);
 (   DROP TABLE public.detailed_review_post;
       public         heap    postgres    false                       1259    51687 0   detailed_review_post_detailed_review_post_id_seq    SEQUENCE       ALTER TABLE public.detailed_review_post ALTER COLUMN detailed_review_post_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.detailed_review_post_detailed_review_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    282                       1259    51701    detailed_review_template    TABLE     =  CREATE TABLE public.detailed_review_template (
    detailed_review_template_id integer NOT NULL,
    detailed_review_id integer,
    review_templaate_key character varying(25),
    item_title character varying(100),
    item_description text,
    required boolean DEFAULT true,
    is_active boolean DEFAULT false
);
 ,   DROP TABLE public.detailed_review_template;
       public         heap    postgres    false                       1259    51700 8   detailed_review_template_detailed_review_template_id_seq    SEQUENCE       ALTER TABLE public.detailed_review_template ALTER COLUMN detailed_review_template_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.detailed_review_template_detailed_review_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    284            H           1259    51998    docvalt    TABLE     	  CREATE TABLE public.docvalt (
    docvalt_id integer NOT NULL,
    tenant_id integer,
    rfx_id integer,
    user_id integer,
    docvalt_key character varying(50),
    docvalt_dir character varying(50),
    docvalt_filename character varying(100),
    docvalt_cloudpath character varying(255),
    file_type character varying(25),
    file_size character varying(50),
    file_moved boolean DEFAULT false,
    created_date date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE public.docvalt;
       public         heap    postgres    false            G           1259    51997    docvalt_docvalt_id_seq    SEQUENCE     �   ALTER TABLE public.docvalt ALTER COLUMN docvalt_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.docvalt_docvalt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    328            4           1259    51856    final_review    TABLE     D  CREATE TABLE public.final_review (
    final_review_id integer NOT NULL,
    rfx_id integer,
    templaate_name character varying(100),
    review_templaate_key character varying(25),
    reference_num character varying(50),
    score_value integer,
    score_display_name character varying(50),
    score_display_description text,
    issued_date date,
    due_date date,
    status character varying(25),
    skip_review boolean DEFAULT false,
    skip_reason text,
    required_revision boolean DEFAULT false,
    created_on date,
    created_at timestamp without time zone
);
     DROP TABLE public.final_review;
       public         heap    postgres    false            8           1259    51889    final_review_contacts    TABLE     �   CREATE TABLE public.final_review_contacts (
    final_review_contacts_id integer NOT NULL,
    final_review_id integer,
    user_id integer,
    role character varying(15)
);
 )   DROP TABLE public.final_review_contacts;
       public         heap    postgres    false            7           1259    51888 2   final_review_contacts_final_review_contacts_id_seq    SEQUENCE       ALTER TABLE public.final_review_contacts ALTER COLUMN final_review_contacts_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.final_review_contacts_final_review_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    312            6           1259    51871    final_review_details    TABLE     �  CREATE TABLE public.final_review_details (
    final_review_details_id integer NOT NULL,
    final_review_id integer,
    skip_review boolean DEFAULT false,
    skip_reason text,
    required_revision boolean DEFAULT false,
    review_approved boolean DEFAULT false,
    review_approved_notes text,
    review_declined boolean DEFAULT false,
    review_declined_notes text,
    review_revison boolean DEFAULT false,
    review_revison_notes text
);
 (   DROP TABLE public.final_review_details;
       public         heap    postgres    false            5           1259    51870 0   final_review_details_final_review_details_id_seq    SEQUENCE       ALTER TABLE public.final_review_details ALTER COLUMN final_review_details_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.final_review_details_final_review_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    310            3           1259    51855     final_review_final_review_id_seq    SEQUENCE     �   ALTER TABLE public.final_review ALTER COLUMN final_review_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.final_review_final_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    308            :           1259    51900    final_review_post    TABLE     �   CREATE TABLE public.final_review_post (
    final_review_post_id integer NOT NULL,
    final_review_id integer,
    posted_by integer,
    posted_on timestamp without time zone,
    title character varying(100),
    comment text
);
 %   DROP TABLE public.final_review_post;
       public         heap    postgres    false            9           1259    51899 *   final_review_post_final_review_post_id_seq    SEQUENCE       ALTER TABLE public.final_review_post ALTER COLUMN final_review_post_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.final_review_post_final_review_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    314            <           1259    51913    final_review_template    TABLE     4  CREATE TABLE public.final_review_template (
    final_review_template_id integer NOT NULL,
    final_review_id integer,
    review_templaate_key character varying(25),
    item_title character varying(100),
    item_description text,
    required boolean DEFAULT true,
    is_active boolean DEFAULT false
);
 )   DROP TABLE public.final_review_template;
       public         heap    postgres    false            ;           1259    51912 2   final_review_template_final_review_template_id_seq    SEQUENCE       ALTER TABLE public.final_review_template ALTER COLUMN final_review_template_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.final_review_template_final_review_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    316            �            1259    51259    opportunity    TABLE     �  CREATE TABLE public.opportunity (
    opportunity_id integer NOT NULL,
    tenant_id integer,
    company_id integer,
    customer_id integer,
    title character varying(100),
    type character varying(50),
    probability character varying(50),
    total_value numeric DEFAULT 0.00,
    crm_id integer,
    customer_name character varying(100),
    end_user_name character varying(100),
    region character varying(100),
    industry_code character varying(25),
    business_unit character varying(100),
    project_type character varying(100),
    delivery_duration character varying(100),
    stage character varying(150),
    status character varying(25),
    expected_award_date date,
    expected_rfx_date date,
    close_date date,
    competition character varying(100),
    gross_profit_percent numeric DEFAULT 0.00,
    gross_profit_value numeric DEFAULT 0.00,
    description text,
    last_updated_at timestamp without time zone,
    forcasted boolean DEFAULT false
);
    DROP TABLE public.opportunity;
       public         heap    postgres    false            �            1259    51258    opportunity_opportunity_id_seq    SEQUENCE     �   ALTER TABLE public.opportunity ALTER COLUMN opportunity_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.opportunity_opportunity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    226            >           1259    51928    order_review    TABLE     D  CREATE TABLE public.order_review (
    order_review_id integer NOT NULL,
    rfx_id integer,
    templaate_name character varying(100),
    review_templaate_key character varying(25),
    reference_num character varying(50),
    score_value integer,
    score_display_name character varying(50),
    score_display_description text,
    issued_date date,
    due_date date,
    status character varying(25),
    skip_review boolean DEFAULT false,
    skip_reason text,
    required_revision boolean DEFAULT false,
    created_on date,
    created_at timestamp without time zone
);
     DROP TABLE public.order_review;
       public         heap    postgres    false            @           1259    51943    order_review_contacts    TABLE     �   CREATE TABLE public.order_review_contacts (
    order_review_contacts_id integer NOT NULL,
    order_review_id integer,
    user_id integer,
    role character varying(15)
);
 )   DROP TABLE public.order_review_contacts;
       public         heap    postgres    false            ?           1259    51942 2   order_review_contacts_order_review_contacts_id_seq    SEQUENCE       ALTER TABLE public.order_review_contacts ALTER COLUMN order_review_contacts_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_review_contacts_order_review_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    320            =           1259    51927     order_review_order_review_id_seq    SEQUENCE     �   ALTER TABLE public.order_review ALTER COLUMN order_review_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_review_order_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    318            B           1259    51954    order_review_post    TABLE     �   CREATE TABLE public.order_review_post (
    order_review_post_id integer NOT NULL,
    order_review_id integer,
    posted_by integer,
    posted_on timestamp without time zone,
    title character varying(100),
    comment text
);
 %   DROP TABLE public.order_review_post;
       public         heap    postgres    false            A           1259    51953 *   order_review_post_order_review_post_id_seq    SEQUENCE       ALTER TABLE public.order_review_post ALTER COLUMN order_review_post_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_review_post_order_review_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    322            D           1259    51967    order_review_template    TABLE     4  CREATE TABLE public.order_review_template (
    order_review_template_id integer NOT NULL,
    order_review_id integer,
    review_templaate_key character varying(25),
    item_title character varying(100),
    item_description text,
    required boolean DEFAULT true,
    is_active boolean DEFAULT false
);
 )   DROP TABLE public.order_review_template;
       public         heap    postgres    false            C           1259    51966 2   order_review_template_order_review_template_id_seq    SEQUENCE       ALTER TABLE public.order_review_template ALTER COLUMN order_review_template_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_review_template_order_review_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    324            
           1259    51574    prelim_review    TABLE     �  CREATE TABLE public.prelim_review (
    prelim_review_id integer NOT NULL,
    rfx_id integer,
    templaate_name character varying(100),
    review_templaate_key character varying(25),
    reference_num character varying(50),
    score_value integer,
    score_display_name character varying(50),
    score_display_description text,
    issued_date date,
    due_date date,
    status character varying(25),
    created_on date,
    created_at timestamp without time zone
);
 !   DROP TABLE public.prelim_review;
       public         heap    postgres    false                       1259    51605    prelim_review_contacts    TABLE     �   CREATE TABLE public.prelim_review_contacts (
    prelim_review_contacts_id integer NOT NULL,
    prelim_review_id integer,
    user_id integer,
    role character varying(15)
);
 *   DROP TABLE public.prelim_review_contacts;
       public         heap    postgres    false                       1259    51604 4   prelim_review_contacts_prelim_review_contacts_id_seq    SEQUENCE       ALTER TABLE public.prelim_review_contacts ALTER COLUMN prelim_review_contacts_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.prelim_review_contacts_prelim_review_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    270                       1259    51587    prelim_review_details    TABLE     �  CREATE TABLE public.prelim_review_details (
    prelim_review_details_id integer NOT NULL,
    prelim_review_id integer,
    skip_review boolean DEFAULT false,
    skip_reason text,
    required_revision boolean DEFAULT false,
    review_approved boolean DEFAULT false,
    review_approved_notes text,
    review_declined boolean DEFAULT false,
    review_declined_notes text,
    review_revison boolean DEFAULT false,
    review_revison_notes text
);
 )   DROP TABLE public.prelim_review_details;
       public         heap    postgres    false                       1259    51586 2   prelim_review_details_prelim_review_details_id_seq    SEQUENCE       ALTER TABLE public.prelim_review_details ALTER COLUMN prelim_review_details_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.prelim_review_details_prelim_review_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    268                       1259    51616    prelim_review_post    TABLE     �   CREATE TABLE public.prelim_review_post (
    prelim_review_post_id integer NOT NULL,
    prelim_review_id integer,
    posted_by integer,
    posted_on timestamp without time zone,
    title character varying(100),
    comment text
);
 &   DROP TABLE public.prelim_review_post;
       public         heap    postgres    false                       1259    51615 ,   prelim_review_post_prelim_review_post_id_seq    SEQUENCE       ALTER TABLE public.prelim_review_post ALTER COLUMN prelim_review_post_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.prelim_review_post_prelim_review_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    272            	           1259    51573 "   prelim_review_prelim_review_id_seq    SEQUENCE     �   ALTER TABLE public.prelim_review ALTER COLUMN prelim_review_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.prelim_review_prelim_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    266                       1259    51629    prelim_review_template    TABLE     7  CREATE TABLE public.prelim_review_template (
    prelim_review_template_id integer NOT NULL,
    prelim_review_id integer,
    review_templaate_key character varying(25),
    item_title character varying(100),
    item_description text,
    required boolean DEFAULT true,
    is_active boolean DEFAULT false
);
 *   DROP TABLE public.prelim_review_template;
       public         heap    postgres    false                       1259    51628 4   prelim_review_template_prelim_review_template_id_seq    SEQUENCE       ALTER TABLE public.prelim_review_template ALTER COLUMN prelim_review_template_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.prelim_review_template_prelim_review_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    274                       1259    51515    purchase_order    TABLE     k  CREATE TABLE public.purchase_order (
    purchase_order_id integer NOT NULL,
    rfx_id integer,
    assign_to integer,
    acknowledged_by integer,
    acknowledgement_document integer,
    purchase_order_num character varying(50),
    title character varying(100),
    currency character varying(15),
    order_value numeric DEFAULT 0.00,
    description text,
    issued_date date,
    delivery_date date,
    acknowledgement_deadline date,
    acknowledgement_comment text,
    acknowledgement_date date,
    acknowledged_on date,
    acknowledged boolean DEFAULT false,
    order_complete boolean DEFAULT false
);
 "   DROP TABLE public.purchase_order;
       public         heap    postgres    false                       1259    51531    purchase_order_acknowledgement    TABLE     �  CREATE TABLE public.purchase_order_acknowledgement (
    purchase_order_acknowledgement integer NOT NULL,
    purchase_order_id integer,
    rfx_id integer,
    acknowledged_by integer,
    acknowledgement_date date,
    acknowledgement_comment text,
    acknowledged boolean DEFAULT false,
    acknowledgement_document integer,
    acknowledgement_submitted_on timestamp without time zone
);
 2   DROP TABLE public.purchase_order_acknowledgement;
       public         heap    postgres    false                       1259    51530 ?   purchase_order_acknowledgemen_purchase_order_acknowledgemen_seq    SEQUENCE     -  ALTER TABLE public.purchase_order_acknowledgement ALTER COLUMN purchase_order_acknowledgement ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.purchase_order_acknowledgemen_purchase_order_acknowledgemen_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    260                       1259    51558    purchase_order_meta    TABLE     �   CREATE TABLE public.purchase_order_meta (
    purchase_order_meta_id integer NOT NULL,
    rfx_id integer,
    purchase_order_id integer,
    order_post_id integer,
    meta_key character varying(25),
    meta_id integer
);
 '   DROP TABLE public.purchase_order_meta;
       public         heap    postgres    false                       1259    51557 .   purchase_order_meta_purchase_order_meta_id_seq    SEQUENCE     	  ALTER TABLE public.purchase_order_meta ALTER COLUMN purchase_order_meta_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.purchase_order_meta_purchase_order_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    264                       1259    51545    purchase_order_post    TABLE     �   CREATE TABLE public.purchase_order_post (
    order_post_id integer NOT NULL,
    rfx_id integer,
    purchase_order_id integer,
    post_by integer,
    title character varying(100),
    comment text,
    post_on timestamp without time zone
);
 '   DROP TABLE public.purchase_order_post;
       public         heap    postgres    false                       1259    51544 %   purchase_order_post_order_post_id_seq    SEQUENCE     �   ALTER TABLE public.purchase_order_post ALTER COLUMN order_post_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.purchase_order_post_order_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    262                       1259    51514 $   purchase_order_purchase_order_id_seq    SEQUENCE     �   ALTER TABLE public.purchase_order ALTER COLUMN purchase_order_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.purchase_order_purchase_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    258            L           1259    59368    rfx    TABLE       CREATE TABLE public.rfx (
    rfx_id integer NOT NULL,
    tenant_id integer,
    opportunity_id integer,
    initiator_id integer,
    rfx_bid_assignto integer,
    rfx_title character varying(100),
    rfx_number character varying(50),
    under_existing_agreement boolean DEFAULT false,
    status character varying(50),
    previous_rfx_ref_num character varying(50),
    revision_of_previous_rfx boolean DEFAULT false,
    agreement_ref_num character varying(50),
    issued_date date,
    due_date date,
    crm_id integer,
    bid_number character varying(50),
    request_for_bid boolean DEFAULT false,
    submission_instructions text,
    visit_worksite boolean DEFAULT false,
    visit_worksite_instructions text,
    tech_clarification_deadline date,
    com_clarification_deadline date,
    expected_award_date date,
    enduser_id integer,
    enduser_type character varying(15),
    rfx_type_id integer,
    bid_validity_id integer,
    rfx_content_submission_id integer,
    rfx_submission_mode_id integer,
    rfx_stage_id integer
);
    DROP TABLE public.rfx;
       public         heap    postgres    false            �            1259    51303    rfx_acknowledgement    TABLE     T  CREATE TABLE public.rfx_acknowledgement (
    rfx_acknowledgement integer NOT NULL,
    rfx_id integer,
    acknowledged_by integer,
    acknowledgement_date date,
    acknowledgement_comment text,
    acknowledged boolean DEFAULT false,
    acknowledgement_document integer,
    acknowledgement_submitted_on timestamp without time zone
);
 '   DROP TABLE public.rfx_acknowledgement;
       public         heap    postgres    false            �            1259    51302 +   rfx_acknowledgement_rfx_acknowledgement_seq    SEQUENCE       ALTER TABLE public.rfx_acknowledgement ALTER COLUMN rfx_acknowledgement ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rfx_acknowledgement_rfx_acknowledgement_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    228            �            1259    51369    rfx_clarification    TABLE     �  CREATE TABLE public.rfx_clarification (
    rfx_clarification_id integer NOT NULL,
    rfx_id integer,
    submitted_by integer,
    assign_to integer,
    rfx_clarification_ref_num character varying(255),
    clarification_title character varying(50),
    clarification_type character varying(50),
    clarification_issued_date date,
    clarification_due_date date,
    status character varying(25)
);
 %   DROP TABLE public.rfx_clarification;
       public         heap    postgres    false            �            1259    51393    rfx_clarification_meta    TABLE     �   CREATE TABLE public.rfx_clarification_meta (
    rfx_clarification_meta_id integer NOT NULL,
    rfx_id integer,
    rfx_clarification_id integer,
    rfx_clarification_post_id integer,
    meta_key character varying(25),
    meta_id integer
);
 *   DROP TABLE public.rfx_clarification_meta;
       public         heap    postgres    false            �            1259    51392 4   rfx_clarification_meta_rfx_clarification_meta_id_seq    SEQUENCE       ALTER TABLE public.rfx_clarification_meta ALTER COLUMN rfx_clarification_meta_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rfx_clarification_meta_rfx_clarification_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    238            �            1259    51380    rfx_clarification_post    TABLE       CREATE TABLE public.rfx_clarification_post (
    rfx_clarification_post_id integer NOT NULL,
    rfx_clarification_id integer,
    posted_by integer,
    post_number integer,
    posted_on timestamp without time zone,
    title character varying(100),
    comment text
);
 *   DROP TABLE public.rfx_clarification_post;
       public         heap    postgres    false            �            1259    51379 4   rfx_clarification_post_rfx_clarification_post_id_seq    SEQUENCE       ALTER TABLE public.rfx_clarification_post ALTER COLUMN rfx_clarification_post_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rfx_clarification_post_rfx_clarification_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    236            �            1259    51368 *   rfx_clarification_rfx_clarification_id_seq    SEQUENCE       ALTER TABLE public.rfx_clarification ALTER COLUMN rfx_clarification_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rfx_clarification_rfx_clarification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    234            P           1259    59935    rfx_content_submission    TABLE     �   CREATE TABLE public.rfx_content_submission (
    rfx_content_submission_id integer NOT NULL,
    tenant_id integer,
    title character varying(100),
    is_active boolean DEFAULT true,
    alias character varying(15)
);
 *   DROP TABLE public.rfx_content_submission;
       public         heap    postgres    false            O           1259    59934 4   rfx_content_submission_rfx_content_submission_id_seq    SEQUENCE       ALTER TABLE public.rfx_content_submission ALTER COLUMN rfx_content_submission_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rfx_content_submission_rfx_content_submission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    336            K           1259    59367    rfx_rfx_id_seq    SEQUENCE     �   ALTER TABLE public.rfx ALTER COLUMN rfx_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rfx_rfx_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    332            Z           1259    60089 	   rfx_stage    TABLE     �   CREATE TABLE public.rfx_stage (
    rfx_stage_id integer NOT NULL,
    tenant_id integer,
    title character varying(100),
    is_active boolean DEFAULT true,
    alias character varying(15)
);
    DROP TABLE public.rfx_stage;
       public         heap    postgres    false            Y           1259    60088    rfx_stage_rfx_stage_id_seq    SEQUENCE     �   ALTER TABLE public.rfx_stage ALTER COLUMN rfx_stage_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rfx_stage_rfx_stage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    346            R           1259    59947    rfx_submission_mode    TABLE     �   CREATE TABLE public.rfx_submission_mode (
    rfx_submission_mode_id integer NOT NULL,
    tenant_id integer,
    title character varying(100),
    is_active boolean DEFAULT true,
    alias character varying(15)
);
 '   DROP TABLE public.rfx_submission_mode;
       public         heap    postgres    false            Q           1259    59946 .   rfx_submission_mode_rfx_submission_mode_id_seq    SEQUENCE     	  ALTER TABLE public.rfx_submission_mode ALTER COLUMN rfx_submission_mode_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rfx_submission_mode_rfx_submission_mode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    338            N           1259    59923    rfx_type    TABLE     �   CREATE TABLE public.rfx_type (
    rfx_type_id integer NOT NULL,
    tenant_id integer,
    title character varying(100),
    is_active boolean DEFAULT true,
    alias character varying(15)
);
    DROP TABLE public.rfx_type;
       public         heap    postgres    false            M           1259    59922    rfx_type_rfx_type_id_seq    SEQUENCE     �   ALTER TABLE public.rfx_type ALTER COLUMN rfx_type_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rfx_type_rfx_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    334            �            1259    51195    team    TABLE     �   CREATE TABLE public.team (
    team_id integer NOT NULL,
    tenant_id integer,
    team_title character varying(50),
    team_role character varying(50),
    role_level smallint
);
    DROP TABLE public.team;
       public         heap    postgres    false            �            1259    51194    team_team_id_seq    SEQUENCE     �   ALTER TABLE public.team ALTER COLUMN team_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.team_team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            �            1259    51166    tenant    TABLE     �  CREATE TABLE public.tenant (
    tenant_id integer NOT NULL,
    tenant_name character varying(100),
    tenant_title character varying(100),
    tenant_logo character varying(255),
    tenant_description text,
    contact_person character varying(100),
    contact_email character varying(100),
    contact_phone character varying(20),
    contact_address text,
    subscription_start_date date,
    subscription_end_date date,
    subscription_type character varying(50),
    created_on date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    location_country character varying(100),
    location_state character varying(100),
    location_zip character varying(10),
    domain_url character varying(255),
    private_key character varying(255),
    public_key character varying(255),
    email_verified boolean DEFAULT false,
    tenant_status character varying(25),
    tenant_is_active boolean DEFAULT false
);
    DROP TABLE public.tenant;
       public         heap    postgres    false            �            1259    51165    tenant_tenant_id_seq    SEQUENCE     �   ALTER TABLE public.tenant ALTER COLUMN tenant_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tenant_tenant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            F           1259    51982    user_activities    TABLE     W  CREATE TABLE public.user_activities (
    user_activities_id integer NOT NULL,
    tenant_id integer,
    rfx_id integer,
    user_id integer,
    meta_key character varying(25),
    meta_id integer,
    title character varying(100),
    activity_type character varying(100),
    created_on date,
    created_at timestamp without time zone
);
 #   DROP TABLE public.user_activities;
       public         heap    postgres    false            E           1259    51981 &   user_activities_user_activities_id_seq    SEQUENCE     �   ALTER TABLE public.user_activities ALTER COLUMN user_activities_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_activities_user_activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    326            �            1259    51206    users    TABLE     l  CREATE TABLE public.users (
    user_id integer NOT NULL,
    tenant_id integer,
    team_id integer,
    designation_id integer,
    company_id integer,
    user_name character varying(100),
    email character varying(255),
    password character varying(255),
    first_name character varying(50),
    middle_name character varying(50),
    last_name character varying(50),
    user_role character varying(25),
    role_level character varying(25),
    registration_date timestamp with time zone DEFAULT '2005-01-24 00:00:00+05'::timestamp with time zone,
    last_login_at timestamp without time zone,
    created_on date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    active boolean DEFAULT false,
    verified boolean DEFAULT false,
    password_salt character varying(255),
    user_profile_photo character varying(255)
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    51205    users_user_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    222                      0    51456    bid_clarification 
   TABLE DATA           �   COPY public.bid_clarification (bid_clarification_id, rfx_id, submitted_to, assigned_to, title, type, issued_date, due_date, status, reference_num, completed, completed_date) FROM stdin;
    public          postgres    false    248   
{                 0    51468    bid_clarification_meta 
   TABLE DATA           |   COPY public.bid_clarification_meta (bid_clarification_meta_id, rfx_id, bid_clarification_id, meta_key, meta_id) FROM stdin;
    public          postgres    false    250   '{      "          0    51479    bid_clarification_revision 
   TABLE DATA           �   COPY public.bid_clarification_revision (bid_clarification_revision_id, rfx_id, bid_clarification_id, comment, due_date, created_date, created_at, revision_completed) FROM stdin;
    public          postgres    false    252   D{      $          0    51493    bid_clarification_revision_line 
   TABLE DATA           �   COPY public.bid_clarification_revision_line (bid_clarification_revision_line_id, bid_clarification_id, bid_clarification_revision_id) FROM stdin;
    public          postgres    false    254   a{      &          0    51504    bid_clarification_revision_meta 
   TABLE DATA           �   COPY public.bid_clarification_revision_meta (bid_clarification_revision_meta_id, bid_clarification_revision_id, rfx_id, bid_clarification_id, meta_key, meta_id) FROM stdin;
    public          postgres    false    256   ~{      D          0    51716    bid_deliverables 
   TABLE DATA           �   COPY public.bid_deliverables (bid_deliverables_id, rfx_id, template_title, deliverable_type, deliverable_count, created_by, created_on) FROM stdin;
    public          postgres    false    286   �{      F          0    51727    bid_deliverables_template 
   TABLE DATA           �   COPY public.bid_deliverables_template (bid_deliverables_template_id, bid_deliverables_id, deliverable_templaate_key, item_title, item_description, required, is_active) FROM stdin;
    public          postgres    false    288   �{                0    51404    bid_documents 
   TABLE DATA           �   COPY public.bid_documents (bid_documents_id, rfx_id, submit_to_customer, assigned_to, submitted_to, title, reference_num, document_type, request_revision, status, comment) FROM stdin;
    public          postgres    false    240   �{                0    51418    bid_documents_acknowledgement 
   TABLE DATA           �   COPY public.bid_documents_acknowledgement (bid_documents_acknowledgement, bid_documents_id, rfx_id, acknowledged_by, acknowledgement_date, acknowledgement_comment, acknowledged, acknowledgement_document, acknowledgement_submitted_on) FROM stdin;
    public          postgres    false    242   ;|                0    51445    bid_documents_meta 
   TABLE DATA           �   COPY public.bid_documents_meta (bid_documents_meta_id, rfx_id, bid_documents_id, bid_documents_post_id, meta_key, meta_id) FROM stdin;
    public          postgres    false    246   �|                0    51432    bid_documents_post 
   TABLE DATA           �   COPY public.bid_documents_post (bid_documents_post_id, bid_documents_id, posted_by, post_number, posted_on, title, comment) FROM stdin;
    public          postgres    false    244   �|      H          0    51742    bid_kickoff_meeting 
   TABLE DATA           �   COPY public.bid_kickoff_meeting (bid_kickoff_meeting_id, rfx_id, meeting_title, meeting_location, meeting_date, meeting_start_time, meeting_end_time, created_on) FROM stdin;
    public          postgres    false    290   ;}      J          0    51753    bid_kickoff_meeting_contacts 
   TABLE DATA           �   COPY public.bid_kickoff_meeting_contacts (bid_kickoff_meeting_contacts_id, bid_kickoff_meeting_id, rfx_id, user_id, invite_sent, email, created_on) FROM stdin;
    public          postgres    false    292   X}      L          0    51765    bid_kickoff_meeting_template 
   TABLE DATA           �   COPY public.bid_kickoff_meeting_template (bid_kickoff_meeting_template_id, bid_kickoff_meeting_id, deliverable_templaate_key, item_title, item_description, required, is_active) FROM stdin;
    public          postgres    false    294   u}      N          0    51780    bid_preparation_task 
   TABLE DATA           �   COPY public.bid_preparation_task (bid_preparation_task_id, bid_deliverables_template_id, assign_to, task_title, task_description, type, priority, issue_date, due_date, log_spent_hours, log_estimated_time, log_notes, completed) FROM stdin;
    public          postgres    false    296   �}      R          0    51805    bid_preparation_task_activity 
   TABLE DATA           �   COPY public.bid_preparation_task_activity (bid_preparation_task_activity_id, bid_preparation_task_id, title, description) FROM stdin;
    public          postgres    false    300   �}      P          0    51794    bid_preparation_task_contacts 
   TABLE DATA           {   COPY public.bid_preparation_task_contacts (bid_preparation_task_contacts_id, bid_preparation_task_id, user_id) FROM stdin;
    public          postgres    false    298   �}      X          0    51844    bid_preparation_task_docvalt 
   TABLE DATA           �   COPY public.bid_preparation_task_docvalt (bid_preparation_task_docvalt_id, bid_preparation_task_id, docvalt_dir, docvalt_filename, docvalt_cloudpath, file_type, file_size, file_moved, created_date, created_at, updated_at) FROM stdin;
    public          postgres    false    306   �}      V          0    51831    bid_preparation_task_post 
   TABLE DATA           �   COPY public.bid_preparation_task_post (bid_preparation_task_post_id, bid_preparation_task_id, posted_by, title, comment) FROM stdin;
    public          postgres    false    304   ~      T          0    51818    bid_preparation_task_subtask 
   TABLE DATA           �   COPY public.bid_preparation_task_subtask (bid_preparation_task_subtask_id, bid_preparation_task_id, assign_to, title, description, issue_date, due_date) FROM stdin;
    public          postgres    false    302   #~      |          0    60045 	   bid_stage 
   TABLE DATA           s   COPY public.bid_stage (bid_stage_id, tenant_id, rfx_id, default_name, new_name, stage_order, required) FROM stdin;
    public          postgres    false    342   @~      ~          0    60062    bid_stage_detail 
   TABLE DATA           �   COPY public.bid_stage_detail (bid_stage_detail_id, bid_stage_id, status, description, created_date, completed, completed_at) FROM stdin;
    public          postgres    false    344   ]~      z          0    59959    bid_validity 
   TABLE DATA           [   COPY public.bid_validity (bid_validity_id, tenant_id, title, is_active, alias) FROM stdin;
    public          postgres    false    340   z~                0    51343 
   bids_stage 
   TABLE DATA           m   COPY public.bids_stage (bids_stage_id, tenant_id, default_name, new_name, stage_order, required) FROM stdin;
    public          postgres    false    230   �~                0    51355    bids_stage_detail 
   TABLE DATA           �   COPY public.bids_stage_detail (bids_stage_detail_id, bids_stage_id, status, description, created_date, completed, completed_at) FROM stdin;
    public          postgres    false    232   �~                 0    51182    company 
   TABLE DATA           �   COPY public.company (company_id, tenant_id, company_name, phone, email, address, industry, website, created_date, updated_date, company_logo) FROM stdin;
    public          postgres    false    218   �~      �          0    60101    contacts 
   TABLE DATA           y   COPY public.contacts (contact_id, tenant_id, rfx_id, contact_user_id, conatct_key, created_date, created_at) FROM stdin;
    public          postgres    false    348   �                0    51236    customer 
   TABLE DATA           �   COPY public.customer (customer_id, tenant_id, company_id, designation_id, customer_name, email, phone, address, created_at, created_date, updated_date) FROM stdin;
    public          postgres    false    224   X�      p          0    59357    designation 
   TABLE DATA           Z   COPY public.designation (designation_id, tenant_id, title, type, description) FROM stdin;
    public          postgres    false    330   ��      :          0    51644    detailed_review 
   TABLE DATA             COPY public.detailed_review (detailed_review_id, rfx_id, templaate_name, review_templaate_key, reference_num, score_value, score_display_name, score_display_description, issued_date, due_date, status, skip_review, skip_reason, required_revision, created_on, created_at) FROM stdin;
    public          postgres    false    276   �      >          0    51677    detailed_review_contacts 
   TABLE DATA           r   COPY public.detailed_review_contacts (detailed_review_contacts_id, detailed_review_id, user_id, role) FROM stdin;
    public          postgres    false    280   �      <          0    51659    detailed_review_details 
   TABLE DATA             COPY public.detailed_review_details (detailed_review_details_id, detailed_review_id, skip_review, skip_reason, required_revision, review_approved, review_approved_notes, review_declined, review_declined_notes, review_revison, review_revison_notes) FROM stdin;
    public          postgres    false    278   ,�      @          0    51688    detailed_review_post 
   TABLE DATA           �   COPY public.detailed_review_post (detailed_review_post_id, detailed_review_id, posted_by, posted_on, title, comment) FROM stdin;
    public          postgres    false    282   I�      B          0    51701    detailed_review_template 
   TABLE DATA           �   COPY public.detailed_review_template (detailed_review_template_id, detailed_review_id, review_templaate_key, item_title, item_description, required, is_active) FROM stdin;
    public          postgres    false    284   f�      n          0    51998    docvalt 
   TABLE DATA           �   COPY public.docvalt (docvalt_id, tenant_id, rfx_id, user_id, docvalt_key, docvalt_dir, docvalt_filename, docvalt_cloudpath, file_type, file_size, file_moved, created_date, created_at, updated_at) FROM stdin;
    public          postgres    false    328   ��      Z          0    51856    final_review 
   TABLE DATA             COPY public.final_review (final_review_id, rfx_id, templaate_name, review_templaate_key, reference_num, score_value, score_display_name, score_display_description, issued_date, due_date, status, skip_review, skip_reason, required_revision, created_on, created_at) FROM stdin;
    public          postgres    false    308   �      ^          0    51889    final_review_contacts 
   TABLE DATA           i   COPY public.final_review_contacts (final_review_contacts_id, final_review_id, user_id, role) FROM stdin;
    public          postgres    false    312   %�      \          0    51871    final_review_details 
   TABLE DATA           �   COPY public.final_review_details (final_review_details_id, final_review_id, skip_review, skip_reason, required_revision, review_approved, review_approved_notes, review_declined, review_declined_notes, review_revison, review_revison_notes) FROM stdin;
    public          postgres    false    310   B�      `          0    51900    final_review_post 
   TABLE DATA           x   COPY public.final_review_post (final_review_post_id, final_review_id, posted_by, posted_on, title, comment) FROM stdin;
    public          postgres    false    314   _�      b          0    51913    final_review_template 
   TABLE DATA           �   COPY public.final_review_template (final_review_template_id, final_review_id, review_templaate_key, item_title, item_description, required, is_active) FROM stdin;
    public          postgres    false    316   |�                0    51259    opportunity 
   TABLE DATA           �  COPY public.opportunity (opportunity_id, tenant_id, company_id, customer_id, title, type, probability, total_value, crm_id, customer_name, end_user_name, region, industry_code, business_unit, project_type, delivery_duration, stage, status, expected_award_date, expected_rfx_date, close_date, competition, gross_profit_percent, gross_profit_value, description, last_updated_at, forcasted) FROM stdin;
    public          postgres    false    226   ��      d          0    51928    order_review 
   TABLE DATA             COPY public.order_review (order_review_id, rfx_id, templaate_name, review_templaate_key, reference_num, score_value, score_display_name, score_display_description, issued_date, due_date, status, skip_review, skip_reason, required_revision, created_on, created_at) FROM stdin;
    public          postgres    false    318   3�      f          0    51943    order_review_contacts 
   TABLE DATA           i   COPY public.order_review_contacts (order_review_contacts_id, order_review_id, user_id, role) FROM stdin;
    public          postgres    false    320   P�      h          0    51954    order_review_post 
   TABLE DATA           x   COPY public.order_review_post (order_review_post_id, order_review_id, posted_by, posted_on, title, comment) FROM stdin;
    public          postgres    false    322   m�      j          0    51967    order_review_template 
   TABLE DATA           �   COPY public.order_review_template (order_review_template_id, order_review_id, review_templaate_key, item_title, item_description, required, is_active) FROM stdin;
    public          postgres    false    324   ��      0          0    51574    prelim_review 
   TABLE DATA           �   COPY public.prelim_review (prelim_review_id, rfx_id, templaate_name, review_templaate_key, reference_num, score_value, score_display_name, score_display_description, issued_date, due_date, status, created_on, created_at) FROM stdin;
    public          postgres    false    266   ��      4          0    51605    prelim_review_contacts 
   TABLE DATA           l   COPY public.prelim_review_contacts (prelim_review_contacts_id, prelim_review_id, user_id, role) FROM stdin;
    public          postgres    false    270   ă      2          0    51587    prelim_review_details 
   TABLE DATA           �   COPY public.prelim_review_details (prelim_review_details_id, prelim_review_id, skip_review, skip_reason, required_revision, review_approved, review_approved_notes, review_declined, review_declined_notes, review_revison, review_revison_notes) FROM stdin;
    public          postgres    false    268   �      6          0    51616    prelim_review_post 
   TABLE DATA           {   COPY public.prelim_review_post (prelim_review_post_id, prelim_review_id, posted_by, posted_on, title, comment) FROM stdin;
    public          postgres    false    272   ��      8          0    51629    prelim_review_template 
   TABLE DATA           �   COPY public.prelim_review_template (prelim_review_template_id, prelim_review_id, review_templaate_key, item_title, item_description, required, is_active) FROM stdin;
    public          postgres    false    274   �      (          0    51515    purchase_order 
   TABLE DATA           L  COPY public.purchase_order (purchase_order_id, rfx_id, assign_to, acknowledged_by, acknowledgement_document, purchase_order_num, title, currency, order_value, description, issued_date, delivery_date, acknowledgement_deadline, acknowledgement_comment, acknowledgement_date, acknowledged_on, acknowledged, order_complete) FROM stdin;
    public          postgres    false    258   8�      *          0    51531    purchase_order_acknowledgement 
   TABLE DATA           �   COPY public.purchase_order_acknowledgement (purchase_order_acknowledgement, purchase_order_id, rfx_id, acknowledged_by, acknowledgement_date, acknowledgement_comment, acknowledged, acknowledgement_document, acknowledgement_submitted_on) FROM stdin;
    public          postgres    false    260   U�      .          0    51558    purchase_order_meta 
   TABLE DATA           �   COPY public.purchase_order_meta (purchase_order_meta_id, rfx_id, purchase_order_id, order_post_id, meta_key, meta_id) FROM stdin;
    public          postgres    false    264   r�      ,          0    51545    purchase_order_post 
   TABLE DATA           y   COPY public.purchase_order_post (order_post_id, rfx_id, purchase_order_id, post_by, title, comment, post_on) FROM stdin;
    public          postgres    false    262   ��      r          0    59368    rfx 
   TABLE DATA           %  COPY public.rfx (rfx_id, tenant_id, opportunity_id, initiator_id, rfx_bid_assignto, rfx_title, rfx_number, under_existing_agreement, status, previous_rfx_ref_num, revision_of_previous_rfx, agreement_ref_num, issued_date, due_date, crm_id, bid_number, request_for_bid, submission_instructions, visit_worksite, visit_worksite_instructions, tech_clarification_deadline, com_clarification_deadline, expected_award_date, enduser_id, enduser_type, rfx_type_id, bid_validity_id, rfx_content_submission_id, rfx_submission_mode_id, rfx_stage_id) FROM stdin;
    public          postgres    false    332   ��      
          0    51303    rfx_acknowledgement 
   TABLE DATA           �   COPY public.rfx_acknowledgement (rfx_acknowledgement, rfx_id, acknowledged_by, acknowledgement_date, acknowledgement_comment, acknowledged, acknowledgement_document, acknowledgement_submitted_on) FROM stdin;
    public          postgres    false    228   ͆                0    51369    rfx_clarification 
   TABLE DATA           �   COPY public.rfx_clarification (rfx_clarification_id, rfx_id, submitted_by, assign_to, rfx_clarification_ref_num, clarification_title, clarification_type, clarification_issued_date, clarification_due_date, status) FROM stdin;
    public          postgres    false    234   �                0    51393    rfx_clarification_meta 
   TABLE DATA           �   COPY public.rfx_clarification_meta (rfx_clarification_meta_id, rfx_id, rfx_clarification_id, rfx_clarification_post_id, meta_key, meta_id) FROM stdin;
    public          postgres    false    238   }�                0    51380    rfx_clarification_post 
   TABLE DATA           �   COPY public.rfx_clarification_post (rfx_clarification_post_id, rfx_clarification_id, posted_by, post_number, posted_on, title, comment) FROM stdin;
    public          postgres    false    236         v          0    59935    rfx_content_submission 
   TABLE DATA           o   COPY public.rfx_content_submission (rfx_content_submission_id, tenant_id, title, is_active, alias) FROM stdin;
    public          postgres    false    336   G�      �          0    60089 	   rfx_stage 
   TABLE DATA           U   COPY public.rfx_stage (rfx_stage_id, tenant_id, title, is_active, alias) FROM stdin;
    public          postgres    false    346   ��      x          0    59947    rfx_submission_mode 
   TABLE DATA           i   COPY public.rfx_submission_mode (rfx_submission_mode_id, tenant_id, title, is_active, alias) FROM stdin;
    public          postgres    false    338   �      t          0    59923    rfx_type 
   TABLE DATA           S   COPY public.rfx_type (rfx_type_id, tenant_id, title, is_active, alias) FROM stdin;
    public          postgres    false    334   ,�                0    51195    team 
   TABLE DATA           U   COPY public.team (team_id, tenant_id, team_title, team_role, role_level) FROM stdin;
    public          postgres    false    220   y�      �          0    51166    tenant 
   TABLE DATA           �  COPY public.tenant (tenant_id, tenant_name, tenant_title, tenant_logo, tenant_description, contact_person, contact_email, contact_phone, contact_address, subscription_start_date, subscription_end_date, subscription_type, created_on, created_at, updated_at, location_country, location_state, location_zip, domain_url, private_key, public_key, email_verified, tenant_status, tenant_is_active) FROM stdin;
    public          postgres    false    216   ԋ      l          0    51982    user_activities 
   TABLE DATA           �   COPY public.user_activities (user_activities_id, tenant_id, rfx_id, user_id, meta_key, meta_id, title, activity_type, created_on, created_at) FROM stdin;
    public          postgres    false    326   	�                0    51206    users 
   TABLE DATA           *  COPY public.users (user_id, tenant_id, team_id, designation_id, company_id, user_name, email, password, first_name, middle_name, last_name, user_role, role_level, registration_date, last_login_at, created_on, created_at, updated_at, active, verified, password_salt, user_profile_photo) FROM stdin;
    public          postgres    false    222   &�      �           0    0 *   bid_clarification_bid_clarification_id_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.bid_clarification_bid_clarification_id_seq', 1, false);
          public          postgres    false    247            �           0    0 4   bid_clarification_meta_bid_clarification_meta_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.bid_clarification_meta_bid_clarification_meta_id_seq', 1, false);
          public          postgres    false    249            �           0    0 <   bid_clarification_revision_bid_clarification_revision_id_seq    SEQUENCE SET     k   SELECT pg_catalog.setval('public.bid_clarification_revision_bid_clarification_revision_id_seq', 1, false);
          public          postgres    false    251            �           0    0 ?   bid_clarification_revision_li_bid_clarification_revision_li_seq    SEQUENCE SET     n   SELECT pg_catalog.setval('public.bid_clarification_revision_li_bid_clarification_revision_li_seq', 1, false);
          public          postgres    false    253            �           0    0 ?   bid_clarification_revision_me_bid_clarification_revision_me_seq    SEQUENCE SET     n   SELECT pg_catalog.setval('public.bid_clarification_revision_me_bid_clarification_revision_me_seq', 1, false);
          public          postgres    false    255            �           0    0 (   bid_deliverables_bid_deliverables_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.bid_deliverables_bid_deliverables_id_seq', 1, false);
          public          postgres    false    285            �           0    0 :   bid_deliverables_template_bid_deliverables_template_id_seq    SEQUENCE SET     i   SELECT pg_catalog.setval('public.bid_deliverables_template_bid_deliverables_template_id_seq', 1, false);
          public          postgres    false    287            �           0    0 ?   bid_documents_acknowledgement_bid_documents_acknowledgement_seq    SEQUENCE SET     m   SELECT pg_catalog.setval('public.bid_documents_acknowledgement_bid_documents_acknowledgement_seq', 2, true);
          public          postgres    false    241            �           0    0 "   bid_documents_bid_documents_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.bid_documents_bid_documents_id_seq', 8, true);
          public          postgres    false    239            �           0    0 ,   bid_documents_meta_bid_documents_meta_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.bid_documents_meta_bid_documents_meta_id_seq', 4, true);
          public          postgres    false    245            �           0    0 ,   bid_documents_post_bid_documents_post_id_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.bid_documents_post_bid_documents_post_id_seq', 1, true);
          public          postgres    false    243            �           0    0 .   bid_kickoff_meeting_bid_kickoff_meeting_id_seq    SEQUENCE SET     ]   SELECT pg_catalog.setval('public.bid_kickoff_meeting_bid_kickoff_meeting_id_seq', 1, false);
          public          postgres    false    289            �           0    0 ?   bid_kickoff_meeting_contacts_bid_kickoff_meeting_contacts_i_seq    SEQUENCE SET     n   SELECT pg_catalog.setval('public.bid_kickoff_meeting_contacts_bid_kickoff_meeting_contacts_i_seq', 1, false);
          public          postgres    false    291            �           0    0 ?   bid_kickoff_meeting_template_bid_kickoff_meeting_template_i_seq    SEQUENCE SET     n   SELECT pg_catalog.setval('public.bid_kickoff_meeting_template_bid_kickoff_meeting_template_i_seq', 1, false);
          public          postgres    false    293            �           0    0 ?   bid_preparation_task_activity_bid_preparation_task_activity_seq    SEQUENCE SET     n   SELECT pg_catalog.setval('public.bid_preparation_task_activity_bid_preparation_task_activity_seq', 1, false);
          public          postgres    false    299            �           0    0 0   bid_preparation_task_bid_preparation_task_id_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public.bid_preparation_task_bid_preparation_task_id_seq', 1, false);
          public          postgres    false    295            �           0    0 ?   bid_preparation_task_contacts_bid_preparation_task_contacts_seq    SEQUENCE SET     n   SELECT pg_catalog.setval('public.bid_preparation_task_contacts_bid_preparation_task_contacts_seq', 1, false);
          public          postgres    false    297            �           0    0 ?   bid_preparation_task_docvalt_bid_preparation_task_docvalt_i_seq    SEQUENCE SET     n   SELECT pg_catalog.setval('public.bid_preparation_task_docvalt_bid_preparation_task_docvalt_i_seq', 1, false);
          public          postgres    false    305            �           0    0 :   bid_preparation_task_post_bid_preparation_task_post_id_seq    SEQUENCE SET     i   SELECT pg_catalog.setval('public.bid_preparation_task_post_bid_preparation_task_post_id_seq', 1, false);
          public          postgres    false    303            �           0    0 ?   bid_preparation_task_subtask_bid_preparation_task_subtask_i_seq    SEQUENCE SET     n   SELECT pg_catalog.setval('public.bid_preparation_task_subtask_bid_preparation_task_subtask_i_seq', 1, false);
          public          postgres    false    301            �           0    0    bid_stage_bid_stage_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.bid_stage_bid_stage_id_seq', 1, false);
          public          postgres    false    341            �           0    0 (   bid_stage_detail_bid_stage_detail_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.bid_stage_detail_bid_stage_detail_id_seq', 1, false);
          public          postgres    false    343            �           0    0     bid_validity_bid_validity_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.bid_validity_bid_validity_id_seq', 3, true);
          public          postgres    false    339            �           0    0    bids_stage_bids_stage_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.bids_stage_bids_stage_id_seq', 1, false);
          public          postgres    false    229            �           0    0 *   bids_stage_detail_bids_stage_detail_id_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.bids_stage_detail_bids_stage_detail_id_seq', 1, false);
          public          postgres    false    231            �           0    0    company_company_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.company_company_id_seq', 25, true);
          public          postgres    false    217            �           0    0    contacts_contact_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.contacts_contact_id_seq', 16, true);
          public          postgres    false    347            �           0    0    customer_customer_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.customer_customer_id_seq', 1, true);
          public          postgres    false    223            �           0    0    designation_designation_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.designation_designation_id_seq', 9, true);
          public          postgres    false    329            �           0    0 8   detailed_review_contacts_detailed_review_contacts_id_seq    SEQUENCE SET     g   SELECT pg_catalog.setval('public.detailed_review_contacts_detailed_review_contacts_id_seq', 1, false);
          public          postgres    false    279            �           0    0 &   detailed_review_detailed_review_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.detailed_review_detailed_review_id_seq', 1, false);
          public          postgres    false    275            �           0    0 6   detailed_review_details_detailed_review_details_id_seq    SEQUENCE SET     e   SELECT pg_catalog.setval('public.detailed_review_details_detailed_review_details_id_seq', 1, false);
          public          postgres    false    277            �           0    0 0   detailed_review_post_detailed_review_post_id_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public.detailed_review_post_detailed_review_post_id_seq', 1, false);
          public          postgres    false    281            �           0    0 8   detailed_review_template_detailed_review_template_id_seq    SEQUENCE SET     g   SELECT pg_catalog.setval('public.detailed_review_template_detailed_review_template_id_seq', 1, false);
          public          postgres    false    283            �           0    0    docvalt_docvalt_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.docvalt_docvalt_id_seq', 2, true);
          public          postgres    false    327            �           0    0 2   final_review_contacts_final_review_contacts_id_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.final_review_contacts_final_review_contacts_id_seq', 1, false);
          public          postgres    false    311            �           0    0 0   final_review_details_final_review_details_id_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public.final_review_details_final_review_details_id_seq', 1, false);
          public          postgres    false    309            �           0    0     final_review_final_review_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.final_review_final_review_id_seq', 1, false);
          public          postgres    false    307            �           0    0 *   final_review_post_final_review_post_id_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.final_review_post_final_review_post_id_seq', 1, false);
          public          postgres    false    313            �           0    0 2   final_review_template_final_review_template_id_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.final_review_template_final_review_template_id_seq', 1, false);
          public          postgres    false    315            �           0    0    opportunity_opportunity_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.opportunity_opportunity_id_seq', 2, true);
          public          postgres    false    225            �           0    0 2   order_review_contacts_order_review_contacts_id_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.order_review_contacts_order_review_contacts_id_seq', 1, false);
          public          postgres    false    319            �           0    0     order_review_order_review_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.order_review_order_review_id_seq', 1, false);
          public          postgres    false    317            �           0    0 *   order_review_post_order_review_post_id_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.order_review_post_order_review_post_id_seq', 1, false);
          public          postgres    false    321            �           0    0 2   order_review_template_order_review_template_id_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.order_review_template_order_review_template_id_seq', 1, false);
          public          postgres    false    323            �           0    0 4   prelim_review_contacts_prelim_review_contacts_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.prelim_review_contacts_prelim_review_contacts_id_seq', 1, false);
          public          postgres    false    269            �           0    0 2   prelim_review_details_prelim_review_details_id_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.prelim_review_details_prelim_review_details_id_seq', 1, false);
          public          postgres    false    267            �           0    0 ,   prelim_review_post_prelim_review_post_id_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.prelim_review_post_prelim_review_post_id_seq', 1, false);
          public          postgres    false    271            �           0    0 "   prelim_review_prelim_review_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.prelim_review_prelim_review_id_seq', 1, false);
          public          postgres    false    265            �           0    0 4   prelim_review_template_prelim_review_template_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('public.prelim_review_template_prelim_review_template_id_seq', 1, false);
          public          postgres    false    273            �           0    0 ?   purchase_order_acknowledgemen_purchase_order_acknowledgemen_seq    SEQUENCE SET     n   SELECT pg_catalog.setval('public.purchase_order_acknowledgemen_purchase_order_acknowledgemen_seq', 1, false);
          public          postgres    false    259            �           0    0 .   purchase_order_meta_purchase_order_meta_id_seq    SEQUENCE SET     ]   SELECT pg_catalog.setval('public.purchase_order_meta_purchase_order_meta_id_seq', 1, false);
          public          postgres    false    263            �           0    0 %   purchase_order_post_order_post_id_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.purchase_order_post_order_post_id_seq', 1, false);
          public          postgres    false    261            �           0    0 $   purchase_order_purchase_order_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.purchase_order_purchase_order_id_seq', 1, false);
          public          postgres    false    257            �           0    0 +   rfx_acknowledgement_rfx_acknowledgement_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.rfx_acknowledgement_rfx_acknowledgement_seq', 92, true);
          public          postgres    false    227            �           0    0 4   rfx_clarification_meta_rfx_clarification_meta_id_seq    SEQUENCE SET     b   SELECT pg_catalog.setval('public.rfx_clarification_meta_rfx_clarification_meta_id_seq', 5, true);
          public          postgres    false    237            �           0    0 4   rfx_clarification_post_rfx_clarification_post_id_seq    SEQUENCE SET     b   SELECT pg_catalog.setval('public.rfx_clarification_post_rfx_clarification_post_id_seq', 3, true);
          public          postgres    false    235            �           0    0 *   rfx_clarification_rfx_clarification_id_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.rfx_clarification_rfx_clarification_id_seq', 3, true);
          public          postgres    false    233            �           0    0 4   rfx_content_submission_rfx_content_submission_id_seq    SEQUENCE SET     b   SELECT pg_catalog.setval('public.rfx_content_submission_rfx_content_submission_id_seq', 3, true);
          public          postgres    false    335            �           0    0    rfx_rfx_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.rfx_rfx_id_seq', 98, true);
          public          postgres    false    331            �           0    0    rfx_stage_rfx_stage_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.rfx_stage_rfx_stage_id_seq', 5, true);
          public          postgres    false    345            �           0    0 .   rfx_submission_mode_rfx_submission_mode_id_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('public.rfx_submission_mode_rfx_submission_mode_id_seq', 3, true);
          public          postgres    false    337            �           0    0    rfx_type_rfx_type_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.rfx_type_rfx_type_id_seq', 6, true);
          public          postgres    false    333            �           0    0    team_team_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.team_team_id_seq', 6, true);
          public          postgres    false    219            �           0    0    tenant_tenant_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.tenant_tenant_id_seq', 32, true);
          public          postgres    false    215            �           0    0 &   user_activities_user_activities_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.user_activities_user_activities_id_seq', 1, false);
          public          postgres    false    325            �           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 32, true);
          public          postgres    false    221            �           2606    51472 2   bid_clarification_meta bid_clarification_meta_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_clarification_meta
    ADD CONSTRAINT bid_clarification_meta_pkey PRIMARY KEY (bid_clarification_meta_id);
 \   ALTER TABLE ONLY public.bid_clarification_meta DROP CONSTRAINT bid_clarification_meta_pkey;
       public            postgres    false    250            �           2606    51461 (   bid_clarification bid_clarification_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.bid_clarification
    ADD CONSTRAINT bid_clarification_pkey PRIMARY KEY (bid_clarification_id);
 R   ALTER TABLE ONLY public.bid_clarification DROP CONSTRAINT bid_clarification_pkey;
       public            postgres    false    248            �           2606    51497 D   bid_clarification_revision_line bid_clarification_revision_line_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_clarification_revision_line
    ADD CONSTRAINT bid_clarification_revision_line_pkey PRIMARY KEY (bid_clarification_revision_line_id);
 n   ALTER TABLE ONLY public.bid_clarification_revision_line DROP CONSTRAINT bid_clarification_revision_line_pkey;
       public            postgres    false    254            �           2606    51508 D   bid_clarification_revision_meta bid_clarification_revision_meta_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_clarification_revision_meta
    ADD CONSTRAINT bid_clarification_revision_meta_pkey PRIMARY KEY (bid_clarification_revision_meta_id);
 n   ALTER TABLE ONLY public.bid_clarification_revision_meta DROP CONSTRAINT bid_clarification_revision_meta_pkey;
       public            postgres    false    256            �           2606    51486 :   bid_clarification_revision bid_clarification_revision_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_clarification_revision
    ADD CONSTRAINT bid_clarification_revision_pkey PRIMARY KEY (bid_clarification_revision_id);
 d   ALTER TABLE ONLY public.bid_clarification_revision DROP CONSTRAINT bid_clarification_revision_pkey;
       public            postgres    false    252            �           2606    51720 &   bid_deliverables bid_deliverables_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.bid_deliverables
    ADD CONSTRAINT bid_deliverables_pkey PRIMARY KEY (bid_deliverables_id);
 P   ALTER TABLE ONLY public.bid_deliverables DROP CONSTRAINT bid_deliverables_pkey;
       public            postgres    false    286            �           2606    51735 8   bid_deliverables_template bid_deliverables_template_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_deliverables_template
    ADD CONSTRAINT bid_deliverables_template_pkey PRIMARY KEY (bid_deliverables_template_id);
 b   ALTER TABLE ONLY public.bid_deliverables_template DROP CONSTRAINT bid_deliverables_template_pkey;
       public            postgres    false    288            �           2606    51425 @   bid_documents_acknowledgement bid_documents_acknowledgement_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_documents_acknowledgement
    ADD CONSTRAINT bid_documents_acknowledgement_pkey PRIMARY KEY (bid_documents_acknowledgement);
 j   ALTER TABLE ONLY public.bid_documents_acknowledgement DROP CONSTRAINT bid_documents_acknowledgement_pkey;
       public            postgres    false    242            �           2606    51449 *   bid_documents_meta bid_documents_meta_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.bid_documents_meta
    ADD CONSTRAINT bid_documents_meta_pkey PRIMARY KEY (bid_documents_meta_id);
 T   ALTER TABLE ONLY public.bid_documents_meta DROP CONSTRAINT bid_documents_meta_pkey;
       public            postgres    false    246            �           2606    51411     bid_documents bid_documents_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.bid_documents
    ADD CONSTRAINT bid_documents_pkey PRIMARY KEY (bid_documents_id);
 J   ALTER TABLE ONLY public.bid_documents DROP CONSTRAINT bid_documents_pkey;
       public            postgres    false    240            �           2606    51438 *   bid_documents_post bid_documents_post_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.bid_documents_post
    ADD CONSTRAINT bid_documents_post_pkey PRIMARY KEY (bid_documents_post_id);
 T   ALTER TABLE ONLY public.bid_documents_post DROP CONSTRAINT bid_documents_post_pkey;
       public            postgres    false    244            �           2606    51758 >   bid_kickoff_meeting_contacts bid_kickoff_meeting_contacts_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_kickoff_meeting_contacts
    ADD CONSTRAINT bid_kickoff_meeting_contacts_pkey PRIMARY KEY (bid_kickoff_meeting_contacts_id);
 h   ALTER TABLE ONLY public.bid_kickoff_meeting_contacts DROP CONSTRAINT bid_kickoff_meeting_contacts_pkey;
       public            postgres    false    292            �           2606    51746 ,   bid_kickoff_meeting bid_kickoff_meeting_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.bid_kickoff_meeting
    ADD CONSTRAINT bid_kickoff_meeting_pkey PRIMARY KEY (bid_kickoff_meeting_id);
 V   ALTER TABLE ONLY public.bid_kickoff_meeting DROP CONSTRAINT bid_kickoff_meeting_pkey;
       public            postgres    false    290            �           2606    51773 >   bid_kickoff_meeting_template bid_kickoff_meeting_template_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_kickoff_meeting_template
    ADD CONSTRAINT bid_kickoff_meeting_template_pkey PRIMARY KEY (bid_kickoff_meeting_template_id);
 h   ALTER TABLE ONLY public.bid_kickoff_meeting_template DROP CONSTRAINT bid_kickoff_meeting_template_pkey;
       public            postgres    false    294            �           2606    51811 @   bid_preparation_task_activity bid_preparation_task_activity_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_activity
    ADD CONSTRAINT bid_preparation_task_activity_pkey PRIMARY KEY (bid_preparation_task_activity_id);
 j   ALTER TABLE ONLY public.bid_preparation_task_activity DROP CONSTRAINT bid_preparation_task_activity_pkey;
       public            postgres    false    300            �           2606    51798 @   bid_preparation_task_contacts bid_preparation_task_contacts_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_contacts
    ADD CONSTRAINT bid_preparation_task_contacts_pkey PRIMARY KEY (bid_preparation_task_contacts_id);
 j   ALTER TABLE ONLY public.bid_preparation_task_contacts DROP CONSTRAINT bid_preparation_task_contacts_pkey;
       public            postgres    false    298                       2606    51849 >   bid_preparation_task_docvalt bid_preparation_task_docvalt_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_docvalt
    ADD CONSTRAINT bid_preparation_task_docvalt_pkey PRIMARY KEY (bid_preparation_task_docvalt_id);
 h   ALTER TABLE ONLY public.bid_preparation_task_docvalt DROP CONSTRAINT bid_preparation_task_docvalt_pkey;
       public            postgres    false    306            �           2606    51787 .   bid_preparation_task bid_preparation_task_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task
    ADD CONSTRAINT bid_preparation_task_pkey PRIMARY KEY (bid_preparation_task_id);
 X   ALTER TABLE ONLY public.bid_preparation_task DROP CONSTRAINT bid_preparation_task_pkey;
       public            postgres    false    296                       2606    51837 8   bid_preparation_task_post bid_preparation_task_post_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_post
    ADD CONSTRAINT bid_preparation_task_post_pkey PRIMARY KEY (bid_preparation_task_post_id);
 b   ALTER TABLE ONLY public.bid_preparation_task_post DROP CONSTRAINT bid_preparation_task_post_pkey;
       public            postgres    false    304            �           2606    51824 >   bid_preparation_task_subtask bid_preparation_task_subtask_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_subtask
    ADD CONSTRAINT bid_preparation_task_subtask_pkey PRIMARY KEY (bid_preparation_task_subtask_id);
 h   ALTER TABLE ONLY public.bid_preparation_task_subtask DROP CONSTRAINT bid_preparation_task_subtask_pkey;
       public            postgres    false    302            )           2606    60069 &   bid_stage_detail bid_stage_detail_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.bid_stage_detail
    ADD CONSTRAINT bid_stage_detail_pkey PRIMARY KEY (bid_stage_detail_id);
 P   ALTER TABLE ONLY public.bid_stage_detail DROP CONSTRAINT bid_stage_detail_pkey;
       public            postgres    false    344            '           2606    60050    bid_stage bid_stage_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.bid_stage
    ADD CONSTRAINT bid_stage_pkey PRIMARY KEY (bid_stage_id);
 B   ALTER TABLE ONLY public.bid_stage DROP CONSTRAINT bid_stage_pkey;
       public            postgres    false    342            %           2606    59964    bid_validity bid_validity_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.bid_validity
    ADD CONSTRAINT bid_validity_pkey PRIMARY KEY (bid_validity_id);
 H   ALTER TABLE ONLY public.bid_validity DROP CONSTRAINT bid_validity_pkey;
       public            postgres    false    340            �           2606    51362 (   bids_stage_detail bids_stage_detail_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.bids_stage_detail
    ADD CONSTRAINT bids_stage_detail_pkey PRIMARY KEY (bids_stage_detail_id);
 R   ALTER TABLE ONLY public.bids_stage_detail DROP CONSTRAINT bids_stage_detail_pkey;
       public            postgres    false    232            �           2606    51348    bids_stage bids_stage_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.bids_stage
    ADD CONSTRAINT bids_stage_pkey PRIMARY KEY (bids_stage_id);
 D   ALTER TABLE ONLY public.bids_stage DROP CONSTRAINT bids_stage_pkey;
       public            postgres    false    230            �           2606    51188    company company_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (company_id);
 >   ALTER TABLE ONLY public.company DROP CONSTRAINT company_pkey;
       public            postgres    false    218            -           2606    60105    contacts contacts_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (contact_id);
 @   ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_pkey;
       public            postgres    false    348            �           2606    51242    customer customer_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);
 @   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
       public            postgres    false    224                       2606    59361    designation designation_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.designation
    ADD CONSTRAINT designation_pkey PRIMARY KEY (designation_id);
 F   ALTER TABLE ONLY public.designation DROP CONSTRAINT designation_pkey;
       public            postgres    false    330            �           2606    51681 6   detailed_review_contacts detailed_review_contacts_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.detailed_review_contacts
    ADD CONSTRAINT detailed_review_contacts_pkey PRIMARY KEY (detailed_review_contacts_id);
 `   ALTER TABLE ONLY public.detailed_review_contacts DROP CONSTRAINT detailed_review_contacts_pkey;
       public            postgres    false    280            �           2606    51670 4   detailed_review_details detailed_review_details_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.detailed_review_details
    ADD CONSTRAINT detailed_review_details_pkey PRIMARY KEY (detailed_review_details_id);
 ^   ALTER TABLE ONLY public.detailed_review_details DROP CONSTRAINT detailed_review_details_pkey;
       public            postgres    false    278            �           2606    51652 $   detailed_review detailed_review_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.detailed_review
    ADD CONSTRAINT detailed_review_pkey PRIMARY KEY (detailed_review_id);
 N   ALTER TABLE ONLY public.detailed_review DROP CONSTRAINT detailed_review_pkey;
       public            postgres    false    276            �           2606    51694 .   detailed_review_post detailed_review_post_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.detailed_review_post
    ADD CONSTRAINT detailed_review_post_pkey PRIMARY KEY (detailed_review_post_id);
 X   ALTER TABLE ONLY public.detailed_review_post DROP CONSTRAINT detailed_review_post_pkey;
       public            postgres    false    282            �           2606    51709 6   detailed_review_template detailed_review_template_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.detailed_review_template
    ADD CONSTRAINT detailed_review_template_pkey PRIMARY KEY (detailed_review_template_id);
 `   ALTER TABLE ONLY public.detailed_review_template DROP CONSTRAINT detailed_review_template_pkey;
       public            postgres    false    284                       2606    52005    docvalt docvalt_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.docvalt
    ADD CONSTRAINT docvalt_pkey PRIMARY KEY (docvalt_id);
 >   ALTER TABLE ONLY public.docvalt DROP CONSTRAINT docvalt_pkey;
       public            postgres    false    328            	           2606    51893 0   final_review_contacts final_review_contacts_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.final_review_contacts
    ADD CONSTRAINT final_review_contacts_pkey PRIMARY KEY (final_review_contacts_id);
 Z   ALTER TABLE ONLY public.final_review_contacts DROP CONSTRAINT final_review_contacts_pkey;
       public            postgres    false    312                       2606    51882 .   final_review_details final_review_details_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.final_review_details
    ADD CONSTRAINT final_review_details_pkey PRIMARY KEY (final_review_details_id);
 X   ALTER TABLE ONLY public.final_review_details DROP CONSTRAINT final_review_details_pkey;
       public            postgres    false    310                       2606    51864    final_review final_review_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.final_review
    ADD CONSTRAINT final_review_pkey PRIMARY KEY (final_review_id);
 H   ALTER TABLE ONLY public.final_review DROP CONSTRAINT final_review_pkey;
       public            postgres    false    308                       2606    51906 (   final_review_post final_review_post_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.final_review_post
    ADD CONSTRAINT final_review_post_pkey PRIMARY KEY (final_review_post_id);
 R   ALTER TABLE ONLY public.final_review_post DROP CONSTRAINT final_review_post_pkey;
       public            postgres    false    314                       2606    51921 0   final_review_template final_review_template_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.final_review_template
    ADD CONSTRAINT final_review_template_pkey PRIMARY KEY (final_review_template_id);
 Z   ALTER TABLE ONLY public.final_review_template DROP CONSTRAINT final_review_template_pkey;
       public            postgres    false    316            �           2606    51269    opportunity opportunity_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.opportunity
    ADD CONSTRAINT opportunity_pkey PRIMARY KEY (opportunity_id);
 F   ALTER TABLE ONLY public.opportunity DROP CONSTRAINT opportunity_pkey;
       public            postgres    false    226                       2606    51947 0   order_review_contacts order_review_contacts_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.order_review_contacts
    ADD CONSTRAINT order_review_contacts_pkey PRIMARY KEY (order_review_contacts_id);
 Z   ALTER TABLE ONLY public.order_review_contacts DROP CONSTRAINT order_review_contacts_pkey;
       public            postgres    false    320                       2606    51936    order_review order_review_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.order_review
    ADD CONSTRAINT order_review_pkey PRIMARY KEY (order_review_id);
 H   ALTER TABLE ONLY public.order_review DROP CONSTRAINT order_review_pkey;
       public            postgres    false    318                       2606    51960 (   order_review_post order_review_post_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.order_review_post
    ADD CONSTRAINT order_review_post_pkey PRIMARY KEY (order_review_post_id);
 R   ALTER TABLE ONLY public.order_review_post DROP CONSTRAINT order_review_post_pkey;
       public            postgres    false    322                       2606    51975 0   order_review_template order_review_template_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.order_review_template
    ADD CONSTRAINT order_review_template_pkey PRIMARY KEY (order_review_template_id);
 Z   ALTER TABLE ONLY public.order_review_template DROP CONSTRAINT order_review_template_pkey;
       public            postgres    false    324            �           2606    51609 2   prelim_review_contacts prelim_review_contacts_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.prelim_review_contacts
    ADD CONSTRAINT prelim_review_contacts_pkey PRIMARY KEY (prelim_review_contacts_id);
 \   ALTER TABLE ONLY public.prelim_review_contacts DROP CONSTRAINT prelim_review_contacts_pkey;
       public            postgres    false    270            �           2606    51598 0   prelim_review_details prelim_review_details_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.prelim_review_details
    ADD CONSTRAINT prelim_review_details_pkey PRIMARY KEY (prelim_review_details_id);
 Z   ALTER TABLE ONLY public.prelim_review_details DROP CONSTRAINT prelim_review_details_pkey;
       public            postgres    false    268            �           2606    51580     prelim_review prelim_review_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.prelim_review
    ADD CONSTRAINT prelim_review_pkey PRIMARY KEY (prelim_review_id);
 J   ALTER TABLE ONLY public.prelim_review DROP CONSTRAINT prelim_review_pkey;
       public            postgres    false    266            �           2606    51622 *   prelim_review_post prelim_review_post_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.prelim_review_post
    ADD CONSTRAINT prelim_review_post_pkey PRIMARY KEY (prelim_review_post_id);
 T   ALTER TABLE ONLY public.prelim_review_post DROP CONSTRAINT prelim_review_post_pkey;
       public            postgres    false    272            �           2606    51637 2   prelim_review_template prelim_review_template_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.prelim_review_template
    ADD CONSTRAINT prelim_review_template_pkey PRIMARY KEY (prelim_review_template_id);
 \   ALTER TABLE ONLY public.prelim_review_template DROP CONSTRAINT prelim_review_template_pkey;
       public            postgres    false    274            �           2606    51538 B   purchase_order_acknowledgement purchase_order_acknowledgement_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.purchase_order_acknowledgement
    ADD CONSTRAINT purchase_order_acknowledgement_pkey PRIMARY KEY (purchase_order_acknowledgement);
 l   ALTER TABLE ONLY public.purchase_order_acknowledgement DROP CONSTRAINT purchase_order_acknowledgement_pkey;
       public            postgres    false    260            �           2606    51562 ,   purchase_order_meta purchase_order_meta_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.purchase_order_meta
    ADD CONSTRAINT purchase_order_meta_pkey PRIMARY KEY (purchase_order_meta_id);
 V   ALTER TABLE ONLY public.purchase_order_meta DROP CONSTRAINT purchase_order_meta_pkey;
       public            postgres    false    264            �           2606    51524 "   purchase_order purchase_order_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_pkey PRIMARY KEY (purchase_order_id);
 L   ALTER TABLE ONLY public.purchase_order DROP CONSTRAINT purchase_order_pkey;
       public            postgres    false    258            �           2606    51551 ,   purchase_order_post purchase_order_post_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.purchase_order_post
    ADD CONSTRAINT purchase_order_post_pkey PRIMARY KEY (order_post_id);
 V   ALTER TABLE ONLY public.purchase_order_post DROP CONSTRAINT purchase_order_post_pkey;
       public            postgres    false    262            �           2606    51310 ,   rfx_acknowledgement rfx_acknowledgement_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.rfx_acknowledgement
    ADD CONSTRAINT rfx_acknowledgement_pkey PRIMARY KEY (rfx_acknowledgement);
 V   ALTER TABLE ONLY public.rfx_acknowledgement DROP CONSTRAINT rfx_acknowledgement_pkey;
       public            postgres    false    228            �           2606    51397 2   rfx_clarification_meta rfx_clarification_meta_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.rfx_clarification_meta
    ADD CONSTRAINT rfx_clarification_meta_pkey PRIMARY KEY (rfx_clarification_meta_id);
 \   ALTER TABLE ONLY public.rfx_clarification_meta DROP CONSTRAINT rfx_clarification_meta_pkey;
       public            postgres    false    238            �           2606    51373 (   rfx_clarification rfx_clarification_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.rfx_clarification
    ADD CONSTRAINT rfx_clarification_pkey PRIMARY KEY (rfx_clarification_id);
 R   ALTER TABLE ONLY public.rfx_clarification DROP CONSTRAINT rfx_clarification_pkey;
       public            postgres    false    234            �           2606    51386 2   rfx_clarification_post rfx_clarification_post_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.rfx_clarification_post
    ADD CONSTRAINT rfx_clarification_post_pkey PRIMARY KEY (rfx_clarification_post_id);
 \   ALTER TABLE ONLY public.rfx_clarification_post DROP CONSTRAINT rfx_clarification_post_pkey;
       public            postgres    false    236            !           2606    59940 2   rfx_content_submission rfx_content_submission_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.rfx_content_submission
    ADD CONSTRAINT rfx_content_submission_pkey PRIMARY KEY (rfx_content_submission_id);
 \   ALTER TABLE ONLY public.rfx_content_submission DROP CONSTRAINT rfx_content_submission_pkey;
       public            postgres    false    336                       2606    59378    rfx rfx_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.rfx
    ADD CONSTRAINT rfx_pkey PRIMARY KEY (rfx_id);
 6   ALTER TABLE ONLY public.rfx DROP CONSTRAINT rfx_pkey;
       public            postgres    false    332            +           2606    60094    rfx_stage rfx_stage_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.rfx_stage
    ADD CONSTRAINT rfx_stage_pkey PRIMARY KEY (rfx_stage_id);
 B   ALTER TABLE ONLY public.rfx_stage DROP CONSTRAINT rfx_stage_pkey;
       public            postgres    false    346            #           2606    59952 ,   rfx_submission_mode rfx_submission_mode_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.rfx_submission_mode
    ADD CONSTRAINT rfx_submission_mode_pkey PRIMARY KEY (rfx_submission_mode_id);
 V   ALTER TABLE ONLY public.rfx_submission_mode DROP CONSTRAINT rfx_submission_mode_pkey;
       public            postgres    false    338                       2606    59928    rfx_type rfx_type_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.rfx_type
    ADD CONSTRAINT rfx_type_pkey PRIMARY KEY (rfx_type_id);
 @   ALTER TABLE ONLY public.rfx_type DROP CONSTRAINT rfx_type_pkey;
       public            postgres    false    334            �           2606    51199    team team_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (team_id);
 8   ALTER TABLE ONLY public.team DROP CONSTRAINT team_pkey;
       public            postgres    false    220            �           2606    51174    tenant tenant_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.tenant
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (tenant_id);
 <   ALTER TABLE ONLY public.tenant DROP CONSTRAINT tenant_pkey;
       public            postgres    false    216                       2606    51986 $   user_activities user_activities_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.user_activities
    ADD CONSTRAINT user_activities_pkey PRIMARY KEY (user_activities_id);
 N   ALTER TABLE ONLY public.user_activities DROP CONSTRAINT user_activities_pkey;
       public            postgres    false    326            �           2606    51214    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    222            ?           2606    51473 G   bid_clarification_meta bid_clarification_meta_bid_clarification_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_clarification_meta
    ADD CONSTRAINT bid_clarification_meta_bid_clarification_id_fkey FOREIGN KEY (bid_clarification_id) REFERENCES public.bid_clarification(bid_clarification_id);
 q   ALTER TABLE ONLY public.bid_clarification_meta DROP CONSTRAINT bid_clarification_meta_bid_clarification_id_fkey;
       public          postgres    false    250    5065    248            @           2606    51487 O   bid_clarification_revision bid_clarification_revision_bid_clarification_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_clarification_revision
    ADD CONSTRAINT bid_clarification_revision_bid_clarification_id_fkey FOREIGN KEY (bid_clarification_id) REFERENCES public.bid_clarification(bid_clarification_id);
 y   ALTER TABLE ONLY public.bid_clarification_revision DROP CONSTRAINT bid_clarification_revision_bid_clarification_id_fkey;
       public          postgres    false    5065    248    252            A           2606    51498 _   bid_clarification_revision_line bid_clarification_revision_li_bid_clarification_revision_i_fkey    FK CONSTRAINT       ALTER TABLE ONLY public.bid_clarification_revision_line
    ADD CONSTRAINT bid_clarification_revision_li_bid_clarification_revision_i_fkey FOREIGN KEY (bid_clarification_revision_id) REFERENCES public.bid_clarification_revision(bid_clarification_revision_id);
 �   ALTER TABLE ONLY public.bid_clarification_revision_line DROP CONSTRAINT bid_clarification_revision_li_bid_clarification_revision_i_fkey;
       public          postgres    false    5069    254    252            B           2606    51509 _   bid_clarification_revision_meta bid_clarification_revision_me_bid_clarification_revision_i_fkey    FK CONSTRAINT       ALTER TABLE ONLY public.bid_clarification_revision_meta
    ADD CONSTRAINT bid_clarification_revision_me_bid_clarification_revision_i_fkey FOREIGN KEY (bid_clarification_revision_id) REFERENCES public.bid_clarification_revision(bid_clarification_revision_id);
 �   ALTER TABLE ONLY public.bid_clarification_revision_meta DROP CONSTRAINT bid_clarification_revision_me_bid_clarification_revision_i_fkey;
       public          postgres    false    256    252    5069            O           2606    51736 L   bid_deliverables_template bid_deliverables_template_bid_deliverables_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_deliverables_template
    ADD CONSTRAINT bid_deliverables_template_bid_deliverables_id_fkey FOREIGN KEY (bid_deliverables_id) REFERENCES public.bid_deliverables(bid_deliverables_id);
 v   ALTER TABLE ONLY public.bid_deliverables_template DROP CONSTRAINT bid_deliverables_template_bid_deliverables_id_fkey;
       public          postgres    false    286    5103    288            <           2606    51426 Q   bid_documents_acknowledgement bid_documents_acknowledgement_bid_documents_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_documents_acknowledgement
    ADD CONSTRAINT bid_documents_acknowledgement_bid_documents_id_fkey FOREIGN KEY (bid_documents_id) REFERENCES public.bid_documents(bid_documents_id);
 {   ALTER TABLE ONLY public.bid_documents_acknowledgement DROP CONSTRAINT bid_documents_acknowledgement_bid_documents_id_fkey;
       public          postgres    false    242    240    5057            >           2606    51450 ;   bid_documents_meta bid_documents_meta_bid_documents_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_documents_meta
    ADD CONSTRAINT bid_documents_meta_bid_documents_id_fkey FOREIGN KEY (bid_documents_id) REFERENCES public.bid_documents(bid_documents_id);
 e   ALTER TABLE ONLY public.bid_documents_meta DROP CONSTRAINT bid_documents_meta_bid_documents_id_fkey;
       public          postgres    false    240    246    5057            =           2606    51439 ;   bid_documents_post bid_documents_post_bid_documents_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_documents_post
    ADD CONSTRAINT bid_documents_post_bid_documents_id_fkey FOREIGN KEY (bid_documents_id) REFERENCES public.bid_documents(bid_documents_id);
 e   ALTER TABLE ONLY public.bid_documents_post DROP CONSTRAINT bid_documents_post_bid_documents_id_fkey;
       public          postgres    false    244    240    5057            P           2606    51759 U   bid_kickoff_meeting_contacts bid_kickoff_meeting_contacts_bid_kickoff_meeting_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_kickoff_meeting_contacts
    ADD CONSTRAINT bid_kickoff_meeting_contacts_bid_kickoff_meeting_id_fkey FOREIGN KEY (bid_kickoff_meeting_id) REFERENCES public.bid_kickoff_meeting(bid_kickoff_meeting_id);
    ALTER TABLE ONLY public.bid_kickoff_meeting_contacts DROP CONSTRAINT bid_kickoff_meeting_contacts_bid_kickoff_meeting_id_fkey;
       public          postgres    false    5107    292    290            Q           2606    51774 U   bid_kickoff_meeting_template bid_kickoff_meeting_template_bid_kickoff_meeting_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_kickoff_meeting_template
    ADD CONSTRAINT bid_kickoff_meeting_template_bid_kickoff_meeting_id_fkey FOREIGN KEY (bid_kickoff_meeting_id) REFERENCES public.bid_kickoff_meeting(bid_kickoff_meeting_id);
    ALTER TABLE ONLY public.bid_kickoff_meeting_template DROP CONSTRAINT bid_kickoff_meeting_template_bid_kickoff_meeting_id_fkey;
       public          postgres    false    5107    294    290            T           2606    51812 X   bid_preparation_task_activity bid_preparation_task_activity_bid_preparation_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_activity
    ADD CONSTRAINT bid_preparation_task_activity_bid_preparation_task_id_fkey FOREIGN KEY (bid_preparation_task_id) REFERENCES public.bid_preparation_task(bid_preparation_task_id);
 �   ALTER TABLE ONLY public.bid_preparation_task_activity DROP CONSTRAINT bid_preparation_task_activity_bid_preparation_task_id_fkey;
       public          postgres    false    300    5113    296            R           2606    51788 K   bid_preparation_task bid_preparation_task_bid_deliverables_template_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task
    ADD CONSTRAINT bid_preparation_task_bid_deliverables_template_id_fkey FOREIGN KEY (bid_deliverables_template_id) REFERENCES public.bid_deliverables_template(bid_deliverables_template_id);
 u   ALTER TABLE ONLY public.bid_preparation_task DROP CONSTRAINT bid_preparation_task_bid_deliverables_template_id_fkey;
       public          postgres    false    288    5105    296            S           2606    51799 X   bid_preparation_task_contacts bid_preparation_task_contacts_bid_preparation_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_contacts
    ADD CONSTRAINT bid_preparation_task_contacts_bid_preparation_task_id_fkey FOREIGN KEY (bid_preparation_task_id) REFERENCES public.bid_preparation_task(bid_preparation_task_id);
 �   ALTER TABLE ONLY public.bid_preparation_task_contacts DROP CONSTRAINT bid_preparation_task_contacts_bid_preparation_task_id_fkey;
       public          postgres    false    296    298    5113            W           2606    51850 V   bid_preparation_task_docvalt bid_preparation_task_docvalt_bid_preparation_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_docvalt
    ADD CONSTRAINT bid_preparation_task_docvalt_bid_preparation_task_id_fkey FOREIGN KEY (bid_preparation_task_id) REFERENCES public.bid_preparation_task(bid_preparation_task_id);
 �   ALTER TABLE ONLY public.bid_preparation_task_docvalt DROP CONSTRAINT bid_preparation_task_docvalt_bid_preparation_task_id_fkey;
       public          postgres    false    306    5113    296            V           2606    51838 P   bid_preparation_task_post bid_preparation_task_post_bid_preparation_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_post
    ADD CONSTRAINT bid_preparation_task_post_bid_preparation_task_id_fkey FOREIGN KEY (bid_preparation_task_id) REFERENCES public.bid_preparation_task(bid_preparation_task_id);
 z   ALTER TABLE ONLY public.bid_preparation_task_post DROP CONSTRAINT bid_preparation_task_post_bid_preparation_task_id_fkey;
       public          postgres    false    5113    296    304            U           2606    51825 V   bid_preparation_task_subtask bid_preparation_task_subtask_bid_preparation_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_preparation_task_subtask
    ADD CONSTRAINT bid_preparation_task_subtask_bid_preparation_task_id_fkey FOREIGN KEY (bid_preparation_task_id) REFERENCES public.bid_preparation_task(bid_preparation_task_id);
 �   ALTER TABLE ONLY public.bid_preparation_task_subtask DROP CONSTRAINT bid_preparation_task_subtask_bid_preparation_task_id_fkey;
       public          postgres    false    302    5113    296            j           2606    60070 3   bid_stage_detail bid_stage_detail_bid_stage_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_stage_detail
    ADD CONSTRAINT bid_stage_detail_bid_stage_id_fkey FOREIGN KEY (bid_stage_id) REFERENCES public.bid_stage(bid_stage_id);
 ]   ALTER TABLE ONLY public.bid_stage_detail DROP CONSTRAINT bid_stage_detail_bid_stage_id_fkey;
       public          postgres    false    342    344    5159            h           2606    60051    bid_stage bid_stage_rfx_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.bid_stage
    ADD CONSTRAINT bid_stage_rfx_id_fkey FOREIGN KEY (rfx_id) REFERENCES public.rfx(rfx_id);
 I   ALTER TABLE ONLY public.bid_stage DROP CONSTRAINT bid_stage_rfx_id_fkey;
       public          postgres    false    5149    342    332            i           2606    60056 "   bid_stage bid_stage_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_stage
    ADD CONSTRAINT bid_stage_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 L   ALTER TABLE ONLY public.bid_stage DROP CONSTRAINT bid_stage_tenant_id_fkey;
       public          postgres    false    216    342    5033            g           2606    59965 (   bid_validity bid_validity_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid_validity
    ADD CONSTRAINT bid_validity_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 R   ALTER TABLE ONLY public.bid_validity DROP CONSTRAINT bid_validity_tenant_id_fkey;
       public          postgres    false    216    340    5033            9           2606    51363 6   bids_stage_detail bids_stage_detail_bids_stage_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bids_stage_detail
    ADD CONSTRAINT bids_stage_detail_bids_stage_id_fkey FOREIGN KEY (bids_stage_id) REFERENCES public.bids_stage(bids_stage_id);
 `   ALTER TABLE ONLY public.bids_stage_detail DROP CONSTRAINT bids_stage_detail_bids_stage_id_fkey;
       public          postgres    false    232    230    5047            8           2606    51349 $   bids_stage bids_stage_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bids_stage
    ADD CONSTRAINT bids_stage_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 N   ALTER TABLE ONLY public.bids_stage DROP CONSTRAINT bids_stage_tenant_id_fkey;
       public          postgres    false    5033    216    230            .           2606    51189    company company_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 H   ALTER TABLE ONLY public.company DROP CONSTRAINT company_tenant_id_fkey;
       public          postgres    false    216    5033    218            l           2606    60106    contacts contacts_rfx_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_rfx_id_fkey FOREIGN KEY (rfx_id) REFERENCES public.rfx(rfx_id);
 G   ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_rfx_id_fkey;
       public          postgres    false    5149    348    332            m           2606    60111     contacts contacts_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 J   ALTER TABLE ONLY public.contacts DROP CONSTRAINT contacts_tenant_id_fkey;
       public          postgres    false    348    216    5033            3           2606    51248 !   customer customer_company_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.company(company_id);
 K   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_company_id_fkey;
       public          postgres    false    5035    224    218            4           2606    51253     customer customer_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 J   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_tenant_id_fkey;
       public          postgres    false    224    216    5033            a           2606    59362 &   designation designation_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.designation
    ADD CONSTRAINT designation_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 P   ALTER TABLE ONLY public.designation DROP CONSTRAINT designation_tenant_id_fkey;
       public          postgres    false    5033    330    216            L           2606    51682 I   detailed_review_contacts detailed_review_contacts_detailed_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detailed_review_contacts
    ADD CONSTRAINT detailed_review_contacts_detailed_review_id_fkey FOREIGN KEY (detailed_review_id) REFERENCES public.detailed_review(detailed_review_id);
 s   ALTER TABLE ONLY public.detailed_review_contacts DROP CONSTRAINT detailed_review_contacts_detailed_review_id_fkey;
       public          postgres    false    280    5093    276            K           2606    51671 G   detailed_review_details detailed_review_details_detailed_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detailed_review_details
    ADD CONSTRAINT detailed_review_details_detailed_review_id_fkey FOREIGN KEY (detailed_review_id) REFERENCES public.detailed_review(detailed_review_id);
 q   ALTER TABLE ONLY public.detailed_review_details DROP CONSTRAINT detailed_review_details_detailed_review_id_fkey;
       public          postgres    false    278    276    5093            M           2606    51695 A   detailed_review_post detailed_review_post_detailed_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detailed_review_post
    ADD CONSTRAINT detailed_review_post_detailed_review_id_fkey FOREIGN KEY (detailed_review_id) REFERENCES public.detailed_review(detailed_review_id);
 k   ALTER TABLE ONLY public.detailed_review_post DROP CONSTRAINT detailed_review_post_detailed_review_id_fkey;
       public          postgres    false    5093    282    276            N           2606    51710 I   detailed_review_template detailed_review_template_detailed_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detailed_review_template
    ADD CONSTRAINT detailed_review_template_detailed_review_id_fkey FOREIGN KEY (detailed_review_id) REFERENCES public.detailed_review(detailed_review_id);
 s   ALTER TABLE ONLY public.detailed_review_template DROP CONSTRAINT detailed_review_template_detailed_review_id_fkey;
       public          postgres    false    284    5093    276            `           2606    52011    docvalt docvalt_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.docvalt
    ADD CONSTRAINT docvalt_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 H   ALTER TABLE ONLY public.docvalt DROP CONSTRAINT docvalt_tenant_id_fkey;
       public          postgres    false    216    328    5033            Y           2606    51894 @   final_review_contacts final_review_contacts_final_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.final_review_contacts
    ADD CONSTRAINT final_review_contacts_final_review_id_fkey FOREIGN KEY (final_review_id) REFERENCES public.final_review(final_review_id);
 j   ALTER TABLE ONLY public.final_review_contacts DROP CONSTRAINT final_review_contacts_final_review_id_fkey;
       public          postgres    false    5125    308    312            X           2606    51883 >   final_review_details final_review_details_final_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.final_review_details
    ADD CONSTRAINT final_review_details_final_review_id_fkey FOREIGN KEY (final_review_id) REFERENCES public.final_review(final_review_id);
 h   ALTER TABLE ONLY public.final_review_details DROP CONSTRAINT final_review_details_final_review_id_fkey;
       public          postgres    false    5125    310    308            Z           2606    51907 8   final_review_post final_review_post_final_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.final_review_post
    ADD CONSTRAINT final_review_post_final_review_id_fkey FOREIGN KEY (final_review_id) REFERENCES public.final_review(final_review_id);
 b   ALTER TABLE ONLY public.final_review_post DROP CONSTRAINT final_review_post_final_review_id_fkey;
       public          postgres    false    308    5125    314            [           2606    51922 @   final_review_template final_review_template_final_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.final_review_template
    ADD CONSTRAINT final_review_template_final_review_id_fkey FOREIGN KEY (final_review_id) REFERENCES public.final_review(final_review_id);
 j   ALTER TABLE ONLY public.final_review_template DROP CONSTRAINT final_review_template_final_review_id_fkey;
       public          postgres    false    308    316    5125            5           2606    51275 '   opportunity opportunity_company_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.opportunity
    ADD CONSTRAINT opportunity_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.company(company_id);
 Q   ALTER TABLE ONLY public.opportunity DROP CONSTRAINT opportunity_company_id_fkey;
       public          postgres    false    5035    226    218            6           2606    51270 (   opportunity opportunity_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.opportunity
    ADD CONSTRAINT opportunity_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);
 R   ALTER TABLE ONLY public.opportunity DROP CONSTRAINT opportunity_customer_id_fkey;
       public          postgres    false    226    5041    224            7           2606    51280 &   opportunity opportunity_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.opportunity
    ADD CONSTRAINT opportunity_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 P   ALTER TABLE ONLY public.opportunity DROP CONSTRAINT opportunity_tenant_id_fkey;
       public          postgres    false    226    216    5033            \           2606    51948 @   order_review_contacts order_review_contacts_order_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_review_contacts
    ADD CONSTRAINT order_review_contacts_order_review_id_fkey FOREIGN KEY (order_review_id) REFERENCES public.order_review(order_review_id);
 j   ALTER TABLE ONLY public.order_review_contacts DROP CONSTRAINT order_review_contacts_order_review_id_fkey;
       public          postgres    false    318    5135    320            ]           2606    51961 8   order_review_post order_review_post_order_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_review_post
    ADD CONSTRAINT order_review_post_order_review_id_fkey FOREIGN KEY (order_review_id) REFERENCES public.order_review(order_review_id);
 b   ALTER TABLE ONLY public.order_review_post DROP CONSTRAINT order_review_post_order_review_id_fkey;
       public          postgres    false    318    5135    322            ^           2606    51976 @   order_review_template order_review_template_order_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_review_template
    ADD CONSTRAINT order_review_template_order_review_id_fkey FOREIGN KEY (order_review_id) REFERENCES public.order_review(order_review_id);
 j   ALTER TABLE ONLY public.order_review_template DROP CONSTRAINT order_review_template_order_review_id_fkey;
       public          postgres    false    5135    318    324            H           2606    51610 C   prelim_review_contacts prelim_review_contacts_prelim_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prelim_review_contacts
    ADD CONSTRAINT prelim_review_contacts_prelim_review_id_fkey FOREIGN KEY (prelim_review_id) REFERENCES public.prelim_review(prelim_review_id);
 m   ALTER TABLE ONLY public.prelim_review_contacts DROP CONSTRAINT prelim_review_contacts_prelim_review_id_fkey;
       public          postgres    false    270    5083    266            G           2606    51599 A   prelim_review_details prelim_review_details_prelim_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prelim_review_details
    ADD CONSTRAINT prelim_review_details_prelim_review_id_fkey FOREIGN KEY (prelim_review_id) REFERENCES public.prelim_review(prelim_review_id);
 k   ALTER TABLE ONLY public.prelim_review_details DROP CONSTRAINT prelim_review_details_prelim_review_id_fkey;
       public          postgres    false    5083    266    268            I           2606    51623 ;   prelim_review_post prelim_review_post_prelim_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prelim_review_post
    ADD CONSTRAINT prelim_review_post_prelim_review_id_fkey FOREIGN KEY (prelim_review_id) REFERENCES public.prelim_review(prelim_review_id);
 e   ALTER TABLE ONLY public.prelim_review_post DROP CONSTRAINT prelim_review_post_prelim_review_id_fkey;
       public          postgres    false    266    272    5083            J           2606    51638 C   prelim_review_template prelim_review_template_prelim_review_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prelim_review_template
    ADD CONSTRAINT prelim_review_template_prelim_review_id_fkey FOREIGN KEY (prelim_review_id) REFERENCES public.prelim_review(prelim_review_id);
 m   ALTER TABLE ONLY public.prelim_review_template DROP CONSTRAINT prelim_review_template_prelim_review_id_fkey;
       public          postgres    false    266    5083    274            C           2606    51539 T   purchase_order_acknowledgement purchase_order_acknowledgement_purchase_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase_order_acknowledgement
    ADD CONSTRAINT purchase_order_acknowledgement_purchase_order_id_fkey FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_order(purchase_order_id);
 ~   ALTER TABLE ONLY public.purchase_order_acknowledgement DROP CONSTRAINT purchase_order_acknowledgement_purchase_order_id_fkey;
       public          postgres    false    260    258    5075            E           2606    51563 :   purchase_order_meta purchase_order_meta_order_post_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase_order_meta
    ADD CONSTRAINT purchase_order_meta_order_post_id_fkey FOREIGN KEY (order_post_id) REFERENCES public.purchase_order_post(order_post_id);
 d   ALTER TABLE ONLY public.purchase_order_meta DROP CONSTRAINT purchase_order_meta_order_post_id_fkey;
       public          postgres    false    5079    262    264            F           2606    51568 >   purchase_order_meta purchase_order_meta_purchase_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase_order_meta
    ADD CONSTRAINT purchase_order_meta_purchase_order_id_fkey FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_order(purchase_order_id);
 h   ALTER TABLE ONLY public.purchase_order_meta DROP CONSTRAINT purchase_order_meta_purchase_order_id_fkey;
       public          postgres    false    264    5075    258            D           2606    51552 >   purchase_order_post purchase_order_post_purchase_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.purchase_order_post
    ADD CONSTRAINT purchase_order_post_purchase_order_id_fkey FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_order(purchase_order_id);
 h   ALTER TABLE ONLY public.purchase_order_post DROP CONSTRAINT purchase_order_post_purchase_order_id_fkey;
       public          postgres    false    258    5075    262            ;           2606    51398 G   rfx_clarification_meta rfx_clarification_meta_rfx_clarification_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rfx_clarification_meta
    ADD CONSTRAINT rfx_clarification_meta_rfx_clarification_id_fkey FOREIGN KEY (rfx_clarification_id) REFERENCES public.rfx_clarification(rfx_clarification_id);
 q   ALTER TABLE ONLY public.rfx_clarification_meta DROP CONSTRAINT rfx_clarification_meta_rfx_clarification_id_fkey;
       public          postgres    false    234    238    5051            :           2606    51387 G   rfx_clarification_post rfx_clarification_post_rfx_clarification_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rfx_clarification_post
    ADD CONSTRAINT rfx_clarification_post_rfx_clarification_id_fkey FOREIGN KEY (rfx_clarification_id) REFERENCES public.rfx_clarification(rfx_clarification_id);
 q   ALTER TABLE ONLY public.rfx_clarification_post DROP CONSTRAINT rfx_clarification_post_rfx_clarification_id_fkey;
       public          postgres    false    234    5051    236            e           2606    59941 <   rfx_content_submission rfx_content_submission_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rfx_content_submission
    ADD CONSTRAINT rfx_content_submission_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 f   ALTER TABLE ONLY public.rfx_content_submission DROP CONSTRAINT rfx_content_submission_tenant_id_fkey;
       public          postgres    false    216    336    5033            b           2606    59379    rfx rfx_opportunity_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rfx
    ADD CONSTRAINT rfx_opportunity_id_fkey FOREIGN KEY (opportunity_id) REFERENCES public.opportunity(opportunity_id);
 E   ALTER TABLE ONLY public.rfx DROP CONSTRAINT rfx_opportunity_id_fkey;
       public          postgres    false    226    332    5043            k           2606    60095 "   rfx_stage rfx_stage_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rfx_stage
    ADD CONSTRAINT rfx_stage_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 L   ALTER TABLE ONLY public.rfx_stage DROP CONSTRAINT rfx_stage_tenant_id_fkey;
       public          postgres    false    5033    216    346            f           2606    59953 6   rfx_submission_mode rfx_submission_mode_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rfx_submission_mode
    ADD CONSTRAINT rfx_submission_mode_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 `   ALTER TABLE ONLY public.rfx_submission_mode DROP CONSTRAINT rfx_submission_mode_tenant_id_fkey;
       public          postgres    false    216    338    5033            c           2606    59384    rfx rfx_tenant_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.rfx
    ADD CONSTRAINT rfx_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 @   ALTER TABLE ONLY public.rfx DROP CONSTRAINT rfx_tenant_id_fkey;
       public          postgres    false    332    5033    216            d           2606    59929     rfx_type rfx_type_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rfx_type
    ADD CONSTRAINT rfx_type_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 J   ALTER TABLE ONLY public.rfx_type DROP CONSTRAINT rfx_type_tenant_id_fkey;
       public          postgres    false    216    334    5033            /           2606    51200    team team_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 B   ALTER TABLE ONLY public.team DROP CONSTRAINT team_tenant_id_fkey;
       public          postgres    false    220    5033    216            _           2606    51992 .   user_activities user_activities_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_activities
    ADD CONSTRAINT user_activities_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 X   ALTER TABLE ONLY public.user_activities DROP CONSTRAINT user_activities_tenant_id_fkey;
       public          postgres    false    216    326    5033            0           2606    51225    users users_company_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.company(company_id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_company_id_fkey;
       public          postgres    false    5035    218    222            1           2606    51215    users users_team_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.team(team_id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_team_id_fkey;
       public          postgres    false    5037    222    220            2           2606    51230    users users_tenant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(tenant_id);
 D   ALTER TABLE ONLY public.users DROP CONSTRAINT users_tenant_id_fkey;
       public          postgres    false    222    216    5033                  x������ � �             x������ � �      "      x������ � �      $      x������ � �      &      x������ � �      D      x������ � �      F      x������ � �         V   x�3�4�4C��������Լμ�\]C#cΤ��4�Ђ�Ē����\��BFjQ*��N$� ��%E�y�@�P������ pv!�         J   x�3�4�4�4�4202�50�52�,.)��K�LCU04�2��20�342�2� N������������!W� �&�         6   x�3�4��4�L�O.K�)�4�2B1�2��$��$&�p�s���Xp��qqq �G         P   x�3��4B##]C]#CK+SK+C=CsSN�������Լ����##�`
L� $����q��qqq �m*      H      x������ � �      J      x������ � �      L      x������ � �      N      x������ � �      R      x������ � �      P      x������ � �      X      x������ � �      V      x������ � �      T      x������ � �      |      x������ � �      ~      x������ � �      z   /   x�3�4�t�LQ(K��L�,�T0�,�,.)��K�2B�3B���qqq ,��            x������ � �            x������ � �          �   x���=�0��˯�.��~$SWgW�V3l,F)�{#b����އ�RX4�Xa������p� b:���r�%��ȶB���,^:o�4��`�)*�혂��4 Q�@,�S��4��K6��w��$ų3����Ѻ�?MJP����Kn�X!�7J��_Gd      �   �   x����!Dc��k��~���.���7پ�,�d���	�B��30��H;��ܐ�h5�f����ƻ<�ܰùQ�jU=
H+�0�%^�t^Os�r����4w�3.(u!_	��"'�!\uzHV"2�_�2�J�DQ�¼��p���(p� ��t�            x�3�4CǜL�?4����� {x�      p   `   x�3�4�t��LL����t.-.��M-RJ�I,���S�OK�LN-�2�s�LQ�M�KLO-�̅�\�@���䌼���׼�̼T�x*������ �@�      :      x������ � �      >      x������ � �      <      x������ � �      @      x������ � �      B      x������ � �      n   u   x�3�4�47�4�,J���L�L)v�/JN�7�3�w�K����+)V�0��+HI��F��z�f�@����������i�``bejfeb�gli�K�ˈ(��-54�35"�R\�\1z\\\ ��7      Z      x������ � �      ^      x������ � �      \      x������ � �      `      x������ � �      b      x������ � �         �   x�uL��0��_����0���\ltu!��)���Wq3���%w�0��ׯ4�]�)�A�d�"��ty�a"��\}�x��9�=fIC�q"ݴ����;�]�$`�cF&3�������=�
�&������Z�z�J�6@,�      d      x������ � �      f      x������ � �      h      x������ � �      j      x������ � �      0      x������ � �      4      x������ � �      2      x������ � �      6      x������ � �      8      x������ � �      (      x������ � �      *      x������ � �      .      x������ � �      ,      x������ � �      r     x�͙�n�0Ư�S�.�C[�\����w�SgX\�&{��Pb��b|�����䐯��(#�������~{�v�>~�?�L*bHY��ܘ��ؓ͡�1.�<�Q6��)y/w���ܘ��7���u=Y�x������|����vI2��%1W�#���ۀ鼴g@L~&�-�%�����]uG�>7My�,�Ǹ��7Ҽ�-��%�k��?u�A
��C`D$��#dx	B`��#h<B�G(�����������J=�:z(u�P�8 (�:z(u�����������������������(�1F����N�A���|�Wh�Wh-�J�}c�t���|[>/����uK���H����Z�9�Cwxy�xE�x9��ō���q�eq�ɸ�T�xn��<!xR˯f�B�1���];������%Ex/��Kس��k,�	���. ��nbZ��R>��� �c���x[��2~��A�e��A�e��Ase��Ace���$I~k�Y�      
   6  x���;�AE��Ux�����k!� �����	���$��88�<�Q)��n�O�~Җ��~|��U~=�}�s�n��,�ɤ�E3!M3)z�P��!��s^�9�����#hm\�W���C��64h򔊞-ă2ѳ�xP.z�*D���A��Qbͭ�T��bG���;���Z��2|tT�I���^V���^vo՝y��x�Ś�B����S�u�N߶��CMq�%<��ISP��S*~P�#e��?R.~P�#�AŎ{������TI��8�/�ׯ;�r��u����f�%����(f^%&3o��w�f�C�f�SR���d�BN2}!'����L_�I�/�$�r��9��b�BN1}!����SL_�)�/��r��9��b�BN1}!g2}!g2}!g2}!g2}!g2}!g>��Nח��ό��͢!�9����J[���)��<�n�JY�S%�xj�r�Z���Z��f�� p���;Je��F�=0�����n4	v�)x��u��zg]��>����w3��n��K����n3�xm�6�����19����1��c��m         Z   x�3�4�4B�P_]C#cN�� �Ģ̴��Ē��<΀�����N##]C]CKdfqIQf^:��#�9FF$��\�Y������ 2�%�         5   x�3�4�������NC.#4#.c4c.�HJ~rYbH�)��W� ��@         u   x�3�4C##]C]CK##+C+Ss=##΀��C(���Z���S�e�iD�.CC8����]��������9�sNbQfZfrbIf~���B� �)F03���Q�q��qqq ��3      v   E   x�3�4�t��+I�+Q.M��,.���S0�,�LL.�,K�2®�����$��D���3���b���� J�%      �   :   x�3�4�t�,��,�,.ILOU0�2
9�����U�����%��%@!����� !��      x   6   x�3�4�J�P.M��,.���S��OIU0�,�LL.�,K�2¡��$F��� n2�      t   =   x�3�4�r�P�,HU0�,�LL.�,K�2B7B��ŋ�*
A@����� �         K   x�3�4�t�LQIM��,-N-���2
���p:��f�e�%��qq�%܊��J�sR�Q�F\1z\\\ �1H      �   %  x��TK�� >�_���������RE�V�*b����-C�M}q��٫�P	1l���a�Te���J-��-ܙGk+��fگ�o�g?-RK[�, �-N%���z��h��AD�Jn�L��V�U�FO��"�xBk�e!T��Dx�\��D@!XP�`lP!D��ʅÑ�Y�4��W�Y�V�4�
��ͮ���ȏ�����l��Z�j!�FŽ>2&s�"
�>7I����m���� �+��'yPZ�לG��@�@������m}F߬+3zU��m��A�����D� ��U�/���W�&P��u�]���z�4V?8�1�	c	e��͹oct�~O�&��]:�bT�uCC+�U6��WM�).�G��)8�	��0�f��#��Yi,s�޳�䅖᫡���p1���޵�kY��uOh�p����P�b$vʠ���&W���!
��.�xV����˯s���u�{��7Ѱ��Q��v)u￟:ʍ�ɱ�*$u*�D	��'I���V�Z�m����y�c�����w����c      l      x������ � �         �   x�ŏ;�@��˯H�Nw��G*QAL�#I�1�F�3ޝ��z_)����Yfaf���URxŧu�.�8�9�o�2���l���X0o>p�徝LZ���#f���`,9o��_�/#2>mP�	�<�5/�\4řmT!�(�u��aS>�F������I���o���YY|R�;�e�ڿ��^EzV�@�k��E���e� ���u     