---
title: Use GPOs to change default logon domain name
description: Describes how to use Group Policy Objects (GPOs) to change default logon domain name.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
ms.subservice: group-policy
---
# Use GPOs to change default logon domain name in the logon screen

This article describes how to use Group Policy Objects (GPOs) to change default logon domain name.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2908796

## Symptoms

In multi domain environment, there are scenarios where users consistently login to workstations that are joined to a different domain than that of the logged in user. By default the domain that the workstation is joined to is listed as the default domain name and other domain users have to always provide the user name as *domain\username* to login correctly. Also there are scenarios where the machine is domain joined but the logins are almost always happening with local user accounts (using .\username).

## Cause

Its a common mistake that users make to skip the domain name and unknowingly attempt to login to a different domain than theirs and result in failures. To avoid these problems and improve user experience, you may decide to choose a default logon domain name that is different from workstation domain name.

## Resolution

The following group policy setting is available in Windows Vista or later operating systems:

- Assign a default domain for logon

To enable default domain for logon, follow these steps:

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *gpedit.msc*, and then click **OK**.
3. Under **Computer Configuration**, expand **Administrative Settings**, expand **System**, and then click **Logon**.
4. In the right pane, double click the setting **Assign a default domain for logon** and choose **Enabled**.
5. Under **Options**, you may provide the name of the domain you want to be set as default

  > [!NOTE]
  > Use Group Policy Management console(GPMC.msc) to create a GPO and configure the settings at domain or OU level.

The **Assign a default domain for logon** group policy specifies a default logon domain that may be different domain than the machine joined domain. You can enable this policy setting and add the preferred domain name so that the default logon domain name will be set to the specified domain that may not be the machine joined domain. If you enable this policy and set the domain name as a period (.), once the policy is applied to the machine, users will see a period (.) as their default domain and unless users specify a domainname\username to login, all users will be treated as local users. (.\username)

> [!NOTE]
> Requirements: This policy is applicable to Windows Vista or later.
