DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify;

-- Users

DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users (
  id_user BIGINT NOT NULL AUTO_INCREMENT,
  email_user VARCHAR(100) NULL,
  password_user VARCHAR(45) NULL,
  userName_user VARCHAR(100) NULL,
  birdthDate_user DATETIME NULL,
  sex_user VARCHAR(45) NULL,
  country_user VARCHAR(100) NULL,
  postalCode_user INT NULL,
  isPremium_uer TINYINT NULL,
  PRIMARY KEY (id_user)
);

-- Payment Methods

DROP TABLE IF EXISTS paymentMethods;

CREATE TABLE IF NOT EXISTS paymentMethods (
  id_paymentMethod INT NOT NULL,
  id_user BIGINT NULL,
  payment_method VARCHAR(45) NULL,
  PRIMARY KEY (id_paymentMethod),
  FOREIGN KEY (id_user) REFERENCES users (id_user)
);

-- Subscriptions

DROP TABLE IF EXISTS subscriptions;

CREATE TABLE IF NOT EXISTS subscriptions (
  id_subscription BIGINT NOT NULL AUTO_INCREMENT,
  id_user BIGINT NOT NULL,
  init_date_subscription DATETIME NOT NULL,
  renewal_date_subscription DATETIME NOT NULL,
  payment_method_subscription INT NOT NULL,
  PRIMARY KEY (id_subscription),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (payment_method_subscription) REFERENCES paymentMethods (id_paymentMethod)
);

-- Credit Cards

DROP TABLE IF EXISTS creditCards;

CREATE TABLE IF NOT EXISTS creditCards (
  id_creditCard BIGINT NOT NULL AUTO_INCREMENT,
  id_payment_method INT NULL,
  number_creditCard BIGINT NULL,
  expireMonth_creditCard INT NULL,
  expireYear_creditCard INT NULL,
  secCode_creditCard INT NULL,
  credit_card_user VARCHAR(45) NULL,
  PRIMARY KEY (id_creditCard),
  FOREIGN KEY (id_payment_method) REFERENCES paymentMethods (id_paymentMethod)
);

-- PayPal Users

DROP TABLE IF EXISTS payPalUsers;

CREATE TABLE IF NOT EXISTS payPalUsers (
  id_payPalUser BIGINT NOT NULL AUTO_INCREMENT,
  id_payment_method INT NULL,
  user_name_paypal_paypal_user VARCHAR(100) NULL,
  payment_method_id VARCHAR(45) NULL,
  PRIMARY KEY (id_payPalUser),
  FOREIGN KEY (id_payment_method) REFERENCES paymentMethods (id_paymentMethod)
);

-- Payments

DROP TABLE IF EXISTS payments;

CREATE TABLE IF NOT EXISTS payments (
  id_payment BIGINT NOT NULL AUTO_INCREMENT,
  id_subscription BIGINT NULL,
  date_payment TIMESTAMP NULL,
  oerderNumber_payment BIGINT NOT NULL,
  total_payment FLOAT NULL,
  PRIMARY KEY (id_payment),
  FOREIGN KEY (id_subscription) REFERENCES subscriptions (id_subscription)
);

-- Playlist States

DROP TABLE IF EXISTS playlitsStates;

CREATE TABLE IF NOT EXISTS playlitsStates (
  id_playlit_state INT NOT NULL,
  name_state VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_playlit_state)
);

-- Playlists

DROP TABLE IF EXISTS playlists;

CREATE TABLE IF NOT EXISTS playlists (
  id_playlist BIGINT NOT NULL AUTO_INCREMENT,
  id_user BIGINT NOT NULL,
  name_playlist VARCHAR(45) NULL,
  songs_playlist INT NULL,
  created_at_playlist TIMESTAMP NULL,
  playlist_state INT NOT NULL,
  deleted_at_Playlist TIMESTAMP NOT NULL,
  PRIMARY KEY (id_playlist),
  INDEX fk_playlists_1_idx (id_user ASC) VISIBLE,
  INDEX fk_playlists_2_idx (playlist_state ASC) VISIBLE,
  CONSTRAINT fk_playlists_1
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (playlist_state) REFERENCES playlitsStates (id_playlit_state)
);

