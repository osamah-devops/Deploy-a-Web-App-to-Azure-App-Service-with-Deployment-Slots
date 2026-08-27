---
applyTo: "**/*.bicep"
description: "Review Azure App Service and deployment-slot Bicep for best practices, correctness, and production-safe configuration."
---
Review Azure App Service Bicep for App Service deployment-slot correctness and production-safe patterns.

## Priority checks
- Ensure the App Service plan is Standard or higher because deployment slots require it.
- Confirm the target web app is defined with the correct Linux or Windows runtime.
- Validate slot resources use the same hosting plan and matching runtime settings.
- Check that slot-specific app settings are explicitly set and production-safe values are not accidentally carried over.
- Make sure warm-up settings are present when swap-based deployments are used.

## Best practices
- Define a unique production app name and consistent slot names such as `staging` and `dev`.
- Use `WEBSITE_SWAP_WARMUP_PING_PATH` and `WEBSITE_SWAP_WARMUP_PING_STATUSES` for reliable slot validation.
- Use `slotConfigNames` to pin sticky settings such as `SLOT_NAME` and `SLOT_COLOR`.
- Keep app settings explicit for production and slot-specific values.
- Prefer secure and minimal configuration over broad permissions or unnecessary settings.
- Ensure `httpsOnly` is enabled and deployment config aligns with the runtime stack.

## Common issues to flag
- App Service plan below Standard
- Missing slot resource definitions or incorrect parent relationships
- Missing or inconsistent `linuxFxVersion` or runtime configuration
- No warm-up settings before a swap
- Sticky settings not configured for values that should remain production-specific
- Generic or duplicated app settings that may leak across slots

## Review output
Provide a concise review with:
1. Pass/fail summary
2. Key issues found
3. Recommended Bicep changes
4. Any risks or follow-up validation steps

Keep the guidance practical, precise, and suitable for Azure App Service deployment-slot workloads.
