#### Image to containerize the ALM™ system **[POLARION®](https://polarion.plm.automation.siemens.com/)** from **[Siemens](https://www.siemens.com/de/de.html)**

##### NOTE
The image does not contain any proprietary artifacts/distributives or information, it is just container to convenient setting up the Polarion® system using artifacts owned by end-user.

**[Docker Hub](https://hub.docker.com/r/scalablecomponents/polarion)**

### How To Work
The image required the following Docker volumes on the host side:
```
      - ./data/distr:/opt/distr/Polarion
      - ./data/polarion-opt:/opt/polarion
```
- The `./data/distr` folder must contain the Polarion® installation distributive artifact named as `polarionALM_linux.zip` (this name can be changed by setting `POLARION_LINUX_DISTR_ZIP_NAME` environment variable);
- The `./data/polarion-opt` will contain installed Polarion system files;
- Installation process starts by checking `./data/polarion-opt/bin/polarion.init` file exist. Remove it to reinstall the product (if the Docker container was recreated);
- There are following environment variables:

| Variable | Description | Default value |
|---------:|-------------|---------------|
| `DB_HOST` | Postgres DB host name | `polarion` |
| `DB_USER_NAME` | Postgres DB user name to connect with | `polarion` |
| `DB_PORT` | Port to connect to Postgres DB host | `5432` |
| `DB_PASS` | Password to Postgres DB user to connect with | `polarion` |
| `WWW_DATA_USER` | User which Apache2 service run with | `www-data` |
| `WWW_DATA_GROUP` | User's group which Apache2 service run with | `www-data` |
