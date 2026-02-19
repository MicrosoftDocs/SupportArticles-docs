---
title: USB-connected Audio or Video Devices Malfunction when Connected to Specific Intel-Based Devices
description: Describes how to apply an update and a registry fix to resolve USB audio and video issues on Intel 500/600/700 PCH systems that use discrete TPM chips.
ms.service: windows-client
ms.topic: troubleshooting-general
ms.date: 02/12/2026
ai-usage: ai-assisted
ms.reviewer: kaushika, v-tappelgate, chadbee
ms.custom: 
- sap:windows device and driver management\issues with drivers or updates for peripheral devices
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---

# USB-connected audio or video devices malfunction when connected to specific Intel-based devices

This article provides workarounds and fixes for an issue that affects specific Intel-based devices. USB audio or video devices that are attached to the affected devices might not function correctly. These USB devices include cameras, speakers, microphones, and headsets.

## Symptoms

You experience one or more of the following symptoms:

- You hear occasional glitches or unexpected noise (such as clicking or popping) in the audio stream.
- You see momentary visible glitches in a video stream.
- A USB audio or video device stops working.

## Affected devices

This issue affects Intel-based systems that use a 500, 600, or 700 series Platform Controller Hub that has discrete Trusted Platform Module (dTPMs) chips. Computers that use firmware TPM (fTPM) technology aren't affected by this issue.

## Workaround

To work around the issue, follow these steps:

1. Unplug the device, and then reattach it to the computer.
2. If step 1 doesn't work, restart the computer.

## Cause

This problem occurs because of delays that occur on an internal hardware bus when Windows communicates with the discrete TPM. These delays, in turn, delay communication with the USB controller and generate Split Transaction errors on the USB bus. Therefore, time-sensitive USB traffic (such as audio and video streaming) might experience glitches or errors.

## Resolution

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

The October 2025 update for Windows 11, version 24H2, and the November 2025 update for Windows 11, version 23H2, introduce a fix for this hardware issue. To use this fix, follow these steps:

1. On the affected device, install the most recent update. Restart the device, if it's necessary.

1. Verify that the device uses a dTPM instead of an fTPM. To find this information, check the device BIOS settings or contact the device manufacturer.

