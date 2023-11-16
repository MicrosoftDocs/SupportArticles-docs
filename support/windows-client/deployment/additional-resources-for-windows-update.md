---
title: Additional resources for Windows Update
description: Describes details about to troubleshooting WSUS and resetting Windows Update components manually.
ms.date: 04/28/2023
ms.prod: windows-client
manager: dcscontentpm
ms.topic: troubleshooting
ms.author: aaroncz
author: aczechowski
ms.collection: highpri
ms.technology: windows-client-deployment
ms.custom: sap:servicing, csstroubleshoot
ms.reviewer: dougeby
audience: itpro
localization_priority: medium
---
# Windows Update - additional resources

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows 11, Windows 10

> [!NOTE]
> Windows Server 2016 supports policies available in Windows 10, version 1607. Windows Server 2019 supports policies available in Windows 10, version 1809.

The following resources provide additional information about using Windows Update.

## WSUS troubleshooting

- [Troubleshooting issues with WSUS client agents](../../mem/configmgr/troubleshoot-issues-with-wsus-client-agents.md)
- [How to troubleshoot WSUS](../../mem/configmgr/troubleshoot-wsus-connection-failures.md)
- [Error 80244007 when WSUS client scans for updates](../../mem/configmgr/error-80244007-when-wsus-client-scans-updates.md)
- [Updates may not be installed with Fast Startup in Windows 10](updates-not-install-with-fast-startup.md)

## How do I reset Windows Update components?

- Try using the [Windows Update Troubleshooter](https://support.microsoft.com/windows/windows-update-troubleshooter-for-windows-10-19bc41ca-ad72-ae67-af3c-89ce169755dd), which will analyze the situation and reset any components that need it.
- Try the steps in [Troubleshoot problems updating Windows 10](https://support.microsoft.com/windows/troubleshoot-problems-updating-windows-10-188c2b0f-10a7-d72f-65b8-32d177eb136c).
- Try the steps in [Fix Windows Update](https://support.microsoft.com/sbs/windows/fix-windows-update-errors-18b693b5-7818-5825-8a7e-2a4a37d6d787) errors.

If all else fails, try resetting the Windows Update Agent by running these commands from an elevated command prompt:

   ``` console
   net stop wuauserv
   rd /s /q %systemroot%\SoftwareDistribution
   net start wuauserv
   ```

## Reset Windows Update components manually

1. Open a Windows command prompt. To open a command prompt, select **Start** > **Run**. Copy and paste (or type) *cmd* and then press Enter.

2. Stop the BITS service, the Windows Update service and the Cryptographic service. Type the following commands at a command prompt. Press Enter after you type each command.

   ``` console
   net stop bits
   net stop wuauserv
   net stop cryptsvc   
   ```

3. Delete the *qmgr\*.dat* files. Type the following command at a command prompt, and then press Enter:

   ``` console
   Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat"
   ```

4. If it is your first attempt at resolving your Windows Update issues by using the steps in this article, go to step 5 without carrying out the steps in step 4. The steps in step 4 should only be performed at this point in the troubleshooting if you can't resolve your Windows Update issues after following all steps but step 4. The steps in step 4 are also performed by the "Aggressive" mode of the Fix it Solution above.

   1. Rename the following folders to `*.BAK`:

      - *%Systemroot%\\SoftwareDistribution\\DataStore*
      - *%Systemroot%\\SoftwareDistribution\\Download*
      - *%Systemroot%\\System32\\catroot2*

       To do this, type the following commands at a command prompt. Press Enter after you type each command.

       ``` console
       Ren %Systemroot%\SoftwareDistribution\DataStore DataStore.bak
       Ren %Systemroot%\SoftwareDistribution\Download Download.bak
       Ren %Systemroot%\System32\catroot2 catroot2.bak
       ```

       > [!IMPORTANT]
       > The reset step below using *sc.exe* will overwrite your existing security ACLs on the BITS and Windows Update service and set them to default.  Skip this step unless the other steps to reset Windows Update components have not resolved the issue.

   2. Reset the BITS service and the Windows Update service to the default security descriptor. To do this, type the following commands at a command prompt. Press Enter after you type each command.

       ``` console
       sc.exe sdset bits D:(A;CI;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)
       sc.exe sdset wuauserv D:(A;;CCLCSWRPLORC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)
       ```

5. Type the following command at a command prompt, and then press Enter:

   ``` console
   cd /d %windir%\system32
   ```

6. Reregister the BITS files and the Windows Update files. To do this, type the following commands at a command prompt. Press Enter after you type each command.

   ``` console
   regsvr32.exe atl.dll
   regsvr32.exe urlmon.dll
   regsvr32.exe mshtml.dll
   regsvr32.exe shdocvw.dll
   regsvr32.exe browseui.dll
   regsvr32.exe jscript.dll
   regsvr32.exe vbscript.dll
   regsvr32.exe scrrun.dll
   regsvr32.exe msxml.dll
   regsvr32.exe msxml3.dll
   regsvr32.exe msxml6.dll
   regsvr32.exe actxprxy.dll
   regsvr32.exe softpub.dll
   regsvr32.exe wintrust.dll
   regsvr32.exe dssenh.dll
   regsvr32.exe rsaenh.dll
   regsvr32.exe gpkcsp.dll
   regsvr32.exe sccbase.dll
   regsvr32.exe slbcsp.dll
   regsvr32.exe cryptdlg.dll
   regsvr32.exe oleaut32.dll
   regsvr32.exe ole32.dll
   regsvr32.exe shell32.dll
   regsvr32.exe initpki.dll
   regsvr32.exe wuapi.dll
   regsvr32.exe wuaueng.dll
   regsvr32.exe wuaueng1.dll
   regsvr32.exe wucltui.dll
   regsvr32.exe wups.dll
   regsvr32.exe wups2.dll
   regsvr32.exe wuweb.dll
   regsvr32.exe qmgr.dll
   regsvr32.exe qmgrprxy.dll
   regsvr32.exe wucltux.dll
   regsvr32.exe muweb.dll
   regsvr32.exe wuwebv.dll
   ```

7. Reset Winsock. Type the following command at a command prompt, and then press Enter:

   ``` console
   netsh winsock reset
   ```

8. If you're running Windows XP or Windows Server 2003, you have to set the proxy settings. Type the following command at a command prompt, and then press Enter:

   ``` console
   proxycfg.exe -d
   ```

9. Restart the BITS service, the Windows Update service and the Cryptographic service. Type the following commands at a command prompt. Press Enter after you type each command.

   ``` console
   net start bits
   net start wuauserv   
   net start cryptsvc 
   ```

10. If you're running Windows Vista or Windows Server 2008, clear the BITS queue. Type the following command at a command prompt, and then press Enter:

    ``` console
    bitsadmin.exe /reset /allusers
    ```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
