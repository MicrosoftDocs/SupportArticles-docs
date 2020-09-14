---
title: Fail to open a list in VAMT 2.0
description: Fixes an error (An item with the same key has already been added) that occurs when you open a list in Volume Activation Management Tool (VAMT) 2.0
ms.data: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Activation
ms.technology: Depolyment
---
# "An item with the same key has already been added" error when you open a list in VAMT 2.0 on a Windows 7-based computer

This article helps fix an error (An item with the same key has already been added) that occurs when you open a list in Volume Activation Management Tool (VAMT) 2.0.

_Original product version:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2383895

## Symptoms

When you open a list (.cil) in VAMT 2.0 on a Windows 7-based computer, you may receive the following error message:

An item with the same key has already been added.

## Cause

This problem may occur if there are multiple network adapters in the computer, and these networks adapters have the same MAC address. For example, this problem may occur if you have two network adapters for a virtual machine, and you configure these network adapters to have the same MAC address.

If you open the CIL file in this situation, you see an entry that resembles the following:

NetworkName="contoso.com" Id="e3f3f83c-f050-4d81-9117-xx">
<MacAddresses>
<MacAddress>00:11:11:CF:FC:xx</MacAddress>
<MacAddress>00:11:11:CF:FC:xx</MacAddress>
</MacAddresses>

## Resolution

To have us delete the duplicate entries from the CIL file for you, go to the "Fix it for me" section. If you prefer to delete the duplicate entries from the CIL file yourself, go to the "Let me fix it myself" section.

#### Fix it for me

To fix this problem automatically, click the **Fix it** button or link. Then click **Run** in the **File Download** dialog box, and follow the steps in the Fix it wizard.

Notes 
- Select a CIL file which you want to delete the duplicate entries for.
- The Fix it solution doesn't work if the VAMT(Volume Activation Management Tool) 2.0 isn't installed in the default path.
- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.
- If you aren't on the computer that has the problem, save the Fix it solution to a flash drive or a CD and then run it on the computer that has the problem.
Then, go to the "Did this fix the problem?" section.

#### Let me fix it myself

To work around this problem, manually delete the duplicate entries from the CIL or to automate this process, use the following source code to create a

PowerShell script to automate.
```
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
4. In Windows PowerShell click in the Untitled1.ps1 window
5. Paste in contents of the script from this article
6. Click File, save as, c:\script\ScrubCil.ps1
7. Click Start > All Programs > Accessories > Windows PowerShell, right-click "Windows PowerShell" and choose "Run as Administrator"
8. At the PowerShell prompt type, the following commands
cd \script
set-executionpolicy unrestricted
.\ScrubCil.ps1 saved.cil

#### Did this fix the problem?


- Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, you can [contact support](/contactus).
- We would appreciate your feedback. To provide feedback or to report any issues with this solution, leave a comment on the "[Fix it for me](https://blogs.technet.com/fixit4me/)" blog or send us an [email](mailto:fixit4me@microsoft.com?subject=kb).
