---
title: Local policy doesn't permit you to log on interactively
description: Provides a resolution to an issue where Local Policy does not permit you to log on interactively.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# Local policy doesn't permit you to log on interactively

This article provides a resolution to an issue where Local Policy doesn't permit you to log on interactively.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 186529

## Symptoms

By default, the group called Everyone has the right to log on locally on a Terminal Server. It means that any user should be able to log on at the Terminal Server console. It is different from a normal Windows NT Server, where the default would be that only the administrator can log on locally. When clients connect to a Terminal Server, they are actually using the Terminal Server console. That is the reason for the different default right.

## Resolution

If you want to limit this right, create a group specifically for your Terminal Server Clients, and grant this group the right to log on locally. You can then remove the Everyone group, limiting console logon rights to the Client group and the administrator.

### If a client or a user at the console gets the error

Local policy of this system doesn't permit you to log on interactively, so that user doesn't have the right to log on locally.

To grant or remove the right to log on locally, follow these steps:

1. Start User Manager for Domains.
2. Click **Policies**, then click **User Rights**.
3. In the **Rights** field, select **Log On Locally**.
4. In the **Grant To** field, select the users and/or groups you want to have this right.  

> [!NOTE]
> You will also see this error if you modify a user's configuration in User Manager by de-selecting the **Allow Logon to Terminal Server** checkbox.

> [!NOTE]
> If you install a Terminal Server as a backup domain controller, and the current primary domain controller's policy is set so that users do not have the right to log on locally, then the new Terminal Server inherits that policy. The result will be that no clients can connect to the Terminal Server. If a Terminal Server is a domain controller, the entire domain MUST use have a policy allowing users to log on locally.
