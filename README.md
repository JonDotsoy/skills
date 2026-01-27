# 📊 Coaching Report Skill

> Transform raw coaching session notes into professional, structured reports automatically

## 📖 Overview

**Coaching Report Skill** is an intelligent tool designed to streamline the documentation process for coaches, scrum masters, and team leaders. It solves the time-consuming challenge of converting unstructured coaching session notes, meeting transcripts, or audio recordings into comprehensive, actionable reports.

### What It Does

- **Transforms** raw text and transcriptions into structured coaching reports
- **Extracts** key insights, action items, and progress tracking automatically
- **Generates** professional documentation following coaching best practices
- **Saves time** by automating repetitive report writing tasks

### Perfect For

- 🎯 **Agile Coaches** managing multiple coachee sessions
- 👥 **Scrum Masters** tracking team development and retrospectives
- 📝 **Tech Leads** documenting 1-on-1s and career development conversations
- 💼 **Engineering Managers** maintaining consistent coaching documentation

### Ideal Input Sources

This skill works exceptionally well with:
- ✨ **Notion transcription** exports
- 📄 Meeting notes from collaborative tools
- 🎤 Audio transcription services
- 📝 Manual session notes

## 🚀 Quick Start

### Installation

Add this skill to your project using your preferred package manager:

**Using npx:**
```bash
npx skills add JonDotsoy/skills
```

**Using Bun:**
```bash
bunx skills add JonDotsoy/skills
```

### Usage Example

Once installed, you can use this skill with AI assistants and automation tools to process coaching session files:

**Example workflow:**

1. Export your coaching session notes (e.g., from Notion transcription)
2. Place the file in `coaching/sessions/` following the format: `<coachee>-<date>.md`
3. Run the skill to generate a comprehensive report
4. Find your structured report in `coaching/reports/` as `<coachee>-<date>-report.md`

**Report includes:**
- 😊 Coachee happiness and sentiment analysis
- 🎯 Discipline alignment and focus areas
- 💡 Personal facts and relationship building notes
- 🏆 Achievements and recognition
- ✅ Action items and next steps
- 📅 Follow-up planning

## ⚙️ Usage & Configuration

Take full control of your coaching report generation! This section will help you understand the file workflow and customize the skill to match your exact needs.

### 📁 File Workflow

Understanding where your files go and where outputs are generated is key to an efficient workflow.

> **📍 Input Location**: Place your coaching session files in `coaching/sessions/`  
> Use the naming convention: `<coachee>-<YYYY-MM-DD>.md`

> **📤 Output Location**: Generated reports are automatically saved in `coaching/reports/`  
> Output format: `<coachee>-<YYYY-MM-DD>-report.md`

**Example structure:**
```
your-project/
├── coaching/
│   ├── sessions/
│   │   ├── john-2026-01-15.md          ← Your input files
│   │   └── sarah-2026-01-20.md
│   └── reports/
│       ├── john-2026-01-15-report.md   ← Generated reports
│       └── sarah-2026-01-20-report.md
```

### 🎨 Customization

Want to adjust how reports are generated? You have full control! The skill's behavior is defined in the configuration files located in the `coaching-reporter/` directory.

#### Adjusting Tone of Voice

You can modify the system prompt to change the report's tone. Edit the instructions in `coaching-reporter/AGENTS.md` to adjust the style:

**Available tone options:**
- **Empático** (Empathetic): Warm, understanding, focuses on emotional support
- **Directo** (Direct): Clear, concise, action-oriented
- **Analítico** (Analytical): Data-driven, objective, detailed insights
- **Motivacional** (Motivational): Inspiring, encouraging, growth-focused

**Example customization:**
```markdown
<!-- In coaching-reporter/AGENTS.md -->

## Generar el reporte:
   - El reporte debe ser claro, conciso y profesional
   - **Tono de voz: [EMPÁTICO/DIRECTO/ANALÍTICO/MOTIVACIONAL]**
   - Usa un lenguaje que [describe el estilo deseado]
```

#### Changing Output Language

By default, reports are generated in Spanish. To force a different language, modify the language instruction in `coaching-reporter/AGENTS.md`:

```markdown
<!-- Original (Spanish) -->
- **El reporte completo debe estar escrito en español**

<!-- Change to English -->
- **The complete report must be written in English**

<!-- Or Portuguese -->
- **O relatório completo deve ser escrito em português**
```

**Pro tip:** You can also create language-specific templates by duplicating the skill directory and maintaining separate configurations for different teams or regions.

### 💡 Pro Tips for Best Results

#### Notion Export Recommendations

When exporting your coaching sessions from Notion:

> **✨ Recommended Format: Markdown & CSV**  
> This preserves the document structure, including headers, lists, and formatting, making it easier for the skill to parse and generate accurate reports.

**Export steps:**
1. Open your coaching session page in Notion
2. Click "⋯" (More actions) → Export
3. Select **"Markdown & CSV"** as the export format
4. Extract the downloaded file and move the `.md` file to `coaching/sessions/`

#### Other Tips

- **Consistent naming**: Stick to the `<coachee>-<date>.md` format for automatic processing
- **Rich context**: Include as much detail as possible in your session notes—the more context, the better the report quality
- **Template testing**: After customizing tone or language, test with a sample session to ensure the output meets your expectations

## 📄 License

This project is distributed under the **MIT License**.

See the [LICENSE](./LICENSE) file for complete details.

---

**Made with ❤️ for coaches who value their time and their coachees' growth**
