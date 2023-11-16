---
title: Error message when Report Server service starts
description: This article helps you resolve the problem that occurs when you reset Report Server service account. 
ms.date: 09/21/2020
ms.custom: sap:Reporting Services
ms.reviewer: lukaszp
---
# Error message when the Report Server service starts or when you try to access the Reporting Services Web site or Power BI Report Server: 'Key not valid for use in specified state'

This article helps you resolve the problem that occurs when you reset Report Server service account. 

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 955757

## Symptoms

When you work with a computer that is running Microsoft SQL Server, you may receive the following error message in the Report Server service trace log:

> An internal error occurred on the report server. See the error log for more details. (rsInternalError) Get Online Help Key not valid for use in specified state. (Exception from HRESULT: 0x8009000B)

You may receive this error message when one of the following actions occurs:

- The Report Server service starts.
- You try to access the Reporting Services Web site.

Additionally, you may receive the following error message in the Report Server service trace log:

> ERROR: Exception caught while starting service.
>
> Error: Microsoft.ReportingServices.Diagnostics.Utilities.ReportServerDisabledException: The report server cannot decrypt the symmetric key used to access sensitive or encrypted data in a report server database. You must either restore a backup key or delete all encrypted content. Check the documentation for more information.

## Cause

Typically, this problem occurs when the Report Server service account password is reset.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1: Restore the symmetric key

> [!NOTE]
> To use this method, you must have a backup copy of the symmetric key available.

To restore the symmetric key, follow these steps:

1. Start the Reporting Services Configuration tool, and then connect to the report server that you want to configure.
2. On the **Encryption Keys** page, click **Restore**.
3. Click the .snk file that contains the Backup copy.
4. Type the password that unlocks the file.
5. Click **OK**.

### Method 2: Delete the encrypted content

> [!IMPORTANT]
> This method deletes all the encrypted content. This includes connection strings and stored credentials. Then, this method creates a new symmetric key. Only use this method if you cannot restore the symmetric key.

After you delete the encrypted content, you must reenter the missing connection strings and the missing stored credentials in the reports and in the shared data sources that no longer have these values. Additionally, you must update all the subscriptions that use delivery extensions that store encrypted data. This includes the file share delivery extension and any third-party delivery extension that uses encrypted values.

There is no automated way to update this information. You must update each report, each subscription, and each shared data source that uses stored credentials and connection strings one at a time.

To delete the encrypted content, follow these steps:

1. Start the Reporting Services Configuration tool, and then connect to the report server that you want to configure.
2. On the **Encryption Keys** page, click **Delete encrypted content**.

## References

- For more information about the Report Server service trace log, see [Report Server Service Trace Log](/previous-versions/sql/sql-server-2008/ms156500(v=sql.100)).
- For more information about how to restore the symmetric key, see [SSRS Encryption Keys - Back Up and Restore Encryption Keys](/sql/reporting-services/install-windows/ssrs-encryption-keys-back-up-and-restore-encryption-keys).
- For more information about encryption keys, see [Encryption Keys (Reporting Services Configuration)](/previous-versions/sql/sql-server-2008/ms189422(v=sql.100)).
