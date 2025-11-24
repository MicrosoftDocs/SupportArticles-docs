---
title: Troubleshoot Version Control Errors When Publishing or Saving a Flow
description: Learn how to resolve version control errors in Power Automate for Desktop. Fix unpublished active row issues when saving or publishing flows.
ms.reviewer: Nikos.Moutzourakis, v-shaywood
ms.date: 11/24/2025
ms.custom: sap:Desktop flows\List, create, open, save or delete flows
---

# Version control error when publishing a flow or saving it as draft

This article provides troubleshooting guidance for an error you might encounter in Power Automate for desktop when you try to publish a flow or save it as a draft in an environment where [version control](/power-automate/desktop-flows/version-control) is enabled.

## Symptoms

When you try to publish a flow or save it as a draft in an environment where version control is enabled, you receive the following error message:

> You are attempting to do a published update of a component in an unmodified context when there is an unpublished active row.

## Cause

This error might occur in the following scenarios:

- You initially created or edited the flow using a newer version of Power Automate for desktop than the one you are currently running.
- The newer version of Power Automate for desktop hasn't rolled out or installed yet on your device.
- You switch from an environment that has version control enabled to an environment that doesn't.

## Resolution

To resolve this issue, follow these guidelines:

- Use the same version of Power Automate for Desktop that you previously used to create or edit the flow, or upgrade to the latest version.
- If the latest version of Power Automate for Desktop isn’t available yet on your device, wait until it is.
- Make sure that version control is enabled for all environments where you edit or publish flows.
