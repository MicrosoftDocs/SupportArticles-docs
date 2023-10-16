---
title: Check SSL connectivity for Microsoft Monitoring Agent on Windows
description: "Learn how to check SSL connectivity for Microsoft Monitoring Agent on Windows by using PowerShell cmdlets."
ms.date: 06/29/2022
ms.reviewer: irfanr, arboisse, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: logs-troubleshoot
ms.custom:
keywords:
#Customer intent: As an Azure Monitor user, I want to check the connectivity of Secure Sockets Layer (SSL) for the Microsoft Monitoring Agent so that the agent can successfully communicate over the network on a Windows computer.
---
# Check SSL connectivity for Microsoft Monitoring Agent on Windows

This article discusses how to troubleshoot Secure Sockets Layer (SSL) connectivity for the Microsoft Monitoring Agent on Windows. It provides PowerShell code that helps you check SSL connectivity from the agent computer to different Azure Log Analytics workspace and Azure Automation endpoints. This code complements the [TestCloudConnectivity](/azure/azure-monitor/agents/agent-windows-troubleshoot#connectivity-issues) tool that checks whether physical network connections are open. SSL connectivity checking is useful to determine whether any filtering is occurring.

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell)

## Troubleshooting checklist

### Step 1: Implement the CheckSSL function

The following PowerShell code defines and implements the `CheckSSL` function that tests a connection to a fully qualified domain name (FQDN) that you specify. It displays information about the connection name, resolution details, and connectivity to the provided certificate.

Open an administrative PowerShell console, and run the following code:

```powershell
# Usage: CheckSSL <fully-qualified-domain-name>
function CheckSSL($fqdn, $port=443) 
{
    try {
        $tcpSocket = New-Object Net.Sockets.TcpClient($fqdn, $port)
    } catch {
        Write-Warning "$($_.Exception.Message) / $fqdn"
        break
    }
    $tcpStream = $tcpSocket.GetStream()
    ""; "-- Target: $fqdn / " + $tcpSocket.Client.RemoteEndPoint.Address.IPAddressToString
    $sslStream = New-Object -TypeName Net.Security.SslStream($tcpStream, $false)
    $sslStream.AuthenticateAsClient($fqdn)  # If not valid, will display "remote certificate is invalid".
    $certinfo = New-Object -TypeName Security.Cryptography.X509Certificates.X509Certificate2(
        $sslStream.RemoteCertificate)

    $sslStream |
        Select-Object |
        Format-List -Property SslProtocol, CipherAlgorithm, HashAlgorithm, KeyExchangeAlgorithm,
            IsAuthenticated, IsEncrypted, IsSigned, CheckCertRevocationStatus
    $certinfo |
        Format-List -Property Subject, Issuer, FriendlyName, NotBefore, NotAfter, Thumbprint
    $certinfo.Extensions |
        Where-Object -FilterScript { $_.Oid.FriendlyName -Like 'subject alt*' } |
        ForEach-Object -Process { $_.Oid.FriendlyName; $_.Format($true) }

    $tcpSocket.Close() 
}
```

### Step 2: Use CheckSSL to test endpoint connections

After you implement the `CheckSSL` function in PowerShell, you can use this function to check connectivity to the endpoints in your Azure Log Analytics workspace and your Azure Automation account. The PowerShell code that's provided in this section invokes `CheckSSL` for several different endpoints.

Because the endpoint URLs often include identifiers for your workspace and automation accounts, you'll first have to get these IDs and add them to various placeholders within the code.

#### Get the Log Analytics workspace ID

To get the ID of your Log Analytics workspace:

