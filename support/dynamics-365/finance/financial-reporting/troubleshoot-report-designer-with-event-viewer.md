---
# required metadata

title: Troubleshoot report designer issues with Event Viewer
description: Describes how to use the Event Viewer to analyze some issues that occur when using Financial reporting in Microsoft Dynamics 365 Finance.
author: aprilolson
ms.date: 12/07/2023
ms.prod: 
ms.technology: 

# optional metadata

ms.search.form: FinancialReports
# ROBOTS: 
audience: Application User
# ms.devlang: 
ms.reviewer: twheeloc
# ms.tgt_pltfrm: 
ms.collection: get-started
ms.assetid: 3eae6dc3-ee06-4b6d-9e7d-1ee2c3b10339
ms.search.region: Global
# ms.search.industry: 
ms.author: aolson
ms.search.validFrom: 2016-02-28
ms.dyn365.ops.version: AX 7.0.0
---
# Troubleshoot report designer issues with Event Viewer

You can use Event Viewer to analyze connection issues that occur when using Financial reporting in Microsoft Dynamics 365 Finance.

The following steps walk through the process of turning on Event Viewer messages for Financial reporting. If you need to contact Microsoft Support for help with Financial reporting issues, submit copies of the logs that Event Viewer generates as they will help support engineers identify the source of the connection issue quickly.

1. Copy the [RegisterETW.zip](//download.microsoft.com/download/3/0/0/3008047d-ff50-45fa-8427-e4eddc517bd7/RegisterETW-c1a35291-6aa6-4462-a2bc-4ba117fd5f8e%20(3).zip) file to the client workstation (preferably the Desktop) and extract the file.
2. Make sure Windows Event Viewer is closed.
3. Open a Windows PowerShell command prompt as an administrator and go to the directory where *RegisterETW.ps1* is located.
4. Run the `.\RegisterETW.ps1` command.

    A successful output in PowerShell will be verified with the "Competed RegisterETW script" message.

    Reopen Event Viewer and you'll see these logs under **Microsoft** > **Dynamics**:

    - MR-Client
    - MR-DVT
    - MR-Integration
    - MR-Logger
    - MR-Reporting
    - MR_SchedulerTasks
    - MR-Sql
    - MR-TraceManager

5. Reproduce the issue in the Report Designer.
6. Export the MR-Logger events using Event Viewer.
