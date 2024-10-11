---
title: Troubleshooting Windows device enrollment problems in Intune
description: Suggestions for troubleshooting some of the most common error messages when you enroll Windows devices in Microsoft Intune.
ms.date: 12/05/2023
ms.reviewer: kaushika, mghadial
search.appverid: MET150
ms.custom: sap:Enroll Device - Windows\MDM only
---
# Troubleshooting Windows device enrollment errors in Intune

This article helps Intune administrators understand and troubleshoot error messages when enrolling Windows devices in Microsoft Intune. See [Troubleshoot device enrollment in Microsoft Intune](troubleshoot-device-enrollment-in-intune.md) for additional, general troubleshooting scenarios.
 
## Error hr 0x8007064c: The machine is already enrolled

Enrollment fails with the error "The machine is already enrolled." The enrollment log shows error **hr 0x8007064c**.

**Cause:** This failure may occur for one of these reasons:

- The computer was previously enrolled
- The computer has the cloned image of a computer that was already enrolled.
- The account certificate of the previous account is still present on the computer.

**Solution:**

1. From the **Start** menu, type **Run** -> **MMC**.
1. Choose **File** > **Add/Remove Snap-ins**.
1. Double-click **Certificates**, choose **Computer account** > **Next**, and select **Local Computer**.
1. Double-click **Certificates (Local computer)** and choose **Personal** > **Certificates**.
1. Look for the Intune cert issued by Sc_Online_Issuing, and delete it, if present.
1. If the following registry key exists, delete it: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OnlineManagement** and all sub keys.
1. Try to re-enroll.
1. If the PC still can't enroll, look for and delete this key, if it exists: **KEY_CLASSES_ROOT\Installer\Products\6985F0077D3EEB44AB6849B5D7913E95**.
1. Try to re-enroll.

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs.
    > For more information about how to back up and restore the registry, read [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756)

### Error 8018000a: The device is already enrolled.

Error 8018000a: "Something went wrong. The device is already enrolled.  You can contact your system administrator with the error code 8018000a."

**Cause:** One of the following conditions is true:

- A different user has already enrolled the device in Intune or joined the device to Microsoft Entra ID. To determine whether this is the case, go to **Settings** > **Accounts** > **Work Access**. Look for a message that's similar to "Another user on the system is already connected to a work or school. Please remove that work or school connection and try again."

**Solution:**

Use these steps to remove the other work or school account.

1. Sign out of Windows, then sign in by using the other account that has enrolled or joined the device.
2. Go to **Settings** > **Accounts** > **Work Access**, then remove the work or school account.
3. Sign out of Windows, then sign in by using your account.
4. Enroll the device in Intune or join the device to Microsoft Entra ID.

## This account is not allowed on this phone.

Error: "This account is not allowed on this phone. Make sure the information you provided is correct, and then try again or request support from your company."

**Cause:** The user who tried to enroll the device doesn't have a valid Intune license.

**Solution:** Assign a valid Intune license to the user, and then enroll the device.

## Looks like the MDM Terms of Use endpoint is not correctly configured.

**Cause:** One of the following conditions is true:

- You use both MDM for Microsoft 365 and Intune on the tenant. And the user who tries to enroll the device doesn't have a valid Intune license or an Office 365 license. In this situation, you may receive the following error message:

  > Something went wrong.  
  > Looks like we can't connect to the URL for your organization's MDM terms of use. Try again, or contact your system administrator with the problem information from this page.
- The MDM terms and conditions in Microsoft Entra ID is blank or doesn't contain the correct URL.

**Solution:**

To fix this issue, use one of the following methods:

### Assign a valid license to the user

