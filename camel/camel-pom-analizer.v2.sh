#!/bin/bash

# Directorio base
BASE_DIR="$1"

# Validar que se proporcione la ruta base
if [ -z "$BASE_DIR" ]; then
  echo "Uso: $0 <ruta_base_del_proyecto>"
  exit 1
fi

# Verificar si la ruta base existe
if [ ! -d "$BASE_DIR" ]; then
  echo "Error: La ruta base '$BASE_DIR' no existe."
  exit 1
fi

# Función para validar si un archivo POM es válido
is_valid_pom() {
  local POM_FILE="$1"

  # Verificar si contiene <project> como raíz
  if ! grep -q "<project" "$POM_FILE"; then
    return 1
  fi

  # Verificar elementos requeridos
  if ! grep -q "<artifactId>" "$POM_FILE"; then
    return 1
  fi
  if ! grep -q "<version>" "$POM_FILE"; then
    return 1
  fi

  # Pasó todas las verificaciones básicas
  return 0
}

# Función para analizar un archivo POM
analyze_pom() {
  local POM_FILE=$1
  local ARTIFACT_ID=$(grep -m 1 "<artifactId>" "$POM_FILE" | sed -e 's/.*<artifactId>//g' -e 's/<\/artifactId>.*//g' -e 's/^[ \t]*//g')
  local VERSION=$(grep -m 1 "<version>" "$POM_FILE" | sed -e 's/.*<version>//g' -e 's/<\/version>.*//g' -e 's/^[ \t]*//g')
  local CAMEL_VERSION=$(grep -m 1 "<camel.version>" "$POM_FILE" | sed -e 's/.*<camel.version>//g' -e 's/<\/camel.version>.*//g' -e 's/^[ \t]*//g')
  local JAVA_VERSION=$(grep -m 1 "<maven.compiler.source>" "$POM_FILE" | sed -e 's/.*<maven.compiler.source>//g' -e 's/<\/maven.compiler.source>.*//g' -e 's/^[ \t]*//g')

  echo "$ARTIFACT_ID,$VERSION,${CAMEL_VERSION:-No especificado},${JAVA_VERSION:-No especificado},$POM_FILE"
}

# Declarar diccionario para almacenar la mejor versión de cada servicio
declare -A POM_INFO

# Buscar y validar archivos pom.xml
echo -e "\nValidando archivos pom.xml:"
POM_FILES=$(find "$BASE_DIR" -name "pom.xml" | grep -v "/META-INF/maven/")

for POM_FILE in $POM_FILES; do
  if is_valid_pom "$POM_FILE"; then
    echo "Archivo válido: $POM_FILE"

    # Analizar archivo POM
    INFO=$(analyze_pom "$POM_FILE")
    ARTIFACT_ID=$(echo "$INFO" | cut -d ',' -f 1)
    VERSION=$(echo "$INFO" | cut -d ',' -f 2)

    # Si el ARTIFACT_ID ya existe, comparar versiones
    if [[ -v POM_INFO["$ARTIFACT_ID"] ]]; then
      EXISTING_INFO=${POM_INFO["$ARTIFACT_ID"]}
      EXISTING_VERSION=$(echo "$EXISTING_INFO" | cut -d ',' -f 2)

      # Comparar versiones
      if [[ "$VERSION" > "$EXISTING_VERSION" ]]; then
        POM_INFO["$ARTIFACT_ID"]="$INFO"
      fi
    else
      POM_INFO["$ARTIFACT_ID"]="$INFO"
    fi
  else
    echo "Archivo no válido: $POM_FILE"
  fi
done

# Reportar resultados
echo -e "\nAnálisis de servicios detectados (Mayor versión de cada servicio):"
for ARTIFACT_ID in "${!POM_INFO[@]}"; do
  INFO=${POM_INFO["$ARTIFACT_ID"]}
  VERSION=$(echo "$INFO" | cut -d ',' -f 2)
  CAMEL_VERSION=$(echo "$INFO" | cut -d ',' -f 3)
  JAVA_VERSION=$(echo "$INFO" | cut -d ',' -f 4)
  FILE=$(echo "$INFO" | cut -d ',' -f 5)

  echo "--------------------------------------------"
  echo "Servicio: $ARTIFACT_ID"
  echo "Versión: $VERSION"
  echo "Versión de Camel: ${CAMEL_VERSION}"
  echo "Versión de Java: ${JAVA_VERSION}"
  echo "Archivo: $FILE"
done

echo -e "\nResumen del análisis completado."

