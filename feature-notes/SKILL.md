---
name: feature-notes
description: Mantiene una ficha de contexto (feature.md) por branch de git para el feature que se está trabajando actualmente — no es un plan de implementación, es el contexto de negocio y las restricciones técnicas a seguir. Usa este skill cuando el usuario pregunte "qué feature estamos trabajando" / "what feature are we working on", diga "en este branch trabajemos en..." / "in this branch let's work on..." o "let's build X here", pida documentar/guardar/actualizar el contexto de negocio o las restricciones técnicas del feature actual, quiera abrir la ficha del feature para editarla a mano, o pida actualizar el CHANGELOG por el trabajo hecho en el feature actual. Actívalo también de forma proactiva antes de empezar cualquier implementación no trivial en una branch de feature, para revisar si ya existe una ficha guardada y cargar ese contexto antes de escribir código. Funciona con frases en español e inglés.
license: MIT
metadata:
  author: Jonathan Delgado <hi@jon.soy> (https://jon.soy)
  version: "1.0"
---

# feature-notes

## Qué hace este skill

Mantiene un archivo de detalle de feature por branch de git, en `.git/features_works/<branch>/feature.md`. Este archivo **no es un plan de implementación para el agente** — es la ficha de la feature: qué se está construyendo, por qué (contexto de negocio) y qué restricciones técnicas hay que respetar. El agente lo usa como fuente de verdad para entender el trabajo antes de tocar código, y lo mantiene actualizado a medida que la conversación aporta más contexto.

¿Por qué vive dentro de `.git/`? Es información de trabajo en curso, específica de esta copia local del repo, que el usuario quiere mantener sin versionar ni compartir. Git nunca rastrea el contenido de `.git/`, así que no hace falta gitignorarlo ni preocuparse de que termine en un commit por accidente — pero también significa que se pierde si el usuario clona el repo de nuevo en otra máquina. Si el usuario alguna vez pregunta por esto, es bueno recordárselo, pero no cambies la ubicación sin que te lo pida.

## Paso 1: identificar la branch actual

Ejecuta siempre esto primero, incluso si crees recordar la branch de un turno anterior — el usuario puede haber cambiado de branch entre mensajes:

```
git branch --show-current
```

- Si el repo tiene HEAD "detached" (el comando devuelve vacío), avisa al usuario y usa `git rev-parse --short HEAD` como identificador en su lugar (ej. `.git/features_works/detached-<hash>/feature.md`), dejando claro que conviene crear o cambiar a una branch real para que el feature quede bien asociado.
- Si el comando falla (no es un repo git), dile al usuario que este skill necesita estar dentro de un repositorio git y detente ahí.

## Paso 2: ubicar el archivo del feature

Ruta: `.git/features_works/<branch>/feature.md`

Si el nombre de la branch tiene `/` (ej. `feature/01`), esto crea subcarpetas de forma natural (`.git/features_works/feature/01/feature.md`) — es el comportamiento esperado, no hay que sanitizar el nombre.

## Paso 3: decidir si crear, leer o actualizar

### El archivo no existe → crear

Esto pasa la primera vez que se trabaja en una branch, o cuando el usuario dice explícitamente algo como "en este branch trabajemos en X".

1. Si el usuario ya dio contexto suficiente en su mensaje (qué se va a construir, por qué, restricciones técnicas conocidas), úsalo directamente para llenar la ficha sin pedir más de lo necesario.
2. Si el contexto es escaso (ej. solo "trabajemos en el login"), pregunta lo mínimo indispensable: el objetivo de negocio y si hay restricciones técnicas ya decididas (stack, APIs a respetar, cosas a evitar). Es una ficha de trabajo rápida, no un formulario — no sobre-preguntes.
3. Usa `assets/feature_template.md` como estructura base.
4. Crea la carpeta si no existe y escribe el archivo.
5. Confirma al usuario dónde quedó guardado y ofrécele el comando para abrirlo en el editor si prefiere afinar el texto a mano:
   ```
   code <ruta absoluta al feature.md>
   ```
   Esto solo funciona si el usuario tiene el CLI de VS Code (`code`) disponible en su entorno. Si no está seguro de tenerlo, puede simplemente seguir dictándote los cambios y tú editas el archivo.

### El archivo ya existe → leer y usar como contexto

Esto es lo normal durante el resto del trabajo en esa branch.

1. Léelo completo antes de emprender cualquier trabajo no trivial en la branch (implementar algo, revisar código relacionado, etc.).
2. Usa su contenido como marco — qué se está construyendo, contexto de negocio, restricciones técnicas — para informar tus decisiones. No se lo repitas al usuario a menos que te lo pida.
3. Si el usuario da instrucciones que agregan o cambian el alcance del feature (nueva restricción, nuevo detalle de negocio, cambio de objetivo), actualiza el archivo para que siga siendo la fuente de verdad — edita solo las secciones relevantes, no sobrescribas todo. Si no es obvio si algo es una corrección a la ficha o solo una instrucción puntual para esta tarea, pregunta antes de modificar el archivo.
4. Si el usuario pregunta directamente "qué feature estamos trabajando" o similar, respóndele con un resumen breve y natural basado en el archivo — no le pegues el markdown crudo.

## Paso 4: apoyar la implementación

El feature.md es contexto de negocio/técnico, no un plan de agente ni una checklist de tareas. Una vez cargado, procede a implementar los cambios con tus herramientas normales (leer código, editar, correr tests, etc.), guiándote por el objetivo y las restricciones que describe el archivo. No generes un plan de subtareas separado dentro o fuera de feature.md a menos que el usuario lo pida explícitamente — este skill da contexto de qué y por qué, no gestiona el cómo paso a paso.

## Paso 5: actualizar el CHANGELOG (solo si el usuario lo pide)

No toques el changelog de forma proactiva — solo cuando el usuario lo pida explícitamente (ej. "actualiza el changelog", "agrega esto al changelog").

1. Busca un `CHANGELOG.md` (u otro nombre común como `HISTORY.md`) en la raíz del repo.
2. Si existe, mira las entradas recientes para detectar el formato que el proyecto ya usa (¿sigue Keep a Changelog con `[Unreleased]` / `Added` / `Changed` / `Fixed`? ¿es una lista plana de bullets? ¿otro estilo?) e imita ese mismo formato — no le impongas un formato distinto al que ya tiene el repo.
3. Si no existe ningún changelog, pregúntale al usuario si quiere que crees uno y en qué formato, antes de crear el archivo.
4. La entrada debe resumir el cambio hecho en esta feature (basándote en lo implementado y en el feature.md), no pegar el detalle completo de la ficha.

## Notas generales

- Este skill no reemplaza el control de versiones normal: el código sigue yendo a los archivos del proyecto y se commitea como siempre. Solo `feature.md` vive fuera del árbol versionado, dentro de `.git/`.
- Si el usuario cambia de branch a mitad de conversación, vuelve a correr el Paso 1 y trata la nueva branch como su propio feature — archivo propio, contexto propio.
- Si el usuario pide ver o listar los features documentados hasta ahora, puedes listar el contenido de `.git/features_works/` para mostrarle qué branches tienen ficha creada.
