---
title: Handle version control error when saving as draft or publishing a flow in an unmodified context when there is an unpublished active row
description: Provides a resolution for the attempting to do a published update of a component in an unmodified context when there is an unpublished active row error when using version control in Power Automate for desktop.
author: nimoutzo
ms.author: nimoutzo
ms.date: 11/13/2025
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Handle version control error when saving as draft or publishing a flow in an unmodified context when there is an unpublished active row

## Symptoms
When saving as draft or publishing a flow, you see the error:

> “You are attempting to do a published update of a component in an unmodified context when there is an unpublished active row.”

## Cause
This error typically occurs in these scenarios:
- You created or edited the flow using a newer version of Power Automate for Desktop, but your device is running an older version.
- The newer version is still rolling out and isn’t yet available on your device.
- You switched environments, and one of them doesn’t have version control enabled.

## Resolution
- Use the same version of Power Automate for Desktop that you last used to create or edit the flow, or upgrade to the latest version.
- If the newer version isn’t available yet, wait until the rollout completes.
- Ensure that version control is enabled in all environments where you edit or publish flows.
