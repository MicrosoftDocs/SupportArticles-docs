---
title: Resolve Windows Agent installation issues 
description: Follow these steps to resolve Windows Log Analytics Agent (Windows Agent) installation issues.
ms.date: 01/24/2022
ms.reviewer: aaronmax, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: logs-troubleshoot
keywords: 
#Customer intent: As a Windows Log Analytics Agent (Windows Agent) user, I want to resolve Windows Agent installation errors so I can complete my installation successfully. 
---

# Resolve Windows Log Analytics Agent installation issues

This article provides troubleshooting steps to resolve common Windows Log Analytics Agent (Windows Agent) installation issues.

## Symptoms

After you install the Windows Agent, you're not sure whether the agent is connected correctly because you see no data, or only partial data, in your workspace. This problem could be related to an installation or deployment issue. Or, it could be caused by a local server issue or a network connectivity issue.

## Cause 1: The Log Analytics extension and monitoring agent deployment failed  

### Solution 1: Check the Log Analytics extension status in the Azure portal

After you successfully install the Windows Agent, the agent will have a Log Analytics extension added, and your virtual machine (VM) will emit Heartbeat events. To check this status:

1. Sign in to the [Azure portal](https://portal.azure.com/), and then search for and select **Virtual machines**.

1. Select your VM from the list, and then select **Extensions + applications**.

1. Check the list to see whether the Log Analytics extension is enabled. If it's enabled, the Windows Log Analytics Agent will appear as **MicrosoftMonitoringAgent**, and it will have the type of **Microsoft.EnterpriseCloud.Monitoring.MicrosoftMonitoringAgent**. After a successful installation, the value in the **STATUS** column should be **Provisioning succeeded**.

     1. If the value in the **STATUS** column is **Unavailable**, submit a support ticket to the VM support team to troubleshoot the VM Guest Agent installation.

     1. If the value in the **STATUS** column is **Provisioning failed**, see [Solution 2](#solution-2-check-for-correct-extension-and-installation-log-directories-on-the-vm) to troubleshoot the VM.

1. Check whether the VM is emitting Heartbeat events to the Log Analytics workspace:

     1. Navigate to the Log Analytics workspace that the server is connected to.
     1. Locate and select the **Logs** blade.
     1. In the query window, run the following Heartbeat Query:

        ```console
        Heartbeat | where Computer contains "ComputerNameGoesHere" 
        ```

1. If the heartbeat query returns results, those results will be displayed below the query window. The results indicate that the extension and agent have been successfully installed. If no results appear, see [Solution 2](#solution-2-check-for-correct-extension-and-installation-log-directories-on-the-vm) to troubleshoot the VM.

## Cause 2: The VM extension and agent processes aren't running correctly on the local server  

### Solution 2: Check for correct extension and installation log directories on the VM

1. Use Remote Desktop Protocol (RDP) to access the VM.

1. Run the following PowerShell commands to check whether extension and agent processes are running correctly:

   ```powershell
   Get-WmiObject Win32_Process -Filter "name = 'MMAExtensionHeartbeatService.exe'" | Format-List ProcessName, Path
   Get-WmiObject Win32_Process -Filter "name = 'HealthService.exe'" | Format-List ProcessName, Path
   Get-WmiObject Win32_Process -Filter "name = 'MonitoringHost.exe'" | Format-List ProcessName, Path
   ```

   In the output for MMAExtensionHeartbeatService.exe, make sure that the path corresponds to the version that's being installed.  

   If these commands don't produce any results, see step 4.e. in this solution.

1. Check whether the following extension installation directory exists:

   *C:\Packages\Plugins\Microsoft.EnterpriseCloud.Monitoring.MicrosoftMonitoringAgent\<Extension version\>*

   The absence of this directory indicates that the VM Guest Agent didn't try the extension installation. In this situation, file a support request with the VM support team to troubleshoot the VM Guest Agent installation.

1. Check whether the following extension log directory exists:

   *C:\WindowsAzure\Logs\Plugins\Microsoft.EnterpriseCloud.Monitoring.MicrosoftMonitoringAgent\<Extension version\>*

   The absence of this directory indicates that the VM Guest Agent didn't try the extension installation.

   1. If the directory isn't there, file a support request with the VM support team to troubleshoot the VM Guest Agent.
   1. If the directory is there, navigate to that directory, and then open *MMAExtensionInstall[PickLargestNumber].log*. A successful installation log entry will resemble the following example:

        ```output
        11/22/2019 1:10:05 AM +00:00 Starting installation of agent 
        install package at path *C:\Packages\Plugins\Microsoft.EnterpriseCloud.Monitoring.MicrosoftMonitoringAgent\1.0.18018.0\MOMAgent.msi 
        with log C:\WindowsAzure\Logs\Plugins\Microsoft.EnterpriseCloud.Monitoring.MicrosoftMonitoringAgent\1.0.18018.0\MMAExtensionInstall0-Setup0.log*.
        11/22/2019 1:11:42 AM +00:00 Windows installer reported success in installing agent.
        11/22/2019 1:11:42 AM +00:00 Verified that service Microsoft Monitoring Agent is installed
        and in Running state.
        11/22/2019 1:11:42 AM +00:00 Completed installing the Microsoft Monitoring Agent VM Extension.
        ```

   1. A failed installation will show the cause of the failure. If the failure occurs because of Windows Installer issues, check the Windows Installer logs to inspect *MMAExtensionInstall0-Setup0.log*.  
   1. If possible, fix the issue that's reported by Windows Installer. Then, try to install the Windows Agent again.  
   1. If the commands in step 2 in this solution don't produce any results, then the related service isn't running. In PowerShell, try to start the following services:  
  
        - This service will start both the HealthService process and the MonitoringHost process:

           ```powershell
           Net start HealthService  
           ```

        - This service will start the VM Guest Heartbeat Service:

           ```powershell
           Net start MMAExtensionHeartbeatService 
           ```

   1. Wait a few minutes, and then repeat step 2 in this solution. If the processes still don't return any values, check the following event viewer logs for possible causes:  

      - Windows Logs - Application
      - Applications and Services Logs - Operations Manager

   1. If you can't determine the cause of failure, run the Agent Troubleshooter to gather a set of troubleshooting logs, as described in [Log Analytics Agent Troubleshooting Tool](/azure/azure-monitor/agents/agent-windows-troubleshoot#log-analytics-troubleshooting-tool). Then, file a support request.  

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
