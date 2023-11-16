---
title: Error 0xC004E002 during activation
description: Provides a solution to an error 0xC004E002 when you try to activate Windows.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, danv
ms.custom: sap:activation, csstroubleshoot
ms.technology: windows-server-deployment
---
# Error 0xC004E002 during activation for Windows

This article provides a solution to an error 0xC004E002 when you try to activate Windows.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 978305

## Symptoms

When you try to activate Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows 8, Windows Server 2012, Windows 8.1, or Windows Server 2012 R2, you may receive one of the following error messages:

> Code: 0xC004C003  
Description: The activation server determined that the specified product key has been blocked.

> Code: 0xC004E002  
Description: The Software Licensing Service reported that the license store contains inconsistent data.

## Cause

This issue occurs because the incorrect permissions are set on the Tokens.dat file or this file is corrupted.

## Resolution

To resolve this issue, try the following methods in order.

### Method 1: Set the correct permissions to the Tokens.dat file

1. Select **Start**, and then type cmd in the **Search** box.
2. Right-click **cmd**, and then select **Run as Administrator**.
3. At the command prompt, type the following command depending on the operating system and then press **ENTER**:

    For Windows Vista or Windows Server 2008:

    ```console
    icacls %windir%\serviceprofiles\networkservice\appdata\roaming\microsoft\softwarelicensing /grant "BUILTIN\Administrators:(OI)(CI)(F)" "NT AUTHORITY\SYSTEM:(OI)(CI)(F)" "NT Service\slsvc:(OI)(CI)(R,W,D)"
    ```

    The correct permissions for tokens.dat should look like this output from icacls:

    ```console
    tokens.dat NT AUTHORITY\SYSTEM:(I)(F)
             BUILTIN\Administrators:(I)(F)
             NT SERVICE\SLSVC:(I)(R,W,D)
    ```

    For Windows 7 or Windows Server 2008 R2:

    ```console
     icacls %windir%\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform /grant "BUILTIN\Administrators:(OI)(CI)(F)" "NT AUTHORITY\SYSTEM:(OI)(CI)(F)" "NETWORK SERVICE:(OI)(CI)(F)"
    ```

    The correct permissions for token.dat should look like this output from icacls:

    ```console
    tokens.dat NT AUTHORITY\SYSTEM:(I)(F)
                BUILTIN\Administrators:(I)(F)
                NT AUTHORITY\NETWORK SERVICE:(I)(F)
    ```

    For Windows 8, Windows Server 2012, Windows 8.1, or Windows Server 2008 R2:

    ```console
    icacls "%windir%\ServiceProfiles\LocalService\AppData\Local\Microsoft\WSLicense" /grant "BUILTIN\Administrators:(OI)(CI)(F)" "NT AUTHORITY\SYSTEM:(OI)(CI)(F)" "NETWORK SERVICE:(OI)(CI)(F)"
    ```

    The correct permissions for tokens.dat should look like this output from icacls:

    ```console
    tokens.dat NT AUTHORITY\SYSTEM:(I)(F)
             BUILTIN\Administrators:(I)(F)
             NT SERVICE\WSService:(OI)(CI)(R,W,D)
    ```

4. Close the Command Prompt window.

> [!NOTE]
> You must type this command from an elevated command prompt.

### Method 2: Rename the Tokens.dat file

1. Select **Start**, and then type cmd in the **Search** box.
2. Right-click **cmd**, and then select **Run as Administrator**.
3. At the command prompt, type the following command and then press **ENTER**.

    For Windows Vista or for Windows Server 2008

    ```console
    net stop slsvc
    ```

    For Windows 7 or for Windows Server 2008 R2

    ```console
    net stop sppsvc
    ```

    For Windows 8, Windows Server 2012, Windows 8.1, or Windows Server 2008 R2

    ```console
    net stop sppsvc
    ```

    > [!NOTE]
    > If you receive a message that asks whether you want to continue with this operation, type Y and then press **ENTER**.

4. Type the following command and then press **ENTER**.

    For Windows Vista or for Windows Server 2008

    ```console
    cd %windir%\serviceprofiles\networkservice\appdata\roaming\microsoft\softwarelicensing
    ```

    For Windows 7 or for Windows Server 2008 R2

    ```console
    cd %windir%\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform
    ```

    For Windows 8, Windows Server 2012, Windows 8.1, or Windows Server 2008 R2:

    ```console
    cd %windir%\ServiceProfiles\LocalService\AppData\Local\Microsoft\WSLicense
    ```

5. Type the following command and then press **ENTER**:

    ```console
    ren tokens.dat tokens.bar
    ```

6. Type the following command and then press **ENTER**:

    For Windows Vista or Windows Server 2008

    ```console
    net start slsvc
    ```

    For Windows 7 or Windows Server 2008 R2

    ```console
    net start sppsvc
    ```

    For Windows 8, Windows Server 2012, Windows 8.1, or Windows Server 2008 R2:

    ```console
    net start sppsvc
    ```

7. Type the following command and then press **ENTER**:
  
    ```console
    cd %windir% \System32
    ```

8. Type the following command and then press **ENTER**:

    ```console
    cscript slmgr.vbs -rilc
    ```

9. Restart the computer two times for the changes to apply.

### Did this fix the problem

Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, for Windows 7 or Windows Server 2008, you can [contact support](https://support.microsoft.com/contactus/). Assisted support is no longer available for Windows Vista.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