1. Run the diagnostic script in the [More information](#more-information) section of this article.

   This script checks whether the fix applies to your device.

1. Create the following registry entry:

   - Subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Tpm`
   - Type: **REG_DWORD**
   - Name: **TPMDriverReadAfterWriteCount**
   - Value: **0x1 (1)**

   For example, open an administrative Command Prompt window, and then run the following command:

    ```console
    reg.exe ADD HKLM\SYSTEM\CurrentControlSet\Control\Tpm /v TPMDriverReadAfterWriteCount /t REG_DWORD /d 1
    ```

## More information

You can use the following Windows PowerShell script to determine whether your PC has one of the controllers that might be affected. To run this script, create a file that uses a name such as **Check-USBSplitTransactionVulnerability.ps1**. Then, paste the following text into the file, and run the script at a PowerShell command prompt.

> [!NOTE]  
> In Device Manager, the device in question appears under **System Devices**. It has a name that resembles "Intel(R) LPC Controller/eSPI Controller."

```powershell
# USB Split Transaction Vulnerability Detection Script
# This script checks if a device is vulnerable to USB split transaction issues
# by examining the Windows registry for specific Intel PCH device IDs

# Define the vulnerable PCH device IDs from the CPP code
$VulnerablePchDeviceIds = @(
    "VEN_8086&DEV_4380", "VEN_8086&DEV_4381", "VEN_8086&DEV_4382", "VEN_8086&DEV_4383",
    "VEN_8086&DEV_4384", "VEN_8086&DEV_4385", "VEN_8086&DEV_4386", "VEN_8086&DEV_4387",
    "VEN_8086&DEV_4388", "VEN_8086&DEV_4389", "VEN_8086&DEV_438A", "VEN_8086&DEV_438B",
    "VEN_8086&DEV_438C", "VEN_8086&DEV_438D", "VEN_8086&DEV_438E", "VEN_8086&DEV_438F",
    "VEN_8086&DEV_4390", "VEN_8086&DEV_4391", "VEN_8086&DEV_4392", "VEN_8086&DEV_4393",
    "VEN_8086&DEV_4394", "VEN_8086&DEV_4395", "VEN_8086&DEV_4396", "VEN_8086&DEV_4397",
    "VEN_8086&DEV_4398", "VEN_8086&DEV_4399", "VEN_8086&DEV_439A", "VEN_8086&DEV_439B",
    "VEN_8086&DEV_439C", "VEN_8086&DEV_439D", "VEN_8086&DEV_439E", "VEN_8086&DEV_439F",
    "VEN_8086&DEV_7A80", "VEN_8086&DEV_7A81", "VEN_8086&DEV_7A82", "VEN_8086&DEV_7A83",
    "VEN_8086&DEV_7A84", "VEN_8086&DEV_7A85", "VEN_8086&DEV_7A86", "VEN_8086&DEV_7A87",
    "VEN_8086&DEV_7A88", "VEN_8086&DEV_7A89", "VEN_8086&DEV_7A8A", "VEN_8086&DEV_7A8B",
    "VEN_8086&DEV_7A8C", "VEN_8086&DEV_7A8D", "VEN_8086&DEV_7A8E", "VEN_8086&DEV_7A8F",
    "VEN_8086&DEV_7A90", "VEN_8086&DEV_7A91", "VEN_8086&DEV_7A92", "VEN_8086&DEV_7A93",
    "VEN_8086&DEV_7A94", "VEN_8086&DEV_7A95", "VEN_8086&DEV_7A96", "VEN_8086&DEV_7A97",
    "VEN_8086&DEV_7A98", "VEN_8086&DEV_7A99", "VEN_8086&DEV_7A9A", "VEN_8086&DEV_7A9B",
    "VEN_8086&DEV_7A9C", "VEN_8086&DEV_7A9D", "VEN_8086&DEV_7A9E", "VEN_8086&DEV_7A9F",
    "VEN_8086&DEV_7A00", "VEN_8086&DEV_7A01", "VEN_8086&DEV_7A03", "VEN_8086&DEV_7A03",
    "VEN_8086&DEV_7A04", "VEN_8086&DEV_7A05", "VEN_8086&DEV_7A06", "VEN_8086&DEV_7A07",
    "VEN_8086&DEV_7A08", "VEN_8086&DEV_7A09", "VEN_8086&DEV_7A0A", "VEN_8086&DEV_7A0B",
    "VEN_8086&DEV_7A0C", "VEN_8086&DEV_7A0D", "VEN_8086&DEV_7A0E", "VEN_8086&DEV_7A0F",
    "VEN_8086&DEV_7A10", "VEN_8086&DEV_7A11", "VEN_8086&DEV_7A12", "VEN_8086&DEV_7A13",
    "VEN_8086&DEV_7A14", "VEN_8086&DEV_7A15", "VEN_8086&DEV_7A16", "VEN_8086&DEV_7A17",
    "VEN_8086&DEV_7A18", "VEN_8086&DEV_7A19", "VEN_8086&DEV_7A1A", "VEN_8086&DEV_7A1B",
    "VEN_8086&DEV_7A1C", "VEN_8086&DEV_7A1D", "VEN_8086&DEV_7A1E", "VEN_8086&DEV_7A1F",
    "VEN_8086&DEV_A080", "VEN_8086&DEV_A081", "VEN_8086&DEV_A082", "VEN_8086&DEV_A083",
    "VEN_8086&DEV_A084", "VEN_8086&DEV_A085", "VEN_8086&DEV_A086", "VEN_8086&DEV_A087",
    "VEN_8086&DEV_A088", "VEN_8086&DEV_A089", "VEN_8086&DEV_A08A", "VEN_8086&DEV_A08B",
    "VEN_8086&DEV_A08C", "VEN_8086&DEV_A08D", "VEN_8086&DEV_A08E", "VEN_8086&DEV_A08F",
    "VEN_8086&DEV_A090", "VEN_8086&DEV_A091", "VEN_8086&DEV_A092", "VEN_8086&DEV_A093",
    "VEN_8086&DEV_A094", "VEN_8086&DEV_A095", "VEN_8086&DEV_A096", "VEN_8086&DEV_A097",
    "VEN_8086&DEV_A098", "VEN_8086&DEV_A099", "VEN_8086&DEV_A09A", "VEN_8086&DEV_A09B",
    "VEN_8086&DEV_A09C", "VEN_8086&DEV_A09D", "VEN_8086&DEV_A09E", "VEN_8086&DEV_A09F",
    "VEN_8086&DEV_5180", "VEN_8086&DEV_5181", "VEN_8086&DEV_5182", "VEN_8086&DEV_5183",
    "VEN_8086&DEV_5184", "VEN_8086&DEV_5185", "VEN_8086&DEV_5186", "VEN_8086&DEV_5187",
    "VEN_8086&DEV_5188", "VEN_8086&DEV_5189", "VEN_8086&DEV_518A", "VEN_8086&DEV_518B",
    "VEN_8086&DEV_518C", "VEN_8086&DEV_518D", "VEN_8086&DEV_518E", "VEN_8086&DEV_518F",
    "VEN_8086&DEV_5190", "VEN_8086&DEV_5191", "VEN_8086&DEV_5192", "VEN_8086&DEV_5193",
    "VEN_8086&DEV_5194", "VEN_8086&DEV_5195", "VEN_8086&DEV_5196", "VEN_8086&DEV_5197",
    "VEN_8086&DEV_5198", "VEN_8086&DEV_5199", "VEN_8086&DEV_519A", "VEN_8086&DEV_519B",
    "VEN_8086&DEV_519C", "VEN_8086&DEV_519D", "VEN_8086&DEV_519E", "VEN_8086&DEV_519F",
    "VEN_8086&DEV_5480", "VEN_8086&DEV_5481", "VEN_8086&DEV_5482", "VEN_8086&DEV_5483",
    "VEN_8086&DEV_5484", "VEN_8086&DEV_5485", "VEN_8086&DEV_5486", "VEN_8086&DEV_5487",
    "VEN_8086&DEV_5488", "VEN_8086&DEV_5489", "VEN_8086&DEV_548A", "VEN_8086&DEV_548B",
    "VEN_8086&DEV_548C", "VEN_8086&DEV_548D", "VEN_8086&DEV_548E", "VEN_8086&DEV_548F",
    "VEN_8086&DEV_5490", "VEN_8086&DEV_5491", "VEN_8086&DEV_5492", "VEN_8086&DEV_5493",
    "VEN_8086&DEV_5494", "VEN_8086&DEV_5495", "VEN_8086&DEV_5496", "VEN_8086&DEV_5497",
    "VEN_8086&DEV_5498", "VEN_8086&DEV_5499", "VEN_8086&DEV_549A", "VEN_8086&DEV_549B",
    "VEN_8086&DEV_549C", "VEN_8086&DEV_549D", "VEN_8086&DEV_549E", "VEN_8086&DEV_549F"
)

function Test-USBSplitTransactionVulnerability {
    <#
    .SYNOPSIS
    Checks if the current device is vulnerable to USB split transaction issues.
    
    .DESCRIPTION
    This function examines the Windows registry under HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\PCI
    to detect if any of the known vulnerable Intel PCH device IDs are present on the system.
    
    .OUTPUTS
    Boolean indicating whether the device needs the registry workaround.
    #>
    
    try {
        # Define the registry path for PCI devices
        $RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\PCI"
        
        # Check if the registry path exists
        if (-not (Test-Path $RegistryPath)) {
            Write-Warning "Registry path $RegistryPath not found. Unable to perform vulnerability check."
            return $false
        }
        
        # Get all first-level subkeys under the PCI registry path
        $PciDevices = Get-ChildItem -Path $RegistryPath -ErrorAction SilentlyContinue
        
        if (-not $PciDevices) {
            Write-Warning "No PCI devices found in registry."
            return $false
        }
        
        # Check each PCI device against the vulnerable device IDs
        foreach ($Device in $PciDevices) {
            $DeviceName = $Device.PSChildName
            
            # Check if the device name contains any of the vulnerable device IDs
            foreach ($VulnerableId in $VulnerablePchDeviceIds) {
                if ($DeviceName -like "*$VulnerableId*") {
                    Write-Verbose "Found vulnerable device: $DeviceName"
                    return $true
                }
            }
        }
        
        return $false
    }
    catch {
        Write-Error "An error occurred while checking for USB split transaction vulnerability: $_"
        return $false
    }
}

# Main execution
try {
    Write-Host "Checking for USB split transaction vulnerability..." -ForegroundColor Yellow
    
    # Run the vulnerability check
    $IsVulnerable = Test-USBSplitTransactionVulnerability
    
    # Output the result based on the evaluation
    if ($IsVulnerable) {
        Write-Host "This device is expected to need the registry workaround" -ForegroundColor Red
    } else {
        Write-Host "This device is not expected to need the registry workaround" -ForegroundColor Green
    }
}
catch {
    Write-Error "Script execution failed: $_"
    exit 1
}
```
