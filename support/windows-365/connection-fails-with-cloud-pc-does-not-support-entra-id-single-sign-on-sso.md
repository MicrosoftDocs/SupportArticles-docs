---
title: Connection Fails with Cloud PC Does Not Support Entra ID Single Sign-on
description: Introduces how to resolve the connection failure with the Cloud PC does not support Entra ID single sign-on error.
audience: itpro
manager: dcscontentpm
ms.date: 04/02/2025
ms.reviewer: wincicuex, erikje
ms.topic: troubleshooting
---
# Windows 365 Link connection fails with "Cloud PC does not support Entra ID single sign-on"

After a user authenticates on the sign-in page, when the user tries to connect to the Cloud PC, the user might encounter the following message:

> Something went wrong.  
> Your Cloud PC does not support Entra ID single sign-on.

## Cause

This error commonly occurs when single sign-on (SSO) isn't enabled.

## Resolution

Windows 365 Link requires that [SSO is enabled on the Cloud PC](/windows-365/link/requirements) it connects to.

To confirm the status of SSO on the Cloud PC, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Navigate to **Devices** > **Device onboarding** > **Windows 365** > **All Cloud PCs**.
3. Select **Columns** > **Using single sign-on**.
4. Search the list for the Cloud PC in question by device name or the user's User Principal Name (UPN).
5. If **Using single sign-on** shows **No**, Windows 365 Link can't connect to it.

## Reference

For details on how to enable SSO on Cloud PCs, see [Configure single sign-on for Windows 365 using Microsoft Entra authentication](/windows-365/enterprise/configure-single-sign-on).
