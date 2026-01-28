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

## Documentation

- [SKILL.md](SKILL.md) - Skill definition and basic instructions
- [AGENTS.md](AGENTS.md) - Detailed implementation guide for AI agents

## License

MIT License - See [LICENSE](../LICENSE) for details
