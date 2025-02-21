---
title: Scripts to extract .msu and .cab files
description: Provides a script to extract .msu and .cab files.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, jpsantho, abjos
ms.custom:
- sap:windows servicing,updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
---
# Scripts: Extract .msu and .cab files

This article provides a guide on how to use a PowerShell script to extract `.msu` and `.cab` files to a specified directory. The script is designed to handle various scenarios, ensure smooth extractions, and even create directories if needed.

## Script overview

The script needs two mandatory parameters:

- The file path of the `.msu` or `.cab` file
- The destination path where the extracted files will be stored

The script checks for the existence of the specified file and destination directory, and creates the destination directory if it doesn't exist. The script then proceeds to extract the contents of the `.msu` or `.cab` files and handles nested `.cab` files in the process.

## Step-by-step instructions for using the script

1. Prepare the script.

    Copy the provided PowerShell script into a `.ps1` file (for example, *Extract-MSUAndCAB.ps1*).

2. Run the script.

    Open PowerShell as an administrator. Go to the directory where your script is saved. In this example, execute the script by running `.\Extract-MSUAndCAB.ps1`.

3. Provide file paths.

    When prompted, provide the paths to the `.msu` or `.cab` files you want to extract. Specify the destination path where the extracted files should be saved.

Here's a usage example:

```powershell
powershell -ExecutionPolicy Bypass -File .\Extract-MSUAndCAB.ps1 -filePath "C:\<path>\<yourfile>.msu" -destinationPath "C:\<path>\<destination>"
```

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

```PowerShell
param (
    [Parameter(Mandatory = $true)]
    [string]$filePath,
    [Parameter(Mandatory = $true)]
    [string]$destinationPath
)

# Display the note to the user
Write-Host "==========================="
Write-Host
Write-Host -ForegroundColor Yellow "Note: Do not close any Windows opened by this script until it is completed."
Write-Host
Write-Host "==========================="
Write-Host


# Remove quotes if present
$filePath = $filePath -replace '"', ''
$destinationPath = $destinationPath -replace '"', ''

# Trim trailing backslash if present
$destinationPath = $destinationPath.TrimEnd('\')

if (-not (Test-Path $filePath -PathType Leaf)) {
    Write-Host "The specified file does not exist: $filePath"
    return
}

if (-not (Test-Path $destinationPath -PathType Container)) {
    Write-Host "Creating destination directory: $destinationPath"
    New-Item -Path $destinationPath -ItemType Directory | Out-Null
}

$processedFiles = @{}

function Extract-File ($file, $destination) {
    Write-Host "Extracting $file to $destination"
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c expand.exe `"$file`" -f:* `"$destination`" > nul 2>&1" -Wait -WindowStyle Hidden | Out-Null
    $processedFiles[$file] = $true
    Write-Host "Extraction completed for $file"
}

function Rename-File ($file) {
    if (Test-Path -Path $file) {
        $newName = [System.IO.Path]::GetFileNameWithoutExtension($file) + "_" + [System.Guid]::NewGuid().ToString("N") + [System.IO.Path]::GetExtension($file)
        $newPath = Join-Path -Path ([System.IO.Path]::GetDirectoryName($file)) -ChildPath $newName
        Write-Host "Renaming $file to $newPath"
        Rename-Item -Path $file -NewName $newPath
        Write-Host "Renamed $file to $newPath"
        return $newPath
    }
    Write-Host "File $file does not exist for renaming"
    return $null
}

function Process-CabFiles ($directory) {
    while ($true) {
        $cabFiles = Get-ChildItem -Path $directory -Filter "*.cab" -File | Where-Object { -not $processedFiles[$_.FullName] -and $_.Name -ne "wsusscan.cab" }

        if ($cabFiles.Count -eq 0) {
            Write-Host "No more CAB files found in $directory"
            break
        }

        foreach ($cabFile in $cabFiles) {
            Write-Host "Processing CAB file $($cabFile.FullName)"
            $cabFilePath = Rename-File -file $cabFile.FullName

            if ($cabFilePath -ne $null) {
                Extract-File -file $cabFilePath -destination $directory
                Process-CabFiles -directory $directory
            }
        }
    }
}

try {
    # Initial extraction
    if ($filePath.EndsWith(".msu")) {
        Write-Host "Extracting .msu file to: $destinationPath"
        Extract-File -file $filePath -destination $destinationPath
    } elseif ($filePath.EndsWith(".cab")) {
        Write-Host "Extracting .cab file to: $destinationPath"
        Extract-File -file $filePath -destination $destinationPath
    } else {
        Write-Host "The specified file is not a .msu or .cab file: $filePath"
        return
    }

    # Process all .cab files recursively
    Write-Host "Starting to process CAB files in $destinationPath"
    Process-CabFiles -directory $destinationPath
}
catch {
    Write-Host "An error occurred while extracting the file. Error: $_"
    return
}

Write-Host "Extraction completed. Files are located in $destinationPath"
return $destinationPath
```
