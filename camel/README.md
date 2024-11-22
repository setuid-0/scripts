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

2. **Cambiar permisos**:
   ```bash
   chmod +x camel-fuse-analizer.sh

3. **Ejecutar camel-fuse-analizer.sh**:
   El script utiliza una ruta absoluta o debe estar en la misma ruta del código fuente.
   ```bash
   ./camel-fuse-analizer.sh <ruta_fuentes_aplicativo>

### Tabla de Elementos y Ponderaciones

La siguiente tabla detalla los elementos analizados por el script junto con sus ponderaciones. Cada ponderación representa una estimación del tiempo necesario en **horas** para implementar ese componente específico. Por ejemplo, una ponderación de **0,55** corresponde a **33 minutos**, lo que permite utilizar el resultado del script como una referencia del tiempo necesario para desarrollar el aplicativo, sin considerar etapas iniciales como el levantamiento y maduración de requerimientos.

| **Elemento**           | **Ponderación** | **Descripción y Justificación**                                                                                   |
|-------------------------|-----------------|-------------------------------------------------------------------------------------------------------------------|
| **JAVA FILES**          | 0,55            | Tiempo estimado para analizar e implementar la estructura básica del proyecto en términos de archivos Java.       |
| **RATIO-SRC**           | 0,01            | Representa el esfuerzo para asegurar la calidad del código generado manualmente y su proporción frente al total.  |
| **Routes**              | 1               | Implementación de rutas en Apache Camel, incluyendo definiciones básicas de `from()` y `to()`.                   |
| **SOAP**                | 0,5             | Configuración de integraciones con servicios SOAP mediante Apache Camel.                                          |
| **REST**                | 0,5             | Configuración de servicios RESTful utilizando componentes Camel REST.                                             |
| **QUEUE**               | 0,5             | Configuración de colas JMS o ActiveMQ como puntos de entrada/salida en las rutas.                                 |
| **SQL**                 | 0,5             | Definición de consultas SQL simples en rutas Camel.                                                              |
| **SQL-STORED**          | 0,5             | Configuración e integración de procedimientos almacenados (stored procedures) en rutas Camel.                     |
| **SetHeader**           | 0,2             | Configuración de encabezados (`setHeader`) en rutas para modificar metadatos de mensajes.                         |
| **SetBody**             | 0,2             | Transformaciones simples del cuerpo del mensaje (`setBody`).                                                     |
| **convertBodyTo**       | 0,2             | Conversión del tipo de datos del cuerpo del mensaje en rutas Camel.                                               |
| **setProperty**         | 0,2             | Definición de propiedades en rutas Camel para almacenar información contextual.                                   |
| **bean (Java)**         | 0,4             | Implementación de beans personalizados para procesamientos específicos en rutas Camel.                           |
| **process**             | 0,2             | Definición e integración de procesadores (`Processor`) personalizados en código Java.                             |
| **unmarshal (Java)**    | 0,2             | Deserialización de mensajes en formatos específicos (e.g., JSON, XML) en código Java.                             |
| **marshal (Java)**      | 0,2             | Serialización de mensajes en formatos específicos en rutas Camel.                                                |
| **Excepciones**         | 0,2             | Configuración de manejadores de excepciones (`onException`) en Apache Camel.                                      |
| **Blueprint Beans**     | 0,4             | Definición de beans en archivos `blueprint.xml` para configurar dependencias e integraciones.                     |
| **Blueprint Marshal**   | 0,2             | Configuración de serializaciones (`marshal`) en archivos `blueprint.xml`.                                         |
| **Blueprint Unmarshal** | 0,2             | Configuración de deserializaciones (`unmarshal`) en archivos `blueprint.xml`.                                     |

### Consideraciones

1. **Estimaciones orientativas:**
   - Las ponderaciones están diseñadas como una aproximación basada en proyectos estándar.
   - Es posible ajustar las ponderaciones según la complejidad del proyecto o el entorno de trabajo.

2. **Tiempo total:**
   - El tiempo estimado no incluye etapas iniciales como levantamiento de requerimientos o reuniones de definición.

3. **Componentes faltantes:**
   - Si el proyecto incluye integraciones o configuraciones no estándar (e.g., YAML DSL, Spring Boot), se recomienda ajustar el análisis y sus ponderaciones.

4. **Compatibilidad:**
   - Aunque el script es compatible con versiones de Apache Camel 2.x y 3.x, este script no es referencia para versiones Camel 4.x.

Esta tabla y las explicaciones permitirán a los usuarios del script interpretar correctamente los resultados y utilizarlos como referencia para estimar el tiempo necesario para implementar un proyecto.
