---
title: Fail to open a list in VAMT 2.0
description: Fixes an error (An item with the same key has already been added) that occurs when you open a list in Volume Activation Management Tool (VAMT) 2.0
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# "An item with the same key has already been added" error when you open a list in VAMT 2.0 on a Windows 7-based computer

This article helps fix an error (An item with the same key has already been added) that occurs when you open a list in Volume Activation Management Tool (VAMT) 2.0.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2383895

## Symptoms

When you open a list (`.cil`) in VAMT 2.0 on a Windows 7-based computer, you may receive the following error message:

An item with the same key has already been added.

## Cause

This problem may occur if there are multiple network adapters in the computer, and these networks adapters have the same MAC address. For example, this problem may occur if you have two network adapters for a virtual machine, and you configure these network adapters to have the same MAC address.

If you open the CIL file in this situation, you see an entry that resembles the following:

> NetworkName="`contoso.com`" Id="e3f3f83c-f050-4d81-9117-xx">  
\<MacAddresses>  
\<MacAddress>00:11:11:CF:FC:xx\</MacAddress>  
\<MacAddress>00:11:11:CF:FC:xx\</MacAddress>  
\</MacAddresses>

## Resolution

To resolve this problem, manually delete the duplicate entries from the CIL or to automate this process, use the following source code to create a PowerShell script to automate.  

```powershell

param($inputFilePath, $vamtDirPath)

$cilFilePath = Resolve-Path $inputFilePath;

if (!$cilFilePath)

{

Write-Error "Expected input file name of target CIL";

exit 1;

}

if ($vamtDirPath)

{

$vamtDirPath = Resolve-Path $vamtDirPath;

}

else

{

$prograPath = [environment]::GetEnvironmentVariable("ProgramFiles(x86)");

if (!$prograPath -or $prograPath -eq "")

{

$prograPath = [environment]::GetEnvironmentVariable("ProgramFiles");

}

$vamtDirPath = $prograPath + "\VAMT 2.0"

}

try

{

$assembly = [System.Reflection.Assembly]::LoadFile($vamtDirPath + "\Vamtrt.dll");

}

catch

{

Write-Error "Error while attempting to load VAMT assembly. Provide the correct path to your VAMT installation if VAMT is not installed to the default directory.";

exit 1;

}

$fileSerializer = new-object Microsoft.SoftwareLicensing.Vamt.FileSerializer($cilFilePath);

$softwareLicensingData = $fileSerializer.Deserialize();

for ($i = 0; $i -lt $softwareLicensingData.Machines.Length; $i++)

{

$machine = $softwareLicensingData.Machines[$i];

if ($machine.MacAddresses.Count -gt 0)

{

$distinctMacAddrs = new-object System.Collections.ObjectModel.Collection[string];

foreach ($mac in $machine.MacAddresses)

{

if (!$distinctMacAddrs.Contains($mac))

{

$distinctMacAddrs.Add($mac);

}

}

$machine.MacAddresses.Clear();

foreach ($distinctMac in $distinctMacAddrs)

{

$machine.MacAddresses.Add($distinctMac);

}

}

}

$fileSerializer.Serialize($softwareLicensingData);

```

Then, follow these steps on a Windows 7 computer:  

1. Copy your saved CIL file to c:\script. For example, c:\script\saved.cil
2. Copy the included source code from this KB article into the clipboard
3. Click Start, All Programs, Accessories, Windows PowerShell, "Windows PowerShell ise"
4. In Windows PowerShell, click in the Untitled1.ps1 window
5. Paste in contents of the script from this article
6. Click File, save as, c:\script\ScrubCil.ps1
7. Click Start > All Programs > Accessories > Windows PowerShell, right-click "Windows PowerShell" and choose "Run as Administrator"
8. At the PowerShell prompt type, the following commands  

    ```powershell
    cd\script
    set-executionpolicy unrestricted
    .\ScrubCil.ps1 saved.cil
    ```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
