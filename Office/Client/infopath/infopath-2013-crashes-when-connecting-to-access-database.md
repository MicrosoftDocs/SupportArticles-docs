---
title: InfoPath 2013 crashes when you connect to an Access database
description: Describes an issue in which InfoPath 2013 crashes when you connect to the Access database, and provides a workaround.
author: helenclu
ms.author: luche
ms.reviewer: warrenr
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - InfoPath 2013
ms.date: 03/31/2022
---

# InfoPath 2013 crashes when you connect to an Access database

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

Assume that you have a Microsoft InfoPath form that connects to an Access database. After you move to Office 2016 and Access 2016 is installed, InfoPath 2013 crashes when you connect to the Access database.

## Workaround

To work around this issue, do the following steps:

1. Install the Windows Installer version of Office 2013 or Click to Run (C2R) version of Office 2016.
1. Run the Access application before you use the InfoPath form.
