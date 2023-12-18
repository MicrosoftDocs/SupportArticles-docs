---
title: Guidance for troubleshooting Windows Update for Business reports issues
description: Introduces general guidance for troubleshooting scenarios related to Windows Update for Business reports
ms.date: 12/19/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.prod: windows-server
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-server-deployment
keywords: 
---

# Windows Update for Business reports: troubleshooting guidance

_Applies to:_ &nbsp; Windows Server, all supported versions

This article is designed to get you started on troubleshooting issues encountered when using Windows Update for Business reports.

## Troubleshooting checklist

Here's a list of basic steps to resolve most Windows Update for Business reports issues:

- Verify that you belong to the correct roles:
  - Azure: Either the Log Analytics Reader or Log Analytics Contributor Azure role.  
  - Microsoft Entra: An administrative role.  

  At a high level, Azure roles control permissions to manage Azure resources, while Microsoft Entra roles control permissions to manage Microsoft Entra ID resources. For more information, see [Windows Update for Business reports prerequisites: Permissions](/windows/deployment/update/wufb-reports-prerequisites#permissions).
- Verify that at least one device is sending telemetry, especially if you got a successful save message during enrollment but still haven't seen any data after 48 hours. If no devices are sending telemetry, run the [configuration script](/windows/deployment/update/wufb-reports-configuration-script) on the clients to ensure that they're active and configured properly.
- Verify that the devices are [Microsoft Entra joined](/azure/active-directory/devices/concept-azure-ad-join) or [Microsoft Entra hybrid joined](/azure/active-directory/devices/concept-azure-ad-join-hybrid).
- Verify that the devices are turned on, active, and can scan for Windows updates. To be included in reports, a device has to have been active at least once in the past 28 days.
- Make sure that each device has the **Allow device name to be sent in Windows diagnostic data** policy enabled.
- Check the size of the report. For performance reasons, the default limit for rows in Azure workbooks is set to 1000. If your report has more than 1000 rows, do one of the following:
  - Export the report data to Excel to view the whole report
  - To view the information in Logs view, select the three dots beside the component of interest.
  - Check the policy configuration.

> [!NOTE]  
> If you have questions about report content or customization, see [Frequently Asked Questions about Windows Update for Business reports](/windows/deployment/update/wufb-reports-faq).

## Common issues and solutions

### Stuck at the "Waiting for Windows Update for Business reports data" page

This issue has several potential causes. To resolve the issue, check the following:  

- Verify that you belong to the correct roles:
  - Azure: Either the Log Analytics Reader or Log Analytics Contributor Azure role.
  - Microsoft Entra: An administrative role.  

  At a high level, Azure roles control permissions to manage Azure resources, while Microsoft Entra roles control permissions to manage Microsoft Entra resources. For more information, see [Windows Update for Business reports prerequisites: Permissions](/windows/deployment/update/wufb-reports-prerequisites#permissions).
- Verify that at least one device is sending telemetry, especially if you got a successful save message during enrollment but still haven't seen any data after 48 hours. If no devices are sending telemetry, run the [configuration script](/windows/deployment/update/wufb-reports-configuration-script) on the clients to ensure that they're active and configured properly.
- If the preceding solutions don't apply or don't resolve the issue, use the Configuration flyout of your administrative console to unenroll and re-enroll again. Wait for 24-48 hours. If the issue persists, contact Microsoft Support.

### Devices are missing from reports

This issue has several potential causes. To resolve the issue, check the following:

- Verify that the devices are [Microsoft Entra joined](/azure/active-directory/devices/concept-azure-ad-join) or [Microsoft Entra hybrid joined](/azure/active-directory/devices/concept-azure-ad-join-hybrid).
- Verify that the devices are sending telemetry. If the missing devices aren't sending telemetry, run the configuration script to ensure that they're active and configured properly.
- Verify that the devices are turned on, active, and can scan for Windows updates. To be included in reports, a device has to have been active at least once in the past 28 days.
- Check the size of the report. For performance reasons, the default limit for rows in Azure workbooks is set to 1000. If your report has more than 1000 rows, do one of the following:  

  - Export the report data to Excel to view the whole report
  - To view the information in Logs view, select the three dots beside the component of interest.

For more in-depth troubleshooting of missing diagnostic data, see [Windows Update for Business reports: How to troubleshoot diagnostic data transmission](wubr-troubleshooting-data-transmission.md).
