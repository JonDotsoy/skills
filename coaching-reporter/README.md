# Coaching Reporter Skill

Transform coaching session notes into structured, professional reports automatically.

## Overview

This skill analyzes coaching session files and generates comprehensive reports that include:

- Coachee happiness and sentiment analysis
- Discipline alignment tracking
- Personal facts and relationship building notes
- Achievements and recognition
- Action items and next steps
- Follow-up planning

## Installation

```bash
# Using npx
npx skills add jondotsoy/skills --skill coaching-reporter

# Using bunx
bunx skills add jondotsoy/skills --skill coaching-reporter
```

## Usage

### File Structure

Place your coaching session files in:
```
coaching/sessions/<coachee>-<YYYY-MM-DD>.md
```

Generated reports will be saved to:
```
coaching/reports/<coachee>-<YYYY-MM-DD>-report.md
```

### Example

1. Create a session file: `coaching/sessions/john-2026-01-27.md`
2. Ask your AI agent to generate a report from the session
3. Find the report at: `coaching/reports/john-2026-01-27-report.md`

## Vocabulary

**Coachee**: The person receiving coaching. The professional being accompanied, guided, and supported in their professional and personal development through coaching sessions.

## Report Sections

- **Happiness**: Coachee's current emotional state
- **Discipline Alignment**: Whether working within their main discipline
- **Personal Facts**: Relationship building information
- **Achievements**: Recognition and accomplishments
- **Action Items**: Next steps and commitments
- **Follow-up**: Planning for future sessions

## Customization

### Modifying the Report Template

The report template is defined in `AGENTS.md`. To customize it:

1. Open `coaching-reporter/AGENTS.md`
2. Locate the "Template Reporte de Coaching" section
3. Modify the sections, character limits, or structure as needed
4. Save your changes

### Changing Report Language

By default, reports are generated in Spanish. To change the language:

1. Edit `coaching-reporter/AGENTS.md`
2. Update the instruction: `**El reporte completo debe estar escrito en español**`
3. Modify the template sections and emoji suggestions to your preferred language

### Adjusting File Paths

To use different folder structures:

1. Edit `coaching-reporter/AGENTS.md` or `SKILL.md`
2. Update the paths in the "Identificar el archivo de sesión" and "Guardar el reporte" sections
3. Change `coaching/sessions/` and `coaching/reports/` to your preferred paths

### Adding Custom Sections

To add new sections to the report:

1. Open `coaching-reporter/AGENTS.md`
2. Add your custom section to the template with format:
   ```markdown
   ### Your Section Name
   Description of what to capture
   
   **Report**:
   
   <format or character limit>
   ```
3. Update the "Guía para Completar el Reporte Narrativo" with guidance for the new section

## Documentation

- [SKILL.md](SKILL.md) - Skill definition and basic instructions
- [AGENTS.md](AGENTS.md) - Detailed implementation guide for AI agents

## License

MIT License - See [LICENSE](../LICENSE) for details
