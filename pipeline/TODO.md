 Steps
 ---
 - run openvas
    - run openvasmd
        - build image with all included: # docker build -f pipeline/build/master
            - wget, socat, nmap, git, python-pip
            - openvasmd, openvassd, gsad...
            - setup: - add user, db
            - postgresql
            - redis
            - worker code 
                - ADD git-url code 
                - pip install -r requirements.txt
            - worker cfg
        - update defs (additional image: ???)
            - start pg, openvasmd
            - setup
                - build db, update defs (long operation!)
            - stop openvasmd, pg
        - run container
            - run postgresql/socat-pg
            - run redis/socat-rd
            - setup pg user & db
            - setup scan configs
            - update definitions
    - run openvassd
    - run gsad
 
 
 Structure
 ---

 - build: Dockerfile(s)
    - master-image 
        - svlasov/openvas from debian:jessie
            - compile/install/add
                - ov_manager
                    - openvasmd
                    - openvasmd-pg
                - ov_scanner
                - ov_gsadweb
                - pg_db(data volume)
                - redis
                - worker(code volume, custom config volume)
                - mongod?
            - checklist
                - which 
            - setup
                - run pg_db
                - setup db user, data etc.
            - default entry point runs bash

 - update: 
    - openvas: nvts etc. -> ship as a volume image
    - worker: code, config -> ship as 2 separate volume images
 
 - run: docker-compose.yml(s)
    - services
        - scanner
            - openvas
                - manager
                - scanner
                - gsadweb
                - postgre
                - redisdb
            - worker
                - vs-wrkr
                - mongodb

 - deploy
    - update
        - master image
            - SD
                - scan configs
                - worker code
            - OV
                - def dbs
        - custom image
            - worker config
    