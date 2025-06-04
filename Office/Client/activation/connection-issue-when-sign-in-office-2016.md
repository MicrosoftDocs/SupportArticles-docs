---
title: Connection Issues When Signing In After Updating to Office 2016 Build 16.0.7967
description: Resolves Web Account Manager (WAM) sign-in issues after you update to Office 2016 build 16.0.7967 or later on Windows 10.
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - CSSTroubleshoot
  - CI 5938
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Office 2016
ms.date: 06/04/2025
---

# Connection issues when signing in after updating to Office 2016 build 16.0.7967 on Windows 10

> [!TIP]
> To diagnose and automatically fix common Office sign-in issues, run the [Microsoft 365 Sign-in troubleshooter](https://aka.ms/SaRA-OfficeSignIn-sarahome).

By default, Microsoft 365 Apps for enterprise (2016 version) uses Azure Active Directory Authentication Library (ADAL) framework-based authentication. Starting in build 16.0.7967, Office uses Web Account Manager (WAM) for sign-in workflows on Windows builds that are later than 15000 (Windows 10, version 1703, build 15063.138).

If you experience authentication issues in Office applications on Windows 10, perform the following actions:

- Update to the latest build for your channel according to [Update history for Microsoft 365 Apps for enterprise](/officeupdates/update-history-office365-proplus-by-date).
- Make sure that you're running Windows 10, version 22H2.

## Symptoms

After you update to Microsoft Office 2016 build 16.0.7967 or a later version on Windows 10, you might experience one of the following symptoms.

### Symptom 1

When the overall network is working on your devices, Office applications might experience connection issues. You might receive a message that resembles the following example:

> You'll need the internet for this.  
> We couldn't connect to one of the services we needed to sign you in. Please check your connection and try again.  
> 0xCAA70007

:::image type="content" source="./media/connection-issue-when-sign-in-office-2016/error-message-saying-you-need-internet.png" alt-text="Screenshot of the you will need the internet for this error message.":::

To determine whether you're experiencing this issue, follow these steps:

1. Make sure that you're running Office build 16.0.9126.2259 or a later build.
1. Open Event Viewer.
1. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **AAD** > **Operational**.
1. Look for entries that mention `XMLHTTPWebRequest` and contain error codes that show the following pattern:

    ```output
    0x?AA7????,  0x?AA8????, 0x?AA3????, 0x102, 0x80070102
    ```  

1. Make sure that the time at which these errors occur corresponds with the time at which you actually connect to the internet. Also, make sure that the connection error isn't an intermittent network issue that's caused by a loss of Wi-Fi connection or a wake-up after hibernation and initialization of the network stack.

Then, to determine whether your issue is caused by network environment or local firewall or antivirus software, follow these steps:
  
1. Open Edge (not Internet Explorer), andthen go to [https://login.microsoftonline.com](https://login.microsoftonline.com). Navigation should land on [https://www.office.com](https://www.office.com) or your company's default landing page. If it fails, the issue is caused by a network environment or local firewall/antivirus software.  
1. Open Edge (not Internet Explorer) in InPrivate mode and go to [https://login.microsoftonline.com](https://login.microsoftonline.com). After you enter credentials, navigation should land on [https://www.office.com](https://www.office.com) or your company's default landing page. If it fails, the issue is caused by a network environment or local firewall/antivirus software.

To resolve this issue, make sure that your local firewall, antivirus software, and Windows Defender don't block the following processes that engage in token acquisition:

- C:\Windows\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Microsoft.AAD.BrokerPlugin.exe
- C:\Windows\System32\backgroundTaskHost.exe

Also, make sure that your network environment doesn't block the primary destination [https://login.microsoftonline.com](https://login.microsoftonline.com).

**Note**: This primary address covers many IP addresses and many services. Some of these addresses may be blocked in your environment for no apparent reason. This might cause intermittent problems with some devices while other devices continue to work correctly. 

### Symptom 2

When you try to open or save a document in SharePoint and OneDrive in Microsoft 365, or you try to synchronize email messages or calendar entries in Microsoft Outlook, you're prompted for credentials. After you enter credentials, you're prompted again.

This issue might occur for the following reasons:

- The Trusted Platform Module (TPM) chip or firmware is malfunctioning. Windows uses the TPM chip to protect your credentials. The chip may become corrupted or reset in some conditions. To determine whether you're experiencing this kind of issue, follow these steps:

  1. Open Event Viewer.
  1. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **AAD** > **Operational**.
  1. Look for errors that show the following pattern:

     ```output
     0x?028????, 0x?029????, 0x?009????
     ```

  To avoid this issue in the future, we recommend that you update the TPM firmware.

  **For Windows 10, version 1709 or later versions**: The operating system automatically detects situations that are related to TPM failures and provides a user recovery process that should occur automatically. If this process doesn't occur automatically, we recommend that you use the [manual recovery](#manual-recovery) method.  
- A device is disabled by the user, the administrator, or a policy because of a security concern or by mistake. To determine whether you're experiencing this issue, follow these steps:  
  
  1. Open Event viewer.
  1. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **AAD** > **Operational**.
  1. Look for the following message:

     > Description: AADSTS70002: Error validating credentials. AADSTS135011: Device used during the authentication is disabled.

  To resolve this issue, we recommend that the administrator enable the device in Active Directory or Microsoft Entra ID. For information about how to manage devices in Microsoft Entra ID, see [Manage device identities using the Microsoft Entra admin center](/entra/identity/devices/manage-device-identities).
- The administrator or a policy deleted a device because of a security reason or by mistake. To determine whether you're experiencing this issue, follow these steps:  

  1. Open Event viewer.
  1. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **AAD** > **Operational**.
  1. Look for the following message:

     > Description: AADSTS70002: Error validating credentials. AADSTS50155: Device is not authenticated.**

  To resolve this issue, we recommend that you recover the device by using the [manual recovery](#manual-recovery) method.

  **Note**: If nobody in your organization deleted the device, submit a support request and provide an example of a device that's not recovered.

#### Manual recovery

To perform a manual recovery, follow the appropriate steps, depending on how the device is joined (Microsoft Entra hybrid join, Add a work account, or Microsoft Entra join).

- **Microsoft Entra hybrid join**

   Run the `dsregcmd /status` command. ​​

   The results output should contain the following fields under the **Device State** section:  

   ```output
   AzureAdJoined : YES
   DomainJoined : YES
   DomainName : <CustomerDomain>
  ```

   The current logon user should be a domain user. The affected identity should be the current logon user.

   To perform the recovery, run the `dsregcmd /leave` command in an elevated Command Prompt window, and then restart the device.

- **Add a work account**

   Run the `dsregcmd /status` command.

   The results output should contain the following field under the **User State** section:  

   ```output
   WorkplaceJoined : YES
   ```

   The device state can be set to any option. The current logon user can be any user. The affected identity should be a work or school account in **Setting** > **Accounts** > **Access work or school**.

   To perform the recovery, remove the work account in **Setting** > **Accounts** > **Access work or school**, and then restore the work account.
- **Microsoft Entra join**

   Run the `dsregcmd /status` command.

   The result should contain the following fields under the **Device State** section:  

   ```output
   AzureAdJoined : YES
   DomainJoined : NO
   ```

   The current logon user should be a Microsoft Entra user. The affected identity should be the current logon user.

   To perform the recovery, follow these steps:

   1. Back up your data.
   1. Create a new local administrator.
   1. Disconnect the current logon user account from the domain. To do this, go to **Setting** > **Accounts** > **Access work or school**, select the account, and then select **Disconnect**.
   1. Sign in by using the new local administrator account, and reconnect to Microsoft Entra ID.

### Symptom 3

The sign-in workflow stops, or no progress is shown on the screen. The sign-in window displays a "Signing in" message or a blank authentication screen.

:::image type="content" source="./media/connection-issue-when-sign-in-office-2016/sign-in-page.png" alt-text="Screenshot of the page that shows the Signing in status.":::

This issue occurs because WAM disables non-HTTPS traffic to prevent security threats, such as someone stealing user credentials. To determine whether you're experiencing this issue, follow these steps:

1. Open Event viewer.
1. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **AAD** > **Operational**.
1. Look for the following message:

    > Navigation to non-SSL destination. Non-secure communication is prohibited. Canceling navigation.

To resolve this issue and secure user credentials, we recommend that you enable HTTPS on the identity servers.

### Symptom 4

You have a non-persistent Virtual Desktop Infrastructure (VDI) environment that has a federated Identity Provider (IdP) that's configured as Single-Sign On (SSO). You don't expect to be prompted to activate or sign in because SSO is configured. However, you're prompted to sign in for each new session. Additionally, [Office ULS logs](/office/troubleshoot/diagnostic-logs/how-to-enable-office-365-proplus-uls-logging) display the following error message:

> {"Action": "BlockedRequest", "HRESULT": "0xc0f10005"

To resolve this issue, submit a support request. We require more log entry reports to help isolate the issue.

## References

[Error Code: 0x8004deb4 when signing in to OneDrive](https://support.microsoft.com/office/error-code-0x8004deb4-when-signing-in-to-onedrive-e8a8d97c-a87e-4dda-a67e-bae4fef05dcb)
