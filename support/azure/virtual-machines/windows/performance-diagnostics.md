---
title: Troubleshoot performance issues on Azure virtual machines using Performance Diagnostics (PerfInsights)
description: Use the Performance Diagnostics tool to identify and troubleshoot performance issues on your Azure virtual machine (VM).
services: virtual-machines
documentationcenter: ''
author: anandhms
manager: dcscontentpm
editor: przlplx
tags: ''
ms.service: azure-virtual-machines
ms.workload: infrastructure-services
ms.topic: troubleshooting
ms.date: 06/10/2025
ms.custom: sap:VM Performance
ms.reviewer: guywild, poharjan
ms.author: anandh

# Customer intent: As a VM administrator or a DevOps engineer, I want to analyze and troubleshoot performance issues on my Azure virtual machine so that I can resolve these issues myself or share Performance Diagnostics information with Microsoft Support.
---

# Troubleshoot performance issues on Azure virtual machines using Performance Diagnostics

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

You can use the Performance Diagnostics tool to identify and troubleshoot performance issues on your Azure virtual machine (VM) in one of two modes:

* **Continuous diagnostics** collects data at five-second intervals and reports actionable insights about high resource usage every five minutes. Continuous diagnostics is Generally Available (GA) for Windows VMs and in Public Preview for Linux VMs.
* **On-demand diagnostics** helps you troubleshoot an ongoing performance issue by providing more in-depth data, insights, and recommendations that are based on data that's collected at a single moment. On-demand diagnostics is supported on both Windows and Linux.

Performance Diagnostics stores all insights and reports in a storage account that you can configure for short data retention to minimize costs.

Run Performance Diagnostics directly from the Azure portal, where you can also review insights and a report about various logs, rich configuration, and diagnostics data. We recommend that you run Performance Diagnostics and review the insights and diagnostics data before you contact Microsoft Support.

This article explains how to use Performance Diagnostics and what the continuous and on-demand modes offer.

## Known issues

### Existing user-assigned managed identities removed from VM

**Issue**<br>
If system-assigned managed identity is disabled on a VM, installing Performance Diagnostics using system-assigned managed identity will unintentionally remove any existing user-assigned managed identities from the VM.<br><br>
**Cause**<br>
If system-assigned managed identity is disabled on a VM and the authentication method selected during installation is system-assigned managed identity, Performance Diagnostics attempts to enable the system-assigned managed identity with an ARM template deployment. ARM treats the identity property as a complete object rather than a partial update. Because the deployment template specified only `SystemAssigned` as the identity type, it overwrites any existing user-assigned managed identities. This results in the removal of all user-assigned managed identities since both identity types weren' t explicitly defined in the template. This issue does not occur if system-assigned managed identity is already enabled on the VM before installing Performance Diagnostics using system-assigned managed identity.<br><br>
**Status**<br>
The product team is actively working on a fix and will update the status once the fix is available.<br><br>
**Workaround**<br>
To install Performance Diagnostics using a system-assigned managed identity on a VM that already has user-assigned managed identities, you must enable the system-assigned managed identity on the VM before installation to avoid overwriting existing identities. Alternatively, you can install Performance Diagnostics using other authentication methods such as user-assigned managed identity or storage account access keys.

## Prerequisites

* To run continuous and on-demand diagnostics on Windows, you need [.NET SDK](/dotnet/core/install/windows) version 4.5 or a later version installed.

> [!NOTE]
> To run Performance Diagnostics on classic VMs, see [Azure Performance Diagnostics VM extension](performance-diagnostics-vm-extension.md).

## Permissions required

| Action | Authentication type | Permissions required |
|:-|:-|:-|
| Run Performance Diagnostics | Storage Account Access Keys | The **Owner** role on the VM and an Azure role that includes the **Microsoft.Storage/storageAccounts/listkeys/action** permission on the storage account. |
| Run Performance Diagnostics | Managed Identities (System-assigned and User-assigned) | The **Owner** role on the VM and an Azure role that includes the **Microsoft.Storage/storageAccounts/providers/roleAssignments/write** permission on the storage account. |
| View Performance Diagnostics | Storage Account Access Keys | An Azure role that includes the **Microsoft.Storage/storageAccounts/listkeys/action** permission on the storage account or the **Storage Table Data Reader** role on the storage account. |
| View Performance Diagnostics | Managed Identities (System-assigned and User-assigned) | An Azure role that includes the **Storage Table Data Reader** role on the storage account. |
| Download Performance Diagnostics reports | All | An Azure role that includes the **Storage Table Data Reader** role and the **Storage Blob Data Reader** role on the storage account. |


