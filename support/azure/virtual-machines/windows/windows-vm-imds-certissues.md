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

The Azure Instance Metadata Service (IMDS) is a REST API that's available at a well-known, non-routable IP address (`169.254.169.254`). You can only access it from within the VM. Communication between the VM and IMDS never leaves the host. HTTP clients must bypass web proxies within the VM when querying IMDS. IMDS IP address (`169.254.169.254`) must be handled in the same manner as the 168.63.129.16 IP address. 

[Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service.md)

Run the [IMDSCertCheck](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/IMDSCertCheck) to diagnose any known isses. Additional information is also located below.

## Symptom
The Azure Virtual Machine cannot establish a connection with the Azure Instance Metadata Service (IMDS) endpoint. 

* Applications/Clients dependent on the IMDS Service to be functioning are not working as expected
* Windows Server 2022/2025 Azure Edition [activation watermark continues to be displayed](./activation-watermark-appears.md)
* Extended Security Updates for Windows EOS versions may not install or function correctly

When testing the IMDS service response, the error below is encountered:
Need repro or does the IMDS endpoint not just work

**Need unsuccessful response**

## Cause 
IMDS has a dependency on the Intermediate certificates located on the machine for the service to function properly. Those Intermediate certificates must be valid and must have access to [Certificate downloads and revocation lists](azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains%23certificate-downloads-and-revocation-lists.md) and must be included in your firewall allowlists. For more information about expired certificates, please read [Azure Instance Metadata Service-Attested data TLS: Critical changes are here](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-instance-metadata-service-attested-data-tls-critical/ba-p/2888953).


## Resolution

Please refer to the following link to [download missing certificates:](azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains) 

While not recommend and if you're unable to allow access to the PKI URL from your servers , you can manually download and install the certificates on each machine[] listed here](azure/security/fundamentals/azure-ca-details?tabs=root-and-subordinate-cas-list#subordinate-certificate-authorities).

### Step 1

On any computer with internet access, download any of the missing intermediate CA certificates:

| | |
| ---------- | ------------- |
| Microsoft Azure RSA TLS Issuing CA 03 | https://www.microsoft.com/pkiops/certs/Microsoft Azure RSA TLS Issuing CA 03 - xsign.crt | 
| Microsoft Azure RSA TLS Issuing CA 04 | https://www.microsoft.com/pkiops/certs/Microsoft Azure RSA TLS Issuing CA 04 - xsign.crt |
| Microsoft Azure RSA TLS Issuing CA 07 | https://www.microsoft.com/pkiops/certs/Microsoft Azure RSA TLS Issuing CA 07 - xsign.crt |
| Microsoft Azure RSA TLS Issuing CA 08 | https://www.microsoft.com/pkiops/certs/Microsoft Azure RSA TLS Issuing CA 08 - xsign.crt | 
| |  |

### Step 2
Copy the certificate files to your machines that are missing .

### Step 3
Run any one set of the following commands in an elevated command prompt or PowerShell session to add the certificates to the "Intermediate Certificate Authorities" store for the local computer. The command should be run from the same directory as the certificate files. 

The commands are idempotent and won't make any changes if you've already imported the certificate:

 ```
CERTUTIL -ADDSTORE CA "MICROSOFT AZURE RSA TLS ISSUING CA 03 - XSIGN.CRT"
CERTUTIL -ADDSTORE CA "MICROSOFT AZURE RSA TLS ISSUING CA 04 - XSIGN.CRT"
CERTUTIL -ADDSTORE CA "MICROSOFT AZURE RSA TLS ISSUING CA 07 - XSIGN.CRT"
CERTUTIL -ADDSTORE CA "MICROSOFT AZURE RSA TLS ISSUING CA 08 - XSIGN.CRT"
``` 

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
