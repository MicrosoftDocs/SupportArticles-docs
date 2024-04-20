---
title: Error 0xCAA5001C Token broker operation failed
description: Resolves an 0xCAA5001C error that occurs when you access Microsoft Store for Business on a Windows 10-based computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:User Logon and Profiles\Service Account and Interactive User Logon Issues and Credential Providers, csstroubleshoot
---
# Event 1098: Error: 0xCAA5001C Token broker operation failed in Windows 10

This article provides help to solve an 0xCAA5001C error that occurs when you access Microsoft Store for Business on a Windows 10-based computer.

_Applies to:_ &nbsp; Windows 10, version 1903, Windows 10, version 1809, Windows 10, version 1709  
_Original KB number:_ &nbsp; 3196528

## Symptoms

After you log on to a Windows 10-based computer, you try to access Microsoft Store for Business. However, Microsoft Entra authentication fails, and some events are logged in the Microsoft-Windows-AAD/Operational log.

In addition to Microsoft Store for Business, this issue may affect Enterprise State Roaming.

## Cause

This issue occurs if there are missing permissions or ownership attributes on one or both of the following registry keys:

- `HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\ Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\PSR`

- `HKEY_USERS\S-1-5-21-299502267-1950408961-849522115-1818\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion \AppModel\SystemAppData\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\PSR`

> [!NOTE]
> Match the SID reported for the user in event ID 1098 to the path under HKEY_USERS. In this example, it is S-1-5-21-299502267-1950408961-849522115-1818.

## Resolution

To resolve this issue, follow these steps:

1. Take ownership of the key if necessary (Owner = SYSTEM).
2. Fix the permissions on these registry keys by enabling inheritance (fixing one should fix both, unless multiple users log on to the same device):
    - `HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\ Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\PSR`
    - `HKEY_USERS\S-1-5-21-299502267-1950408961-849522115-1818\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion \AppModel\SystemAppData\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\PSR`

|Type|Principal|Access|Inherited from|Applies to|
|---|---|---|---|---|
|Allow|S-1-15-2-1910091885-1573563583-1104941280-2418270861-3411158377-2822700936-2990310272|Query Value|None|This key only|
|Allow|SYSTEM|Full Control|CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData|This key and subkeys|
|Allow|Domain User Account (`user@contoso.com`)|Full Control|CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData|This key and subkeys|
|Allow|Administrators (COMPUTER\Administrators)|Full Control|CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData|This key and subkeys|
|Allow|CREATOR OWNER|Full Control|CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData|Subkeys only|

> [!NOTE]
> If you view the permissions of the ~\PSR registry key under HKEY_USERS\{SID}, the **Inherited from** field shows inheritance from the HKEY_USERS\{SID} path.

If this does not resolve the issue, consider running [Process Monitor](/sysinternals/downloads/procmon) while performing the authentication method to look for ACCESS DENIED in other areas of the registry or file system that could be causing the authentication failure. If you discover any, add them to this article.
