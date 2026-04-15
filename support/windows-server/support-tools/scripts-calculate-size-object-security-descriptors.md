---
title: Script to calculate the size of object security descriptors
description: This article introduces a script to 
ms.date: 04/16/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Script: Calculate the sizes of object security descriptors

 This script helps you calculate the size (in bytes) of the `ntSecurityDescriptor` attribute on Active Directory objects that reside under a given base distinguished name (DN). The script writes its results to a CSV file.

## Script

```powershell
#This sample script is not supported under any Microsoft standard support 
#program or service. This sample script is provided AS IS without warranty of 
#any kind. Microsoft further disclaims all implied warranties including,
#without limitation, any implied warranties of merchantability or of fitness
#for a particular purpose. The entire risk arising out of the use or 
#performance of the sample scripts and documentation remains with you. In no 
#event shall Microsoft, its authors, or anyone else involved in the creation,
#production, or delivery of the scripts be liable for any damages whatsoever 
#(including, without limitation, damages for loss of business profits, business
#interruption, loss of business information, or other pecuniary loss) arising 
#out of the use of or inability to use this sample script or documentation, 
#even if Microsoft has been advised of the possibility of such damages.

<#

.SYNOPSIS
    Calculates the size (in bytes) of the ntSecurityDescriptor on AD objects under a given base DN,
    and writes results to a CSV file.

.PARAMETER Base
    The LDAP base DN or container to search (e.g., "OU=Users,DC=contoso,DC=com")

.PARAMETER OutputPath
    Path to the CSV file where results will be written.

.PARAMETER MinimumSize
    Optional. Only include objects whose ntSecurityDescriptor size is greater than this threshold (in bytes).

.EXAMPLE
    .\Get-ACLByteSize.ps1 -Base "OU=Users,DC=contoso,DC=com" -OutputPath "C:\Temp\NTSD_Sizes.csv"

.EXAMPLE
    .\Get-ACLByteSize.ps1 -Base "DC=contoso,DC=com" -OutputPath "C:\Temp\NTSD_Sizes.csv" -MinimumSize 60000
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$Base,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath,

    [Parameter(Mandatory = $false)]
    [int]$MinimumSize = 0
)

Import-Module ActiveDirectory -ErrorAction Stop

$results = @()

Write-Host "Enumerating AD objects under $Base ..."

$Objects = Get-ADObject -Filter * -SearchBase $Base -Properties distinguishedName

foreach ($object in $Objects) {
    try {
        # Bind and request SD
        $searcher = [adsisearcher]"(distinguishedName=$($object.DistinguishedName))"
        $searcher.PropertiesToLoad.Add("ntSecurityDescriptor") | Out-Null
        $searcher.SecurityMasks = "Dacl,Owner,Group,sacl"
        $result = $searcher.FindOne()

        if ($null -ne $result -and $result.Properties["ntsecuritydescriptor"].Count -gt 0) {
            $sdBytes = $result.Properties["ntsecuritydescriptor"][0]

            if ($sdBytes -is [byte[]]) {
                $size = $sdBytes.Length
            }
            elseif ($sdBytes -is [System.DirectoryServices.ActiveDirectorySecurity]) {
                $size = ($sdBytes.GetSecurityDescriptorBinaryForm()).Length
            }
            else {
                Write-Warning "Unexpected SD type on $($object.DistinguishedName): $($sdBytes.GetType().FullName)"
                continue
            }

            if ($size -ge $MinimumSize) {
                $results += [pscustomobject]@{
                    DistinguishedName = $object.DistinguishedName
                    ObjectClass       = $object.ObjectClass
                    NTSD_Size_Bytes   = $size
                }
            }
        }
        else {
            Write-Verbose "No ntSecurityDescriptor found for $($object.DistinguishedName)"
        }
    }
    catch {
        Write-Warning "Error processing $($object.DistinguishedName): $_"
    }
}

if ($results.Count -gt 0) {
    $results | Sort-Object NTSD_Size_Bytes -Descending | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Host "`nExported $($results.Count) results to $OutputPath"
}
else {
    Write-Warning "No results matched your criteria (MinimumSize=$MinimumSize)."
}

```

## Reference

[Troubleshooting AD Replication error 8418: The replication operation failed because of a schema mismatch between the servers involved](../../active-directory/replication-error-8418.md)
