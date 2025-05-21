---
title: Windows Time Service settings aren't preserved
description: Describes an issue in which Windows Time service settings are disabled in the registry after you upgrade to Windows Server 2016 or Windows 10 Version 1607.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\windows time service configuration,accuracy,and synchronization
- pcy:WinComm Directory Services
---
# Windows Time Service settings aren't preserved during an in-place upgrade to Windows Server 2016 or Windows 10 Version 1607

This article describes an issue in which Windows Time service settings are disabled in the registry after you upgrade to Windows Server 2016 or Windows 10 Version 1607.

_Applies to:_ &nbsp; Windows Server (All supported versions), Windows client (All supported versions)  
_Original KB number:_ &nbsp; 3201265

## Symptoms

When you do an in-place upgrade on the following operating systems upgrade paths, the Windows Time service doesn't preserve its configuration. Instead, it shows the default values for a workgroup server or workstation.

| Upgrade from| Upgrade to |
|---|---|
|Windows Server 2012 or Windows Server 2012 R2|Windows Server 2016|
|Windows 7, Windows 8, or Windows 8.1|Windows 10 Version 1607|
  
### Affected roles

After the in-place upgrade is completed, the following roles may be affected.

#### Domain controllers

The domain controllers (DC) that hosts the PDC emulator role is the default authoritative time server for the domain. Typically, it's configured to sync with a highly accurate time source. All other DCs in the domain sync their time with the PDC.

After you do an in-place upgrade, the PDC loses its connection to the external time server that it's configured to sync with. It also no longer announces that it's a time server.

All other DCs in the domain no longer announce that they're time servers, and they no longer use the domain hierarchy to sync their time. Therefore, their time setting may no longer be in sync with the setting for their peers, and domain members can no longer sync their time.

You may notice the following warning in the DCDIAG output:

> Warning: \<DCNAME> is not advertising as a time server

You may also notice that the DC doesn't respond to NTP client requests. It includes failures that occur when you test the NTP server availability by using the `w32tm.exe /stripchart` tool. For example, the text output may resemble the following output:

> c:>w32tm /stripchart /computer: \<DCName> Tracking \<DCName> [10.1.1.100:123]. The current time is 10/28/2016 9:00:00 AM. 09:00:00 error: 0x800705B4:

#### Domain Members

Domain member servers and computers that are upgraded are no longer configured to use the domain hierarchy to synchronize their time. Instead, they'll sync their time with the `time.windows.com` website.

#### Authoritative Time Server

Windows computers that are manually configured as an Authoritative Time Server lose their configuration. Therefore, devices that are configured to use these computers to synchronize their time may not sync.

You may also notice that the Authoritative NTP server doesn't respond to NTP client requests. It includes failures that occur when you test the NTP server availability by using the `w32tm.exe /stripchart` tool. For example, the text output may resemble the following output:

> c:>w32tm /stripchart /computer:\<myAuthoritativeTimeServer> Tracking \<myAuthoritativeTimeServer> [10.1.1.100:123]. The current time is *\<DateTime>*. *\<DateTime>* error: 0x800705B4:

> [!NOTE]
> This issue shouldn't occur when you do an in-place upgrade of the following operating systems:
>
> - Windows 10 version 1507 through Windows 10 version 1511
> - Windows 10 version 1511 through Windows 10 version 1607
> - Windows Server 2016 Technical Preview 5 (TP5) through Windows Server 2016 (RTM)

## Cause

