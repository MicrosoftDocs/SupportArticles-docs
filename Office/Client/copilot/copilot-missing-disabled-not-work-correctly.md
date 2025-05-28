---
title: Copilot is Missing, Disabled, or Doesn't Work Correctly
description: Resolves errors and issues, such as no Copilot button on the ribbon, when you use Copilot in Microsoft 365 Apps.
ms.reviewer: yasgow, gausin
ms.topic: troubleshooting
ms.date: 05/27/2025
manager: dcscontentpm
audience: Admin
ms.service: microsoft-365-copilot
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft 365 Copilot
ms.custom: 
  - sap:Copilot for Microsoft 365
  - CI 5818
---
# Copilot is missing, disabled, or doesn't work correctly

## Symptoms

When you try to use Copilot in Microsoft 365 Apps, you experience one of the following issues:

- The Copilot button doesn't appear on the ribbon or is unavailable (grayed out).
- You receive one of the following error messages:
  
  > Couldn't update license  
    You can continue using Microsoft 365 and try again. If issues persist, please contact Microsoft support.  
    Error code: 29
  >
  > Something went wrong. Let's try again.

## Cause

These issues might occur for any of the following reasons:

- Newly assigned license: A new license assignment can take some time to propagate. This delay might prevent Copilot from being available immediately.
- Licensing or account conflicts: For example, you're signed in to Microsoft 365 by using both a personal account and a work or school account. In this situation, Copilot might not validate correctly.
- Internet connectivity issues: To have Copilot work correctly, [these network requirements](/copilot/microsoft-365/microsoft-365-copilot-requirements#network-requirements) must be met.
- Recent Office reset or update: In this situation, your Office activation status might be affected.
- Device-based licensing is used: Copilot isn't available when you use device-based licensing for Microsoft 365 Apps. To use Copilot, you must have a user-based license assigned.
- Semi-Annual Enterprise Channel is used as the update channel: To use Copilot, your organization must use the Current Channel or the Monthly Enterprise Channel.
- Copilot is blocked by your [privacy settings](/copilot/microsoft-365/microsoft-365-copilot-privacy#microsoft-365-copilot-and-privacy-controls-for-connected-experiences).
- Shared Computer Activation (SCA) is used: Copilot isn't supported in environments that use SCA.

## Resolution

To resolve the issue, follow the steps in [How to find and enable missing Copilot button in Microsoft 365 apps](https://support.microsoft.com/office/how-to-find-and-enable-missing-copilot-button-in-microsoft-365-apps-c8482b93-4b96-4bb8-8ec9-5148f4d42441).

If the issue persists, ask your Microsoft 365 admin to make sure that:

- You're assigned a [license that supports Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-licensing#microsoft-365-copilot-license).
- Copilot isn't blocked by your organization's policies.
