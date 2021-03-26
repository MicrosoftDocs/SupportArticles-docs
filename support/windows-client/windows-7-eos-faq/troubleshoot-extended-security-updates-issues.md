---
title: Troubleshoot issues in Extended Security Updates (ESU)
description: Discusses troubleshooting methods to resolve issues that affect Extended Security Updates in Windows 7 and Windows Server 2008 and 2008 R2.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: v-elj, chawong, squin, scottmca, winciccore, kaushika
ms.prod-support-area-path: Troubleshoot issues in ESU
ms.technology: windows-client-eos
adobe-target: true
---
# Troubleshoot issues in ESU

This article describes emerging issues that affect Extended Security Updates (ESU) deployments and the steps to troubleshoot these issues. This information is organized by task, as follows:

- Installing update prerequisites
- Installing ESU keys
- Activating ESU keys
- Installing ESU
- Maintaining ongoing ESU compliance

_Original product version:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 4547184

## Installing ESU prerequisites

You may experience the following issues when you install the ESU prerequisites.  

### The update isn't applicable to your computer

When you install an update that's required by ESU, you see a message similar to the following example:

> The update is not applicable to your computer.

#### Possible cause

The package that you're trying to install isn't applicable to your Windows operating system edition or architecture.

#### Actions to take

- Make sure that the package is meant for your operating system edition and architecture.
- Restart the computer, and then try to install the package again.​
- If you still see the error message, see [The update is not applicable to your computer](/windows/deployment/update/windows-update-troubleshooting#the-update-is-not-applicable-to-your-computer).

#### Additional steps

If the preceding steps don't resolve the problem, follow these steps on the affected computer:

1. Copy the component-based servicing (CBS) log file (C:\Windows\Logs\CBS\CBS.log).
2. Contact [Microsoft Support](https://support.microsoft.com/contactus/), and provide this log file.  

### Installer encountered an error: 0x80096010. The digital signature of the object did not verify

When you install an update that's required by ESU, you see a message similar to the following example:

> Installer encountered an error: 0x80096010.  
The digital signature of the object did not verify.

#### Possible cause

The computer is missing the SHA-2 updates.

#### Actions to take

Install the SHA-2 updates. For a list of prerequisites and SHA-2 updates, see the "Installation prerequisites" section of [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091#).

## Installing ESU product activation keys

You may experience the following problems when you install a product activation key for ESU on a computer. This section assumes that all of the prerequisite updates for ESU are installed on the computer.  

### Run 'slui.exe 0x2a 0xC004F050' to display the error text.  Error: 0xC004F050  

When you install an ESU key, you see a message similar to the following example:  

> Run 'slui.exe 0x2a 0xC004F050' to display the error text.  
Error: 0xC004F050

#### Possible causes

This problem may occur under any of the following conditions:

- The licensing monthly rollup/security only/standalone package isn't installed on the computer.
- The computer hasn't been restarted after installing the updates.  
- Windows Server 2008 SP2-based computers sometimes require another restart.  

#### Actions to take

1. Review the update history of the computer to make sure that all the ESU prerequisites have been installed successfully. For a list of the prerequisites, see [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091#).
2. ​​Verify that the key that you're installing is the correct key for the computer and its operating system.
3. Restart the computer, and then install the key again.​​

#### Additional steps

If the preceding steps don't resolve the problem, follow these steps on the affected computer:  

1. Copy the component-based servicing (CBS) log file (C:\Windows\Logs\CBS\CBS.log).  
2. Contact [Microsoft Support](https://support.microsoft.com/contactus/), and provide this log file.  

### Error: 0xC004F050 The Software Licensing Service reports that the product key is invalid  

When you install the ESU product key by using `slmgr.vbs /ipk`, you receive the following Windows Script Host message:  

> Error: 0xC004F050 The Software Licensing Service reported that the product key is invalid.

#### Cause  

This problem can occur in either of the following circumstances:

- The licensing monthly rollup/security only/standalone package isn't installed on the computer.
- You installed the prerequisite updates, but you didn't restart the computer.  

#### Actions to take

1. Check the computer's update history to make sure that all ESU prerequisite updates have been installed successfully.

    For a list of the required updates and information about how to get them, see [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091).
2. Make sure that the key that you're installing is the correct key for the computer and its operating system.
3. Restart the computer, and try again.

#### Additional steps

If the preceding steps don't resolve the problem, follow these steps on the affected computer:

1. Copy the component-based servicing (CBS) log file (C:\Windows\Logs\CBS\CBS.log).
2. Contact [Microsoft Support](https://support.microsoft.com/contactus/), and provide this log file.

### The Software Licensing Service reports that the product key is invalid  

When you add the ESU product key to the Volume Activation Management Tool (VAMT), you receive the following message:

> Unable to verify product key  
The specified product key is invalid, or is unsupported by this version of VAMT. An update to support additional products may be available online.

#### Cause

This issue can occur if two of the files that support VAMT aren't updated to support ESU keys.

#### Resolution  

To fix this problem, update the VAMT configuration files with these steps:

1. Download the [VAMT files](https://www.microsoft.com/download/details.aspx?id=100304). The download includes the following files:
   - pkconfig_win7.xrm-ms
   - pkconfig_vista.xrm-ms
2. Copy the two downloaded files to C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\VAMT3\pkconfig, replacing the older versions of the files.
3. Close VAMT, and then restart it.  

### The Software Licensing Service reports that the product key is invalid 

When you use VAMT to install an ESU key on a computer, you receive the following Action Status message:
> The Software Licensing Service reports that the product key is invalid  

#### Cause

This issue can occur if the computer is missing the prerequisite updates that ESU requires.

#### Resolution

For a list of the required updates and information about how to get them, see [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091).

## Activating ESU keys

You may experience the following problems when you activate the ESU key on a computer. This section assumes that the computer has the product activation key and all the prerequisite updates for ESU installed.

This section is divided into four parts. Some problems may occur during any type of activation, and some problems are specific to the activation type that your use.

### Any activation method  

Error: 0x80072F8F: Content decoding has failed  

When you try to activate a Windows 7, Windows Server 2008, or Windows Server 2008 R2 ESU key, you receive the following error message:

> 0x80072F8F  
147012721  
WININET_E_DECODING_FAILED  
Content decoding has failed  

#### Cause

This issue may occur if TLS 1.0 is disabled and the `HKEY_LOCAL_MACHINE\System\CurrenteControlSet\Control\SecurityProviders\Schannel\Protocols\TLS 1.0\Client` subkey is set as follows:

- DisabledByDefault: 1
- Enabled: 0

#### Actions to take

This method forces the activation process to use TLS 1.2 by default so that TLS 1.0 can remain disabled.

To resolve this issue, follow these steps.

1. If update [3140245](https://support.microsoft.com/help/3140245) isn't installed on the computer, use Windows Update to install it.
2. Open **regedit**, and navigate to the following registry subkey:

     `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp`

    Create or set a **REG_DWORD** value of **DefaultSecureProtocols**, and set it to **0x800**.
3. If the computer is x64, you must also set the following registry key:
  
    `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp`

    Create or set a **REG_DWORD** value of **DefaultSecureProtocols**, and set it to **0x800**.
4. Restart the computer, and then try to run the `slmgr.vbs /ato` command again.

### Slmgr activation  

This section describes problems that you might experience when you use the Slmgr tool for activation.  

### Product activation failed while trying to activate ESU product key

When you try to activate the product key, you get a message similar to the following example:

> Error: Product activation failed.

#### Cause

The Windows operating system edition or architecture isn't eligible for ESU.

#### Actions to take

Make sure that the Windows operating system edition or architecture is in the list of editions and architectures that are supported for ESU. For a list, see [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091#).

#### Additional steps

If the preceding steps don't resolve the problem, contact [Microsoft Support](https://support.microsoft.com/contactus/).

### 0xC004C020 the activation server reported that the Multiple Activation Key (MAK) has exceeded its limit

When you try to activate the product key, you get a message similar to the following example:

> 0xC004C020 the activation server reported that the Multiple Activation Key has exceeded its limit

#### Cause

A MAK supports a limited number of activations. In this case, the MAK has exceeded its activation limit.

#### Actions to take

To increase the number of activations that the MAK key supports, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### Product not found while trying to activate ESU key

When you activate the ESU product key, you receive a "product not found" message.

#### Cause

The activation ID that you used in the activation command isn't correct.

#### Actions to take

To get the activation ID, follow these steps:

1. Open an elevated Command Prompt window.
2. Run the following command: `cscript /h:cscript`.  
3. Run one of the following commands, depending on your version of Windows.
   - For Windows 7: `slmgr /dlv`  
   - For Windows Server 2008 SP2: `slmgr /dlv all`
4. In the command output, copy the activation ID of the ESU key.

To use the activation ID, run the following command: `slmgr /ato <Activation ID>`.

> [!NOTE]
> In this command, \<Activation ID> represents the activation ID of the ESU key.

### 0xC004F025 access denied: the requested action requires elevated privileges

When you try to activate the product key, you receive a message similar to the following example:

> 0xC004F025 access denied: the requested action requires elevated privileges.

#### Possible Cause

You may be using a regular Command Prompt window instead of an elevated Command Prompt window.

#### Actions to take

To open an elevated Command Prompt window:

- Select **Start**, right-click **Command Prompt**, and then select **Run as administrator**.

### Error: 0x80072EE7

When you try to activate the product key, you receive a message similar to the following example:

> On a computer running Microsoft Windows non-core edition, run 'slui.exe 0x2a 0x80072EE7' to display the error text.  
Error: 0x80072EE7

#### Cause 

The computer can't communicate with the Microsoft Activation and Validation Services (AVS) server to activate the ESU key.

#### Actions to take

Make sure that the computer is connected to the internet, or has the Activation URLs in the allow list, and try again.

For computers that don't connect directly to the internet, you can use VAMT Proxy activation or Phone activation as an alternative. For more information, see [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091#).

For the current VAMT Proxy Activation URLs, see the "Volume Activation Management Tool (VAMT) activation" section.

### 0x80072EE2 The operation timed out

When you try to activate the product key, you get a message similar to the following example:

> 0x80072EE2 The operation timed out

#### Possible causes

The computer can't connect to the Microsoft Activation service. It might not be connected to internet, or it might have issues with internet connectivity.

#### Actions to take

Make sure that the computer is connected to internet, or has the Activation URLs in the allow list, and try again.

For computers that don't connect directly to the internet, you can use VAMT Proxy activation or Phone activation as an alternative. For more information, see [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091#).

For the current VAMT Proxy Activation URLs, see the "Volume Activation Management Tool (VAMT) activation" section.

### Activation command succeeds but the ESU key is still in Unlicensed state  

You appear to have successfully activated the ESU key. However, the key still doesn't seem to be properly licensed.

#### Possible cause

The `slmgr /ato` command didn't correctly pass the ESU activation ID.

#### Action to take

To use the activation ID, run the following command: `slmgr /ato <Activation ID>`.

> [!NOTE]
> In this command, \<Activation ID> represents the activation ID of the ESU key.

### License Status: Unlicensed  

Collapsible element body

### Volume Activation Management Tool (VAMT) activation  

This section describes problems that you might experience when you use VAMT online or proxy activation. When you do so, use the following VAMT proxy activation URLs:

- `https://activation.sls.microsoft.com/BatchActivation/BatchActivation.asmx​`
- `https://go.microsoft.com/fwlink/?LinkId=82160` (This FWLink redirects to the preceding URL.)​
​
Or, include the following domains in the computer's allow list:

- activation.sls.microsoft.com​
- `go.microsoft.com`  

### Unable to verify product key

When you try to activate the product key, you get a message similar to the following example:

> Unable to verify product key  
The specified product key is invalid, or is unsupported by this version of VAMT. An update to support additional products may be available online.

#### Possible causes 

There may be a problem in the `pkconfig` files. Those files may have to be replaced.

#### Actions to take

To update the VAMT configuration files, follow these steps:

1. Download the [VAMT files](https://www.microsoft.com/download/details.aspx?id=100304).

    The download includes the following files:
    - pkconfig_win7.xrm-ms
    - pkconfig_vista.xrm-ms  

2. Copy the two downloaded files into C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\VAMT3\pkconfig, replacing the older versions of the files.
3. Close VAMT, and then restart it.

### Unable to connect to the WMI service on the remote machine while activating the remote machine using VAMT online/proxy activation

When you try to activate the product key, you receive a message similar to the following example:

> Unable to connect to the WMI service on the remote machine while activating the remote machine using VAMT online/proxy activation.

#### Possible causes 

Either of the following conditions on the affected computer may cause this problem:  

- The WMI (Windows Management Instrumentation) service isn't turned on.
- Windows Firewall isn't configured correctly to allow VAMT access.

#### Actions to take

- To turn on the WMI service, select **Start** > **Services**, and right-click **Windows Management Instrumentation**. Then select **Restart​**.
- To configure Windows Firewall, follow the instructions in [Configure Client Computers](/windows/deployment/volume-activation/configure-client-computers-vamt).

For more information about how to install the VAMT tool and configure client computers, see [Install and Configure VAMT](https://docs.microsoft.com/windows/deployment/volume-activation/install-configure-vamt).

### Error: Access is denied

When you try to activate the product key, you receive a message similar to the following example:

> Error: Access is denied.

#### Possible Cause

You don't have permissions to access the computer.

#### Actions to take

On a domain-joined VAMT client computer, verify that:

1. You (or the activating user) have permissions to access the client computer.
2. Your account (or that of the activating user) appears in the **User Accounts** list on the client computer. For more information, see [Local Accounts](/windows/security/identity-protection/access-control/local-accounts).

### Phone activation

This section describes problems that you might experience when you use phone activation.  

#### Error: 0xC004F04D The Software Licensing Service determined that the Installation ID (IID) or the Confirmation ID (CID) is invalid  

When you try to activate the product key, you receive a message similar to the following example:

> Run 'slui.exe 0x2a 0xC004F04D' to display the error text.  
Error: 0xC004F04D  

##### Possible Cause

The confirmation ID is incorrect.

##### Actions to take

1. Call the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers) again. They'll walk you through the steps to get a confirmation ID.
2. In an elevated Command Prompt window, run the following command: `slmgr /atp <Confirmation ID> <ESU Activation ID>`.

> [!NOTE]
> In this command, \<Confirmation ID> represents the confirmation ID that you obtained in step 1, and \<ESU Activation ID> represents the activation ID of the ESU product key.

## Installing ESU

You may experience the following problems when you install an ESU update on a computer. This section assumes that the computer has all of the prerequisite updates for ESU, and the product activation key is installed and activated.

### The Windows Module Installer must be updated before you can install the package

When you install an ESU update, you see a message similar to the following example:

> Windows Update Standalone Installer  
The Windows Modules Installer must be updated before you can install this package. Please update the Windows Modules Installer on your computer, then retry Setup.

#### Possible cause  

The Servicing Stack Update (SSU) with AI Changes package isn't installed on the computer.

#### Actions to take  

Verify that the SSU package is installed on the computer. To do so, on the affected computer, select **Start** > **Control Panel** > **Programs** > **Program and Features** > **View Installed updates**.

If the SSU package isn't installed, install it and restart the computer. For more information about this update, see the "Installation prerequisites" section of [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091#).

#### Additional steps  

If the preceding steps don't resolve the problem, on the affected computer, copy the component-based servicing (CBS) log file (C:\Windows\Logs\CBS\CBS.log). Contact [Microsoft Support](https://support.microsoft.com/contactus/), and provide this log file.  

### Some updates weren't installed while trying to install the security update

When you install an ESU update, you see a message similar to the following example:

> Download and Install Updates
Some updates were not installed
For information about other error codes, refer to the [Windows Update](https://docs.microsoft.com/windows/deployment/update/windows-update-error-reference) error reference.

#### Possible causes

This problem may occur under any of the following conditions:

- A valid ESU key isn't installed on the computer.​
- On a desktop client or server, the ESU key is installed but isn't activated.​
- On a Windows Embedded device, see [Windows Embedded devices](#windows-embedded-devices) for possible causes.​
- The Windows operating system that is installed on the computer isn't in the list of ESU supported editions or architectures. For a list of the supported editions and architectures, see [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091#).

#### Actions to take

On a desktop client or server computer, follow these steps to verify that the computer has a valid ESU key installed and activated.

1. Open an elevated Command Prompt window and then run one of the following commands:
   - `slmgr /dlv`  (Windows 7 only)
   - `slmgr /dlv <Activation ID>`  
        > [!Note]
        > In this command, **\<Activation ID>**  represents the activation ID of the ESU key that is installed on the computer.

   - `slmgr /dlv all`  

2. In the command output, verify that ESU key is licensed.  

    ​ ![ESU key is licensed.](./media/troubleshoot-extended-security-updates-issues/esu-key-licensed.gif)

    On a typical (non-embedded) computer, install the ESU key if you haven't already done so. Then activate the key by using one of the following methods:

    - [VAMT online or proxy activation](/windows/deployment/volume-activation/install-configure-vamt)
    - Phone activation​
    - By using the `slmgr /ato` command. To do so, follow these steps:

        1. Open an elevated Command Prompt window.
        2. Run `slmgr /ipk <ESU key>` and wait for the success message.
           > [!Note]
           > In this command, **\<ESU key>** represents the ESU product key for the computer.

3. Run `slmgr /ato <Activation ID>`.

On a Windows Embedded device, see [Windows Embedded devices](#windows-embedded-devices) for appropriate actions to take.​

#### Additional steps

If the preceding steps don't resolve the problem, on the affected computer, copy the component-based servicing (CBS) log file (C:\Windows\Logs\CBS\CBS.log). Contact [Microsoft Support](https://support.microsoft.com/contactus/), and provide this log file.  

### Error: 80070643 - prep-check KB installation fails  

When you install an ESU update, you see a message similar to the following example:

> Error: 80070643 - prep-check KB installation fails

The message may reference one of the following KBs:

- KB 4528081 for Windows Server 2008 SP2
- KB 4528069 for Windows 7 / Windows Server 2008R2

The CBS log may contain messages similar to the following example:

- ESU: Product = 36 (0x00000024).
- ESU: Is IMDS check needed: FALSE​
- ESU: Pre IMDS checks failed, Not Eligible:HRESULT_FROM_WIN32(1605)
- [1605 = ERROR_UNKNOWN_PRODUCT](/windows/win32/debug/system-error-codes--1300-1699-)  

#### Possible causes

- The operating system edition is not supported by the prep-check KB. The prep-check KB doesn't support `*V` or `*Core` editions.
- The most recent Servicing Stack Update (February 11, 2020, or later) and Monthly Rollup update (February 11, 2020, or later) aren't installed on the computer.

#### Actions to take

Install the latest Servicing Stack Update (February 11, 2020, or later) and Monthly Rollup (February 11, 2020, or later), and then try again.

### Windows Embedded devices

When you install ESU on a device that runs a Windows Embedded operating system, you may notice the following problems. ESU: NO ESU KEY FOUND  

You have a device with a Windows product key that falls within the range of keys defined for embedded editions of Windows. When you install an ESU update, some of the updates don't install. And the CBS log contains entries similar to the following example:

> ESU: NO ESU KEY FOUND  

For example, you see the following log entries.  

![CBS log no esu key](./media/troubleshoot-extended-security-updates-issues/log-entries-no-esu.png)

#### Possible causes

The ESU product key isn't installed on the device.

#### Actions to take

Install a valid Windows Embedded ESU key on the computer, and then try to install the ESU package again.  

### HRESULT_FROM_WIN32(1633), Windows key in range of Windows Embedded keys  

You have a device that has a Windows product key that falls within the range of keys that has been defined for embedded editions of Windows. When you install an ESU update, some of the updates don't install, and the CBS log contains entries similar to the following example:

> ESU: Windows is not activated.  
ESU: not eligible:HRESULT_FROM_WIN32(1633)  

For example, you see the following log entries.  

![CBS log in the range](./media/troubleshoot-extended-security-updates-issues/log-entries-in-range.png)

#### Possible cause

Either the Windows product key or the ESU product key (or both) is installed on the device but isn't activated.

#### Actions to take

Activate the Windows product key or the ESU product key (or both) and try to install the ESU package.  

### HRESULT_FROM_WIN32(1633), Windows key out of range of Windows Embedded keys  

You have a device with a Windows product key that doesn't fall within the range of keys defined for embedded editions of Windows. When you install an ESU update, some of the updates don't install and the CBS log contains entries similar to the following example:

> ESU: Windows is not activated.  
ESU: not eligible:HRESULT_FROM_WIN32(1633)  

For example, you see the following log entries.

![CBS log out of the range](./media/troubleshoot-extended-security-updates-issues/log-entries-out-range.png)

#### Possible cause

The ESU product key is installed on the computer but isn't activated.

#### Actions to take

Activate the ESU product key, and then try to install the ESU package again.

## Maintaining ongoing ESU compliance  

You notice a non-compliant device in your update management and compliance toolsets.  

If you have a subset of devices that are running Windows 7 Service Pack 1 (SP1) and Windows Server 2008 R2 SP1 without ESU, you notice a non-compliant device in your update management and compliance toolsets.

Windows Server Update Service (WSUS) continues to scan cab files for Windows 7 SP1 and Windows Server 2008 R2 SP1.

## More information

- [Troubleshooting Windows volume activation](/windows-server/get-started/activation-troubleshooting-guide)  
- [Resolve Windows activation error codes](/windows-server/get-started/activation-error-codes)  
- [Using the Activation troubleshooter](https://support.microsoft.com/help/20527/windows-10-activation-troubleshooter)  
- [Get help with Windows activation errors](https://support.microsoft.com/help/10738/windows-10-get-help-with-activation-errors)  
- [FAQ about Extended Security Updates for Windows 7](https://support.microsoft.com/help/4527878/faq-about-extended-security-updates-for-windows-7)  
- [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091)  
- [How to use Windows Server 2008 and 2008 R2 extended security updates (ESU)​](/windows-server/get-started/extended-security-updates)  
- [Extended Security Updates and Configuration Manager ​](https://techcommunity.microsoft.com/t5/configuration-manager-blog/extended-security-updates-and-configuration-manager/ba-p/825618)  
- [What are Extended Security Updates for SQL Server?](/sql/sql-server/end-of-support/sql-server-extended-security-updates?view=sql-server-ver15&preserve-view=true)  
- ​[Lifecycle FAQ-Extended Security Updates](https://support.microsoft.com/help/4497181/lifecycle-faq-extended-security-updates)  