It's a known issue in the Windows upgrade paths that are listed in the "Symptoms" section. This issue occurs because the registry values for the Windows Time service aren't preserved during an upgrade. Therefore, all Windows Time service values are reverted to the default state of a Workgroup Member Server or a stand-alone computer.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, go to the following Microsoft Knowledge Base article:  
 [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

> [!NOTE]
> On DCs and domain-joined computers, the Netlogon service must be running before the W32time service can start. After you upgrade the system, make sure that Netlogon is running before you try any of these workarounds.

To work around this issue, use one of the following methods.

### Method 1

Before you upgrade to Windows 10 Version 1607 or Windows Server 2016, manually back up the contents under the **w32time** registry key. To do so, follow these steps:

1. Open the **Run** box by pressing the Windows logo key‌+R.
2. Type regedit, and then press Enter.
3. Locate and then select the following registry entry:  
   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\`  

4. Select **File** > **Export**.
5. In the **Export Registry File** dialog box, select the location where you want to save the backup copy, and then type a name for the backup file in the **File name** field.
6. Select **Save**.
7. Save the W32time configuration for validation by running the following commands at an elevated command prompt:

    ```console
    Net start w32time w32tm /query /configuration /verbose > PreUpgradeW32timeConfiguration.txt
    ```  

You can now upgrade the computer to Windows Server 2016 or Windows 10 Version 1607. After the upgrade is completed, follow these steps to restore the contents under the w32time registry key:

1. Open the **Run** box by pressing the Windows logo key‌+R.
2. Type regedit, and then press Enter.
3. Open the **Run** box by pressing the Windows logo key‌+R.
4. Type regedit, and then press Enter.
5. In Registry Editor, select **File** > **Import**.
6. In the **Import Registry File** dialog box, select the location where you saved the backup copy, select the backup file, and then select **Open**.
7. Exit Registry Editor.
8. Run the following command to remove a deprecated service trigger:

    ```console
    reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TriggerInfo\1 /f
    ```  

9. Restart W32time service to enable it to use the new configuration. To do so, run the following commands at an elevated command prompt:

    ```console
    net stop w32time

    net start w32time
    ```  

### Method 2

If you're experiencing issues that affect the Windows Time Service after you upgrade to Windows Server 2016 or Windows 10 Version 1607, follow these steps to reregister `w32tm.exe`.

> [!NOTE]
> This procedure restores the default settings that are appropriate for the computer role. It does not restore any customizations that were made by the administrator.

At an elevated command prompt, run the following sequence of commands:

```console
net stop w32time

w32tm.exe /unregister

w32tm.exe /register

net start w32time
```  

### Method 3

If you're experiencing issues that affect the Windows Time Service after you upgrade to Windows Server 2016 or Windows 10 Version 1607, follow these steps to restore your settings from the Windows.old folder.

> [!IMPORTANT]
> The following steps should be done only by advanced users.

1. Export the registry key from Windows.old folder.

    1. Open the Windows Run box by pressing the Windows logo key+R.
    2. Type regedit and then press Enter.
    3. Locate and then click `HKEY_LOCAL_MACHINE`.
    4. On the **File** menu, click **Load Hive**.
    5. Locate and then click the `C:\Windows.old\Windows\System32\Config\System` file, and then click **Open**.
    6. In the **Load Hive** dialog box, type Offline, and then click **OK**.
    7. Expand **Offline**.
    8. Locate and then click the following registry subkey:
         `ControlSet001\Services\W32Time\`  

    9. Click **File** > **Export**.
    10. In the **Export Registry File** dialog box, select the location on a local hard disk where you want to save the registry, and then type a name for the backup file in the **File name** field.
    11. Click **Save**.
    12. Locate and then click the following registry subkey:
         `HKEY_LOCAL_MACHINE\Offline`

    13. On the **File** menu, click **Unload Hive**, and then click **Yes** in the **Confirm Unload Hive** dialog box.
    14. Exit Registry editor.
2. Restart the computer in Recovery mode.

      1. Select **Start** > **Settings** > **Update & Security** > **Recovery**  
      2. From the right-side pane, click **Restart now** under **Advanced startup**.
      3. After the computer restarts, select **Troubleshoot**, and then select **Command Prompt**.
      4. Select a local admin user, and then insert the password.

    > [!NOTE]
    > This restarts the computer in Recovery mode and provides a Command Prompt window.
3. Import the saved registry key from step 1.

      1. At the command prompt, type regedit and then press Enter
      2. Locate and then select `HKEY_LOCAL_MACHINE`  
      3. On on the **File** menu, click **Load Hive**.
      4. Locate and then select the `C:\Windows\System32\Config\System` file, and then click **Open**.
      5. In the **Load Hive** dialog box, type Offline, and then click **OK**  
      6. Expand **Offline**.
      7. Locate and then click the following registry subkey:
         `ControlSet001\Services\W32Time\`  

      8. Click **File** > **Import**.
      9. In the **Import Registry File** dialog box, select the location where you saved the backup copy, select the backup file, and then click **Open**.
      10. Locate and then click the following registry subkey:
         `HKEY_LOCAL_MACHINE\Offline`

      11. On the **File** menu, click **Unload Hive**, and then click **Yes** in the **Confirm Unload Hive** dialog box.
      12. Exit Registry Editor, and then restart the computer in Normal mode.

### Verify the workaround results

To verify that the Windows Time service can now preserve its configuration, follow these steps:

1. Run DCDiag.exe on DCs to make sure that they're advertising as a time server.
2. Make sure that DCs or Authoritative NTP Servers respond to NTP client requests without errors. For example, the command output resembles the following one:

    > c:\<w32tm /stripchart /computer:\<myTimeServer>  
    Tracking \<myTimeServer> [10.1.1.100:123].  
    The current time is *\<DateTime>*.  
    *\<DateTime>* d:+00.0013494s o:-00.0891868s [ * ]  

3. For advanced users, query the W32time configuration, and make sure that the time providers are configured as expected. If you used Method 1 as the workaround, you can compare the post-upgrade configuration to the saved pre-configuration data. For example, the command output resembles the following one:

    > c:\ >w32tm /query /configuration /verbose > PostUpgradeW32timeConfiguration.txt

## References

For more information about related Netlogon issues, click the following article number to view the article in the Microsoft Knowledge Base:  
[3201247](https://support.microsoft.com/help/3201247) Netlogon service doesn't retain settings after upgrade to Windows Server 2016
