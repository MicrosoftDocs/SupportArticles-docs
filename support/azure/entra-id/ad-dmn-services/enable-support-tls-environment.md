---

title: Enable TLS 1.2 support as Microsoft Entra TLS 1.0/1.1 is deprecated
description: This article describes how to enable support for TLS 1.2 in your environment, in preparation for upcoming Microsoft Entra TLS 1.0/1.1 deprecation.
ms.date: 02/29/2024
ms.reviewer: dahans, abizerh, v-leedennis, v-weizhu
ms.service: active-directory
ms.subservice: authentication
ms.custom: has-azure-ad-ps-ref
---
# Enable support for TLS 1.2 in your environment for Microsoft Entra TLS 1.1 and 1.0 deprecation

To improve the security posture of your tenant, and to remain in compliance with industry standards, Microsoft Entra ID will soon stop supporting the following Transport Layer Security (TLS) protocols and ciphers:

- TLS 1.1
- TLS 1.0
- 3DES cipher suite **(TLS_RSA_WITH_3DES_EDE_CBC_SHA)**

## How this change might affect your organization

Do your applications communicate with or authenticate against Microsoft Entra ID? Then those applications might not work as expected if they can't use TLS 1.2 to communicate. This situation includes:

- Microsoft Entra Connect
- Microsoft Graph PowerShell
- Microsoft Entra application proxy connectors
- PTA agents
- Legacy browsers
- Applications that are integrated with Microsoft Entra ID

## Why this change is being made

These protocols and ciphers are being deprecated for the following reasons:

