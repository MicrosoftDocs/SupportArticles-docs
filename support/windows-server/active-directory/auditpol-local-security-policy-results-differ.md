---
title: AuditPol and Local Security Policy results may differ
description: Fixes an issue where audit policy settings with AuditPol and the Local Security Policy (SECPOL.msc) show different results.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: keithpe, kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# AuditPol and Local Security Policy results may differ

This article helps fix an issue where audit policy settings with AuditPol and the Local Security Policy (SECPOL.msc) show different results.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2573113

## Symptoms

When viewing audit policy settings with AuditPol and the Local Security Policy (SECPOL.msc), the settings may show different results.

## Cause

AuditPol directly calls authorization APIs to implement the changes to the granular audit policy.  Secpol.msc manipulates the Local Group Policy Object, which results in writing the changes to %SYSTEMROOT%\system32\GroupPolicy\Machine\Microsoft\Windows NT\Audit\Audit.csv.  The settings saved to the .csv file aren't applied directly to the system at the time of modification, but are instead written to the file and read later by the client-side extension (CSE).  At the next group policy refresh cycle, the CSE applies the modifications that are present in the .csv file.

Secpol.msc displays what is set in the local GPO. There's no "effective settings" view in secpol.msc that will merge granular AuditPol settings and what is defined locally as seen with secpol.msc.

## Resolution

From an administrative command prompt, you can use AuditPol to view the defined auditing settings by running:

```console
auditpol /get /category:*
```

## More information

[Auditpol get](https://technet.microsoft.com/library/cc772576.aspx)
