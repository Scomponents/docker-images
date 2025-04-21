### Image to run the SCell Web Component with [jpro-loadbalancer](https://www.jpro.one)

##### NOTE
The image does not contain any proprietary artifacts/distributives or information, it is just container to convenient setting up the Polarion® system using artifacts owned by end-user.

**[Docker Hub](https://hub.docker.com/r/scalablecomponents/scell-web-jpro)**

### Example usage

1. Create a working folder with `docker-compose.yml` and `files` subfolder
2. Place the `jpro-loadbalancer.jar` and the (given) scellweb.zip artifacts into the `files`
3. Place the `application.properties` file into the `files`
4. Place the `docker-compose.yml` into the created working folder with the following content:
```yml
services:
  scell-jpro:
    image: scalablecomponents/scell-web-jpro:temurin-jre21-0.0.2
    ports:
      - 8080-8120:8080-8120
    volumes:
      - ./files/jpro-logs:/opt/jpro-loadbalancer/logs
      - ./files/ssl:/opt/jpro-loadbalancer/ssl
      - ./files/apache-logs:/opt/apache-logs
      - ./files/jpro-loadbalancer-0.15.0-SNAPSHOT.jar:/opt/jpro-loadbalancer/jpro-loadbalancer.jar
      - ./files/SCell-1.6.1-java11_web-3.5.0_2025.1.0-jpro.zip:/opt/jpro-loadbalancer/scellweb.zip
      - ./files/application.properties:/opt/jpro-loadbalancer/application.properties
      - ./files/xlsxs:/opt/jpro-loadbalancer/xlsxs
```
5. Run the docker-compose services
6. Options, to connect some demo files and additional fonts. To load custom fonts, create subfolder `files/fonts` and put here your ttf-fonts; to add some demo files, create `files/xlsxs` and put to it needed files. Full example:
```yml
services:
  scell-jpro:
    image: scalablecomponents/scell-web-jpro:temurin-jre21-0.0.2
    ports:
      - 18081-18120:18080-18120
    volumes:
      - ./files/jpro-logs:/opt/jpro-loadbalancer/logs
      - ./files/ssl:/opt/jpro-loadbalancer/ssl
      - ./files/apache-logs:/opt/apache-logs
      - ./files/jpro-loadbalancer-0.15.0-SNAPSHOT.jar:/opt/jpro-loadbalancer/jpro-loadbalancer.jar
      - ./files/SCell-1.6.1-java11_web-3.5.0_2025.1.0-jpro.zip:/opt/jpro-loadbalancer/scellweb.zip
      - ./files/application.properties:/opt/jpro-loadbalancer/application.properties
      - ./files/xlsxs:/opt/jpro-loadbalancer/xlsxs
    environment:
      SCELL_WEB_FONTS_FOLDER_1: /usr/share/fonts/truetype/msttcorefonts/
      SCELL_WEB_SHOW_WATERMARK: False
      SCELL_WEB_DEMO_FILE_FULL_PATH_1: /opt/jpro-loadbalancer/xlsxs/demo.xlsx
      JPRO_SERVER_PORT: 18080
      JPRO_LOADBALANCER_START_PORT: 18100
      RUN_APACHE_HTTPS: True
      APACHE_HTTPS_HOST: intechcore.space
      APACHE_HTTPS_PORT: 18120
      APACHE_HTTPS_COMMON_CONFIG: options-ssl-apache.conf
      APACHE_SSL_CERTIFICATE_FILE: fullchain11.pem
      APACHE_SSL_CERTIFICATE_KEY_FILE: privkey11.pem
