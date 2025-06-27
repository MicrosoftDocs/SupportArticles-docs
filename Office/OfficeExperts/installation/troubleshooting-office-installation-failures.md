---
title: Troubleshooting Office installation errors
description: Describes techniques on how to determine and fix Microsoft Office installation failures.
author: helenclu
ms.author: luche
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: ericspli
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\SxS\SxSOrPerpetual
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office
ms.date: 06/06/2024
---

# Troubleshooting Office installation failures

This article was written by [Eric Ashton](https://social.technet.microsoft.com/profile/EricAshton), Senior Support Escalation Engineer.

This article describes techniques on how to determine and fix Microsoft Office installation failures. The techniques can be applied to all Office installations that use Windows Installer (MSI).

## Enable verbose logging

When you troubleshoot Office install failures, make sure that MSI verbose logging is enabled. In Office, there's a setup.exe log file that's created by default. However, it doesn't give the detail that's usually required to diagnose an installation failure. With verbose MSI logging enabled, you'll get a verbose log file for each component that Office installs. You'll have a verbose log for the installation of the Word component, Excel, and so on.

To enable verbose logging, set the following registry keys:

HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Installer

"**Debug**"=dword:**00000007**

"**Logging**"="**voicewarmup**"

For more information about Windows Installer logging, see [How to enable Windows Installer logging](https://support.microsoft.com/help/223300/how-to-enable-windows-installer-logging).

## Perform the installation attempt

If you're running your installation manually on the computer as a signed-in user by double-clicking setup.exe, the log files will be generated in the **%temp%** directory of the user who performs the installation.

Now that you have enabled verbose logging and know where you should look for the logs, just retry your installation. It's failed previously, expect it to fail again. However, this time, you're ready to capture log files that will be detailed enough to help you diagnose the failure point.

## Analyzing logs

After your install attempt, you'll find that you have somewhere between 1 and 20 logs from the installation in your temp directory.

Here's a screenshot of the verbose logs from an installation attempt.

:::image type="content" source="media/troubleshooting-office-installation-failures/verbose-logs.png" alt-text="Screenshot shows an example of the verbose logs from an installation attempt.":::

When you look through the MSI logs, we will typically want to look for a value 3 entry in the logs. Windows installer returns codes during the installation that indicate if a particular function is successful or not.

- Value 1 = Success
- Value 2 = Cancel
- Value 3 = Error

In a good installation, you'll typically not see any *value 3* entries in the logs.

Therefore, there are many logs to verify. We recommend that you start with the setup.exe log. This log usually has a value 3 entry in it when there is a failure. However, this log isn't clear enough to diagnose the issue. If it doesn't have a *value 3* entry, look for the first instance of ***Rolling back package***. Rolling back package indicates that the Office installation has failed and Office is trying to "roll back" the installation. You should be able to identify the failure immediately at that point. As soon as you find *value 3* or *Rolling back package* in the setup.exe log, you should be able to identify which component is failing, and then from there look for the particular MSI log that corresponds to that component.

There's frequently more than one *value 3* or *rolling back package* entry. You should focus on the first entry that you find.

Here are some examples of Office installation failures and how we can identify the failure point.

### Analyze log example 1: Office ProPlus 2010 installation

In this example, you don't find a *value 3* entry in the setup.exe log, and then you search the setup.exe log for *Rolling back package*.

You may find the following error:

*Error: Failed to install product: C:\MSOCache\All Users\GUID-C\ProPlusWW.msi ErrorCode: 1603(0x643).*

*Log level changed from: Standard to: Verbose*

*Rolling back chain*

*Date/Time Rolling back package: ProPlusWW*
 
The error doesn't tell you why the installation failed. But it does tell you that the failure occurred during the installation of the ProPlusWW.msi file. Then, you have to find the verbose MSI log that correlates with ProPlusWW.msi.

> [!NOTE]
> - If you know that the failure is in ProPlusWW.msi, but you don't want to waste time finding which MSI log is for ProPlus, it's usually the largest log file.
> - If you don't know which log is the correct log for the ProPlusWW.msi component, open each log one at a time and scroll to the bottom. It indicates which component just tried to install or rollback.

For example, from the bottom of the MSIb0bc7.LOG, you see the information that resembles the following:

*MSI (s) (50:CC) [Time]: Note: 1: 1724*

*MSI (s) (50:CC) [Time]: Product: Microsoft Office Outlook MUI (English) 2010 -- Removal completed successfully.*

So this is the verbose MSI log for the Office Outlook MUI component, and the component is from the rollback (the installation failure occurred earlier than this rollback).

When you find the ProPlus log (it's the biggest one), you see the following information that indicates it's the ProPlus log:

*Product: C:\MSOCache\All Users\GUID-C\ProPlusWW.msi*

When you search the log for a *value 3* entry, you may not find one, but you may see the following error at the bottom of the log:

*MSI (s) (B0:14) [Time]: Internal Exception during install operation: 0xc0000017 at 0x7C812AFB.*
*MSI (s) (B0:14) [Time]: WER report disabled for silent install.*
*MSI (s) (B0:14) [Time]: Internal MSI error. Installer terminated prematurely.*
*Out of memory.  Shut down other applications before retrying.*
*MSI (s) (B0:14) [Time]: MainEngineThread is returning 1603.*

This is a known issue about Windows Installer. To fix this issue, install the [hotfix](https://support.microsoft.com/help/972397/a-hotfix-for-windows-installer-is-available-for-windows-xp-windows-ser
). After you install the hotfix and restart, the installation is successful.

### Analyze log example 2: Access 2010 stand-alone install

In this example, you don't find a *value 3* entry in the setup.exe log, and then you search the setup.exe log for *Rolling back package*. You may find the following error:

*Error: Failed to install product: C:\MSOCache\All Users\GUID-C\AccessRWW.msi ErrorCode: 1601(0x641).*

*Log level changed from: Standard to: Verbose*

*Rolling back chain*

*Date/Time Rolling back package: AccessRWW*

The error doesn't tell you why the installation failed, but it does tell you that the failure occurred during the installation of the AccessRWW.msi file. Looking through the log files, you may find a log for AccessRWW.msi:

*Product: C:\MSOCache\All Users\GUID-C\AccessRWW.msi*

When you search for a *value 3* entry, you find the following error:

*CAInitSPPTokenStore.x86:  OMSICA : Initializing CustomAction CAInitSPPTokenStore.x86*
*CAInitSPPTokenStore.x86:  Error: Failed to initialize the SPP Token store. HResult: 0x80070057.*
*CAInitSPPTokenStore.x86:*
*MSI (s) (2C:D0) [Time]: User policy value 'DisableRollback' is 0*
*MSI (s) (2C:D0) [Time]: Machine policy value 'DisableRollback' is 0*
*Action ended Time: InstallExecute. Return value 3.*

To fix this issue, make sure that the network service is running, and then make sure that the following registry keys are present.

- HKEY_USERS\S-1-5-20
- HKEY_USERS\S-1-5-19

### Analyze logs example 3: Office ProPlus 2010

In this next example, you find a value 3 entry in the setup.exe log that resembles the following error:

*MSI(ERROR): 'Error 1304. Error writing to file: C:\WINDOWS\winsxs\Policies\x86_policy.8.0.Microsoft.VC80.ATL_1fc8b3b9a1e18e3b_x-ww_5f0bbcff\8.0.50727.4053.policy. Verify that you have access to that directory.'*

*Log level changed from: Standard to: Verbose*

*Not showing message because suppress modal has been set. Title: 'Setup', Message: 'Error 1304. Error writing to file: C:\WINDOWS\winsxs\Policies\x86_policy.8.0.Microsoft.VC80.ATL_1fc8b3b9a1e18e3b_x-ww_5f0bbcff\8.0.50727.4053.policy. Verify that you have access to that directory.'*

*Message returned: 2*

*MSI(USER): 'Are you certain you want to cancel?'*

*MSI(INFO): 'Action ended 14:03:01: InstallExecute. Return value 3.'*

When you see a value 3 entry in the setup.exe log, it will sometimes give you enough information to fix the issue without having to view the verbose MSI log. In this case, the verbose MSI log just repeated what we found in the setup.exe log.

In this case, you should consider updating .net framework, and verifying the permissions in c:\windows\winsxs.

## Known errors from verbose logs and possible resolutions

Some of these suggestions discuss working with registry keys. 

> [!WARNING]
> Follow the steps in this section carefully. Serious problems might occur if you change the registry incorrectly. Before you change it, [back up the registry for restoration](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows) in case problems occur.

### Error 1935

*Error 1935. An error occurred during the installation of assembly component. HRESULT: 0x80070003. assembly interface: IAssemblyCache, function: CreateAssemblyCacheItem, assembly name: Microsoft.VC90.ATL,version="9.0.30729.4148",type="win32",processorArchitecture="amd64",publicKeyToken="PublicKeyToken"*

*MSI (s) (1C:9C) [Time]: User policy value 'DisableRollback' is 0*

*MSI (s) (1C:9C) [Time]: Machine policy value 'DisableRollback' is 0*

*Action ended Time: InstallExecute. Return value 3.*

**Solution**

This most frequently occurs because of issues when you upgrade Office. First thing to try is to remove the earlier version of Office before you install a new version. You can remove the earlier version of Office automatically by using the appropriate tool from [here](https://support.office.com/article/uninstall-office-from-a-pc-9dd49b83-264a-477a-8fcc-2fdf5dbf61d8?ui=en-US&rs=en-US&ad=US). After you remove the earlier version of Office, try to install the newer version of Office.

### 1913

*Error 1913: Setup cannot update file C:/windows/win.ini.*
*Verify that the file exists in your system and that you have sufficient permissions to update it.*

**Cause**

There's a known issue with Trend Micro that might be causing this issue and preventing the Office installation.

**Solution**

If you use Antivirus or other security software, consider uninstalling it, rebooting and trying the installation again.

### Error 1714 

*Error 1714. Setup cannot remove the older version of Microsoft Office Product_Name 2007. Contact Microsoft Product Support Services (PSS) for assistance. For information about how to contact PSS, see C:\DOCUME~1\username\LOCALS~1\Temp\Setup00000d64\PSS10R.CHM.*

**Solution**

- Method 1: Remove the earlier versions of Office first if you try to perform an upgrade. For more information about how to remove Office, see [Uninstall Office from a PC](https://support.office.com/article/uninstall-office-from-a-pc-9dd49b83-264a-477a-8fcc-2fdf5dbf61d8?ui=en-US&rs=en-US&ad=US).
- Method 2: Perform a side-by-side installation instead of upgrading. (This is a Customize button).

### Error 1719

*Error 1719. Windows Installer Service could not be accessed. This can occur if the Windows Installer is not correctly installed. Contact support personnel for assistance.*

**Cause**

This issue occurs if the registry keys are corrupted or incorrect at HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\msiserver.

**Solution**

Method 1:

1. Export the **msiserver** registry key from a known good computer that uses the same OS and Windows Installer version.
1. Back up and then delete the existing **msiserver** key on the bad computer under: 

   HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\msiserver

1. Import the registry file from the known good computer to the bad computer.
1. Restart and then retry the installation.

Method 2:

Refer to ["The Windows Installer service could not be accessed" error message when you try to install Office](https://support.microsoft.com/help/324516/the-windows-installer-service-could-not-be-accessed-error-message-when).

### Error 1406

*Error 1406.Setup cannot write the value to the registry key \CLSID\GUID. Verify that you have sufficient permissions to access the registry or contact Microsoft Product Support Services (PSS) for assistance. For information about how to contact PSS see C:\Users\ADMINI~1\AppData\Local\Temp\Setup00000e64\PSS10R.CHM.'*

*Log level changed from: Standard to: Verbose*

*MSI(INFO): 'Action ended Time: InstallExecute. Return value 3.*

**Cause**

This error indicates incorrect registry permissions. In this example, you would find incorrect registry permissions on HKEY_CLASSES_ROOT\CLSID\GUID.

**Solution**

The user account that's being used to install Office has to have access to the registry key in question. You can also compare registry permissions on a device where the installation is successful.

### Error 1920

*Error 1920. Service 'Office Software Protection Platform' (osppsvc) failed to start. Verify that you have sufficient privileges to start system services.*

*Log level changed from: Standard to: Verbose.*

*MSI(INFO): 'Action ended Time: InstallExecute. Return value 3.*

**Cause**

This error indicates possible incorrect permissions on the OfficeSoftwareProtectionPlatform folder, or incorrect permissions on HKEY_CLASSES_ROOT\APPID.

**Solution**

Method 1:

Give the Network Service account full permission on the OfficeSoftwareProtectionPlatform folder.

Method 2:

1. Compare the permissions on HKEY_CLASSES_ROOT\APPID from a good computer, with the problem computer.
1. Try granting "Restricted" to the following permissions: **Query Value**, **Enumerate Subkeys**, **Notify**, and **Read Control**.

### Error: IHxRegisterSession::CreateTransaction() returned 8004036e

*IHxRegisterSession::CreateTransaction() returned 8004036e*
*BeginTransaction() ERROR: Attempt failed because another transaction was running.*

*Trying to Rollback current transaction ({GUID})*
***IHxRegisterSession::ContinueTransaction() returned 80004005.***

*BeginTransaction() ERROR: Could not restart current transaction.*

*BeginTransaction() ERROR: Could not Rollback current transaction. HelpFile registration will abort.*

*Registration session {GUID} was *not* created.*

*Action ended Time: InstallFinalize. Return value 3.*

**Solution**

Refer to [KB 927153 The 2007 Office suite or the 2010 Office suite Setup program will not restart after an initial installation is interrupted](https://support.microsoft.com/help/927153/the-2007-office-suite-or-the-2010-office-suite-setup-program-will-not).

### Error: Failed to register plugin. HResult: 0x80070005

*MSI (s) (08:6C) [Time]: Invoking remote custom action. DLL: C:\WINDOWS\Installer\MSI4D4.tmp, Entrypoint: CAInstallSppPlugin*

*CAInstallPlugin.x86:  OMSICA : Initializing CustomAction CAInstallPlugin.x86*

*CAInstallPlugin.x86:  Registering PlugIn 'C:\Program Files\Common Files\Microsoft Shared\OfficeSoftwareProtectionPlatform\OSPPOBJS.DLL' 'C:\Program Files\Common Files\Microsoft Shared\OfficeSoftwareProtectionPlatform\osppobjs-spp-plugin-manifest-signed.xrm-ms'*

***CAInstallPlugin.x86:  Error: Failed to register plugin. HResult: 0x80070005.***

*CAInstallPlugin.x86:*
*MSI (s) (08:58) [Time]: User policy value 'DisableRollback' is 0*
*MSI (s) (08:58) [Time]: Machine policy value 'DisableRollback' is 0*

*Action ended 12:32:42: InstallExecute. Return value 3.*

**Cause**

Policies on the problem computer (local or through a Group Policy object (GPO)) is misconfigured.

**Solution**

1. Type **Gpedit.MSC** in the search box to open **Local Group Policy Editor**.
1. Locate **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **User Rights Assignment**.
1. Make sure that everyone has rights on the **Bypass traverse checking** policy. By default, **Everyone** is listed in **Security Setting**.

For more information, see [Client, service, and program issues can occur if you change security settings and user rights assignments](https://support.microsoft.com/help/823659/client-service-and-program-issues-can-occur-if-you-change-security-set).

### Error 0x80070005: CAQuietExec Failed

*CAQuietExec:  "wevtutil.exe" im "C:\Program Files\Microsoft Office\Office14\BCSEvents.man"*
*CAQuietExec:  The publishers and channels are installed successfully. However, we can't enable one or more publishers and channels. Access is denied.*

*CAQuietExec:  Error 0x80070005: Command line returned an error.*
***CAQuietExec:  Error 0x80070005: CAQuietExec Failed***

*CustomAction RegisterEventManifest returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)*

*MSI (s) (88:04) [Time]: User policy value 'DisableRollback' is 0*
*MSI (s) (88:04) [Time]: Machine policy value 'DisableRollback' is 0*

*Action ended Time: InstallExecute. Return value 3.*

**Cause**

This issue may occur because permissions are set incorrectly on the "C:\Windows\System32\winevt\Logs" folder.

**Solution**

Grant **Everyone** full rights to that folder, and then retry the installation. If this is successful, you can remove the Everyone group afterward.

### Error 0x800706b5: CAQuietExec Failed

*CAQuietExec:  "wevtutil.exe" im "C:\Program Files\Microsoft Office\Office14\BCSEvents.man"*
*CAQuietExec:  The publishers and channels are installed successfully. However, we can't enable one or more publishers and channels. The interface is unknown.*

*CAQuietExec:  Error 0x800706b5: Command line returned an error.*
***CAQuietExec:  Error 0x800706b5: CAQuietExec Failed***

*CustomAction RegisterEventManifest returned actual error code 1603 (note this may not be 100% accurate if translation happened inside sandbox)*
*MSI (s) (6C:84) [Time]: User policy value 'DisableRollback' is 0*
*MSI (s) (6C:84) [Time]: Machine policy value 'DisableRollback' is 0*

*Action ended Time: InstallExecute. Return value 3.*

**Cause**

This issue may occur if the **Windows Event Log** service isn't running.

**Solution**

1. Click start or search, type **services.msc**, and then press Enter. 
1. Scroll down to the **Windows Event Log** service, and make sure that it's set to automatic. If it isn't running, right-click it, and then select **Start**.

You may receive an error that resembles the following:

*Error 4201: The instance name passed was not recognized as valid by a WMI data provider.*

In this case, do the following actions:

1. Check the permissions on the "c:\windows\system32\logfiles\wmi\RTbackup" folder.
1. If the system account doesn't have **Full control** permission, grant the system account **Full control** permission, and then restart the system.
1. Check and see whether the **Windows Event Log service** is started in **services.msc**. If it's now started correctly, try your Office installation again.
