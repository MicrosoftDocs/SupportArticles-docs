---
title: Report not found problem starting up report error when you try to print a modified copy of a modified report
description: Describes an error that occurs when you try to print a modified copy of a modified report.
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message when you try to print a modified copy of a modified report: "Report not found, problem starting up report"

This article describes an error that occurs when you try to print a modified copy of a modified report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857235

## Symptoms

Consider the following scenario:

- You modify a report.
- You make a copy of the modified report and then modify the copy. That is, you don't modify the original but instead make a copy of the modified copy.
- You delete the original modified report and then try to print the modified copy of the modified report.

In this scenario, you receive the following error message:
> Report not found, problem starting up report.

## Cause 1

This problem occurs for one of the following reasons:

- The report doesn't exist.
- The report is corrupted.

To resolve this problem, see [Resolution 1](#resolution-1).

## Cause 2

This problem occurs for one of the following reasons:

- The Reports.dic file was renamed.
- The Reports.dic file was deleted.

To resolve this problem, see [Resolution 2](#resolution-2).

## Resolution 1

To resolve this problem, follow these steps, depending on the version of Microsoft Dynamics that you've installed.

### Microsoft Dynamics 10.0

1. Export the report to a package file by following these steps:
    1. Start Microsoft Dynamics GP 10.0.
    1. Click **Microsoft Dynamics GP** > **Tools** > **Customize** > **Customization Maintenance**.
    1. Click to select the report, and then click **Export**.
1. Delete the modified report by following these steps:
    1. Click **Microsoft Dynamics GP** > **Tools** > **Customize** > **Report Writer**.
    1. Click **Microsoft Dynamics GP** > **OK**.
    1. In Report Writer, click **Reports**, click the modified report, and then click **Delete**.
1. Import the report package that you created by following these steps:
    1. Click **Microsoft Dynamics GP**, click **Tools** > **Customize** > **Customization Maintenance**.
    1. Click **Browse**, locate, and then select the package file that you created in step 1, and then click **OK**.

### Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0

1. Export the report to a package file by following these steps:
    1. Start Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0.
    1. Click **Tools** > **Customize** > **Customization Maintenance**.
    1. Click to select the report, and then click **Export**.
1. Delete the modified report by following these steps:
    1. Click **Tools** > **Customize** > **Report Writer**.
    1. Take one of the following actions, as appropriate for your situation:
        - In Microsoft Dynamics GP 9.0, Click **Microsoft Dynamics GP** > **OK**.
        - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** > **OK**.
    1. In Report Writer, click **Reports**, click the modified report, and then click **Delete**.
1. Import the report package that you create by following these steps:
    1. Click **Tools** > **Customize** > **Customization Maintenance**.
    1. Click **Import**.
    1. Click **Browse**, locate, and select the package file that you created in step 1, and then click **OK**.

## Resolution 2

To resolve this problem, follow these steps:

1. Locate the Reports.dic file by following these steps:
    1. Take one of the following actions, as appropriate for your situation:
        - In Microsoft Dynamics GP 10.0, point to **Tools**. On the **Microsoft Dynamics GP** menu, point to **Setup** > **System**, and then click **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0 and earlier versions, point to **Setup**. On the **Tools** menu, point to **System**, and then click **Edit Launch File**.
    1. If you're prompted for a password, type the system password.
    1. Take one of the following actions, as appropriate for your situation:
        - In Microsoft Dynamics GP, click **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, click **Great Plains** in the Edit Launch File window.
    1. Note the path that is displayed in the **Reports** field.
    1. Click **OK** to close the Edit Launch File window.
1. Determine whether the Reports.dic file exists in the location that is specified in step 1d.
1. If the Reports.dic file doesn't exist in the location that is specified in step 1d, restore the file from a backup.
