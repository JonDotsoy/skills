# 📊 Skill de Reportes de Coaching

> Transforma notas crudas de sesiones de coaching en reportes profesionales y estructurados automáticamente

**[English](README.md)** | Español

## 📖 Descripción General

**Skill de Reportes de Coaching** es una herramienta inteligente diseñada para optimizar el proceso de documentación para coaches, scrum masters y líderes de equipo. Resuelve el desafío que consume tiempo de convertir notas desestructuradas de sesiones de coaching, transcripciones de reuniones o grabaciones de audio en reportes completos y accionables.

### Qué Hace

- **Transforma** texto crudo y transcripciones en reportes estructurados de coaching
- **Extrae** insights clave, elementos de acción y seguimiento de progreso automáticamente
- **Genera** documentación profesional siguiendo las mejores prácticas de coaching
- **Ahorra tiempo** automatizando tareas repetitivas de escritura de reportes

### Perfecto Para

- 🎯 **Coaches Ágiles** gestionando múltiples sesiones de coachees
- 👥 **Scrum Masters** rastreando desarrollo de equipos y retrospectivas
- 📝 **Tech Leads** documentando conversaciones 1-on-1 y desarrollo de carrera
- 💼 **Engineering Managers** manteniendo documentación consistente de coaching

### Fuentes de Entrada Ideales

Este skill funciona excepcionalmente bien con:
- ✨ Exportaciones de **transcripciones de Notion**
- 📄 Notas de reuniones de herramientas colaborativas
- 🎤 Servicios de transcripción de audio
- 📝 Notas manuales de sesiones

## 🚀 Inicio Rápido

### Instalación

Agrega este skill a tu proyecto usando tu gestor de paquetes preferido:

**Usando npx:**
```bash
npx skills add JonDotsoy/skills
```

**Usando Bun:**
```bash
bunx skills add JonDotsoy/skills
```

### Ejemplo de Uso

Una vez instalado, puedes usar este skill con asistentes de IA y herramientas de automatización para procesar archivos de sesiones de coaching:

**Flujo de trabajo de ejemplo:**

1. Exporta tus notas de sesión de coaching (ej., desde transcripción de Notion)
2. Coloca el archivo en `coaching/sessions/` siguiendo el formato: `<coachee>-<fecha>.md`
3. Ejecuta el skill para generar un reporte completo
4. Encuentra tu reporte estructurado en `coaching/reports/` como `<coachee>-<fecha>-report.md`

**El reporte incluye:**
- 😊 Análisis de felicidad y sentimiento del coachee
- 🎯 Alineación con disciplina y áreas de enfoque
- 💡 Datos personales y notas de construcción de relación
- 🏆 Logros y reconocimientos
- ✅ Elementos de acción y próximos pasos
- 📅 Planificación de seguimiento

## ⚙️ Uso y Configuración

¡Toma el control completo de la generación de tus reportes de coaching! Esta sección te ayudará a entender el flujo de trabajo de archivos y personalizar el skill para que coincida exactamente con tus necesidades.

### 📁 Flujo de Trabajo de Archivos

Entender dónde van tus archivos y dónde se generan las salidas es clave para un flujo de trabajo eficiente.

> **📍 Ubicación de Entrada**: Coloca tus archivos de sesión de coaching en `coaching/sessions/`  
> Usa la convención de nombres: `<coachee>-<AAAA-MM-DD>.md`

> **📤 Ubicación de Salida**: Los reportes generados se guardan automáticamente en `coaching/reports/`  
> Formato de salida: `<coachee>-<AAAA-MM-DD>-report.md`

**Estructura de ejemplo:**
```
tu-proyecto/
├── coaching/
│   ├── sessions/
│   │   ├── juan-2026-01-15.md          ← Tus archivos de entrada
│   │   └── maria-2026-01-20.md
│   └── reports/
│       ├── juan-2026-01-15-report.md   ← Reportes generados
│       └── maria-2026-01-20-report.md
```

### 🎨 Personalización

¿Quieres ajustar cómo se generan los reportes? ¡Tienes control total! El comportamiento del skill está definido en los archivos de configuración ubicados en el directorio `coaching-reporter/`.

#### Ajustando el Tono de Voz

Puedes modificar el prompt del sistema para cambiar el tono del reporte. Edita las instrucciones en `coaching-reporter/AGENTS.md` para ajustar el estilo:

**Opciones de tono disponibles:**
- **Empático**: Cálido, comprensivo, se enfoca en el apoyo emocional
- **Directo**: Claro, conciso, orientado a la acción
- **Analítico**: Basado en datos, objetivo, insights detallados
- **Motivacional**: Inspirador, alentador, enfocado en el crecimiento

**Ejemplo de personalización:**
```markdown
<!-- En coaching-reporter/AGENTS.md -->

3. **Generar el reporte**:
   - Crea un reporte detallado basado en la información del archivo de sesión
   - Utiliza el template "Template Reporte de Coaching" que se encuentra a continuación
   - El reporte debe ser claro, conciso y profesional
   - **Tono de voz: EMPÁTICO** (o DIRECTO/ANALÍTICO/MOTIVACIONAL)
   - El reporte completo debe estar escrito en español
```

#### Cambiando el Idioma de Salida

Por defecto, los reportes se generan en español. Para forzar un idioma diferente, modifica la instrucción de idioma en `coaching-reporter/AGENTS.md`:

```markdown
<!-- Original (Español) -->
- **El reporte completo debe estar escrito en español**

<!-- Cambiar a Inglés -->
- **The complete report must be written in English**

<!-- O Portugués -->
- **O relatório completo deve ser escrito em português**
```

**Consejo profesional:** También puedes crear plantillas específicas por idioma duplicando el directorio del skill y manteniendo configuraciones separadas para diferentes equipos o regiones.

### 💡 Consejos Pro para Mejores Resultados

#### Recomendaciones de Exportación desde Notion

Al exportar tus sesiones de coaching desde Notion:

> **✨ Formato Recomendado: Markdown & CSV**  
> Esto preserva la estructura del documento, incluyendo encabezados, listas y formato, facilitando que el skill analice y genere reportes precisos.

**Pasos de exportación:**
1. Abre tu página de sesión de coaching en Notion
2. Haz clic en "⋯" (Más acciones) → Exportar
3. Selecciona **"Markdown & CSV"** como formato de exportación
4. Extrae el archivo descargado y mueve el archivo `.md` a `coaching/sessions/`

#### Otros Consejos

- **Nombres consistentes**: Adhiérete al formato `<coachee>-<fecha>.md` para procesamiento automático
- **Contexto rico**: Incluye tantos detalles como sea posible en tus notas de sesión—cuanto más contexto, mejor la calidad del reporte
- **Prueba de plantilla**: Después de personalizar el tono o idioma, prueba con una sesión de muestra para asegurar que la salida cumple con tus expectativas

## 📄 Licencia

Este proyecto se distribuye bajo la **Licencia MIT**.

Consulta el archivo [LICENSE](./LICENSE) para detalles completos.

---

**Hecho con ❤️ para coaches que valoran su tiempo y el crecimiento de sus coachees**
