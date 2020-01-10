---
title: Can't force Modern Authentication when using Connect-SPOService cmdlet in SharePoint Online Management Shell
description: Describes an issue in which you can't force Modern Authentication when using Connect-SPOService cmdlet in SharePoint Online Management Shell.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# Cannot force Modern Authentication when using Connect-SPOService cmdlet in SharePoint Online Management Shell

## Problem

You can't force Modern Authentication when you use the Connect-SPOService cmdlet in Microsoft SharePoint Online Management Shell, unless you add an undocumented registry key to your client computer.

## Cause

This issue can occur if you added an Active Directory Federation Services (ADFS) claim rule to block legacy authentication requests when these requests don't originate from your expected IP range. The Connect-SPOService cmdlet uses legacy authentication but doesn't pass along the IP range information, so the cmdlet is blocked.

## Solution/Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, add the following registry subkey on the client computer to force Modern Authentication.

[HKEY_CURRENT_USER\Software\Microsoft\SPO\CMDLETS]

"**ForceOAuth**" = dword:**00000001**

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
