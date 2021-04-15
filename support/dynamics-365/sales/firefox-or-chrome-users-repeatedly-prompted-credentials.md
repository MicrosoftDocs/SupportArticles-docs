---
title: Firefox or Chrome users are repeatedly prompted for credentials in Microsoft Dynamics CRM 2011
description: This article describes the resolution for issues pertaining to multiple sign-in prompts when using Firefox or Chrome to access Microsoft Dynamics CRM 2011 post Update Rollup 9.
ms.reviewer: matp
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Firefox or Chrome users are repeatedly prompted for credentials in Microsoft Dynamics CRM 2011

This article provides the resolution for issues pertaining to multiple sign-in prompts when using Firefox or Chrome to access Microsoft Dynamics CRM 2011 post Update Rollup 9.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2709891

## Symptoms

Users are repeatedly prompted to sign in even though they have successfully signed in previously when they use the Firefox or Chrome web browser.

This issue occurs when the following conditions are true:

- The web browser is connecting to a Microsoft Dynamics CRM Server that uses AD FS 2.0 for claims-based authentication. Claims-based authentication is required for an Internet-facing deployment (IFD).
- The web browser that used to access Microsoft Dynamics CRM 2011 is Firefox or Chrome.

## Cause

This issue occurs because of the Windows operating system feature Extended Protection for Authentication. For more information about this security feature, see [Microsoft Security Advisory (973811)](https://go.microsoft.com/fwlink/p/?linkid=248883).

## Resolution

> [!WARNING]
> The following steps disable Extended Protection for Authentication. This feature can help reduce the risk for "man in the middle" kinds of attacks. For more information about this feature and the protection it provides for credential handling, see [Microsoft Security Advisory (973811)](https://go.microsoft.com/fwlink/p/?linkid=248883).

The following steps disable the Extended Protection for Authentication feature on the computer running Firefox or Chrome.

1. On the computer where the web browser is experiencing the issue, start Registry Editor (`regedit`), and locate the following subkey.

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa`

2. In the `Lsa` subkey, locate the `SuppressExtendedProtection` value. If the value doesn't exist, you must add it. To add the value, right-click `Lsa`, point to **New**, and then click **DWORD (32-bit) Value**. Type `SuppressExtendedProtection`, and then press ENTER.

3. Right-click `SuppressExtendedProtection`, click **Modify**, and enter **1** (REG_DWORD).
4. Click **OK** and close Registry Editor.
5. Repeat for each computer that experiences the issue when you run Firefox or Chrome and Microsoft Dynamics CRM.

After the change is made, the following behavior occurs.

- Chrome web browsers will no longer continue to prompt after the initial sign in.
- Firefox web browsers will prompt up to two additional occasions after the initial sign in.

Alternatively, you can disable the Extended Protection for Authentication feature in AD FS 2.0. Notice that disabling Extended Protection for Authentication feature in AD FS 2.0 will disable the feature for all clients that are authenticated by the federation server. For more information about how to disable the Extended Protection for Authentication feature on the AD FS 2.0 federation server, see [Configuring Advanced Options for AD FS 2.0](https://go.microsoft.com/fwlink/p/?linkid=248886). For more information about this issue when using Office 365, see [A federated user is repeatedly prompted for credentials when they connect to the AD FS 2.0 service endpoint during Office 365 sign-in](https://go.microsoft.com/fwlink/p/?linkid=248885).

## More information

Cross browser support for Mozilla Firefox and Google Chrome was introduced in Update Rollup 12 for Microsoft Dynamics CRM 2011. Prior versions of Microsoft Dynamics CRM 2011 do not support cross browser platforms.

Mozilla Firefox users may also experience a prompt for credentials when using Windows Integrated Authentication. For more information regarding this symptom, see the following article:

[Microsoft Dynamics CRM 2011 Integrated Authentication with Firefox in Update Rollup 12](https://support.microsoft.com/help/2786247)
