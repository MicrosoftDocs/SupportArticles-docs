---
title: Error when you open Enterprise or Computer Compliance Reports in MBAM
description: Provides a solution to an error that occurs when you open Enterprise or Computer Compliance Reports in MBAM.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika,  yitzhaks, manojse
ms.custom: sap:bitlocker, csstroubleshoot
---
# Error when you open Enterprise or Computer Compliance Reports in MBAM

This article provides a solution to an error that occurs when you open Enterprise or Computer Compliance Reports in Microsoft BitLocker Administration and Monitoring (MBAM).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2639518

## Symptoms

When a user uses a specific account for SQL Server Reporting Service (SSRS) in the MBAM wizard, they may not open any reports for MBAM and it fails with the below error message.

> An error has occurred during report processing. (rsProcessingAborted)  
> Cannot impersonate user for data source 'MaltaDataSource'. (rsErrorImpersonatingUser)  
> Log on failed. Ensure the user name and password are correct. (reLogonFailed)  
> Logon failure: unknown user name or bad password

:::image type="content" source="media/error-when-opening-reports-mbam/rsprocessingaborted-error.png" alt-text="Error message that is shown in BitLocker Administration and Monitoring." border="false":::

## Cause

The above error occurs when the MBAM SSRS password that was used during MBAM setup wizard is changed or expired or the account is deleted from Active Directory.

## Resolution

To resolve this issue, follow the steps from below:

1. Open web browser and go to `http://servername/Reports/Pages/Folder.aspx`.

    > [!NOTE]
    > If your password is expired, then you might get an access denied error message when you try to open the above web page.  
    In this case, you will first have to connect to SQL Reporting Services using SQL Management Studio with your new password and you will be able to access the above webpage.

2. Click Microsoft BitLocker Administration and Monitoring.
3. Click **Malta Data Source** (see screenshot below).

    :::image type="content" source="media/error-when-opening-reports-mbam/malta-data-source-setting.png" alt-text="Properties setting page of Malta Data Source.":::

4. Make sure you have Windows-integrated security selected.
5. Click **Test Connection** and then click **Apply**.
6. Now you can view the MBAM Enterprise and Computer Compliance Reports successfully.
