---
title: Open Click-to-Run version of Office on a terminal server
description: Works around an issue that prevents you from opening the Click-to-Run version of an Office 2013 and Office 2016 program or suite. This issue occurs after you install the program or suite on a terminal server.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: offspms, andyfel
search.appverid: 
- MET150
appliesto:
- Office Professional Plus 2016
- Office Standard 2016
- Office Professional 2013
- Office Home and Business 2013
- Office Home and Student 2013
---

# Error when opening the Click-to-Run version of an Office program or suite on a terminal server

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Assume that you install the Click-to-Run version of a Microsoft Office program or suite on a terminal server. When you open the Office program or suite, you receive the following error message:

In Microsoft Office 2013:

"This copy of Microsoft Office 2013 cannot be used on a computer running Terminal Services. To use Office 2013 on a computer running Terminal Services, you must use a Volume License edition of Office."

In Microsoft Office 2016:

"This copy of Microsoft Office 2016 cannot be used on a computer running Terminal Services. To use Office 2016 on a computer running Terminal Services, you must use a Volume License edition of Office."

## Cause

This issue occurs because Click-to-Run versions of Office programs or suites running on a server with Remote Desktop Services (RDS), must have [Shared Computer Activation](https://docs.microsoft.com/deployoffice/overview-of-shared-computer-activation-for-office-365-proplus) enabled. Remote Desktop Services are formerly known as Terminal Services. Shared Computer Activation is only available for Microsoft 365 Apps. Other releases are not supported.

## Workaround

To work around this issue, do one of the following;

- For customers who have an Microsoft 365 Apps for enterprise license, install Office with shared computer activation. For more information about installing Microsoft 365 Apps for enterprise with shared computer activation, see [Deploy Microsoft 365 Apps for enterprise by using Remote Desktop Services](https://technet.microsoft.com/library/dn782858.aspx).   
- For all other versions of Office Click-to-Run, install an edition of the Office program or suite that uses a volume license key.   


## Status

This behavior is by design.
