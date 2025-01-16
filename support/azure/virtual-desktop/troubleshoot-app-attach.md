---
title: Troubleshoot app attach in Azure Virtual Desktop
description: Learn how to troubleshoot app attach in Azure Virtual Desktop, where you can dynamically attach applications from an application package to a user session.
author: dknappettmsft
ms.topic: troubleshooting
ms.date: 03/05/2024
ms.author: daknappe
ms.custom: pcy:wincomm-user-experience
---
# Troubleshoot app attach in Azure Virtual Desktop

This article helps troubleshoot issues when using app attach in Azure Virtual Desktop.

## Check file share access

To validate that your session hosts have the necessary access to a file share containing your MSIX images, you can use PsExec.

1. Download and install [PsExec](/sysinternals/downloads/psexec) from Microsoft Sysinternals on a session host in your host pool.
2. Open PowerShell as an administrator and run the following cmdlet, which will start a new PowerShell session as the system account:

    ```powershell
    PsExec.exe -s -i powershell.exe
    ```

3. Verify that the context of the PowerShell session is the system account by running the following cmdlet:

    ```powershell
    whoami
    ```

   The output should be the following:

   ```output
   nt authority\system
   ```

4. Mount an MSIX image from the file share manually by using one of the following examples, changing the UNC paths to your own values.

   - To mount an MSIX image in `.vhdx` format, run the following cmdlet:

      ```powershell
      Mount-DiskImage -ImagePath \\fileshare\msix\MyApp.vhdx
      ```

   - To mount an MSIX image in `.cim` format, run the following cmdlets. The [CimDiskImage PowerShell module from the PowerShell Gallery](https://www.powershellgallery.com/packages/CimDiskImage) will be installed, if it's not already.

      ```powershell
      # Install the CimDiskImage PowerShell module, if it's not already installed.
      If (!(Get-Module -ListAvailable | ? Name -eq CimDiskImage)) {
          Install-Module CimDiskImage
      }
      
      # Import the CimDiskImage PowerShell module.
      Import-Module CimDiskImage

      # Mount the MSIX image
      Mount-CimDiskImage -ImagePath \\fileshare\msix\MyApp.cim -DriveLetter Z:
      ```

   If the MSIX image mounts successfully, your session hosts have the correct access to the file share containing your MSIX images.

5. Dismount the MSIX image by using one of the following examples.

   - To dismount an MSIX image in `.vhdx` format, run the following cmdlet:

      ```powershell
      Dismount-DiskImage -ImagePath \\fileshare\msix\MyApp.vhdx
      ```

   - To dismount an MSIX image in `.cim` format, run the following cmdlets:

      ```powershell
      Get-CimDiskImage | Dismount-CimDiskImage
      ```

## Next steps

[Test MSIX packages with app attach or MSIX app attach](/azure/virtual-desktop/app-attach-test-msix-packages).
