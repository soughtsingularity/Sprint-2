DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
USE youtube;

-- Usuarios

DROP TABLE IF EXISTS usuarios;

CREATE TABLE IF NOT EXISTS usuarios (
  id_usuario BIGINT NOT NULL,
  email_usuario VARCHAR(100) NOT NULL UNIQUE,
  password_susuario VARCHAR(150) NOT NULL,
  nombre_susuario VARCHAR(100) NOT NULL,
  fecha_nacimiento_usuario DATE NOT NULL,
  sexo_usuario INT NOT NULL,
  pais_usuario VARCHAR(100) NOT NULL,
  cp_usuario VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_usuario)
);

-- Estado video (Publico, Oculto, Privado)

DROP TABLE IF EXISTS estados_video;

CREATE TABLE IF NOT EXISTS estados_video (
  id_estados_video INT NOT NULL AUTO_INCREMENT,
  nombre_estado VARCHAR(10) NULL,
  PRIMARY KEY (id_estados_video)
);

-- Tipo de reacción (Like, Dislike)

DROP TABLE IF EXISTS tipo_reaccion;

CREATE TABLE IF NOT EXISTS tipo_reaccion (
  id_reaccion INT NOT NULL AUTO_INCREMENT,
  tipo_reaccion VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_reaccion)
);

-- Estado playlist (Publico, Privado)

DROP TABLE IF EXISTS estados_playlist;

CREATE TABLE IF NOT EXISTS estados_playlist (
  id_estado_playlist INT NOT NULL,
  tipo_estado VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_estado_playlist)
);

-- Canales

DROP TABLE IF EXISTS canales;

CREATE TABLE IF NOT EXISTS canales(
  id_canal BIGINT NOT NULL,
  nombre_canal VARCHAR(50) NOT NULL,
  descripcion_canal VARCHAR(255) NOT NULL,
  fecha_creacion_canal DATETIME NOT NULL,
  PRIMARY KEY (id_canal),
  FOREIGN KEY (id_canal) REFERENCES usuarios (id_usuario)
);

-- Playlists

DROP TABLE IF EXISTS playlists;

CREATE TABLE IF NOT EXISTS playlists (
  id_playlist BIGINT NOT NULL,
  nombre_playlist VARCHAR(45) NOT NULL,
  fecha_creacion_playlist DATETIME NOT NULL,
  estado_playlist INT NOT NULL,
  PRIMARY KEY (id_playlist),
  FOREIGN KEY (id_playlist) REFERENCES usuarios(id_usuario) 
);

-- Videos

DROP TABLE IF EXISTS videos;

CREATE TABLE IF NOT EXISTS videos (
  id_video BIGINT NOT NULL,
  titulo_video VARCHAR(100) NOT NULL,
  descripcion_video VARCHAR(255) NOT NULL,
  tamano_video FLOAT NOT NULL,
  nombre_archivo_video VARCHAR(100) NOT NULL,
  duracion_video FLOAT NOT NULL,
  thumbnail_video BLOB NOT NULL,
  numero_reproducciones DOUBLE NOT NULL,
  numero_likes DOUBLE NOT NULL,
  numero_dislikes DOUBLE NOT NULL,
  estado_video INT NOT NULL,
  PRIMARY KEY (id_video),
  FOREIGN KEY (estado_video) REFERENCES estados_video(id_estados_video)
);

-- Etiquetas

DROP TABLE IF EXISTS etiquetas;

CREATE TABLE IF NOT EXISTS etiquetas (
  id_etiqueta BIGINT NOT NULL,
  nombre_etiqueta VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_etiqueta)
);

-- Comentarios

DROP TABLE IF EXISTS comentarios;

CREATE TABLE IF NOT EXISTS comentarios (
  id_comentario BIGINT NOT NULL,
  texto_comentario VARCHAR(255) NOT NULL,
  fecha_creacion_comentario DATETIME NOT NULL,
  PRIMARY KEY (id_comentario)
);

-- Videos de Usuarios

DROP TABLE IF EXISTS videos_usuario;

CREATE TABLE IF NOT EXISTS videos_usuario (
  id_video BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  fecha_publicacion_video DATETIME NOT NULL,
  PRIMARY KEY (id_video, id_usuario),
  UNIQUE (id_video, id_usuario, fecha_publicacion_video),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (id_video) REFERENCES videos(id_video)
);

-- Videos playlist

DROP TABLE IF EXISTS videos_playlist;

CREATE TABLE IF NOT EXISTS videos_playlist (
  id_videos_playlist BIGINT NOT NULL AUTO_INCREMENT,
  id_playlist BIGINT NOT NULL,
  id_video BIGINT NOT NULL,
  PRIMARY KEY (id_videos_playlist, id_playlist, id_video),
  FOREIGN KEY (id_video) REFERENCES videos(id_video),
  FOREIGN KEY (id_playlist) REFERENCES playlists (id_playlist)
);


-- Etiquetas para videos

DROP TABLE IF EXISTS etiquetas_videos;

CREATE TABLE IF NOT EXISTS etiquetas_videos (
  id_etiquetas_videos BIGINT NOT NULL,
  id_etiqueta BIGINT NOT NULL,
  id_video BIGINT NOT NULL,
  PRIMARY KEY (id_etiquetas_videos, id_etiqueta, id_video),
  FOREIGN KEY (id_etiqueta) REFERENCES etiquetas(id_etiqueta),
  FOREIGN KEY (id_video) REFERENCES videos(id_video)
);

-- Usuarios suscritos a un canal

DROP TABLE IF EXISTS usuarios_suscritos_canal;

