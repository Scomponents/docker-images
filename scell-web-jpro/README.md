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
    image: scalablecomponents/scell-web-jpro:temurin-jre21-0.0.1
    ports:
      - 8080-8120:8080-8120
    volumes:
      - ./files/jpro-loadbalancer-0.13.0.jar:/opt/jpro-loadbalancer/jpro-loadbalancer.jar
      - ./files/scellweb.zip:/opt/jpro-loadbalancer/scellweb.zip
      - ./files/application.properties:/opt/jpro-loadbalancer/application.properties
      - ./logs:/opt/jpro-loadbalancer/logs
```
5. Run the docker-compose services
6. Options, to connect some demo files and additional fonts. To load custom fonts, create subfolder `files/fonts` and put here your ttf-fonts; to add some demo files, create `files/xlsxs` and put to it needed files. Full example:
```yml
services:
  scell-jpro:
    image: scalablecomponents/scell-web-jpro:temurin-jre21-0.0.1
    ports:
      - 8080-8120:8080-8120
    volumes:
      - ./files/jpro-loadbalancer-0.13.0.jar:/opt/jpro-loadbalancer/jpro-loadbalancer.jar
      - ./files/scellweb.zip:/opt/jpro-loadbalancer/scellweb.zip
      - ./files/application.properties:/opt/jpro-loadbalancer/application.properties
      - ./files/xlsxs:/opt/jpro-loadbalancer/xlsxs
      - ./files/fonts:/opt/jpro-loadbalancer/fonts
      - ./logs:/opt/jpro-loadbalancer/logs
    environment:
      SCELL_WEB_FONTS_FOLDER_1: /opt/jpro-loadbalancer/fonts/
      SCELL_WEB_DEMO_FILE_FULL_PATH_1: /opt/jpro-loadbalancer/xlsxs/demo.xlsx
