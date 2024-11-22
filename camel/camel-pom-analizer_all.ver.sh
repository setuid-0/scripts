#!/bin/bash

# Función para obtener información del POM
analyze_pom() {
  local POM_FILE=$1
  local ARTIFACT_ID=$(grep -m 1 "<artifactId>" "$POM_FILE" | sed -e 's/<artifactId>//g' -e 's/<\/artifactId>//g' -e 's/^[ \t]*//g')
  local VERSION=$(grep -m 1 "<version>" "$POM_FILE" | sed -e 's/<version>//g' -e 's/<\/version>//g' -e 's/^[ \t]*//g')
  
  echo "$ARTIFACT_ID,$VERSION,$POM_FILE"
}

# Buscar y analizar archivos pom.xml
POM_FILES=$(find $BASE_DIR -iname "pom.xml")
declare -A POM_INFO

for POM_FILE in $POM_FILES; do
  INFO=$(analyze_pom "$POM_FILE")
  ARTIFACT_ID=$(echo "$INFO" | cut -d ',' -f 1)
  VERSION=$(echo "$INFO" | cut -d ',' -f 2)
  FILE=$(echo "$INFO" | cut -d ',' -f 3)

  # Si el ARTIFACT_ID ya existe, comparar versiones
  if [[ -v POM_INFO["$ARTIFACT_ID"] ]]; then
    EXISTING_INFO=${POM_INFO["$ARTIFACT_ID"]}
    EXISTING_VERSION=$(echo "$EXISTING_INFO" | cut -d ',' -f 2)
    EXISTING_FILE=$(echo "$EXISTING_INFO" | cut -d ',' -f 3)

    # Comparar versiones
    if [[ "$VERSION" > "$EXISTING_VERSION" ]]; then
      POM_INFO["$ARTIFACT_ID"]="$ARTIFACT_ID,$VERSION,$FILE"
    fi
  else
    POM_INFO["$ARTIFACT_ID"]="$INFO"
  fi
done

# Reportar resultados
echo -e "\nAnálisis de servicios detectados en pom.xml:"
for ARTIFACT_ID in "${!POM_INFO[@]}"; do
  INFO=${POM_INFO["$ARTIFACT_ID"]}
  VERSION=$(echo "$INFO" | cut -d ',' -f 2)
  FILE=$(echo "$INFO" | cut -d ',' -f 3)

  echo "--------------------------------------------"
  echo "Servicio: $ARTIFACT_ID"
  echo "Versión: $VERSION"
  echo "Archivo: $FILE"
done

