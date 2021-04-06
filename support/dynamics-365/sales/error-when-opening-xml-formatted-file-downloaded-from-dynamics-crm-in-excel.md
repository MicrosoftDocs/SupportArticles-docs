---
title: Error occurs when opening an XML formatted file
description: An error occurs when you open an XML formatted file downloaded from Microsoft Dynamics CRM 2011 in Microsoft Excel 2010. Provides a resolution.
ms.reviewer: v-anlang
ms.topic: troubleshooting
ms.date: 
---
# Error occurs when opening an XML formatted file downloaded from Microsoft Dynamics CRM 2011 in Excel 2010

This article provides a resolution for the issue that you may receive an error when you try to open an XML formatted file that's downloaded from Microsoft Dynamics CRM 2011 in Microsoft Excel 2010.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2554009

## Symptoms

You see an error when you try to open an XML formatted file downloaded from Microsoft Dynamics CRM 2011 in Excel 2010.

If it is a Dynamic Worksheet or Dynamic Pivot table:

> Unable to open `https://ORGNAME.crm.dynamics.com/_grid/print/print_data.aspx?tweener=1`. Cannot download the information you requested.

If it is a static worksheet that you marked to be eligible for reimport:

> The file is corrupt and cannot be opened.

## Cause

Office 2010 has added additional security features that block files by default that are from another server. In this case, the additional server is the Microsoft Dynamics CRM Server. If you are using Microsoft Dynamics CRM Online, this Server is outside your domain and therefore, Excel believes you may not want to open the file.

## Resolution

To open a Dynamic Worksheet:

1. Right-click on the file that you have saved and select **Properties**.
2. Select **Unblock** in the **Security** section on the **General** tab.
3. Select **Apply** and **OK** to close the **Properties** window.
4. Double-click the file to open it in Excel.
5. You may see the message **To view and refresh dynamic data, Microsoft Dynamics CRM for Outlook must be installed**. If it is already installed and configured, select **Refresh from CRM** to sign in to Microsoft Dynamics CRM. If you do not want to be prompted again to sign in, select **Save my e-mail address and password** on the **Sign In** page.

    1. If you select **Refresh All** on the **Data** tab, you will still see the error that it was unable to open the page.
    2. Select **Connections** on the **Data** tab.
    3. Highlight the Connection and select **Properties**.
    4. Select the **Definition** tab and select **Edit Query**.
    5. Select **Yes** if you are prompted with an HTTPS warning.
    6. Sign in to Microsoft Dynamics CRM Online, or with your Domain Credentials if you have Claims and IFD enabled for Microsoft Dynamics CRM 2011 On Premise.
    7. You will see a generic error; select **OK**.
    8. Select **Cancel** in the **Edit Web Query** window.
    9. Select **Ok** to close the **Connection Properties** window.
    10. Select **Close** to close the **Workbook Connections** window.

6. Select **Refresh All** and your data should now appear.

To open a Static worksheet that you have marked for reimporting:

1. Right-click on the file that you saved, and select **Properties**.
2. Select **Unblock** in the **Security** section of the **General** tab.
3. Double-click the file to open it in Excel.
