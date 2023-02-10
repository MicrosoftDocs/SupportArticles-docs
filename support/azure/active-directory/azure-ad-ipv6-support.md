--- 
title: IPv6 support in Azure Active Directory (Azure AD)
description: Learn about Internet Protocol version 6 (IPv6) support in Azure Active Directory (Azure AD). Review what your organization needs to do to accommodate IPv6.
ms.service: active-directory
ms.subservice: aad-general
ms.date: 02/01/2023
ms.author: v-dele
author: DennisLee-DennisLee
ms.reviewer: lhuangnorth, gautama, amycolannino, joflore, mariourrutia
ms.collection: M365-identity-device-management
---
# IPv6 support in Azure Active Directory

We're excited to bring IPv6 support to Azure Active Directory (Azure AD), to support customers with increased mobility, and help reduce spending on fast-depleting, expensive IPv4 addresses. For more information about how this change might affect Microsoft 365, see [IPv6 support in Microsoft 365 services](/microsoft-365/enterprise/ipv6-support).

If your organization's networks don't support IPv6 today, you can safely ignore this information until such time that they do.

## What's changing? 

Our service endpoint URLs will now resolve to return both IPv4 and IPv6 addresses. If a client platform or network supports IPv6, the connection will mostly be attempted using IPv6, assuming that the network hops that are in between (such as firewalls or web proxies) also support IPv6. For environments that don't support IPv6, client applications will continue to connect to Azure AD over IPv4. 

The following features will also support IPv6 addresses:

- Named locations
- Conditional Access policies
- Identity Protection
- Sign-in logs

## When will IPv6 be supported in Azure AD?

We'll begin introducing IPv6 support to Azure AD in late March 2023.

We know that IPv6 support is a significant change for some organizations. We're publishing this information now so that customers can make plans to ensure readiness.

## What does my organization have to do?

If you have public IPv6 addresses representing your network, take the actions that are described in the following sections as soon as possible.

> For example:  
> 
> Some organizations have a Conditional Access policy that blocks access to specific applications from outside a trusted named location that represents their public network addresses. This named location contains the IPv4 addresses that are owned by the customer, but it might not include the public IPv6 addresses that represent the customer network.
> 
> **If customers don't update their named locations with these IPv6 addresses, their users will be blocked.**

### Named locations

