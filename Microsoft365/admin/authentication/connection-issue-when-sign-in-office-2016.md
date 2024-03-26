---
title: Connection issues in sign-in after update to Office 2016 build 16.0.7967
description: Office Web Account Manager (WAM) sign-in issues after you update to Office 2016 build 16.0.7967 or later on Windows 10.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365 Apps for enterprise
  - Office 2016
ms.date: 03/31/2022
---

# Connection issues in sign-in after update to Office 2016 build 16.0.7967 on Windows 10

> [!TIP]
> To diagnose and automatically fix several common Office sign-in issues, you can download and run the [Microsoft Support and Recovery Assistant](https://aka.ms/SaRA-OfficeSignInScenario).

## Overview

This article contains information about a new authentication framework for Microsoft Office 2016.

By default, Microsoft Microsoft 365 Apps for enterprise (2016 version) uses Azure Active Directory Authentication Library (ADAL) framework-based authentication. Starting in build 16.0.7967, Office uses Web Account Manager (WAM) for sign-in workflows on Windows builds that are later than 15000 (Windows 10, version 1703, build 15063.138).

### General guidance

If you experience authentication issues in Office application on Windows 10, we recommend to do the following actions:

- Update Office products to the latest build for your channel according to [Update history for Microsoft 365 Apps for enterprise (listed by date)](/officeupdates/update-history-office365-proplus-by-date).
- Make sure that you are running any of the following Windows builds:
  - Any build for Windows 10, version 1809 or a later version
  - 17134.677 or later builds for Windows 10, version 1803
  - 16299.461 or later builds for Windows 10, version 1709
  - 15063.1112 or later builds for Windows 10, version 1703

## Symptoms

You may experience one of the following symptoms after you update to Microsoft Office 2016 build 16.0.7967 or a later version on Windows 10.

### Symptom 1

When the overall network is working on your devices, Office applications may experience connection issues. You may see a message that resembles the following:

> You'll need the internet for this.  
> We couldn't connect to one of the services we needed to sign you in. Please check your connection and try again.  
> 0xCAA70007

:::image type="content" source="./media/connection-issue-when-sign-in-office-2016/error-message-saying-you-need-internet.png" alt-text="Screenshot of the error message shows that you will need the internet for this.":::

To determine whether you're experiencing this kind of issue, follow these steps:

1. Make sure that you're running Office build 16.0.9126.2259 or a later build. (The latest build on your channel is great. See the [general guidance](#general-guidance) in the [Overview](#overview) section.)
2. Open Event Viewer.
3. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID**.
4. In the Operational logs, locate messages from XMLHTTPWebRequest that have the following pattern:

    ```AsciiDoc
    0x?aa7????,  0x?aa8????, 0x?aa3????, 0x102, 0x80070102
    ```  

5. Make sure that the time of these errors is related to the time when you actually had an Internet connection. This is not an intermittent network issue because of the loss of a Wi-Fi connection or a wake-up after hibernation and initialization of the network stack.

Then, to determine whether your issue is due to network environment or local firewall/antivirus software, follow these steps:  
  
1. Open Edge (not Internet Explorer) and go to [https://login.microsoftonline.com](https://login.microsoftonline.com). Navigation should land on [https://www.office.com](https://www.office.com) or your company's default landing page. If this fails, the issue is in a network environment or local firewall/antivirus software.
  
1. Open Edge (not Internet Explorer) in InPrivate mode and go to [https://login.microsoftonline.com](https://login.microsoftonline.com). After you enter credentials, navigation should land on [https://www.office.com](https://www.office.com) or your company's default landing page. If this fails, the issue is in a network environment or local firewall/antivirus software.

To resolve this issue, make sure that your local firewall, antivirus software, and Windows Defender don't block the following Microsoft Entra WAM plug-in processes that engaged in token acquisition:

C:\Windows\SystemApps\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\Microsoft.AAD.BrokerPlugin.exe

C:\Windows\System32\backgroundTaskHost.exe

**Note** The **PackageFamilyName** of the plugin is the following:

Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy

Also, make sure that your network environment doesn't block the primary destination:

https://login.microsoftonline.com/

**Note** This primary address covers many IP addresses (and many services). Some of these addresses may be blocked in the environment for no good reason, which causes intermittent problems in some devices while other devices work fine.

### Symptom 2

When you try to open or save a document in Microsoft SharePoint Online, OneDrive for Business, or SharePoint, or you try to synchronize email messages or your calendar in Microsoft Outlook, you're prompted for credentials. After you enter credentials, you're prompted again. This issue may occur for the following reasons:

- The Trusted Platform Module (TPM) chip or firmware is malfunctioning. Windows uses the TPM chip to protect your credentials. The chip may become corrupted or reset in some conditions. To determine whether you are experiencing this kind of issue, follow these steps:  
  1. Open Event Viewer.
  2. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID**.
  3. In the Operational logs, locate the errors that display the following pattern:
0x?**028**????, 0x?**029**???? or 0x?**009**????

   To avoid this issue in future, we recommend that you update the TPM firmware.  

   **For Windows 10, version 1709 or later versions:** The operating system automatically detects situations that are related to TPM failures and provides a user recovery process that should occur automatically. If this process doesn't occur automatically, we recommend that you use [this manual recovery](#manual-recovery) method.

   **For Windows 10, version 1703:** An automatic process is provided for Microsoft Entra hybrid join. No automatic process is provided for other environment configurations. If the Microsoft Entra hybrid join process doesn't occur automatically, we recommend that you use [this manual recovery](#manual-recovery) method.
- A device is disabled by the user, the Enterprise administrator, or a policy because of a security concern or by mistake. To determine whether you are experiencing this issue, follow these steps:  
  1. Open Event viewer.
  2. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID**.
  3. In the Operational logs, locate the following message:

    **Description: AADSTS70002: Error validating credentials. AADSTS135011: Device used during the authentication is disabled.**

    To resolve this issue, we recommend that the Enterprise administrator enable the device in Active Directory or Microsoft Entra ID. For information about how to manage devices in Microsoft Entra ID, see the [Device management tasks](/azure/active-directory/devices/device-management-azure-portal#device-management-tasks) section of the "How to manage devices using the Azure portal" topic.

- The Enterprise administrator or a policy deleted a device because of a security reason or by mistake. To verify that you are experiencing this issue, follow these steps:  
  1. Open Event viewer.
  2. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID**.
  3. In the Operational logs, locate the following message:

    **Description: AADSTS70002: Error validating credentials. AADSTS50155: Device is not authenticated.**

  To resolve this issue, we recommend that you recover the device by using the [manual recovery](#manual-recovery) method. **Note** If nobody on the Enterprise deleted the device, please file a support ticket and provide an example of a device that is not recovered.

#### Manual recovery

To do a manual recovery of the computer, follow the appropriate steps, depending on how the device is joined to the cloud (Microsoft Entra hybrid join, Add a work account, or Microsoft Entra join).

- **Microsoft Entra hybrid join**

    Run the following command: ​​`>dsregcmd /status`

    The result should contain the following fields (in Device state):  

    ```AsciiDoc
    AzureAdJoined : YES
    DomainJoined : YES
    DomainName : <CustomerDomain>
    ```

    The current logon user should be a domain user. The affected identity should be the current logon user.

    **Recovery (safe to do):**

    Run the `Dsregcmd /leave` command in an administrative Command Prompt window, and then restart the system.

- **Add a work account**

    Run the following command:   `>dsregcmd /status`

    The result should contain the following field (in User state):  

    ```AsciiDoc
    WorkplaceJoined : YES
    ```

    The device state can be set to any option. The current logon user can be any user. The affected identity should be a work or school account that you can see in **Setting** > **Accounts** > **Access work or school**.

    **Recovery (safe to do):**

    Remove the work account in **Setting** > **Accounts** > **Access work or school**, and then restore the work account.
- **Microsoft Entra join**

    Run the following command:   `>dsregcmd /status`

    The result should contain the following fields (in Device state):  

    ```AsciiDoc
    AzureAdJoined : YES
    DomainJoined : NO
    ```

    The current logon user should be a Microsoft Entra user. The affected identity should be the current logon user.

    **Recovery:**

    **Note** Back up your data first.

    Create a new local administrator. Disconnect from the domain (**Setting** > **Accounts** > **Access work or school** > **Disconnect**). Then, log on as the new local administrator, and reconnect to Microsoft Entra ID.

### Symptom 3

The Office sign-in workflow stops or shows no on-screen progress. The sign-in window shows a "Signing in" message or a blank authentication screen.

:::image type="content" source="./media/connection-issue-when-sign-in-office-2016/sign-in-page.png" alt-text="Screenshot of the page that shows the Signing in status.":::

This issue occurs because WAM is disabling non-HTTPS traffic to prevent security threats, such as someone stealing user credentials. To verify that you are experiencing this issue, follow these steps:

1. Open Event viewer.
2. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID**.
3. In the Operational logs, locate the following message:

    > Navigation to non-SSL destination. Non-secure communication is prohibited. Canceling navigation.

To resolve this issue and secure user credentials, we recommend that you enable HTTPS on the Identity servers.

### Symptom 4

You have a non-persistent Virtual Desktop Infrastructure (VDI) environment that has a federated Identity Provider (IdP) that is configured as Single-Sign On (SSO). You do not expect to be prompted to activate or sign in because SSO is configured. However, you are prompted to sign in for each new session. [Office ULS logs](/office/troubleshoot/diagnostic-logs/how-to-enable-office-365-proplus-uls-logging) display the following error message:

> {"Action": "BlockedRequest", "HRESULT": "0xc0f10005"

> [!NOTE]
> Please open a support case if you experience this issue. We require more log entry reports to help isolate the issue.

## More information

The following guidelines apply to this article:

- On builds of Windows 7, Windows 8, Windows 8.1, or Windows 10 that are earlier than 15000, ADAL authentication is the only option.
- The Windows build should be later than 15000 (Windows 10, version 1703, build 15063.138, Generally Available). For more information, see [Windows 10 release information](/windows/release-information/).
- This article applies whether you use Microsoft Federation or non-Microsoft Federation solutions.

For more information, see the following Knowledge Base article:

[4347010](https://support.microsoft.com/help/4347010) Error Code: 0x8004deb4 when signing in to OneDrive for Business
