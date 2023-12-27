---
title: Can't join a device to a Workplace by using Device Registration Services
description: Resolves an error when a user can't join a device to a Workplace by using Device Registration Services.
ms.date: 06/08/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: domain-services
---
# Can't perform a Workplace Join by using Device Registration Services

This article describes an issue in which a user can't join a device to a Workplace by using Device Registration Services. It provides two resolutions.

_Original product version:_ &nbsp; Windows 8.1 Enterprise, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, Microsoft Entra ID  
_Original KB number:_ &nbsp; 3045387

## Symptoms

When a user tries to do a Workplace Join by using Device Registration Services, the user receives one of the following messages:

- The user receives the following message _before_ providing the user's user name and password:

    > Confirm you are using the current sign-in info, and that your workplace uses this feature. Also, the connection to your workplace might not be working right now. Please wait and try again.

- The user receives the following message _after_  the user provides the user's user name and password:

    > Can't connect to the service.

## Resolution

To resolve either of these problems, use the method that's appropriate for the situation.

### Method 1

To fix the problem for message 1, review the Event logs on the client computer that's trying to do a Workplace Join to determine the correct solution.

An administrator may see details in Event Viewer that resemble the following example:

|Event ID:|(See the following table for the Event ID.)|
|---|---|
|Log Name:|Windows 7: Applications and Service Logs/Microsoft-Workplace-Join/Admin<br/><br/>Windows 8 or Windows 10: Applications and Service Logs/Microsoft-Windows-Workplace-Join/Admin|
|Source:|Microsoft-Windows-Workplace Join|
|Level:|Error|
|Description:|(See the following table for the Event ID description.)|
  
|Event ID|Description|Resolution|
|---|---|---|
|103|Workplace Join discovery failed. Server returned http status 404.|KB [3045386](https://support.microsoft.com/help/3045386) |
|103|Workplace Join discovery failed. Server returned http status 503.|KB 3045388 |
|102|Workplace Join discovery failed.<br/><br/>Exit Code: 0x80072EE7.<br/><br/>The server name or address could not be resolved. Could not connect to `'https://EnterpriseRegistration.domainTEST.com:443/EnrollmentServer/contract?api-version=1.0'`.|KB [3045385](https://support.microsoft.com/help/3045385) |
|102|Workplace Join discovery failed.<br/><br/>Exit Code: 0x80072F19.<br/><br/>It was not possible to connect to the revocation server or a definitive response could not be obtained. Could not connect to `'https://EnterpriseRegistration.domain.com:443/EnrollmentServer/contract?api-version=1.0'`.|KB 3045384 |
|102|Workplace Join discovery failed.<br/><br/>Exit Code: 0x80072F8A.<br/><br/>The supplied certificate has been revoked. Could not connect to `'https://EnterpriseRegistration.domain.com:443/EnrollmentServer/contract?api-version=1.0'`.|KB 3045383 |
|102|Workplace Join discovery failed.<br/><br/>Exit Code: 0x80072F0D.<br/><br/>The certificate authority is invalid or incorrect. Could not connect to `'https://EnterpriseRegistration.domain.com:443/EnrollmentServer/contract?api-version=1.0'`.|KB 3045382 |
|102|Workplace Join discovery failed.<br/><br/>Exit Code: 0x80072EFD.<br/><br/>A connection with the server could not be established. Could not connect to `'https://EnterpriseRegistration.domain.com:443/EnrollmentServer/contract?api-version=1.0'`.|KB 3045381|
|102|Workplace Join discovery failed.<br/><br/>Exit Code: 0x80004005.<br/><br/>An unknown error has occurred. Could not connect to `'https://EnterpriseRegistration.domain.com:443/EnrollmentServer/contract?api-version=1.0'`.|KB 3045380 |
|200|"The maximum number of devices that can be joined to the workplace by the user has been reached."|KB [3045379](https://support.microsoft.com/help/3045379) |
  
### Method 2

To fix the problem for message 2, see ["Can't connect to the service" error when you try to register a device](https://support.microsoft.com/help/3045378).

## More Information

To quickly troubleshoot these problems, try one or more of the following things.

### Verify DNS

Verify the DNS configuration by using `NSlookup`, and verify that the answers are correct. To do so, open a Command Prompt window, and then run the following command:

```console
Nslookup enterpriseregistration.domain.com
```

- If you use Microsoft Entra join:
  - Should return CNAME result of `EnterpriseRegistration.windows.net` as the target.
- If you use Windows Server Workplace Join:
  - Internal host should return internal ADFS node.
  - External host should return external ADFS proxy address.  

### Flush the DNS cache

Open a Command Prompt window as an administrator, and then run the following command:

```console
ipconfig /FlushDNS
```

### Verify that Device Registration is enabled

If you try to do Workplace Join to Microsoft Entra ID:

1. Sign in to the Azure portal, or start the Microsoft Entra ID console from Microsoft 365 admin center as a Company Administrator.
2. Go to the directory where the user is trying to do the join.
3. Go to **Configure**.
4. Scroll down to the **Device Registration** section.
5. Make sure the setting labeled **ENABLE WORKPLACE JOIN** is toggled to **Yes**. ("Yes" will be blue.)

If you try to do Workplace Join to your local Active Directory domain, take the following actions:

- Open the Active Directory Federation Services (AD FS) management console.
- Select **Relying Party Trusts** to determine whether the Device Registration Service trust is enabled on each node of the AD FS farm.

### Verify that the Active Directory Federation Services service and the Device Registration Services service are running

If you try to do a Workplace Join to your local Active Directory, you should log on to each node of the AD FS farm and then follow these steps:

1. Go to **Control Panel**, **Administrative Tools**, and then **Services** (Services.msc).
2. Locate the Active Directory Federation Services service, and verify its status.
3. Locate the Device Registration Services service, and verify its status.
4. If either service isn't running, start the services.

### Verify that the host name bindings are registered for each node in the AD FS farm

If you try to do a Workplace Join to your local Active Directory, follow the steps at the following Microsoft TechNet website:

 [Configure a Host Header for a Web Site (IIS 7)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753195(v=ws.10)?redirectedfrom=MSDN)

Make sure that the host name (such as EnterpriseRegistration. **domain_name**. **domain_extension**) is bound to port 443.

### Update the root certificates

Run [Microsoft Update](https://update.microsoft.com/), and make sure that the [Updates for Root Certificates](https://support.microsoft.com/help/931125) are all installed

### Verify that traffic is enabled if you're using a third-party proxy or firewall server

If you try to do a Workplace Join to your local Active Directory, verify that there's a rule to enable incoming TCP connections to EnterpriseRegistration. **domain_name**. **domain_extension**. It should allow for traffic to pass through to the DRS server.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
