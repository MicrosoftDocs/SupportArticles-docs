---
title: Console crashes after upgrading to version 2107
description: The Configuration Manager console crashes after you update to Configuration Manager current branch, version 2107.
ms.date: 12/05/2023
ms.reviewer: kaushika, payur
author: helenclu
ms.author: luche
---
# Console crashes after you upgrade to Configuration Manager, version 2107

*Applies to*: Configuration Manager (current branch)

## Symptoms

When you open the Configuration Manager console after you upgrade to [Configuration Manager current branch, version 2107](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2107), the console crashes.

The following entries are logged in *SMSAdminUI.log*:

> \<Date\> \<Time\>    15 (0xf)    Executing static method SMS_Identification.GetReportVersion()  
> \<Date\> \<Time\>    15 (0xf)    System.ArgumentException  
> **Version string portion was too short or too long.**  
> &nbsp;&nbsp;&nbsp; at System.Version.VersionResult.SetFailure(ParseFailureKind failure, String argument)  
> &nbsp;&nbsp;&nbsp; at System.Version.TryParseVersion(String version, VersionResult& result)  
> &nbsp;&nbsp;&nbsp; at System.Version.Parse(String input)  
> &nbsp;&nbsp;&nbsp; at System.Version..ctor(String version)  
> &nbsp;&nbsp;&nbsp; at Microsoft.ConfigurationManagement.ManagementProvider.WqlQueryEngine.WqlConnectionManager.Connect(String configMgrServerPath)  
> &nbsp;&nbsp;&nbsp; at Microsoft.ConfigurationManagement.AdminConsole.SmsSiteConnectionNode.GetConnectionManagerInstance(String connectionManagerInstance)

You run the following PowerShell cmdlet to call the **SMS_Identification.GetReportVersion** method:

```powershell
PS <SiteCode>:\> Invoke-CMWmiMethod -ClassName SMS_Identification -MethodName GetReportVersion -parameter @{ Sitecode = '<SiteCode>' }
```

And you receive the following results:

```output
SmsProviderObjectPath : __PARAMETERS
ReturnValue : 0
ServerName : {<Site server that hosts the reporting services point>}
SSRSVersion : {}
```

In this situation, the returned value of **SSRSVersion** is empty.

## Cause

This issue occurs because the console can't get the installed SQL Server Reporting Services (SSRS) version from the site database. This issue occurs if the reporting services point isn't correctly installed or reinstalled after the upgrade.

## Resolution

To fix the issue, install [Update rollup for Microsoft Endpoint Configuration Manager version 2107](/mem/configmgr/hotfix/2107/11121541).

## Workaround

To work around the issue, use one of the following methods.

### Method 1

1. Fix any issues that affect SSRS, and make sure that the following URLs are accessible:

   - The Report Manager URL. For example, `https://<server>/Reports`.
   - The Report Server URL. For example, `https://<server>/ReportServer`.
1. Use an older version of console to connect to the site, and reinstall the reporting services point.

### Method 2

1. Run the following PowerShell cmdlet to uninstall the reporting services point:

   ```powershell
   Remove-CMSiteRole -SiteSystemServerName "<FQDN of the site server that hosts the reporting services point>" -RoleName "SMS SRS Reporting Point"
   ```

1. After you fix the underlying SSRS issue, run the following PowerShell cmdlet to reinstall the reporting services point:

   ```powershell
   Add-CMReportingServicePoint -SiteCode "<SiteCode>" -SiteSystemServerName "<FQDN of the site server that hosts the reporting services point>" -UserName <Domain\ReportingUser>
   ```
