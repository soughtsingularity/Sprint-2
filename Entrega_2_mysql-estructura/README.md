# Descripción

Modelarem diversos diagrames entitat-relació.

## Nivel 1

### Exercici 1 - Òptica
Una òptica, anomenada “Cul d'Ampolla”, vol informatitzar la gestió dels clients/es i vendes d'ulleres.

En primer lloc, l'òptica vol saber quin és el proveïdor de cadascuna de les ulleres. En concret vol saber de cada proveïdor: El nom, l'adreça (carrer, número, pis, porta, ciutat, codi postal i país), telèfon, fax, NIF.

La política de compres de l'òptica es basa que les ulleres d'una marca es compraran a un únic proveïdor (així en podrà treure més bons preus), però poden comprar ulleres de diverses marques a un proveïdor. De les ulleres vol saber: La marca, la graduació de cadascun dels vidres, el tipus de muntura (flotant, pasta o metàl·lica), el color de la muntura, el color de cada vidre, el preu.

Dels clients/es vol emmagatzemar: El nom, l'adreça postal, el telèfon, el correu electrònic, la data de registre.
Quan arriba un/a client/a nou, emmagatzemar el/la client/a que li ha recomanat l'establiment (sempre que algú li hagi recomanat).
El nostre sistema haurà d’indicar qui ha sigut l’empleat/da que ha venut cada ullera. Defineix un període de temps de vendes.

### Exercici 2 - Pizzeria
T’han contractat per a dissenyar una web que permeti fer comandes de menjar a domicili per Internet.

Tingues en compte les següents indicacions per a modelar com seria la base de dades del projecte:

- Per a cada client/a emmagatzemem un identificador únic: Nom, cognoms, adreça, codi postal, localitat, província, número de telèfon.

- Una persona pot realitzar moltes comandes, però una única comanda només pot ser realitzat per una única persona. De cada comanda s'emmagatzema un identificador únic: Data/hora, si la comanda és per a repartiment a domicili o per a recollir en botiga, la quantitat de productes que s'han seleccionat de cada tipus, el preu total.

- Una comanda pot constar d'un o diversos productes.

- Els productes poden ser pizzes, hamburgueses i begudes. De cada producte s'emmagatzema un identificador únic: Nom, descripció, imatge, preu.

- En el cas de les pizzes existeixen diverses categories que poden anar canviant de nom al llarg de l'any. Una pizza només pot estar dins d'una categoria, però una categoria pot tenir moltes pizzes.

- De cada categoria s'emmagatzema un identificador únic i un nom. Una comanda és gestionada per una única botiga i una botiga pot gestionar moltes comandes. De cada botiga s'emmagatzema un identificador únic: Adreça, codi postal, localitat, província.

- En una botiga poden treballar molts empleats/des i un empleat/da només pot treballar en una botiga. De cada empleat/da, s'emmagatzema un identificador únic: Nom, cognoms, NIF, Telèfon.

- Si treballa com a cuiner/a o repartidor/a. Per a les comandes de repartiment a domicili interessa guardar qui és el repartidor/a que fa el lliurament de la comanda i la data/hora del moment del lliurament.

## Nivel 2

### Exercici 1 - YouTube

Tractarem de fer un model senzill de com seria la base de dades per a una versió reduïda de YouTube.

- De cada usuari/ària guardem un identificador únic: Email, password, nom d'usuari/ària, data de naixement, sexe, país, codi postal.

- Un usuari/ària publica vídeos. De cada vídeo guardem un identificador únic: Un títol, una descripció, una grandària, el nom de l'arx- iu de vídeo, durada del vídeo, un thumbnail, el nombre de reproduccions, el número de likes, el número de dislikes.

- Un vídeo pot tenir tres estats diferents: públic, ocult i privat. Un vídeo pot tenir moltes etiquetes. Una etiqueta s'identifica per un identificador únic i un nom d'etiqueta. Interessa guardar qui és l'usuari/ària que publica el vídeo i en quina data/hora el fa.

- Un usuari/ària pot crear un canal. Un canal té un identificador únic: Un nom, una descripció, una data de creació.

- Un usuari/ària es pot subscriure als canals d'altres usuaris/es. Un usuari/ària pot donar-li un like o un dislike a un vídeo una única vegada. Caldrà portar un registre dels usuaris/es que li han donat like i dislike a un determinat vídeo i en quina data/hora ho van fer.

