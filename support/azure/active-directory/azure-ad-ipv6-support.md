--- 
title: IPv6 support in Microsoft Entra ID
description: Learn about Internet Protocol version 6 (IPv6) support in Microsoft Entra ID. Review what your organization needs to do to accommodate IPv6.
ms.service: active-directory
ms.subservice: aad-general
ms.date: 05/29/2023
ms.reviewer: lhuangnorth, gautama, amycolannino, joflore, mariourrutia, v-leedennis
ms.collection: M365-identity-device-management
---
# IPv6 support in Microsoft Entra ID

[!INCLUDE [Feedback](../../includes/feedback.md)]

We're excited to bring IPv6 support to Microsoft Entra ID, to support customers with increased mobility, and help reduce spending on fast-depleting, expensive IPv4 addresses. For more information about how this change might affect Microsoft 365, see [IPv6 support in Microsoft 365 services](/microsoft-365/enterprise/ipv6-support).

If your organization's networks don't support IPv6 today, you can safely ignore this information until such time that they do.

## What's changing?

Our service endpoint URLs will now resolve to return both IPv4 and IPv6 addresses. If a client platform or network supports IPv6, the connection will mostly be attempted using IPv6, assuming that the network hops that are in between (such as firewalls or web proxies) also support IPv6. For environments that don't support IPv6, client applications will continue to connect to Microsoft Entra ID over IPv4.

The following features will also support IPv6 addresses:

- Named locations
- Conditional Access policies
- Identity Protection
- Sign-in logs

<a name='when-will-ipv6-be-supported-in-azure-ad'></a>

## When will IPv6 be supported in Microsoft Entra ID?

We'll begin introducing IPv6 support to Microsoft Entra ID in April 2023.

We know that IPv6 support is a significant change for some organizations. We're publishing this information now so that customers can make plans to ensure readiness.

## What does my organization have to do?

If you have public IPv6 addresses representing your network, take the actions that are described in the following sections as soon as possible.

**If customers don't update their named locations with these IPv6 addresses, their users will be blocked.**

:::image type="content" source="media/azure-ad-ipv6-support/cant-sign-in-blocked-location-condition.png" alt-text="Screenshot showing a user sign in blocked because of their network location.":::

### Actions to take

