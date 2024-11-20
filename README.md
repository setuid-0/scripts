# scripts
Scripts Diversos
# Script de Análisis de Servicios Apache Camel

Este script está diseñado para analizar la estructura y configuración de servicios basados en Apache Camel, identificando elementos clave como rutas, componentes, transformaciones y configuraciones declarativas en archivos `blueprint.xml`. 

## Funcionalidad

El script realiza las siguientes tareas:
1. **Identificación de archivos Java**:
   - Cuenta los archivos Java y calcula el promedio de líneas de código manual por archivo.
   - Identifica transformaciones, procesadores y excepciones definidos en código Java.

2. **Detección de rutas Camel**:
   - Busca rutas definidas mediante `from()` y `to()` en el código fuente.

3. **Análisis de componentes externos**:
   - Detecta interacciones con SOAP, REST, colas JMS, y SQL (incluidos procedimientos almacenados).

4. **Procesamiento de archivos `blueprint.xml`**:
   - Busca de forma recursiva configuraciones en `blueprint.xml` para detectar:
     - Beans declarados (`<bean>`).
     - Rutas (`<route>`).
     - Transformaciones como `marshal` y `unmarshal`.

5. **Cálculo de ponderación**:
   - Asigna valores ponderados a cada elemento encontrado y calcula una suma total que puede ser utilizada como métrica de evaluación.

## Requisitos

- **Sistema operativo**: Cualquier sistema compatible con Bash.
- **Dependencias**:
  - Bash versión 4.0 o superior.
  - Herramienta `bc` instalada para cálculos aritméticos.
    - sudo dnf install -y bc     (RHEL/FEDORA)
    - sudo apt-get install -y bc (DEBIAN/UBUNTU)

## Uso

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/setuid-0/scripts/
   cd scripts/
