---
title: Credential limit per app
description: Troubleshoot an issue where only 20 credentials can be used per app.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, helohr, femila, v-lianna
ms.custom:
- sap:remote desktop services and terminal services\session connectivity
- pcy:WinComm User Experience
---
# Credential limit per app

Windows only allows up to 20 credentials per app. If you need to have more than 20 credentials per app, follow the instructions in this article.

## Bypass the 20 credential limit

To bypass the 20 credential limit:

1. Open PowerShell as an administrator.
2. Set the `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Vault\MaxPerAppCredentialNumber` DWORD registry entry value to a number greater than 20.
3. Restart your machine.
4. Test out your settings by creating a new set of credentials in the Remote Desktop client.

## Potential risks

When changing this registry setting, it's important to keep these things in mind:

- This is an admin operation. Any errors introduced into the registry could cause your machine to become unstable. Users should change the registry entries at their own risk.
- This registry change will affect all apps on your machine.
