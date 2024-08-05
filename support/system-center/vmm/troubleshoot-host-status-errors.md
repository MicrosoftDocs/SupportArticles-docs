---
title: Troubleshoot host status in Virtual Machine Manager
description: Provides troubleshooting guidance for the Needs Attention, Not Responding, and Access Denied host status in Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, jeffpatt
---
# Troubleshoot Needs Attention, Not Responding, and Access Denied hosts in Virtual Machine Manager

This article discusses how to troubleshoot the **Needs Attention**, **Not Responding**, and **Access Denied** host status in System Center 2012 and later versions of Virtual Machine Manager. Any referenced articles also apply to System Center 2012 and later versions of Virtual Machine Manager.

> [!NOTE]
> **Home users**: This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2016 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2742246

## Summary

The **Needs Attention**, **Not Responding**, and **Access Denied** hosts in the VMM console occurs because the VMM Server is unable to communicate with the host machine or components (WMI, WinRM, and so on) on the host machine that are used to communicate with the VMM server are not functioning correctly.

The following are common errors that are logged in the **Jobs** views in the VMM console when the host status is **Needs Attention**, **Not Responding**, or **Access Denied**.

> Error (2911)  
> Insufficient resources are available to complete this operation on the servername.contoso.com server. (Not enough storage is available to complete this operation (0x8007000E))
>
> Error (2912)  
> An internal error has occurred trying to contact an agent on the servername.contoso.com server. (No more threads can be created in the system (0x800700A4))
>
> Warning (2915)  
> The Windows Remote Management (WS-Management) service cannot process the request. The object was not found on the server (servername.contoso.com). Unknown error (0x80041002) or Unknown error (0x80338000)
>
> Error (2916)  
> VMM is unable to complete the request. The connection to the agent servername.contoso.com was lost. Unknown error (0x80338126) or Unknown error (0x80338012)
>
> Error (2927)
A Hardware Management error has occurred trying to contact server servername.contoso.com. Unknown error (0x803381a6)
>
> Warning (12710)  
> VMM does not have appropriate permissions to access the Windows Remote Management resources on the server (servername.contoso.com). Unknown error (0x80338104)
>
> Warning (13926)  
> Host cluster servername.contoso.com was not fully refreshed because not all of the nodes could be contacted. Highly available storage and virtual network information reported for this cluster might be inaccurate.
>
> Error (20506)  
> Virtual Machine Manager cannot complete the Windows Remote Management (WinRM) request on the computer servername.contoso.com.
>
> Warning (13926)  
> Host cluster servername.contoso.com was not fully refreshed because not all of the nodes could be contacted. Highly available storage and virtual network information reported for this cluster might be inaccurate.
>
> Error (406)  
> Access has been denied while contacting the computer servername.contoso.com.

Perform the following steps to identify the cause of the **Needs Attention**, **Not Responding**, or **Access Denied** host status.

## Step 1: Check the health status of the host

To check the health status of a host, perform the following steps:

1. Open the VMM console.
2. Select the Fabric view, right-click the host that's experiencing issues and then choose **Properties**.
3. Within the host properties, select **Status**.
4. Select the category that has the red exclamation to view the error details.

For more information on the host health check feature, see [Host Properties– New in VMM 2012 expanded host health checks](https://techcommunity.microsoft.com/t5/system-center-blog/host-properties-8211-new-in-vmm-2012-expanded-host-health-checks/ba-p/344409).

## Step 2: Verify the VMM service account is a member of the local administrator group on the host

- If the VMM service is running under a domain account, verify the domain account is a member of the local administrator group on the host.
- If the VMM is running under the local system account, verify the computer account is a member of the local administrator group on the host.

If the VMM service account is removed from the local administrator group on the host, this issue could be caused by a **Restricted Groups** Group Policy.

To resolve this issue, perform one of the following steps:

- Add the VMM service account to the administrators' **Restricted Groups** Group Policy setting.
- Create a new organizational unit (OU) in the domain, move the host computer object to the new OU and then configure the new organizational unit to block policy inheritance.

## Step 3: Check for corrupted performance counters

Check the Application event log on the host to see if the following event is logged:

> Log Name:      Application  
> Source:        Microsoft-Windows-LoadPerf  
> Event ID:      3012  
> Description:  
> The performance strings in the Performance registry value is corrupted when process Performance extension counter provider. The BaseIndex value from the Performance registry is the first DWORD in the Data section, LastCounter value is the second DWORD in the Data section, and LastHelp value is the third DWORD in the Data section.

If the event ID 3012 is logged on the host machine, perform the steps documented in [How to manually rebuild Performance Counters for Windows Server 2008 64bit or Windows Server 2008 R2 systems](https://support.microsoft.com/help/2554336) to rebuild the performance counters.

## Step 4: Check the Svchost.exe process of the Windows Remote Management service

VMM depends on the Windows Remote Management service for host communication. Therefore, the **Not Responding** status is likely to occur because of an error in the underlying Windows Remote Management communication between the VMM server and the host computer. In this scenario, the host status is **OK** shortly after you restart the host computer. However, the status changes to **Not Responding** after three to four hours, and jobs on the VMM server fail and return an error that resembles the following:

> Error (2927)  
> A Hardware Management error has occurred trying to contact server *servername.contoso.com*.
Unknown error (0x803381a6)

Additionally, if you stop the Windows Remote Management service at a command prompt, this process takes much longer than usual to be completed. Sometimes, it can take up to five minutes to stop.

This problem can occur if the shared Svchost.exe process that hosts the Windows Remote Management service is experiencing issues.

To resolve this problem, configure the Windows Remote Management service to run in a separate Svchost.exe process. To do this, open an elevated command prompt, type the following command and then press Enter.

```console
sc config winrm type= own
```

> [!NOTE]
> Make sure that you type the command exactly as it appears here. Notice the space after the equal sign (=) symbol.

If the command is completed successfully, you should see the following output:

> [SC] ChangeServiceConfig SUCCESS

## Step 5: Increase the default values for WinRM

As a best practice, run the following command lines on the VMM host and all the Hyper-V hosts that are being managed by VMM (and press Enter after each line).

```console
Winrm quickconfig
winrm set winrm/config @{MaxTimeoutms="1800000"}
winrm set winrm/config/Service @{MaxConcurrentOperationsPerUser="1500"}
winrm set winrm/config/winrs @{MaxConcurrentUsers="100"}
winrm set winrm/config/winrs @{MaxProcessesPerShell="100"}
winrm set winrm/config/winrs @{MaxShellsPerUser="100"}
```

```powershell
set-item "WSMan:\localhost\Plugin\WMI Provider\Quotas\MaxConcurrentOperationsPerUser" 400
```

You must restart WinRM (for the WINRM changes) and restart WMI (for the SC config setting), or reboot the server for the changes to take effect.

When you add untrusted hosts or perimeter/workgroup hosts, make sure that the `LocalAccountTokenFilterPolicy` registry value under the following registry subkey is set to **1**:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`
