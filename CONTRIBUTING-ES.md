# 🤝 Contribuyendo a Skills

¡Bienvenido! Gracias por tu interés en contribuir a este proyecto. Este repositorio contiene una colección de skills que pueden ser instalados en proyectos propios usando herramientas de línea de comandos.

**[English](CONTRIBUTING.md)**

## 📦 Instalación de Skills

Los usuarios pueden instalar skills de este repositorio usando:

```bash
# Con npx
npx skills add jondotsoy/skills --skill coaching-reporter

# Con bunx
bunx skills add jondotsoy/skills --skill coaching-reporter
```

## ✨ Cómo Contribuir con un Nuevo Skill

### 1. Nomenclatura del Skill

El nombre del skill debe seguir el patrón: **`[rol/entidad]-[función]`**

- **Rol/Entidad**: El dominio o contexto del skill
- **Función**: La acción o capacidad que proporciona

**Ejemplos:**
- `coaching-reporter` → Coaching + Reporter (genera reportería)
- `devops-argocd-cli` → DevOps + ArgoCD CLI (herramientas de línea de comandos)
- `frontend-component-generator` → Frontend + Component Generator
- `data-analysis-pipeline` → Data Analysis + Pipeline

**Formato:**
- Usa minúsculas
- Separa palabras con guiones (`-`)
- Sé descriptivo pero conciso

### 2. Crear la Estructura del Skill

Crea una carpeta en la raíz del proyecto con el nombre siguiendo la nomenclatura:

```
skills/
├── coaching-reporter/
│   ├── SKILL.md          ← Archivo principal (requerido)
│   └── resources/        ← Recursos adicionales (opcional)
│       ├── templates/
│       └── scripts/
```

### 3. Crear el Archivo SKILL.md

El archivo `SKILL.md` es el corazón de tu skill. Debe seguir el formato [Agent Skills](https://skill.md) estándar:

```markdown
---
name: Nombre del Skill
description: Descripción clara de qué hace el skill y cuándo usarlo (máx. 200 caracteres)
dependencies: python>=3.8, pandas>=1.5.0  # Opcional
---

## Overview
Descripción detallada de tu skill, su propósito y casos de uso.

## Instructions
Instrucciones paso a paso que el agente debe seguir.

## Examples
Ejemplos de entrada y salida esperada.

## Resources
Referencias a archivos adicionales si los hay.
```

**Campos requeridos en el frontmatter YAML:**
- `name`: Nombre amigable del skill (máx. 64 caracteres)
- `description`: Descripción clara para que el agente sepa cuándo invocar el skill (máx. 200 caracteres)

**Campos opcionales:**
- `dependencies`: Paquetes de software requeridos

### 4. Mejores Prácticas

- **Mantén el enfoque**: Un skill debe resolver una tarea específica y repetible
- **Descripción clara**: El agente usa la descripción para decidir cuándo invocar tu skill
- **Incluye ejemplos**: Ayuda al agente a entender qué es un resultado exitoso
- **Comienza simple**: Empieza con instrucciones básicas en Markdown antes de agregar scripts complejos
- **Recursos adicionales**: Si tienes mucha información, crea archivos adicionales en una carpeta `resources/`

### 5. Agregar Recursos Adicionales (Opcional)

Si tu skill necesita archivos de referencia, templates o scripts:

```
tu-skill/
├── SKILL.md
└── resources/
    ├── REFERENCE.md      ← Información suplementaria
    ├── templates/        ← Plantillas
    └── scripts/          ← Scripts ejecutables
```

Referencia estos archivos en tu `SKILL.md` para que el agente sepa cuándo acceder a ellos.

### 6. Actualizar el README.md

Agrega tu skill al archivo `README.md` del proyecto. Aunque no hay un formato establecido aún, incluye:

- Nombre del skill
- Breve descripción
- Ejemplo de instalación
- Casos de uso principales

### 7. Publicar en la Rama Develop

Una vez que tu skill esté listo:

```bash
git checkout develop
git add tu-nuevo-skill/
git add README.md
git commit -m "feat: agregar skill [nombre-del-skill]"
git push origin develop
```

### 8. Compartir

¡Listo! Ahora puedes compartir con la comunidad que tu skill está disponible para ser descargado e instalado en sus proyectos.

## 🧪 Probar tu Skill

Antes de publicar, verifica:

1. ✅ El nombre del skill sigue la nomenclatura `[rol/entidad]-[función]`
2. ✅ El `SKILL.md` tiene metadata completa y válida
3. ✅ La descripción refleja claramente cuándo debe usarse el skill
4. ✅ Todos los archivos referenciados existen en las ubicaciones correctas
5. ✅ El skill funciona con prompts de ejemplo

## 🤖 Trabajando con Agentes de IA

Este proyecto incluye un archivo **AGENTS.md** que proporciona instrucciones específicamente para agentes de IA. Si estás usando un agente de IA (como Claude, Cursor o GitHub Copilot) para ayudarte a crear tu skill, el agente leerá automáticamente este archivo para entender la estructura y convenciones del proyecto.

El archivo AGENTS.md contiene:
- Descripción general del proyecto y estructura
- Convenciones de nomenclatura de skills
- Requisitos del formato SKILL.md
- Flujo de trabajo de publicación

La mayoría de los agentes de IA modernos detectan y usan automáticamente los archivos AGENTS.md para proporcionar mejor asistencia.

## 📚 Recursos Adicionales

- [Especificación Agent Skills](https://skill.md)
- [Formato AGENTS.md](https://agents.md)
- [Documentación oficial de Skills](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)
- [Ejemplos de Skills](https://github.com/anthropics/skills/tree/main/skills)
- [Mejores prácticas](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

## 🔒 Consideraciones de Seguridad

- No incluyas información sensible (API keys, contraseñas) en el código
- Revisa cualquier script antes de agregarlo
- Documenta claramente las dependencias externas

## 💬 ¿Preguntas?

Si tienes dudas o necesitas ayuda, abre un issue en el repositorio.

---

**¡Gracias por contribuir! 🎉**
