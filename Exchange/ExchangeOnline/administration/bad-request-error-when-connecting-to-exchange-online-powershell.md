---
title: Bad Request when connecting to Exchange Online PowerShell
description: You cannot connect to Exchange Online PowerShell if the RemotePowerShellEnable parameter value is set to False.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: rroddy, v-six
appliesto: 
  - Exchange Online
  - MSfC O365-Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Bad Request error when you try to connect to Exchange Online PowerShell

_Original KB number:_ &nbsp; 4482720

## Symptoms

When you try to connect to Exchange Online PowerShell, you receive the following error message:

> New-PSSession: [outlook.office365.com] Connecting to remote server outlook.office365.com failed with the following error message: Bad Request For more information, see the about_Remote_Troubleshooting Help topic.

## Cause

This issue occurs if your account has the `RemotePowerShellEnabled` parameter value set to **False**.

## Resolution

To resolve this issue, have another administrator set the parameter value to **True** by running the following PowerShell command:

```powershell
Set-User -identity user@contoso.com -RemotePowerShellEnabled $True
```

> [!NOTE]
> Allow 15-20 minutes for the setting to fully take effect, and then try to connect to Exchange Online PowerShell again.
