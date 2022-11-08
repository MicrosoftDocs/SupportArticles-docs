---
title: Understand Azure AD Connect 1.4.xx.x and device disappearance
description: This document describes an issue that arises with version 1.4.xx.x of Azure AD Connect
services: active-directory
author: billmath
manager: daveba
ms.service: active-directory
ms.workload: identity
ms.topic: reference
ms.date: 06/30/2021
ms.subservice: hybrid
ms.author: billmath
---

# Understand Azure AD Connect 1.4.xx.x and device disappearance

With the implementation of version 1.4.xx.x of Azure Active Directory Connect (Azure AD Connect), customers may see some or all of their Windows devices disappear from Azure AD. This isn't a cause for concern, as these device identities aren't used by Azure Active Directory (Azure AD) during *Conditional Access* authorization. This change won't delete any Windows devices that were correctly registered with Azure AD for Hybrid Azure AD Join.

If you see the deletion of device objects in Azure AD exceeding the *Export Deletion Threshold*, allow the deletions to go through. [How To: allow deletes to flow when they exceed the deletion threshold](/azure/active-directory/hybrid/how-to-connect-sync-feature-prevent-accidental-deletes)

## Background

Windows devices registered as Hybrid Azure AD Joined are represented in Azure AD as device objects, and they can be used for Conditional Access. Windows 10 devices are synchronized to the cloud via Azure AD Connect, while down level Windows devices are registered directly using either Active Directory Federation Services (AD FS) or seamless single sign-on.

## Windows 10 devices

Only Windows 10 devices with a specific *userCertificate* attribute value that's configured by Hybrid Azure AD Join should be synchronized to the cloud by Azure AD Connect. In previous versions of Azure AD Connect, this requirement was not rigorously enforced, and unnecessary device objects were added to Azure AD. Such devices in Azure AD always stayed in the "pending" state, as these devices were not intended to be registered with Azure AD.

This version of Azure AD Connect will only synchronize Windows 10 devices that are correctly configured to be Hybrid Azure AD Joined. Windows 10 device objects without the Azure AD join specific userCertificate will be removed from Azure AD.

## Down-Level Windows devices

