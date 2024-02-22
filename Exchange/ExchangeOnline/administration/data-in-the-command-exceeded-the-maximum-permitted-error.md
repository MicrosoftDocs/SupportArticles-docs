---
title: Data in the command exceeded the maximum permitted error
description: Describes an issue that triggers an error when you run the Get-Mailbox -ResultSize Unlimited command to retrieve info about Exchange Online mailboxes in your organization.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-mosha, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Data in the command exceeded the maximum permitted by the session configuration error when running Get-Mailbox -ResultSize Unlimited

_Original KB number:_ &nbsp; 2922668

## Symptoms

When you use the remote Exchange PowerShell command Get-Mailbox -ResultSize Unlimited to retrieve information about Exchange Online mailboxes in your organization, you receive an error message that resembles the following:

> [ClientAccessServer=XXXXXXXXXCA014,`BackEndServer=XXXXXXmb294.namprd05.prod.outlook.com`,RequestId=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx,TimeStamp=\<Date>\<Time>] The data in the command exceeded the maximum permitted by the session configuration. The allowed maximum is 500MB. Change the input, use a different session configuration, or change the "PSMaximumReceivedObjectSizeMB" and "PSMaximumReceivedDataSizePerCommandMB" properties of the session configuration on the remote computer

## Cause

This issue occurs when the process times out as it tries to retrieve a large volume of data in one session. This issue may occur when you try to retrieve mailbox information from a very large organization.

## Workaround

To work around this issue, run the command to execute on the server, and then add a pause between each command to prevent throttling.

### Step 1 - Retrieve the list of objects from the server

Use the `Invoke-Command` cmdlet to execute the commands from the server. For example:

```powershell
$mailboxes = Invoke-Command -Session (Get-PSSession) -ScriptBlock {Get-Mailbox -ResultSize Unlimited | Select-Object -Property Identity,DisplayName}
```

### Step 2 - Add a pause between each command

Use the `Start-Sleep` cmdlet to add a pause between each object that's being processed. For example:

```powershell
foreach($m in $mailboxes) {Get-MailboxPermission $m.Identity.ToString() | Where { ($_.AccessRights -eq "FullAccess") -and ($_.IsInherited -eq $False) -and -not ($_.User -like "NT AUTHORITY\SELF")}; Start-Sleep -Milliseconds 500}
```

## More information

For more information, see the following Microsoft TechNet resources:

- [Invoke-Command](/powershell/module/microsoft.powershell.core/invoke-command?view=powershell-7&preserve-view=true)
- [Start-Sleep](/powershell/module/microsoft.powershell.utility/start-sleep?view=powershell-7&preserve-view=true)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
