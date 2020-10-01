---
title: ADWS service crashes after you upgrade 
description: Describes an issue in which the Active Directory Web Services service crashes upon start. This issue occurs after you perform an in-place upgrade.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, lindakup, jCaudill
ms.prod-support-area-path: Active Directory database issues and domain controller boot failures
ms.technology: ActiveDirectory
---
# ADWS service crashes after you upgrade

This article provides a resolution for the issue Active Directory Web Services (ADWS) service crashes after you upgrade.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3019069

## Symptoms

After you perform an in-place upgrade of a Windows Server 2008 R2 domain controller to Windows Server 2012 R2, the Active Directory Web Services (ADWS) service crashes upon start.

When this issue occurs, the following event is logged in the System log.

## Cause

This is a known issue concerning the product.

## Resolution

To resolve this issue, reinstall [the Microsoft .NET Framework 4.5.2 package](https://www.microsoft.com/download/details.aspx?id=42642).
