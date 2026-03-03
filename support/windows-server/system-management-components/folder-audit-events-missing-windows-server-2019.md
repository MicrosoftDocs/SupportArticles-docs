---
title: Folder audit events missing from Event Viewer in Windows Server 2019
description: 
ms.date: 03/05/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, nitkum, v-jesits, simonw, v-tappelgate
ms.custom:
- sap:system management components\event viewer
- pcy:WinComm User Experience
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Folder audit events missing from Event Viewer in Windows Server 2019

This article explains how to troubleshoot and fix issues that relate to folder auditing in Windows Server 2019. It is intended for IT administrators who need to track access and changes to specific folders on a file server. If you have enabled auditing but are not seeing the expected logs in Event Viewer, this guide can help you identify and fix the configuration.

## Symptoms

You configure folder auditing to monitor a folder on a Windows Server 2019 file server for access and change operations. However, you don't see the audit logs that you expect in Event Viewer. Additionally, you don't see any events or error codes that indicate an auditing issue.

## Cause

This issue can occur if audit policies or permissions are incomplete or incorrectly configured on the file server. Windows Server 2019 doesn't generate the folder access or change audit logs unless the audit policy settings and folder-specific audit entries are correctly configured.

## Resolution

To configure folder auditing, follow these steps:

### Step 1: Verify the audit policy settings

1. If you use Group Policy objects (GPOs) to manage your configuration, follow these steps to find the correct settings:

   1. On a domain controller (DC), open the Group Policy Management Console (GPMC) (available on the Server Manager **Tools** menu).
   1. Open or create a Group Policy object (GPO) that links to the affected computer. To open the Group Policy Management Editor, right-click the GPO and then select **Edit**.
   1. In the editor, select **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Advanced Audit Policy Configuration** > **Audit Policies** > **Object Access**.

1. If you don't configure GPOs and you use Group Policy at the local level, follow these steps to find the correct settings:

   1. On the affected computer, select **Start**, type *gpedit.msc*, and select **Edit group policy** from the search results.
   1. In the editor, select **Computer Configuration** > **Windows Settings** > **Security Settings** > **Advanced Audit Policy Configuration** > **System Audit Policies - Local Group Policy Object** > **Object Access**.

1. Right-click the policy that you want to enable (such as **Audit File System**) and then select **Properties**.
1. Make sure that **Configure the following audit events** is selected, and that the types of events that you want to audit are selected (**Success**, **Failure**, or both).
1. After you configure the policies, and then open an administrative Windows Command Prompt window on the affected computer.
1. To force the computer to update its Group Policy settings, run the following command at the command prompt:

   ```console
   gpupdate /force
   ```

### Step 2: Configure the user or group for whom you want to audit folder usage

1. In File Explorer on the affected computer, right-click the target folder, and then select **Properties**.
1. Select **Security** > **Advanced** > **Auditing**.
1. In the **Auditing** tab, add the user or group whose access you want to audit.
1. Select the types of access you want to audit (for example, **Create files/write data** or **Read data/list folder**).
1. Select whether to audit successful attempts, failed attempts, or both.

### Step 3: Verify that audit logging is working

1. On the affected computer. verify that the Windows Event Log service is running.
1. To verify that the computer is recording folder access events, open Event Viewer, and then select **Windows Logs** > **Security**.
1. To test the auditing configuration, use an account that matches the auditing rules to access or change the target folder.

   The audit events that document your actions should now appear in Event Viewer.

## Data collection

The following types of data can help you troubleshoot this issue. Additionally, if you contact Microsoft Support, you can attach this data to your support request.

- Exported data from the Security event log.
- Windows Server 2019 version and build details (To see the exact version and build number, run `winver` at a command prompt on the affected computer).
- Screenshots of the audit policy configuration in the Group Policy Management console.
- Screenshots of the folder's auditing entries in the folder **Properties** dialog box.
- Details the steps used in testing, including the user account that was used and the actions that were performed.

## References

- [Advanced Audit Policy Configuration](/windows-server/identity/ad-ds/plan/security-best-practices/advanced-audit-policy-configuration)
