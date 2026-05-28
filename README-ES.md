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

### 🗂️ Issue Workspace
Configura un entorno de desarrollo completo y aislado alrededor de un issue: descarga el ticket, crea una rama dedicada, activa el rastreo de memorias y prepara un worktree limpio para el pull request.

**Perfecto para:**
- Iniciar el trabajo en un issue de GitHub con un entorno estructurado
- Mantener notas, decisiones y contexto organizados por ticket
- Preparar una rama de pull request limpia sin mezclar archivos de memoria
- Equipos que quieren flujos consistentes desde el issue hasta el PR

[Ver Documentación →](issue-workspace/README.md)

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
npx skills add jondotsoy/skills --skill issue-workspace
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
