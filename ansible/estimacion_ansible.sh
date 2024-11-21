#!/bin/bash

# Script para estimar el tiempo de desarrollo de un proyecto Ansible

# Tiempos estimados en minutos
declare -A times=(
    ["project_setup_dev"]=30
    ["project_setup_val"]=15
    ["ansible_cfg_dev"]=40
    ["ansible_cfg_val"]=20
    ["inventory_dev_base"]=10
    ["inventory_val_base"]=5
    ["variables_dev"]=40
    ["variables_val"]=20
    ["playbook_dev"]=45
    ["playbook_val"]=30
    ["role_dev"]=60
    ["role_val"]=40
    ["task_dev"]=5
    ["task_val"]=3
    ["template_dev"]=20
    ["template_val"]=10
    ["vars_role_dev"]=10
    ["vars_role_val"]=5
    ["handler_dev"]=10
    ["handler_val"]=5
    ["static_file_dev"]=5
    ["static_file_val"]=2
    ["module_dev"]=60
    ["module_val"]=30
    ["collection_dev"]=30
    ["collection_val"]=15
    ["ssh_config_dev"]=25
    ["ssh_config_val"]=15
    ["facts_dev"]=20
    ["facts_val"]=10
    ["tags_dev"]=10
    ["tags_val"]=5
    ["logging_dev"]=15
    ["logging_val"]=10
    ["testing_val"]=90
    ["documentation_dev"]=30
    ["awx_dev"]=200
    ["awx_val"]=130
)

# Función para preguntar un valor numérico mayor o igual a cero
function ask_number() {
    local prompt="$1"
    local var_name="$2"
    local suggestion="$3"
    local value

    while true; do
        read -p "$prompt" value
        if [[ "$value" =~ ^[0-9]+$ ]]; then
            eval "$var_name=$value"
            break
        else
            echo "Por favor, ingresa un número entero válido (0 o mayor)."
        fi
    done
}

# Función para imprimir títulos en color
function print_title() {
    local title="$1"
    echo -e "\e[1;31m===== $title =====\e[0m"  # Color azul
}

echo -e "\e[1;32m=========================================================="
echo "Estimación de Tiempo para un Proyecto Ansible"
echo -e "==========================================================\e[0m"
echo

# Mostrar la estructura de un proyecto Ansible de referencia
echo "Estructura de un proyecto Ansible de referencia:"
echo -e "\e[1;39m"
echo "----------------------------------------------------------"
cat <<'EOF'
ansible-project/
├── ansible.cfg            # Archivo de configuración principal de Ansible
├── inventory/
│   └── hosts              # Archivo de inventario que define los hosts y grupos
├── group_vars/
│   ├── all.yml            # Variables globales aplicables a todos los hosts
│   └── vault.yml          # Variables sensibles encriptadas con Ansible Vault
├── playbooks/
│   └── site.yml           # Playbook principal que orquesta la ejecución de roles
├── roles/
│   ├── role1/             # Primer rol
│   │   ├── tasks/         # Tareas del rol
│   │   ├── templates/     # Plantillas Jinja2 del rol
│   │   └── vars/          # Variables específicas del rol
│   └── role2/             # Segundo rol
│       ├── tasks/         # Tareas del rol
│       ├── templates/     # Plantillas Jinja2 del rol
│       └── vars/          # Variables específicas del rol
EOF
echo "----------------------------------------------------------"
echo -e "\e[0m"
echo

echo "Este script te hará algunas preguntas para estimar el tiempo de desarrollo y validación de tu proyecto Ansible basado en los elementos anteriores."
echo

# Configuración inicial del proyecto
print_title "Configuración Inicial del Proyecto"
echo "Este es el tiempo estimado para crear la estructura del proyecto."
echo "Sugerencia: Indica 1 si necesitas crear una estructura de proyecto personalizada, 0 si no."
ask_number "¿Necesitas crear una estructura de proyecto personalizada? (0 = No, 1 = Sí): " custom_project_structure

