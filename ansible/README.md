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
- [Interpretación de Resultados](#interpretación-de-resultados)
- [Contribuciones](#contribuciones)
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

El nivel de complejidad se determina según la siguiente tabla:

| **Complejidad Playbook** | **Sistemas** | **Reglas de Negocio/Políticas** | **Integraciones** | **Actividades (hasta)** | **Tiempo Máximo (horas)** |
|--------------------------|--------------|----------------------------------|-------------------|-------------------------|---------------------------|
| **Alta Plus**            | 4            | 7                                | 3                 | 8                       | 8                         |
| **Media Plus**           | 2            | 5                                | 2                 | 5                       | 5                         |
| **Baja Plus**            | 1            | 2                                | 1                 | 3                       | 3                         |
| **Alta**                 | 4            | 7                                | 0                 | 8                       | 8                         |
| **Media**                | 2            | 4                                | 0                 | 5                       | 5                         |
| **Baja**                 | 1            | 2                                | 0                 | 3                       | 3                         |

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

## Contribuciones

Si deseas contribuir al script o mejorar la estimación, puedes:

- **Crear un fork** del repositorio.
- **Realizar modificaciones** y mejoras.
- **Enviar un pull request** con tus cambios.

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

**Nota:** Este script es una herramienta de estimación y los resultados deben ser ajustados según las especificidades y complejidades únicas de cada proyecto.