- [Test Microsoft Entra authentication over IPv6](#test-azure-ad-authentication-over-ipv6)
- [Find IPv6 addresses in Sign-in logs](#find-ipv6-addresses-in-sign-in-logs)
- [Create or update named locations, to include identified IPv6 addresses](/azure/active-directory/conditional-access/location-condition#ip-address-ranges)

### Named locations

Named locations are shared between many features, such as Conditional Access, Identity Protection, and B2C. Customers should partner with their network administrators and internet service providers (ISPs) to identify their public-facing IPv6 addresses. Customers should then use this list to [create or update named locations, to include their identified IPv6 addresses](/azure/active-directory/conditional-access/location-condition#ip-address-ranges).

#### Conditional Access

When configuring Conditional Access policies, organizations can choose to include or exclude locations as a condition. These named locations may include public IPv4 or IPv6 addresses, country or region, or unknown areas that don't map to specific countries or regions.

- If you add IPv6 ranges to an existing named location, used in existing Conditional Access policies, no changes are required.
- If you create new named locations for your organization's IPv6 ranges, you must update relevant Conditional Access policies with these new locations.

#### Cloud proxies and VPNs

When a cloud proxy is in place, a policy that requires a [Microsoft Entra hybrid joined or complaint device](/azure/active-directory/conditional-access/howto-conditional-access-policy-compliant-device#create-a-conditional-access-policy) can be easier to manage. Keeping a list of IP addresses used by your cloud hosted proxy or VPN solution up to date can be nearly impossible.

<a name='azure-ad-per-user-multifactor-authentication'></a>

### Microsoft Entra per-user multifactor authentication

If you're a customer who uses per-user multifactor authentication, have you added IPv4 addresses that represent on-premises trusted networks using [trusted IP addresses](/azure/active-directory/authentication/howto-mfa-mfasettings#trusted-ips) instead of named locations? If you have, you might see a multifactor authentication prompt for a request that was initiated through on-premises IPv6-enabled egress points.

Using per-user multifactor authentication isn't recommended, unless your Microsoft Entra ID licenses don't include Conditional Access and you don't want to use security defaults.

### Outbound traffic restrictions

If your organization restricts outbound network traffic to specific IP ranges, you'll have to update these addresses to include IPv6 endpoints. Administrators can find these IP ranges in the following articles:

- [Office 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges#microsoft-365-common-and-office-online)
- [Microsoft Entra Connect: Troubleshoot Microsoft Entra connectivity issues](/azure/active-directory/hybrid/tshoot-connect-connectivity#troubleshoot-connectivity-issues-in-the-installation-wizard)

For the IP ranges that are specified for Microsoft Entra ID, make sure that you allow outbound access in your proxy or firewall.

### Device configuration

By default, both IPv6 and IPv4 traffic is supported on Windows and most other operating system (OS) platforms. Changes to the standard IPv6 configuration may result in unintended consequences. For more information, see [Guidance for configuring IPv6 in Windows for advanced users](../../windows-server/networking/configure-ipv6-in-windows.md).

### Service endpoints

The implementation of IPv6 support in Microsoft Entra ID won't affect Azure Virtual Network service endpoints. Service endpoints still don't support IPv6 traffic. For more information, see [Limitations of Virtual Network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview#limitations).

<a name='test-azure-ad-authentication-over-ipv6'></a>

## Test Microsoft Entra authentication over IPv6

You can test Microsoft Entra authentication over IPv6 before we enable it worldwide by using the following procedures. These procedures help validate IPv6 range configurations. The recommended approach is to use a [Name Resolution Policy Table (NRPT)](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn593632(v=ws.11)) rule pushed to your Microsoft Entra joined Windows devices. In Windows Server, NRPT lets you implement a global or local policy that overrides DNS resolution paths. With this feature, you can redirect DNS for various fully qualified domain names (FQDNs) to special DNS servers that are configured to have IPv6 DNS entries for Microsoft Entra sign-in. It's simple to enable and disable NRPT rules by using a PowerShell script. You can use [Microsoft Intune](/mem/intune/fundamentals/what-is-intune) to push this feature to clients.

> [!NOTE]
> - Microsoft is providing these instructions for testing purposes only. You must remove the following configurations by May 2023 to ensure that your clients are using production DNS servers. The DNS servers in the following procedures may be decommissioned after May 2023.
> 
> - We recommend using the [Resolve-DnsName](/powershell/module/dnsclient/resolve-dnsname) cmdlet to validate NRPT rules. If you use the [nslookup](/windows-server/administration/windows-commands/nslookup) command, the result may be different given the differences that exist between these tools.
>
> - Make sure that you have open network connectivity on TCP and UDP port 53 between your client devices and the DNS servers that are used for the NRPT rule.

### Configure a client NRPT rule manually - public cloud

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

### Configure a client NRPT rule manually - US Gov cloud

Similar to the script for public cloud, the following script creates an NRPT rule for the US Gov sign-in endpoint `login.microsfotonline.us`.

1. Open a PowerShell console as an administrator by right-clicking the PowerShell icon and selecting **Run As Administrator**.
1. Add an NRPT rule by running the following commands:

    ```powershell
    $DnsServers = (
        "ns1-35.azure-dns.com.",
        "ns2-35.azure-dns.net.",
        "ns3-35.azure-dns.org.",
        "ns4-35.azure-dns.info."
    )
    $DnsServerIPs = $DnsServers | Foreach-Object {
        (Resolve-DnsName $_).IPAddress | Select-Object -Unique
    }
    $params = @{
        Namespace = "login.microsoftonline.us"
        NameServers = $DnsServerIPs
        DisplayName = "AZURE-AD-NRPT-USGOV"
    }
    Add-DnsClientNrptRule @params
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

## Find IPv6 addresses in Sign-in logs

Using one or more of the following methods, compare the list of IPv6 addresses to those addresses you expect. Consider adding these IPv6 addresses to your named locations and marking some as trusted where appropriate. You need at least the [Reports Reader role](/azure/active-directory/roles/permissions-reference#reports-reader) assigned in order to read the sign-in log.

### Azure portal

1. Sign in to the **Azure portal** as a Reports Reader, Security Reader, Global Reader, Security Administrator, or other role with permission.
1. Browse to **Microsoft Entra ID** > **Sign-in logs**.
1. Select **+ Add filters** > **IP address** and select **Apply**.
1. In the **Filter by IP address** box, insert a colon (**:**).
1. Optionally download this list of log entries to JSON or CSV format for further processing.

### Log Analytics

If your organization uses [Log Analytics](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics), you can query for IPv6 addresses in your logs using the following query.

```kusto
union SigninLogs, AADNonInteractiveUserSignInLogs
| where IPAddress has ":"
| summarize RequestCount = count() by IPAddress, AppDisplayName, NetworkLocationDetails
| sort by RequestCount
```

### PowerShell

Organizations can use the following PowerShell script to query the Microsoft Entra sign-in logs in [Microsoft Graph PowerShell](/powershell/microsoftgraph/authentication-commands). The script provides you with a listing of IPv6 addresses along with the application and number of times it appears.

```powershell
$tId = "TENANT ID"  # Add the Azure Active Directory tenant ID.
$agoDays = 2  # Will filter the log for $agoDays from the current date and time.
$startDate = (Get-Date).AddDays(-($agoDays)).ToString('yyyy-MM-dd')  # Get filter start date.
$pathForExport = "./"  # The path to the local filesystem for export of the CSV file. 

Connect-MgGraph -Scopes "AuditLog.Read.All" -TenantId $tId 

# Get both interactive and non-interactive IPv6 sign-ins.
$signInsInteractive = Get-MgAuditLogSignIn -Filter "contains(IPAddress, ':')" -All
$signInsNonInteractive = Get-MgAuditLogSignIn -Filter "contains(IPAddress, ':')" -All 

# Summarize IPv6 & app display name count.
$signInsInteractive |
    Group-Object IPaddress, AppDisplayName |
    Select-Object @{Name = 'IPaddress'; Expression = {$_.Group[0].IPaddress}},
        @{Name = 'AppDisplayName'; Expression = {$_.Group[0].AppDisplayName}},
        Count |
    Sort-Object -Property Count –Descending |
    Export-Csv -Path ($pathForExport + "Summary_Interactive_IPv6_$tId.csv") -NoTypeInformation
$signInsNonInteractive |
    Group-Object IPaddress, AppDisplayName |
    Select-Object @{Name = 'IPaddress'; Expression = {$_.Group[0].IPaddress}},
        @{Name = 'AppDisplayName'; Expression = {$_.Group[0].AppDisplayName}},
        Count |
    Sort-Object -Property Count –Descending |
    Export-Csv -Path ($pathForExport + "Summary_NonInteractive_IPv6_$tId.csv") -NoTypeInformation
```

## Next steps

We'll keep this article updated. Here's a short link you can use to come back for updated and new information: <https://aka.ms/azureadipv6>.

- [Use the location condition in a Conditional Access policy](/azure/active-directory/conditional-access/location-condition)
- [Conditional Access: Block access by location](/azure/active-directory/conditional-access/howto-conditional-access-policy-location)
- [Find help and get support for Microsoft Entra ID](/azure/active-directory/fundamentals/how-to-get-support)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
