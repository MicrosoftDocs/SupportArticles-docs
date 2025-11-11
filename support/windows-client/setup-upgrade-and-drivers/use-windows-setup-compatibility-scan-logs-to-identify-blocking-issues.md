---
title: Use the Windows Setup Compatibility Scan Logs to Identify Blocking Issues
description: Discusses how to locate and interpret the results of Windows Setup compatibility scans, and how to use that information to remediate compatibility issues.
ms.date: 11/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-appelgatet
ms.custom:
- sap:windows setup,upgrade and deployment\installing or upgrading windows
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---

# How to use the Windows Setup compatibility scan logs to identify blocking issues

During a feature update or in-place upgrade, Windows Setup runs a compatibility scan. If Setup detects incompatible applications or drivers, it records the findings in XML reports under the Panther logging directory. This guide explains:

- What result codes mean (for example, `0xC1900208 - incompatible app`).
- Where to find log files.
- How to interpret CompatData\*.xml and \*_APPRAISER_HumanReadable.xml.
- How to remediate compatibility issues, either manually or at scale, by using Setup's `/compat scanonly` mode and the SetupDiag tool.

## Symptoms

You run a Windows feature update or an in-place upgrade on a Windows computer. The Windows Setup process fails, and produces the `0xC1900208` error code. This code indicates a compatibility issue. Typically, this means that the computer has an application or driver that's not compatible with the new version or feature update. This might be true even if the incompatible application or driver has already been uninstalled.

> [!NOTE]  
> If Windows Setup produces the `0xC1900210` code, then there are no compatibility issues.

## Resolution

