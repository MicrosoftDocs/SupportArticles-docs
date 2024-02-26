---
title: Can't install updates or programs
description: Discusses that you cannot install some updates or programs in Windows, and you receive an error message. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# You cannot install some updates or programs in Windows XP

This article offers you some advanced manual methods that can be used to fix some problems that prevent you from installing some updates or programs.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 822798

## Symptoms

When you try to download an ActiveX control, install an update to Windows or to a Windows component, install a service pack for Windows or for a Windows component, or install a Microsoft or third-party software program, you may experience one or more of the following symptoms:​​​​​​​

> [!NOTE]
> These problems may occur [for these reasons](#cause).

- You receive the following error message when you try to install a program or update:

    > Digital Signature Not Found  
    The Microsoft digital signature affirms that software has been tested with Windows and that the software has not been altered since it was tested.  
    The software you are about to install does not contain a Microsoft digital signature. Therefore, there is no guarantee that this software works correctly with Windows.  
    **Name of software package**  
    If you want to search for Microsoft digitally signed software, visit the Windows Update Web site at `http://update.microsoft.com` to see if one is available.  
    Do you want to continue the installation?

    If you click **More Info**, you receive the following message:

    > Microsoft Windows  
    The signature on the software package you want to install is invalid. The software package is not signed properly.

    After you click **OK** in the first error message dialog box, you receive a message that states that the installation was successful, or you receive the following error message:

    > **Name of Update Package**  
    The cryptographic operation failed due to a local security option setting.

- When you try to install an update or to install a service pack, you receive an error message that is similar to one of the following:

  - Error 1

    > **Name of Update Package**  
    Setup could not verify the integrity of the file Update.inf. Make sure the Cryptographic service is running on this computer.

  - Error 2

    > Failed to install catalog files.

  - Error 3

    > The software you are installing has not passed Windows Logo testing to verify its compatibility with Windows XP. (Tell me why this testing is important.)  
    This software will not be installed. Contact your system administrator.

  - Error 4

    > The software you are installing has not passed Windows Logo testing to verify its compatibility with this version of Windows. (Tell me why this testing is important.)

- When you try to install a Windows XP service pack, you receive an error message that is similar to the following:

    > Service Pack 1 Setup could not verify the integrity of the file. Make sure the Cryptographic service is running on this computer.

- When you attempt to install Microsoft Data Access Components (MDAC) 2.8, you receive an error message that is similar to the following:

    > INF Install failure. Reason: The timestamp signature and/or certificate could not be verified or is malformed.

- The %WINDIR%\System32\CatRoot2\Edb.log may grow to 20 megabytes (MB) even though the file is typically less than 1 MB.
- When you try to install a package from the Windows Update Web site or from the Microsoft Update Web site, you receive a message that is similar to the following:

    > The software has not passed Windows logo testing and will not be installed.

- When you examine the %systemroot%\Windowsupdate.log file, you see an entry for one of the following errors:​​​​​​​
  - 0x80096001
  - 0x80096005
  - 0x80096010
  - 0x800B0001
  - 0x800B0003
  - 0x800B0004
  - 0x800B0109
  - 0x8007f0da
  - 0x8007f01e

- When you use Microsoft windows update on a Windows XP-based computer, the update process fails, and you receive a 0x8007f007 error message. This may occur regardless of what type of update you select.

- The Svcpack.log file may contain entries that are similar to the following

> 937.406: GetCatVersion: Failed to retrieve version information from C:\WINDOWS\system32 \CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\Tmp.0.scw.cat with error 0x57 937.437: GetCatVersion: Failed to retrieve version information from C:\WINDOWS\Tmp.0.scw.cat with error 0x80092004 940.344: InstallSingleCatalogFile: MyInstallCatalog failed for Tmp.0.scw.cat; error=0xfffffbfe.  940.344: DoInstallation:MyInstallCatalogFiles  failed:STR_CATALOG_INSTALL_FAILED  
955.125: UnRegisterSpuninstForRecovery, failed to delete SpRecoverCmdLine value, error 0x2  
955.125: DoInstallation: Failed to unregistering spuninst.exe for recovery.  
962.656: DeRegistering the Uninstall Program -> Windows Server 2003 Service Pack, 0  
962.656: Failed to install catalog files. 1448.406: Message displayed to the user: Failed to install catalog files.  
1448.406: User Input: OK  
1448.406: Update.exe extended error code = 0xf01e  
1448.406: Update.exe return code was masked to 0x643 for MSI custom action compliance.

## Cause

These problems may occur in any of the following situations:

- Log file or database corruption exists in the %Systemroot%\System32\Catroot2 folder.
- **Cryptographic Services** is set to **disabled**.
- Other Windows files are corrupted or missing.
- The timestamp signature or certificate could not be verified or is malformed.
- The hidden attribute is set for the %Windir% folder or one of its subfolders.
- The **Unsigned non-driver installation behavior** Group Policy setting (Windows 2000 only) is set to **Do not allow installation** or **Warn but allow installation**, or the **Policy** binary value is not set to 0 in the following registry key:  `HKEY_LOCAL_MACHINE\Software\Microsoft\Non-Driver Signing`
- The **Enable trusted publisher lockdown** Group Policy setting is turned on, and you do not have the appropriate certificate in your Trusted Publishers certificate store. This Group Policy setting is located under **User Configuration**, under **Windows Settings**, under **Internet Explorer Maintenance**, under **Security**, under **Authenticode Settings** in the Group Policy MMC snap-in.
- You are installing Internet Explorer 6 SP1, and the 823559 (MS03-023) security update is installed.
- The software distribution folder is corrupted.

## Method 1: Rename the Edb.log file

Rename the Edb.log file, and then try to install the program again. To rename the Edb.log file, follow these steps:

1. Click **Start**, click **Run**, type cmd in the **Open** box, and then click **OK**.

    > [!NOTE]
    > On a Windows Vista-based computer, click **Start**, type *cmd* in the **Start Search** text box, right-click **cmd.exe**, and then click **Run as administrator**.
2. At the command prompt, type the following command, and then press Enter:

    ```console
    ren %systemroot%\system32\catroot2\Edb.log *.tst
    ```

## Method 2: Temporarily turn off Trusted Publishers Lockdown and install the appropriate certificates to your trusted publishers certificate store

You can continue to use the **Enable trusted publisher lockdown** Group Policy setting, but you must first add the appropriate certificates to your Trusted Publishers certificate store. To do this, turn off the **Enable trusted publisher lockdown** Group Policy setting, install the appropriate certificates in your Trusted Publishers certificate store, and then turn the **Enable trusted publisher lockdown** Group Policy setting back on. To install the appropriate certificate for Microsoft Windows and Microsoft Internet Explorer product updates, follow these steps:

1. Download the Microsoft product update that you want to install from the Microsoft Download Center, from the Windows Update Catalog, or from the Microsoft Update.

    For more information about how to download product updates from the Microsoft Download Center, view [how to obtain Microsoft support files from the Online Services Catalog](https://support.microsoft.com/help/119591).

    For more information about how to download product updates from the Windows Update Catalog, view [how to download updates that include drivers and hotfixes from the Windows Update Catalog](https://support.microsoft.com/help/323166).

2. Extract the product update package to a temporary folder. The command-line command that you use to do this depends on the update that you are trying to install. View the Microsoft Knowledge Base article that is associated with the update to determine the appropriate command-line switches that you will use to extract the package. For example, to extract the 824146 security update for Windows XP to the C:\824146 folder, run `Windowsxp-kb824146-x86-enu -x:c:\824146`. To extract the 828750 security update for Windows XP to the C:\828750 folder, run `q828750.exe /c /t:c:\828750`.

3. Right-click the KB **Number**.cat file from the product update package in the temporary folder you created in step 2, and then click **Properties**.

    > [!NOTE]
    > The KB **Number**.cat file may be in a subfolder. For example, the file may be in the C:\824146\sp1\update folder or in the C:\824146\sp2\update folder.

4. On the **Digital Signatures** tab, click the digital signature and then click **Details**.
5. Click **View Certificate**, and then click **Install Certificate**.
6. Click **Next** to start the **Certificate Import** Wizard.
7. Click **Place all certificates in the following store**, and then click **Browse**.
8. Click **Trusted Publishers**, and then click **OK**.
9. Click **Next**, click **Finish**, and then click **OK**.

## Method 3: Verify status of all certificates in certification path and import missing or damaged certificates from another computer

To verify certificates in the certificate path for a Windows or Internet Explorer product update, follow these steps: 

### Step 1: Verify Microsoft certificates

1. In Internet Explorer, click **Tools**, and then click **Internet Options**.
2. On the **Content** tab, click **Certificates**.
3. On the **Trusted Root Certification Authorities** tab, double-click **Microsoft Root Authority**. If this certificate is missing, go on to step 2.
4. On the **General** tab, make sure that the **Valid from** dates are **1/10/1997 to 12/31/2020**.
5. On the **Certification Path** tab, verify that **This certificate is OK** appears under **Certificate Status**.
6. Click **OK**, and then double-click the **NO LIABILITY ACCEPTED** certificate.
7. On the **General** tab, make sure that the **Valid from** dates are **5/11/1997 to 1/7/2004**.
8. On the **Certification Path** tab, verify that either **This certificate has expired or is not yet valid** or **This certificate is OK** appears under **Certificate Status**.

    > [!NOTE]
    > Although this certificate is expired, the certificate will continue to work. The operating system may not work correctly if the certificate is missing or revoked. For more information, view [Required trusted root certificates](../identity/trusted-root-certificates-are-required.md).

9. Click **OK**, and then double-click the **GTE CyberTrust Root** certificate. You may have more than one of these certificates with the same name. Check the certificate that has an expiration date of 2/23/2006.
10. On the **General** tab, make sure that the **Valid from** dates are 2/23/1996 to 2/23/2006.
11. On the **Certification Path** tab, verify that **This certificate is OK** appears under **Certificate Status**.

    > [!NOTE]
    > Although this certificate is expired, the certificate will continue to work. The operating system may not work correctly if the certificate is missing or revoked.

12. Click **OK**, and then double-click **Thawte Timestamping CA**.
13. On the **General** tab, make sure that the **Valid from** dates are 12/31/1996 to 12/31/2020.
14. On the **Certification Path** tab, verify that **This certificate is OK** appears under **Certificate Status**.

### Step 2: Import missing or damaged certificates

If one or more of these certificates are missing or corrupted, export the missing or corrupted certificates to another computer, and then install the certificates on your computer. To export certificates on another computer, follow these steps:

1. In Internet Explorer, click **Tools**, and then click **Internet Options**.
2. On the **Content** tab, click **Certificates**.
3. On the **Trusted Root Certification Authorities** tab, click the certificate that you want to export.
4. Click **Export**, and then follow the instructions to export the certificate as a **DER encoded Binary x.509(.CER)** file.
5. After the certificate file has been exported, copy it to the computer where you want to import it.
6. On the computer where you want to import the certificate, double-click the certificate.
7. Click **Install certificate**, and then click **Next**.
8. Click **Finish**, and then click **OK**.

## Method 4: Clear temporary file and restart hotfix installation or service pack installation

To clear the temporary file and restart the hotfix installation or the service pack installation, follow these steps:

1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. At the command prompt, type the following commands. Press Enter after each command.

    ```console
    net stop cryptsvc
    ren %systemroot%\System32\Catroot2 oldcatroot2
    net start cryptsvc
    exit
    ```

3. Remove all the tmp*.cat files in the following folders:

    - %systemroot% \system32\CatRoot\{127D0A1D-4EF2-11D1-8608-00C04FC295EE}
    - %systemroot% \system32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}

    If no files that start with *tmp* exist in this folder, do not remove any other files. The .cat files in this folder are necessary for installing hotfixes and service packs.

    > [!IMPORTANT]
    > Do not rename the Catroot folder. The Catroot2 folder is automatically recreated by Windows, but the Catroot folder is not recreated if the Catroot folder is renamed.

4. Delete all the oem*.* files from the %systemroot% \inf folder.
5. Restart the failed hotfix installation or service pack installation.

## Method 5: Empty the software distribution folder

1. Click **Start**, click **Run**, type *services.msc*, and then click **OK**.

    > [!NOTE]
    > On a Windows Vista-based computer, click **Start**, type services.msc in the **Start Search** box, right-click **services.msc**, and then click **Run as administrator**.

2. In the Services (Local) pane, right-click **Automatic Updates**, and then click **Stop**.
3. Minimize the Services (local) window.
4. Select all the contents of the Windows distribution folder, and then delete them.

    > [!NOTE]
    > By default, the Windows distribution folder is located in the **drive** :\Windows\SoftwareDistribution folder. In this location, **drive** is a placeholder for the drive where Windows is installed.

5. Make sure that the Windows distribution folder is empty, and then maximize the Services (local) window.
6. In the **Services (Local)** pane, right-click **Automatic Updates**, and then click **Start**.
7. Restart the computer, and then run Windows Update again.

## Method 6: Perform an in-place upgrade

If all these methods do not resolve your problem, you may have to perform an in-place upgrade.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
