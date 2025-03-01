#!/bin/bash
#-------------------------------------------------------------#
# This file is for automatically start/stop/create container/stack instances in this folder.
#-------------------------------------------------------------#
# Help: ./docker -h
#List all: ./docker -l
#Start all: ./docker -r
#Stop all: ./docker -s
#Start stack: ./docker -S [StackName] -r
#Stop stack: ./docker -S [StackName] -s
#Create stack: ./docker -c [StackName]

if [ ! -f ".gitignore" ]; then
    echo -e ".stackignore\nglobal.env\nglobal.env.temp" >> .gitignore
fi;

STACK=;
StackIgnore=;
if [ -f ".stackignore" ]; then
    readarray -t StackIgnore < .stackignore
else
    touch .stackignore
fi

GlobalENV=;
if [ -f "global.env" ]; then
    readarray -t GlobalENV < global.env
else
    touch global.env
fi

#
GlobalENVold=;
# GlobalENVnew=;
# GlobalENVdelete=;
if [ -f "global.env.temp" ]; then
    #old
    GlobalENVold=($(grep -vxf global.env global.env.temp))

    #new
    #GlobalENVnew=($(grep -vxf global.env.temp global.env))
    #find deleted lines
    # for olditem in "${GlobalENVold[@]}"
    # do
    #     if [[ ! " ${GlobalENVnew[@]} " =~ " ${olditem} " ]]; then
    #         GlobalENVdelete+=${olditem}
    #         #GlobalENVold=${GlobalENVold[@]/$olditem}
    #     fi
    # done

    rm global.env.temp
    cp global.env global.env.temp
else
    cp global.env global.env.temp
fi

#Add all global variables from global.env to each .env file
for d in */ ; do
    if [ -f "${d}docker-compose.yml" ]; then
        if [ -f "${d}.env" ]; then
            #If GlobalENVold in .env -> delete line in .env
            readarray -t env_temp < ${d}.env
            for deleteitem in "${GlobalENVold[@]}"
            do
                if [[ " ${env_temp[@]} " =~ " ${deleteitem} " ]]; then
                    deleteitem=$(sed -e s/\\//\\[\\/\\]/g <<<"$deleteitem")
                    sed -i "/$deleteitem/d" ${d}.env
                fi
            done

            #Add empty line to file if there is none
            x=$(tail -c 1 ${d}.env)
            if [ "$x" != "" ]; then
                echo >> ${d}.env
            fi

            #If GlobalENV not in .env -> add to .env
            readarray -t env_temp < ${d}.env
            for item in "${GlobalENV[@]}"
            do
                if [[ ! " ${env_temp[@]} " =~ " ${item} " ]]; then
                    echo -e "$item" >> ${d}.env
                fi
            done
        fi
    fi
done

helpFunction()
{
    echo "Help:"
    echo "Usage: $0 [parameter]"
    echo -e "\t-h help"
    echo -e "\t-l list"
    echo -e "\t-r run"
    echo -e "\t-s stop"
    echo -e "\t-S [StackName] stack"
    echo -e "\t-c [StackName] create"
    echo "There is a '.stackignore' file. All stacks inside this file will be ignored when executing ./docker.sh -r or ./docker.sh -s"
    echo "There is a 'global.env' file. Evrything inside this file will be copyed into each '.env' file in each folder/stack in this directory"
    exit 0 # Exit script after printing help
}

List()
{
    #All
    for d in */ ; do
        if [ -f "${d}docker-compose.yml" ]; then
            if [[ " ${StackIgnore[*]} " =~ " ${d} " ]]; then
                echo "[${d}]: Will be ignored";
            else
                echo "[${d}]: Will not be ignored";
            fi
        else
            echo "[${d}]: No docker-compose.yml file";
        fi
    done
}

RunStack()
{
    if [[ ! -z "$STACK" ]]; then
        if [ -f "${STACK}/docker-compose.yml" ]; then
            echo -n "[${STACK}]: ";
            cd ${STACK}

            # Copy template files
            if [ -d "data.tmpl" ] && [[ ! -d "data" ]]; then
                cp "data.tmpl" "data" -r
            fi
            if [ -f ".env.tmpl" ] && [[ ! -f ".env" ]]; then
                cp ".env.tmpl" ".env"
            fi

            docker compose up -d --remove-orphans
            cd ..
        else
            echo "ERROR: \"${STACK}/docker-compose.yml\" not found"
        fi
    else
        #All
        for d in */ ; do
            if [ -f "${d}docker-compose.yml" ]; then
                if [[ ! " ${StackIgnore[*]} " =~ " ${d} " ]]; then
                    echo -n "[${d}]: ";
                    cd ${d}

                    # Copy template files
                    if [ -d "data.tmpl" ] && [[ ! -d "data" ]]; then
                        cp "data.tmpl" "data" -r
                    fi
                    if [ -f ".env.tmpl" ] && [[ ! -f ".env" ]]; then
                        cp ".env.tmpl" ".env"
                    fi

                    docker compose up -d --remove-orphans --build
                    cd ..
                fi
            fi
        done
    fi
}

StopStack()
{
    if [[ ! -z "$STACK" ]]; then
        if [ -f "${STACK}/docker-compose.yml" ]; then
            echo -n "[${STACK}]: ";
            cd ${STACK}
            docker compose down --remove-orphans
            cd ..
        else
            echo "ERROR: \"${STACK}/docker-compose.yml\" not found"
        fi
    else
        #All
        for d in */ ; do
            if [ -f "${d}docker-compose.yml" ]; then
                if [[ ! " ${StackIgnore[*]} " =~ " ${d} " ]]; then
                    echo -n "[${d}]: ";
                    cd ${d}
                        docker compose down --remove-orphans
                    cd ..
                fi
            fi
        done
    fi
}

CreateStack()
{
    if [ -d "$STACKNAME" ]; then
        echo "ERROR: Stack name already exists"
    else
        mkdir $STACKNAME
        mkdir $STACKNAME/data
        if [ -f "docker-compose.tmpl.yml" ]; then
            cp docker-compose.tmpl.yml $STACKNAME/docker-compose.yml
        else
            touch $STACKNAME/docker-compose.yml
        fi
        cp global.env $STACKNAME/.env
        echo -e "/.env\n/data\n/data/*" >> $STACKNAME/.gitignore
        echo -e "# $STACKNAME" >> $STACKNAME/README.md
    fi
}



while getopts "hlS:rsc:" opt
do
    case "$opt" in
        h ) helpFunction ;;
        l ) List ;;
        S ) STACK="$OPTARG" ;;
        r ) RunStack ;;
        s ) StopStack ;;
        c ) STACKNAME="$OPTARG" && CreateStack ;;
        ? ) helpFunction ;;
    esac
done

if [ $# -eq 0 ]; then
    helpFunction
fi