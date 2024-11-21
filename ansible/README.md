# Estimación de Tiempo y Complejidad para Proyectos Ansible

Este script en Bash tiene el objetivo de estimar el tiempo de desarrollo y validación de un proyecto Ansible, asignando un nivel de complejidad basado en criterios predefinidos. Como apoyo planificar de manera efectiva tus proyectos, considerando diferentes componentes y tareas involucradas en la automatización con Ansible.

## Tabla de Contenidos

- [Descripción General](#descripción-general)
- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Ejecución del Script](#ejecución-del-script)
- [Uso del Script](#uso-del-script)
- [Entendimiento y Criterios Utilizados](#entendimiento-y-criterios-utilizados)
  - [Categorías y Elementos](#categorías-y-elementos)
  - [Tabla de Complejidad](#tabla-de-complejidad)
    - [Estimar los Tiempos](#estimar-los-tiempos)
      - [1. Complejidad Alta plus](#1-complejidad-alta-plus)
      - [2. Complejidad Media plus](#2-complejidad-media-plus)
      - [3. Complejidad Baja plus](#3-complejidad-baja-plus)
      - [4. Complejidad Alta](#4-complejidad-alta)
      - [5. Complejidad Media](#5-complejidad-media)
      - [6. Complejidad Baja](#6-complejidad-baja)
- [Interpretación de Resultados](#interpretación-de-resultados)
- [Elementos de Ansible con Métodos de Validación](#elementos-de-ansible-con-métodos-de-validación)
- [Licencia](#licencia)


## Descripción General

El script:

- **Estima el tiempo de desarrollo y validación** para un proyecto Ansible basado en tus respuestas.
- **Asigna un nivel de complejidad** al proyecto según criterios definidos.
- **Ayuda en la planificación** y gestión del tiempo en proyectos de automatización.

## Requisitos Previos

- **Sistema Operativo:** Unix/Linux.
- **Intérprete de Bash:** Versiones compatibles con Bash scripting.
- **Git:** Para clonar el repositorio (opcional).

## Instalación

1. **Clonar el repositorio:**

   ```bash
   git clone git@github.com:setuid-0/scripts.git
   ```

2. **Navegar al directorio del script:**

   ```bash
   cd scripts/ansible
   ```

3. **Dar permisos de ejecución al script:**

   ```bash
   chmod +x estimacion_ansible_complejidad.sh
   ```

## Ejecución del Script

Para ejecutar el script, utiliza el siguiente comando:

```bash
./estimacion_ansible_complejidad.sh
```

## Uso del Script

Al ejecutar el script:

1. **Introducción:**

   El script muestra una estructura de proyecto Ansible de referencia para contextualizar.

2. **Preguntas Interactivas:**

   El script te hará una serie de preguntas. Algunas pautas:

   - **Respuestas Numéricas:** Ingresa números enteros según corresponda.
   - **Sugerencias:** Lee las sugerencias proporcionadas para orientarte en tus respuestas.
   - **Opciones Sí/No:** Para preguntas de tipo "Sí/No", responde con `1` para Sí y `0` para No.

3. **Categorías de Preguntas:**

   - **Configuración del Proyecto:** Estructura personalizada, archivos, directorios.
   - **Configuraciones Específicas:** `ansible.cfg`, inventario, variables globales.
   - **Componentes del Proyecto:** Playbooks, roles, tareas, plantillas, handlers.
   - **Integraciones y Optimización:** Módulos personalizados, colecciones, configuración SSH avanzada, caché de hechos.
   - **Herramientas Adicionales:** Implementación en AWX/Ansible Automation Platform.
   - **Prácticas y Políticas:** Uso de etiquetas, registro y tiempos de ejecución.

4. **Resultados:**

   Al finalizar, el script mostrará:

   - **Tiempo de Desarrollo (minutos).**
   - **Tiempo de Validación (minutos).**
   - **Tiempo Total (minutos y horas).**
   - **Nivel de Complejidad** asignado al proyecto.

## Entendimiento y Criterios Utilizados

El script se basa en tablas y criterios predefinidos para estimar tiempos y asignar niveles de complejidad.

### Categorías y Elementos

Se consideran las siguientes **categorías**:

- **Sistemas:**
  - Configuración inicial, `ansible.cfg`, inventario, configuración SSH avanzada, caché de hechos, implementación en AWX.
- **Reglas de Negocio/Políticas:**
  - Variables globales, variables en roles, etiquetas, registro y tiempos de ejecución.
- **Integraciones:**
  - Módulos o plugins personalizados, colecciones.
- **Actividades:**
  - Playbooks, roles, tareas, plantillas, handlers, archivos estáticos, pruebas y documentación.

### Tabla de Complejidad

| **Complejidad Playbook** | **Sistemas** | **Reglas de negocio/ Políticas** | **Integraciones** | **Actividades** | **Tiempo (minutos)** |
|--------------------------|--------------|----------------------------------|-------------------|-----------------|----------------------|
| Alta plus                | 4            | 7                                | 3                 | Hasta 8         | **2159**             |
| Media plus               | 2            | 5                                | 2                 | Hasta 5         | **1345**             |
| Baja plus                | 1            | 2                                | 1                 | Hasta 3         | **795**              |
| Alta                     | 4            | 7                                | 0                 | Hasta 8         | **1934**             |
| Media                    | 2            | 4                                | 0                 | Hasta 5         | **1020**             |
| Baja                     | 1            | 2                                | 0                 | Hasta 3         | **750**              |


### Estimar los Tiempos

A continuación, detallo el cálculo del tiempo total para cada nivel de complejidad, considerando el **mayor tiempo posible** basado en los elementos y tiempos estimados previamente.

#### **1. Complejidad Alta plus**

- **Sistemas (4 elementos):**
  - Implementación en AWX: **330 min**
  - `ansible.cfg`: **60 min**
  - Inventario: **50 min**
  - Configuración Inicial del Proyecto: **45 min**
  - **Subtotal Sistemas:** 330 + 60 + 50 + 45 = **485 min**

- **Reglas de negocio/Políticas (7 elementos):**
  - Variables Globales: **60 min**
  - Variables en Roles (4 roles): 15 min x 4 = **60 min**
  - Etiquetas: **15 min**
  - Registro y Tiempos de Ejecución: **25 min**
  - **Subtotal Reglas:** 60 + 60 + 15 + 25 = **160 min**

- **Integraciones (3 elementos):**
  - Módulos o Plugins Personalizados (2 módulos): 90 min x 2 = **180 min**
  - Colecciones: **45 min**
  - **Subtotal Integraciones:** 180 + 45 = **225 min**

- **Actividades (hasta 8):**
  - Playbooks (1): 75 min x 1 = **75 min**
  - Roles (4): 100 min x 4 = **400 min**
  - Tareas (10 por rol): 8 min x 40 = **320 min**
  - Plantillas (2 por rol): 30 min x 8 = **240 min**
  - Manejadores (2 por rol): 15 min x 8 = **120 min**
  - Archivos Estáticos (2): 7 min x 2 = **14 min**
  - Pruebas y Validación General: **90 min**
  - Documentación Interna: **30 min**
  - **Subtotal Actividades:** 75 + 400 + 320 + 240 + 120 + 14 + 90 + 30 = **1289 min**

- **Tiempo Total Alta plus:** 485 + 160 + 225 + 1289 = **2159 min**

#### **2. Complejidad Media plus**

- **Sistemas (2 elementos):**
  - Implementación en AWX: **330 min**
  - `ansible.cfg`: **60 min**
  - **Subtotal Sistemas:** 330 + 60 = **390 min**

- **Reglas de negocio/Políticas (5 elementos):**
  - Variables Globales: **60 min**
  - Variables en Roles (2 roles): 15 min x 2 = **30 min**
  - Etiquetas: **15 min**
  - Registro y Tiempos de Ejecución: **25 min**
  - **Subtotal Reglas:** 60 + 30 + 15 + 25 = **130 min**

- **Integraciones (2 elementos):**
  - Módulos o Plugins Personalizados (2 módulos): 90 min x 2 = **180 min**
  - **Subtotal Integraciones:** **180 min**

- **Actividades (hasta 5):**
  - Playbooks (1): 75 min x 1 = **75 min**
  - Roles (2): 100 min x 2 = **200 min**
  - Tareas (10 por rol): 8 min x 20 = **160 min**
  - Plantillas (2 por rol): 30 min x 4 = **120 min**
  - Pruebas y Validación General: **90 min**
  - **Subtotal Actividades:** 75 + 200 + 160 + 120 + 90 = **645 min**

- **Tiempo Total Media plus:** 390 + 130 + 180 + 645 = **1345 min**

#### **3. Complejidad Baja plus**

- **Sistemas (1 elemento):**
  - Implementación en AWX: **330 min**
  - **Subtotal Sistemas:** **330 min**

- **Reglas de negocio/Políticas (2 elementos):**
  - Variables Globales: **60 min**
  - Variables en Roles (1 rol): 15 min x 1 = **15 min**
  - **Subtotal Reglas:** 60 + 15 = **75 min**

- **Integraciones (1 elemento):**
  - Colecciones: **45 min**
  - **Subtotal Integraciones:** **45 min**

- **Actividades (hasta 3):**
  - Playbooks (1): 75 min x 1 = **75 min**
  - Roles (1): 100 min x 1 = **100 min**
  - Tareas (10 por rol): 8 min x 10 = **80 min**
  - Pruebas y Validación General: **90 min**
  - **Subtotal Actividades:** 75 + 100 + 80 + 90 = **345 min**

- **Tiempo Total Baja plus:** 330 + 75 + 45 + 345 = **795 min**

#### **4. Complejidad Alta**

- **Sistemas (4 elementos):**
  - Igual que en Alta plus: **485 min**

- **Reglas de negocio/Políticas (7 elementos):**
  - Igual que en Alta plus: **160 min**

- **Integraciones (0 elementos):**
  - **Subtotal Integraciones:** **0 min**

- **Actividades (hasta 8):**
  - Igual que en Alta plus: **1289 min**

- **Tiempo Total Alta:** 485 + 160 + 0 + 1289 = **1934 min**

#### **5. Complejidad Media**

- **Sistemas (2 elementos):**
  - Igual que en Media plus: **390 min**

- **Reglas de negocio/Políticas (4 elementos):**
  - Variables Globales: **60 min**
  - Variables en Roles (2 roles): **30 min**
  - Etiquetas: **15 min**
  - **Subtotal Reglas:** 60 + 30 + 15 = **105 min**

- **Integraciones (0 elementos):**
  - **Subtotal Integraciones:** **0 min**

- **Actividades (hasta 5):**
  - Igual que en Media plus: **525 min**

- **Tiempo Total Media:** 390 + 105 + 0 + 525 = **1020 min**

#### **6. Complejidad Baja**

- **Sistemas (1 elemento):**
  - Igual que en Baja plus: **330 min**

- **Reglas de negocio/Políticas (2 elementos):**
  - Igual que en Baja plus: **75 min**

- **Integraciones (0 elementos):**
  - **Subtotal Integraciones:** **0 min**

- **Actividades (hasta 3):**
  - Igual que en Baja plus: **345 min**

- **Tiempo Total Baja:** 330 + 75 + 0 + 345 = **750 min**

**Notas:**

- **Integraciones:** La presencia de integraciones (módulos personalizados, colecciones) distingue entre niveles "Plus" y los demás.
- **Actividades:** Aunque no se cuentan individualmente para determinar el nivel, se consideran en el tiempo total.

## Interpretación de Resultados

- **Tiempo Estimado:**

  - **Desarrollo:** Tiempo para implementar los componentes.
  - **Validación:** Tiempo para probar y asegurar el correcto funcionamiento.

- **Nivel de Complejidad:**

  - **Alta Plus:** Proyectos con mayor cantidad de sistemas, reglas y integraciones.
  - **Media Plus / Baja Plus:** Niveles intermedios con integraciones.
  - **Alta / Media / Baja:** Proyectos sin integraciones, variando en cantidad de sistemas y reglas.

**Utilidad:**

- **Planificación:** Ayuda a estimar esfuerzos y plazos.
- **Recursos:** Permite asignar recursos humanos y técnicos adecuados.
- **Comunicación:** Facilita la comunicación con equipos y stakeholders sobre el alcance del proyecto.

## Elementos de Ansible con Métodos de Validación
-

| **Categoría**                     | **Elemento**                                     | **Descripción**                                                                                   | **Tiempo de Desarrollo (minutos)** | **Tiempo de Validación (minutos)** | **Tiempo Total (minutos)** | **Cómo se Realiza la Validación (Comandos)**                                                                                                          |
|-----------------------------------|--------------------------------------------------|---------------------------------------------------------------------------------------------------|------------------------------------|-------------------------------------|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Sistemas**                      | **Configuración Inicial del Proyecto**           | Creación de la estructura de directorios y archivos básicos del proyecto Ansible.                 | 30                                 | 15                                  | 45                         | **Comando:** `tree nombre_del_proyecto/` para verificar la estructura de directorios.                                                                 |
| **Sistemas**                      | **ansible.cfg**                                  | Configuración principal de Ansible, incluyendo opciones avanzadas y optimizaciones.               | 40                                 | 20                                  | 60                         | **Comando:** `ansible-config dump --only-changed` para verificar las configuraciones aplicadas.                                                       |
| **Sistemas**                      | **Inventario**                                   | Definición de hosts y grupos en el archivo de inventario (`hosts`), incluyendo variables si aplica. | 30                                 | 20                                  | 50                         | **Comando:** `ansible all -m ping` o `ansible -i inventario/hosts all -m ping` para verificar conectividad con los hosts.                             |
| **Sistemas**                      | **Configuración de SSH Avanzada**                | Optimización de conexiones SSH en `ansible.cfg` y pruebas de conectividad.                        | 25                                 | 15                                  | 40                         | **Comando:** `ansible all -m ping -o -vvvv` para ver detalles de la conexión SSH y verificar optimizaciones.                                          |
| **Sistemas**                      | **Recolección y Caché de Hechos (Facts)**        | Configuración de recolección y caché de hechos para optimizar el rendimiento.                     | 20                                 | 10                                  | 30                         | **Comando:** `ansible all -m setup` para recolectar hechos; verificar caché en la ruta configurada.                                                  |
| **Sistemas**                      | **Implementación en AWX/Ansible Automation Platform** | Configuración de proyectos, inventarios, credenciales, plantillas de trabajo y ajustes en AWX/Ansible Automation Platform. | **200 + tiempos adicionales**      | **130 + tiempos adicionales**        | **330 + tiempos adicionales**  | **Validación:** Ejecutar trabajos desde la interfaz de AWX; revisar resultados y logs; ajustar configuraciones según sea necesario.                  |
| **Reglas de negocio/Políticas**   | **Variables Globales**                           | Gestión de variables en `group_vars` y `host_vars`, incluyendo variables encriptadas con Ansible Vault. | 40                                 | 20                                  | 60                         | **Comando:** `ansible all -m debug -a "var=variable"` para verificar valores; desencriptar con `ansible-vault view`.                                  |
| **Reglas de negocio/Políticas**   | **Variables en Roles**                           | Definición de variables específicas dentro de roles.                                              | 10 por rol                         | 5 por rol                           | 15 por rol                 | **Comando:** `ansible all -m debug -a "var=variable"` para imprimir el valor de la variable.                                                         |
| **Reglas de negocio/Políticas**   | **Etiquetas (Tags)**                             | Implementación de etiquetas para facilitar la ejecución de tareas específicas.                    | 10                                 | 5                                   | 15                         | **Comando:** `ansible-playbook playbook.yml --tags "nombre_de_etiqueta"` para ejecutar tareas con etiquetas específicas.                              |
| **Reglas de negocio/Políticas**   | **Registro y Tiempos de Ejecución**              | Configuración de logs y visualización de tiempos en las tareas.                                   | 15                                 | 10                                  | 25                         | **Comando:** Revisar logs generados; usar `ansible-playbook playbook.yml --callback profile_tasks` para ver tiempos.                                  |
| **Integraciones**                 | **Módulos o Plugins Personalizados**             | Desarrollo de módulos o plugins personalizados (si es necesario).                                 | 60 por módulo                      | 30 por módulo                       | 90 por módulo              | **Comando:** `ansible-doc -t módulo nombre_del_módulo` para verificar documentación; pruebas con `ansible -m nombre_del_módulo`.                      |
| **Integraciones**                 | **Colecciones**                                  | Gestión e integración de colecciones de Ansible.                                                  | 30                                 | 15                                  | 45                         | **Comando:** `ansible-galaxy collection list` para verificar instalación; usar módulos en playbooks de prueba.                                        |
| **Actividades**                   | **Playbooks**                                    | Creación de playbooks que orquestan la ejecución de roles y tareas.                               | 45 por playbook                    | 30 por playbook                     | 75 por playbook            | **Comandos:** `ansible-playbook playbook.yml --syntax-check`; `ansible-playbook playbook.yml --check` para simulación.                                |
| **Actividades**                   | **Roles**                                        | Desarrollo de roles, incluyendo tareas, plantillas, archivos y variables específicas.            | 60 por rol                         | 40 por rol                          | 100 por rol                | **Comando:** `ansible-playbook playbook.yml --tags "nombre_del_rol"` para probar roles específicos.                                                   |
| **Actividades**                   | **Tareas (Tasks)**                               | Definición de tareas dentro de roles o playbooks.                                                | 5 por tarea                        | 3 por tarea                         | 8 por tarea                | **Comando:** `ansible-playbook playbook.yml --step` para ejecutar tareas interactivamente.                                                            |
| **Actividades**                   | **Plantillas (Templates)**                       | Creación de archivos de configuración dinámicos utilizando Jinja2.                                | 20 por plantilla                   | 10 por plantilla                    | 30 por plantilla           | **Validación:** Desplegar la plantilla en un host de prueba y verificar la sintaxis y contenido. No hay comandos específicos para validar aislados.   |
| **Actividades**                   | **Manejadores (Handlers)**                       | Configuración de acciones que responden a notificaciones de tareas.                               | 10 por handler                     | 5 por handler                       | 15 por handler             | **Comando:** Ejecutar tareas que disparen el handler y verificar su ejecución; usar `ansible-playbook playbook.yml --tags "nombre_del_handler"`.      |
| **Actividades**                   | **Archivos Estáticos**                           | Archivos que se copian directamente a los hosts gestionados.                                      | 5 por archivo                      | 2 por archivo                       | 7 por archivo              | **Comando:** `ansible all -m file -a "path=/ruta/al/archivo state=file"` para verificar existencia y permisos.                                        |
| **Actividades**                   | **Pruebas y Validación General**                 | Ejecución de playbooks en modo `--check`, pruebas integrales y depuración de errores.             | -                                  | 90                                  | 90                         | **Comando:** `ansible-playbook playbook.yml --check`; revisar resultados y corregir errores.                                                          |
| **Actividades**                   | **Documentación Interna**                        | Comentarios en código y documentación dentro de los archivos.                                     | 30                                 | **No requiere validación**          | 30                         | **Nota:** La documentación interna se valida mediante revisión manual; no requiere comandos específicos.                                              |

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

**Nota:** Este script es una herramienta de estimación y los resultados deben ser ajustados según las especificidades y complejidades únicas de cada proyecto.
