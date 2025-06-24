---
title: Archive mailbox issues for a mailbox that's migrated to or from Microsoft 365
description: Describes archive mailbox issues for a mailbox that's migrated to or from Microsoft 365. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
ms.reviewer: chrisbur
appliesto: 
  - Exchange Online
  - Exchange Server 2003 Service Pack 2
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 05/05/2025
---

# Archive mailbox issues for a mailbox that's migrated to or from Microsoft 365

_Original KB number:_&nbsp;2757430

## Problem

When you migrate a mailbox to or from Microsoft 365 and use an archive mailbox, you experience an issue in which the Microsoft Exchange Mailbox Replication service (MRS) in Microsoft Exchange Online stamps the target domain value of the ArchiveDomain property of the mailbox at the end of the migration.

> [!NOTE]
> The issue shouldn't occur on an account that doesn't have an archive mailbox.

There are five scenarios that are related to archive mailboxes. Each scenario requires a different resolution.

- Scenario 1 - Onboarding: You move your on-premises Microsoft Exchange Server mailboxes to Exchange Online.
- Scenario 2 - Onboarding: Your archive mailbox exists in Exchange Online, and you move your primary mailbox from your on-premises Exchange Server environment to Exchange Online.
- Scenario 3 - Offboarding: You enable an archive mailbox and then migrate both your primary and archive mailboxes from Exchange Online to your on-premises Exchange Server environment. A similar scenario occurs when your primary mailbox is already on-premises and you decide to offboard your archive mailbox from Exchange Online to your on-premises Exchange Server environment.
- Scenario 4 - Offboarding: Your primary mailbox does not have an archive mailbox enabled, and you move your primary mailbox from Exchange Online to your on-premises Exchange Server environment.
- Scenario 5 - Offboarding: Your primary mailbox exists in your on-premises Exchange Server environment, and your archive mailbox exists in Exchange Online. This scenario may occur when you take one of the following actions:
  - You offboard your primary mailbox. However, you leave your archive mailbox in Exchange Online.
  - Both primary and archive mailboxes are located in your on-premises Exchange Server environment. However, you onboard only your archive mailbox.
  > [!NOTE]
  > The only supported archive split scenario is a primary mailbox on-premises and an archive mailbox in Exchange Online.

## Cause

This issue occurs if a mailbox is migrated between an on-premises Exchange Server environment and Exchange Online.

If you use the following Windows PowerShell cmdlet to view the archive properties, you notice that the archive status is Active. However, much of the archive information is missing.

```powershell
Get-Mailbox alias |fl Name, Archive*
```

> [!NOTE]
> You can use either the on-premises Exchange Management Shell or Exchange Online PowerShell to run the cmdlet. For more info about how to use Exchange Online PowerShell, go to [Connect Windows PowerShell to the Service](/powershell/exchange/connect-to-exchange-online-powershell).

When you run the cmdlet, the result resembles the following:

```console
Name : jsmith
ArchiveDatabase :
ArchiveGuid : 00000000-0000-0000-0000-000000000000
ArchiveName : {}
ArchiveQuota : 100 GB (107,374,182,400 bytes)
ArchiveWarningQuota : 90 GB (96,636,764,160 bytes)
ArchiveDomain : contoso.mail.onmicrosoft.com
ArchiveStatus : Active
```

## Solution

To resolve this issue, use one of the following methods, as appropriate for your scenario.

### Scenario 1

The issue in scenario 1 was resolved as follows: All onboarding migrations to Exchange Online are addressed and the ArchiveDomain property is no longer set until the archive mailbox is enabled by the tenant administrator.

Before this issue was resolved, users reported the presence of an archive mailbox in Outlook and received authentication prompts. However, users can't see the same archive mailbox in Outlook Web App. (Microsoft refers to the archive as a 'ghost archive' because it is not a true archive mailbox that can be accessed by users.  

### Scenario 2

