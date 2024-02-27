# selenium-fastapi

## Prerequisites

- [Docker](https://www.docker.com/)
- [Make](https://www.gnu.org/software/make/)


## Prepare `.env` file

Make a copy from `.env.example` to `.env` file. Edit and adjust the file. After that, just need to load the environment
variables:

```shell
cp .env.example .env
vi .env
```

## Run aplication with Docker and Makefile

```shell
make up # production
make up-dev # development
```

## Run the script
    
```shell
make run_script_save_printscreen_page # production
make run_script_save_printscreen_page-dev # development
```
