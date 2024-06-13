---
title: Rebuild the Tokens.dat file
description: Describes how to rebuild the Tokens.dat file when you troubleshoot Windows activation issues.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca
ms.custom: sap:Windows Activation\Windows activation issues, csstroubleshoot
---
# How to rebuild the Tokens.dat file when you troubleshoot Windows activation issues

When you troubleshoot Windows activation issues, you may have to rebuild the Tokens.dat file.

_Original KB number:_ &nbsp; 2736303

## Rebuild the Tokens.dat file

1. Open an elevated command prompt:

   1. Open Start menu or Start screen, search **cmd**.
   1. Right click **Command Prompt** in the search results, and select **Run as administrator**.
      
1. Type the following commands in the order in which they're presented. Press **Enter** after each command.

   1. For Windows Server 2008 R2 and later
      
      `net stop sppsvc`
      
   1. For Windows Server 2008
      
      `net stop slsvc`
      
   1. For Windows 10, Windows Server 2016 and later versions of Windows:  
   `cd %windir%\system32\spp\store\2.0`
   
      For Windows 8.1 and Windows Server 2012 R2:  
      `cd %windir%\system32\spp\store\2.0`
      
      For Windows 8 and Windows Server 2012:  
      `cd %windir%\system32\spp\store`
      
      For Windows 7, Windows Server 2008 and Windows Server 2008 R2:  
      `cd %windir%\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform`
      
      > [!NOTE]
      > For Windows 8.1 that were upgraded from Windows 8, the location may still be %windir%\system32\spp\store.
   1. `ren tokens.dat tokens.bar`
      
   1. `net start sppsvc`
      
   1. `cscript.exe %windir%\system32\slmgr.vbs /rilc`
      
1. Restart the computer twice

## More information

After you rebuild theTokens.dat file, you must reinstall your product key by using one of the following methods:

- At the same elevated prompt command, type the following command, and then press **Enter**:
  
    `cscript.exe %windir%\system32\slmgr.vbs /ipk \<product key>`

- Right-click **My Computer**, select **Properties**, and then select **Change product key**.

> [!NOTE]
- You should never use the `/upk` switch to uninstall a product key. To install a product key over an existing product key, use the `/ipk` switch.
> - For more information about Key Management Services (KMS) client setup keys, see [KMS client activation and product keys](/windows-server/get-started/kms-client-activation-keys).
## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
