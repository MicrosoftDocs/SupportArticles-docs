---
title: Error 2927 adding a Hyper-V server or cluster node
description: Fixes an issue in which you receive error 2927 when you add a Hyper-V server or a Hyper-V cluster node on a Virtual Machine Manager server.
ms.date: 04/09/2024
ms.reviewer: wenca, jchornbe
---
# Error 2927 when you add a Hyper-V server or a Hyper-V cluster node in VMM

This article helps you fix an issue in which you receive error 2927 when you add a Hyper-V server or a Hyper-V cluster node on a Virtual Machine Manager (VMM) server.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager, System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2875120

## Symptoms

Consider the following scenario. You add a Hyper-V server or a Hyper-V cluster node on a server that's running one of the following versions of Microsoft System Center Virtual Machine Manager:

- System Center 2012 R2 Virtual Machine Manager
- System Center 2012 Virtual Machine Manager

In this scenario, you receive the following error message:

> Error (2927)  
> A Hardware Management error has occurred trying to contact server <*servername*>.  
> (Unknown error (0x80338029))
>
> Recommended Action  
> Check that WinRM is installed and running on server <*servername*>. For more information use the command "winrm helpmsg hresult".

## Cause

This issue may occur in one of the following situations:

- Antivirus software is installed but configured incorrectly on the VMM server.
- The Hyper-V host is a node of a high availability (HA) cluster, and the cluster has issues.
- Windows Remote Management (WinRM) is configured incorrectly.

## Resolution

### Step 1: Run a cluster validation report if the Hyper-V host is a node of an HA cluster

If the Hyper-V host is a node of an HA cluster, run a cluster validation report, and fix errors if there are errors in the report.

### Step 2: Configure exclusions of the antivirus software

To configure exclusions of the antivirus software, follow these steps:

1. Test whether the Hyper-V host can be added after you disable the antivirus software on the VMM server.
2. If the test succeeds, make sure that the following directories and files are added to the exclusion list of the antivirus software:

   - `%systemroot%\cluster\clussvc.exe`
   - `%systemroot%\system32\vds.exe`
   - Directories and files that are listed in [Hyper-V: Anti-Virus Exclusions for Hyper-V Hosts](https://social.technet.microsoft.com/wiki/contents/articles/2179.hyper-v-anti-virus-exclusions-for-hyper-v-hosts.aspx)
   - Directories and files that are listed in [Virtual machines are missing, or error 0x800704C8, 0x80070037, or 0x800703E3 occurs when you try to start or create a virtual machine](../../windows-server/virtualization/vm-missing-0x800704c8-0x80070033-0x800703e3.md)
   - Directories and files that are listed in [Virus scanning recommendations for Enterprise computers that are running currently supported versions of Windows](https://support.microsoft.com/help/822158)
   - Directories and files that are listed in [Microsoft Anti-Virus Exclusion List](https://social.technet.microsoft.com/wiki/contents/articles/953.microsoft-anti-virus-exclusion-list.aspx)

### Step 3: Check whether WinRM is configured correctly

To check whether WinRM is configured correctly, follow these steps:

1. Open an elevated command prompt on the Hyper-V host, run `winrm qc`, and then restart the host. For more information, see [WinRM (Windows Remote Management) Troubleshooting](/archive/blogs/jonjor/winrm-windows-remote-management-troubleshooting).

2. Increase the default value for the WinRM time-out. To do this, open an elevated command prompt on the Hyper-V host, and then execute the following commands:

   1. Set the maximum timeout in milliseconds to 1,800,000.

      ```console
      winrm set winrm/config @{MaxTimeoutms = "1800000"}
      ```

   2. In WinRM 1.1 and earlier versions:

      ```console
      winrm set winrm/config/Service @{MaxConcurrentOperations="200"}
      ```

      Or, in WinRM 2.0 and later versions:

      ```console
      winrm set winrm/config/Service @{MaxConcurrentOperationsPerUser="400"}
      ```

   3. Restart the WinRM service:

      ```console
      net stop winrm
      net start winrm
      ```

   4. Start the VMM agent:

      ```console
      net start vmmagent
      ```

3. Check the Svchost.exe process of the WinRM service. If the shared Svchost.exe process that hosts the WinRM service is experiencing issues, run the following command to configure the WinRM service to run in a separate Svchost.exe process:

    ```console
    sc config winrm type= own
    ```

    For more information, see [Step 5: Increase the default values for WinRM](troubleshoot-host-status-errors.md#step-5-increase-the-default-values-for-winrm).

4. If you experience the issue that's described in [WinRM operations to Hyper-V fail on a Windows 7 SP1-based or Windows Server 2008 R2 SP1-based computer that has Windows Management Framework 3.0 installed](https://support.microsoft.com/help/2781512), install the hotfix on the Hyper-V host.

## References

- [Antivirus software that is not cluster-aware may cause problems with Cluster Services](https://support.microsoft.com/help/250355)
- [About Preconfigured Policy Templates](/previous-versions/tn-archive/gg412475(v=technet.10))
