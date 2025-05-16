---
title: Windows activation watermark continues to be displayed
description: Learn how to resolve a scenario in which a Windows activation watermark continues to be displayed on Azure virtual machines.
author: cwhitley-MSFT
ms.author: cwhitley
ms.reviewer: scotro, scottmca, kimberj, jdickson, shache, justingross, v-naqviadil, v-leedennis, v-weizhu
ms.date: 05/16/2025
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.topic: troubleshooting-problem-resolution
#Customer intent: As an Azure administrator, I want to learn how to resolve the appearance of an "Activate Windows" watermark so that I can successfully use Windows on my Azure virtual machine.
---
# Windows activation watermark continues to be displayed

**Applies to:** :heavy_check_mark: Windows VMs running Windows Server 2025 Datacenter Azure Edition, Windows VMs running Windows Server 2022 Datacenter Azure Edition

This document discusses how to resolve the continued presence of a Windows activation watermark on Microsoft Azure virtual machines.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli-windows)

## Symptoms

When you use an Azure virtual machine (VM) that runs Windows Server 2025/2022 Datacenter Azure Edition, you encounter the following symptoms:

- You see a watermark on the desktop that contains the following message:

  > Activate Windows. Go to Settings to activate Windows.

  This watermark indicates that the Windows activation status isn't genuine.

- When you open the **Settings** app and select **System** > **Activation**, the **Application state** field indicates an activation failure.

- When you open an elevated Command Prompt window and run the following [slmgr.vbs volume activation script](/windows-server/get-started/activation-slmgr-vbs-options), the output shows that Key Management Services (KMS) activation is successful, but the first two symptoms remain:

  ```console
  cscript c:\windows\system32\slmgr.vbs /dlv
  ```
- When you restart or sign in to the VM, a pop-up window with one of the following messages is displayed:

  - > Your Windows Server 2022 Datacenter Azure Edition VM has been deactivated because you are not running on Azure or a supported Azure Stack hypervisor, or that you have not enabled Azure benefits on the supported Azure Stack. To enable Azure benefits, go to your cluster settings in Windows Admin Center > Enable Azure benefits.

  - > Your Windows Server 2025 Datacenter Azure Edition VM has been deactivated because you are not running on Azure or a supported Azure Stack hypervisor, or that you have not enabled Azure benefits on the supported Azure Stack. To enable Azure benefits, go to your cluster settings in Windows Admin Center > Enable Azure benefits.

## Cause 1: Azure Instance Metadata Service connection issue

The Azure VM can't establish a connection with the [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service) endpoint, which is essential for obtaining the activation token.

### How to determine if the VM guest OS can successfully communicate with IMDS

Run the following PowerShell script depending on your version of PowerShell to check if the metadata is received from IMDS.

- **PowerShell 6 and later versions**

  ```powershell
  Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -NoProxy -Uri 
  http://169.254.169.254/metadata/attested/document?api-version=2020-09-01
   | Format-List * | Out-File "IMDSResponse1.txt"
  ```

- **PowerShell 5 and earlier versions**

  ```powershell
  $Proxy=New-object System.Net.WebProxy
  $WebSession=new-object Microsoft.PowerShell.Commands.WebRequestSession
  $WebSession.Proxy=$Proxy
  Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01" -WebSession $WebSession
  ```

If you get a successful response, you'll see the metadata information from the VM, such as the following output:

 ```output
 compute                                                                                                                                                                  
 -------                                                                                                                                                                  
 @{azEnvironment=AzurePublicCloud; customData=; evictionPolicy=; isHostCompatibilityLayerVm=true; licenseType=; location=eastus; name=testWs; offer=WindowsServer; ...
 ```