if [ "$custom_project_structure" -eq 1 ]; then
    ask_number "¿Cuántos directorios o archivos personalizados necesitas crear? [Ejemplo sugerido: 2-5]: " num_custom_files
    project_setup_dev=$(( 20 + (num_custom_files * 5) ))
    project_setup_val=$(( 10 + (num_custom_files * 2) ))
else
    project_setup_dev=${times["project_setup_dev"]}
    project_setup_val=${times["project_setup_val"]}
fi

# ansible.cfg
echo
print_title "Configuración del archivo ansible.cfg"
echo "Incluye la configuración de opciones avanzadas y optimizaciones."
ansible_cfg_dev=${times["ansible_cfg_dev"]}
ansible_cfg_val=${times["ansible_cfg_val"]}

# Inventario
echo
print_title "Inventario"
echo "Incluye la definición de hosts y grupos en el archivo de inventario."
echo "Sugerencia: Indica el número de hosts y grupos que tendrás en tu inventario."
ask_number "¿Cuántos hosts se gestionarán? [Ejemplo sugerido: 5-20]: " num_hosts
ask_number "¿Cuántos grupos de hosts tendrás? [Ejemplo sugerido: 1-5]: " num_groups

inventory_dev=$(( times["inventory_dev_base"] + (num_hosts * 1) + (num_groups * 5) ))
#echo "inventory_val: $inventory_val"
inventory_val=$(( times["inventory_val_base"] + (num_hosts * 0,5) + (num_groups * 2) ))
#echo "inventory_val: $inventory_val"
#echo "inventory_val 5: $(( times["inventory_val_base"] + (num_hosts * 5) + (num_groups * 2) ))"

# Variables globales y variables encriptadas
echo
print_title "Variables Globales y Variables Encriptadas"
echo "Tiempo estimado para configurar variables globales y sensibles."
echo "Sugerencia: Indica 1 si necesitas configurar variables globales o variables encriptadas (Ansible Vault), 0 si no."
ask_number "¿Necesitas configurar variables globales o variables encriptadas? (0 = No, 1 = Sí): " use_global_vars

if [ "$use_global_vars" -eq 1 ]; then
    variables_dev=${times["variables_dev"]}
    variables_val=${times["variables_val"]}
else
    variables_dev=0
    variables_val=0
fi

# Playbooks
echo
print_title "Playbooks"
echo "Los playbooks orquestan la ejecución de roles y tareas."
echo "Sugerencia: En proyectos pequeños, suele haber 1 o 2 playbooks principales."
ask_number "¿Cuántos playbooks principales se necesitan? [Ejemplo sugerido: 1-2]: " num_playbooks

total_playbook_dev=$(( num_playbooks * times["playbook_dev"] ))
total_playbook_val=$(( num_playbooks * times["playbook_val"] ))

# Roles
echo
print_title "Roles"
echo "Los roles son conjuntos de tareas, variables y archivos relacionados."
echo "Sugerencia: Estima un rol por cada componente o servicio que necesites configurar."
ask_number "¿Cuántos roles se implementarán? [Ejemplo sugerido: 2-5]: " num_roles

total_role_dev=$(( num_roles * times["role_dev"] ))
total_role_val=$(( num_roles * times["role_val"] ))

# Tareas
echo
print_title "Tareas (Tasks)"
echo "Las tareas son las acciones individuales que Ansible ejecutará."
echo "Sugerencia: Estima entre 5 y 15 tareas por rol, dependiendo de su complejidad."
ask_number "¿Cuál es el número promedio de tareas por rol? [Ejemplo sugerido: 10]: " avg_tasks_per_role

total_tasks=$(( num_roles * avg_tasks_per_role ))
total_task_dev=$(( total_tasks * times["task_dev"] ))
total_task_val=$(( total_tasks * times["task_val"] ))

# Plantillas
echo
print_title "Plantillas (Templates)"
echo "Las plantillas son archivos que utilizan variables para generar configuraciones dinámicas."
suggested_templates_min=$(( num_roles * 1 ))
suggested_templates_max=$(( num_roles * 3 ))
echo "Sugerencia: Estima 1-3 plantillas por rol. Por ejemplo, con $num_roles roles, podrías tener entre $suggested_templates_min y $suggested_templates_max plantillas."
ask_number "¿Cuántas plantillas (templates) se crearán en total? [Ejemplo sugerido: $suggested_templates_min-$suggested_templates_max]: " num_templates

