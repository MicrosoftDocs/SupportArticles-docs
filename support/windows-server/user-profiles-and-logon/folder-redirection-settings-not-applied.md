---
title: Folder Redirection settings aren't applied
description: Provides a solution to an issue where folders aren't redirected after you configure Folder redirection.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, lindakup
ms.custom: sap:folder-redirection, csstroubleshoot
---
# Folder Redirection settings aren't applied

This article provides a solution to an issue where folders aren't redirected after you configure Folder redirection.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2811384

## Symptoms

Scenario:

The Group policy is configured: Computer Configuration\Administrative Templates\windows Explorer - " Verify Old and New folder redirection targets point to the same share before redirecting" is Enabled to prevent data loss.

You configure Folder redirection for users to redirect multiple folders to a file server. For example:

Appdata - > Local profile
Documents -> `\\filer1\<username>`
Music -> `\\filer1\<username>\My Music`
Pictures -> `\\filer1\<username>\My Pictures`
Videos -> `\\filer1\<username>\My Videos`
Contacts -> `\\filer1\<username>\Contacts`
 Links -> `\\filer1\<username>\Links`
Downloads -> `\\filer1\<username>\Downloads`

After logon, only some folders are redirected but others are not. For example, the contact folder may be redirected but no others. The behavior of which folder gets redirected is inconsistent as well.

The problem happens regardless if the user previously had redirected folders or not.

If you Disable the GPO setting "Verify Old and New folder redirection targets..." the FR works as expected.

## Cause

The problem is caused by a code defect in the FR component.

## Resolution

To resolve the problem install Windows 7 Service Pack 1 or apply the hotfix from KB977229 - [https://support.microsoft.com/kb/977229](https://support.microsoft.com/help/977229)