CREATE TABLE IF NOT EXISTS usuarios_suscritos_canal (
  id_usuario BIGINT NOT NULL,
  id_canal BIGINT NOT NULL,
  fecha_suscripcion DATETIME NOT NULL,
  PRIMARY KEY (id_usuario, id_canal),
  UNIQUE(id_usuario, id_canal, fecha_suscripcion),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (id_canal) REFERENCES canales(id_canal)
);

-- Video reacción

DROP TABLE IF EXISTS video_reaccion;

CREATE TABLE IF NOT EXISTS video_reaccion (
  id_reaccion BIGINT NOT NULL AUTO_INCREMENT,
  tipo_reaccion INT NOT NULL,
  id_usuario BIGINT NOT NULL,
  id_video BIGINT NOT NULL,
  fecha_reaccion DATETIME NOT NULL,
  PRIMARY KEY (id_reaccion, id_usuario, id_video, tipo_reaccion),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (id_video) REFERENCES videos(id_video),
  FOREIGN KEY (tipo_reaccion) REFERENCES tipo_reaccion(id_reaccion)
);

-- Comentarios reacción

DROP TABLE IF EXISTS comentarios_video_reaccion;

CREATE TABLE IF NOT EXISTS comentarios_video_reaccion (
  id_comentarios_video_reaccion BIGINT NOT NULL AUTO_INCREMENT,
  tipo_reaccion INT NOT NULL,
  id_comentario BIGINT NOT NULL,
  id_usuario BIGINT NOT NULL,
  fecha_comentario_reaccion DATETIME NOT NULL,
  PRIMARY KEY (id_comentarios_video_reaccion, id_comentario, id_usuario, tipo_reaccion),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (id_comentario) REFERENCES comentarios(id_comentario),
  FOREIGN KEY (tipo_reaccion) REFERENCES tipo_reaccion(id_reaccion)
);


INSERT INTO usuarios (id_usuario, email_usuario, password_susuario, nombre_susuario, fecha_nacimiento_usuario, sexo_usuario, pais_usuario, cp_usuario) VALUES
  (1, 'ana@gmail.com', 'password123', 'Anna', '1990-01-01', 2, 'España', '08008'),
  (2, 'hola@yahoo.com', 'password456', 'El guapo', '1985-05-05', 1, 'España', '08009');

INSERT INTO estados_video (id_estados_video, nombre_estado) VALUES
  (1, 'publico'),
  (2, 'oculto'),
  (3, 'privado');

INSERT INTO tipo_reaccion (id_reaccion, tipo_reaccion) VALUES
  (1, 'like'),
  (2, 'dislike');

INSERT INTO estados_playlist (id_estado_playlist, tipo_estado) VALUES
  (1, 'publico'),
  (2, 'privado');

INSERT INTO canales (id_canal, nombre_canal, descripcion_canal, fecha_creacion_canal) VALUES
  (1, 'La merced', 'Un canal sobre religión tecnológica.', '2021-01-01 10:00:00'),
  (2, 'El canal del guapo', 'Los viajes del guapo.', '2021-02-02 11:00:00');

INSERT INTO playlists (id_playlist, nombre_playlist, fecha_creacion_playlist, estado_playlist) VALUES
  (1, 'Noticias', '2021-01-05 14:00:00', 1),
  (2, 'De incógnito', '2021-02-06 15:00:00', 2);

INSERT INTO videos (id_video, titulo_video, descripcion_video, tamano_video, nombre_archivo_video, duracion_video, thumbnail_video, numero_reproducciones, numero_likes, numero_dislikes, estado_video) VALUES
  (1, 'Tormenta explosiva', 'Tormenta explosive en directo.', 500.0, 'tormenta.mp4', 600.0, 0x0, 1000, 150, 10, 1),
  (2, 'No lo sabemos', 'La verdad es que no lo sabemos.', 750.0, 'niidea.mp4', 900.0, 0x0, 2000, 250, 15, 2);

INSERT INTO etiquetas (id_etiqueta, nombre_etiqueta) VALUES
  (1, 'Tecnología'),
  (2, 'Viajes');

INSERT INTO comentarios (id_comentario, texto_comentario, fecha_creacion_comentario) VALUES
  (1, 'Que buen video, colega!', '2021-01-06 16:00:00'),
  (2, 'OMG.', '2021-02-07 17:00:00');

INSERT INTO videos_usuario (id_video, id_usuario, fecha_publicacion_video) VALUES
  (1, 1, '2021-01-02 12:00:00'),
  (2, 2, '2021-02-03 13:00:00');

INSERT INTO videos_playlist (id_videos_playlist, id_playlist, id_video) VALUES
  (1, 1, 1),
  (2, 2, 2);

INSERT INTO etiquetas_videos (id_etiquetas_videos, id_etiqueta, id_video) VALUES
  (1, 1, 1),
  (2, 2, 2);

INSERT INTO usuarios_suscritos_canal (id_usuario, id_canal, fecha_suscripcion) VALUES
  (1, 2, '2021-01-09 22:00:00'),
  (2, 1, '2021-02-10 23:00:00');

INSERT INTO video_reaccion (id_reaccion, tipo_reaccion, id_usuario, id_video, fecha_reaccion) VALUES
  (1, 1, 2, 1, '2021-01-07 18:00:00'),
  (2, 2, 1, 2, '2021-02-08 19:00:00');

INSERT INTO comentarios_video_reaccion (id_comentarios_video_reaccion, tipo_reaccion, id_comentario, id_usuario, fecha_comentario_reaccion) VALUES
  (1, 1, 1, 2, '2021-01-08 20:00:00'),
  (2, 2, 2, 1, '2021-02-09 21:00:00');