- To follow the latest compliance standards for the [Federal Risk and Authorization Management Program (FedRAMP)](https://www.fedramp.gov/).
- To improve security when users interact with our cloud services.

The **TLS 1.0**, **TLS 1.1**, and **3DES Cipher suite** services are being deprecated on the following schedule.

| Instance type                                    | Deprecation date | Status        |
|--------------------------------------------------|------------------|---------------|
| U.S. government instances                        | March 31, 2021   | **COMPLETED** |
| Public instances                                 | January 31, 2022 | **COMPLETED** |
| Microsoft Entra instances operated by 21Vianet in China | June 2023        | **ONGOING**   |

## TLS 1.3 support for Microsoft Entra services

In addition to supporting TLS 1.2, Microsoft Entra is also rolling out support for TLS 1.3 for its endpoints to align with security best practices ([NIST - SP 800-52 Rev. 2](https://csrc.nist.gov/pubs/sp/800/52/r2/final)). With this change, Microsoft Entra endpoints will support both TLS 1.2 and TLS 1.3 protocols.

## Enable support for TLS 1.2 in your environment

To ensure a secure connection to Microsoft Entra ID and Microsoft 365 services, configure your client apps and both the client and server operating systems (OS) to support TLS 1.2 and contemporary cipher suites.

### Guidelines for enabling TLS 1.2 on clients

- Update Windows and the default TLS that you use for "WinHTTP".
- Identify and reduce you dependency on the client apps and operating systems that don't support TLS 1.2.
- Enable TLS 1.2 for applications and services that communicate with Microsoft Entra ID.
- Update and configure your .NET Framework installation to support TLS 1.2.
- Make sure that applications and PowerShell (that use [Microsoft Graph](https://graph.microsoft.com) and [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview)) scripts are hosted and run on a platform that supports TLS 1.2.
- Make sure that your web browser has the latest updates. We recommend that you use the new Microsoft Edge browser (based on Chromium). For more information, see the [Microsoft Edge release notes for Stable Channel](/deployedge/microsoft-edge-relnote-stable-channel).
- Make sure that your web proxy supports TLS 1.2. For more information about how to update a web proxy, check with the vendor of your web proxy solution.

For more information, see the following articles:

- [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC - Microsoft 365 Compliance](/purview/prepare-tls-1.2-in-office-365)

### Update the Windows OS and the default TLS that you use for WinHTTP

These operating systems natively support TLS 1.2 for client-server communications over WinHTTP:

- Windows 8.1, Windows 10, and later versions
- Windows Server 2012 R2, Windows Server 2016, and later versions

Verify that you haven't explicitly disabled TLS 1.2 on these platforms.

By default, earlier versions of Windows (such as Windows 8 and Windows Server 2012) don't enable TLS 1.2 or TLS 1.1 for secure communications by using WinHTTP. For these earlier versions of Windows:

1. Install [Update 3140245](https://support.microsoft.com/help/3140245).
1. Enable the registry values from the [Enable TLS 1.2 on client or server operating systems](#enable-tls-12-on-client-or-server-operating-systems-) section.

You can configure those values to add TLS 1.2 and TLS 1.1 to the default secure protocols list for WinHTTP.

For more information, see [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client).

> [!NOTE]
> By default, an OS that supports TLS 1.2 (for example, Windows 10) also supports legacy versions of the TLS protocol. When a connection is made by using TLS 1.2 and it doesn't get a timely response, or when the connection is reset, the OS might try to connect to the target web service by using an older TLS protocol (such as TLS 1.0 or 1.1). This usually occurs if the network is busy, or if a packet drops in the network. After the temporary fallback to the legacy TLS, the OS will try again to make a TLS 1.2 connection.
>
> What will be the status of such fallback traffic after Microsoft stops supporting the legacy TLS? The OS might still try to make a TLS connection by using the legacy TLS protocol. But if the Microsoft service is no longer supporting the older TLS protocol, the legacy TLS-based connection won't succeed. This will force the OS to try the connection again by using TLS 1.2 instead.

### Identify and reduce dependency on clients that don't support TLS 1.2

Update the following clients to provide uninterrupted access:

- Android version 4.3 and earlier versions
- Firefox version 5.0 and earlier versions
- Internet Explorer versions 8-10 on Windows 7 and earlier versions
- Internet Explorer 10 on Windows Phone 8.0
- Safari 6.0.4 on OS X 10.8.4 and earlier versions

For more information, see [Handshake Simulation for various clients connecting to www.microsoft.com, courtesy SSLLabs.com](/security/engineering/solving-tls1-problem#appendix-a-handshake-simulation).

<a name='enable-tls-12-on-common-server-roles-that-communicate-with-azure-ad'></a>

### Enable TLS 1.2 on common server roles that communicate with Microsoft Entra ID

- Microsoft Entra Connect (install the latest version)
  - Do you also want to enable TLS 1.2 between the sync engine server and a remote SQL Server? Then make sure you have the required versions installed for [TLS 1.2 support for Microsoft SQL Server](https://support.microsoft.com/topic/kb3135244-tls-1-2-support-for-microsoft-sql-server-e4472ef8-90a9-13c1-e4d8-44aad198cdbe).
- Microsoft Entra Connect Authentication Agent (pass-through authentication) (version 1.5.643.0 and later versions)
- Azure Application Proxy (version 1.5.1526.0 and later versions enforce TLS 1.2)
- Active Directory Federation Services (AD FS) for servers that are configured to use Azure multifactor authentication (Azure MFA)
- NPS servers that are configured to use the NPS extension for Microsoft Entra multifactor authentication
- MFA Server version 8.0._x_ or later versions
- Microsoft Entra Password Protection proxy service

  **Action required**

  1. We highly recommend that you run the latest version of the agent, service, or connector.
  2. By default, TLS 1.2 is enabled on Windows Server 2012 R2 and later versions. In rare instances, the default OS configuration might have been modified to disable TLS 1.

      To make sure that TLS 1.2 is enabled, we recommend that you explicitly add the registry values from the [Enable TLS 1.2 on client or server operating systems](#enable-tls-12-on-client-or-server-operating-systems-) section on servers that are running Windows Server and that communicate with Microsoft Entra ID.

  3. Most of the previously listed services are dependent on .NET Framework. Make sure it's updated as described in the [Update and configure .NET Framework to support TLS 1.2](#update-and-configure-net-framework-to-support-tls-12-) section.

  For more information, see the following articles:
  - [TLS 1.2 enforcement - Enforce TLS 1.2 for the Microsoft Entra Registration Service](/azure/active-directory/devices/reference-device-registration-tls-1-2)
  - [Microsoft Entra Connect: TLS 1.2 enforcement for Microsoft Entra Connect](/azure/active-directory/hybrid/reference-connect-tls-enforcement)
  - [Understand Microsoft Entra application proxy connectors](/azure/active-directory/manage-apps/application-proxy-connectors#requirements-and-deployment)

## Enable TLS 1.2 on client or server operating systems <a name="enable-tls-12"></a>

### Registry strings

For Windows 2012 R2, Windows 8.1, and later operating systems, TLS 1.2 is enabled by default. Thus, the following registry values aren't displayed unless they were set with different values.

To manually configure and enable TLS 1.2 at the operating system level, you can add the following DWORD values:

- **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client**
  - `DisabledByDefault`: **00000000**
  - `Enabled`: **00000001**
- **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server**
  - `DisabledByDefault`: **00000000**
  - `Enabled`: **00000001**
- **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft&#92;.NETFramework\v4.0.30319**
  - `SchUseStrongCrypto`: **00000001**

To enable TLS 1.2 by using a PowerShell script, see [TLS 1.2 enforcement for Microsoft Entra Connect](/azure/active-directory/hybrid/reference-connect-tls-enforcement).

## How to check which TLS protocol is being used

Here are two ways to check which TLS is being used:

- Browser security settings
- Internet Properties in Windows

To check which TLS protocol is being used by using Internet Properties, follow these steps:

1. Press <kbd>Windows</kbd>+<kbd>R</kbd> to open the **Run** box.
2. Type *inetcpl.cpl* and then select **OK**. Then, the **Internet Properties** window is opened.
3. In the **Internet Properties** window, select the **Advanced** tab and scroll down to check the settings related to TLS.

    :::image type="content" source="media/enable-support-tls-environment/used-tls-protocol.png" alt-text="Screenshot that shows TLS-related settings in Internet Properties.":::

## Update and configure .NET Framework to support TLS 1.2 <a name="update-configure-tls-12"></a>

Managed Microsoft Entra integrated applications and Windows PowerShell scripts (using [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) and [Microsoft Graph](https://graph.microsoft.com)) may use .NET Framework.

### Install .NET updates to enable strong cryptography

#### Determine the .NET version

First, determine the installed .NET versions.

- For more information, see [Determine which versions and service pack levels of .NET Framework are installed](../../dotnet/framework/determine-dotnet-versions-service-pack-levels.md).

#### Install .NET updates

Install the .NET updates so that you can enable strong cryptography. Some versions of .NET Framework might have to be updated to enable strong cryptography.

Use these guidelines:

- .NET Framework 4.6.2 and later versions support TLS 1.2 and TLS 1.1. Check the registry settings. No other changes are required.

- Update .NET Framework 4.6 and earlier versions to support TLS 1.2 and TLS 1.1.

  For more information, see [.NET Framework versions and dependencies](/dotnet/framework/migration-guide/versions-and-dependencies).
- Do you use .NET Framework 4.5.2 or 4.5.1 on Windows 8.1 or Windows Server 2012? Then the relevant updates and details are also available from [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=2898850).

  - Also see [Microsoft Security Advisory 2960358](/security-updates/SecurityAdvisories/2015/2960358).

For any computer that communicates across the network and runs a TLS 1.2-enabled system, set the following registry DWORD values.

- For 32-bit applications that are running on a 32-bit OS and 64-bit applications that are running on a 64-bit OS, update the following subkey values:

  - **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft&#92;.NETFramework\v2.0.50727**
    - `SystemDefaultTlsVersions`: **00000001**
    - `SchUseStrongCrypto`: **00000001**
  
  - **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft&#92;.NETFramework\v4.0.30319**
    - `SystemDefaultTlsVersions`: **00000001**
    - `SchUseStrongCrypto`: **00000001**
- For 32-bit applications that are running on 64-bit OSs, update the following subkey values:
  - **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft&#92;.NETFramework\v2.0.50727**
    - `SystemDefaultTlsVersions`: **dword:00000001**
    - `SchUseStrongCrypto`: **dword:00000001**
  - **HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft&#92;.NETFramework\v4.0.30319**
    - `SystemDefaultTlsVersions`: **dword:00000001**
    - `SchUseStrongCrypto`: **dword:00000001**

For example, set these values on:

- Configuration Manager clients
- Remote site system roles that aren't installed on the site server
- The site server itself

For more information, see the following articles:

- [TLS Cipher Suites supported by Microsoft Entra ID](/azure/active-directory-b2c/https-cipher-tls-requirements#cipher-suites)
- [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Transport Layer Security (TLS) best practices with the .NET Framework](/dotnet/framework/network-programming/tls#configuring-schannel-protocols-in-the-windows-registry)
- [Solving the TLS 1.0 Problem - Security documentation](/security/engineering/solving-tls1-problem)

## Overview of new telemetry in the sign-in logs

To help you identify any clients or apps that still use legacy TLS in your environment, view the Microsoft Entra sign-in logs. For clients or apps that sign in over legacy TLS, Microsoft Entra ID marks the **Legacy TLS** field in **Additional Details** with **True**. The Legacy TLS field only appears if the sign-in occurred over legacy TLS. If you don't see any legacy TLS in your logs, you're ready to switch to TLS 1.2.

To find the sign-in attempts that used legacy TLS protocols, an administrator can review the logs by:

- Exporting and querying the logs in Azure Monitor.
- Downloading the last seven days of logs in JavaScript Object Notation (JSON) format.
- Filtering and exporting sign-in logs using PowerShell.

These methods are described below.

## [Azure Monitor](#tab/azure-monitor)

You can query the sign-in logs using Azure Monitor. Azure Monitor is a powerful log analysis, monitoring, and alerting tool. Use Azure Monitor for:

- Microsoft Entra logs
- Azure resources logs
- Logs from independent software tools

> [!NOTE]
> You need a Microsoft Entra ID P1 or P2 license to export reporting data to Azure Monitor.

To query for legacy TLS entries using Azure Monitor:

1. In [Integrate Microsoft Entra logs with Azure Monitor logs](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics), follow the instructions for how to access the Microsoft Entra sign-in logs in Azure Monitor.

1. In the query definition area, paste the following Kusto Query Language query:

    ```kusto
    // Interactive sign-ins only
    SigninLogs
    | where AuthenticationProcessingDetails has "Legacy TLS"
        and AuthenticationProcessingDetails has "True"
    | extend JsonAuthProcDetails = parse_json(AuthenticationProcessingDetails)
    | mv-apply JsonAuthProcDetails on (
        where JsonAuthProcDetails.key startswith "Legacy TLS"
        | project HasLegacyTls=JsonAuthProcDetails.value
    )
    | where HasLegacyTls == true

    // Non-interactive sign-ins
    AADNonInteractiveUserSignInLogs
    | where AuthenticationProcessingDetails has "Legacy TLS"
        and AuthenticationProcessingDetails has "True"
    | extend JsonAuthProcDetails = parse_json(AuthenticationProcessingDetails)
    | mv-apply JsonAuthProcDetails on (
        where JsonAuthProcDetails.key startswith "Legacy TLS"
        | project HasLegacyTls=JsonAuthProcDetails.value
    )
    | where HasLegacyTls == true

    // Workload Identity (service principal) sign-ins
    AADServicePrincipalSignInLogs
    | where AuthenticationProcessingDetails has "Legacy TLS"
        and AuthenticationProcessingDetails has "True"
    | extend JsonAuthProcDetails = parse_json(AuthenticationProcessingDetails)
    | mv-apply JsonAuthProcDetails on (
        where JsonAuthProcDetails.key startswith "Legacy TLS"
        | project HasLegacyTls=JsonAuthProcDetails.value
    )
    | where HasLegacyTls == true
    ```

1. Select **Run** to execute the query. The log entries that match the query appear in the **Results** tab below the query definition.

1. To learn more about the source of the legacy TLS request, look for the following fields:

    - **UserDisplayName**
    - **AppDisplayName**
    - **ResourceDisplayName**
    - **UserAgent**

## [JSON](#tab/json)

To see the Legacy TLS flag, you may download the last seven days of sign-in logs in JSON format.

> [!NOTE]
>
> 1. The Legacy TLS flag only appears if legacy TLS is used for the request to sign in.
>
> 1. If you download the sign-in logs in comma-separated value (CSV) format instead, the legacy TLS flag doesn't appear.

### Download JSON logs

To download sign-in logs as JSON:

1. In the [Azure portal](https://portal.azure.com), search for and select **Microsoft Entra ID**.

1. In the **Overview** page menu, select **Sign-in logs**.

1. Clear all filters except the **Date** filter.

1. Set the **Date** filter to **Last 7 days**.

1. Select **Download**.

1. Choose each category of logs:
    - User interactive
    - User non-interactive
    - Managed identity

### View the JSON files

Now you can review the JSON logs by using a JSON viewer of your choice.

> [!NOTE]
> If you need a JSON viewer, you can [download Visual Studio Code](https://code.visualstudio.com/Download).

To review the JSON logs:

1. Open the JSON log files your JSON viewer.

1. Search for the term _legacy TLS_.

1. If you find a log file with _legacy TLS_, review that sign-in log entry to learn more about the source of the legacy TLS request. Look for the following fields:
    - **UserDisplayName**
    - **AppDisplayName**
    - **ResourceDisplayName**
    - **UserAgent**

## [PowerShell](#tab/powershell)

Use PowerShell to filter and export sign-in log entries where legacy TLS is used.

> [!NOTE]
> You need a Microsoft Entra ID P1 or P2 license to call the [Microsoft Graph API](/graph/use-the-api) through PowerShell.

To filter and export the sign-in log entries:

1. Using the **Run as administrator** option, open Windows PowerShell from the Start menu.

1. Run the following commands to install the [Microsoft Graph SDKs](/graph/sdks/sdk-installation) and set the execution policy:

    ```powershell
    Install-Module Microsoft.Graph -Scope AllUsers
    Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
    ```

1. Save the following script to a PowerShell script (.ps1) file.

    ```powershell
    $tId = "your-tenant-id"  # Add tenant ID from Azure Active Directory page on portal.
    $agoDays = 4  # Will filter the log for $agoDays from the current date and time.
    $startDate = (Get-Date).AddDays(-($agoDays)).ToString('yyyy-MM-dd')  # Get filter start date.
    $pathForExport = "./"  # The path to the local filesystem for export of the CSV file.

    Connect-MgGraph -Scopes "AuditLog.Read.All" -TenantId $tId  # Or use Directory.Read.All.
    Select-MgProfile "beta"  # Low TLS is available in Microsoft Graph preview endpoint.

    # Define the filtering strings for interactive and non-interactive sign-ins.
    $procDetailFunction = "x: x/key eq 'legacy tls (tls 1.0, 1.1, 3des)' and x/value eq '1'"
    $clauses = (
        "createdDateTime ge $startDate",
        "signInEventTypes/any(t: t eq 'nonInteractiveUser')",
        "signInEventTypes/any(t: t eq 'servicePrincipal')",
        "(authenticationProcessingDetails/any($procDetailFunction))"
    )

    # Get the interactive and non-interactive sign-ins based on filtering clauses.
    $signInsInteractive = Get-MgAuditLogSignIn -Filter ($clauses[0,3] -Join " and ") -All
    $signInsNonInteractive = Get-MgAuditLogSignIn -Filter ($clauses[0,1,3] -Join " and ") -All
    $signInsWorkloadIdentities = Get-MgAuditLogSignIn -Filter ($clauses[0,2,3] -Join " and ") -All

    $columnList = @{  # Enumerate the list of properties to be exported to the CSV files.
        Property = "CorrelationId", "createdDateTime", "userPrincipalName", "userId",
                  "UserDisplayName", "AppDisplayName", "AppId", "IPAddress", "isInteractive",
                  "ResourceDisplayName", "ResourceId", "UserAgent"
    }

    $columnListWorkloadId = @{ #Enumerate the list of properties for workload identities to be exported to the CSV files.
        Property = "CorrelationId", "createdDateTime", "AppDisplayName", "AppId", "IPAddress",
                  "ResourceDisplayName", "ResourceId", "ServicePrincipalId", "ServicePrincipalName"
    }

    $signInsInteractive | ForEach-Object {
        foreach ($authDetail in $_.AuthenticationProcessingDetails)
        {
            if (($authDetail.Key -match "Legacy TLS") -and ($authDetail.Value -eq "True"))
            {
                $_ | Select-Object @columnList
            }
        }
    } | Export-Csv -Path ($pathForExport + "Interactive_lowTls_$tId.csv") -NoTypeInformation

    $signInsNonInteractive | ForEach-Object {
        foreach ($authDetail in $_.AuthenticationProcessingDetails)
        {
            if (($authDetail.Key -match "Legacy TLS") -and ($authDetail.Value -eq "True"))
            {
                $_ | Select-Object @columnList
            }
        }
    } | Export-Csv -Path ($pathForExport + "NonInteractive_lowTls_$tId.csv") -NoTypeInformation

    $signInsWorkloadIdentities | ForEach-Object {
        foreach ($authDetail in $_.AuthenticationProcessingDetails)
        {
            if (($authDetail.Key -match "Legacy TLS") -and ($authDetail.Value -eq "True"))
            {
                $_ | Select-Object @columnListWorkloadId
            }
        }
    } | Export-Csv -Path ($pathForExport + "WorkloadIdentities_lowTls_$tId.csv") -NoTypeInformation
    ```

1. In the [Azure portal](https://portal.azure.com), search for and select **Microsoft Entra ID**.

1. Copy the **Tenant ID** value from the Microsoft Entra ID page into the first statement of the PowerShell script, assigning it to the `$tId` variable.

1. Save and run the script. If you're prompted when the script is running, sign in as a global administrator. Then give your consent to let Microsoft Graph read the audit log information.

1. To learn about the source of the legacy TLS request, search the script output files (*Interactive_lowTls_\<Tenant-ID>.csv* and *NonInteractive_lowTls_\<Tenant-ID>.csv*) for these fields:
    - **UserDisplayName**
    - **AppDisplayName**
    - **ResourceDisplayName**
    - **UserAgent**
---

<a name='view-details-about-log-entries-in-the-azure-ad-portal'></a>

### View details about log entries in the Microsoft Entra admin center

After you obtain the logs, you can get more details about legacy TLS-based sign-in log entries in the Microsoft Entra admin center. Follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Microsoft Entra ID**.

1. In the **Overview** page menu, select **Sign-in logs**.

1. Select a sign-in log entry for a user.

1. Select the **Additional details** tab. (If you don't see this tab, first select the ellipsis (**...**) in the right corner to view the full list of tabs.)

1. Check for a **Legacy TLS (TLS 1.0, 1.1, or 3DES)** value that's set to **True**. If you see that particular field and value, the sign-in attempt was made using legacy TLS. If the sign-in attempt was made using TLS 1.2, that field doesn't appear.

For more information, see [Sign-in logs in Microsoft Entra ID](/azure/active-directory/reports-monitoring/concept-sign-ins).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