If not, it means that the connection to the IMDS wire server is blocked somewhere, and access to it needs to be allowed. The IP of the IMDS server is `169.254.169.254`. To fix the connection issue, go to [Solution 1: Bypass web proxies within the VM](#solution-1-bypass-web-proxies-within-the-vm).

## Cause 2: Certificate related issue

Intermediate certificates that are crucial for the activation process have expired.

For more information, see [Azure Instance Metadata Service-Attested data TLS: Critical changes are here](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-instance-metadata-service-attested-data-tls-critical/ba-p/2888953).

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

## Solution 1: Bypass web proxies within the VM

[IMDS](/azure/virtual-machines/instance-metadata-service) is a REST API that's available at a well-known, non-routable IP address (`169.254.169.254`). The IMDS endpoint is accessible from within the VM only at the following URI: `http://169.254.169.254/metadata/instance`. Communication between the VM and IMDS never leaves the host. Have your HTTP clients bypass web proxies within the VM while they query IMDS. Also, make sure that the clients treat the `169.254.169.254` IP address in the same manner as they treat the [168.63.129.16 IP address](/azure/virtual-network/what-is-ip-address-168-63-129-16). To verify that this direct network connection exists, follow these steps:

> [!NOTE]
> `168.63.129.16` is a Microsoft-owned virtual public IP address that's used for communicating with Azure resources.

1. To view the local routing table on your VM, run the [route print][route-command] command:

   ```powershell-interactive
   route print
   ```

1. To locate the routing entry for the IMDS target, go to the `Active Routes` section of the `IPv4 Route Table` output, and then find the row that contains the `169.254.169.254` IP address in the `Network Destination` column.

   | Network Destination | Netmask         | Gateway     | Interface       | Metric |
   |--------------------:|----------------:|------------:|----------------:|-------:|
   | 0.0.0.0             | 0.0.0.0         | 172.16.69.1 | 172.16.69.7     | 10     |
   | 127.0.0.0           | 255.0.0.0       | On-link     | 127.0.0.1       | 331    |
   | 127.0.0.1           | 255.255.255.255 | On-link     | 127.0.0.1       | 331    |
   | 127.255.255.255     | 255.255.255.255 | On-link     | 127.0.0.1       | 331    |
   | 168.63.129.16       | 255.255.255.255 | 172.16.69.1 | 172.16.69.7     | 11     |
   | **169.254.169.254** | 255.255.255.255 | 172.16.69.1 | **172.16.69.7** | 11     |
   | ...                 | ...             | ...         | ...             | ...    |

   In the sample route table output, the IMDS target entry is in the last row, and the corresponding network interface is the value in the `Interface` column within that row. (In this example, the network interface is `172.16.69.7`.)

1. To view the IP configuration of your VM, run the [ipconfig](/windows-server/administration/windows-commands/ipconfig) command:

     ```powershell-interactive
     ipconfig /all
     ```

1. In the ipconfig command output, find the IP configuration in which the `IPv4 Address` field matches the network interface value of the IMDS entry (`172.16.69.7`):

     ```output
     ...
     Ethernet adapter Ethernet:

     Connection-specific DNS Suffix  . : xic3mnxjiefupcwr1mcs1rjiqa.cx.internal.cloudapp.net
     Description . . . . . . . . . . . : Microsoft Hyper-V Network Adapter
     Physical Address. . . . . . . . . : 00-0D-3A-E5-1C-C0
     DHCP Enabled. . . . . . . . . . . : Yes
     Autoconfiguration Enabled . . . . : Yes
     Link-local IPv6 Address . . . . . : fe80::3166:ce5a:2bd5:a6d1%3(Preferred)
     IPv4 Address. . . . . . . . . . . : 172.16.69.7(Preferred)
     Subnet Mask . . . . . . . . . . . : 255.255.255.0
     ...
     ```

   In the sample ipconfig output, the IP configuration that contains the network interface value of the IMDS entry is `Ethernet adapter Ethernet`.

1. In the IP configuration that you located, copy the Media Access Control (MAC) address and the primary private IP address that the VM uses. The MAC address is shown in the `Physical Address` field, and the primary private IP address is shown in the `IPv4 Address` field. In this example, the MAC address and the primary private IP address are `00-0D-3A-E5-1C-C0` and `172.16.69.7`, respectively.

1. Check whether the MAC and primary private IP addresses that Azure uses for the VM match the MAC address and the primary private IP address that the guest OS of the VM actually uses (the addresses that you found in the earlier step). To determine what Azure uses as the MAC address, you use Azure CLI. To determine what Azure uses as the primary private IP address, you examine the network configuration in the Azure portal.

   - Find the MAC address (by using Azure CLI in a PowerShell script)

     Run the following PowerShell script that invokes Azure CLI commands. This script invokes the [az vm nic list](/cli/azure/vm/nic#az-vm-nic-list) command to collect the names of the network interfaces on your VM. Then, it invokes the [az vm nic show](/cli/azure/vm/nic#az-vm-nic-show) command to display the name of each network interface, whether that network interface is the primary network interface (`True` or `False`), and the MAC address of the network interface:

     > [!NOTE]
     > In the commands, "nic" represents the network interface, not a network interface card.

     ```powershell-interactive
     # Placeholder variable definitions
     $ResourceGroup = "<resource-group-name>"
     $VmName = "<virtual-machine-name>"

     # Code
     $NicNames = az vm nic list --resource-group $ResourceGroup --vm-name $VmName |
         ConvertFrom-Json | Foreach-Object { $_.id.Split('/')[-1] }
     foreach($NicName in $NicNames)
     {
         az vm nic show --resource-group $ResourceGroup --vm-name $VmName --nic $NicName |
             ConvertFrom-Json | Format-Table -Property name, primary, macAddress
     }
     ```

     ```output
     name       primary macAddress
     ----       ------- ----------
     wintest767    True 00-0D-3A-E5-1C-C0
     ```

   - Find the primary private IP address (by using the Azure portal):

     1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machines**.

     1. In the list of VMs, select the name of your VM.

     1. On the **Properties** tab of your VM **Overview** page, locate the **Networking** heading.

     1. In the **Private IP address** field, copy the displayed IPv4 address.

1. If the MAC addresses or the primary private IP addresses aren't identical between Azure and the VM guest OS, use various [route][route-command] commands to update the routing table so that the primary network interface and IP address are targeted.

## Solution 2: Ensure firewalls and proxies are configured to allow certificate downloads

1. If you are using Windows Server 2022, check if [KB 5036909](https://support.microsoft.com/topic/april-9-2024-kb5036909-os-build-20348-2402-36062ce9-f426-40c6-9fb9-ee5ab428da8c) is installed. If not, install it. You can get it from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5036909).

2. If you have installed the update for Windows Server 2022 but still encounter the issue or you are using Windows Server 2025, verify that your system's firewalls and proxies are configured to allow the download of certificates. For more information, see [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details?tabs=root-and-subordinate-cas-list#certificate-downloads-and-revocation-lists).

   Alternatively, you can download and install all the certificates directly from the [root and subordinate certificate authority chains](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains#root-and-subordinate-certificate-authority-chains).
  
   > [!NOTE]
   > Make sure to select the store location as **Local Machine** in the installation wizard.

3. Open Command Prompt as an administrator, navigate to *c:\windows\system32*, and run *fclip.exe*.
4. Restart the VM or sign out and then sign in again. You'll see that the watermark on the home page is no longer displayed, and the **Application state** field in the **Settings** > **Activation** screen reports success.

## More information

- [Troubleshoot Azure Windows virtual machine activation problems](./troubleshoot-activation-problems.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[route-command]: /windows-server/administration/windows-commands/route_ws2008
