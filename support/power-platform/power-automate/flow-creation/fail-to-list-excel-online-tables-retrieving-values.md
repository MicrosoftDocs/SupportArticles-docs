---
title: Fail to list Excel Online tables retrieving values
description: Creating an Excel-triggered flow and unable to list tables in the Excel file with could not retrieve values, error executing the API error.
ms.reviewer: jewelden
ms.date: 03/31/2021
ms.subservice: power-automate-flow-creation
---
# Fail to list Excel Online tables retrieving values

This article provides a resolution for the issue that an API error **could not retrieve values, error executing the API** occur when creating an Excel trigger flow.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4534996

## Symptoms

Creating an Excel trigger flow using, for example, the ["request approval for a selected row" template](https://preview.flow.microsoft.com/galleries/public/templates/4c8abe0d62ab4333860da9ad218cc8f7/request-approval-for-a-selected-row/), browsing to the workbook in OneDrive works but the template doesn't list the tables in the excel file, but gives an API error **could not retrieve values, error executing the API**.

## Cause

This error might occur due to OneDrive IP permissions.

## Resolution

To resolve this issue:

- Check permissions in OneDrive.
- Make sure to use OneDrive connector for OneDrive and OneDrive for Business connector for OneDrive for Business.
- If permission error is received while running the flow, change IP restrictions in OneDrive.
- Move the file to another group folder.
- If unable to run the flow but table picker works, create the flow from scratch and try running it again.

For more information, see the following articles:

- [Control access based on network location or app](/onedrive/control-access-based-on-network-location-or-app)
- [Limits for automated, scheduled, and instant flows](/power-automate/limits-and-config#ip-address-configuration)
- [OneDrive for Business](/connectors/onedriveforbusiness/)
- [OneDrive](/connectors/onedrive/)

See related article:

- [Unable to Find Excel Online Table in Microsoft Flow](https://support.microsoft.com/help/4527553/unable-to-find-excel-online-table-in-microsoft-flow)
