--- 
title: IPv6 Support in Azure AD
description: Bringing IPv6 support to Azure Active Directory
ms.service: active-directory
ms.subservice: aad-general
ms.date: 11/22/2022
ms.author: v-dele
author: DennisLee-DennisLee
ms.reviewer: lhuangnorth, gautama, amycolannino, joflore
ms.collection: M365-identity-device-management
---

# IPv6 Support in Azure Active Directory

We're excited to bring IPv6 support to Azure Active Directory (Azure AD), to support customers with increased mobility, and help reduce spending on fast-depleting, expensive IPv4 addresses. For more information about how this change might affect Microsoft 365, see [IPv6 support in Microsoft 365 services](/microsoft-365/enterprise/ipv6-support).

If your organization's networks don't support IPv6 today, you can safely ignore this information until such time that they do.

## When will IPv6 be supported in Azure AD?

We'll begin introducing IPv6 support to Azure AD in late March 2023.

We know that IPv6 support is a significant change for some organizations. We're publishing this information now so that customers can make plans to ensure readiness.

## Support

If you have questions about this change or need help, we invite you to create a support request, or ask Azure community support.

## What does my organization have to do?

As Microsoft plans the rollout of IPv6 into Azure AD, we want to share changes that you might notice. These changes include some advantages and some changes you must make.

Customers who use Conditional Access location-based policies to restrict and secure access to their apps from specific networks have to:

