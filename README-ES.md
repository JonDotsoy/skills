# Colección de Agent Skills

> Una colección curada de skills para agentes de IA para automatizar documentación, reportes de coaching y flujos de trabajo técnicos

**[English](README.md)** | Español

## 📖 Descripción General

Este repositorio contiene una colección de Agent Skills que pueden ser instalados en proyectos usando herramientas de línea de comandos como `npx skills` o `bunx skills`. Cada skill es un paquete autocontenido con instrucciones y recursos que los agentes de IA pueden usar para realizar tareas específicas.

## Skills Disponibles

### 📊 Coaching Reporter
Transforma notas crudas de sesiones de coaching en reportes profesionales y estructurados automáticamente.

**Perfecto para:**
- Coaches Ágiles gestionando múltiples sesiones
- Scrum Masters rastreando desarrollo de equipos
- Tech Leads documentando conversaciones 1-on-1
- Engineering Managers manteniendo documentación de coaching

[Ver Documentación →](coaching-reporter/README.md)

### 📝 Runbook Generator
Crea runbooks estructurados para documentar escenarios reproducibles para APIs, flujos UX y procedimientos técnicos.

**Perfecto para:**
- Documentar flujos de trabajo de APIs y pruebas de integración
- Registrar flujos de interfaz de usuario
- Estandarizar procedimientos de despliegue
- Crear escenarios de prueba reproducibles

[Ver Documentación →](runbook-generator/README.md)

### ▶️ Runbook Executor
Ejecuta runbooks y genera documentación de evidencia con timestamp de los resultados de ejecución.

**Perfecto para:**
- Crear registros de auditoría para cumplimiento
- Depurar problemas de producción
- Entrenar nuevos miembros del equipo
- Comparar resultados de ejecución a lo largo del tiempo

[Ver Documentación →](runbook-executor/README.md)

### 🔀 PR Creator
Automatiza la creación de pull requests en GitHub en modo draft siguiendo el formato Conventional Commits.

**Perfecto para:**
- Mantener formato consistente de PRs en equipos
- Extraer IDs de tickets automáticamente del nombre de las ramas
- Generar descripciones estructuradas de PRs con secciones apropiadas
- Ahorrar tiempo en tareas repetitivas de creación de PRs
- Asegurar que los PRs sigan mejores prácticas y convenciones

[Ver Documentación →](pr-creator/README.md)

### 💬 Commit Message
Genera mensajes de commit consistentes siguiendo el estándar Conventional Commits leyendo el diff staged y el historial de commits recientes.

**Perfecto para:**
- Escribir mensajes de commit bien formateados sin memorizar la especificación
- Mantener un estilo de commits consistente en el equipo
- Describir el "por qué" de los cambios, no solo el "qué"
- Validar mensajes antes de que sean commiteados

[Ver Documentación →](commit-message/README.md)

### 🗺️ Project Roadmap
Crea y gestiona un ROADMAP de proyecto a nivel de historia de usuario, rastreando hitos (`HU-*`), sus descripciones y dependencias sin mezclar detalles de implementación.

**Perfecto para:**
- Planificar funcionalidades e hitos con un orden claro de dependencias
- Visualizar el roadmap como un diagrama de dependencias Mermaid
- Mantener la planificación separada de los detalles de implementación
- Compartir un roadmap estructurado con stakeholders

[Ver Documentación →](project-roadmap/README.md)

### 🗒️ Feature Notes
Mantiene una ficha de contexto por branch (`feature.md`) para el feature que se está trabajando actualmente — contexto de negocio y restricciones técnicas, no un plan de implementación.

**Perfecto para:**
- Capturar por qué se construye un feature y para quién, antes de escribir código
- Mantener visibles las restricciones y decisiones técnicas a lo largo de una branch de larga duración
- Retomar contexto rápidamente al volver a una branch de feature más tarde
- Resumir el trabajo hecho para una entrada de CHANGELOG, cuando se pida

[Ver Documentación →](feature-notes/README.md)

## 🚀 Inicio Rápido

### Instalación

Agrega skills a tu proyecto usando tu gestor de paquetes preferido:

**Instalar todos los skills:**
```bash
npx skills add jondotsoy/skills
```

**Instalar un skill específico:**
```bash
npx skills add jondotsoy/skills --skill coaching-reporter
npx skills add jondotsoy/skills --skill runbook-generator
npx skills add jondotsoy/skills --skill runbook-executor
npx skills add jondotsoy/skills --skill pr-creator
npx skills add jondotsoy/skills --skill commit-message
npx skills add jondotsoy/skills --skill project-roadmap
npx skills add jondotsoy/skills --skill feature-notes
```

**Usando Bun:**
```bash
bunx skills add jondotsoy/skills --skill coaching-reporter
```

## 📚 Documentación

Cada skill incluye documentación completa:

- **SKILL.md**: Instrucciones para agentes y configuración
- **README.md**: Documentación de usuario y ejemplos de uso
- **AGENTS.md**: Instrucciones detalladas para agentes de IA (cuando aplica)

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Por favor lee la [Guía de Contribución](CONTRIBUTING-ES.md) para detalles sobre cómo crear nuevos skills o mejorar los existentes.

**Contributing in English?** Check out [CONTRIBUTING.md](CONTRIBUTING.md)

## 🛠️ Creando Tus Propios Skills

¿Quieres crear un skill personalizado? Sigue las guías en [AGENTS.md](AGENTS.md) para aprender sobre:

- Convenciones de nombres de skills
- Estructura de archivos requerida
- Formato y metadata de SKILL.md
- Proceso de pruebas y publicación

## 📄 Licencia

Este proyecto se distribuye bajo la **Licencia MIT**.

Consulta el archivo [LICENSE](./LICENSE) para detalles completos.

---

**Hecho con ❤️ por [Jonathan Delgado](https://jon.soy)**