-- Shared Playlists

DROP TABLE IF EXISTS sharedPlaylists;

CREATE TABLE IF NOT EXISTS sharedPlaylists (
  id_shared_Playlist BIGINT ZEROFILL NOT NULL,
  id_playlist BIGINT NULL,
  user_id_addsong BIGINT NULL,
  date_addsong TIMESTAMP NULL,
  PRIMARY KEY (id_shared_Playlist),
  FOREIGN KEY (id_playlist) REFERENCES playlists (id_playlist),
  FOREIGN KEY (user_id_addsong) REFERENCES users (id_user)
);

-- Artists

DROP TABLE IF EXISTS artists;

CREATE TABLE IF NOT EXISTS artists (
  id_artist BIGINT NOT NULL AUTO_INCREMENT,
  name_artist VARCHAR(45) NOT NULL,
  image_artist VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_artist)
);

-- Albums

DROP TABLE IF EXISTS Albums;

CREATE TABLE IF NOT EXISTS Albums (
  id_album BIGINT NOT NULL,
  id_artist BIGINT NULL,
  title_album VARCHAR(100) NOT NULL,
  published_at_album TIMESTAMP NOT NULL,
  image_album VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_album),
  FOREIGN KEY (id_artist) REFERENCES artists (id_artist)
);

-- Songs

DROP TABLE IF EXISTS Songs;

CREATE TABLE IF NOT EXISTS Songs (
  id_song BIGINT NOT NULL AUTO_INCREMENT,
  id_album BIGINT NOT NULL,
  title_song VARCHAR(100) NOT NULL,
  duration_song TIME NOT NULL,
  num_reproductions_song BIGINT NOT NULL,
  PRIMARY KEY (id_song),
  INDEX fk_Songs_1_idx (id_album ASC) VISIBLE,
  CONSTRAINT fk_Songs_1
  FOREIGN KEY (id_album) REFERENCES Albums (id_album)
);

-- Followed Artists

DROP TABLE IF EXISTS folowed_artists;

CREATE TABLE IF NOT EXISTS folowed_artists (
  id_folowed_artists INT NOT NULL AUTO_INCREMENT,
  id_user BIGINT NOT NULL,
  id_artist BIGINT NOT NULL,
  PRIMARY KEY (id_folowed_artists),
  CONSTRAINT fk_folowed_artists_1
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_artist) REFERENCES artists (id_artist)
);

-- Music Styles

DROP TABLE IF EXISTS music_styles;

CREATE TABLE IF NOT EXISTS music_styles (
  id_music_styles INT NOT NULL,
  name_music_style VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_music_styles)
);

-- Music Styles Same Artists

DROP TABLE IF EXISTS music_styles_same_artists;

CREATE TABLE IF NOT EXISTS music_styles_same_artists (
  id_music_styles_same_artist BIGINT NOT NULL AUTO_INCREMENT,
  id_music_style INT NOT NULL,
  id_artist BIGINT NOT NULL,
  PRIMARY KEY (id_music_styles_same_artist),
  FOREIGN KEY (id_music_style) REFERENCES music_styles (id_music_styles),
  FOREIGN KEY (id_artist) REFERENCES artists (id_artist)
);

-- Favorite Songs

DROP TABLE IF EXISTS favorite_songs;

CREATE TABLE IF NOT EXISTS favorite_songs (
  id_favorite_songs INT NOT NULL AUTO_INCREMENT,
  id_user BIGINT NULL,
  id_song BIGINT NULL,
  PRIMARY KEY (id_favorite_songs),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_song) REFERENCES Songs (id_song)
);

-- Favorite Albums

DROP TABLE IF EXISTS favorite_albums;

CREATE TABLE IF NOT EXISTS favorite_albums (
  id_favorite_album INT NOT NULL,
  id_user BIGINT NULL,
  id_album BIGINT NULL,
  PRIMARY KEY (id_favorite_album),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_album) REFERENCES Albums (id_album)
);

-- Insert data into Users

