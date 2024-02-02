---
title: Windows Server stops responding when signing in using a custom account
description: Helps resolve an issue in which Windows Server stops responding when signing in by using a custom account that has an auto-start service.
ms.date: 11/23/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, jasone, v-lianna
ms.custom: sap:system-hang, csstroubleshoot, ikb2lmc
ms.subservice: performance
---
# Windows Server stops responding during the sign-in process of a custom account

This article helps resolve an issue in which Windows Server stops responding when you use a custom account that has an auto-start service to sign in.

When you use a custom account to sign in to Windows Server, the system stops responding:

- During the sign-in process.
- On the **Applying user settings** screen.
- On the **Getting devices ready** screen.
- On a gray screen.

This issue occurs when the following conditions are true:

- The **Delete user profiles older than a specified number of days on system restart** group policy is configured and enabled.
- There are profiles that meet the cleanup requirements of the group policy.
- The system has components that have registered for profile deletion notifications. And at least one component is making a call (direct or indirect) that needs to acquire data from the Service Control Manager (SCM) components. For example, start, stop, or query information about a service.
- A service is configured to start automatically for a custom account but not a built-in account.

This issue is fixed in Windows Server 2016 and later versions.

To work around this issue, disable the **Delete user profiles older than a specified number of days on system restart** group policy. If you want to clean up profiles, configure a scheduled task or script instead of the group policy. 