total_template_dev=$(( num_templates * times["template_dev"] ))
total_template_val=$(( num_templates * times["template_val"] ))

# Variables en roles
echo
print_title "Variables en Roles"
echo "Roles que requieren variables específicas definidas en vars/main.yml o defaults/main.yml."
echo "Sugerencia: La mayoría de los roles personalizados requieren variables específicas."
echo "Ventaja: Utilizar variables en roles aumenta la flexibilidad y reutilización."
ask_number "¿Cuántos roles requerirán variables específicas? [Ejemplo sugerido: $num_roles]: " num_roles_vars

total_vars_role_dev=$(( num_roles_vars * times["vars_role_dev"] ))
total_vars_role_val=$(( num_roles_vars * times["vars_role_val"] ))

# Handlers
echo
print_title "Handlers"
echo "Los handlers realizan acciones en respuesta a notificaciones de tareas (e.g., reiniciar servicios)."
suggested_handlers_min=$(( num_roles * 1 ))
suggested_handlers_max=$(( num_roles * 2 ))
echo "Sugerencia: Estima 1-2 handlers por rol. Por ejemplo, con $num_roles roles, podrías tener entre $suggested_handlers_min y $suggested_handlers_max handlers."
ask_number "¿Cuántos handlers se implementarán en total? [Ejemplo sugerido: $suggested_handlers_min-$suggested_handlers_max]: " num_handlers

total_handler_dev=$(( num_handlers * times["handler_dev"] ))
total_handler_val=$(( num_handlers * times["handler_val"] ))

# Archivos estáticos
echo
print_title "Archivos Estáticos"
echo "Archivos que se copiarán directamente a los hosts gestionados sin modificaciones."
echo "Sugerencia: Incluye certificados, archivos de configuración estáticos, etc."
ask_number "¿Cuántos archivos estáticos se copiarán en total? [Ejemplo sugerido: 1-5]: " num_static_files

total_static_file_dev=$(( num_static_files * times["static_file_dev"] ))
total_static_file_val=$(( num_static_files * times["static_file_val"] ))

# Módulos o plugins personalizados
echo
print_title "Módulos o Plugins Personalizados"
echo "Desarrollo de módulos o plugins en Python para funcionalidades específicas."
echo "Sugerencia: Solo si las funcionalidades no están cubiertas por los módulos existentes."
ask_number "¿Cuántos módulos o plugins personalizados se desarrollarán? [Ejemplo sugerido: 0-2]: " num_modules

total_module_dev=$(( num_modules * times["module_dev"] ))
total_module_val=$(( num_modules * times["module_val"] ))

# Colecciones
echo
print_title "Colecciones de Ansible"
echo "Gestión e integración de colecciones personalizadas o de terceros."
echo "Sugerencia: Indica 1 si usarás colecciones, 0 si no."
ask_number "¿Se gestionarán colecciones de Ansible? (0 = No, 1 = Sí): " use_collections

if [ "$use_collections" -eq 1 ]; then
    collection_dev=${times["collection_dev"]}
    collection_val=${times["collection_val"]}
else
    collection_dev=0
    collection_val=0
fi

# Configuración SSH avanzada
echo
print_title "Configuración SSH Avanzada"
echo "Optimización de conexiones SSH en ansible.cfg y pruebas de conectividad."
echo "Ventaja: Mejora el rendimiento y seguridad de las conexiones SSH."
ask_number "¿Se realizará configuración SSH avanzada? (0 = No, 1 = Sí): " use_ssh_config

if [ "$use_ssh_config" -eq 1 ]; then
    ssh_config_dev=${times["ssh_config_dev"]}
    ssh_config_val=${times["ssh_config_val"]}
else
    ssh_config_dev=0
    ssh_config_val=0
fi

