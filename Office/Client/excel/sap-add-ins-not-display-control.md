---
title: SAP add-ins don't display controls after update to Office 1806 or higher
description: SAP EPM Context Pane doesn't display any control in Excel after updating Office to version 1806 or 1807.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Excel for Microsoft 365
  - PowerPoint for Microsoft 365
  - Word for Microsoft 365
ms.date: 03/31/2022
---

# SAP add-ins don't display controls after update to Office 1806 or higher

## Symptoms

Consider the following scenario:

- You're running Windows 10 with a lower version than 1809, and you update your Microsoft Office instance to version 1806 or higher.    
- You install a SAP add-in for Microsoft Office (for Microsoft Excel, PowerPoint, or Word).    

In this scenario, the SAP add-in can no longer display some controls in dialog boxes and task panes. If you revert Office to version 1805, this issue doesn't occur. 

## Resolution

To resolve the issue, update Office to version 1808, or a later version, and update Windows to version 1809 or a later version.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

## Workaround

Until Office and Windows have been updated to the required versions, you can configure the **When using multiple displays** setting in Office to **Optimize for compatibility**. The issues should not occur in compatibility mode.

:::image type="content" source="media/sap-add-ins-not-display-control/excel-options-dialog-box.png" alt-text="Screenshot to select the Optimize for compatibility option in the When using multiple displays setting.":::
