---
title: Connection fails with "Failed to open a Microsoft Entra ID credential prompt."
description: Introduces how to resolve the connection failure with "Failed to open a Microsoft Entra ID credential prompt."
audience: itpro
manager: dcscontentpm
ms.date: 04/02/2025
ms.reviewer: wincicuex, erikje
ms.topic: troubleshooting
---
# Windows 365 Link connection fails with "Failed to open a Microsoft Entra ID credential prompt."

After a user authenticates on the Sign in page, when the user tries to connect to the Cloud PC, the user might encounter the following message:

> Connection Denied.  
> Failed to open a Microsoft Entra ID credential prompt. This can happen in SSO-enabled Cloud PCs if this is the first time you are connecting to it, or if you first connected 30 days ago. Connect to your Cloud PC on another device and then try again.

## Cause

This error commonly occurs when Single Sign-on (SSO) consent required.

When a user connects to a Cloud PC that has SSO enabled, the user might be prompted for consent to use the authentication token. This can happen under several conditions:

* The Cloud PC is newly provisioned.
* The Cloud PC is reprovisioned.
* The Cloud PC just has SSO enabled.
* It's been 30 days since the last time consent was given.

If any of these conditions are true, the next time a user attempts to sign-in, consent are required via an Interactive Prompt. However, because Link uses a non-interactive SSO connection, the prompt can't be shown on Windows 365 Link, resulting in the error message.

## Workaround

As a workaround, the user could connect to this Cloud PC from a different device or the [Web Client](https://windows365.microsoft.com) where the prompt can be acknowledged. However, the prompt returns every 30 days.

For configuration details on how to prevent this issue, see [Suppress single sign-on consent prompts for Windows 365 Link](/windows-365/link/single-sign-on-suppress)
