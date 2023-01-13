## MonorepoProject structure

```
monorepo
    - project
        - apps
            - monitoring
            - notifier
            - roles-manager
            - router-permission-checker
            - texchange
        - packages
            - php
                - DTO
                    - ...
                - microservice-...
                - SharedDatabases
        - monorepo-tools
    - laradocks
        - laradock_for_php_service
        - laradocks_for_microservices
            - router-permission-checker (out - http://localhost:79  in - http://nginx-microservice-router-permission-checker)
            - roles-manager             (out - http://localhost:80  in - http://nginx-microservice-roles-manager)
            - notifier                  (out - http://localhost:81  in - http://nginx-microservice-notifier)
            - main-account              (out - http://localhost:82  in - http://nginx-microservice-main-account)
            - frontend-gateway          (out - http://localhost:83  in - http://nginx-microservice-frontend-gateway)
            - winessy-monolith          (out - http://localhost:84  in - http://nginx-microservice-winessy-monolith)
```


## Development environment 

#### at first init

`docker network create microservices-network`

#### laradock_for_php_service
**all "global"** containers like Mysql / Redis / RabbitMq / e.t.c
```
docker-compose up -d mysql redis beanstalkd
```

#### laradock_for_microservices
self microservice containers nginx / php-fpm / workspace / nodejs(optional)   
**all "global"** containers like Mysql / Redis / RabbitMq / e.t.c
```
docker-compose up -d nginx php-fpm workspace php-worker
```

##### _env_examples has default data for microservices like pathes and port   
```
ln -s _env_examples/.env.79.router-permission-checker .env
ln -s _env_examples/.env.80.roles-manager .env
ln -s _env_examples/.env.81.notifier .env
ln -s _env_examples/.env.82.main-account .env
ln -s _env_examples/.env.83.frontend-gateway .env
ln -s _env_examples/.env.84.winessy-monolith .env
```

##### php-worker/default_supervisor_configs has default supervisor configs for microservices   
```
cp php-worker/default_supervisor_configs/main-account-worker.conf php-worker/supervisord.d/main-account-worker.conf
cp php-worker/default_supervisor_configs/winessy-monolith-worker.conf php-worker/supervisord.d/winessy-monolith-worker.conf
```


