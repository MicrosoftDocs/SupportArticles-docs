﻿---
title: How to use Office 365 PowerShell to manage Microsoft Planner licenses
description: Describes how to use Office 365 PowerShell to manage Microsoft Planner licenses.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Office 365 Planner
---

# How to use Office 365 PowerShell to manage Microsoft Planner licenses

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Introduction

This article describes how to use Microsoft Office 365 PowerShell to manage licenses for Microsoft Planner.

## Procedure

The management of Microsoft Planner licenses differs between the First Release experience and General Availability (GA). In First Release, Microsoft Planner is a top-level SKU, and licenses aren't assigned to users by default. Whereas in General Availability, Microsoft Planner is an available service under your main Office 365 subscription, and licenses will be assigned to users by default. The following sections cover the First Release and General Availability scenarios. If you're in First Release and also see Microsoft Planner listed under your main Office 365 subscription, you must use both methods.

## First Release

Microsoft Planner requires licenses to be assigned to users before they can use the new Planner features. Therefore, it may be more convenient to use Office 365 PowerShell if you have many users in your Office 365 organization. This article discusses the prerequisites for using Office 365 PowerShell to administer an Office 365 organization, and it describes some options for assigning licenses to all users, to selected users based on metadata, and to selected users based on a list.

This article assumes that you're already using Office 365 PowerShell to administer Office 365. If you're not using Office 365 PowerShell, see the following Microsoft website to make sure that you have the prerequisites to run the commands that are discussed in [Connect to Office 365 PowerShell](https://technet.microsoft.com/library/dn975125.aspx).

The following command example assumes that you want to assign a license to all users. The cmdlet can be saved and executed as a .ps1 file. Or, you can run the script from the PowerShell Integrated Scripting Environment (ISE), because this is a one-time requirement.

```
Connect-MsolService

$licenseObj = Get-MsolAccountSku | Where-Object {$_.SkuPartNumber -eq "PLANNERSTANDALONE"}

$license = $licenseObj.AccountSkuId Get-MSOLUser | Set-MsolUserLicense -AddLicenses $license
```

The license string will resemble <*Contoso*>:PLANNERSTANDALONE. In this string, the <*Contoso*> placeholder represents the name of your organization.

If you want to assign a license to a subset of users based on other metadata of the user record, you can add a Where-Object filter in the last line of the code. For example, if the **Department** field is populated and you want to assign a license only where the department name is "Support," you can use the following cmdlet:

```
Get-MSOLUser | Where-Object {$_.department -eq 'Support'} | Set-MsolUserLicense -AddLicenses $license
```

If you want to create a file that includes a list of users and then remove from that list the names of the users to which you don't currently want licenses assigned, you can use the following cmdlet:

```
Connect-MsolService

$licenseObj = Get-MsolAccountSku | Where-Object {$_.SkuPartNumber -eq "PLANNERSTANDALONE"}

$license = $licenseObj.AccountSkuId

Get-MsolUser | Select-Object Displayname, UserPrincipalName | `

Export-CSV -Path d:\ExportedUsers.csv -NoTypeInformation

# Edit the file d:\ExportedUsers.csv and remove users who shouldn't be licensed before you run the following command

Import-Csv -Path d:\Exportedusers.csv | ForEach-Object `

{ Set-MsolUserLicense -UserPrincipalName $_.UserPrincipalName -AddLicenses $license}
```

If you want to remove licenses from users, replace -AddLicenses with -RemoveLicenses in any of these scripts.

## General Availability (GA)

After Microsoft Planner is GA, Microsoft Planner licenses are listed under your main Office 365 subscription alongside services such as Sway, Office Online, Skype, and so on (depending on your subscription). You may already see this before GA if you're in First Release as we prepare for the GA release.

By default, the license for Microsoft Planner will be enabled for all users. You can use PowerShell to disable it if you prefer. For more information, see [Disable access to services with Office 365 PowerShell](https://technet.microsoft.com/library/dn771769.aspx).

> [!NOTE]
> In the scripts, the DisabledPlans value for Microsoft Planner is PROJECTWORKMANAGEMENT.

## More information

For more information about how to use Office 365 PowerShell to administer users and licenses in Office 365, see the following Microsoft websites:

- [Create user accounts with Office 365 PowerShell](https://docs.microsoft.com/office365/enterprise/powershell/create-user-accounts-with-office-365-powershell)

- [How to use PowerShell to automatically assign licenses to your Office 365 users](https://social.technet.microsoft.com/wiki/contents/articles/15905.how-to-use-powershell-to-automatically-assign-licenses-to-your-office-365-users.aspx)
