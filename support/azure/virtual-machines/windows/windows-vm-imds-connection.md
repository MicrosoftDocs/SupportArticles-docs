---
title: Azure Instance Metadata Service Connection Issues
description: Azure Instance Metadata Service Connection Issues
ms.service: azure-virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Azure Instance Metadata Service Connection Issues

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

The Azure Instance Metadata Service (IMDS) is a REST API that's available at a well-known, non-routable IP address (`169.254.169.254`). You can only access it from within the VM. Communication between the VM and IMDS never leaves the host. HTTP clients must bypass web proxies within the VM when querying IMDS. IMDS IP address (`169.254.169.254`) must be handled in the same manner as the `168.63.129.16` IP address. 

[Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service.md)

Run the [IMDSCertCheck](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/IMDSCertCheck) to diagnose any known isses. Additional information is also located below.

## Symptom
The Azure Virtual Machine cannot establish a connection with the Azure Instance Metadata Service (IMDS) endpoint. 

* Applications/Clients dependent on the IMDS Service to be functioning are not working as expected
* Windows Server 2022/2025 Azure Edition [activation watermark continues to be displayed](./activation-watermark-appears.md)
* Extended Security Updates for Windows EOS versions may not install or function correctly


When testing the IMDS service response, the error below is encountered:

**Need unsuccessful response**

## Cause 
The connection to the IMDS wire server is blocked somewhere, and access to it needs to be allowed.

To determine if the VM guest OS can successfully communicate with IMDS, run the tool mentioned above or the following PowerShell script to check if the metadata is received from IMDS. Additional information can be obtained here 

PowerShell 6 and later versions
```
Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -NoProxy -Uri "http://169.254.169.254/metadata/instance?api-version=2025-04-07" | ConvertTo-Json -Depth 64
```

*-NoProxy requires PowerShell V6 or greater. See our samples repository for examples with older PowerShell versions.*

If not, it means that the connection to the IMDS wire server is blocked somewhere, and access to it needs to be allowed. 


## Resolution

1.	Connect to the VM by using Remote Desktop, and then test connectivity to `169.254.169.254`. See the Troubleshoot connectivity section of Azure IP address `168.63.129.16` overview which has similar instructions.

2.	If you have only one private IP on your VM's network adapter, we highly recommend that you have DHCP enabled on the guest VM. If you need a static private IP address, you should configure it through the Azure portal or PowerShell and make sure the DHCP option inside the VM is enabled. To make sure that the IP configuration always matches the configuration on the VM in Azure, learn how to set up a static IP address by using PowerShell.

3.	If you have multiple private IPs assigned to your VM's network adapter, make sure that you carefully follow the steps to assign the IP configurations correctly. After you finish the steps, if the error continues with `169.254.169.254,` check that the primary IP in Windows matches the primary IP in your VM's network adapter in Azure.

4.	Check for any issues that a firewall, a proxy, or another source might cause that could block access to IP address `169.254.169.254`.

5.	Check whether Windows Firewall or a third-party firewall is blocking access to ports `80 and 32526` – is this it? . For more information about why this address shouldn't be blocked, see What is IP address `168.63.129.16`?


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
