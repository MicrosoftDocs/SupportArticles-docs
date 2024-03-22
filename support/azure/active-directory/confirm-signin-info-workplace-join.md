---
title: Error (Confirm you are using the current sign-in info) when you perform a Workplace Join
description: Describes a problem that returns a (Confirm you are using the current sign-in info, and that your workplace uses this feature) error. Provides a resolution.
ms.date: 06/08/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: authentication
---
# Error when you perform a Workplace Join: Confirm you are using the current sign-in info

This article describes a problem in which an error occurs when you perform a Workplace Join operation.

_Original product version:_ &nbsp; Windows 8.1 Enterprise, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, Microsoft Entra ID  
_Original KB number:_ &nbsp; 3045386

## Symptoms

When you try to perform a Workplace Join operation, you receive this error message:

> Confirm you are using the current sign-in info, and that your workplace uses this feature. Also, the connection to your workplace might not be working right now. Please wait and try again.

Additionally, an administrator may see the following event details in Event Viewer:

> Event ID: 103  
Log Name: Microsoft-Windows-Workplace Join/Admin  
Source: Microsoft-Windows-Workplace Join  
Level: Error  
Description: Workplace Join discovery failed. Server returned http status 404.  
`https://EnterpriseRegistration.domain.com:443/EnrollmentServer/contract?api-version=1.0`

## Cause

This problem occurs for one of the following reasons:

- The client is being redirected to the internal Device Registration Service (DRS) instance where the DRS endpoint is disabled or stopped.
- The DNS records for the EnterpriseRegistration service are missing or misconfigured.
- The domain suffix of the currently logged-on user is not accounted for in the SSL certificate of DRS.
- The network or firewall is blocking traffic, or transient network issues are causing packet loss.

## Resolution

### Verify DNS

Verify the DNS configuration by using the `NSlookup` tool, and verify that the answers are correct.

To do this, open a Command Prompt window, and then run the following command:

```console
Nslookup enterpriseregistration.domain.com
```

- If you use Microsoft Entra join
  - This should return the CNAME result of `EnterpriseRegistration.windows.net` as the target.
- If you use Windows Server Workplace Join
  - The internal host should return the internal AD FS node.
  - The external host should return the external AD FS proxy address.

### Verify that Device Registration is enabled

If you try to perform Workplace Join to Microsoft Entra ID, follow these steps:

1. Sign in to Azure portal, or launch the Microsoft Entra ID console from the M365 admin center as a Company Administrator.
2. Locate the directory where the user is trying the join operation.
3. Go to Configure.
4. Scroll down to the Device Registration section.
5. Make sure that the setting that's labeled ENABLE WORKPLACE JOIN is toggled to Yes (Yes will be blue).

If you try to perform a Workplace Join to your local Active Directory domain, follow these steps:

1. Start the AD FS Management console, and then select Relying Party Trusts to determine whether the Device Registration Service trust is Enabled on each node of the AD FS farm.
2. If Device Registration Service is Enabled, check the Services Console to make sure that the Device Registration Service is started.

### Check the SSLCertificate bindings

If you try to perform Workplace Join to your local Active Directory domain, follow these steps:

1. Open a Command Prompt window as an administrator, type the following commands, and press Enter after each command to display the bindings on the ADFS Proxy or ADFS Server:

    ```console
    Netsh
    ```

    ```console
    Http Show SSLCert
    ```

2. Determine whether the IP Port Binding (not Name binding) is present.
3. If the IP Port binding is not present, review to determine whether the EnterpriseRegistration Name binding is present.

## More information

For more troubleshooting information, see the following article in the Microsoft Knowledge Base:

[Diagnostic logging for troubleshooting Workplace Join issues](https://support.microsoft.com/help/3045377).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
