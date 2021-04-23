---
title: No data if exporting Dynamic Worksheets or Pivot Tables
description: After exporting Microsoft Dynamics CRM Dynamic Worksheets and/or Dynamic Pivot Tables using Claims Authentication, users do not see the expected data within the Excel worksheet.
ms.reviewer: jowells, chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Cannot see the expected data after exporting Dynamic Worksheets and/or Dynamic Pivot Tables

This article provides a resolution for the issue that you can't see the expected data within the Excel worksheet after exporting Microsoft Dynamics CRM Dynamic Worksheets and/or Dynamic Pivot Tables.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 2556284

## Symptoms

After exporting Microsoft Dynamics CRM Dynamic Worksheets and/or Dynamic Pivot Tables using Claims Authentication, users do not see the expected data within the Excel worksheet.

Users may see one of two things within the Excel Worksheet:

1. When using IFD Claims Authentication, users will see the AD FS sign-in page.
2. When using claims authentication, users will get a message stating:

   > "Script is disabled. Click Submit to continue"

## Cause

Cause 1

Exporting the Dynamic Worksheet and/or Dynamic Pivot Table using Internet Explorer. This issue occurs because Internet Explorer is unable to pass the federation cookie to Excel.

Cause 2

After exporting the Dynamic Worksheet and/or Dynamic Pivot Table using the Microsoft Dynamics CRM for Microsoft Office Outlook client, users did not refresh the data.

## Resolution

Resolution 1

Dynamic Worksheets and/or Dynamics Pivot Tables require the use of the Excel add-in that is part of the Microsoft Dynamics CRM for Microsoft Office Outlook client. You must install the Microsoft Dynamics CRM for Microsoft Office Outlook for the proper version of Microsoft Dynamics CRM.

After the Microsoft Dynamics CRM for Microsoft Office Outlook client is installed and configured, the Dynamic Worksheet and/or Dynamic Pivot Table can be exported using the Outlook client, which allows for the transfer of the federation cookie to Excel.

Resolution 2

After exporting the Dynamic Worksheets and/or Dynamics Pivot Tables, refresh the data.

1. Export the Dynamic Worksheets and/or Dynamics Pivot Tables from Microsoft Dynamics CRM.  
2. Open up the Dynamic Worksheets and/or Dynamics Pivot Tables with Excel.  
3. Within Excel, select the **Data** tab.  
4. Select **Refresh** from CRM button.

## More information

You can work around the requirement of using the Microsoft Dynamics CRM for Microsoft Office Outlook client by going through the following:

1. Export the Dynamic Worksheets and/or Dynamics Pivot Tables from Microsoft Dynamics CRM.
2. Open up the Dynamic Worksheets and/or Dynamics Pivot Tables with Excel.
3. After the ADFS sign-in page or the **Script is disabled** error shows in the worksheet, select the **Data** tab.
4. Select **Connections**.
5. Within Workbook Connections, select **Properties**.
6. Within Connection Properties, select the **Definition** tab.
7. Select the **Edit Query** button.
8. Within the Edit Web Query window you will need to do one of the following:
   - Using IFD Claims authentication, the Edit Web Query will redirect to ADFS login, enter in the user's credentials and select **Sign In**.
   - Using Claims authentication, continue to step 9.
9. After getting the Microsoft Dynamics CRM error, select **OK**.
10. Within Edit Web Query, select **Cancel**.
11. Within Connection Properties, select **Cancel**.
12. Within Workbook Connections, select **Close**.
13. Within **Excel** > **Data** tab, select **Refresh All**.

> [!NOTE]
> These steps are required every time you close and re-open the Dynamic Worksheets and/or Dynamics Pivot Tables.