> [!NOTE]  
> If you want to test compatibility before you deploy a feature update or in-place upgrade at scale (by using Microsoft Intune or Microsoft Endpoint Manager), review [How to test compatibility at scale](#how-to-test-compatibility-at-scale). That section describes special considerations and techniques to supplement the following procedure.

1. Use the compatibility scan logs (CompatData\*.xml or \*_APPRAISER_HumanReadable.xml) to identify the blocking issue. For more information, see [How to use the compatibility scan logs to identify the blocking issue](#how-to-use-the-compatibility-scan-logs-to-identify-the-blocking-issue).
1. Fix the problematic application or driver. For example, uninstall it or upgrade it to a compatible version. If the human-readable log points to a specific file, and the related application or driver has already been installed, remove the indicated file.
1. If you intend to use the same media for the next setup attempt, clear the setup-related caches:

   - Empty the C:\Windows\SoftwareDistribution\Download folder.
   - If you don't need the files in the hidden C:\$WINDOWS.~BT folder, empty the folder.

1. To make sure that Setup has the latest compatibility information, use Dynamic Update. For more information, see [Update Windows installation media with Dynamic Update](/windows/deployment/update/media-dynamic-update).
1. To test compatibility without running the full setup, run the following command at a Windows command prompt:

   ```console
   ```setup.exe /auto upgrade /noreboot /eula accept /compat scanonly /compat ignorewarning 
   ```

   For more information, see [Windows Setup Command-Line Options: /Compat](/windows-hardware/manufacture/desktop/windows-setup-command-line-options?view=windows-11#compat).

1. Re-check the logs to make sure that the issue doesn't recur, and that Setup generated the `0xC1900210` code. If it generated the `0xC1900208` code, review the logs for further compatibility issues.
1. When the compatibility checks pass, retry the upgrade.

### How to use the compatibility scan logs to identify the blocking issue

Over the course of the setup process, Windows Setup stores logs in different locations. Look for the log files in the following locations:

> [!TIP]  
> These folders are hidden. To make sure that you can search the folders, in File Explorer, select **View** and make sure that **Hidden items** is selected.

- Logs that're stored during the Downlevel, OOBE, or Rollback stages of the Setup process: C:\\$WINDOWS.~BT\\Sources\\Panther\\CompatData\<date-time>.xml.

  > [!NOTE]  
  > In this file path, \<date-time> represents the data and time when the file was created. The latest timestamp is most relevant to the troubleshooting process.

   :::image type="content" source="./media/use-windows-setup-compatibility-scan-logs-to-identify-blocking-issues/list-of-compatdata-log-files.png" alt-text="Screenshot that shows a directory listing the compatibility log files.":::

- Logs that're stored after the OOBE stage of the Setup process: C:\Windows\Panther\.

- Human readable log that's stored by the compatibility appraiser: Search the operating system drive for \*_APPRAISER_HumanReadable.xml.

For more information about Setup log files, see [Windows upgrade log files](/windows/deployment/upgrade/log-files).

#### Using the CompatData\<date-time>.xml file

Open the most recent CompatData\<date-time>.xml.xml and search for the following strings:

- In the \<Programs> section, search for **BlockingType="Hard"**. This string identifies programs that you have to remove or mitigate to upgrade Windows. The following excerpt shows an application that has been identified in this way:

  ```output
      <DriverPackage Inf="oem471.inf: BlockMigration="False" HasSignedBinaries="True"/>
    </DriverPackages>
    <Programs>
      <Program Name="Some Wallpaper Apps may be incompatible" Id="{3eb4353f-e9c5-44b4-97c6-a07df49c5803}" DefaultIcon="True">
        <CompatibilityInfo BlockingType="Hard" StatusDetail="WarnUpgrade" Message="Your PC has an app that changes the Window Desktop or Wallpaper and it may be incompatible with this version of Windows. This app may...
        <Link Target="https://go.microsoft.com/fwlink/?LinkId=2311650" Value="Learn More"/>
        <Action Name="Dismiss" Link="wsc:wica:_{3eb4353f-e9c5-44b4-97c6-a07df49c5803}" DisplayStyle="Link" ResolveState="NotRun"/>
      </Program>
    </Programs>
  </CompatReport>
  ```

- Search the file for **//DriverPackages/DriverPackage\[@BlockMigration="True"]**. This string identifies a driver that won't migrate. You have to upgrade or remove this drive to upgrade Windows.

#### Using the \*_APPRAISER_HumanReadable.xml file

The human-readable log file uses a flattened, easier-to-scan XML than the CompatData logs. You can use this log to find exact file paths to files that block Setup, including .exe or .dll files that're left behind after you uninstalled an application. To find this information, follow these steps:

1. Open the most recent \*_APPRAISER_HumanReadable.xml file, and then search for the **DT_ANY_FMC_BlockingApplication=True** string.

1. When you find the previous string, search for a nearby occurrence of the **LowerCaseLongPathUnexpanded** property. This property records the exact file path to the blocking artifact.

   :::image type="content" source="./media/use-windows-setup-compatibility-scan-logs-to-identify-blocking-issues/human-readable-compatibility-properties.png" alt-text="Screenshot of the human-readable XML file, highlighting the property elements of applications that have compatibility issues.":::

### How to test compatibility at scale

Before you try to run an update or upgrade operation at scale, run `setup.exe` together with the `/compat scanonly` to generate logs that you can use to inventory blocking applications and drivers.

To help resolve compatibility issues, use the [SetupDiag](/windows/deployment/upgrade/setupdiag) tool. SetupDiag parses Windows Setup logs and maps the log data to known rules (for example, `CompatBlockedApplication`) that pinpoint the causes of setup issues. To start SetupDiag, open a Windows Command Prompt window and then run a command that resembles the following command:

```console
SetupDiag.exe /LogsPath "C:\Temp\WindowsSetupLogs" /Output "C:\Temp\SetupDiag-Results.txt"
```

You can aggregate SetupDiag outputs into into your reporting pipeline.

## More information

Microsoft Compatibility Appraiser creates registry entries in the `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags` subkey. This process runs as the \Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser scheduled task. 

Windows inbox and appraiser processes and Dynamic update processes write and refresh compatibility intelligence when they run scans. Windows Setup, Windows Update, and enterprise tools then use this information to to decide if a device is ready for a target release without running a full upgrade.

## References

- [Windows 10 upgrade resolution procedures](/windows-client/setup-upgrade-and-drivers/windows-10-upgrade-resolution-procedures?toc=%2Fwindows%2Fdeployment#0xc1900101)
- [Windows upgrade log files](/windows/deployment/upgrade/log-files)
