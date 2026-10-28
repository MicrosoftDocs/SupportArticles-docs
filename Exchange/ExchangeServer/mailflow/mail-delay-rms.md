---
title: Email delivery delayed in Exchange Server that uses MSIPC
description: Describes an issue in which email delivery is delayed on an Exchange Server when RMS licensing endpoints are unreachable.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: dkhrebin
appliesto: 
  - Exchange Server SE
search.appverid: MET150
ms.date: 10/27/2026
ai-usage: ai-assisted
---

# Email delivery delayed in Exchange Server that uses MSIPC

## Summary

When an on-premises Exchange server uses the Microsoft Information Protection Client (MSIPC), processing RMS-protected messages can require a connection to an external licensing service. If that connection can't complete, licensing requests can wait while mail-processing capacity remains occupied. Queues can grow even though the Microsoft Exchange Mailbox Transport Delivery service is still running.

Start with the Delivery RightsManagement logs. If they show licensing failures or long waits for an Azure RMS endpoint, work with your network team to establish the intended outbound route: an approved proxy or direct HTTPS access.

## Symptoms

You might see delayed delivery, growing queues, and repeated deferrals. Errors can include:

`432 4.3.2 STOREDRV.Deliver; Dynamic mailbox database throttling limit exceeded`

or:

`Already processing maximum number of RMS message for Transport Decryption`

## Cause

These errors relate to different stages of mail processing. Neither proves that RMS connectivity is the cause; use the Delivery logs to check whether this scenario applies.

### Check the Delivery Rights Management logs

On an affected Exchange server, open:

```text
%ExchangeInstallPath%Logging\RightsManagement
```

With a default installation, this is:

```text
C:\Program Files\Microsoft\Exchange Server\V15\Logging\RightsManagement
```

Look specifically for:

```text
MSExchangeDelivery_<pid>_<yyyyMMdd>-<sequence>.LOG
```

Use files covering the period when delivery was delayed, including earlier process IDs if the service restarted. Don't check only the newest file, which might be empty. Logs for EdgeTransport, application pools, or Mailbox Assistants in the same folder belong to other processes.

To find licensing URLs without opening each file, run this read-only search in **Exchange Management Shell** on the affected server:

```powershell
$logPath = Join-Path $env:ExchangeInstallPath 'Logging\RightsManagement'
Get-ChildItem -LiteralPath $logPath -Filter 'MSExchangeDelivery_*.LOG' -File | Select-String -SimpleMatch '_wmcs/licensing'
```

The output shows the file path, line number, and matching log line. Check its timestamp and hostname, and then look for accompanying errors such as `IpcpGetKey failed` or messages that a network location can't be reached. The search matches the licensing path for both cloud and on-premises RMS endpoints. An Azure RMS URL might look like:

```text
https://<tenant-guid>.rms.eu.aadrm.com/_wmcs/licensing
```

The tenant identifier and regional hostname can differ. Use the **exact hostname from the affected log**, not the preceding example.

If the command returns no matches, check that the log files cover the incident interval. No match doesn't prove that RMS connectivity is working.

> [!IMPORTANT]
> An RMS URL is a useful lead, not proof of a blocked connection. A URL accompanied by repeated licensing or network failures, or long waits during the delivery delay, makes the outbound licensing path a strong candidate for investigation.

The URL can come from the protected message itself. Your organization doesn't need its own local RMS deployment for Exchange to encounter an external licensing endpoint.

