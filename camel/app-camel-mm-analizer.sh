#!/bin/bash

# Directorio base
BASE_DIR="$1"

# Validar que se proporcione la ruta base
if [ -z "$BASE_DIR" ]; then
  echo "Uso: $0 <ruta_base_del_proyecto>"
  exit 1
fi

# Función para analizar cada archivo pom.xml
analyze_pom() {
  local POM_FILE=$1
  local SERVICE_NAME=$(grep -m 1 "<artifactId>" "$POM_FILE" | sed -e 's/<artifactId>//g' -e 's/<\/artifactId>//g' -e 's/^[ \t]*//g')
  local CAMEL_VERSION=$(grep -m 1 "<camel.version>" "$POM_FILE" | sed -e 's/<camel.version>//g' -e 's/<\/camel.version>//g' -e 's/^[ \t]*//g')
  local JAVA_VERSION=$(grep -m 1 "<maven.compiler.source>" "$POM_FILE" | sed -e 's/<maven.compiler.source>//g' -e 's/<\/maven.compiler.source>//g' -e 's/^[ \t]*//g')
  
  echo -e "\e[1;38m\nServicio:\e[1;37m $SERVICE_NAME\e[0m"
  echo -e "Versión de Camel: ${CAMEL_VERSION:-No especificado}"
  echo -e "Versión de Java: ${JAVA_VERSION:-No especificado}"
  
  echo -e "Dependencias:"
  grep "<dependency>" -A 2 "$POM_FILE" | grep -E "<artifactId>|<version>" | sed -e 's/<\/\?artifactId>//g' -e 's/<\/\?version>//g' -e 's/^[ \t]*//g' | paste -d " " - -
}

# Función para buscar módulos en un pom.xml
find_modules() {
  local PARENT_POM=$1
  grep "<module>" "$PARENT_POM" | sed -e 's/<module>//g' -e 's/<\/module>//g' -e 's/^[ \t]*//g' | while read -r module; do
    echo "$(dirname "$PARENT_POM")/$module/pom.xml"
  done
}

# Buscar y analizar todos los archivos pom.xml
echo -e "\nAnálisis de servicios detectados en pom.xml:"
POM_FILES=$(find "$BASE_DIR" -name "pom.xml")
for POM_FILE in $POM_FILES; do
  echo "--------------------------------------------"
  echo "Archivo: $POM_FILE"
  
  # Analizar el archivo pom.xml actual
  analyze_pom "$POM_FILE"
  
  # Buscar módulos si el archivo es un parent POM
  if grep -q "<modules>" "$POM_FILE"; then
    echo -e "\nMódulos detectados en $POM_FILE:"
    MODULES=$(find_modules "$POM_FILE")
    for MODULE_POM in $MODULES; do
      if [ -f "$MODULE_POM" ]; then
        echo "  - $MODULE_POM"
        analyze_pom "$MODULE_POM"
      else
        echo "  - Módulo no encontrado: $MODULE_POM"
      fi
    done
  fi
done

echo -e "\nResumen del análisis completado."