# Recolección y caché de hechos
echo
print_title "Recolección y Caché de Hechos (Facts)"
echo "Configuración para mejorar el rendimiento al gestionar hechos."
echo "Ventaja: Reduce el tiempo de ejecución al evitar recopilar hechos repetidamente."
ask_number "¿Se configurará la recolección y caché de hechos (facts)? (0 = No, 1 = Sí): " use_facts

if [ "$use_facts" -eq 1 ]; then
    facts_dev=${times["facts_dev"]}
    facts_val=${times["facts_val"]}
else
    facts_dev=0
    facts_val=0
fi

# Etiquetas
echo
print_title "Etiquetas (Tags)"
echo "Permiten ejecutar subconjuntos específicos de tareas en los playbooks."
echo "Ventaja: Facilita la ejecución selectiva y el desarrollo incremental."
ask_number "¿Se utilizarán etiquetas (tags)? (0 = No, 1 = Sí): " use_tags

if [ "$use_tags" -eq 1 ]; then
    tags_dev=${times["tags_dev"]}
    tags_val=${times["tags_val"]}
else
    tags_dev=0
    tags_val=0
fi

# Registro y tiempos de ejecución
echo
print_title "Registro y Tiempos de Ejecución"
echo "Configuración para registrar logs y analizar el rendimiento."
echo "Ventaja: Ayuda en la depuración y optimización de los playbooks."
ask_number "¿Se configurará el registro y tiempos de ejecución? (0 = No, 1 = Sí): " use_logging

if [ "$use_logging" -eq 1 ]; then
    logging_dev=${times["logging_dev"]}
    logging_val=${times["logging_val"]}
else
    logging_dev=0
    logging_val=0
fi

# Pruebas y validación general
echo
print_title "Pruebas y Validación General"
echo "Tiempo estimado para pruebas integrales y depuración de errores."
testing_val=${times["testing_val"]}

# Documentación interna
echo
print_title "Documentación Interna"
echo "Incluye comentarios en código y documentación dentro de los archivos."
documentation_dev=${times["documentation_dev"]}

# Implementación en AWX/Ansible Automation Platform
echo
print_title "Implementación en AWX/Ansible Automation Platform"
echo "Configuración de proyectos, inventarios, credenciales y plantillas de trabajo."
echo "Ventaja: Permite gestionar y ejecutar playbooks desde una interfaz web centralizada."
ask_number "¿Se implementará en AWX/Ansible Automation Platform? (0 = No, 1 = Sí): " use_awx

if [ "$use_awx" -eq 1 ]; then
    awx_dev=${times["awx_dev"]}
    awx_val=${times["awx_val"]}
else
    awx_dev=0
    awx_val=0
fi

# Cálculo de tiempos totales
total_dev=$(( project_setup_dev + ansible_cfg_dev + inventory_dev + variables_dev + total_playbook_dev + total_role_dev + total_task_dev + total_template_dev + total_vars_role_dev + total_handler_dev + total_static_file_dev + total_module_dev + collection_dev + ssh_config_dev + facts_dev + tags_dev + logging_dev + documentation_dev + awx_dev ))

total_val=$(( project_setup_val + ansible_cfg_val + inventory_val + variables_val + total_playbook_val + total_role_val + total_task_val + total_template_val + total_vars_role_val + total_handler_val + total_static_file_val + total_module_val + collection_val + ssh_config_val + facts_val + tags_val + logging_val + testing_val + awx_val ))

total_time=$(( total_dev + total_val ))

# Conversión a horas
total_hours=$(awk "BEGIN {printf \"%.2f\", $total_time/60}")

# Mostrar resultados
echo
echo -e "\e[1;32m=========================================================="
echo "Estimación de Tiempo del Proyecto Ansible"
echo -e "==========================================================\e[0m"
echo -e "\e[1;36mTiempo de Desarrollo (min):\e[0m $total_dev"
echo -e "\e[1;36mTiempo de Validación (min):\e[0m $total_val"
echo "----------------------------------------------------------"
echo -e "\e[1;33mTiempo Total (min):\e[0m $total_time"
echo -e "\e[1;33mTiempo Total (horas):\e[0m $total_hours"
echo -e "\e[1;32m==========================================================\e[0m"