Named locations are shared between many features, such as Conditional Access, Identity Protection, and B2C. Customers should partner with their network administrators and internet service providers (ISPs) to identify their public-facing IPv6 addresses. Customers should then use this list to [create or update named locations, to include their identified IPv6 addresses](/azure/active-directory/conditional-access/location-condition#ip-address-ranges). 

### Azure AD per-user multifactor authentication

If you're a customer who uses per-user multifactor authentication, have you added IPv4 addresses that represent on-premises trusted networks using [trusted IP addresses](/azure/active-directory/authentication/howto-mfa-mfasettings#trusted-ips) instead of named locations? If you have, you might see a multifactor authentication prompt for a request that was initiated through on-premises IPv6-enabled egress points.

Using per-user multifactor authentication isn't recommended, unless your Azure AD licenses don't include Conditional Access and you don't want to use security defaults.

### Outbound traffic restrictions

If your organization restricts outbound network traffic to specific IP ranges, you'll have to update these addresses to include IPv6 endpoints. Administrators can find these IP ranges in the following articles:

- [Office 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges#microsoft-365-common-and-office-online)
- [Azure AD Connect: Troubleshoot Azure AD connectivity issues](/azure/active-directory/hybrid/tshoot-connect-connectivity#troubleshoot-connectivity-issues-in-the-installation-wizard)

For the IP ranges that are specified for Azure AD, make sure that you allow outbound access in your proxy or firewall.

### Device configuration

By default, both IPv6 and IPv4 traffic is supported on Windows and most other operating system (OS) platforms. Changes to the standard IPv6 configuration may result in unintended consequences. For more information, see [Guidance for configuring IPv6 in Windows for advanced users](/troubleshoot/windows-server/networking/configure-ipv6-in-windows).

## How to find the IPv6 address used to sign-in to Azure AD
To help admins find the IPv6 addresses used to sign-in to Azure AD, either during proactive testing 
[Name Resolution Policy Table (NRPT)](https://learn.microsoft.com/en-us/troubleshoot/azure/active-directory/azure-ad-ipv6-support#test-azure-ad-authentication-over-ipv6) mentioned above OR post the IPv6 enablement in March 2023, use the methods below. Finding the top IPv6 addresses that are owned and managed by the organization will help you add the same under ‘Named location”.

### Methods to get the list of IPv6 addresses from Sign-in logs:

   #### Filtering Azure AD Sign-in logs
   - In the Azure portal, search for and select Azure Active Directory.
   - In the Overview page menu, select Sign-in logs.
   - Click on +Add filters and select IP Address
   - In the filter “IP address contains” insert a colon **“:”** (without quotes)
   - Select the Location tab to check more IP Address and Named Locations.
            - Add new Named Location and Mark as trusted if necessary.
   - Click on Download to export the logs in CSV or JSON formats. 
 
   #### Log Analytics (in Azure Monitor)
 
   You can query the Azure AD Interactive and Non-Interactive sign-in logs using Azure Monitor. 

   Azure Monitor is a powerful log analysis, monitoring, and alerting tool. Use Azure Monitor for:
   -	Azure AD logs
   -	Azure resources logs
   -	Logs from independent software tools

   Note
   You need an Azure AD Premium license to export reporting data to Azure Monitor.

   To query for legacy TLS entries using Azure Monitor:

   •	In Integrate Azure AD logs with Azure Monitor logs, follow the instructions for how to access the Azure AD sign-in logs in Azure Monitor.

   •	In the query definition area, paste the following Kusto Query Language query:
 

        union SigninLogs, AADNonInteractiveUserSignInLogs
        | where IPAddress has ":"
        | summarize RequestCount = count() by IPAddress, AppDisplayName, NetworkLocationDetails
        | sort by RequestCount

   •	Select Run to execute the query. The log entries that match the query appear in the Results tab below the query definition.

   #### Exporting logs through PowerShell
    
        $tId = "TENANT ID"  # Add tenant ID from Azure Active Directory page on portal.
        $agoDays = 2  # Will filter the log for $agoDays from the current date and time.
        $startDate = (Get-Date).AddDays(-($agoDays)).ToString('yyyy-MM-dd')  # Get filter start date.
        $pathForExport = "./"  # The path to the local filesystem for export of the CSV file. Connect-MgGraph -Scopes "AuditLog.Read.All" -TenantId $tId  # Or use Directory.Read.All. 
        # Get the interactive and non-interactive IPv6 sign-ins .
        $signInsInteractive = Get-MgAuditLogSignIn -Filter "contains(IPAddress, ':')" -All
        $signInsNonInteractive = Get-MgAuditLogSignIn -Filter "contains(IPAddress, ':')" -All $columnList = @{  # Enumerate the list of properties to be exported to the CSV files.
            Property = "createdDateTime","CorrelationId", "userPrincipalName", "userId",
                      "UserDisplayName", "AppDisplayName", "AppId", "IPAddress", "isInteractive",
                      "ResourceDisplayName", "ResourceId"
        } # Summary IPv6 & App Display Name count
        $signInsInteractive | Group-Object IPaddress, AppDisplayName | Select-Object @{Name='IPaddress';Expression={$_.Group[0].IPaddress}}, 
            @{Name ='AppDisplayName';Expression={$_.Group[0].AppDisplayName}}, Count | Sort-Object -Property Count –Descending | Export-Csv -Path ($pathForExport + "Summary_Interactive_IPv6_$tId.csv") -NoTypeInformation
        $signInsNonInteractive | Group-Object IPaddress, AppDisplayName | Select-Object @{Name='IPaddress';Expression={$_.Group[0].IPaddress}}, 
            @{Name ='AppDisplayName';Expression={$_.Group[0].AppDisplayName}}, Count | Sort-Object -Property Count –Descendin | Export-Csv -Path ($pathForExport + "Summary_NonInteractive_IPv6_$tId.csv") -NoTypeInformation #Detailed IPv6 Sign-ins
        #$signInsInteractive  | Select-Object @columnList | Export-Csv -Path ($pathForExport + "Detailed_Interactive_IPv6_$tId.csv") -NoTypeInformation
        #$signInsNonInteractive  | Select-Object @columnList | Export-Csv -Path ($pathForExport + "Detailed_NonInteractive_IPv6_$tId.csv") -NoTypeInformation


## Test Azure AD authentication over IPv6

You can test Azure AD authentication over IPv6 before we enable it worldwide in late March 2023. This procedure helps validate IPv6 range configurations. The recommended approach is to use a [Name Resolution Policy Table (NRPT)](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn593632(v=ws.11)) rule pushed to your Azure AD-joined Windows devices. In Windows Server, NRPT lets you implement a global or local policy that overrides DNS resolution paths. With this feature, you can redirect DNS for various fully qualified domain names (FQDNs) to special DNS servers that are configured to have IPv6 DNS entries for Azure AD sign-in. It's simple to enable and disable NRPT rules by using a PowerShell script. You can use [Microsoft Intune](/mem/intune/fundamentals/what-is-intune) to push this feature to clients.

> [!NOTE]
> Microsoft is providing these instructions for testing purposes only. You must remove the following configurations by May 2023 to ensure that your clients are using production DNS servers. The DNS servers in the following procedures may be decommissioned after May 2023.

### Configure a client NRPT rule manually

1. Open a PowerShell console as an administrator (right-click the PowerShell icon and select **Run As Administrator**).
1. Add an NRPT rule by running the following commands:

    ```powershell
    $DnsServers = (
        "ns1-37.azure-dns.com.",
        "ns2-37.azure-dns.net.",
        "ns3-37.azure-dns.org.",
        "ns4-37.azure-dns.info."
    )
    $DnsServerIPs = $DnsServers | Foreach-Object {
        (Resolve-DnsName $_).IPAddress | Select-Object -Unique
    }
    $params = @{
        Namespace = "login.microsoftonline.com"
        NameServers = $DnsServerIPs
        DisplayName = "AZURE-AD-NRPT"
    }
    Add-DnsClientNrptRule @params
    ```

1. Verify that your client gets IPv6 responses for `login.microsoftonline.com` by running the [Resolve-DnsName](/powershell/module/dnsclient/resolve-dnsname) cmdlet. The command output should resemble the following text:

    ```console
    PS C:\users\username> Resolve-DnsName login.microsoftonline.com
    Name                          Type   TTL   Section    IPAddress 
    ----                          ----   ---   -------    --------- 
    login.microsoftonline.com     AAAA   300   Answer     2603:1037:1:c8::8 
    login.microsoftonline.com     AAAA   300   Answer     2603:1036:3000:d8::5 
    login.microsoftonline.com     AAAA   300   Answer     2603:1036:3000:d0::5 
    login.microsoftonline.com     AAAA   300   Answer     2603:1036:3000:d8::4 
    login.microsoftonline.com     AAAA   300   Answer     2603:1037:1:c8::9 
    login.microsoftonline.com     AAAA   300   Answer     2603:1037:1:c8::a 
    login.microsoftonline.com     AAAA   300   Answer     2603:1036:3000:d8::2 
    login.microsoftonline.com     AAAA   300   Answer     2603:1036:3000:d0::7 
    login.microsoftonline.com     A      300   Answer     20.190.151.7 
    login.microsoftonline.com     A      300   Answer     20.190.151.67 
    login.microsoftonline.com     A      300   Answer     20.190.151.69 
    login.microsoftonline.com     A      300   Answer     20.190.151.68 
    login.microsoftonline.com     A      300   Answer     20.190.151.132 
    login.microsoftonline.com     A      300   Answer     20.190.151.70 
    login.microsoftonline.com     A      300   Answer     20.190.151.9 
    login.microsoftonline.com     A      300   Answer     20.190.151.133 
    ```

1. If you want to remove the NRPT rule, run this PowerShell script: 

    ```powershell
    Get-DnsClientNrptRule | Where-Object {
        $_.DisplayName -match "AZURE-AD-NRPT" -or $_.Namespace -match "login.microsoftonline.com"
    } | Remove-DnsClientNrptRule -Force
    ```

### Deploy NRPT rule with Intune 

To deploy the NRPT rule to multiple machines by using Intune, create a Win32 app and assign it to one or more devices. 

#### Step 1: Create the scripts

Create a folder, and then save the following installation and rollback scripts (*InstallScript.ps1* and *RollbackScript.ps1*) in it so that you can create the *.intunewin* file for use in the deployment.

##### InstallScript.ps1

```powershell
# Add Azure AD NRPT rule.
$DnsServers = (
    "ns1-37.azure-dns.com.",
    "ns2-37.azure-dns.net.",
    "ns3-37.azure-dns.org.",
    "ns4-37.azure-dns.info."
)
$DnsServerIPs = $DnsServers | Foreach-Object {
    (Resolve-DnsName $_).IPAddress | Select-Object -Unique
}

# List the rules.
$existingRules = Get-DnsClientNrptRule | Where-Object {
    $_.DisplayName -match "AZURE-AD-NRPT" -or $_.Namespace -match "login.microsoftonline.com"
}
if ($existingRules) { 
    Write-Output ("Azure AD NRPT rule exists: {0}" -F $existingRules) 
} 
else { 
    Write-Output "Adding Azure AD NRPT DNS rule for login.microsoftonline.com ..." 
    $params = @{
        Namespace = "login.microsoftonline.com"
        NameServers = $DnsServerIPs
        DisplayName = "AZURE-AD-NRPT"
    }
    Add-DnsClientNrptRule @params
}  
```

##### RollbackScript.ps1

```powershell
# Remove the Azure AD NRPT rule.
# List the rules.
$existingRules = Get-DnsClientNrptRule | Where-Object {
    $_.DisplayName -match "AZURE-AD-NRPT" -or $_.Namespace -match "login.microsoftonline.com"
}
if ($existingRules) { 
    Write-Output "Removing Azure AD NRPT DNS rule for login.microsoftonline.com ..." 
    $existingRules | Format-Table 
    $existingRules | Remove-DnsClientNrptRule -Force 
} 
else { 
    Write-Output "Azure AD NRPT rule does not exist. Device was successfully remediated."
}
```

##### DetectionScript.ps1

Save the following script (*DetectionScript.ps1*) in another location. Then, you can reference the detection script in the application when you create it in Intune.

```powershell
# Add Azure AD NRPT rule.
$DnsServers = (
    "ns1-37.azure-dns.com.",
    "ns2-37.azure-dns.net.",
    "ns3-37.azure-dns.org.",
    "ns4-37.azure-dns.info."
)
$DnsServerIPs = $DnsServers | Foreach-Object {
    (Resolve-DnsName $_).IPAddress | Select-Object -Unique
}
# List the rules.
$existingRules = Get-DnsClientNrptRule | Where-Object {
    $_.DisplayName -match "AZURE-AD-NRPT" -or $_.Namespace -match "login.microsoftonline.com"
}
if ($existingRules) { 
    Write-Output 'Compliant' 
}  
```

#### Step 2: Package the scripts as a .intunewin file

See [Prepare Win32 app content for upload](/mem/intune/apps/apps-win32-prepare) to create a *.intunewin* file from the folder and scripts that you previously saved.

#### Step 3: Create the Win32 application 

The following instructions show you how to create the necessary Win32 application. For more information, see [Add, assign, and monitor a Win32 app in Microsoft Intune](/mem/intune/apps/apps-win32-add).

1. Sign in to the [Intune portal](https://endpoint.microsoft.com).
1. Select **Apps** > **All Apps**, and then select **+ Add** to create a new Win32 app.
1. In the **App type** dropdown list, select **Windows app (Win32)**, and then choose **Select**.
1. On the **App information** page, click **Select app package file** to select the *.intunewin* file that you previously created. Select **OK** to continue.
1. Return to the **App information** page, and then enter a descriptive **Name**, **Description**, and **Publisher** for the application. Other fields are optional. Select **Next** to continue.
1. On the **Program** page, enter following information and select **Next**.

   - **Install command** string:  
     `powershell.exe -executionpolicy bypass -NoLogo -NoProfile -NonInteractive -WindowStyle Hidden -file "InstallScript.ps1"`
   - **Uninstall command** string:  
     `powershell.exe -executionpolicy bypass -NoLogo -NoProfile -NonInteractive -WindowStyle Hidden -file "RollbackScript.ps1"`
   - **Install behavior**:  
     `System`

1. In the **Requirement** page, select both **Operating system architectures** and set **Minimum Operating system** to **Windows 10 1607**. Select **Next** to continue.
1. On the **Detection** page, select **Use a custom detection script** from the **Rules format** dropdown list. Select the browse button beside the **Script file** box to choose the detection script. Leave the remaining fields as their default values. Select **Next** to continue.
1. Select **Next** on the **Dependencies** page to continue without any changes.  
1. Select **Next** on the **Supersedence (preview)** page to continue without any changes. 
1. On the **Assignments** page, create assignments based on your requirements, and then select **Next** to continue.  
1. Review the information one final time on the **Review + create** page. Once you finish your validation, select **Create** to create the application.  

## Next steps

We'll keep this article updated. Here's a short link you can use to come back for updated and new information: <https://aka.ms/azureadipv6>.

- [Use the location condition in a Conditional Access policy](/azure/active-directory/conditional-access/location-condition)
- [Conditional Access: Block access by location](/azure/active-directory/conditional-access/howto-conditional-access-policy-location)
- [Find help and get support for Azure Active Directory](/azure/active-directory/fundamentals/how-to-get-support)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)] 
