---
title: Diagnose AD replication failures
description: Describes how to diagnose Active Directory replication failures.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Diagnose Active Directory replication failures

This article describes how to diagnose Active Directory replication failures.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2498185

## Symptoms

You may notice that Active Directory fails to replicate in the following conditions:

- The Repadmin monitoring tool exposes replication failures.
- Administrators, users, or applications detect that objects that are created and changed in Active Directory don't exist on all domain controllers (DCs) in a common replication scope.

## Cause

Active Directory Domain Services (AD DS) replication has the following dependencies:

- Network connectivity over the ports and protocols that are used by the ADDS service
- DNS name resolution to resolve the name of a replication partner to its IP address
- Authentication and authorization
- Time accuracy within 5 minutes to support Kerberos authentication
- The directory database
- The Active Directory replication topology to build connection objects between replication partners
- The ADDS replication engine

## Resolution

Use either of the following methods to view replications errors:

- Download and run the [Microsoft Support and Recovery Assistant tool](https://aka.ms/sara-adreplication).
- Read the replication status in the `repadmin /showrepl` output.

  - `Repadmin` is part of Remote Server Administrator Tools (RSAT). If you're using Windows 10, version 1803 or an earlier version of Windows, download [Remote Server Administration Tools (RSAT)](https://www.microsoft.com/download/details.aspx?id=45520).
  
  - In Windows 10, version 1809 and later version of Windows 10, you can install the RSAT feature through **Settings** > **Manage optional features**.

### Use repadmin to identify forest-wide Active Directory replication errors

You can create a Microsoft Excel spreadsheet for domain controllers by using the `repadmin/showrepl` command to view replication errors. To do it, follow these steps:

1. Open a Command Prompt as an administrator:

    On the **Start** menu, right-click **Command Prompt**, and then select **Run as administrator**. If the **User Account Control** dialog box appears, provide Enterprise Admins credentials, and then select **Continue**.

2. At the command prompt, type the following command, and then press Enter:

    ```console
    repadmin /showrepl * /csv >showrepl.csv
    ```

3. In Excel, open showrepl.csv.

4. Format the spreadsheet as follows:

   1. Hide or delete column A and column G.
   2. Select row 1 underneath the column header row. On the **View** tab, select **Freeze Panes** > **Freeze Top Row**.
   3. Select the whole spreadsheet. On the **Data** tab, select **Filter**.
   4. In the **Last Success Time** column, select the down arrow, point to **Text Filters**, and then select **Custom Filter**.
   5. Sort the table from oldest to newest.
   6. In the **Source DC** or **Source DSA** column, select the filter down arrow, point to **Text Filters**, and then select **Custom Filter**.
   7. In the **Custom AutoFilter** dialog box, under **Show rows where**, select **does not contain**. In the adjacent text box, type *del* to eliminate deleted domain controllers from the view.
   8. Repeat step 6 for the **Last Failure Time** column, but use the value **does not equal**, and then type the value **0**.

5. To fix any replication failures that appear under **Last Failure Status**, see [How to troubleshoot common Active Directory replication errors](https://support.microsoft.com/help/3108513/how-to-troubleshoot-common-active-directory-replication-errors).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
