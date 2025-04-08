#!/bin/bash

BUILD_PATH="bin/"
BINARY_PATH="WEB-INF/classes/"
LIBRARY_PATH="lib/"
TOMCAT_PATH="C:\apache-tomcat-10.1.7/"
WEBAPPAS_PATH_LOCAL="src/webapps/"
WEBAPPAS_PATH_SERVER="webapps/"
WAR_NAME="webDym"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "$GREEN...compilation du code java$NC"

rm -rf "$BUILD_PATH"*

find . -name "*.java" > source.txt

if javac -d  "$BUILD_PATH$BINARY_PATH" -cp "$LIBRARY_PATH*" @source.txt; then
    echo -e "${GREEN}Compilation reussie${NC}"
else
    echo -e "${RED}Compilation Failed${NC}"
    exit 1;
fi

rm source.txt

echo -e "${GREEN}...Copie du contenu du dossier WEB_APPS dans build${NC}"

if cp -R "$WEBAPPAS_PATH_LOCAL"* "$BUILD_PATH"; then
    echo -e "${GREEN}Copie Reussie${NC}"
else
    echo -e "${RED}Erreur de Copie${NC}"
    exit 1;
fi

echo -e "${GREEN}...Creatin du fichier War${NC}"

if jar -cvf "$WAR_NAME.war" -C "$BUILD_PATH" . ; then
    echo -e "${GREEN}Copie Reussie${NC}"
else
    echo -e "${RED}Erreur de Copie${NC}"
    exit 1;
fi

echo -e "${GREEN}...Deployement dans le serveur Tomcat${NC}"

if mv "$WAR_NAME.war" "$TOMCAT_PATH$WEBAPPAS_PATH_SERVER" ; then
    echo -e "${GREEN}Deployement Reussie${NC}"
else
    echo -e "${RED}Deployement Failed${NC}"
    exit 1;
fi

echo -e "${GREEN}=== Déploiement terminé avec succès ===${NC}"