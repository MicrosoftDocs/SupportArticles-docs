---
title: InvalidShellID error in RPS
description: Describes an issue that triggers an InvalidShellID error when a script is running long or when you run an administrative cmdlet in Remote PowerShell (RPS) in Microsoft 365. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# InvalidShellID error in RPS in Microsoft 365

_Original KB number:_ &nbsp; 3090768

## Symptoms

When a script is running long or when you run an administrative cmdlet in Remote PowerShell (RPS) in Microsoft 365, you intermittently receive an error message that resembles the following:

> Processing data for a remote command failed with the following error message:  
[ClientAccessServer=Server1,BackEndServer=Server2,RequestId=<>,TimeStamp=*DateTime*] [FailureCategory=WSMan-InvalidShellID] The request for the Windows Remote Shell with ShellId <> failed because the shell was not found on the server. Possible causes are: the specified ShellId is incorrect or the shell no longer exists on the server. Provide the correct ShellId or create a new shell and retry the operation. For more information, see the about_Remote_Troubleshooting Help topic.
>
> \+ CategoryInfo : OperationStopped: (mail.contoso.com:String) [], PSRemotingTransportException
>
> \+ FullyQualifiedErrorId : JobFailure
>
> \+ PSComputerName : mail. **contoso**.com

## Cause

This issue occurs if the following conditions are true:

- You are using an account that's associated with a mail-enabled user (MEU) in a multi-region environment.
- Connections are routed through a region that differs from the user's region.

This error may occur when a back-end server is removed from rotation to be upgraded. Additionally, this issue occurs infrequently.

## Resolution

### Scenario 1 - When a script is running long or when automated workflow stops

In this scenario, you may have to change the script to automatically reconnect if a server is removed from rotation while in progress. You can do this by using the appropriate error handling in the script to catch errors. Then, reconnect and restart processes.

### Scenario 2 - When you run an administrative cmdlet in RPS

In this scenario, you should rerun the cmdlet. A different back-end server should be contacted, and then the cmdlet should run successfully.

> [!NOTE]
> In a multi-region Exchange Online deployment, we recommend that you use administrative accounts that are mailbox-enabled. This makes sure that RPS connections are made through the current environment. If the administrative account is associated with an MEU, the connections may be routed through the other region. This behavior may delay the connection or trigger errors.

Microsoft may require a Fiddler trace to investigate this issue. If this is required, a support engineer will send a Support Diagnostics Package to securely capture and upload this information. To capture this information in the Fiddler trace, you must add a PowerShell session option with the `ProxyAccessType` parameter set to **IEConfig**. For example:

```powershell
Import-PSSession (New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://mail.contoso.com/powershell -Credential (Get-Credential) -Authentication Basic -AllowRedirection -SessionOption (New-PSSessionOption -ProxyAccessType IEConfig))
```

## More information

For more information about error handling, see [Weekend Scripter: Using Try, Catch, Finally blocks for PowerShell error handling](https://devblogs.microsoft.com/scripting/weekend-scripter-using-try-catch-finally-blocks-for-powershell-error-handling/).
