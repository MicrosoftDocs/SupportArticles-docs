---
title: Troubleshoot DPM protection agent installation issues
description: Troubleshoot some of the most common problems when installing System Center 2016 Data Protection Manager protection agent.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# Troubleshoot Data Protection Manager 2016 protection agent installation issues

This guide helps you understand and troubleshoot some of the most common problems when installing System Center 2016 Data Protection Manager (DPM) protection agent.

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager  
_Original KB number:_ &nbsp; 4052731

Before you start troubleshooting, we recommend that you first try to install the protection agents manually. For detailed instructions, see [Install the agent manually](/system-center/dpm/deploy-dpm-protection-agent#BKMK_Manual).

Also Make sure that you have [the latest update rollup](/system-center/dpm/release-build-versions) for DPM installed, then try to reinstall the protection agent.

## Prerequisite checks

### Verify COM+ services are running

Make sure that COM+ services are running on the protected computers, then try to reinstall the protection agent.

### Verify required applications are installed

Make sure that you have [the required applications](/system-center/dpm/prepare-environment-for-dpm#protected-workloads) installed on the protected computers, then try to reinstall the protection agent.

## Unexpected restarts during DPM agent deployment

When Microsoft Visual C++ 2012 Redistributable (x64) version 11.0.51106 or a later version isn't preinstalled, agent deployment fails, and a forced restart occurs without warning. This occurs even you clear the automatically restart option.

To fix this issue, verify that the required version of Microsoft Visual C++ 2012 Redistributable (x64) is installed. To do this, at the command prompt, type the following command to query the related registry entries:

```console
reg query \\<ComputerName>\HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /s /f "Microsoft Visual C++ 2012 x64"
```

If no results are returned, install Microsoft Visual C++ 2012 Redistributable (x64) version 11.0.51106 or a later version.

## Agent installation (or setdpmserver) fails with fatal error 0x80004005

This issue occurs if Windows Management Instrumentation (WMI) isn't listed as a predefined exception in Windows Firewall.

To fix the issue, follow these steps:

1. On the **Select Administrative and Other Options** page of the **Security Configuration Wizard**, select the **Remote WMI** option.
2. Apply the security policy.
3. Reinstall DPM agent.

## DPM protection agent doesn't install on a computer

To fix the issue, go through the following checklist:

1. Is the computer connected to the network and can it be remotely accessed from the DPM server?

    Both the DPM server and the computer to be protected must be connected to the network during installation of a protection agent.

2. Does the protected computer have a supported Windows operating system installed?

    Verify the operating system on the computer to be protected.

3. Is a firewall enabled on the computer to be protected that could be blocking requests from the DPM server?

    If a firewall is enabled, you must configure the firewall to allow communication between the DPM server and the computer to be protected. For information about how to configure the firewall, see [Set up firewall exceptions](/system-center/dpm/deploy-dpm-protection-agent#set-up-firewall-exceptions).

4. Is a firewall enabled on the DPM server?

    If a firewall is enabled, you must configure the firewall to allow installation of a protection agent on the computer.

5. Has an earlier version of the protection agent already been installed on the protected computer?

    You can't install two versions of the protected agent on the same protected computer.

6. Is the Remote Registry service running on the computer to be protected?

    The Remote Registry service must be running on both the DPM server and the computer before you can install a protection agent. In Administrative Tools, start the Remote Registry service and then install the protection agent.

7. Is remote procedure call (RPC) unavailable?

    RPC must be available. See [The system cannot log you on due to the following error: The RPC server is unavailable](https://support.microsoft.com/help/555839).

8. Is the boot volume on the computer formatted as file allocation table (FAT)?

    Convert the boot volume to NTFS file system if you have sufficient space.

## DPM protection agent doesn't uninstall from a computer

To fix the issue, go through the following checklist:

1. Is the protected computer disconnected from the network?

    To uninstall a protection agent, the protected computer must be connected to the network.

2. Was the protected computer renamed or moved to another Active Directory domain after the protection agent was installed?

    To uninstall a protection agent, the protected computer must have the same name and be in the same domain as it was when the protection agent was installed.

    Uninstall the agent locally, and then remove the entry from DPM Administrator console.

## DPM protection agent is incompatible with DPM or other software

To fix the issue, go through the following checklist:

1. Did you upgrade the DPM software without updating the protection agent?

    To determine whether an agent update is available, check the **Agents** tab in the **Management** view.
2. Did you upgrade a protection agent by using Microsoft Update before DPM received the corresponding server update?

    Because Microsoft Update can occur automatically, make sure that the protection agent and DPM are compatible.

## An error occurred when the agent operation attempted to communicate with the DPM Agent Coordinator service on the specified computer

This issue occurs because of a COM communications error.

To fix the issue, verify COM permissions on the protected computer.

## Protection agent upgrade fails

To fix the issue, following these steps:

1. If there is an entry for DPM protection agent in the installed programs list, try upgrading the agent by using DPMAgentInstaller.exe.
2. If the previous step fails, uninstall the agent from **Programs and Features** and install it again by running the following command:

    ```console
    DPMAgentInstaller <DPMServerName>
    ```

## System Error 1130: Not enough server storage is available to process this command

This issue occurs if the configuration parameter `IRPStackSize` of the server is too small for the server to use a local device.

To fix the issue, we recommend that you increase the value of this parameter.

## Event ID 2011: Not enough memory to complete the transaction. Close some applications and retry

This issue occurs if the configuration parameter `IRPStackSize` of the server is too small for the server to use a local device.

To fix the issue, we recommend that you increase the value of this parameter.

## The RPC server is unavailable

This issue occurs if a firewall is enabled on the remote computer.

If a firewall is enabled on the remote computer on which you are installing the protection agents, you must run the `DPMAgentInstaller.exe` executable file before installation.

## The Windows SharePoint Services farm back-end server does not appear as protected in DPM Administrator console

After you install a protection agent on a back-end server to protect a Windows SharePoint Services farm, the server doesn't appear as protected in the **Management** task area on the **Agents** tab.

No action is required. DPM protects the back-end servers internally if the Windows SharePoint Services farm has data on the server.

## The application has failed to start because the application configuration is incorrect

This issue occurs if the software requirements aren't met on the protected computer.

To fix the issue, install the .NET Framework 3.5 with Service Pack 1 (SP1), and then reinstall the protection agent.

If you are protecting a server released earlier than Windows Server 2012, you must install the appropriate version of Windows Management Framework (WMF) before you install the DPM agent:

- [WMF 3.0](https://www.microsoft.com/download/details.aspx?id=34595) for Windows Server 2008 SP2
- [WMF 5.1](https://www.microsoft.com/download/details.aspx?id=54616) for Windows 7, Windows Embedded Standard 7, and Windows Server 2008 R2

## Backup of data sources fails with agent upgrade error

This issue occurs if the protection agent on some members of the cluster has not been upgraded.

To fix the issue, upgrade the protection agent on all members of the cluster.

## Error ID: 31008 appears because DPM only refreshes protection agents every 30 minutes

If a protected domain controller or secondary server becomes unavailable, the protection agents are not automatically refreshed in DPM Administration console.

For disaster recovery scenarios, in DPM Administrator console, you must wait for the scheduled installation list refresh which is a maximum of 30 minutes.

To manually refresh the protection agents, in the **Management** task area, select the **Agents** tab, select the computer, and then in the **Actions** pane, select **Refresh information**.

## DPM agent install fails with Error 347: An error occurred when the agent operation attempted to create the DPM Agent Coordinator service

This issue typically occurs because a prerequisite isn't installed. Most frequently, Windows Management Framework (WMF) must be updated.

To fix the issue, follow these steps:

1. Upgrade [WMF](https://www.microsoft.com/download/details.aspx?id=54616) on the production server to version 5.1.
2. Make sure all other [prerequisites](/system-center/dpm/prepare-environment-for-dpm#protected-workloads) are installed.
3. Try to install the DPM agent again.

For more information, see [DPM agent installation fails with error 347](agent-installation-error-347.md).
