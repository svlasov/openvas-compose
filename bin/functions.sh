#!/usr/bin/env bash

TEMPLATE=svlasov/openvas
CONTEXT=openvas

build_master_image () {
    docker build -t svlasov/openvas openvas
}