- Un usuari/ària pot crear playlists amb els vídeos que li agraden. Cada playlist té un identificador únic: Un nom, una data de creació, un estat que indica que pot ser pública o privada.

- Un usuari/ària pot escriure comentaris en un vídeo determinat. Cada comentari està identificat per un identificador únic: El text del comentari, la data/hora en la qual es va realitzar.

- Un usuari/ària pot marcar un comentari com m'agrada o no m'agrada. Caldrà portar un registre dels usuaris/es que han marcat un comentari com m'agrada/no m'agrada, i en quina data/hora ho van fer.

## Nivel 3

### Exercici 1 - Spotify

- Tractarem de fer un model senzill de com seria la base de dades necessària per a Spotify.

- Existeixen dos tipus d'usuaris/es: free i prèmium. De cada usuari/ària guardem un identificador únic: Email, password, nom d'usuari/ària, data de naixement, sexe, país, codi postal.

- Els usuaris/es prèmium fan subscripcions. Les dades necessàries que caldrà guardar per a cada subscripció són: Data d'inici de la subscripció, data de renovació del servei, una forma de pagament, que pot ser mitjançant targeta de crèdit o PayPal.

- De les targetes de crèdit guardem el número de targeta, mes i any de caducitat i el codi de seguretat. Dels usuaris/es que paguen amb PayPal guardem el nom d'usuari/ària de PayPal. Ens interessa portar un registre de tots els pagaments que un usuari/ària prèmium ha anat realitzant durant el període que està subscrit. De cada pagament es guarda: La data, un número d'ordre (que és únic), un total.

- Un usuari/ària pot crear moltes playlists. De cada playlist guardem: Un títol, el nombre de cançons que conté, un identificador únic, una data de creació.

- Quan un usuari/ària esborra una playlist no s'esborra del sistema, sinó que es marca com que ha estat eliminada. D'aquesta manera l'usuari/ària pot tornar a recuperar les seves playlists en cas que les hagi eliminat per error. És necessari emmagatzemar la data en la qual la playlist ha estat marcada com eliminada.

- Podem dir que existeixen dos tipus de playlists: actives i esborrades. Una playlist que està activa pot ser compartida amb altres usuaris/es, això vol dir que altres usuaris/es poden afegir cançons en ella. En una llista compartida ens interessa saber quin usuari/ària ha estat el que ha afegit cada cançó i en quina data ho va fer.

- Una cançó només pot pertànyer a un únic àlbum. Un àlbum pot contenir moltes cançons. Un àlbum ha estat publicat per un/a únic/a artista. Un/a artista pot haver publicat molts àlbums. De cada cançó guardem un identificador únic: Un títol, una durada, el nombre de vegades que ha estat reproduïda pels usuaris/es de Spotify.

- De cada àlbum guardem un identificador únic: Títol, any de publicació, una imatge amb la portada.

- De cada artista guardem un identificador únic: Nom, una imatge de l'artista

- Un usuari/ària pot seguir a molts/es artistes. Un/a artista pot estar relacionat/da amb altres artistes que facin música semblant. De manera que Spotify pugui mostrar-nos un llistat d'artistes relacionats/des amb els artistes que ens agraden. També ens interessa guardar quins són els àlbums i les cançons favorites d'un usuari/ària. Un usuari/ària pot seleccionar molts àlbums i moltes cançons com a favorites.

NOTA: Un cop creada les bases de dades, omplirem les taules amb dades de prova per tal de verificar que les relacions són correctes.


# Diseño er y creación de DB Mysql

## 💻 Tecnologías Utilizadas

- MySQL 9
- MySQL Workbrench 8

## 🔑 Requisitos

- Tener versión compatible de MySQL instalada
- Opcional: Tener alguna herramientas de manejo de DB como Workbrench o PHPMyAdmin 
- Tener las bases de datos tienda y universidad en formato sql

## ☕ Instalación

1. Clona el repositorio en tu máquina local:
   ```sh
   git clone https://github.com/soughtsingularity/Sprint-2/tree/main/mysql-estructura

2. Navega al directorio del proyecto:

```cd tu_repositorio```

## ⏩ Ejecución

### Usando la consola de comandos

1. Navega al direcorio del proyecto

```cd_tu_repositorio```

2. Inicia MySQL:

```mysql -u root -p```

3. Asegurate de tener los archivos sql con la creación de las tablas de la base de datos


4. Realiza las consultas