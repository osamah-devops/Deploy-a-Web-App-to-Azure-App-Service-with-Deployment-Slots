---
mode: "agent"
description: "Generate a deployment checklist for Azure App Service slot deployments, including validation, health checks, swap steps, and rollback instructions."
tools: [read, search, edit]
---
Generate a deployment checklist for Azure App Service slot-based releases.

## Inputs
- App name: {{appName}}
- Production slot: {{productionSlot}}
- Target slot(s): {{targetSlots}}
- Deployment trigger: {{trigger}}
- Health endpoint: {{healthPath}}
- Azure resource group: {{resourceGroup}}

## Requirements
Create a clear pre-deployment checklist for a slot-based Azure App Service release process. Include:
- Preconditions and required Azure resources
- Deployment steps for the target slot
- App settings and environment validation
- Warm-up and health check validation
- Swap readiness checks
- Rollback steps if deployment fails or swap fails
- Sign-off items for production release

## Output format
Provide a checklist in markdown with headings and actionable bullet points.

Use concise but operational language suitable for a release engineer.
Include any Azure CLI or GitHub Actions commands only when they are relevant and valid.

If necessary, mention the need for a Standard App Service plan and slot-specific app settings.
