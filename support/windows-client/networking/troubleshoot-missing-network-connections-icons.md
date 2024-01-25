---
title: How to troubleshoot missing network connections icons in Windows Server 2003 and in Windows XP
description: Describes how to troubleshoot missing network connections icons in Windows Server 2003 and in Windows XP.
ms.date: 12/03/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, waltere
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.subservice: networking
---
# How to troubleshoot missing network connections icons in Windows Server 2003 and in Windows XP

This article describes how to troubleshoot missing network connections icons in Windows Server 2003 and in Windows XP.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 825826

## Introduction

This article describes general step-by-step methods and advanced troubleshooting methods that you can use to restore missing network and dial-up connections icons on a computer that runs Windows XP or Windows Server 2003. However, despite the missing icons, networking continues to function correctly. Because missing network icons can be a symptom of several issues, it is difficult to say what is causing your particular problem until you examine it a bit. We'll ask you some questions. Then, based on your answers, we'll determine which of these methods that you should try first.

This article provides self-help steps for a beginning to intermediate computer user.
The "[Advanced troubleshooting](#advanced-troubleshooting)" section is designed for the advanced computer user. You may find it easier to follow the steps if you print this article first.

## Symptoms

When you click **Start**, point to and click **Control Panel**, and then double-click **Network Connections**, or if you right-click **My Network Places** on the desktop and then click **Properties**, you do not see all network icons. Or, you may experience problems with the **Network Connections** window.

To know which method you should try first to resolve your problem, review the following four cases to determine which symptoms match your situation.

### Case 1: All or some of the network icons are missing

- The **LAN or High-Speed Internet** connection icon is missing.
- The **Dial-up Connection** icons are missing.
- The **New Connection Wizard** icon is missing.
- Only the **New Connection Wizard** icon appears. Or, one or more dial-up connections also appear.
- If you click the **Advanced** menu and then click **Advanced Settings**, only the **Remote Access connections** entry appears in the **Connections** list.