- Identify egress IPv6 addresses in use in your organization
- [Create or update named locations, to include their identified IPv6 addresses](/azure/active-directory/conditional-access/location-condition#ip-address-ranges)

Customers who have invested in Azure AD Identity Protection, using user and sign-in risk policies, will automatically benefit from the introduction of IPv6 to Azure AD.

### Azure AD B2C

Customers who [add Conditional Access to user flows in Azure Active Directory B2C](/azure/active-directory-b2c/conditional-access-user-flow?pivots=b2c-user-flow#add-a-conditional-access-policy) can follow the same process to [create or update named locations to include their identified IPv6 addresses](/azure/active-directory/conditional-access/location-condition#ip-address-ranges).

## Next steps

We'll keep this article updated. Here's a short link you can use to come back for updated and new information: [https://aka.ms/azureadipv6](https://aka.ms/azureadipv6).

- [Using the location condition in a Conditional Access policy](/azure/active-directory/conditional-access/location-condition)
- [Conditional Access: Block access by location](/azure/active-directory/conditional-access/howto-conditional-access-policy-location)
- [Find help and get support for Azure Active Directory](/azure/active-directory/fundamentals/how-to-get-support)

## How customers can test Azure AD Authentication over IPv6 prior to the production rollout

Customers can test Azure AD Authentication over IPv6 prior to when we enable it world-wide in late March of 2023. This will facilitate validation of Conditional Access and Identity Protection IPv6 range configurations. The recommended approach is to use a Name Resolution Policy Table (NRPT) rule pushed to your Azure AD joined Windows devices. NRPT is a feature of Windows that allows a global or local policy to be implemented which overrides DNS resolution paths. You can use this feature to redirect DNS for various fully qualified domain names to special DNS Name Servers that are configured to have IPv6 DNS entries for Azure AD login. It is simple to enable and disable using PowerShell script and can be pushed to clients by Microsoft Intune.

Microsoft is providing these instructions for testing purposes only. The configurations below must be removed after May 2023 to ensure your clients are using production DNS servers. The DNS servers in the following procedures may be decommissioned after May 2023.

### Procedure to configure client NRPT rule manually 
1. Launch PowerShell as Administrator (Right click and "Run As Administrator")
2. Add NRPT rule using the following commands:

```
$DnsServers = "ns1-37.azure-dns.com.","ns2-37.azure-dns.net.","ns3-37.azure-dns.org.","ns4-37.azure-dns.info." 
$DnsServerIPs = $DnsServers | Foreach-Object { (Resolve-DnsName $_).IPAddress | Select-Object -Unique } 
Add-DnsClientNrptRule -DisplayName "AAD-NRPT" -NameServers $DnsServerIPs -Namespace login.microsoftonline.com 
```
3. Verify that your client gets IPv6 responses for login.microsoftonline.com. It should look similar to this:

```
PS C:\users\username> resolve-dnsname login.microsoftonline.com

Name                                           Type   TTL   Section    IPAddress 
----                                           ----   ---   -------    --------- 
login.microsoftonline.com                      AAAA   300   Answer     2603:1037:1:c8::8 
login.microsoftonline.com                      AAAA   300   Answer     2603:1036:3000:d8::5 
login.microsoftonline.com                      AAAA   300   Answer     2603:1036:3000:d0::5 
login.microsoftonline.com                      AAAA   300   Answer     2603:1036:3000:d8::4 
login.microsoftonline.com                      AAAA   300   Answer     2603:1037:1:c8::9 
login.microsoftonline.com                      AAAA   300   Answer     2603:1037:1:c8::a 
login.microsoftonline.com                      AAAA   300   Answer     2603:1036:3000:d8::2 
login.microsoftonline.com                      AAAA   300   Answer     2603:1036:3000:d0::7 
login.microsoftonline.com                      A      300   Answer     20.190.151.7 
login.microsoftonline.com                      A      300   Answer     20.190.151.67 
login.microsoftonline.com                      A      300   Answer     20.190.151.69 
login.microsoftonline.com                      A      300   Answer     20.190.151.68 
login.microsoftonline.com                      A      300   Answer     20.190.151.132 
login.microsoftonline.com                      A      300   Answer     20.190.151.70 
login.microsoftonline.com                      A      300   Answer     20.190.151.9 
login.microsoftonline.com                      A      300   Answer     20.190.151.133 
```
4. If you want to remove the NRPT rule, run this PowerShell script: 

```
Get-DnsClientNrptRule | Where-Object { $_.DisplayName -match "AAD-NRPT" -or $_.Namespace -match "login.microsoftonline.com" } | Remove-DnsClientNrptRule -Force
```
### Procedure to roll out NRPT rule via Intune 
We can deploy the NRPT rule in Intune by creating a Win32 app. Steps to create the app:
1. Prepare the intunewin file. 
2. Create the app. 
3. Create assignment.  

#### Prepare the intunewin file 
Follow the below URL on how to prepare the intunewin file for provisioning a Win32 file.  
[Prepare a Win32 app to be uploaded to Microsoft Intune | Microsoft Learn](https://learn.microsoft.com/en-us/mem/intune/apps/apps-win32-prepare)

#### Create the Win32 application
1. Open MEM portal aka Intune using https://endpoint.microsoft.com 

2. Click on **Apps > All Apps** and then click on **+ Add** button to create a new Win32 app.

3. Select **Windows app (win32)** from **App type** drop down and click on **Select**.

![image](https://user-images.githubusercontent.com/123704787/214983920-1aeedf74-3f8a-4658-a178-5800523b4412.png)

4. In the App information page, click on **Select app package file** to select the intunewin file created in the earlier section. Click **OK** to continue.

![image](https://user-images.githubusercontent.com/123704787/214984383-355353cd-033e-4e4b-b5d4-a1d3f9ac2ce1.png)

5. Back in the App information page, enter the Name, Description and Publisher information for the Application. Remaining other fields are optional. Click on **Next** to continue.

![image](https://user-images.githubusercontent.com/123704787/214984675-240981a3-6e18-4d7d-9d25-ce2060278e39.png)

6. In the **Program** page, enter following information and click **Next**.
 - Install command line: powershell.exe -executionpolicy bypass -NoLogo -NoProfile -NonInteractive -WindowStyle Hidden -file "InstallScript.ps1"
 - Uninstall command line: powershell.exe -executionpolicy bypass -NoLogo -NoProfile -NonInteractive -WindowStyle Hidden -file "RollbackScript.ps1"
 - Install behavior: System

![image](https://user-images.githubusercontent.com/123704787/214986069-f7c735d5-c2b6-433c-b0d1-758ce8db954a.png)

7. In the **Requirement** page, select both Operating system architecture and Minimum Operating system to **Windows 10 1607**. Click **Next** to continue.

![image](https://user-images.githubusercontent.com/123704787/214986465-bb65442c-d4b0-4fa4-9763-36a08e35d039.png)

8. In the **Detection** page, select **Use a custom detection script** from Rules format drop down. Click on the browse button beside the Script file box to select the detection script. Leave remaining fields as default. Click **Next** to continue.

![image](https://user-images.githubusercontent.com/123704787/214986799-ba3bc71e-8644-46d0-a3c2-3187e80beff5.png)

9. Click Next on the **Dependencies** page to continue without any changes. 

10. Click Next on **Supersedence (preview)** page to continue without any changes.

11. In the **Assignments** page, create assignment as per your requirement and client Next to continue. 

12. Review the information one final time in the **Review + create** page. Once you finish your validation, click on create button to create the application. 

#### Installation/uninstallation and detection script 

We need the below files for creating the Win32 app in Intune. 
- **InstallScript.ps1** for installing the NRPT rule.
- **RollbackScript.ps1** for uninstalling the change. 
- **DetectionScript.ps1** for detecting the installation. 

Content for the **InstallScript.ps1**:
```
# Add AAD NRPT Rule
$DnsServers = "ns1-37.azure-dns.com.", "ns2-37.azure-dns.net.", "ns3-37.azure-dns.org.", "ns4-37.azure-dns.info."
$DnsServerIPs = $DnsServers | Foreach-Object { (Resolve-DnsName $_).IPAddress | Select-Object -Unique }
# List rules
$existingRules = Get-DnsClientNrptRule | Where-Object { $_.DisplayName -match "AAD-NRPT" -or $_.Namespace -match "login.microsoftonline.com" }
if ($existingRules) {
    Write-Output ("AAD Nrpt rule exists: {0}" -F $existingRules)
}
else {
    Write-Output "Adding AAD NRPT Dns rule for login.microsoftonline.com ..."
    Add-DnsClientNrptRule -DisplayName "AAD-NRPT" -NameServers $DnsServerIPs -Namespace login.microsoftonline.com
} 
```

Content for the **RollbackScript.ps1**:
```
# Remove AAD NRPT Rule
# List rules
$existingRules = Get-DnsClientNrptRule | Where-Object { $_.DisplayName -match "AAD-NRPT" -or $_.Namespace -match "login.microsoftonline.com" }
if ($existingRules) {
    Write-Output "Removing AAD NRPT Dns rule for login.microsoftonline.com ..."
    $existingRules | Format-Table
    $existingRules | Remove-DnsClientNrptRule -Force
 }
else {
    Write-Output "AAD NRPT rule does not exist. Device was successfully remediated."
} 
```

Content for the **DetectionScript.ps1**:
```
# Add AAD NRPT Rule
$DnsServers = "ns1-37.azure-dns.com.", "ns2-37.azure-dns.net.", "ns3-37.azure-dns.org.", "ns4-37.azure-dns.info."
$DnsServerIPs = $DnsServers | Foreach-Object { (Resolve-DnsName $_).IPAddress | Select-Object -Unique }
# List rules
$existingRules = Get-DnsClientNrptRule | Where-Object { $_.DisplayName -match "AAD-NRPT" -or $_.Namespace -match "login.microsoftonline.com" }
if ($existingRules) {
    Write-Output 'Compliant'
 } 
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)] 