Go to the [Microsoft 365 Admin Center](https://admin.microsoft.com), and then assign either an Intune or a Microsoft 365 license to the user.

### Correct the MDM terms of use URL

  1. Sign in to the [Azure portal](https://portal.azure.com/), and then select **Microsoft Entra ID**.
  2. Select **Mobility (MDM and MAM)**, and then click **Microsoft Intune**.
  3. Select **Restore default MDM URLs**, verify that the **MDM terms of use URL** is set to **`https://portal.manage.microsoft.com/TermsofUse.aspx`**.
  4. Choose **Save**.

## Something went wrong.

Error 80180026: "Something went wrong. Confirm you are using the correct sign-in information and that your organization uses this feature. You can try to do this again or contact your system administrator with the error code 80180026."

**Cause:** This error can occur when you try to join a Windows 10 computer to Microsoft Entra ID and both of the following conditions are true:

- MDM automatic enrollment is enabled in Azure.
- The Intune PC software client (Intune PC agent) is installed on the Windows 10 computer.

**Solution:**

Use one of the following methods to address this issue:

### Disable MDM automatic enrollment in Azure.

1. Sign in to the [Azure portal](https://portal.azure.com/).
2. Go to **Microsoft Entra ID** > **Mobility (MDM and MAM)** > **Microsoft Intune**.
3. Set **MDM User scope** to **None**, and then click **Save**.

### Uninstall the Intune client

Uninstall the Intune PC software client agent from the computer.

## The software cannot be installed.

Error: "The software cannot be installed, 0x80cf4017."

**Cause:** The client software is out of date.

**Solution:**

1. Sign in to [https://admin.manage.microsoft.com](https://admin.manage.microsoft.com).
2. Go to **Admin** > **Client Software Download**, and then click **Download Client Software**.
3. Save the installation package, and then install the client software.

## The account certificate is not valid and may be expired.

Error: "The account certificate is not valid and may be expired, 0x80cf4017."

**Cause:** The client software is out of date.

**Solution:**

1. Sign in to [https://admin.manage.microsoft.com](https://admin.manage.microsoft.com).
2. Go to **Admin** > **Client Software Download**, and then click **Download Client Software**.
3. Save the installation package, and then install the client software.

## Your organization does not support this version of Windows.

Error: "There was a problem. Your organization does not support this version of Windows.  (0x80180014)"

**Cause:** Windows MDM enrollment is disabled in your Intune tenant.

**Solution:**

To fix this issue in a stand-alone Intune environment, follow these steps:

1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), chooses **Devices** > **Enrollment restrictions** > choose a device type restriction.
2. Choose **Properties** > **Edit** (next to **Platform settings**) > **Allow** for **Windows (MDM)**.
3. Click **Review + Save**.

## A setup failure has occurred during bulk enrollment.

**Cause:** The Microsoft Entra user accounts in the account package (Package_GUID) for the respective provisioning package aren't allowed to join devices to Microsoft Entra ID. These Microsoft Entra accounts are automatically created when you set up a provisioning package with Windows Configuration Designer (WCD) or the **Set up School PCs** app. And these accounts are then used to join the devices to Microsoft Entra ID.

**Solution:**

1. Sign in to the [Azure portal](https://portal.azure.com/) as administrator.
2. Go to **Microsoft Entra ID > Devices > Device Settings**.
3. Set **Users may join devices to Microsoft Entra ID** to **All** or **Selected**.

   If you choose **Selected**, click **Selected**, and then click **Add Members** to add all users who can join their devices to Microsoft Entra ID. Make sure that all Microsoft Entra accounts for the provisioning package are added.

For more information about how to create a provisioning package for Windows Configuration Designer, see [Create a provisioning package for Windows 10](/windows/configuration/provisioning-packages/provisioning-create-package).

For more information about the **Set up School PCs** app, see [Use the Set up School PCs app](/education/windows/use-set-up-school-pcs-app).

## Auto MDM Enroll: Failed

When you try to enroll a Windows 10 device automatically by using Group Policy, you experience the following issues:

- In Task Scheduler, under **Microsoft** > **Windows** > **EnterpriseMgmt**, the last run result of the **Schedule created by enrollment client for automatically enrolling in MDM from Microsoft Entra ID** task is as follows: **Event 76 Auto MDM Enroll: Failed (Unknown Win32 Error code: 0x8018002b)**
- In Event Viewer, the following event is logged under **Applications and Services Logs/Microsoft/Windows/DeviceManagement-Enterprise-Diagnostics-Provider/Admin**:

    ```output
    Log Name: Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin
    Source: DeviceManagement-Enterprise-Diagnostics-Provider
    Event ID: 76
    Level: Error
    Description: Auto MDM Enroll: Failed (Unknown Win32 Error code: 0x80180002b)
    ```

**Cause:** One of the following conditions is true:

- The UPN contains an unverified or non-routable domain, such as `.local` (like joe@contoso.local).
- **MDM user scope** is set to **None**.

**Solution:**

If the UPN contains an unverified or non-routable domain, follow these steps:

1. On the server that Active Directory Domain Services (AD DS) runs on, open **Active Directory Users and Computers** by typing **dsa.msc** in the **Run** dialog, and then click **OK**.
2. Click **Users** under your domain, and then follow these steps:  
    - If there's only one affected user, right-click the user, and then click **Properties**. On the **Account** tab, in the UPN suffix drop-down list under **User logon name**, select a valid UPN suffix such as contoso.com, and then click **OK**.
    - If there are multiple affected users, select the users, in the **Action** menu, click **Properties**. On the **Account** tab, select the **UPN suffix** check box, select a valid UPN suffix such as contoso.com in the drop-down list, and then click **OK**.
3. Wait for the next synchronization. Or force a Delta Sync from the Synchronization Server by running the following commands in an elevated PowerShell prompt:

    ```powershell
    Import-Module ADSync
    Start-ADSyncSyncCycle -PolicyType Delta
    ```

> [!NOTE]
> Another solution to this issue is [Configuring Alternate Login ID](/windows-server/identity/ad-fs/operations/configuring-alternate-login-id). Be sure to review the article before you decide to implement this solution.

If **MDM user scope** is set to **None**, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com/), and then select **Microsoft Entra ID**.
2. Select **Mobility (MDM and MAM)**, and then select **Microsoft Intune**.
3. Set **MDM user scope** to **All**. Or, set **MDM user scope** to **Some**, and select the Groups that can automatically enroll their Windows 10 devices.
4. Set **MAM User scope** to **None**.

## An error occurred while creating Autopilot profile.

**Cause:** The device name template's specified naming format doesn't meet the requirements. For example, you use lowercase for the serial macro, such as %serial% instead of %SERIAL%.

**Solution:**

Make sure that the naming format meets the following requirements:

- Create a unique name for your devices. Names must be 15 characters or less, and can contain letters (a-z, A-Z), numbers (0-9), and hyphens (‐).
- Names can't be all numbers.
- Names can't contain blank space.
- Use the %SERIAL% macro to add a hardware-specific serial number. Or, use the %RAND:<# of digits>% macro to add a random string of numbers, the string contains <# of digits> digits. For example, MYPC-%RAND:6% generates a name such as MYPC-123456.

## Something went wrong. OOBEIDPS.

**Cause:** This issue occurs if there's a proxy, firewall, or other network device that's blocking access to the Identity Provider (IdP).

**Solution:**

Make sure that the required access to internet-based services for Autopilot isn't blocked. For more information, see [Windows Autopilot networking requirements](/mem/autopilot/networking-requirements).

## Autopilot device enrollment failed with error HRESULT = 0x80180022

**Cause:** The device being provisioned is running Windows Home Edition

**Solution:**
Update the device to Pro edition or higher

## Registering your device for mobile management (Failed: 3, 0x801C03EA).

**Cause:** The device has a TPM chip that supports version 2.0, but hasn't yet been upgraded to version 2.0.

**Solution:**

Upgrade the TPM chip to version 2.0.

If the issue persists, check whether the same device is in two assigned groups, with each group being assigned a different Autopilot profile. If it is in two groups, determine which Autopilot profile should be applied to the device, and then remove the other profile's assignment.

For more information about how to deploy a Windows device in kiosk mode with Autopilot, see [Deploying a kiosk using Windows Autopilot](/archive/blogs/mniehaus/deploying-a-kiosk-using-windows-autopilot).

## Securing your hardware (Failed: 0x800705b4).

Error 800705b4:

> Securing your hardware (Failed: 0x800705b4)  
> Joining your organization's network (Previous step failed)  
> Registering your device for mobile management (Previous step failed)

**Cause:** The targeted Windows device doesn't meet either of the following requirements:

- The device must have a physical TPM 2.0 chip. Devices with virtual TPMs (for example, Hyper-V VMs) or TPM 1.2 chips don't work with self-deploying mode.
- The device must be running one of the following versions of Windows:
  - Windows 10 build 1709 or a later version.
  - If Microsoft Entra hybrid join is used, Windows 10 build 1809 or a later version.

**Solution:**

Make sure that the targeted device meets both requirements that are described in the **Cause** section.

For more information about how to deploy a Windows device in kiosk mode with Autopilot, see [Deploying a kiosk using Windows Autopilot](/archive/blogs/mniehaus/deploying-a-kiosk-using-windows-autopilot).

## Something went wrong. Error Code 80070774.

Error 0x80070774: Something went wrong. Confirm you are using the correct sign-in information and that your organization uses this feature. You can try to do this again or contact your system administrator with the error code 80070774.

This issue typically occurs before the device is restarted in a Hybrid Microsoft Entra Autopilot scenario, when the device times out during the initial sign-in screen. It means that the domain controller can't be found or successfully reached because of connectivity issues. Or, the device has entered a state that can't join the domain.

**Cause:** The most common cause is that Microsoft Entra hybrid join is used, and the Assign user feature is configured in the Autopilot profile. Using the Assign user feature performs a Microsoft Entra join on the device during the initial sign-in screen. It puts the device in a state that can't join your on-premises domain. Therefore, the Assign user feature should only be used in standard Microsoft Entra join Autopilot scenarios. The feature shouldn't be used in Microsoft Entra hybrid join scenarios.

Another possible cause for this error is that the Autopilot object's associated AzureAD device has been deleted. To resolve this issue, delete the Autopilot object and reimport the hash to generate a new one.

**Solution 1:**

1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose >  **Devices** > **Windows** > **Windows devices**.
2. Select the device which is experiencing the issue, and then click the ellipsis (…) on the rightmost side.
3. Select **Unassign user** and wait for the process to finish.
4. Verify that the Hybrid Microsoft Entra Autopilot profile is assigned before reattempting OOBE.

**Solution 2:**

If the issue persists, on the server that hosts the Offline Domain Join Intune Connector, check to see if Event ID 30132 is logged within the ODJ Connector Service log. Event 30132 resembles the following event:

```output
Log Name:      ODJ Connector Service
Source:        ODJ Connector Service Source
Event ID:      30132
Level:         Error
Description:
{
          "Metric":{
                   "Dimensions":{
                             "RequestId":"<RequestId>",
                             "DeviceId":"<DeviceId>",
                             "DomainName":"contoso.com",
                             "ErrorCode":"5",
                             "RetryCount":"1",
                              "ErrorDescription":"Failed to get the ODJ Blob. The ODJ connector does not have sufficient privileges to complete the operation",
                              "InstanceId":"<InstanceId>",
                              "DiagnosticCode":"0x00000800",
                              "DiagnosticText":"Failed to get the ODJ Blob. The ODJ connector does not have sufficient privileges to complete the operation [Exception Message: \"DiagnosticException: 0x00000800. Failed to get the ODJ Blob. The ODJ connector does not have sufficient privileges to complete the operation\"] [Exception Message: \"Failed to call NetProvisionComputerAccount machineName=<ComputerName>\"]"
                   },
                   "Name":"RequestOfflineDomainJoinBlob_Failure",
                   "Value":0
          }
}
```

This issue is usually caused by incorrectly delegating permissions to the organizational unit where the Windows Autopilot devices are created. For more information, see [Increase the computer account limit in the Organizational Unit](/mem/autopilot/windows-autopilot-hybrid#increase-the-computer-account-limit-in-the-organizational-unit).

1. Open **Active Directory Users and Computers (DSA.msc)**.
2. Right-click the organizational unit that you will use to create Microsoft Entra hybrid joined computers > **Delegate Control**.
3. In the **Delegation of Control** wizard, select **Next** > **Add** > **Object Types**.
4. In the **Object Types** pane, select the **Computers** check box > **OK**.
5. In the **Select Users**, **Computers**, or **Groups** pane, in the **Enter the object names to select** box, enter the name of the computer where the Connector is installed.
6. Select **Check Names** to validate your entry > **OK** > **Next**.
7. Select **Create a custom task to delegate** > **Next**.
8. Select the **Only the following objects in the folder** check box, and then select the **Computer objects**, **Create selected objects in this folder**, and **Delete selected objects in this folder** check boxes.
9. Select **Next**.
10. Under **Permissions**, select the **Full Control** check box. This action selects all the other options.
11. Select **Next** > **Finish**.

## The Enrollment Status Page times out

In this scenario, the Enrollment Status Page (ESP) times out before the sign in screen can load.

**Cause:** This issue can arise if all the following conditions are true:

- You're using the ESP to track Microsoft Store for Business apps.
- You have a Microsoft Entra Conditional Access policy that uses the **Require device to be marked as compliant** control.
- The policy applies to All Cloud apps and Windows.

**Solution:**

Try one of the following methods:

- Target your Intune compliance policies to devices. Make sure that compliance can be determined before the user logs on.
- Use offline licensing for store apps. This way, the Windows client doesn't have to check with the Microsoft Store before determining device compliance.
