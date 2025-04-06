#### Image to containerize the ALM™ system **[POLARION®](https://polarion.plm.automation.siemens.com/)** from **[Siemens](https://www.siemens.com/de/de.html)**

##### NOTE
The image does not contain any proprietary artifacts/distributives or information, it is just container to convenient setting up the Polarion® system using artifacts owned by end-user.

**[Docker Hub](https://hub.docker.com/r/scalablecomponents/polarion)**

##### TAGS HISTORY
- [0.1-bookworm](https://hub.docker.com/repository/docker/scalablecomponents/polarion/tags/0.1-bookworm/sha256:ff2c8d04cd409a2988fcd2a89606815f0759c51c56df87d1e34eb263ffa167bb) - init build, tested on Polarion® v2310
- [0.2-bookworm](https://hub.docker.com/repository/docker/scalablecomponents/polarion/tags/0.2-bookworm/sha256:c33ce62643bb50e258af5a554cb066d3d6994f378f37ba14b5f72a24590899af) - fixed for Windows, add settings for SCell Spreadsheet Editor plugin, tested on Polarion® v2410
- [0.3-bookworm](https://hub.docker.com/repository/docker/scalablecomponents/polarion/tags/0.3-bookworm/sha256-a185cd2bf51fe5f044c4a4b3f1f93258a495826dcb3e39d67854e023c3f5897e) - fixed running after container was recreated, added possibility to full reindex the database

### How To Work
The image required the following Docker volumes on the host side:
```
services:
    polarion:
        volumes:
          - ./data/distr:/opt/distr/Polarion
          - ./data/polarion-opt:/opt/polarion
          - ./data/extensions:/opt/polarion/polarion/extensions
```
If run on Windows, use named volumes because of perfomance and compatibility issues:
```
volumes:
    polarion-opt:

services:
    polarion:
        volumes:
          - ./data/distr:/opt/distr/Polarion
          - polarion-opt:/opt/polarion
          - ./data/extensions:/opt/polarion/polarion/extensions
```

- The `./data/distr` folder must contain the Polarion® installation distributive artifact named as `polarionALM_linux.zip` (this name can be changed by setting `POLARION_LINUX_DISTR_ZIP_NAME` environment variable);
- The `polarion-opt` volume will contain installed Polarion system files;
- Installation process starts by checking `./data/polarion-opt/bin/polarion.init` file exist. Remove it to reinstall the product (if the Docker container was recreated);
- Set env variable `RUN_FULL_REINDEX` to `true` to run Polarion's full reindex on next container start
- There are following environment variables to additional setup:

| Variable | Description | Default value |
|---------:|-------------|---------------|
| `DB_HOST` | Postgres DB host name | `polarion` |
| `DB_USER_NAME` | Postgres DB user name to connect with | `polarion` |
| `DB_PORT` | Port to connect to Postgres DB host | `5432` |
| `DB_PASS` | Password to Postgres DB user to connect with | `polarion` |
| `WWW_DATA_USER` | User which Apache2 service run with | `www-data` |
| `WWW_DATA_GROUP` | User's group which Apache2 service run with | `www-data` |
