---
title: Error Code 0x8004de40 or 0x8004de88 when signing in to OneDrive
description: Describes how to resolve an issue when unable to sign in to OneDrive
author: helenclu
ms.reviewer: salarson
ms.author: luche
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 149475
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - OneDrive for Business
---

# Error Code 0x8004de40 or 0x8004de88 when signing in to OneDrive

## Symptoms

When you sign in to Microsoft OneDrive, you receive the following error message:  

> OneDrive Can't sign in. Error 0x8004de40
>
> Login was either interrupted or unsuccessful. Please try logging in again. (Error Code: 0x8004de40)
> 
> We can't sign into your account, please try again later 0x8004de88

Error Code 0x8004de40 or 0x8004de88 indicates OneDrive is having trouble connecting to the cloud.  

## Resolution

First, verify that you are connected to the internet. If the affected device is not connected, see [Fix Wi-Fi connection issues in Windows](https://go.microsoft.com/fwlink/?linkid=871051).

Make sure that you carefully review information about [TLS deprecation](/microsoft-365/compliance/tls-1.0-and-1.1-deprecation-for-office-365). That change might also cause this error.

If the device is connected to the internet and TLS has been updated, continue to the following steps based on the version of Windows that the device is running.

### Windows 10

**Solution 1: Check cipher suites settings**

Even after you upgrade to TLS 1.2, it's important to make sure that the cipher suites settings match Azure Front Door requirements, because Microsoft 365 and Azure Front Door provide slightly different support for cipher suites.

For TLS 1.2, the following cipher suites are supported by Azure Front Door:

- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_DHE_RSA_WITH_AES_128_GCM_SHA256

To add cipher suites, either deploy a group policy or use local group policy as described in [Configuring TLS Cipher Suite Order by using Group Policy](/windows-server/security/tls/manage-tls#configuring-tls-cipher-suite-order-by-using-group-policy). 

> [!IMPORTANT]
> Edit the order of the cipher suites to ensure that these four suites are at the top of the list (the highest priority).

Alternatively, you can use the [Enable-TlsCipherSuite](/powershell/module/tls/enable-tlsciphersuite?view=windowsserver2019-ps&preserve-view=true) cmdlet to enable the TLS cipher suites. For example, run the following command to enable a cipher suite as the highest priority:

```powershell
Enable-TlsCipherSuite -Name "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384" -Position 0
```
This command adds the TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 cipher suite to the TLS cipher suite list at position 0, which is the highest priority.

> [!IMPORTANT]
> After you run Enable-TlsCipherSuite, you can verify the order of the cipher suites by running Get-TlsCipherSuite. If the order doesn't reflect the change, check if the [SSL Cipher Suite Order](/windows-server/security/tls/manage-tls#configuring-tls-cipher-suite-order-by-using-group-policy) Group Policy setting configures the default TLS cipher suite order.

For more information, see [What are the current cipher suites supported by Azure Front Door?](/azure/frontdoor/front-door-faq#what-are-the-current-cipher-suites-supported-by-azure-front-door-&preserve-view=true).

**Solution 2: Check TLS protocols**

 Use the following steps:

1. Press Windows logo key+R to open the **Run** window.
2. Type *`inetcpl.cpl`*, and press **Enter**.
3. Navigate to the **Advanced** tab, and enable all three TLS protocols by selecting the check boxes for the TLS 1.0, TLS 1.1, and TLS 1.2 options.
4. Select **Apply** and then **OK** to save the changes.

**Solution 3: Restart the device**

Restart the device while it is connected to your Microsoft Entra domain. If that doesn’t fix the problem, unjoin your device from Microsoft Entra ID and rejoin it, by using the following steps.

> [!IMPORTANT]
> You must be connected to your organization’s network when you do these steps. Don’t do these steps if you aren’t connected to your organization’s infrastructure (for example, while traveling).

1. Open an elevated Command Prompt window. To do this, select **Start**, right-click **Command Prompt**, and then select **Run as administrator**.
1. Type *`dsregcmd /leave`*, and press **Enter**.
1. After the command runs, type *`dsregcmd /join`*, and press **Enter**.
1. After the command runs, close the Command Prompt window.
1. Restart the computer, and log in to OneDrive.

### Windows 8, Windows 7 or Windows Server 2012/2008 R2(SP1)

If you're using Windows 8, Windows 7 Service Pack 1 (SP1), Windows Server 2012 or Windows Server 2008 R2 SP1, see the following solutions.

- The [Easy Fix Tool](https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi) can add TLS 1.1 and TLS 1.2 Secure Protocol registry keys automatically. For more information, see [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392). 
- For Windows 8, install [KB 3140245](https://www.catalog.update.microsoft.com/search.aspx?q=kb3140245), and create a corresponding registry value.
- For Windows Server 2012, the [Easy Fix Tool](https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi) can add TLS 1.1 and TLS 1.2 Secure Protocol registry keys automatically. If you're still receiving intermittent connectivity errors after you run the Easy Fix Tool, consider [disabling DHE cipher suites](/security-updates/securitybulletins/2015/ms15-055#workarounds). For more information, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](/troubleshoot/windows-server/identity/apps-forcibly-closed-tls-connection-errors).

If none of these solutions fix the issue, consider checking the cipher suite settings and order. For more information, see **Solution 1** in the [Windows 10](#windows-10) section.

## All computers

If you have completed all the previous steps, consider doing a [reset of OneDrive](https://support.microsoft.com/en-us/office/reset-onedrive-34701e00-bf7b-42db-b960-84905399050c).

## References

- [TLS cipher suites supported by Microsoft 365](/microsoft-365/compliance/technical-reference-details-about-encryption?view=o365-worldwide#tls-cipher-suites-supported-by-office-365&preserve-view=true)
- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](/microsoft-365/compliance/prepare-tls-1.2-in-office-365?view=o365-worldwide&preserve-view=true)
- [Authentication errors when connecting to SharePoint or OneDrive from Windows 8 or 7](../../SharePointOnline/administration/authentication-errors-windows7.md).
