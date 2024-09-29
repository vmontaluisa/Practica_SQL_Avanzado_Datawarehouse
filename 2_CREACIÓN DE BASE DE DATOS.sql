

CREATE TABLE roles (
    id serial NOT NULL,
    nombre varchar(50) NOT NULL
);


CREATE TABLE usuarios (
    id serial NOT NULL,
    nombre varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    rol_id integer,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE profesores (
    id serial NOT NULL,
    usuario_id integer,
    especialidad varchar(100) NOT NULL
);


CREATE TABLE directivos (
    id serial NOT NULL,
    usuario_id integer,
    departamento varchar(100) NOT NULL
);


CREATE TABLE bootcamps (
    id serial NOT NULL,
    nombre varchar(100) NOT NULL,
    descripcion text,
    duracion_meses integer DEFAULT 8,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    precio numeric(10,2) NOT NULL
);


CREATE TABLE cursos_modulos (
    id integer NOT NULL  ,
    nombre varchar(100) NOT NULL,
    descripcion text,
    titulacion varchar(100),
    profesor_id integer,
    precio numeric(10,2) NOT NULL
);


CREATE TABLE inscripciones (
    id serial NOT NULL,
    alumno_id integer,
    bootcamp_id integer,
    curso_id integer,
    fecha_inscripcion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE certificados (
    id serial NOT NULL,
    alumno_id integer,
    curso_id integer,
    fecha_emision timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    archivo_certificado bytea
);


CREATE TABLE facturas (
    id serial NOT NULL,
    usuario_id integer,
    bootcamp_id integer,
    curso_id integer,
    monto numeric(10,2) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE seguimiento_usu_curso (
    usuario_id integer,
    curso_id integer,
    id serial NOT NULL,
    fecha_seguimiento_inicio time(0) without time zone,
    fecha_fin time(0) without time zone,
    video_id integer,
    sesion_id integer
);

CREATE TABLE sesion (
    id serial NOT NULL,
    sesion_uuid varchar(50),
    navegador varchar(100),
    metadata_navegacion varchar(100)
);


CREATE TABLE bootcamp_cursos (
    id serial NOT NULL,
    bootcamp_id integer NOT NULL,
    curso_id integer NOT NULL
);


CREATE TABLE videos (
    id serial NOT NULL,
    titulo_video varchar(200),
    almacenamiento_video varchar(300),
    tipo_video char(2),
    curso_id integer
);


ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_nombre_key
    UNIQUE (nombre);


ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_email_key
    UNIQUE (email);


ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_rol_id_fkey
    FOREIGN KEY (rol_id) REFERENCES roles(id);


ALTER TABLE ONLY profesores
    ADD CONSTRAINT profesores_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY profesores
    ADD CONSTRAINT profesores_usuario_id_fkey
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;


ALTER TABLE ONLY directivos
    ADD CONSTRAINT directivos_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY directivos
    ADD CONSTRAINT directivos_usuario_id_fkey
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;


ALTER TABLE ONLY bootcamps
    ADD CONSTRAINT bootcamps_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY cursos_modulos
    ADD CONSTRAINT cursos_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY cursos_modulos
    ADD CONSTRAINT cursos_profesor_id_fkey
    FOREIGN KEY (profesor_id) REFERENCES profesores(id) ON DELETE SET NULL;


ALTER TABLE ONLY inscripciones
    ADD CONSTRAINT inscripciones_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY inscripciones
    ADD CONSTRAINT inscripciones_alumno_id_fkey
    FOREIGN KEY (alumno_id) REFERENCES usuarios(id) ON DELETE CASCADE;


ALTER TABLE ONLY inscripciones
    ADD CONSTRAINT inscripciones_bootcamp_id_fkey
    FOREIGN KEY (bootcamp_id) REFERENCES bootcamps(id) ON DELETE CASCADE;



ALTER TABLE ONLY inscripciones
    ADD CONSTRAINT inscripciones_curso_id_fkey
    FOREIGN KEY (curso_id) REFERENCES cursos_modulos(id) ON DELETE CASCADE;


ALTER TABLE ONLY certificados
    ADD CONSTRAINT certificados_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY certificados
    ADD CONSTRAINT certificados_alumno_id_fkey
    FOREIGN KEY (alumno_id) REFERENCES usuarios(id) ON DELETE CASCADE;

ALTER TABLE ONLY certificados
    ADD CONSTRAINT certificados_curso_id_fkey
    FOREIGN KEY (curso_id) REFERENCES cursos_modulos(id) ON DELETE CASCADE;


ALTER TABLE ONLY facturas
    ADD CONSTRAINT facturas_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY facturas
    ADD CONSTRAINT facturas_usuario_id_fkey
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;


ALTER TABLE ONLY facturas
    ADD CONSTRAINT facturas_bootcamp_id_fkey
    FOREIGN KEY (bootcamp_id) REFERENCES bootcamps(id);


ALTER TABLE ONLY facturas
    ADD CONSTRAINT facturas_curso_id_fkey
    FOREIGN KEY (curso_id) REFERENCES cursos_modulos(id);



ALTER TABLE ONLY seguimiento_usu_curso
    ADD CONSTRAINT seguimiento_usu_curso_pkey
    PRIMARY KEY (id);



ALTER TABLE ONLY sesion
    ADD CONSTRAINT sesion_pkey
    PRIMARY KEY (id);



ALTER TABLE ONLY bootcamp_cursos
    ADD CONSTRAINT bootcamp_cursos_pkey
    PRIMARY KEY (bootcamp_id, curso_id);



ALTER TABLE ONLY bootcamp_cursos
    ADD CONSTRAINT bootcamp_cursos_id_key
    UNIQUE (id);



ALTER TABLE ONLY bootcamp_cursos
    ADD CONSTRAINT bootcamp_cursos_bootcamp_id_fkey
    FOREIGN KEY (bootcamp_id) REFERENCES bootcamps(id) ON DELETE CASCADE;



ALTER TABLE ONLY bootcamp_cursos
    ADD CONSTRAINT bootcamp_cursos_curso_id_fkey
    FOREIGN KEY (curso_id) REFERENCES cursos_modulos(id) ON DELETE CASCADE;



ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_pkey
    PRIMARY KEY (id);


ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_fk
    FOREIGN KEY (curso_id) REFERENCES cursos_modulos(id);



ALTER TABLE ONLY seguimiento_usu_curso
    ADD CONSTRAINT seguimiento_usu_curso_fk
    FOREIGN KEY (curso_id) REFERENCES cursos_modulos(id);



ALTER TABLE ONLY seguimiento_usu_curso
    ADD CONSTRAINT seguimiento_usu_curso_fk1
    FOREIGN KEY (sesion_id) REFERENCES sesion(id);


ALTER TABLE ONLY seguimiento_usu_curso
    ADD CONSTRAINT seguimiento_usu_curso_fk2
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id);



ALTER TABLE ONLY seguimiento_usu_curso
    ADD CONSTRAINT seguimiento_usu_curso_fk3
    FOREIGN KEY (video_id) REFERENCES videos(id) DEFERRABLE;
