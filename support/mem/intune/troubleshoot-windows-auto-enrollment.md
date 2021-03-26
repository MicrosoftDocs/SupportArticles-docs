---
title: Troubleshoot Windows 10 auto-enrollment in Intune
description: Learn how to troubleshoot auto-enrollment.
ms.date: 08/03/2020
ms.reviewer: jchombe
---

# Troubleshoot Windows 10 group policy-based auto-enrollment in Intune

You can use group policy to trigger auto-enrollment to MDM for Active Directory (AD) domain-joined devices. For more information on this feature, see [Enroll a Windows 10 device automatically using Group Policy](/windows/client-management/mdm/enroll-a-windows-10-device-automatically-using-group-policy).

## Verify the configuration

Before you start troubleshooting, it's best to verify that everything is configured correctly. If the issue can’t be fixed during verification, you can troubleshoot further by checking some important log files.

- Verify that a valid Intune license is assigned to the user who is trying to enroll the device.

   ![Verify Intune license](./media/troubleshoot-windows-auto-enrollment/intune-license.png)

- Verify that auto-enrollment is enabled for all users who will enroll the devices in Intune. For more information, see [Azure AD and Microsoft Intune: Automatic MDM enrollment in the new Portal](/windows/client-management/mdm/azure-ad-and-microsoft-intune-automatic-mdm-enrollment-in-the-new-portal).

   ![Verify auto-enrollment](./media/troubleshoot-windows-auto-enrollment/verify-auto-enrollment.png)

  - Verify that **MDM user scope** is set to **All** to allow all users to enroll a device in Intune.
  - Verify that **MAM User scope** is set to **None**. Otherwise, this setting will have precedence over the MDM scope and cause issues.
  - Verify that **MDM discovery URL** is set to **`https://enrollment.manage.microsoft.com/enrollmentserver/discovery`**.

- Verify that the device is running Windows 10, version 1709 or a later version.

- Verify that the devices are set to **hybrid Azure AD joined**. This setting means that the devices are both domain-joined and Azure AD-joined.

  To verify the settings, run `dsregcmd /status` at the command line. Then, verify the following status values in the output:

  - Device State

     ```output
     AzureAdJoined: YES
     DomainJoined: YES
     ```

  - SSO State

     ```output
     AzureAdPrt: YES
     ```

   You can find this same information in the list of Azure AD-joined devices:

   ![List of Azure AD-joined devices](./media/troubleshoot-windows-auto-enrollment/ad-joined-devices.png)

- Both **Microsoft Intune** and **Microsoft Intune Enrollment** might be listed under **Mobility (MDM and MAM)** in the Azure AD blade. If both are present, make sure that you configure the auto-enrollment settings under **Microsoft Intune**.

- Verify that the following Group Policy policy setting is successfully deployed to all devices that should be enrolled in Intune:

   **Computer Configuration** > **Policies** > **Administrative Templates** > **Windows Components** > **MDM** > **Enable automatic MDM enrollment using default Azure AD credentials**

   You can contact your domain administrators to verify that the Group Policy policy setting is deployed successfully.

- Make sure that the device isn't enrolled in Intune by using the classic PC agent.
- Verify the following settings in Azure AD and Intune:

  **In Azure AD Device settings:**

   ![Azure AD Device settings](./media/troubleshoot-windows-auto-enrollment/device-setting.png)

   - The **Users may join devices to Azure AD** setting is set to **All**.
   - The number of devices that a user has in Azure AD doesn't exceed the **Maximum number of devices per user** quota.
  
  **In Intune enrollment restrictions:**

  - Enrollment of Windows devices is allowed.

    ![Allowed Enrollment of Windows devices](./media/troubleshoot-windows-auto-enrollment/restrictions.png)

## Troubleshooting

If the issue persists, examine the MDM logs on the device in the following location in Event Viewer:

**Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider** > **Admin**

Look for Event ID 75 (Event message "Auto MDM Enroll: Succeeded"). This event indicates that the auto-enrollment succeeded.

Event ID 75 isn't logged in the following situations:

- The enrollment fails.

  To verify this error, look for Event ID 76 (Event message: Auto MDM Enroll: Failed (Unknown Win32 Error code: 0x8018002b)). This event indicates a failed auto-enrollment.

  For a resolution to this error, see [Troubleshoot Windows device enrollment problems in Microsoft Intune](troubleshoot-windows-enrollment-errors.md).

- The enrollment wasn't triggered at all. In this case, event ID 75 and event ID 76 aren't logged.
  
  The auto-enrollment process is triggered by the following task:

    **Schedule created by enrollment client for automatically enrolling in MDM from AAD**

  This task is located under **Microsoft** > **Windows** > **EnterpriseMgmt** in Task Scheduler.

  ![Enrollment wasn't triggered](./media/troubleshoot-windows-auto-enrollment/trigger.png)

  This task is created when the **Enable automatic MDM enrollment using default Azure AD credentials** Group Policy policy setting is successfully deployed to the target device. The task is scheduled to run every 5 minutes during one day.

  To verify that the task is started, check the task scheduler event logs under the following location in Event Viewer:

  **Applications and Services Logs > Microsoft > Windows > Task Scheduler > Operational**

  When the task is triggered on the scheduler, Event ID 107 is logged.

  When the task is completed, Event ID 102 is logged. The event is logged whether or not auto enrollment succeeds.

  > [!NOTE]
  > You can use the task scheduler log to check whether auto-enrollment is triggered. However, you can't use the log to determine whether auto-enrollment succeeded.

  The **Schedule created by enrollment client for automatically enrolling in MDM from AAD** task may not start in the following situations:

  - The device is already enrolled in another MDM solution. In this case, Event ID 7016 together with error code 2149056522 is logged in the **Applications and Services Logs** > **Microsoft** > **Windows** > **Task Scheduler** > **Operational** event log.

    To fix this issue, unenroll the device from the MDM.

  - A Group Policy issue exists. In this case, force an update of Group Policy settings by running the following command:

    `gpupdate /force`

    If the issue persists, do additional troubleshooting in Active Directory.
