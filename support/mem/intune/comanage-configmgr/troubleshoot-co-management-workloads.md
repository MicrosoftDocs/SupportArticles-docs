---
title: Troubleshooting Intune and Configuration Manager co-management workloads
description: Helps you understand and troubleshoot issues that you may encounter when you configure workloads in an Intune and Configuration Manager co-management environment.
ms.date: 02/11/2025
search.appverid: MET150
ms.custom: sap:Co-management with System Center Configuration Manager\Switch Configuration Manager workloads to Intune
ms.reviewer: kaushika, meerak
---
# Troubleshoot co-management workloads

This article helps you understand and troubleshoot issues that you may encounter when you configure workloads in an Intune and Configuration Manager co-management environment. For more information about how to configure workloads, see [Support Tip: Configuring workloads in a co-managed environment](https://techcommunity.microsoft.com/t5/Intune-Customer-Success/Support-Tip-Configuring-workloads-in-a-co-managed-environment/ba-p/707221).

## Before you start

Before you start troubleshooting, it's important to collect some basic information about the issue and make sure that you follow all required configuration steps. This helps you better understand the problem and reduce the time to find a resolution. To do this, follow this checklist of pre-troubleshooting questions:

- What is your [current MDM authority](/mem/intune/fundamentals/mdm-authority-set)?
- Did you [complete the prerequisites](/mem/configmgr/comanage/overview#prerequisites)?
- Did you take [path 1 or path 2](/mem/configmgr/comanage/quickstart-paths) to co-management?
- If you took path 2, did you [configure the cloud management gateway (CMG)](/mem/configmgr/core/clients/manage/cmg/setup-cloud-management-gateway)?
- Did you join the Windows 10 devices to Microsoft Entra ID through [Microsoft Entra hybrid join](/azure/active-directory/devices/hybrid-azuread-join-plan) or [Microsoft Entra join](/azure/active-directory/devices/azureadjoin-plan)?
- If you used [hybrid MDM with Configuration Manager and Microsoft Intune](/mem/configmgr/mdm/understand/what-happened-to-hybrid) before, did you [migrate to Intune standalone](/mem/intune/fundamentals/mdm-authority-set)?

Most issues occur because one or more of these steps were not completed. If you find that a step was skipped or was not completed successfully, check the details of each step.

## Frequently asked questions  

### What roles do I need to configure co-management?

Here are the required [permissions and roles](/mem/configmgr/comanage/overview#permissions-and-roles) to configure co-management.

### What log can I use to validate workloads and determine where policies and apps come from in a co-management scenario?

You can use the following log file on Windows 10 devices:

`%WinDir%\CCM\logs\CoManagementHandler.log`

### What workloads are currently supported by co-management?

You can find the supported workloads [here](/mem/configmgr/comanage/workloads).  

### Which workload does the resource access policies workload belong to?

The [resource access policies workload](/mem/configmgr/comanage/workloads#resource-access-policies) is part of the device configuration workload.  

### What logs can be used to verify that workloads are working correctly?

You can use the following logs in the `%WinDir%\CCM\logs\` folder on the Windows 10 devices:

- **CoManagementHandler.log**  

  This file logs the processing of the configuration and the MDM information related to the device.

  Sample log snippet:

  > Processing GET for assignment (ScopeId_\<scope ID>/ConfigurationPolicy_\<policy ID>)  
  > Getting/Merging value for setting 'CoManagementSettings_AutoEnroll'  
  > Merged value for setting 'CoManagementSettings_AutoEnroll' is 'true'  
  > Getting/Merging value for setting 'CoManagementSettings_Capabilities'  
  > Merged value for setting 'CoManagementSettings_Capabilities' is '7'  
  > Getting/Merging value for setting 'CoManagementSettings_Allow'  
  > Merged value for setting 'CoManagementSettings_Allow' is 'true'  
  > State ID and report detail hash are not changed. No need to resend.
  > Machine is already enrolled with MDM

- **ComplRelayAgent.log**  

  This file logs the current configuration and what it means for the status of the compliance policies.

  Sample log snippet:

  > Verifying if workload 2 is enabled in workloadFlags 7  
  > Result of & operation is 2  
  > Feature flag is ON, device should be Intune managed.  
  > CA workload is disabled for ConfigMgr. No compliance state to report for user SID \<SID>

- **CIAgent.log**  

  This file logs the current configuration and what it means for the status of the resource access policies.

  Sample log snippet:

  > Verifying if workload 4 is enabled in workloadFlags 7  
  > Result of & operation is 4  
  > Feature flag is ON, device should be Intune managed.  
  > Resource Access workload is disabled for ConfigMgr client.  
  > Skipping CI [ScopeId_\<Scope ID>/ConfigurationPolicy_\<Policy ID>]  
  > A different management authority is enabled for Resource Access workloads. Terminating current job.

- **WUAHandler.log**  

  This file logs the current configuration and what it means for the status of the Windows Update for Business policies.

  Sample log snippet:

  > Verifying if workload 16 is enabled in workloadFlags 7  
  > Result of & operation is 0  
  > Feature flag is OFF, should be SCCM managed.  
  > SourceManager::GetIsWUfBEnabled - There is no Windows Update for Business settings assignment. Windows Update for Business is not enabled through ConfigMgr

### What's the difference between Pilot Intune and Intune when I switch workloads?

The difference between Pilot Intune and Intune is subtle but important. Both allow Intune to control a configured workload.

- The Pilot Intune setting is used to switch a workload only for the devices in a pilot collection that's created in Configuration Manager. This allows you to test in a staging environment without affecting all Windows 10 devices in the production environment.
- The Intune setting is used when you finish testing in the staging environment and are ready to switch a workload for all Windows 10 devices that are enrolled in co-management.

## Common issues  

### I switch the Endpoint Protection workload to Intune, but a Windows 10 device still has the policies from Configuration Manager

This behavior is expected.

When you switch [this](/mem/configmgr/comanage/workloads#endpoint-protection) workload, the Configuration Manager policies stay on the device until the next check-in to the Intune service. When the device checks in, the Intune policies overwrite the Configuration Manager policies. This behavior makes sure that the device still has protection policies during the transition. For more information about the check-in frequency, see [How long does it take for devices to get a policy, profile, or app after they are assigned?](/mem/intune/configuration/device-profile-troubleshoot#how-long-does-it-take-for-devices-to-get-a-policy-profile-or-app-after-they-are-assigned)  

### I can't find the Client apps workload in the Workloads tab of co-management Properties

Client apps for co-managed devices is a pre-release feature. You must [enable the pre-release feature](/mem/configmgr/core/servers/manage/pre-release-features#enabling-pre-release-features) to make it visible.  

### The Enablement tab in co-management properties displays 'Please ensure the proper prerequisites are installed.'

You receive this message if you didn't install the CMG. After you install the CMG, you receive a message that resembles the following:

> CCMSETUPCMD="CCMHOSTNAME=contoso.cloudapp.net/CCM_Proxy_MutualAuth/72186325152220500 SMSSiteCode=ABC"

In this case, do the following:

- If you are taking [Path 1: Auto-enroll existing clients](/mem/configmgr/comanage/quickstart-paths#bkmk_path1), you can ignore this message because CMG isn't used.
- If you are taking [Path 2: Bootstrap with modern provisioning](/mem/configmgr/comanage/quickstart-paths#bkmk_path2), you must [install and configure the CMG](/mem/configmgr/core/clients/manage/cmg/setup-cloud-management-gateway) and onboard the app to Microsoft Entra ID.

### I unassign Intune policies from a security group, but some settings remain

Intune doesn't revert settings ([tattoo removal](/mem/intune/configuration/device-profile-troubleshoot)) if the Device Configuration workload is set to Configuration Manager. To enable tattoo removal, configure the workload in Configuration Manager, and refresh policy on the device.

## More information

For more information about troubleshooting co-management issues, see the following articles:

- [Troubleshoot co-management: Auto-enroll existing Configuration Manager-managed devices into Intune](troubleshoot-co-management-auto-enrolling.md)
- [Troubleshoot co-management: Bootstrap with modern provisioning](troubleshoot-co-management-bootstrap.md)

For more information about Intune and Configuration Manager co-management and workloads, see the following articles:

- [Overview of Windows 10 co-management](/mem/configmgr/comanage/overview)
- [Getting Started: Paths to co-management](/mem/configmgr/comanage/quickstart-paths)
- [Quickstarts for co-management](/mem/configmgr/comanage/quickstarts)
- [Tutorial: Enable co-management for existing Configuration Manager clients](/mem/configmgr/comanage/tutorial-co-manage-clients)
- [How to prepare internet-based devices for co-management](/mem/configmgr/comanage/how-to-prepare-Win10)
- [How to enable co-management in Configuration Manager](/mem/configmgr/comanage/how-to-enable)
- [How to switch Configuration Manager workloads to Intune](/mem/configmgr/comanage/how-to-switch-workloads)
