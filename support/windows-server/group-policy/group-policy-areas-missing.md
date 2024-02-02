---
title: Some Group Policy areas are missing
description: Provides a solution to an issue where some Group Policy areas are missing from the Group Policy Editor.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
ms.subservice: group-policy
---
# Some Group Policy areas are missing from the Group Policy Editor

This article provides a solution to an issue where some Group Policy areas are missing from the Group Policy Editor.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 555218

## Symptoms

When you open the Group Policy Editor MMC snap-in tool, and focus on a local GPO or Active Directory-based one, some Group Policy areas that are expected to appear may not be found. These missing policy areas are different than the ones that are normally missing when you're focused on a local GPO.

## Cause

Each area of policy functionality is implemented by an MMC snap-in DLL that is registered by default on a standard Windows 2000, 2003 or XP installation. Occasionally those DLLs can be un-registered or removed and when that happens, the underlying group policy editing functionality they implement will not appear in the Group Policy editor UI.

## Resolution

To resolve this issue, re-register the appropriate MMC snap-in DLL that implements the missing functionality by issuing the following command at a Windows command prompt

```console
regsvr32 <snap-in DLL name>
```

By default, all of the Group Policy related MMC snap-in DLLs can be found in %systemroot%\system32.

The following lists the default Group Policy snap-in DLLs that you can re-register:

- Administrative Templates and Scripts: gptext.dll
- Folder Redirection: fde.dll
- Internet Explorer Maintenance: ieaksie.dll
- IP Security: ipsecsnp.dll
- Public Key and Software Restriction: certmgr.dll
- Remote Installation Services: rigpsnap.dll
- Security: wsecedit.dll
- Software Installation: appmgr.dll

## More information

When you focus on the local GPO with the MMC Group Policy Editor snap-in, it is normal that some policy areas that you would normally see when editing an Active Directory-based GPO are not present. This is expected behavior because the local GPO only supports a subset of the features in an Active Directory-based GPO. However, sometimes even when focused on Active Directory-based GPOs, some policy areas that should be present are missing. In that case, the most likely cause is missing registrations for the MMC snap-in DLLs that implement that functionality, and by re-registering the missing DLL and restarting the Group Policy Editor, the problem can be resolved.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
