---
title: VM templates list is missing on the WAP tenant site
description: Describes an issue that prevents the list of VM templates on the Windows Azure Pack site from being displayed as expected. The workaround involves increasing the outgoing web request time-out setting in the TenantAPI web.config file.
ms.date: 04/09/2024
ms.reviewer: wenca, msadoff
---
# VM templates list is missing on the Windows Azure Pack tenant site

This article helps you work around an issue that you can't see the list of virtual machine templates on the Windows Azure Pack (WAP) tenant site.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, Windows Azure Pack (on Windows Server 2012 R2), Microsoft System Center 2012 R2 Orchestrator  
_Original KB number:_ &nbsp; 3051303

## Symptoms

In System Center 2012 R2 Virtual Machine Manager, users don't see the expected list of virtual machine (VM) templates on the Windows Azure Pack tenant site. Therefore, tenant users cannot deploy new virtual machines. Additionally, a red circle with an exclamation mark may appear in the lower-right corner of the tenant site when the webpage loads. If you select this circle, an error message may appear:

> Failed to load virtual machine templates for subscription \<subscription ID>

## Cause

This is a known issue in System Center 2012 R2 Virtual Machine Manager. This issue may occur when you enable a large number of VM templates for a Windows Azure Pack subscription. In this situation, web requests from the WAP tenant site may be time-out when Service Provider Foundation queries Virtual Machine Manager for the list of VM templates.

## Workaround

To work around this problem, increase the outgoing web request timeout setting in the TenantAPI web.config file. To do this, follow these steps:

1. Sign in to the WAP server by using a local administrator account.
2. Open the folder that corresponds to the TenantAPI IIS virtual directory. The default folder is `C:\inetpub\MgmtSvc-TenantAPI`.
3. In the folder for the TenantAPI virtual directory, create a copy of the web.config file.
4. Open an elevated PowerShell window.
5. Enter the following command in the PowerShell window:

   ```powershell
   Unprotect-MgmtSvcConfiguration TenantAPI
   ```

6. Use Notepad to open the web.config file from the TenantAPI virtual directory.
7. Look for the following line in the \<appSettings> element:

   \<add key="OutgoingCallsDefaultTimeoutInSeconds" value="100" />

8. If there's no \<add key> line for `OutgoingCallsDefaultTimeoutInSeconds`, create one.
9. Change the time-out value from the default (100 seconds) to a length of time that is sufficient for SPF to query the list of VM templates from VMM. For example, set the value to 180 to allow outgoing web requests three minutes to be completed.
10. Save and close the web.config file.
11. Enter the following command in the PowerShell window:

    ```powershell
    Protect-MgmtSvcConfiguration TenantAPI
    ```

12. In IIS Manager, recycle the MgmtSvc-TenantSite application pool. Or, run `iisreset` in the PowerShell window.
