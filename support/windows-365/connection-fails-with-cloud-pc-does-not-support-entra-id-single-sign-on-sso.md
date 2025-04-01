---
title: Connection fails with "Cloud PC does not support Entra ID single sign-on (SSO)."
description: Introduces how to resolve the connection failure with "Cloud PC does not support Entra ID single sign-on (SSO)."
audience: itpro
manager: dcscontentpm
ms.date: 04/02/2025
ms.reviewer: wincicuex, erikje
ms.topic: troubleshooting
---
# Connection fails with "Cloud PC does not support Entra ID single sign-on (SSO)."

A user authenticates on the sign in page. When the user tries to connect to the Cloud PC, the user might encounter the following message:

> Something went wrong.  
> Your Cloud PC does not support Entra ID single sign-on.

## Cause

This error commonly occurs when SSO is not enabled.

## Resolution

Windows 365 Link requires that [Single Sign-on is Enabled on the Cloud PC](/windows-365/link/requirements) it is connecting to.

To confirm the status of SSO on a Cloud PC, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Navigate to **Devices** > **Device onboarding** > **Windows 365** > **All Cloud PCs**.
3. Select **Columns** and select **Using single sign-on**.
4. Search the list for the Cloud PC in question by device name or the user's UPN.
5. If **Using single sign-on** shows **No**, then Windows 365 Link cannot connect to it.

## Reference

For details on how to enable SSO on Cloud PCs, see [Configure single sign-on for Windows 365 | Microsoft Learn](/windows-365/enterprise/configure-single-sign-on)
