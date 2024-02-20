---
title: How to get and use the Active Directory Replication Status Tool
description: Describes how to get and use the Active Directory Replication Status Tool.
ms.date: 06/08/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jeffbo
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# How to get and use the Active Directory Replication Status Tool

> [!IMPORTANT]
> As of June 2nd, 2023, the Active Directory Replication Status Tool is no longer available for download. The following article is provided for historical purposes only.

This article introduces the Active Directory Replication Status Tool (ADREPLSTATUS). This tool helps administrators identify, prioritize, and fix Active Directory replication errors on a single domain controller (DC) or any DCs in an Active Directory domain or forest.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4469274

## Features

- Auto-discovery of the DCs and domains in the Active Directory forest to which the computer that is running ADREPLSTATUS is joined.
- "Errors only" mode lets administrators focus only on DCs that report replication failures. For more information, see [below](#error-only).
- When ADREPLSTATUS detects replication errors, the tool relies on its integration with resolution content on Microsoft TechNet to display the resolution steps for the top AD replication errors. For more information, see [below](#replication-error-analysis).
- Rich sorting and grouping of result output by clicking any single column header (sort) or by dragging one or more column headers to the filter bar. Use one or both options to arrange output by last replication error, last replication success date, source DC naming context, replication success date, and so on.
- Export replication status data so that it can be imported and viewed by source domain admins, destination domain admins, or support professionals in Microsoft Excel or ADREPLSTATUS.
- Choose which columns that you want displayed and their display order. These settings are saved as a preference on the ADREPLSTATUS computer.

> [!NOTE]
> ADREPLSTATUS is a read-only tool and makes no changes to the configuration of, or objects in, an Active Directory forest.

## More information

The ADREPLSTATUS user interface consists of a toolbar and Microsoft Office-style ribbon to expose different features. The **Replication Status Viewer** tab displays the replication status for all DCs in the forest. The following screenshot shows ADREPLSTATUS highlighting a DC that hasn't replicated in Tombstone Lifetime number of days (identified here by the black color-coding).

:::image type="content" source="media/get-use-active-directory-replication-status-tool/replication-status-viewer-tab.png" alt-text="ADREPLSTATUS highlights a DC that hasn't replicated in Tombstone Lifetime number of days." border="false":::

### Error only

By using the **Errors Only** button (upper-right of image below), you can filter out healthy DCs to focus on destination DCs that are reporting replication errors:

:::image type="content" source="media/get-use-active-directory-replication-status-tool/using-errors-only-button.png" alt-text="Filter out healthy DCs by using the Errors Only button." border="false":::

### Replication error analysis

The Replication Error Guide has a **Detected Errors Summary** view that records each unique replication error that occurs on the set of DCs that are targeted by the administrator.

:::image type="content" source="media/get-use-active-directory-replication-status-tool/detected-errors-summary.png" alt-text="Detected Errors Summary view that records each unique replication error." border="false":::

Selecting any of the replication error codes loads the recommended troubleshooting content for that error. For example, the following is a screenshot for when the TechNet Article for Active Directory Replication Error 1256 is displayed:

:::image type="content" source="media/get-use-active-directory-replication-status-tool/ad-replication-error-1256.png" alt-text="The TechNet article for Active Directory Replication Error 1256 is displayed." border="false":::

The goals for this tool are to help administrators identify and fix Active Directory replication errors before they cause user and application failures or outages, or lingering objects cause short or long-term replication failures, and to give administrators more insight into the operation of Active Directory replication in their environments.

The current version of ADREPLSTATUS as of this posting is 2.2.20717.1 (as reported on ADREPLSTATUS startup splash screen).

## Known issues

- ADREPLSTATUS won't work when the following security setting is enabled in Windows - *System cryptography: Use FIPS 140 compliant cryptographic algorithms, including encryption, hashing and signing algorithms*.
- An additional check mark appears at the bottom of the column chooser when you right-click a column header.

> [!NOTE]
>
> The ADRPLSTATUS tool is supported by the Microsoft ADREPLSTATUS team. Administrators and support professionals who experience errors installing or executing ADREPLSTATUS can [submit a problem report](https://social.technet.microsoft.com/wiki/contents/articles/12707.active-directory-replication-status-tool-adreplstatus-resources-page.aspx).
>
> For known issues, the ADREPLSTATUS team will report the status at the same page. If your issue requires additional investigation, the ADREPLSTATUS team will contact you at the email address that you provided in your problem report.
>
> The time that's needed to provide a solution depends on the team's workload as well as problem complexity and cause. Code defects in the ADREPLSTATUS tool can typically be resolved relatively quickly. Tool failures due to external causes may take longer, unless a workaround can be found.
>
> The ADREPLSTATUS team can't fix Active Directory replication errors that are identified by the ADREPLSTATUS tool. Contact your support provider to fix the issue. You may also submit and research replication errors at [this TechNet Windows Server forum](https://social.technet.microsoft.com/Forums/en-US/home?forum=winserverDS).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