Azure AD Connect should never synchronize [down-level Windows devices](/azure/active-directory/devices/hybrid-azuread-join-plan#windows-down-level-devices). Any devices in Azure AD previously synchronized incorrectly will be deleted from Azure AD. If Azure AD Connect attempts to delete [down-level Windows devices](/azure/active-directory/devices/hybrid-azuread-join-plan#windows-down-level-devices), then the device isn't the one that was created by the [Microsoft Workplace Join for non-Windows 10 computers MSI](https://www.microsoft.com/download/details.aspx?id=53554), and it can't be consumed by any other Azure AD feature.

Some customers might need to revisit [How To: Plan your hybrid Azure Active Directory join implementation](/azure/active-directory/devices/hybrid-azuread-join-plan) to register their Windows devices correctly and ensure that those devices can participate in device-based Conditional Access.

## How can I verify which devices are deleted with this update?

To verify which devices are deleted, use the PowerShell script in [PowerShell certificate report script](#powershell-certificate-report-script).

This script generates a report about certificates stored in *Active Directory Computer* objects, and specifically certificates issued by the Hybrid Azure AD join feature.

The script also checks the certificates present in the UserCertificate property of a Computer object in AD. For each non-expired certificate present, the script validates whether or not the certificate was issued for the Hybrid Azure AD join feature; for example, `Subject Name matches CN={ObjectGUID}`.

Before this update, Azure AD Connect would synchronize to Azure AD any Computer that contained at least one valid certificate. Beginning with Azure AD Connect version 1.4, the synchronization engine identifies Hybrid Azure AD join certificates, and will use the *cloudfilter* filter to prevent the computer object from synchronizing to Azure AD unless there's a valid Hybrid Azure AD join certificate.

Azure AD devices that were previously synchronized to AD, but don't have a valid Hybrid Azure AD join certificate, will be deleted by the synchronization engine using the filter `CloudFiltered=TRUE`.

## PowerShell certificate report script

 ```powershell
<#

Filename:    Export-ADSyncToolsHybridAzureADjoinCertificateReport.ps1.

DISCLAIMER:
Copyright (c) Microsoft Corporation. All rights reserved. This script is made available to you without any express, implied or statutory warranty, not even the implied warranty of  merchantability or fitness for a particular purpose, or the warranty of title or non-infringement. The entire risk of the use or the results from the use of this script remains with you.
.Synopsis
This script generates a report about certificates stored in Active Directory Computer objects, specifically, 
certificates issued by the Hybrid Azure AD join feature.
.DESCRIPTION
It checks the certificates present in the UserCertificate property of a Computer object in AD and, for each 
non-expired certificate present, validates if the certificate was issued for the Hybrid Azure AD join feature 
(i.e. Subject Name matches CN={ObjectGUID}).
Before, Azure AD Connect would synchronize to Azure AD any Computer that contained at least one valid 
certificate but starting on Azure AD Connect version 1.4, the sync engine can identify Hybrid 
Azure AD join certificates and will 'cloudfilter' the computer object from synchronizing to Azure AD unless 
there's a valid Hybrid Azure AD join certificate.
Azure AD Device objects that were already synchronized to AD but do not have a valid Hybrid Azure AD join 
certificate will be deleted (CloudFiltered=TRUE) by the sync engine.
.EXAMPLE
.\Export-ADSyncToolsHybridAzureADjoinCertificateReport.ps1 -DN 'CN=Computer1,OU=SYNC,DC=Fabrikam,DC=com'
.EXAMPLE
.\Export-ADSyncToolsHybridAzureADjoinCertificateReport.ps1 -OU 'OU=SYNC,DC=Fabrikam,DC=com' -Filename "MyHybridAzureADjoinReport.csv" -Verbose

#>
    [CmdletBinding()]
    Param
    (
        # Computer DistinguishedName
        [Parameter(ParameterSetName='SingleObject',
                Mandatory=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
        [String]
        $DN,

        # AD OrganizationalUnit
        [Parameter(ParameterSetName='MultipleObjects',
                Mandatory=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
        [String]
        $OU,

        # Output CSV filename (optional)
        [Parameter(Mandatory=$false,
                ValueFromPipelineByPropertyName=$false,
                Position=1)]
        [String]
        $Filename

    )

    # Generate Output filename if not provided
    If ($Filename -eq "")
    {
        $Filename = [string] "$([string] $(Get-Date -Format yyyyMMddHHmmss))_ADSyncAADHybridJoinCertificateReport.csv"
    }
    Write-Verbose "Output filename: '$Filename'"
    
    # Read AD object(s)
    If ($PSCmdlet.ParameterSetName -eq 'SingleObject')
    {
        $directoryObjs = @(Get-ADObject $DN -Properties UserCertificate)
        Write-Verbose "Starting report for a single object '$DN'"
    }
    Else
    {
        $directoryObjs = Get-ADObject -Filter { ObjectClass -like 'computer' } -SearchBase $OU -Properties UserCertificate
        Write-Verbose "Starting report for $($directoryObjs.Count) computer objects in OU '$OU'"
    }

    Write-Host "Processing $($directoryObjs.Count) directory object(s). Please wait..."
    # Check Certificates on each AD Object
    $results = @()
    ForEach ($obj in $directoryObjs)
    {
        # Read UserCertificate multi-value property
        $objDN = [string] $obj.DistinguishedName
        $objectGuid = [string] ($obj.ObjectGUID).Guid
        $userCertificateList = @($obj.UserCertificate)
        $validEntries = @()
        $totalEntriesCount = $userCertificateList.Count
        Write-verbose "'$objDN' ObjectGUID: $objectGuid"
        Write-verbose "'$objDN' has $totalEntriesCount entries in UserCertificate property."
        If ($totalEntriesCount -eq 0)
        {
            Write-verbose "'$objDN' has no Certificates - Skipped."
            Continue
        }

        # Check each UserCertificate entry and build array of valid certs
        ForEach($entry in $userCertificateList)
        {
            Try
            {
                $cert = [System.Security.Cryptography.X509Certificates.X509Certificate2] $entry
            }
            Catch
            {
                Write-verbose "'$objDN' has an invalid Certificate!"
                Continue
            }
            Write-verbose "'$objDN' has a Certificate with Subject: $($cert.Subject); Thumbprint:$($cert.Thumbprint)."
            $validEntries += $cert

        }
        
        $validEntriesCount = $validEntries.Count
        Write-verbose "'$objDN' has a total of $validEntriesCount certificates (shown above)."
        
        # Get non-expired Certs (Valid Certificates)
        $validCerts = @($validEntries | Where-Object {$_.NotAfter -ge (Get-Date)})
        $validCertsCount = $validCerts.Count
        Write-verbose "'$objDN' has $validCertsCount valid certificates (not-expired)."

        # Check for AAD Hybrid Join Certificates
        $hybridJoinCerts = @()
        $hybridJoinCertsThumbprints = [string] "|"
        ForEach ($cert in $validCerts)
        {
            $certSubjectName = $cert.Subject
            If ($certSubjectName.StartsWith($("CN=$objectGuid")) -or $certSubjectName.StartsWith($("CN={$objectGuid}")))
            {
                $hybridJoinCerts += $cert
                $hybridJoinCertsThumbprints += [string] $($cert.Thumbprint) + '|'
            }
        }

        $hybridJoinCertsCount = $hybridJoinCerts.Count
        if ($hybridJoinCertsCount -gt 0)
        {
            $cloudFiltered = 'FALSE'
            Write-verbose "'$objDN' has $hybridJoinCertsCount AAD Hybrid Join Certificates with Thumbprints: $hybridJoinCertsThumbprints (cloudFiltered=FALSE)"
        }
        Else
        {
            $cloudFiltered = 'TRUE'
            Write-verbose "'$objDN' has no AAD Hybrid Join Certificates (cloudFiltered=TRUE)."
        }
        
        # Save results
        $r = "" | Select ObjectDN, ObjectGUID, TotalEntriesCount, CertsCount, ValidCertsCount, HybridJoinCertsCount, CloudFiltered
        $r.ObjectDN = $objDN
        $r.ObjectGUID = $objectGuid
        $r.TotalEntriesCount = $totalEntriesCount
        $r.CertsCount = $validEntriesCount
        $r.ValidCertsCount = $validCertsCount
        $r.HybridJoinCertsCount = $hybridJoinCertsCount
        $r.CloudFiltered = $cloudFiltered
        $results += $r
    }

    # Export results to CSV
    Try
    {        
        $results | Export-Csv $Filename -NoTypeInformation -Delimiter ';'
        Write-Host "Exported Hybrid Azure AD Domain Join Certificate Report to '$Filename'.`n"
    }
    Catch
    {
        Throw "There was an error saving the file '$Filename': $($_.Exception.Message)"
    }

 ```

## Next Steps

- [Azure AD Connect Version history](/azure/active-directory/hybrid/reference-connect-version-history)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
