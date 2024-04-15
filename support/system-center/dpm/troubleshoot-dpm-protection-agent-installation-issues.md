---
title: Troubleshoot DPM protection agent installation issues
description: Troubleshoot some of the most common problems when installing System Center Data Protection Manager protection agent.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# Troubleshoot Data Protection Manager protection agent installation issues

This guide helps you understand and troubleshoot some of the most common problems when installing System Center Data Protection Manager (DPM) protection agent.

_Original product version:_ &nbsp; System Center Data 2019 Protection Manager, System Center 2022 Data Protection Manager  
_Original KB number:_ &nbsp; 4052731

Before you start troubleshooting, we recommend that you first try to install the protection agents manually. For detailed instructions, see [Install the agent manually](/system-center/dpm/deploy-dpm-protection-agent#BKMK_Manual).

Also Make sure that you have [the latest update rollup](/system-center/dpm/release-build-versions) for DPM installed, then try to reinstall the protection agent.

## Prerequisite checks

### Verify COM+ services are running

Make sure that COM+ services are running on the protected computers, then try to reinstall the protection agent.

### Verify required applications are installed

Make sure that you have [the required applications](/system-center/dpm/prepare-environment-for-dpm#protected-workloads) installed on the protected computers, then try to reinstall the protection agent.

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

    Verify the operating system on the computer to be protected. For more information, see [DPM support matrix](/system-center/dpm/dpm-protection-matrix).

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

9. Is the Admin$ share accessible?

    From an administrator command prompt, connect to the Admin$ share and then disconnect by using the following commands:

    ```console
    net use * \\servername\Admin$
    net use z: /d
    ```

    If you receive the following error message, make sure that file and print services are enabled on the network interface card (NIC), and check DNS is working properly.

    > System error 53 has occurred

    If you receive the "Access denied" error message, verify that "Everyone" and "Authenticated users" has the "Access this computer from the network" right on the protected server. To check the setting in Local Group Policy Editor, select **Local Computer Policy** > **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Polices** > **User Rights Assignments**.

10. Is Windows Management Instrumentation (WMI) working?

    From an administrator command prompt, test the remote WMI by using the following command:

    ```console
    Wmic /node:"ServerName" OS list brief    (USE THE " ")
    ```

    For more information, see [WMI Troubleshooting](/windows/win32/wmisdk/wmi-troubleshooting).

11. Is the Microsoft Distributed Transaction Coordinator (MSDTC) service running?

    From an administrator command prompt, check the service status by running the following command:

    ```console
    sc \\servername query |find /i "msdtc"
    ```

    Start the service if it isn't started.

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

1. If there is an entry for DPM protection agent in the installed programs list, try upgrading the agent by using *DPMAgentInstaller.exe*. The latest agent can be copied from the DPM server from the DPM installation folder path:

    *C:\Program Files\Microsoft System Center\\\<version>\DPM\DPM\ProtectionAgents\RA\\\<Build number>\amd64*

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

## Backup of data sources fails with agent upgrade error

This issue occurs if the protection agent on some members of the cluster has not been upgraded.

To fix the issue, upgrade the protection agent on all members of the cluster.

## Error ID: 31008 appears because DPM only refreshes protection agents every 30 minutes

If a protected domain controller or secondary server becomes unavailable, the protection agents are not automatically refreshed in DPM Administration console.

For disaster recovery scenarios, in DPM Administrator console, you must wait for the scheduled installation list refresh which is a maximum of 30 minutes.

To manually refresh the protection agents, in the **Management** task area, select the **Agents** tab, select the computer, and then in the **Actions** pane, select **Refresh information**.
