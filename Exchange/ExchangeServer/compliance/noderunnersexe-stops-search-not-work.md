---
title: Search doesn't work when the NodeRunner.exe process stops in Exchange Server 2013
description: Describes an issue that prevents search functionality from working in Exchange Server 2013. It occurs when the NodeRunner.exe process stops running. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Messaging Policy and Compliance\Issues with eDiscovery, import/export of mailbox
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nthonge; excontent; jmartin, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Search doesn't work in Exchange Server 2013 when the NodeRunner.exe process stops

_Original KB number:_ &nbsp;3094698

## Symptoms

When this issue occurs, you may experience the following symptoms.

### Symptom 1

The Content Index State on all mailbox databases is **FailedAndSuspended**.

### Symptom 2

A message is logged in the Unified Logging System (ULS) logs.

> [!NOTE]
> By default, Exchange ULS log files are saved in the following location:
*C:\Program Files\Microsoft\Exchange Server\V15\Logging\Search*

### Symptom 3

The NodeRunner.exe process throws an exception when it tries to allocate more memory than the available memory. Errors are logged.

## Cause

This issue occurs when the NodeRunners.exe process stops because of an **OutOfMemory** exception. Either the server is out of memory or the .NET Framework common language runtime (CLR) is forcing a memory allocation limitation on the NodeRunners.exe process. In this situation, NodeRunner.exe tries unsuccessfully to allocate more memory, generates an exception, and then stops.

## Resolution

To fix this issue, follow these steps:

1. Locate the Noderunner.exe.config file. By default, this file is located along the following path:

    *C:\Program Files\Microsoft Office Servers\15.0\Search\Runtime\1.0\noderunner.exe.config*

1. Edit the file, and then locate the following key:

    `<nodeRunnerSettings memoryLimitMegabytes="<value>" />`

1. If the value of the key is set to any value other than *0*, change it to *0*, as follows:

    `<nodeRunnerSettings memoryLimitMegabytes="0" />`

1. Restart the Microsoft Exchange Host Controller Service.

## About the NodeRunner.exe process

Microsoft Exchange Host Controller Service starts four worker processes, and each is named NodeRunner.exe. NodeRunner.exe is part of the Exchange search component. The individual functionality of each NodeRunner.exe process is set through configuration. The NodeRunner.exe process that starts single Admin node is a process of its own. Because NodeRunner.exe is a stand-alone process, it derives some of its operating properties from the NodeRunner.exe.config application configuration file during the start of the Admin node.

The following screenshot shows the four nodes of the NodeRunner.exe process: Admin, Content, Query, and Index.

:::image type="content" source="media/noderunnersexe-stops-search-not-work/noderunnerexe-process-nodes.png" alt-text="Screenshot of the four nodes of NodeRunner.exe process.":::

If you're familiar with SharePoint Server, you probably know how to limit the memory that's allocated to the NodeRunner.exe process by using the application configuration file. However, it's unsupported in Exchange Server 2013 to limit memory allocation for NodeRunner.exe by this method.

The default setting for the minimum memory requirement for NodeRunner.exe is **0**. The NodeRunner.exe process consumes and changes its memory requirements dynamically, based on current requirements and available memory. However, you can set the upper limit and restrict the volume of memory that Node Runner can access by using the **memoryLimitMegabytes** parameter in the NodeRunner.exe.config file. If you limit memory usage by NodeRunner.exe, and if the Exchange server can't allocate memory for the NodeRunner.exe operation, the operation may fail with an **OutOfMemoryException** exception.