MSIPC became enabled by default for Exchange Server 2019 and 2016 with the November 2024 Security Update. See [Microsoft's feature notice](https://support.microsoft.com/en-us/servicing/exchange/server/msipc-enabled-by-default-in-exchange-server-2019-and-2016). This change explains why the behavior can occur without an administrator explicitly enabling MSIPC. This change doesn't establish a new update regression.

## Resolution

To resolve the issue, use the following steps:

### Step 1: Decide how the server should reach the licensing service

Give your network team the affected server, the licensing hostname, and the time of the failure. Agree on the intended route:

- **Proxy required:** configure the proxy for the service account, as described in the following section.
- **Direct access permitted:** allow the required outbound HTTPS traffic, normally TCP port 443, to the licensing service and any required service dependencies. Check DNS, routing, return traffic, and TLS handling.
- **Access intentionally prohibited:** review how the network rejects the connection, as described in step 3.

Use the current service requirements and the endpoint information in the logs. Don't pin a cloud service to one IP address you observed during troubleshooting.

### Step 2: If a proxy is required, configure NETWORK SERVICE

**The native MSIPC licensing path discussed in this article doesn't use the Exchange server's `InternetWebProxy` setting as its request proxy.** Setting `Set-ExchangeServer -InternetWebProxy` alone isn't sufficient for this path. This limitation doesn't mean that other Exchange components ignore that setting.

Mailbox Transport Delivery normally runs as **NETWORK SERVICE**. This account has its own proxy configuration. A successful browser test as an administrator doesn't verify access for the service.

#### Check the current configuration

Confirm the service's logon account in Services. Don't change it. Open **Windows PowerShell as administrator** on the affected server and run:

```powershell
bitsadmin.exe /util /getieproxy NETWORKSERVICE
if ($LASTEXITCODE -ne 0) { throw 'Unable to read NETWORK SERVICE proxy settings.' }
```

Save the current mode, proxy, bypass list, and any PAC settings before making an approved change.

#### Configure an approved static proxy

Replace the example proxy with the address and port supplied by your network team:

```powershell
bitsadmin.exe /util /setieproxy NETWORKSERVICE MANUAL_PROXY 'proxy.contoso.com:8080' 'NULL'
if ($LASTEXITCODE -ne 0) { throw 'Unable to set NETWORK SERVICE proxy settings.' }

bitsadmin.exe /util /getieproxy NETWORKSERVICE
if ($LASTEXITCODE -ne 0) { throw 'Unable to verify NETWORK SERVICE proxy settings.' }
```

The literal `NULL` means an empty bypass list, not PowerShell `$null`. Use your organization's approved bypass list where required, and ensure it doesn't unintentionally send the licensing request directly.

If your organization uses a PAC file instead, use the following **instead of** the static-proxy command:

```powershell
bitsadmin.exe /util /setieproxy NETWORKSERVICE AUTOSCRIPT 'https://proxy-config.contoso.com/proxy.pac'
if ($LASTEXITCODE -ne 0) { throw 'Unable to set NETWORK SERVICE PAC settings.' }
```

Read the settings again with `/getieproxy`. The PAC file must be reachable by the service and return the intended route for the licensing URL.

#### Before and after the change

- This is a **server-local, account-wide** change. It can affect other services using NETWORK SERVICE, not just Exchange Delivery. Apply it only on the intended servers.
- Ensure the proxy allows HTTPS connections to the required service. If authentication is required, the policy must work for the service account; an interactive user sign-in isn't a substitute.
- Ask the network team to confirm that requests actually reach the expected proxy or destination. A configured proxy value doesn't prove that PAC or bypass rules select it.
- To roll back, restore the recorded mode and original values. Use `NO_PROXY` only if that was the previous configuration. Changing modes can retain parameters from earlier modes.

### Step 3: Avoid silent drops when access must remain blocked

If your network team confirms that connection attempts are silently dropped, the client can wait for retransmissions and timeouts before the operation fails. Repeated requests can keep mail-processing capacity occupied.

The preferred resolution is to provide the required access through the approved route. If policy requires denying the connection, ask the network team whether an explicit **REJECT/TCP RST** response is appropriate instead of silently discarding packets.

**A fast rejection isn't a successful RMS connection.** It can shorten connection-establishment waits, but it doesn't restore licensing, eliminate every retry or SDK wait, or guarantee delivery of protected messages. Don't change system-wide TCP timeouts to compensate for a network drop policy.

### Step 4: Optional temporary workaround: switch away from MSIPC

If you confirm MSIPC-related waits and can't immediately correct the network, Microsoft Support can help determine whether temporarily switching the affected server to the legacy RMS client is appropriate. **Use setting overrides only under documented product guidance or Microsoft Support direction.** Restoring the intended network access remains the preferred resolution.

**`UseMSIPC=false` switches the client stack; it doesn't disable all RMS/IRM features or repair connectivity.** It can change protected-message processing, including content inspection and journaling. Review those requirements before using this option, and don't assume that every protected message will continue to work unchanged.

#### Apply to one affected server

Run in an elevated **Exchange Management Shell**. First inspect existing overrides:

```powershell
Get-SettingOverride | Where-Object { $_.ComponentName -eq 'Encryption' -and $_.SectionName -eq 'UseMSIPC' } | Format-List *
```

If an applicable override already exists, review it with Support rather than creating a duplicate or conflicting setting. Otherwise, replace `EX2K19` with the affected server and use an approved change reference in the reason:

```powershell
New-SettingOverride -Name 'TempRms-EX2K19' -Server 'EX2K19' -Component Encryption -Section UseMSIPC -Parameters @('Enabled=false') -Reason 'Temporary RMS delivery mitigation; approved change reference' -ErrorAction Stop

Get-ExchangeDiagnosticInfo -Server 'EX2K19' -Process Microsoft.Exchange.Directory.TopologyService -Component VariantConfiguration -Argument Refresh

Get-ExchangeDiagnosticInfo -Server 'EX2K19' -Process MSExchangeDelivery -Component VariantConfiguration -Argument Refresh
```

Keep the `-Server` parameter: this example is **server-scoped**, not organization-wide. Omitting it broadens the scope. Overrides persist across cumulative updates, so record an owner and a rollback condition.

Have Support verify that the setting is effective in the Delivery process. A refresh doesn't cancel a native call already in progress. If necessary, arrange a controlled restart of Microsoft Exchange Mailbox Transport Delivery; it briefly interrupts delivery on that server.

#### Roll back the temporary override

When the workaround is no longer needed, remove **only the override created for this change**:

```powershell
Remove-SettingOverride -Identity 'TempRms-EX2K19' -ErrorAction Stop
```

Repeat both configuration-refresh commands earlier, verify the effective setting, and use a controlled Delivery-service restart if required to clear cached state. Test both ordinary and protected messages after applying or removing the workaround.

### Step 5: Confirm recovery

After correcting the route or proxy configuration, or applying an approved temporary mitigation:

- Verify that queues drain and newly arriving messages are delivered normally.
- Check the current Delivery RightsManagement logs for repeated failures to the same licensing endpoint.
- Test a representative protected message as well as ordinary mail.

Existing requests can remain blocked after a configuration change. You might need to perform a controlled restart of Microsoft Exchange Mailbox Transport Delivery to clear in-process state. This action briefly interrupts delivery on that server. Plan it through your normal change procedure.

If delays continue, contact Microsoft Support with the relevant Delivery logs and the intended proxy/direct-access design. Keep logs in a secure support channel: they can contain tenant, message, and recipient identifiers.
