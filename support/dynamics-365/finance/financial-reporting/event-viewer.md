---
# required metadata

title: Troubleshoot report designer issues with Event viewer
description: This article describes how you can use the Event viewer to analyze some of the issues that arise when using Financial reporting.
author: aprilolson
ms.date: 04/04/2023
ms.topic: article
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

# Troubleshoot report designer issues with Event viewer
Troubleshoot report designer issues with Event viewer
You can use the Event viewer to analyze some of the issues that arise when using Financial reporting. 

## Symptoms

### What happens when you have connections issues with Financial reporting? 

Here are some steps you can take to make your conversation with Microsoft support more effective and bring you to a quicker resolution. 
 
The following steps walk through the process of turning on Event viewer messages for Financial reporting. The logs that Event viewer generates will help support engineers to identify the source of the connection 
issue quickly. Submit copies of these logs together with your ticket when contacting support.


1. Copy the RegisterETW.zip file to the client workstation (preferably the Desktop) and extract [RegisterETW.zip](//download.microsoft.com/download/3/0/0/3008047d-ff50-45fa-8427-e4eddc517bd7/RegisterETW-c1a35291-6aa6-4462-a2bc-4ba117fd5f8e%20(3).zip).
2. Make sure Windows Event viewer is closed.
3. Open an Administrator PowerShell command prompt and go to the directory where RegisterETW.ps1 is located.
4. Run the following command: .\RegisterETW.ps1 

    A successful output in PowerShell will be verified with the message, **Competed RegisterETW script**.

    Re-open Event viewer and you will now see these logs under **Microsoft > Dynamics**: 

    * MR-Client
    * MR-DVT
    * MR-Integration
    * MR-Logger
    * MR-Reporting
    * MR_SchedulerTasks
    * MR-Sql
    * MR-TraceManager

5. Reproduce the issue in the report designer.
6. Export the MR-Logger events using the Event viewer.

