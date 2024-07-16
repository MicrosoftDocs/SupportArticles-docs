---
title: Scripts to extract .msu and .cab files 
description: Provides a script to extract .msu and .cab files.
ms.date: 07/16/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Windows Servicing, Updates and Features on Demand\Windows Update fails - installation stops with error, csstroubleshoot
---
# Scripts: Extract .msu and .cab files

This article provides a guide on how to use a PowerShell script to extract `.msu` and `.cab` files to a specified directory. The script is designed to handle various scenarios and ensure smooth extractions, and even creates directories if needed.

## Script overview

The script needs two mandatory parameters:

- The file path of the `.msu` or `.cab` file
- The destination path where the extracted files will be stored

The script checks for the existence of the specified file and the destination directory, and creates the destination directory if it doesn't exist. The script then proceeds to extract the contents of the `.msu` or `.cab` files, and handles nested `.cab` files in the process.

## Step-by-step instructions to use the script

1. Prepare the script.

    Copy the provided PowerShell script into a `.ps1` file (for example, *Extract-MSUAndCAB.ps1*).

2. Run the script.

    Open PowerShell as an administrator. Go to the directory where your script is saved. Execute the script by running `.\Extract-MSUAndCAB.ps1` in this example.

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
 
# Remove quotes if present
$filePath = $filePath -replace '"', ''
$destinationPath = $destinationPath -replace '"', ''
 
if (-not (Test-Path $filePath -PathType Leaf)) {  
    Write-Host "The specified file does not exist: $filePath"  
    return  
}  
 
if (-not (Test-Path $destinationPath -PathType Container)) {  
    Write-Host "Creating destination directory: $destinationPath"  
    New-Item -Path $destinationPath -ItemType Directory | Out-Null  
}  
 
$tempDirPath =  $destinationPath  
if (-not (Test-Path $tempDirPath -PathType Container)) {  
    New-Item -Path $tempDirPath -ItemType Directory | Out-Null  
}  
 
$processedFiles = @{}  
 
function Extract-File ($file, $destination) {  
    Write-Host "Extracting $file to $destination"  
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c expand.exe `"$file`" -f:* `"$destination`" > nul 2>&1" -Wait -NoNewWindow | Out-Null  
    $processedFiles[$file] = $true  
}  
 
try {  
    # Initial extraction  
    if ($filePath.EndsWith(".msu")) {  
        Write-Host "Extracting .msu file to: $tempDirPath"  
        Extract-File -file $filePath -destination $tempDirPath  
    } elseif ($filePath.EndsWith(".cab")) {  
        Write-Host "Extracting .cab file to: $tempDirPath"  
        Extract-File -file $filePath -destination $tempDirPath  
    } else {  
        Write-Host "The specified file is not a .msu or .cab file: $filePath"  
        return  
    }  
 
    # Loop until no more specific cab files are found  
    while ($true) {  
        $cabFiles = Get-ChildItem -Path $tempDirPath -Filter "*.cab" -File | Where-Object { -not $processedFiles[$_.FullName] -and ($_.Name -like "SSU*.cab" -or $_.Name -like "Windows*.cab" -or $_.Name -like "Cab_*.cab") }  
 
        if ($cabFiles.Count -eq 0) {  
            break  
        }  
 
        foreach ($cabFile in $cabFiles) {  
            Extract-File -file $cabFile.FullName -destination $tempDirPath  
        }  
    }  
}  
catch {  
    Write-Host "An error occurred while extracting the file. Error: $_"  
    return  
}  
 
Write-Host "Extraction completed. Files are located in $destinationPath"  
return $destinationPath
```
