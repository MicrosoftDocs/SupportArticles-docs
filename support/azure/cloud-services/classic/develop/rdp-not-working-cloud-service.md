---
title: Remote Desktop Protocol not working for classic cloud service resource
description: Learn how to troubleshoot when Remote Desktop Protocol (RDP) isn't working in a classic cloud service resource and restore access quickly.
ms.date: 09/26/2022
author: kaushika-msft
ms.author: kaushika
ms.service: azure-cloud-services-classic
ms.custom: sap:Development
---
# Remote Desktop Protocol not working for classic cloud service resource

## Summary

This article provides information about troubleshooting issues where Remote Desktop Protocol (RDP) isn't working for Azure customers who use classic cloud service resources.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464927

## Symptoms

This article discusses one of the most common scenarios faced by Azure customers who use classic cloud service resources - RDP isn't working with this error message:

:::image type="content" source="media/rdp-not-working-cloud-service/rdp-error.png" alt-text="Screenshot of an RDP connection error shown for a classic cloud service resource." lightbox="media/rdp-not-working-cloud-service/rdp-error.png":::

Sometimes, you can't download the RDP file and get this error message:

> "Failed to download the file. Error details: error 400 Bad Request".

## Cause

You might see the preceding errors for multiple reasons:

- RDP user account or encryption certificate expired.
- TCP port 3389 for RDP is blocked.
- RDP extension is disabled.

## Resolution

While troubleshooting RDP problems, you might find that resetting the RDP user account expiration date or renewing the encryption certificate doesn't fix the problem. In those cases, follow these steps:

1. Create a self-signed certificate in .pfx format.
1. Upload the self-signed certificate to the cloud service certificate store from the Azure portal.
1. Delete all the existing RDP extensions if present.
1. Re-enable Remote Desktop for the roles by using the self-signed certificate that you created in step 1.

You can also perform the preceding four steps by using a PowerShell script. Run the following PowerShell script in admin or elevated mode. Make sure you have the [Azure PowerShell module](/powershell/azure/new-azureps-module-az) installed on your system before running it.

```powershell
$SubscriptionId = "your-subscription-id" # Subscription Id
$CloudServiceName = "mycloudservice" # Cloud Service name
$CertPassword = "CertPassword" # Password for the self-signed certificate
$CertExportFilePath = "C:\my-cert-file.pfx" # Local file path where self-signed certificate will be exported
$RdpUserName = "RemoteUserName" # RDP user name
$RdpUserPassw0rd = "RdpPassword" # RDP user password
$Slot = "Production" # Cloud Service slot
$RdpAccountExpiry = $(Get-Date).AddDays(365) # RDP user account expiration DateTime

# Creating self-signed certificate

Write-Host (Get-Date).ToString()" : Creating self-signed certificate." -ForegroundColor Magenta
$cert = New-SelfSignedCertificate -DnsName ($CloudServiceName + ".cloudapp.net") -CertStoreLocation "cert:\LocalMachine\My" -KeyLength 2048 -KeySpec "KeyExchange"
$SecureCertPassword = ConvertTo-SecureString -String $CertPassword -Force -AsPlainText
 Export-PfxCertificate -Cert $cert -FilePath $CertExportFilePath -Password $SecureCertPassword
Write-Host (Get-Date).ToString()" : Self-signed certificate created successfully at" $CertExportFilePath -ForegroundColor Magenta

# Login to your Azure account

Write-Host (Get-Date).ToString()" : Logging into your Azure account." -ForegroundColor Magenta
Add-AzureAccount
Select-AzureSubscription -SubscriptionId $SubscriptionId
Write-Host (Get-Date).ToString()" : Logged in successfully." -ForegroundColor Magenta

# Uploading self-signed certificate to the cloud service certificate store

Write-Host (Get-Date).ToString()" : Uploading self-signed certificate to the cloud service certificate store." -ForegroundColor Magenta
Add-AzureCertificate -serviceName $CloudServiceName -certToDeploy $CertExportFilePath -password $CertPassword
Write-Host (Get-Date).ToString()" : Self-signed certificate uploaded successfully." -ForegroundColor Magenta

# Delete all the existing RDP extensions for a given cloud service slot

Write-Host (Get-Date).ToString()" : Deleting all the existing RDP extensions for" $Slot "slot." -ForegroundColor Magenta
Remove-AzureServiceRemoteDesktopExtension -ServiceName $CloudServiceName -UninstallConfiguration -Slot $Slot
Write-Host (Get-Date).ToString()" : Successfully deleted all the existing RDP extensions for" $Slot "slot." -ForegroundColor Magenta

# Enabling remote desktop extension on specified role(s) or all roles on a cloud service slot

Write-Host (Get-Date).ToString()" : Enabling remote desktop extension on all the roles." -ForegroundColor Magenta
$SecureRdpPassword = ConvertTo-SecureString -String $RdpUserPassw0rd -Force -AsPlainText
$Credential = New-Object System.Management.Automation.PSCredential $RdpUserName,$SecureRdpPassword
Set-AzureServiceRemoteDesktopExtension -ServiceName $CloudServiceName -Credential $Credential -CertificateThumbprint $cert.Thumbprint -Expiration $RdpAccountExpiry -Slot $Slot
Write-Host (Get-Date).ToString()" : Remote desktop extension applied successfully." -ForegroundColor Magenta
```

The output of the script is similar to the following screenshot:

:::image type="content" source="media/rdp-not-working-cloud-service/powershell-outputs.png" alt-text="Screenshot of an example output of the PowerShell script." border="false" lightbox="media/rdp-not-working-cloud-service/powershell-outputs.png":::

If you can't RDP after running the preceding script, then it's definitely a networking problem. A few possible reasons are:

- The network from where you're trying to RDP is blocking the traffic.
- Some ACL rules are configured in your cloud service.
- Firewall rules configured by using startup tasks.
- If your cloud service is sitting behind an NSG, you might need to create rules that allow traffic on ports **3389** and **20000**. The RemoteForwarder and RemoteAccess agents require that port **20000** is open, which might be blocked if you have an NSG.

Most of the time, your corporate network blocks the RDP traffic due to security reasons. So the first thing you should check is if you can reach the RDP ports 3389 and 20000 (if applicable as mentioned earlier) by using [PsPing](/sysinternals/downloads/psping), [PortQry](https://www.microsoft.com/download/details.aspx?id=24009), or [Telnet](https://blogs.technet.microsoft.com/danielmauser/2015/03/18/tip-installing-telnet-client-via-command-line/).

Refer to [this article](https://support.microsoft.com/help/4464850) that discusses how to troubleshoot RDP problems by using various tools like PsPing and Network Monitor. If you don't get any response, try to RDP from a different network, such as a home network or mobile hotspot.

 
