---
title: Azure Instance Metadata Service and Certificate related issues 
description: Azure Instance Metadata Service and Certificate related issues 
ms.service: azure-virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Azure Instance Metadata Service and Certificate related issues 

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

> [!NOTE]
> The new [Azure Instance Metadata Service Troubleshooting Tool](windows-vm-imds-tool.md) Run Command is now available to make diagnosing this scenario easier.


The Azure Instance Metadata Service (IMDS) is a REST API that's available at a well-known, non-routable IP address (`169.254.169.254`). You can only access it from within the VM. Communication between the VM and IMDS never leaves the host. HTTP clients must bypass web proxies within the VM when querying IMDS. IMDS IP address (`169.254.169.254`) must be handled in the same manner as the 168.63.129.16 IP address. For additional information, read about the [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)


## Symptom
The Azure Virtual Machine cannot establish a connection with the Azure Instance Metadata Service (IMDS) endpoint. 

* Applications/Clients dependent on the IMDS Service to be functioning are not working as expected
* Windows Server 2022/2025 Azure Edition [activation watermark continues to be displayed](./activation-watermark-appears.md)
* Extended Security Updates for Windows EOS versions may not install or function correctly

When testing the IMDS service response, the error below is encountered:
Need repro or does the IMDS endpoint not just work

**Need unsuccessful response**

## Cause

Intermediate certificates that are crucial for the process have expired or are missing.

For more information, see [Azure Instance Metadata Service-Attested data TLS: Critical changes are here](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-instance-metadata-service-attested-data-tls-critical/ba-p/2888953).


## Resolution

### How to determine if any certificates are missing

Run the following PowerShell script to check for missing certificates:

```powershell
# Get the signature
# Powershell 5.1 does not include -NoProxy
$attestedDoc = Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Uri http://169.254.169.254/metadata/attested/document?api-version=2018-10-01
#$attestedDoc = Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -NoProxy -Uri http://169.254.169.254/metadata/attested/document?api-version=2018-10-01
 
# Decode the signature
$signature = [System.Convert]::FromBase64String($attestedDoc.signature)
 
# Get certificate chain
$cert = [System.Security.Cryptography.X509Certificates.X509Certificate2]($signature)
$chain = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Chain
 
if (-not $chain.Build($cert)) {
   # Print the Subject of the issuer
   Write-Host $cert.Subject
   Write-Host $cert.Thumbprint
   Write-Host "------------------------"
   Write-Host $cert.Issuer
   Write-Host "------------------------"
   Write-Host "Certificate not found: '$($cert.Issuer)'" -ForegroundColor Red
   Write-Host "Please refer to the following link to download missing certificates:" -ForegroundColor Yellow
   Write-Host "https://learn.microsoft.com/en-us/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains" -ForegroundColor Yellow
} else {
   # Print the Subject of each certificate in the chain
   foreach($element in $chain.ChainElements) {
       Write-Host $element.Certificate.Subject
       Write-Host $element.Certificate.Thumbprint
       Write-Host "------------------------"
   }
 
   # Get the content of the signed document
   Add-Type -AssemblyName System.Security
   $signedCms = New-Object -TypeName System.Security.Cryptography.Pkcs.SignedCms
   $signedCms.Decode($signature);
   $content = [System.Text.Encoding]::UTF8.GetString($signedCms.ContentInfo.Content)
   Write-Host "Attested data: " $content
   $json = $content | ConvertFrom-Json
}

```

If any certificates are missing, you'll see an output similar to the following one:

```output
CN=metadata.azure.com, O=Microsoft Corporation, L=Redmond, S=WA, C=US
3ACCC393D3220E40F09A69AC3251F6F391172C32
------------------------
CN=Microsoft Azure RSA TLS Issuing CA 04, O=Microsoft Corporation, C=US
------------------------
Certificate not found: 'CN=Microsoft Azure RSA TLS Issuing CA 04, O=Microsoft Corporation, C=US'
Please refer to the following link to download missing certificates:
https://learn.microsoft.com/en-us/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains
```

To fix the certificate issue, go to [Solution 2: Ensure firewalls and proxies are configured to allow certificate downloads](#solution-2-ensure-firewalls-and-proxies-are-configured-to-allow-certificate-downloads).

## Solution 2: Ensure firewalls and proxies are configured to allow certificate downloads

1. If you use Windows Server 2022, check if [KB 5036909](https://support.microsoft.com/topic/april-9-2024-kb5036909-os-build-20348-2402-36062ce9-f426-40c6-9fb9-ee5ab428da8c) is installed. If not, install it. You can get it from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5036909).

2. If you have installed the update for Windows Server 2022 but still encounter the issue or you use Windows Server 2025, verify that your system's firewalls and proxies are configured to allow the download of certificates. For more information, see [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details#certificate-downloads-and-revocation-lists).

   Alternatively, you can download and install all the certificates directly from the [root and subordinate certificate authority chains](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains#root-and-subordinate-certificate-authority-chains).
  
   > [!NOTE]
   > Make sure to select the store location as **Local Machine** in the installation wizard.

3. Open Command Prompt as an administrator, navigate to *c:\windows\system32*, and run *fclip.exe*.
4. Restart the VM or sign out and then sign in again. You'll see that the watermark on the home page is no longer displayed, and the **Application state** field in the **Settings** > **Activation** screen reports success.

### **Additional resources**

- [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)
- [Azure Instance Metadata Service-Attested data TLS: Critical changes are here](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-instance-metadata-service-attested-data-tls-critical/ba-p/2888953)
- [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details#certificate-downloads-and-revocation-lists)

 

[route-command]: /windows-server/administration/windows-commands/route_ws2008