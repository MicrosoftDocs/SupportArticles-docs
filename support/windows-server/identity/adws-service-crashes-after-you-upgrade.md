---
title: ADWS service crashes after upgrade
description: Describes an issue in which the Active Directory Web Services service crashes upon start. This issue occurs after you perform an in-place upgrade.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, lindakup, jCaudill
ms.custom: sap:active-directory-database-issues-and-domain-controller-boot-failures, csstroubleshoot
---
# ADWS service crashes after you upgrade

This article provides a resolution to an issue where Active Directory Web Services (ADWS) service crashes after you upgrade.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3019069

## Symptoms

After you perform an in-place upgrade of a Microsoft Windows Server 2008 R2 domain controller to Windows Server 2012 R2, the Active Directory Web Services (ADWS) service crashes upon start.

## Cause

This is a known issue concerning the product.

## Resolution

To resolve this issue, reinstall [the Microsoft .NET Framework 4.5.2 package](https://www.microsoft.com/download/details.aspx?id=42642).
