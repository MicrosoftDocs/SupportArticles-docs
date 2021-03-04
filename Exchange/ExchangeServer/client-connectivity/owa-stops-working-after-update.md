---
title: OWA returns "Could not load file or assembly" error after a security update installed on Exchange Server
description: OWA/ECP stops working after installing a security update on Exchange server without elevated permissions.
author: batre
ms.author: v-matham
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.reviewer: batre; ninob
ms.custom: 
- Exchange Server
- CSSTroubleshoot
search.appverid:
- MET150
appliesto:
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
---

# OWA returns "Could not load file or assembly" error after a security update installed on Exchange Server

## Symptoms

After installing a security update on Exchange Server, users get the following error when trying to use Outlook Web Access (OWA):

> "Could not load file or assembly ‘Microsoft.Exchange.Common, Version=15.0.0.0 …”

![Server Error in ecp Application Could not load file or assembly Microsoft.Exchange.Common](./media/owa-stops-working-after-update/Could-not-load-file-or-assembly.png)

You might also see an HTTP 500 error when accessing OWA or the Exchange Control Panel (ECP).
These errors happen because the security update was not installed with elevated permissions.

## Resolution

Reinstall the security update with elevated permissions:

1. From the **Start** menu, type **cmd**.
1. Right-click **Command Prompt** from the search results, and then select **Run as administrator**.
1. If the **User Account Control** windows appears, verify that the default action is the one you want, and then select **Continue**.
1. Type the full path of the .msp file for the security update, and then press **Enter**.

If that doesn't solve the issue:

1. Launch the **Exchange Management Shell** as administrator.
1. Type the following commands, pressing **Enter** after each:

   > cd $exscripts;UpdateCas.ps1<br/>
   > cd $exscripts;UpdateConfigFiles.ps1

1. Restart the server.
