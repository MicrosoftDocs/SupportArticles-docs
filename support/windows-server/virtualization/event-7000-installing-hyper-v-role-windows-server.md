---
title: Event 7000 after installing the Hyper-V role in Windows Server
description: This article describes Event 7000 that is logged by the VMSP service after you install the Hyper-V role in Windows Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installation-and-configuration-of-hyper-v, csstroubleshoot
ms.subservice: hyper-v
---
# Event 7000 after installing the Hyper-V role in Windows Server

This article describes Event ID 7000 that's logged by the VMSP service after you install the Hyper-V role.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 1909, Windows 10, version 1903, Windows Server 2019  
_Original KB number:_ &nbsp; 4483865

## Symptoms

After you install the Hyper-V role in Windows Server, version 1903, Windows Server, version 1909 and Windows Server 2019 and then restart the system to complete the role installation, the virtual machine security process (VMSP) logs the following error message in Event Viewer:

> Log Name: System  
Source: Service Control Manager  
Event ID: 7000  
Level: Error  
Description: "The VMSP service failed to start due to the following error: A device attached to the system is not functioning."

## More information

You can safely ignore this error message. There are no errors that are related to the VMSP, which is installed after you install the Hyper-V role. Although the error message is logged, there is no loss in  the functionality of the virtual switch.