The issue in scenario 2 was resolved as follows: The MRS component that's responsible for moving mailboxes now correctly factors in the presence of an Exchange Online archive mailbox. Therefore, users can correctly access their archive mailboxes in Outlook or Outlook Web App without any errors. No action is required.  

### Scenario 3

The issue in both variations of scenario 3 is resolved as follows: MRS in Exchange Online sets the value of the
ArchiveDomain property to the on-premises domain. Therefore, users can correctly access their archive mailboxes in Outlook or Outlook Web App without any errors. No action is required.  

### Scenario 4

The issue in scenario 4 was resolved as follows: In this scenario, MRS in Exchange Online sets the value of the ArchiveDomain property to the on-premises domain. Therefore, users see the presence of an archive mailbox in Outlook, even though the archive mailbox is not enabled. This archive resembles the 'ghost archive' that's mentioned the 'Resolution' section for scenario 1. However, the archive still requires the Exchange administrator of the on-premises Exchange Server environment to run the script that's provided in the 'Resolution of Scenario 5' section. Microsoft deployed an update to resolve this scenario. Therefore, future offboarding will not be affected.

To determine whether you are affected when you perform an offboarding migration from Exchange Online, run the script that's provided in the 'Resolution of Scenario 5' section in scan mode.  

### Scenario 5

In this scenario, the value of the ArchiveDomain property is set to the on-premises domain. Therefore, Outlook can't locate and open the archive mailbox.

To resolve scenarios 4 and 5, Microsoft provides the following script to help change the necessary attributes automatically if you move your mailboxes from Exchange Online back to your on-premises Exchange Server environment. To run the script, follow these steps:

1. Start Notepad.
1. Copy and paste the following script in Notepad:

