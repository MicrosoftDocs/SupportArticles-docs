---
title: Report generation process stops responding
description: Fixes an issue that the report generation process may stop responding when you run Perfmon.exe with the Active Directory Diagnostics template to generate a report.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, gregue
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# The report generation process may stop responding when you run Perfmon.exe with the Active Directory Diagnostics template to generate a report on a domain controller

This article provides help to fix an issue where the report generation process stops responding when you run Perfmon.exe with the Active Directory Diagnostics template to generate a report.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 971714

## Symptoms

When you run Perfmon.exe with the Active Directory Diagnostics template to generate a report on a Windows Server domain controller, the process may stop responding.

## Cause

This issue occurs because the Reliability and Performance Monitor (Perfmon.exe) console that is running the TraceRpt.exe tool consumes too much memory and CPU resources during the report generation process. If the Windows Server is busy and lacks resources, the report generation process will stop responding.

## Resolution

To resolve this issue, copy your files to a different computer that has same server role and that has enough hardware resources. Then, run TraceRpt.exe with the files. To do this, follow these steps:

1. In the Reliability and Performance Monitor (Perfmon.exe) console, click **Data Collector Sets**, and then click **System**.
2. Right-click **Active Directory Diagnostics**, and then click **Start**. The file collection process starts on the Windows Server domain controller.
3. After the report status changes to **generating report** from **collecting data for**\<time>**, copy the files to the second Windows Server domain controller.

    > [!NOTE]
    > You can find the files at the following location: %systemdrive%\Perflogs\ADDS\ **date report generation run** \\*
    >
    > Ths "-df" switch is to specify the Microsoft specific counting/reporting schema file that is generated with the Perfmon. This file name is named report.xsl
4. Locate the files, and then run the following command at the command line on the second Windows Server domain controller:

    ```console
    tracerpt *.blg *.etl -df *PerfmonSchemaFileName.xsl* -report *your_report.html* -f html **** ****
    ```

5. Use Windows Internet Explorer to view the .html file that is generated.
