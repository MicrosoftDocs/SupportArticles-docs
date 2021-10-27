---
title: Console crashes after upgrading to version 2107
description: 
ms.date: 09/02/2021
ms.prod-support-area-path: 
ms.reviewer: buzb, lamosley
author: helenclu
ms.author: luche
---
# Console crashes after you upgrade to Configuration Manager version 2107

*Applies to*: Configuration Manager (current branch)

## Symptoms

When you open the the Configuration Manager console after you upgrade to [Configuration Manager current branch version 2107](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2107), the console crashes.

The following entries are logged in the SMSAdminUI.log file:

```output
<Date> <Time>    15 (0xf)    Executing static method SMS_Identification.GetReportVersion()
<Date> <Time>    15 (0xf)    System.ArgumentException
Version string portion was too short or too long.
   at System.Version.VersionResult.SetFailure(ParseFailureKind failure, String argument)
   at System.Version.TryParseVersion(String version, VersionResult& result)
   at System.Version.Parse(String input)
   at System.Version..ctor(String version)
   at Microsoft.ConfigurationManagement.ManagementProvider.WqlQueryEngine.WqlConnectionManager.Connect(String configMgrServerPath)
   at Microsoft.ConfigurationManagement.AdminConsole.SmsSiteConnectionNode.GetConnectionManagerInstance(String connectionManagerInstance)
```

## Cause

This issue occurs because the console tries to get the SSRS version installed from the site database. If SSRS Reporting Point was not properly (re)installed after the upgrade, the version will be empty, hence the exception.


Quick check is possible via ConfigMgr PowerShell:

PS <SiteCode>:\> Invoke-CMWmiMethod -ClassName SMS_Identification -MethodName GetReportVersion -parameter @{ Sitecode = '<SiteCode>' }

SmsProviderObjectPath : __PARAMETERS

ReturnValue : 0

ServerName : {SRS RP FQDN}

SSRSVersion : {} Healthy SSRS should have version filled in there.

Article Resolution
Fix underlying issue with SRSS and make sure /Reports and /ReportServer URLs are accessible

Then use older console build to connect the site and reinstall SRSRP role.


To unblock the customer, you can uninstall the role via PowerShell:

Remove-CMSiteRole -SiteSystemServerName "<put your SRS RP FQDN here>" -RoleName "SMS SRS Reporting Point"

Later you may want to install SSRS back:

Add-CMReportingServicePoint -SiteCode "<SiteCode>" -SiteSystemServerName "<put your SRS RP FQDN here>" -UserName <Domain\ReportingUser>