```powershell
#-------------------------------------------------------------------------------
#
# Copyright (c) Microsoft Corporation. All rights reserved.
#
# PLEASE NOTE:
# Microsoft Corporation (or based on where you live, one of its affiliates)
# licenses this supplement to you. You may use it with each validly licensed
# copy of Microsoft Online Services Migration Tools software (the "software").
# You may not use the supplement if you do not have a license for the software.
# The license terms for the software apply to your use of this supplement.
# Microsoft may provide support services for the supplement as described at
# http://www.support.microsoft.com/common/international.aspx.
#
#-------------------------------------------------------------------------------
#
# PowerShell Source Code
#
param([Parameter(Mandatory = $false)]
[string]$TenantCloudDomain,
[Parameter(Mandatory = $false)]
[string]$Domain,
[Parameter(Mandatory = $false)]
[Switch]$Fix,
[Parameter(Mandatory = $false)]
[Switch]$FindAllUsersInForest
)
function GetNameFromDN([string]$dn)
{
if ($dn.Length -eq 0) { return $null; }
return ($dn -split ",")[0].Replace("CN=", "")
}
Import-Module ActiveDirectory
If ($TenantCloudDomain.Length -eq 0) {
$ldapQuery = "(&(objectClass=user)(msExchArchiveAddress=*))"
} else {
$ldapQuery = "(&(objectClass=user)(msExchArchiveAddress=*)(!(&(msExchArchiveGuid=*)(!(msExchArchiveDatabaseLink=*))(msExchArchiveAddress=$TenantCloudDomain))))"
}
if ($Domain.Length -eq 0) {
# default domain to computer's domain
$computer = Get-WmiObject -Class Win32_ComputerSystem
$Domain = $computer.Domain
}
if ($FindAllUsersInForest -and $Fix) {
throw "You cannot specify -FindAllUsersInForest when running in -Fix mode, only one domain can be cleaned up at a time."
}
Write-Host "Looking for objects to clean up in ${Domain}: ${ldapQuery}"
$propertiesToLoad = @("msExchMailboxGuid","homeMDB","msExchArchiveGuid","msExchArchiveDatabaseLink","msExchArchiveAddress")
$tsStart = [DateTime](Get-Date)
if ($FindAllUsersInForest) {
$m = Get-ADObject -Server "${Domain}:3268" -SearchBase "" -LDAPFilter $ldapQuery -ResultSetSize $null -Properties $propertiesToLoad
} else {
$m = Get-ADObject -Server $Domain -LDAPFilter $ldapQuery -ResultSetSize $null -Properties $propertiesToLoad
}
$elapsed = [DateTime](Get-Date) - $tsStart
if ($m -eq $null) {
Write-Host "No objects need to be cleaned up."
return
}
$cleanedCount = 0
$failedCount = 0
$filename = $("~\ArchiveDomainCleanup_{0:yyyymmdd_HHmmss}.csv" -f (Get-Date))
# Run cleanup and output data to CSV file
Write-Host "Writing output to $filename..."
try {
$m | %{
$success = $true
if ($Fix) {
$prevError = $error[0]
Set-ADObject -Identity $_ -Server $Domain -Clear "msExchArchiveAddress"
if ($error[0] -ne $prevError) {
$success = $false
Write-Host "x" -NoNewLine
} else {
Write-Host "." -NoNewLine
}
}
if ($success) {
$cleanedCount++
# object was cleaned up successfully, let's append it to output CSV.
$mm = $_ | Select ObjectGuid,DistinguishedName
# Morph guid values from binary blob to proper guid
$mbxGuid = [Guid]$_.msExchMailboxGuid
if ($_.msExchArchiveGuid -ne $null) {
$archiveGuid = [Guid]$_.msExchArchiveGuid
} else {
$archiveGuid = $null
}
Add-Member -InputObject $mm -MemberType NoteProperty -Name CleanedArchiveDomain -Value $($_.msExchArchiveAddress)
Add-Member -InputObject $mm -MemberType NoteProperty -Name ExchangeGuid -Value $mbxGuid
Add-Member -InputObject $mm -MemberType NoteProperty -Name Database -Value $(GetNameFromDN $_.homeMDB)
Add-Member -InputObject $mm -MemberType NoteProperty -Name ArchiveGuid -Value $archiveGuid
Add-Member -InputObject $mm -MemberType NoteProperty -Name ArchiveDatabase -Value $(GetNameFromDN $_.msExchArchiveDatabaseLink)
$mm
} else {
$failedCount++
}
} | Export-CSV $filename -NoTypeInformatio
}
finally {
if ($Fix) {
Write-Host ""
Write-Host "Cleaned up $cleanedCount recipients."
if ($failedCount -gt 0) {
Write-Warning "Failed to update $failedCount recipients."
}
} else {
Write-Host "Discovered $cleanedCount recipients."
}
}
```

1. On the **File** menu, click **Save**.
1. In the **Save As Type** box, click **All Files (*.*)**.
1. In the **File name** box, typeCleanup-ArchiveDomain.ps1, and then click **Save**.
1. Locate the directory in which you saved the Cleanup-ArchiveDomain.ps1 file, and then run the script together with the following parameters:

```powershell
Cleanup-ArchiveDomain.ps1 [-TenantCloudDomain serviceDomain] [-Domain domain] [-Fix] [-FindAllUsersInForest]
```

> [!NOTE]
>
> - The TenantCloudDomain parameter should be specified only if the tenant uses cloud archive functionality. The value of the parameter should be the DNS domain name that the tenant uses to access cloud archives, such as *contoso*.com.
> - The Domain parameter is used to run cleanup functionality in a domain that's not the domain of current computer.
> - The Fix switch triggers the actual cleanup functionality. The default function of the switch (also known as 'scan mode') is just to find the users and then output them to a CSV file.
> - TheFindAllUsersInForest switch searches a global catalog and finds all affected users in the local forest (across all domains). However, this switch can't be combined with the Fix switch. You can fix users in only one domain at a time.  

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