1. In the [Azure portal](https://portal.azure.com), search for and select **Log Analytics workspaces**.

1. In the list of workspaces, select your workspace name.

1. In the overview page for your workspace, under the **Essentials** section, find the **Workspace ID** (a GUID in standard four-hyphen format), and then select the **Copy to clipboard** icon next to it.

1. Paste the ID into a file or another safe location.

#### Get the Automation account ID and DNS regional code

To get the ID and DNS regional code of your Automation account:

1. In the [Azure portal](https://portal.azure.com), search for and select **Automation Accounts**.

1. In the list of automation accounts, select your account name.

1. In the menu pane of the automation account overview page, find the **Account Settings** label, and then select **Keys**.

1. In the **URL** field, copy the GUID that's displayed after `https://` and before `.agentsvc.` within the domain name. This value is the Automation account ID. Paste the ID into a file or another safe location.

1. In the same field, copy the short alphanumeric string that's displayed between `.agentsvc.` and `.azure-automation.net` within the domain name. This value is the DNS regional code. It represents the region where the Automation account is located. Paste this value into a file or another safe location.

    <details>
    <summary>About regions, region names, and DNS regional codes</summary>

    The region name and DNS regional code are different for a particular region. For example, the "East US" region has a region name of `eastus`, but its DNS regional code is `eus`. The DNS regional code is required to replace the region placeholder in this article.

    You can display the list of regions and region names by running the [az account list-locations](/cli/azure/account#az-account-list-locations) command in [Azure CLI](/cli/azure/what-is-azure-cli). The following table shows a list of regions and their associated DNS regional codes:

    | Region | DNS regional code |
    | ------ | ----------------- |
    | South Africa North | `san` |
    | East Asia | `ea` |
    | South East Asia | `sea` |
    | Australia Central | `ac` |
    | Australia Central 2 | `cbr2` |
    | Australia South East | `ase` |
    | Australia East | `ae` |
    | Brazil South | `brse` |
    | Brazil Southeast | `brse` |
    | Canada Central | `cc` |
    | China East 2 | `sha2` |
    | China North | `bjb` |
    | China North 2 | `bjs2` |
    | West Europe | `we` |
    | North Europe | `ne` |
    | France Central | `fc` |
    | France South | `mrs` |
    | Germany West Central | `dewc` |
    | Central India | `cid` |
    | South India | `ma` |
    | Japan East | `jpe` |
    | Japan West | `jpw` |
    | Korea Central | `kc` |
    | Korea South | `ps` |
    | Norway East | `noe` |
    | Norway West | `now` |
    | Switzerland West | `stzw` |
    | UAE Central | `auh` |
    | UAE North | `uaen` |
    | UK West | `cw` |
    | UK South | `uks` |
    | Central US | `cus` |
    | East US | `eus` |
    | East US 2 | `eus2` |
    | North Central US | `ncus` |
    | South Central US | `scus` |
    | West Central US | `wcus` |
    | West US | `wus` |
    | West US 2 | `wus2` |
    | West US 3 | `usw3` |
    | US Gov Virginia | `usge` |
    | US Gov Texas | `ussc` |
    | US Gov Arizona | `phx` |
    </details>

#### Run the endpoint connection testing code

The following code checks the SSL connectivity for several endpoints. Before you run this code, paste the values that you copied in the previous section over the placeholders for `idWorkspace`, `idAutomation`, and `idRegion`.

> [!NOTE]
> The connectivity check for *global.in.ai.monitor.azure.com* is done by running the [Test-NetConnection](/powershell/module/nettcpip/test-netconnection) cmdlet instead. If you try to run the `CheckSSL` function on that domain name, an "invalid remote certificate" error occurs.

```powershell
cls 
 
# Check sample Log Analytics workspace endpoints, which may include the workspace ID (a GUID).
$idWorkspace = "<32-hexadecimal-digit-guid>"
IPConfig /FlushDNS  # Not required, but recommended if you're collecting a network trace
CheckSSL "$idWorkspace.ods.opinsights.azure.com"
CheckSSL "$idWorkspace.oms.opinsights.azure.com"
CheckSSL "$idWorkspace.agentsvc.azure-automation.net"
CheckSSL "scadvisorcontent.blob.core.windows.net"

# Other related log analytics URLs
CheckSSL "api.monitor.azure.com"

$netTest = @{
    ComputerName = "global.in.ai.monitor.azure.com"
    Port = 443
}
Test-NetConnection @netTest  # Workaround for unexplained error in CheckSSL for this URL

CheckSSL "profiler.monitor.azure.com"
CheckSSL "live.monitor.azure.com"
CheckSSL "snapshot.monitor.azure.com"

# Check sample automation endpoints, which include the automation ID (a GUID) and DNS regional code.
$idAutomation = "<32-hexadecimal-digit-guid>"
$idRegion = "<azure-dns-regional-code>"
CheckSSL "$idAutomation.jrds.$idRegion.azure-automation.net"
CheckSSL "$idAutomation.agentsvc.$idRegion.azure-automation.net"
```

### Step 3: Review output

The following text contains sample output from a `CheckSSL` function call in Windows PowerShell:

```console
PS C:\WINDOWS\system32> CheckSSL "01234567-89ab-cdef-0123-456789abcdef.ods.opinsights.azure.com"

-- Target: 01234567-89ab-cdef-0123-456789abcdef.ods.opinsights.azure.com / 172.16.154.83

SslProtocol               : Tls12
CipherAlgorithm           : Aes256
HashAlgorithm             : Sha384
KeyExchangeAlgorithm      : 44550
IsAuthenticated           : True
IsEncrypted               : True
IsSigned                  : True
CheckCertRevocationStatus : False

Subject      : CN=ODS-SSL201712EUS.azure.com
Issuer       : CN=Microsoft RSA TLS CA 01, O=Microsoft Corporation, C=US
FriendlyName : 
NotBefore    : 9/26/2021 2:30:43 PM
NotAfter     : 9/26/2022 2:30:43 PM
Thumbprint   : F84E9C8A41CF8C7E62A594F1E95961107C33A30D

Subject Alternative Name
DNS Name=ODS-SSL201712EUS.azure.com
DNS Name=*.ods.opinsights.azure.com
DNS Name=ods.systemcenteradvisor.com
DNS Name=ods.trafficmanager.net
DNS Name=eus-aa-ods-a.cloudapp.net
DNS Name=eus-aa-ods-b.cloudapp.net
DNS Name=eus2-aa-ods-a.cloudapp.net
DNS Name=eus2-aa-ods-b.cloudapp.net
```

The `Issuer` value should indicate a Microsoft origin, as in the following example:

```output
Issuer       : CN=Microsoft RSA TLS CA 01, O=Microsoft Corporation, C=US
```

If `Issuer` doesn't include "Microsoft" in its value, change the configuration of your firewall or proxy to bypass HTTPS inspection.

If the output doesn't return any SSL information, check whether the TCP connection is successful. If you can't establish a TCP connection, then check the network firewall.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
