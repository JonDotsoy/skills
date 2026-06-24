---
name: commit-message
description: Genera un mensaje de commit en formato Conventional Commits leyendo el diff staged y los últimos commits del repositorio.
license: MIT
metadata:
  author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
  version: "1.0"
---

# Commit Message Generator

Genera un mensaje de commit siguiendo el estándar **Conventional Commits** para los cambios actualmente en el staging area.

## Workflow

### 1. Obtener el diff staged

```bash
git --no-pager diff --staged
```

Si no hay nada staged, detenerse y avisar al usuario: "No hay cambios en el staging area. Agrega archivos con `git add` primero."

### 2. Obtener contexto de commits recientes

```bash
git --no-pager log --format="%s%n%b" -10
```

Esto entrega los últimos 10 mensajes (subject + body) para inferir el estilo y vocabulario usados en el proyecto.

### 3. Analizar el diff

Antes de escribir el mensaje, responder internamente:

- **¿Qué cambió?** — Archivos modificados, funciones añadidas/eliminadas, comportamiento nuevo.
- **¿Por qué cambió?** — Qué problema resuelve o qué capacidad agrega (esto va en el body).
- **¿Cuál es el scope?** — Subsistema, carpeta o componente más representativo del cambio (ej. `extraer-metadata`, `consola`, `api`, `db`, `scripts`). Si el cambio es transversal, omitir el scope.
- **¿Cuál es el type?** — Ver tabla de tipos a continuación.

### 4. Elegir el type

| Type | Cuándo usarlo |
|------|---------------|
| `feat` | Nueva funcionalidad visible al usuario o al sistema |
| `fix` | Corrección de un bug |
| `refactor` | Cambio interno que no altera comportamiento ni agrega features |
| `test` | Agrega o corrige tests |
| `docs` | Solo documentación (README, CLAUDE.md, comentarios) |
| `chore` | Tareas de mantenimiento: dependencias, configuración, CI |
| `style` | Formato, espaciado, nombres — sin cambio de lógica |
| `perf` | Optimización de rendimiento |
| `build` | Sistema de build, scripts de empaquetado |
| `ci` | Pipelines de CI/CD |
| `revert` | Revierte un commit previo |

Elegir el **type más específico** que aplique. Si el diff mezcla varios types, dividirlo en commits separados es preferible — mencionarlo al usuario si aplica.

### 5. Redactar el mensaje

**Formato obligatorio:**

```
<type>(<scope>): <subject>

<body>
```

**Reglas del subject (primera línea):**

- Imperativo en inglés o español, según el idioma de los commits recientes del proyecto.
- Minúsculas, sin punto final.
- Máximo 72 caracteres incluyendo `type(scope): `.
- Describe **qué** hace el cambio, no cómo.

**Reglas del body (opcional pero recomendado cuando el cambio no es trivial):**

- Separado del subject por una línea en blanco.
- Explica el **por qué** del cambio: contexto, problema que resuelve, decisión tomada.
- Líneas de máximo 72 caracteres.
- Puede usar viñetas (`-`) para enumerar puntos.
- Omitir si el subject ya es autoexplicativo.

### 6. Validar el mensaje generado

Antes de presentarlo al usuario, pasar el mensaje por el script de validación:

```bash
bash scripts/validate-commit-message.sh "<mensaje generado>"
```

Si el script falla (exit 1), corregir el mensaje hasta que pase todas las reglas. Solo presentar el mensaje al usuario cuando la validación sea exitosa.

### 7. Presentar el resultado

Mostrar el mensaje en un bloque de código para que el usuario pueda copiarlo fácilmente:

```
<type>(<scope>): <subject>

<body>
```

Si hay algo ambiguo en el diff (mezcla de concerns, scope no claro), mencionarlo brevemente después del bloque. No preguntar antes de generar — generar primero, comentar después.

## Ejemplos

```
feat(extraer-metadata): add last_payment_folio field to PDF parser

Kastor started including the folio number in boletas issued from 2025-07.
Added extraction logic in parsear_metadata() and updated schema.json.
```

```
fix(consola): show correct billing period when month is January

Date arithmetic was rolling back to December of the previous year
due to a zero-index month offset.
```

```
chore: update wrangler to 3.78.0
```

```
refactor(api): extract apartment upsert into repository layer

Moves D1 write logic out of the route handler to follow the
API → Router → Service → Repository pattern defined in docs/dev/api.md.
```
