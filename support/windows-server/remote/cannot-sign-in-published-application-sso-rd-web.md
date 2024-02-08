---
title: Can't sign in to a published application with SSO through RD Web
description: Helps resolve an issue in which you fail to sign in to a published application with single sign-on (SSO) through Remote Desktop Web (RD Web).
ms.date: 06/16/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, garymu, v-lianna
ms.custom: sap:rdweb, csstroubleshoot
---
# Can't sign in to a published application with SSO through RD Web

This article helps resolve an issue in which you fail to sign in to a published application with single sign-on (SSO) through Remote Desktop Web (RD Web).

When you use SSO to sign in to a published application through RD Web, you fail to sign in and receive a message stating that your username and password are incorrect.

This issue occurs because you have recently changed your password and configured the following registry value on the Remote Desktop Session Host server with which the connection is established.

Registry path: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI`  
Value name: **ForceSilentTSAutoLogon**  
Value type: **REG_DWORD**  
Value data: **1**

The registry value configuration disables the user interface (UI) components that allow prompting for new credentials. The credentials used to establish the connection can't be refreshed with the latest information.

You can try one or more of the following methods to resolve the issue:

- Lock and then unlock your workstation with the new credentials.
- Sign out of the RD Web site and reconnect it with the new credentials.
- Sign out of and sign in to your workstation again with the new credentials.
- Update or remove those credentials if they're stored in the Windows Vault.