If this case describes your situation, you should first try [Method 1](#method-1-let-windows-automatically-detect-and-install-network-adapters) in the "General troubleshooting" section to let Windows automatically detect and install network adapters.

### Case 2: Only the "Dial-up Connection" icons are missing

If this case describes your situation, you should first try [Method 5](#method-5-if-only-the-dial-up-connection-icons-are-missing-temporarily-add-a-new-modem) in the "General troubleshooting methods" section to add a generic standard modem.

### Case 3: The Network Connections window stops responding (hangs) or closes immediately after you select a network connection and then click "Properties"

If this case describes your situation, try [Method 4](#method-4-reset-the-network-connections) in the "Advanced troubleshooting" section to reconstruct the Config entry of the Network subkey. If you do not feel comfortable performing advanced troubleshooting, you may want to ask someone for help or [contact support](#next-steps).

#### Case 4: The network icon disappears only after you manually connect to the network

If this describes your situation, try [Method 3](#method-3-use-the-group-policy-results-tool-to-see-which-group-policy-objects-are-applied) in the "Advanced troubleshooting" section to use the Group Policy Results tool or the Group Policy Management Console to diagnose and resolve the problem. If you do not feel comfortable performing advanced troubleshooting, you may want to ask someone for help or [contact support](#next-steps).

## General troubleshooting

### Method 1: Let Windows automatically detect and install network adapters

Windows can automatically detect and install the correct network adapters for you. It will also correct any corrupted registry entries on the network adapter.

To direct Windows to automatically detect and install network adapters for you, follow these steps:

1. Right-click **My Computer**, and then click **Properties**.
2. Click the **Hardware** tab, and then click **Device Manager**.
3. To see a list of installed network adapters, expand **Network adapter(s)**. Click to locate the network adapter, and then click **Uninstall**.
4. Restart the computer, and then let the system automatically detect and install the network adapter drivers.

Check to see whether your networking icons appear. If this method worked for you, you are finished with this article. However, you might want to read the "[Prevention tips](#prevention-tips)" section to learn how you can avoid this problem in the future.

If this method did not work for you, try Method 2.

### Method 2: Verify network settings and services

Network settings such as adapter settings, services settings, the logon setting, the desktop interaction setting, and networking services settings enable you to use your computer to connect to a network. If these settings are incorrect, network connectivity issues can occur.

To verify network settings and services, follow these steps:

1. Verify that the correct network adapter is selected. A network adapter is a device that enables you to connect a computer to a network. It is also known as a network interface card (NIC).
    1. Right-click **My Computer**, click **Properties**, click the **Hardware** tab, and then click **Device Manager**.
    2. Double-click **Network adapters**, and then verify that the correct network adapter name is selected. If you do not know the name of your network adapter, don't worry. For now, just make sure that an adapter is selected.
    3. Double-click the network adapter, and then verify that the "This device is working properly" message appears in the **Device status** box on the **General** tab. If you do not see this message, click **Troubleshoot**, and follow the directions.
    4. After you confirm that the correct network adapter is selected and is working properly, you can close all the open dialog boxes.
2. Verify that the necessary services are started. The Services settings direct the system to stop, start, and administer system services.
    1. Right-click **My Computer**, and then click **Manage**.
    2. Double-click **Services and Applications**, and then click **Services**.
    3. In the right pane, look at the **Status** column. You may need to expand the box so that you can see all the columns. Make sure that the following services are started:
       - Remote procedure call (RPC)  
         > [!Note]
         > This service must be started before other services can take effect.
       - Network Connections
         > [!Note]
         > This service can only start if the RPC service is active.
       - Plug and Play
       - COM+ Event System
         > [!Note]
         > This service can only start if the RPC service is active.
       - Remote Access Connection Manager
         > [!Note]
         > This service can only start if Telephony service is active.
       - Telephony
         > [!Note]
         > This service can only start if the RPC service and the PnP Service are active.
    4. To start a service, right-click the service name, and then click **Start**.
    5. Do not close the **Computer Management** box because you will need to check additional settings in the remaining steps.
3. Verify the logon setting.
   1. In the right pane, double-click **COM+ Event System service**.
   2. Click the **Log On** tab.
   3. Under **Log on as**, verify that the **Local System account** is selected.
4. Verify the desktop interaction setting.
   1. Double-click the **Network Connections** service.
   2. Click the **Log On** tab.
   3. Under **Log on as**, verify that the **Local System Account** option is selected.
   4. Verify that the **Allow service to interact with desktop** check box is selected, and then click **OK**.
   5. Close the **Computer Management** box.
5. Verify the network services setting.
   1. Click **Start**, and then click **Control Panel**.
   2. Double-click **Add or Remove Programs**.
   3. Click **Add/Remove Windows Components**.
   4. Scroll down and then click **Networking Services**, and then click **Details**. Verify that **Simple TCP/IP Services** is turned on, and then click **OK**.
   5. Close all the open dialog boxes.
6. Verify that the network DLL files are registered correctly. DLL files are small files that include a library of functions and data that can be shared across multiple applications.
   1. Click **Start**, and then click **Run**.
   2. In the **Run** box, type *cmd.exe*, and then click **OK**.
   3. Type the following lines. Press ENTER after you type each line. This command text is difficult to type. Be sure that you type it exactly as it appears below. Or you may find it easier to copy and paste the text instead. Click **OK** when the **RegSvr32** dialog box appears for each command.

        ```console
        regsvr32 netshell.dll
        regsvr32 netcfgx.dll
        regsvr32 netman.dll
        ```

   4. Restart the computer. Check to see whether your networking icons appear. If this method worked for you, you are finished with this article. However, you might want to read the "[Prevention tips](#prevention-tips)" section to avoid this problem in the future.

If this method did not work for you, try Method 3.

### Method 3: Determine if a third-party driver is incompatible with the latest Windows Service Pack

A driver is software that allows your computer to communicate with hardware or devices. If you have an out-of-date driver installed, it may not be compatible with the latest Windows Service Pack. You can correct this incompatibility by checking to see if a driver update is available.

To check to see if a new network adapter driver is available, follow these steps:

1. Click **Start**, point to **All Programs**, and then click **Windows Update**.
2. Click **Custom Install**, and then click **Select optional hardware update**.
3. Look for the network adapter name, and then install any available hardware updates. If you do not find the driver listed, you may want to check the manufacturer's Web site for more information.
4. Restart the computer if you were prompted to install hardware updates. Check to see whether your networking icons appear. If this method worked for you, you are finished with this article. However, you might want to read the "[Prevention tips](#prevention-tips)" section to avoid this problem in the future.

If this method did not work for you, you can try Method 4.

### Method 4: Use the Dcomcnfg.exe utility to reset the "Default Impersonation Level" setting

This setting tells the computer how you want it to authenticate who can connect to a network. This method sounds more intimidating than what it really is. The DCOM Config utility has a point-and-click interface, and you just need to follow the steps, and it will do the "dirty" work for you.

Before you get started, you will need to make sure that you are logged on to the computer by using an administrator account. With an administrator account, you can make changes to your computer that you cannot make with any other account, such as a standard account. If you are using your own computer, chances are that you are logged on with an administrator account.

If you are unsure whether you have administrative user rights, follow these steps. Otherwise, go to [step 1](#step1).

1. Open the **Date and Time Properties** dialog box.
   1. Click **Start**, and then click **Run**.
   2. In the **Open** box, type *timedate.cpl*, and then press ENTER.
2. Now determine whether you are logged on with an administrator account.
   - If the **Date and Time Properties** dialog box opened after you performed step 1, you are logged on as a computer administrator. Close the **Date and Time Properties** dialog box, and then continue with this method.
   - If you received the following message, you are not logged on as an administrator:
     > You do not have the proper privilege level to change the system time.

To continue with this task, you must first log off, and then log back on to Windows by using a computer administrator account. If you do not know how to log back on to Windows by using a computer administrator account, you might have to ask someone for help. If this computer is part of a network at work, you can ask the system administrator for help. However, if you have to perform this task on a home computer that is not part of a network, you must know the password for an administrator account on your computer.

Unfortunately, if you do not know the password for any administrator account on your computer, this content is unable to help you any further. You may want to contact support. See "[Next steps](#next-steps)" for information about how to contact support.

To run the Dcomcnfg.exe utility to rest the **Default Impersonation Level** setting, follow these steps:

1. Click **Start**, and then click **Run**. <a id="step1"></a>
2. Type *dcomcnfg*, and then click **OK**.
3. In **Component Services**, click **Computers**, right-click the computer whose machine-wide impersonation level that you want to modify (for example, My Computer), and then click **Properties**.
4. Click the **Default Properties** tab, and then click to select the **Enable Distributed COM on this computer** check box for this computer.
5. Click the down arrow in the **Default Impersonation Level** box, and then click any setting other than **Anonymous**, and then click **OK**.

The new machine-wide impersonation level is available the next time that you start a program. Programs that are currently running are not affected until you restart them.

Check to see whether your networking icons appear. If this method worked for you, you are finished with this article.

If this method did not work for you, you can try Method 5.

### Method 5: If only the **Dial-up Connection** icons are missing, temporarily add a new modem

Try adding a standard modem. Often, just the process of adding a new modem causes the connection icons to reappear. To add a standard modem, complete these steps:

1. Click **Start**, and then click **Control Panel**.
2. If it is not already selected, click **Switch to Classic View**. This option appears on the left side of **Control Panel**.
3. Double-click **Phone and Modem Options**.
4. Click **Modems**, and then click **Add**. The **Add Hardware Wizard** starts.
5. Click to select the **Don't detect my modem I will select it from a list** check box, and then click **Next**.
6. Select a standard modem from the list on the left, and then click **Next**. When the icons reappear, you can safely delete the modem that you added in this procedure.

## Advanced troubleshooting

If you are still experiencing the missing icons problem, you can try the advanced methods. If you are not comfortable with advanced troubleshooting, you might want to contact Support. For information about how to contact support, see the "[Next steps](#next-steps)" section.

We recommend the following advanced troubleshooting methods for advanced users:

- [Method 1: Verify that all Windows Protected Files in the System 32 folder are intact](#method-1-verify-that-all-windows-protected-files-in-the-system-32-folder-are-intact)
- [Method 2: Remove third-party network adapter management software](#method-2-remove-third-party-network-adapter-management-software)
- [Method 3: Use the Group Policy Results tool to see which Group Policy objects are applied](#method-3-use-the-group-policy-results-tool-to-see-which-group-policy-objects-are-applied)
- [Method 4: Reset the network connections](#method-4-reset-the-network-connections)
- [Method 5: Verify that the registry keys are intact and correct](#method-5-verify-that-the-registry-keys-are-intact-and-correct)
- [Method 6: Check for nonpresent, ghosted, or hidden network adapters](#method-6-check-for-nonpresent-ghosted-or-hidden-network-adapters)
- [Method 7: Remove all the AutoDiscovery/AutoPurge (ADAP) information from the registry and reset the state of each performance library](#method-7-remove-all-the-autodiscoveryautopurge-adap-information-from-the-registry-and-reset-the-state-of-each-performance-library)

### Method 1: Verify that all Windows Protected Files in the System 32 folder are intact

System File Checker enables an administrator to scan all protected files to verify their versions. If System File Checker discovers that a protected file has been overwritten, it retrieves the correct version of the file from the cache folder (%Systemroot%\System32\Dllcache) or from the Windows installation source files, and then it replaces the incorrect file. System File Checker also checks and repopulates the cache folder. You must be logged on as an administrator or as a member of the Administrators group to run System File Checker.

To run System File Checker, open a command prompt, type `sfc /purgecache`, and then press ENTER. The Window File Checker starts.

For more information about how to use the Windows File Protection feature, review the following Microsoft Knowledge Base article:  
[222193](https://support.microsoft.com/help/222193) Description of the Windows File Protection feature

### Method 2: Remove third-party network adapter management software

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Temporarily remove any teaming software. The following combination is known to be incompatible: Dual-Port Intel Pro 100+ Server Adapter with Intel Teaming Software running an SNMP component.

For an updated version of the Intel SNMP agent (Ilansnmp.dll) and for more information, contact the network adapter manufacturer or the third-party software vendor.

### Method 3: Use the Group Policy Results tool to see which Group Policy objects are applied

If the icon is being deleted only after you manually connect to the network, follow these steps:

1. Restart the computer while it is not connected to the network to see whether a Group Policy Object (GPO) is being downloaded.
2. Start the Group Policy Results tool to find out which GPOs are applied.
3. Click **Start**, click **Run**, type *gpedit.msc*, and press ENTER.
4. Locate and open **Group policy/User Configuration/Windows Settings/Internet Explorer Maintenance/Connection/Connection Settings/**.

### Method 4: Reset the network connections

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

If the Network Connections window starts to open, but then closes immediately or "hangs," complete these steps:

1. Click **Start**, click **Run**, type *regedit*, and then press ENTER.
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Network`  
3. Right-click this subkey, click **Export**, and then save the selected branch in a file.
4. Click the Network subkey again, and then delete the Config entry. Do not delete the Network subkey. The Config entry will be reconstructed when you restart the computer.
5. Restart the computer. You may have to manually turn off the computer.

### Method 5: Verify that the registry keys are intact and correct

To verify that the registry keys are intact and correct, complete these steps:

1. Click **Start**, click **Run**, type *regedit*, and then press ENTER.
2. Locate and then click the following registry subkey: `HKEY_CLASSES_ROOT\Interface\{0000010C-0000-0000-C000-00000000046}`

    Verify that the subkeys NumMethods and ProxyStubClsid32 exist and that their values are correct. If these registry subkeys do not exist, create them.

### Method 6: Check for nonpresent, ghosted, or hidden network adapters

To uninstall the ghosted network adapter from the registry, complete these steps:

1. Click **Start**, click **Run**, type *cmd.exe*, and then press ENTER.
2. Type `set devmgr_show_nonpresent_devices=1`, and then press ENTER.
3. Type `Start DEVMGMT.MSC`, and then press ENTER.
4. Click **View**, and then click **Show Hidden Devices**.
5. Expand the **Network adapters** tree.
6. Right-click the dimmed network adapter, and then click **Uninstall**.

### Method 7: Remove all the AutoDiscovery/AutoPurge (ADAP) information from the registry and reset the state of each performance library

To do this, open a command prompt, type `winmgmt / clearadap`, and then press ENTER.

## Next steps

If you were unable to complete the steps in this article to restore your network icons, you might have to ask someone for help or contact support.

To view Microsoft support options, visit the following Microsoft Web site: [Contact us](https://support.microsoft.com/contactus)

## Prevention tips

To prevent these problems in the future, try to keep your computer up-to-date. Always make sure that you have the most recent drivers installed on the computer. To do this, you can use Windows Update to install the latest drivers. For more information, visit the following Microsoft Web site: [https://update.microsoft.com](https://update.microsoft.com)
