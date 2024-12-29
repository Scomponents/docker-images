#### Auxiliary Postgres DB image to containerize the ALM™ system **[POLARION®](https://polarion.plm.automation.siemens.com/)** from **[Siemens](https://www.siemens.com/de/de.html)**

##### NOTE
The image does not contain any proprietary artifacts/distributives or information, it is just container to convenient setting up the Polarion® system using artifacts owned by end-user.

**[Docker Hub](https://hub.docker.com/r/scalablecomponents/polarion-postgres-db)**

Implemented as part of development the SCell Spreadsheet Editor extension for Polarion® ALM™ ([Home Page](https://scalable-components.com/scell-spreadsheet-editor/)).

The Polarion® system required two databases named `polarion` and `polarion_history`, this image is for containerize them.

##### Environment variables and its default values

| Variable | Description | Default value |
|---------:|-------------|---------------|
| `POSTGRES_USER` | Owner of target Polarion databases | `polarion` |
| `POSTGRES_PASSWORD` | Password of the POSTGRES_USER | `polarion` |
| `POSTGRES_DB` | Name of the main Polarion database | `polarion` |
| `POLARION_HISTORY_DB` | Name of the history Polarion database | `polarion_history` |
| `POSTGRES_INITDB_ARGS` | Required args for Polarion databases | `-E utf8 --auth-host=md5` |


