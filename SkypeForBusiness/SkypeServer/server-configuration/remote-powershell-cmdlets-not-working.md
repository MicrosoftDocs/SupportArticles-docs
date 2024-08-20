---
title: Remote PowerShell cmdlets don't work
description: Discusses that Remote PowerShell cmdlets don't work in Skype for Business Server 2015 after update 3061064 is installed. Provides a resolution.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: v-six, genli, christys, UPKUMAR
appliesto: 
  - Skype for Business Server 2015
ms.date: 03/31/2022
---

# Remote PowerShell cmdlets don't work in Skype for Business Server 2015

> [!NOTE]
> Before you apply this article, make sure that you don't have update [3169706](https://support.microsoft.com/help/3169706/remote-powershell-can-t-connect-after-an-upgrade-to-windows-management-framework-5.0) installed on the affected system.

## Symptoms

After you install the February 2017 cumulative update ([KB3061064](https://support.microsoft.com/help/3061064/updates-for-skype-for-business-server-2015)) on a server that's running Microsoft Skype for Business Server 2015 CU4 or a later version, you can't connect to remote PowerShell or run any Skype for Business cmdlets through remote PowerShell.

When this problem occurs, you may receive the following error message:

```adoc
PS C:\Windows\system32> $session = New-PSSession -ConnectionUri "https:///OcsPowershell" -Credential
$credential -SessionOption $sessionOption
New-PSSession : [<ServerName>] Connecting to remote server <ServerName> failed with the following error message: The SSL connection cannot be established. Verify that the service on the remote host is properly configured to listen for HTTPS requests. Consult the logs and documentation for the WS-Management service running on the destination, most commonly IIS or WinRM. If the destination is the WinRM service, run the following command on the destination to analyze and configure the WinRM service: "winrm quickconfig -transport: https". For more information, see the about_Remote_Troubleshooting Help topic.
At line:1 char:12
+ $session = New-PSSession -ConnectionUri "https:///OcsPowershe/OcsPowershe ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [New-PSSession], PSRemotingTransportException
+ FullyQualifiedErrorId : -2144108102,PSSessionOpenFailed
```

Additionally, if you run the Skype for Business Server 2015 Deployment Wizard, you notice the following status for steps 1 and 2 in the installation:

- Step 1 (Install or Update Skype for Business Server System) is shown as Partial.   
- Step 2 (**Setup or Remove Skype for Business Server Components**) is not shown as **Complete**.   

If you run the [Enable-CSReplica](/powershell/module/skype/Enable-CsReplica) command in the Skype for Business Server 2015 Management Shell, you notice the following error entry:

```adoc
Error: An error occurred: "System.MissingMethodException" "Method not found: 'Void System.Runtime.InteropServices.Marshal.StructureToPtr(!!0, IntPtr, Boolean)'."
WARNING: Detailed results can be found at C:\Users\seguim02admin\AppData\Local\Temp\Enable-CSReplica-[2017_03_16][15_15_56].html".Command execution failed: Method not found: 'Void System.Runtime.InteropServices.Marshal.StructureToPtr(!!0, IntPtr, Boolean)'.
```

## Cause

This issue occurs because the .NET Framework 4.5.2 isn't installed on the server that's running Microsoft Skype for Business Server 2015 CU4 or a later version.

## Resolution

To fix this issue, install the .NET Framework 4.5.2 update on Skype for Business Server 2015, and then restart the server. You can download the update from the following sources, depending on your installation method:

- [Microsoft .NET Framework 4.5.2 (Web Installer)](https://www.microsoft.com/en-in/download/details.aspx?id=42643)   
- [Microsoft .NET Framework 4.5.2 (Offline Installer)](https://www.microsoft.com/en-in/download/details.aspx?id=42642)   

## More information

To determine the .Net Framework version that's installed on the Skype for Business Server 2015 server, run the following cmdlet as an administrator in the Skype for Business Server 2015 Management Shell or in Windows PowerShell:

```powershell
Get-ChildItem -Path Registry::"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4"
```

In the output, make sure that the **Release** dword value is 379893 or greater.

For more information, see [How to: Determine Which .NET Framework Versions Are Installed](/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed?cs-lang=csharp&cs-save-lang=1#code-snippet-4).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
