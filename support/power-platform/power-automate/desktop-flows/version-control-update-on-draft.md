---
title: Troubleshoot Version Control Errors When Publishing or Saving a Flow
description: Learn how to resolve version control errors in Power Automate for Desktop. Fix unpublished active row issues when saving or publishing flows.
ms.reviewer: Nikos.Moutzourakis, v-shaywood
ms.date: 11/13/2025
ms.custom: sap:Desktop flows\List, create, open, save or delete flows
---

# Version control error when publishing a flow or saving it as a draft

This article provides troubleshooting guidance for an error you might encounter in Power Automate for Desktop when publishing a flow or saving it as a draft in an unmodified context when there is an unpublished active row. This issue can occur when the *Desktop flow version control* feature is enabled. For more information about the version control feature, see [Version control in Power Automate for desktop](/power-automate/desktop-flows/version-control)

## Symptoms

After you enable version control for desktop flows, when you attempt to publish a flow or save it as a draft, you receive the following error message:

> You are attempting to do a published update of a component in an unmodified context when there is an unpublished active row.

## Cause

This error can occur in the following scenarios:

- You created or edited the flow using a newer version of Power Automate for Desktop, but your device is running an older version.
- A newer version of Power Automate for Desktop is still rolling out and isn’t available on your device yet.
- You switch from an environment that has version control enabled to one that doesn't.

## Resolution

1. Use the same version of Power Automate for Desktop that you previously used to create or edit the flow, or upgrade to the latest version.
2. If a newer version of Power Automate for Desktop isn’t available on your device yet, wait for the rollout to complete.
3. Ensure that version control is enabled for all environments where you edit or publish flows.