For detailed information about built-in roles for Azure Storage, refer to [Azure built-in roles for Storage](/azure/role-based-access-control/built-in-roles/storage).

For more information about storage account settings, see [view and manage storage account and stored data](performance-diagnostics.md#view-and-manage-storage-account-and-stored-data).

## Supported operating systems

### Windows

The following operating systems are currently supported for both on-demand and continuous diagnostics:

* Windows Server 2022
* Windows Server 2019
* Windows Server 2016
* Windows Server 2012 R2
* Windows Server 2012
* Windows 11
* Windows 10

### Linux

The following distributions are currently supported for on-demand diagnostics.

> [!NOTE]  
> Microsoft has tested only the versions that are listed in the table. If a version isn't listed in the table, then it isn't explicitly tested by Microsoft, but it might still work.

| Distribution               | Version                                         |
|----------------------------|-------------------------------------------------|
| Oracle Linux Server        | 6.10 [`*`], 7.3, 7.5, 7.6, 7.7, 7.8, 7.9, 9.0, 9.1, 9.2, 9.3, 9.4 |
| RHEL                       | 7.4, 7.5, 7.6, 7.7, 7.8, 7.9, 8.0 [`*`], 8.1, 8.2, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9, 9.0, 9.1, 9.2, 9.3, 9.4 |
| Ubuntu                     | 16.04, 18.04, 20.04, 22.04, 24.04 |
| Debian                     | 9, 10, 11 [`*`], 12 |
| SLES                       | 12 SP5 [`*`], 15 SP1 [`*`], 15 SP2 [`*`], 15 SP3 [`*`], 15 SP4 [`*`], 15 SP5 [`*`], 15 SP6 [`*`] |
| AlmaLinux                  | 8.4, 8.5, 9 |
| Azure Linux                | 2.0, 3.0|

> [!NOTE]
> [`*`] See [Known issues](../linux/how-to-use-perfinsights-linux.md#known-issues)

## Install and run Performance Diagnostics on your VM

Performance Diagnostics installs a VM extension that runs a diagnostics tool, called PerfInsights. PerfInsights is available for both [Windows](how-to-use-perfinsights.md) and [Linux](../linux/how-to-use-perfinsights-linux.md).

You can install the Performance Diagnostics tool from three different locations in the Azure portal, depending on your troubleshooting workflow. From your virtual machine, go to:

* **Overview** → Monitoring tab
* **Insights** → Performance tab
* **Performance diagnostics**

Select one of the following tabs for detailed instructions.

> [!NOTE]
> To run Performance Diagnostics, make sure that you have all [required permissions](#permissions-required).

### [Performance Diagnostics](#tab/perfdiag)

1. In the [Azure portal](https://portal.azure.com), open **Virtual machines**, and then select the VM that you want to run diagnostics on.

2. In the left-hand navigation menu, expand the **Help** section, then select **Performance Diagnostics**.

3. Select **Enable Performance Diagnostics**

    :::image type="content" source="media/performance-diagnostics/open-performance-diagnostics.png" alt-text="Screenshot of the Performance dianostics pane in the Azure portal that shows the Enable Performance Diagnostics button highlighted." lightbox="media/performance-diagnostics/open-performance-diagnostics.png":::

### [Overview](#tab/overview)

1. In the [Azure portal](https://portal.azure.com), open **Virtual machines**, and then select the VM that you want to run diagnostics on.

2. On the **Overview** page, switch to the **Monitoring** tab.

3. Select **Install** at the bottom of the **Install Performance Diagnostics** tile.

    :::image type="content" source="./media/performance-diagnostics/install-from-overview.png" alt-text="Screenshot of the Overview pane in the Azure portal that shows the Install Performance Diagnostics tile highlighted." lightbox="./media/performance-diagnostics/install-from-overview.png":::

### [Insights](#tab/insights)

1. In the [Azure portal](https://portal.azure.com), open **Virtual machines** and select the VM that you want to run diagnostics on.

2. In the left-hand navigation menu, expand the **Monitoring** section, then select **Insights**.

3. Select **Install** at the bottom of the **Install Performance Diagnostics** tile.

    :::image type="content" source="./media/performance-diagnostics/install-from-insights.png" alt-text="Screenshot of the Insights pane in the Azure portal that shows the Install Performance Diagnostics tile highlighted." lightbox="./media/performance-diagnostics/install-from-insights.png":::

---

4. Select the options to install and run the tool. The table describes the available options.

    :::image type="content" source="media/performance-diagnostics/install-and-run-context-pane.png" alt-text="Screenshot of the Install and run Performance Diagnostics context pane. The Enable continuous diagnostics and Run on-demand diagnostics options are selected." lightbox="media/performance-diagnostics/install-and-run-context-pane.png":::

    | Option | Description |
    | ------ | ----------- |
    | **Enable continuous diagnostics** | Get continuous, actionable insights into high resource usage by having data collected every five seconds and updates uploaded every five minutes to address performance issues promptly. Store insights in your preferred storage account. The storage account retains insights based on the account retention policies that you can configure to [manage the data lifecycle effectively](/azure/storage/blobs/lifecycle-management-policy-configure). You can disable continuous diagnostics at any time. |
    | **Run on-demand diagnostics** | Get on-demand, actionable insights into high resource usage and various system configurations. Receive a downloadable report that provides comprehensive diagnostics data to address performance issues. Store insights and reports in your preferred storage account. The storage account retains insights that are based on the account retention policies that you can configure to [manage the data lifecycle effectively](/azure/storage/blobs/lifecycle-management-policy-configure). You can initiate on-demand diagnostics at any time by using the specific analysis type that you need:<br/><ul><li>**Performance analysis**<br/>Includes all checks in the **Quick analysis** scenario, and monitors high resource consumption. Use this version to troubleshoot general performance issues, such as high CPU, memory, and disk usage. This analysis takes 30 seconds to 15 minutes to run, depending on the selected duration. Learn more [Windows](how-to-use-perfinsights.md) or [Linux](../linux/how-to-use-perfinsights-linux.md)</li><br/><li>**Quick analysis**<br/>Checks for known issues, analyzes best practices, and collects diagnostics data. This analysis takes several minutes to run. Learn more for [Windows](how-to-use-perfinsights.md) or [Linux](../linux/how-to-use-perfinsights-linux.md)</li><br/><li>**Advanced performance analysis** [*Windows only*]<br/>Includes all checks in the **Performance analysis** scenario, and collects one or more of the traces, as listed in the following sections. Use this scenario to troubleshoot complex issues that require more traces. Running this scenario for longer periods increases the overall size of diagnostics output, depending on the size of the VM and the trace options that are selected. This analysis takes 30 seconds to 15 minutes to run, depending on the selected duration. [Learn more](./how-to-use-perfinsights.md)</li><br/><li>**Azure file analysis** [*Windows only*]<br/>Includes all checks in the **Performance analysis** scenario, and captures a network trace and Server Message Block (SMB) counters. Use this scenario to troubleshoot the performance of Azure files. This analysis takes 30 seconds to 15 minutes to run, depending on the selected duration. [Learn more](./how-to-use-perfinsights.md)</li></ul> |
    | **Storage account** | Optionally, if you want to use a single storage account to store the Performance Diagnostics results for multiple VMs, you can select a storage account from the drop-down menu. If you don't specify a storage account, Performance Diagnostics uses the default diagnostics storage account or creates a new storage account. |
    |[Authentication method](#authentication-methods)|Performance Diagnostics supports three authentication methods to write performance diagnostics data to the storage account. They are system-assigned managed identity (default), user-assigned managed identity and storage account access keys. If system-assigned managed identity is selected but not enabled for the VM, Performance Diagnostics attempts to enable it. If the current user lacks the necessary permissions, this operation might fail.|

5. Review the legal terms and privacy policy, and select the corresponding checkbox to acknowledge acceptance (*required*).

    > [!NOTE]
    > To install and run Performance Diagnostics, you must agree to the legal terms and accept the privacy policy.

6. Select **Apply** to apply the selected options and install the tool.

    A notification is displayed as Performance Diagnostics starts to install. After the installation is completed, a second notification indicates that the installation is successful. If the **Run on-demand diagnostics** option is selected, the selected performance analysis scenario is then run for the specified duration.

### Authentication methods

Performance Diagnostics supports [Managed Identities](/entra/identity/managed-identities-azure-resources/overview) and [Storage account access keys](/azure/storage/common/storage-account-keys-manage) as authentication methods to write performance diagnostics data to the storage account:

> [!NOTE]
> For optimal security, Microsoft recommends using Microsoft Entra ID with managed identities to authorize requests against blob, queue, and table data, whenever possible. Authorization with Microsoft Entra ID and managed identities provides superior security and ease of use over Shared Key authorization.

- System-assigned managed identity

    This is the default authentication method. If system-assigned managed identity is selected but not enabled for the VM, Performance Diagnostics attempts to enable it. If the current user lacks the necessary permissions, this operation might fail. Performance Diagnostics adds the **Storage Table Data Contributor** role and the **Storage Blob Data Contributor** role for the storage account, to the system-assigned managed identity. For more information, see [How to enable system-assigned managed identity on an existing VM](/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities#enable-system-assigned-managed-identity-on-an-existing-vm).

- User-assigned managed identity

    The user can select one from a list of user-assigned managed identities associated with the VM. Performance Diagnostics adds the **Storage Table Data Contributor** role and the **Storage Blob Data Contributor** role for the storage account, to the user-assigned managed identity. For more information, see [How to assign a user-assigned managed identity to an existing VM](/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities#assign-a-user-assigned-managed-identity-to-an-existing-vm).

- Storage account access keys

    The user can select storage account access keys. If **Allow storage account key access** is disabled for the storage account, the installation operation fails. For more information, see [Shared key authorization](/azure/storage/common/shared-key-authorization-prevent#disable-shared-key-authorization).

To change the authentication method, uninstall Performance Diagnostics and reinstall it. 

> [!NOTE]
> Once the managed identities are linked to the VM, it might take a few minutes for them to be propagated and recognized by Performance Diagnostics. If the installation fails, wait a few minutes and try again.

## View insights and reports

This table compares the data that's provided by Continuous and On-demand Performance Diagnostics. For a complete list of all the collected diagnostics data, see **What kind of information is collected by PerfInsights** on [Windows](how-to-use-perfinsights.md#what-information-does-performance-diagnostics-collect-in-windows) or [Linux](../linux/how-to-use-perfinsights-linux.md#what-kind-of-information-is-collected-by-perfinsights).

|                               | Continuous Performance Diagnostics                                                                          | On-demand Performance Diagnostics                                                        |
|-------------------------------|-------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| **Availability**              | GA for Windows VMs, Public Preview for Linux VMs                                                                  | GA for both Windows and Linux VMs                                                 |
| **Insights generated**        | Continuous actionable insights into high resource usage, such as high CPU, high memory, and high disk usage | On-demand actionable insights into high resource usage and various system configurations |
| **Data collection frequency** | Collects data every five seconds, updates are uploaded every five minutes                                             | Collects data on demand for the selected duration of the on-demand run                    |
| **Reports generated**         | Doesn't generate a report                                                                                   | Generates a report that has comprehensive diagnostics data                                   |

### View Performance Diagnostics insights

You can view Performance Diagnostics insights from three different locations in the Azure portal, depending on your troubleshooting workflow. From your virtual machine, go to:

* **Overview** → Monitoring tab
* **Insights** → Performance tab
* **Performance diagnostics**

Select one of the following tabs for detailed instructions.

> [!NOTE]
> To view Performance Diagnostics, make sure that you have all [required permissions](#permissions-required).

### [Performance Diagnostics](#tab/perfdiag)

1. In the [Azure portal](https://portal.azure.com), open **Virtual machines**, and then select the VM that you view diagnostics for.

1. In the left-hand navigation menu, expand the **Help** section, then select **Performance Diagnostics**.

1. The **Performance Diagnostics insights** tab is active by default.

    Every row under **Performance Diagnostics insights** lists an insight, its impact level, category, and related recommendations. Use filters to retrieve insights by timestamp, impact, category, or diagnostic type.

    :::image type="content" source="media/performance-diagnostics/view-from-performance-diagnostics.png" alt-text="Screenshot of the Performance Diagnostics experience in the Azure portal." lightbox="media/performance-diagnostics/view-from-performance-diagnostics.png":::

1. Select a row to open the **Performance diagnostics insights details** context menu. For more information, see the following section.

### [Overview](#tab/overview)

1. In the [Azure portal](https://portal.azure.com), open **Virtual machines** and select the VM that you want to view diagnostics for.

1. On the **Overview** page, switch to the **Monitoring** tab.

1. Expand **Insights** (if collapsed) to view Performance Diagnostics.

    Each row under **Performance Diagnostics** lists an insight, its impact level, category, and related recommendations. Use filters to retrieve insights by impact, category, or diagnostic type.

    > [!NOTE]
    > The **Performance Diagnostics** grid in the Overview experience is *limited to show 300 rows*. To view all rows, go to the Performance Diagnostics experience.

    :::image type="content" source="media/performance-diagnostics/view-from-overview.png" alt-text="Screenshot of the Overview experience in the Azure portal." lightbox="media/performance-diagnostics/view-from-overview.png":::

1. Select a row to open the **Performance diagnostics insights details** context menu. For more information, see the following section.

### [Insights](#tab/insights)

1. In the [Azure portal](https://portal.azure.com), open **Virtual machines**, and then select the VM that you want to view diagnostics for.

1. In the left-hand navigation menu, expand the **Monitoring** section, and then select **Insights**.

1. Switch to the **Performance** tab to view **Performance insights**.

    Every row under **Performance insights** lists an insight, its impact level, category, and related recommendations. Use filters to retrieve insights by impact, category, or diagnostic type.

    > [!NOTE]
    > The **Performance insights** grid in the Insights experience is *limited to show 300 rows*. To view all rows, go to the Performance Diagnostics experience.

    :::image type="content" source="media/performance-diagnostics/view-from-insights.png" alt-text="Screenshot of the Insights experience in the Azure portal." lightbox="media/performance-diagnostics/view-from-insights.png":::

1. Select a row to open the **Performance diagnostics insights details** context menu. For more information, see the next section.

---

### View details and download report

The **Performance diagnostics insights details** context menu shows additional information, such as recommendations about what to do and links to relevant documentation. For an on-demand insight, you can also view or download the Performance Diagnostics report in the list by selecting **View all insights** or **Download report**, respectively. For more information, see [Download and review the full Performance Diagnostics report](#view-performance-diagnostics-reports).

:::image type="content" source="media/performance-diagnostics/performance-diagnostics-details.png" alt-text="Screenshot of the details screen on the Performance Diagnostics experience." lightbox="media/performance-diagnostics/performance-diagnostics-details.png" :::

>[!NOTE]
> The Performance Diagnostics experience offers additional options to group or ungroup insights. You can group on-demand and continuous insights by category, insight, or recommendation.
>
> :::image type="content" source="media/performance-diagnostics/insights-list-grouping.png" alt-text="Screenshot of the Insights tab on the Performance Diagnostics screen that shows results grouped by insight." lightbox="media/performance-diagnostics/insights-list-grouping.png":::

### View Performance Diagnostics reports

> [!NOTE]
> To download Performance Diagnostics reports, make sure that you have all [required permissions](#permissions-required).

The **Performance Diagnostics reports** tab is available only in the [Performance diagnostics](#view-performance-diagnostics-insights) experience. It lists all the on-demand diagnostics reports that were run. The list indicates the type of analysis that was run, insights that were found, and their impact levels.

:::image type="content" source="media/performance-diagnostics/select-report.png" alt-text="Screenshot of selecting a diagnostics report from the Performance Diagnostics screen." lightbox="media/performance-diagnostics/select-report.png":::

Select a row to view more details.

:::image type="content" source="media/performance-diagnostics/performance-diagnostics-report-overview.png" alt-text="Screenshot of Performance Diagnostics report overview screen." lightbox="media/performance-diagnostics/performance-diagnostics-report-overview.png":::

Performance Diagnostics reports might contain several insights. Every insight includes recommendations.

The **Impact** column indicates an impact level of High, Medium, or Low to indicate the potential for performance issues, based on factors such as misconfiguration, known problems, or issues that are reported by other users. You might not yet be experiencing one or more of the listed issues. For example, you might have SQL log files and database files on the same data disk. This condition has a high potential for bottlenecks and other performance issues if the database usage is high. However, you might not notice an issue if the usage is low.

Select the **Download report** button to download an HTML report that contains richer diagnostics information, such as storage and network configuration, performance counters, traces, list of processes, and logs. The content depends on the selected analysis. For advanced troubleshooting, the report might contain additional information and interactive charts that are related to high CPU usage, high disk usage, and processes that consume excessive memory. For more information about the Performance Diagnostics report, see [Windows](how-to-use-perfinsights.md#review-the-diagnostics-report) or [Linux](../linux/how-to-use-perfinsights-linux.md#review-the-diagnostics-report).

> [!NOTE]
> You can download Performance Diagnostics reports from the **Performance Diagnostics** screen within 30 days after you generate them. After 30 days, you might receive an error Message when you download a report from the **Performance Diagnostics** screen. To get a report after 30 days, go to the storage account, and download the report from a binary large object (BLOB) container that's named *azdiagextnresults*. You can view the storage account information by using the **Settings** button on the toolbar.

## View and manage storage account and stored data

Performance Diagnostics stores all insights and reports in a storage account that you can [configure for short data retention](/azure/storage/blobs/lifecycle-management-policy-configure) to minimize costs.

To ensure Performance Diagnostics functions correctly, you must enable the **Allow storage account key access** setting for the storage account. To enable this setting, follow these steps:

1. Navigate to your storage account.
2. In the storage account settings, locate the **Configuration** section.
3. Find the **Allow storage account key access** option and set it to **Enabled**.
4. Save your changes.

You can use the same storage account for multiple VMs that use Performance Diagnostics. When you change the storage account, the old reports and insights aren't deleted. However, they're no longer displayed in the list of diagnostics reports.

> [!NOTE]
> Performance Diagnostics stores insights in Azure tables and stores reports in a binary large object (BLOB) container.
>
> If your storage account uses [private endpoints](/azure/storage/common/storage-private-endpoints), to make sure that Performance Diagnostics can store insights and reports in the storage account:
>
> 1. Create separate private endpoints for Table and BLOB.
> 1. Add DNS configuration to each separate private endpoint.

### View diagnostics data stored in your account

> [!NOTE]
> To view diagnostics data, make sure that you have all [required permissions](#permissions-required).

To view diagnostics data:

1. Navigate to your storage account in the Azure portal.
1. In the left-hand navigation menu, Select **Storage browser**.

    :::image type="content" source="media/performance-diagnostics/performance-diagnostics-storage-browser.png" alt-text="Screenshot of the storage account screen that shows the Performance Diagnostics insights and report files." lightbox="media/performance-diagnostics/performance-diagnostics-storage-browser.png":::

    Performance Diagnostics stores reports in a binary large object (BLOB) container that's named **azdiagextnresults**, and insights in tables. Insights include:

    * All the insights and related information about the run
    * An output compressed (.zip) file (named **PerformanceDiagnostics_yyyy-MM-dd_hh-mm-ss-fff.zip**) on Windows and a tar file (named **PerformanceDiagnostics_yyyy-MM-dd_hh-mm-ss-fff.tar.gz**) on Linux that contains log files
    * An HTML report

1. To download a report, select **Blob containers** > **azdiagextnresults** > `<report name>` > **Download**.

### Change storage accounts

To change storage accounts in which the diagnostics insights and output are stored:

1. In the Azure portal, open the **Performance diagnostics** experience from your VM.

1. In the top toolbar, select **Settings** to open the **Performance diagnostic settings** screen.

    :::image type="content" source="media/performance-diagnostics/performance-diagnostics-settings.png" alt-text="Screenshot of the Performance Diagnostics screen toolbar that shows the Settings button highlighted." lightbox="media/performance-diagnostics/performance-diagnostics-settings.png":::

1. Select **Change storage account** to select a different storage account.

    :::image type="content" source="media/performance-diagnostics/change-storage-settings.png" alt-text="Screenshot of the Performance Diagnostics settings screen on which you can change storage accounts." lightbox="media/performance-diagnostics/change-storage-settings.png":::

## Uninstall Performance Diagnostics

Uninstalling Performance Diagnostics from a VM removes the VM extension but doesn't affect any diagnostics data that's in the storage account.

To uninstall Performance Diagnostics, select the **Uninstall** button on the toolbar.

:::image type="content" source="media/performance-diagnostics/uninstall-button.png" alt-text="Screenshot of the Performance Diagnostics screen toolbar that shows the Uninstall button highlighted." lightbox="media/performance-diagnostics/uninstall-button.png":::

## Frequently asked questions

### How do I share this data with Microsoft Support?

When you open a support ticket with Microsoft, it's important to share the Performance Diagnostics report from an on-demand Performance Diagnostics run. The Microsoft Support contact provides the option to upload the on-demand Performance Diagnostics report to a workspace. Use either of the following methods to download the on-demand Performance Diagnostics report:

**Option 1:** Download the report from the Performance Diagnostics blade, as described in [View Performance Diagnostics reports](#view-performance-diagnostics-reports).

**Option 2:** Download the report from the storage account, as described in [View and manage storage account and stored data](#view-and-manage-storage-account-and-stored-data).

### How do I capture diagnostics data at the correct time?

We recommend that you run Continuous Performance Diagnostics to capture VM diagnostics data on an ongoing basis.

The On-demand Performance Diagnostics run has the following stages:

- Install or update the Performance Diagnostics VM extension
- Run the diagnostics for the specified duration

Currently, there's no easy way to know exactly when the VM extension installation is completed. It takes about 45 seconds to 1 minute to install the VM extension. After the VM extension is installed, you can run your repro steps to have On-demand Performance Diagnostics capture the correct set of data for troubleshooting.

### Will Performance Diagnostics continue to work if I move my Azure VM across regions?

Azure VMs, and related network and storage resources, can be moved across regions by using Azure Resource Mover. However, moving VM extensions, including the Azure Performance Diagnostics VM extension, across regions isn't supported. You have to manually install the extension on the VM in the target region after you move the VM. For more information, see [Support matrix for moving Azure VMs between Azure regions](/azure/resource-mover/support-matrix-move-region-azure-vm).

### What is the performance impact of enabling Continuous Performance Diagnostics?

We ran 12-hour tests of Continuous Performance Diagnostics on a range of Windows OS versions, Azure VMs of sizes, and CPU loads.

The test results that are presented in this table show that Continuous Performance Diagnostics provides valuable insights by having a minimal effect on system resources.

| OS version              | VM size         | CPU load      | Avgerage CPU usage | 90th percentile CPU usage | 99th percentile CPU usage | Memory usage |
|-------------------------|-----------------|---------------|--------------------|-------------------------|-------------------------|--------------|
| Windows Server 2019     | B2s, A4V2, D5v2 | 20%, 50%, 80% | <0.5%              | 2%                      | 3%                      | 42-43 MB     |
| Windows Server 2016 SQL | B2s, A4V2, D5v2 | 20%, 50%, 80% | <0.5%              | 2%                      | 3%                      | 42-43 MB     |
| Windows Server 2019     | B2s, A4V2, D5v2 | 20%, 50%, 80% | <0.5%              | 2%                      | 3%                      | 42-43 MB     |
| Windows Server 2022     | B2s, A4V2, D5v2 | 20%, 50%, 80% | <0.5%              | <0.5%                   | 3%                      | 42-43 MB     |

#### Back-of-the-napkin calculations of storage costs

Continuous Performance Diagnostics stores insights in a table and a JSON file in a BLOB container. Given that each row is approximately 0.5 KB (kilobyte), and the report is approximately 9 KB before compression, two rows every five minutes plus the corresponding report upload equals 10 KB, or 0.00001 GB.

To calculate the storage cost:

* Rows per month: 17,280
* Size per row: 0.00001 GB

**Total data size:** 17,280 x 0.000001 = 0.1728 GB

**Data storage cost:** $0.1728 x  $0.045 = $0.007776 

Therefore, assuming steady stress on the VM, the storage cost is estimated to be less than one cent per month, assuming that you use locally redundant storage.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
