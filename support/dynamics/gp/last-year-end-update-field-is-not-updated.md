---
title: Last Year-End Update field isn't updated
description: Provides a solution to an issue where the date in the Last Year-End Update field isn't updated after you install the Payroll Year-End Update for Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The date in the Last Year-End Update field isn't updated after you install the Payroll Year-End Update for Microsoft Dynamics GP

This article provides a solution to an issue where the date in the Last Year-End Update field isn't updated after you install the Payroll Year-End Update for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 981312

## Symptom

After you install the Payroll Year-End Update for Microsoft Dynamics GP, the **Last Year-End Update** field in the Payroll Setup window or in the Payroll Reset Files-Canada window doesn't display the correct date according to the installation document for the Payroll Year-End Update.

## Cause 1

This problem occurs because some Windows Terminal Server deployments or Citrix environments have only a single installation of Microsoft Dynamics GP that is accessed by several client computers. Each client computer has a Dex.ini file that is located in the Windows folder. The Last Year-End Update field contains a date that is obtained from the Dex.ini file. A year-end update installed on the server may not update the date in the Dex.ini file on each client computer. It causes the Last Year-End Update field to display an incorrect date.

## Cause 2

If you've the Support Debugging Tool for Microsoft Dynamics GP loaded, it will centralize the Dex.ini file and doesn't allow it to be updated.

## Resolution

To resolve this issue, follow these steps:

1. In Microsoft Dynamics GP, select the **Help** menu, and then select **About Microsoft Dynamics GP**.
2. In the **Version Information** section, note the version number for Microsoft Dynamics GP, and then verify that the version number is updated according to the version number for the update that is installed. This step is necessary to determine whether new code from the Year-End Update for Microsoft Dynamics GP installed. The new code is installed if the Microsoft Dynamics GP version is incremented correctly.

    For more information about the correct version number for the current release or for a previous release for Microsoft Dynamics GP, select the Microsoft Dynamics GP directory link below and select the **US TAXES** link under the Microsoft Dynamics GP version you need.

    > [!NOTE]
    > After you've accessed the U.S. Payroll Tax Update page for the version you need, download the year-end pdf document for more details around year-end processes, checklists, dates and other helpful information. The year-end pdf document contains the up to date Last Tax Update Date and Last Year End Update dates to refer to in the steps below.

3. The date shown in the Year-End Update field must be manually changed in the Dex.ini file. To do it, locate the Dex.ini file on the client computer. The Dex.ini file is typically located in the following folders:

    `C:\Program Files\Microsoft Dynamics\GP\Data`
4. Right-click the Dex.ini file, point to **Open With**, and then select **Notepad**.
5. Locate the following dates in the Dex.ini file depending on if you've US Payroll or Canadian Payroll installed:

    US Payroll:
    LastYearEndUpdate= **MM/DD/YYYY**  
    LastTaxCodeUpdate= **MM/DD/YYYY**  

    Canadian Payroll:
    CPRLastTaxUpdate= **MM/DD/YYYY**  
    CPRLastYearEndUpdate= **MM/DD/YYYY**  

6. Manually correct the date that appears in the year-end update date line:
   - US Payroll: LastYearEndUpdate=
   - Canadian Payroll: CPRLastYearEndUpdate=

    > [!NOTE]
    >
    > - See the installation document for the Payroll Year-End Update in Microsoft Dynamics GP (refer to the links above) to verify the correct date for the corresponding Year-End Update date field.
    > - The **LastTaxCodeUpdate**  date was updated after you install a tax code update in the past where Dynamics dexterity code is updated versus just tax tables.

7. On the **File** menu, select **Save**.
8. Close the Dex.ini file.
9. Repeat these steps on each client computer where the Dex.ini file has to be changed.
    > [!NOTE]
    > Make sure that the user has Read, Write, and Execute permissions to the Microsoft Dynamics GP code folder on each client computer and any shared files such as the Reports.dic or Forms.dic files. By default, Microsoft Dynamics GP is installed in the following folder: `C:\Program Files\Microsoft Dynamics\GP`

## More information

For more information about the tax fields and year-end update fields in US Payroll in Microsoft Dynamics GP, see
[Information about the tax fields and year-end update fields in Payroll in Microsoft Dynamics GP](https://support.microsoft.com/help/949154).