INSERT INTO users (email_user, password_user, userName_user, birdthDate_user, sex_user, country_user, postalCode_user, isPremium_uer) VALUES
('user1@example.com', 'password1', 'User One', '1990-01-01 00:00:00', 'Male', 'Country1', 12345, 1),
('user2@example.com', 'password2', 'User Two', '1992-02-02 00:00:00', 'Female', 'Country2', 23456, 0),
('user3@example.com', 'password3', 'User Three', '1994-03-03 00:00:00', 'Male', 'Country3', 34567, 1);

-- Insert data into paymentMethods
INSERT INTO paymentMethods (id_paymentMethod, id_user, payment_method) VALUES
(1, 1, 'Credit Card'),
(2, 2, 'PayPal');

-- Insert data into subscriptions
INSERT INTO subscriptions (id_user, init_date_subscription, renewal_date_subscription, payment_method_subscription) VALUES
(1, '2023-01-01 00:00:00', '2024-01-01 00:00:00', 1),
(3, '2023-02-01 00:00:00', '2024-02-01 00:00:00', 1);

-- Insert data into creditCards
INSERT INTO creditCards (id_payment_method, number_creditCard, expireMonth_creditCard, expireYear_creditCard, secCode_creditCard, credit_card_user) VALUES
(1, 1234567890123456, 02, 2026, 123, 'User1CC');

-- Insert data into payPalUsers
INSERT INTO payPalUsers (id_payment_method, user_name_paypal_paypal_user, payment_method_id) VALUES
(2, 'user2Paypal', 'PM-USER2-0001');

-- Insert data into payments
INSERT INTO payments (id_subscription, date_payment, oerderNumber_payment, total_payment) VALUES
(1, '2023-01-10 12:00:00', 100001, 9.99),
(2, '2023-02-10 12:00:00', 100002, 9.99);

-- Insert data into playlitsStates
INSERT INTO playlitsStates (id_playlit_state, name_state) VALUES
(1, 'Active'),
(2, 'Private'),
(3, 'Deleted');

-- Insert data into playlists
INSERT INTO playlists (id_user, name_playlist, songs_playlist, created_at_playlist, playlist_state, deleted_at_Playlist) VALUES
(1, 'Rock Classics', 10, '2023-01-01 05:00:00', 1, '2023-12-31 23:59:59'),
(2, 'Pop Hits', 12, '2023-02-01 07:00:00', 1, '2023-12-31 23:59:59');

-- Insert data into sharedPlaylists
INSERT INTO sharedPlaylists (id_shared_Playlist, id_playlist, user_id_addsong, date_addsong) VALUES
(0000000001, 1, 2, '2023-01-02 09:00:00'),
(0000000002, 1, 3, '2023-01-03 10:00:00');

-- Insert data into artists
INSERT INTO artists (name_artist, image_artist) VALUES
('Artist One', 'artist-one.jpg'),
('Artist Two', 'artist-two.png'),
('Artist Three', 'artist-three.jpg');

-- Insert data into Albums
INSERT INTO Albums (id_album, id_artist, title_album, published_at_album, image_album) VALUES
(1, 1, 'Album One', '2020-01-01 00:00:00', 'album-one.jpg'),
(2, 1, 'Album Two', '2021-02-02 00:00:00', 'album-two.png'),
(3, 2, 'Album Three', '2022-03-03 00:00:00', 'album-three.jpg');

-- Insert data into Songs
INSERT INTO Songs (id_album, title_song, duration_song, num_reproductions_song) VALUES
(1, 'Song One', '00:03:45', 100),
(1, 'Song Two', '00:04:20', 200),
(2, 'Song Three', '00:02:55', 300),
(3, 'Song Four', '00:05:10', 400);

-- Insert data into folowed_artists
INSERT INTO folowed_artists (id_user, id_artist) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Insert data into music_styles
INSERT INTO music_styles (id_music_styles, name_music_style) VALUES
(1, 'Rock'),
(2, 'Pop'),
(3, 'Jazz');

-- Insert data into music_styles_same_artists
INSERT INTO music_styles_same_artists (id_music_style, id_artist) VALUES
(1, 1),
(2, 2),
(1, 3);

-- Insert data into favorite_songs
INSERT INTO favorite_songs (id_user, id_song) VALUES
(1, 1),
(2, 2),
(3, 1);

-- Insert data into favorite_albums
INSERT INTO favorite_albums (id_favorite_album, id_user, id_album) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);






