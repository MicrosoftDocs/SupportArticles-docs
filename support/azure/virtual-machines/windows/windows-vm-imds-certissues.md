---
title: Azure Instance Metadata Service certificate chain issues
description: Troubleshoot and resolve IMDS attestation certificate chain issues on Azure Windows VMs, from missing intermediates to OCSP rotation. Run the tool now.
ms.service: azure-virtual-machines
ms.date: 07/10/2026
author: kaushika-msft
ms.author: kaushika
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, jugross, azurevmcptcic
---
# Azure Instance Metadata Service certificate chain issues

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article helps you troubleshoot certificate chain problems with the Azure Instance Metadata Service (IMDS) attestation endpoint on Windows VMs.

These problems can cause:

- An [activation watermark](./activation-watermark-appears.md) on Windows Server 2022/2025 Azure Edition
- Extended Security Updates (ESU) installation failures
- Application errors when reading IMDS attested data

> [!TIP]
> Run the [Azure IMDS Verification Tool](windows-vm-imds-tool.md) first. It diagnoses these problems automatically and identifies the exact certificate causing the failure.

## Certificate chain architecture

IMDS attestation uses a four-level certificate chain:

```
DigiCert Global Root G2 (Root CA)
  +-- Microsoft TLS RSA Root G2 (cross-signed intermediate)
        +-- Microsoft TLS G2 RSA CA OCSP xx (OCSP responder intermediate)
              +-- CN=metadata.azure.com (leaf certificate)
```

> [!IMPORTANT]
> **"Microsoft TLS RSA Root G2" isn't a root CA** despite its name. It's a cross-signed intermediate issued by DigiCert Global Root G2. The `-xsign` suffix in its download URL confirms this.

> [!NOTE]
> Azure rotates OCSP intermediates. The numbers range from 02 to 16 (for example, OCSP 04, OCSP 10). Your VM might use any one of them. The verification tool detects which one your VM uses.

## Symptom

You might see one or more of the following signs:

- An activation watermark appears on the Windows Server 2022/2025 Azure Edition desktop.
- ESU updates fail to install.
- Applications report IMDS authentication errors.
- The [verification tool](windows-vm-imds-tool.md) reports a chain validation failure.

For example, the verification tool shows output like:

```output
[FAIL] Chain validation FAILED for CN=metadata.azure.com
  [0] OK   CN=metadata.azure.com
  [1] FAIL CN=Microsoft TLS G2 RSA CA OCSP 10
           UntrustedRoot
  MISSING: Microsoft TLS RSA Root G2 (cross-signed intermediate)
```

This output means that the OCSP intermediate certificate (element 1) can't chain to its issuer because the cross-signed intermediate is missing.

## Cause

Certificate chain validation fails when one or more intermediate certificates are missing, blocked, or outdated. The four most common causes are:

- **Missing intermediates** – The OCSP responder or cross-signed intermediate isn't installed on the VM.
- **Firewall blocks certificate downloads** – Windows auto-downloads missing intermediates through AIA (Authority Information Access) on port 80. A firewall rule that blocks outbound port 80 prevents this download.
- **Certificate in the Disallowed store** – Someone or a policy explicitly blocked a certificate. Chain validation fails even though the certificate file exists on the system.
- **OCSP rotation** – Azure periodically rotates OCSP intermediates. A previously cached intermediate might no longer match the one the IMDS endpoint uses.

## How to diagnose

### Use the verification tool (recommended)

Run the [Azure Instance Metadata Service Verification Tool](windows-vm-imds-tool.md) by using one of the following methods:

## [Azure portal](#tab/portal)

1. In the Azure portal, go to your VM.
1. Select **Operations** > **Run Command**.
1. Select **Windows_IMDSValidation** from the list.
1. Select **Run**.

## [Azure CLI](#tab/cli)

```azurecli
az vm run-command invoke \
    --resource-group <resource-group> \
    --name <vm-name> \
    --command-id RunPowerShellScript \
    --scripts @Windows_IMDSValidation.ps1
```

## [Azure PowerShell](#tab/powershell)

```azurepowershell
Invoke-AzVMRunCommand -ResourceGroupName <resource-group> `
    -VMName <vm-name> `
    -CommandId RunPowerShellScript `
    -ScriptPath .\Windows_IMDSValidation.ps1
```

---

The tool runs six checks: IMDS reachability, chain validation, failure identification, store inventory, AIA connectivity, and OCSP detection.

### Manual PowerShell check

If you can't use the verification tool, run the following PowerShell script as an administrator:

```powershell
# Get the attested document from IMDS
$attestedDoc = Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET `
    -Uri http://169.254.169.254/metadata/attested/document?api-version=2018-10-01

# Decode the signature and build certificate chain
$signature = [System.Convert]::FromBase64String($attestedDoc.signature)
$cert = [System.Security.Cryptography.X509Certificates.X509Certificate2]($signature)
$chain = New-Object System.Security.Cryptography.X509Certificates.X509Chain

if (-not $chain.Build($cert)) {
    Write-Host "Certificate chain validation FAILED" -ForegroundColor Red
    # Walk each chain element to find the exact failure
    for ($i = 0; $i -lt $chain.ChainElements.Count; $i++) {
        $el = $chain.ChainElements[$i]
        $st = $el.ChainElementStatus
        if ($st.Count -eq 0) {
            Write-Host "[$i] OK   $($el.Certificate.Subject)" -ForegroundColor Green
        } else {
            Write-Host "[$i] FAIL $($el.Certificate.Subject)" -ForegroundColor Red
            foreach ($s in $st) {
                Write-Host "         $($s.Status): $($s.StatusInformation.Trim())" -ForegroundColor Yellow
            }
        }
    }
} else {
    Write-Host "Certificate chain validation PASSED" -ForegroundColor Green
    foreach ($el in $chain.ChainElements) {
        Write-Host "  $($el.Certificate.Subject)"
    }
}
```

## Common scenarios and resolutions

### Scenario 1: Missing intermediate certificates

**Symptom:** The verification tool reports `[MISS]` for one or more intermediate certificates.

**Resolution:** Follow these steps to download and install the missing certificates:

1. Go to the [Azure Certificate Authority Details](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains) page and download the certificates.
1. Open an elevated PowerShell prompt and install each certificate:

   ```powershell
   # Install the cross-signed intermediate
   certutil -addstore CA "Microsoft TLS RSA Root G2 - xsign.crt"
   ```

   You should see:

   ```output
   CertUtil: -addstore command completed successfully.
   ```

   > [!NOTE]
   > Install intermediates to the **Intermediate Certification Authorities** (CA) store, not the Trusted Root store.

1. Run `fclip.exe` from an elevated Command Prompt to clear the activation watermark:

   ```cmd
   C:\Windows\System32\fclip.exe
   ```

1. Restart the VM or sign out and sign back in.

> [!TIP]
> You can also use the `-AutoFix` switch with the [verification tool](windows-vm-imds-tool.md) to automate this process. The tool downloads missing certificates, installs them, re-validates the chain, and runs `fclip.exe` automatically.

### Scenario 2: Certificate in the Disallowed store

**Symptom:** The verification tool reports `[WARN] Certificate is in the DISALLOWED store!` for one or more certificates. Chain validation fails even though the certificate is installed.

**Cause:** Someone or a Group Policy explicitly blocked the certificate by adding it to the Disallowed store. The Disallowed store takes precedence over all other stores - a certificate in both the CA store and the Disallowed store fails validation.

**Resolution:**

1. Open `certlm.msc` (Local Machine certificate manager).
1. Go to **Untrusted Certificates** > **Certificates**.
1. Find the blocked certificate and verify it should be removed. If a security policy requires the block, contact your security team.
1. Right-click the certificate and select **Delete**.
1. Run the [verification tool](windows-vm-imds-tool.md) again to confirm the chain validates.

> [!IMPORTANT]
> The `-AutoFix` switch doesn't remove certificates from the Disallowed store because they represent explicit policy decisions. You must remove them manually.

### Scenario 3: Clock skew causing validation failure

**Symptom:** Chain validation fails with `NotTimeValid` status. Certificates appear expired or not yet valid, even though they should be current.

**Cause:** The VM's system clock is significantly off from the actual time. Certificate validation checks `NotBefore` and `NotAfter` against the local clock. A clock drift greater than 5 minutes can cause validation failures.

**How to detect:**

```powershell
# Compare local time to a time server
w32tm /stripchart /computer:time.windows.com /dataonly /samples:1
```

If the offset is greater than 5 minutes, clock skew is likely the cause.

**Resolution:**

```powershell
# Force time sync
w32tm /resync /force
```

After syncing the clock, run the [verification tool](windows-vm-imds-tool.md) again.

### Scenario 4: Expired intermediate certificate

**Symptom:** An intermediate certificate is present in the correct store, but chain validation still fails. The verification tool shows the certificate with a past expiration date.

**How to detect:**

```powershell
# Check expiry of all certs in the CA store
Get-ChildItem Cert:\LocalMachine\CA | Where-Object {
    $_.Subject -match "Microsoft TLS" -and $_.NotAfter -lt (Get-Date)
} | Format-Table Subject, NotAfter, Thumbprint
```

**Resolution:**

1. Download the fresh certificate from the URL shown in the verification tool output.
1. Install it to the CA store (replaces the expired one):

   ```powershell
   certutil -addstore CA "Microsoft TLS G2 RSA CA OCSP 10.crt"
   ```

1. Run `fclip.exe` and restart.

> [!TIP]
> Use `-AutoFix` to automatically download and install the fresh certificate.

### Scenario 5: TLS 1.2 disabled (older VMs)

**Symptom:** The verification tool reports AIA HTTPS endpoints as blocked, but HTTP endpoints work. Certificate downloads from `https://www.microsoft.com/pkiops/certs/` fail silently.

**Cause:** On older VMs (Windows Server 2012 R2, 2016), TLS 1.2 might be disabled by default. The OCSP intermediate download URLs use HTTPS and require TLS 1.2.

**How to detect:**

```powershell
# Check current TLS protocol
[Net.ServicePointManager]::SecurityProtocol

# Check registry
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -ErrorAction SilentlyContinue
```

If TLS 1.2 isn't listed in the output, it's disabled.

**Resolution:**

```powershell
# Enable TLS 1.2 for .NET
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value 1 -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value 1 -Type DWord

# Enable TLS 1.2 in SCHANNEL
New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Force
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'Enabled' -Value 1 -Type DWord
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'DisabledByDefault' -Value 0 -Type DWord
```

Restart the VM after making these changes.

### Scenario 6: Stale CryptoAPI cache after OCSP rotation

**Symptom:** Chain validation passes intermittently. The verification tool shows a different OCSP intermediate than expected, or shows `[MISS]` for the active OCSP intermediate despite the chain passing.

**Cause:** Windows CryptoAPI auto-downloads missing certificates via AIA and caches them in the `CurrentUser\CA` store (not `LocalMachine\CA`). After an OCSP rotation, the old cached intermediate might conflict with the new one.

**How to detect:**

```powershell
# Check CurrentUser CA store for OCSP certs
Get-ChildItem Cert:\CurrentUser\CA | Where-Object {
    $_.Subject -match "OCSP"
} | Format-Table Subject, Thumbprint, NotAfter
```

**Resolution:**

1. Remove the stale OCSP certificate from the `CurrentUser\CA` store.
1. Permanently install the correct OCSP intermediate to `LocalMachine\CA`.
1. Run the [verification tool](windows-vm-imds-tool.md) to confirm.

### Scenario 7: Proxy blocks AIA but not IMDS

**Symptom:** IMDS endpoint is reachable (Phase 1 passes), but AIA endpoints are blocked (Phase 5 fails). The VM can reach `169.254.169.254` but can't download certificates.

**Cause:** IMDS uses a link-local address (`169.254.169.254`) that bypasses proxy settings. Certificate download URLs go through the proxy. If the proxy blocks `caissuers.microsoft.com` or `www.microsoft.com`, auto-download fails.

**How to detect:**

```cmd
netsh winhttp show proxy
```

**Resolution:**

Add the AIA and CRL endpoints to the proxy bypass list:

```cmd
netsh winhttp set proxy proxy-server="your-proxy:8080" bypass-list="caissuers.microsoft.com;www.microsoft.com;cacerts.digicert.com;crl3.digicert.com;crl4.digicert.com;ocsp.digicert.com;oneocsp.microsoft.com"
```

### Scenario 8: Group Policy blocking certificates

**Symptom:** Certificates keep reappearing in the Disallowed store after manual removal. Or Group Policy removes certificates from the CA store.

**Cause:** A domain Group Policy manages certificate stores and overrides local changes.

**How to detect:**

```cmd
gpresult /scope computer /v | findstr /i "certificate"
```

**Resolution:** Contact your domain administrator to review the Group Policy that manages certificate stores. Local changes are overwritten at the next Group Policy refresh cycle (typically every 90 minutes).

### Scenario 9: Preinstalled certificates approaching expiry

**Symptom:** IMDS worked for months, then suddenly starts failing. The VM has AIA blocked (all cert download endpoints unreachable) and relies on preinstalled certificates.

**Cause:** Customers who block AIA are advised to preinstall all intermediate certificates. These certificates have expiration dates. When they expire, the chain fails and the VM can't autoupdate replacements because AIA is blocked.

**How to detect:**

```powershell
# Check for intermediates expiring within 60 days
Get-ChildItem Cert:\LocalMachine\CA | Where-Object {
    $_.Subject -match "Microsoft TLS" -and
    $_.NotAfter -lt (Get-Date).AddDays(60) -and
    $_.NotAfter -gt (Get-Date)
} | Format-Table Subject, NotAfter, Thumbprint
```

**Resolution:**

1. Download fresh certificates from the [Azure Certificate Authority Details](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains) page.
1. To prevent future expiry issues when AIA is blocked, preinstall all OCSP intermediate variants (02 through 16) so the VM survives OCSP rotation without needing to download anything.

   The full list of OCSP intermediates is available at `https://www.microsoft.com/pkiops/certs/Microsoft%20TLS%20G2%20RSA%20CA%20OCSP%20{NUM}.crt` where `{NUM}` is 02, 04, 06, 08, 10, 12, 14, or 16.

### Scenario 2: Firewall or proxy blocking certificate downloads

**Symptom:** The verification tool shows `[MISS]` for certificates and reports blocked AIA, CRL, or OCSP endpoints in Phase 5.

**Resolution:** Configure your firewall or proxy to allow outbound port 80 (HTTP) to the following endpoints:

| Purpose | Endpoints |
|---|---|
| **AIA** (certificate download) | `cacerts.digicert.com`, `caissuers.microsoft.com`, `www.microsoft.com` |
| **CRL** (revocation lists) | `crl3.digicert.com`, `crl4.digicert.com` |
| **OCSP** (online validation) | `ocsp.digicert.com`, `oneocsp.microsoft.com` |

For more information, see [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details#certificate-downloads-and-revocation-lists).

> [!IMPORTANT]
> **Auto-download behavior:** Windows automatically downloads missing intermediate certificates through AIA during certificate chain validation. If AIA endpoints are reachable, the chain might pass even though certificates aren't permanently installed. If AIA later becomes blocked (for example, by a firewall change), the chain fails. Install certificates permanently to avoid this problem.

### Scenario 3: Certificate in the Disallowed store

**Symptom:** The verification tool reports `ExplicitDistrust` or `Revoked` status for a chain element. The certificate exists on the system but is blocked.

**Resolution:** Remove the certificate from the Disallowed store:

```powershell
# Check if certificates are in the Disallowed store
Get-ChildItem Cert:\CurrentUser\Disallowed
Get-ChildItem Cert:\LocalMachine\Disallowed

# Remove a specific certificate from the Disallowed store (replace with actual thumbprint)
Remove-Item Cert:\CurrentUser\Disallowed\<thumbprint>
```

### Scenario 4: Certificate in the wrong store

**Symptom:** The verification tool reports `[WARN] Found in WRONG store`. The certificate exists but isn't in the expected store location.

**Resolution:** Certificate chain validation typically still works when a certificate is in a different store because Windows searches all stores during chain building. However, for correct operation, move the certificate to the expected store:

- **Root CA certificates** should be in `LocalMachine\Root`
- **Intermediate certificates** should be in `LocalMachine\CA`

### Scenario 5: Certificates auto-downloaded but not permanently installed

**Symptom:** The verification tool shows `[MISS]` for intermediate certificates with the note `(was auto-downloaded via AIA during chain build)`. Chain validation passes.

**Resolution:** This symptom means the certificates are fetched at runtime but cached in `CurrentUser\CA`, not permanently installed. They persist across reboots but might be lost on reimage or if the user profile is recreated. To install permanently:

1. Download the certificates from [Azure Certificate Authority Details](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains).
1. Install to `LocalMachine\CA` using `certutil -addstore CA <certificate-file>`.

## Windows Server 2022 specific guidance

If you use Windows Server 2022, check if [KB 5036909](https://support.microsoft.com/topic/april-9-2024-kb5036909-os-build-20348-2402-36062ce9-f426-40c6-9fb9-ee5ab428da8c) is installed. This update includes certificate trust list updates that might resolve the issue. You can get it from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5036909).

## Additional resources

- [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)
- [Azure Instance Metadata Service Verification Tool](windows-vm-imds-tool.md)
- [Azure Instance Metadata Service Connection Issues](windows-vm-imds-connection.md)
- [Azure Certificate Authority Details](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains)
- [Azure Instance Metadata Service-Attested data TLS: Critical changes are here](https://techcommunity.microsoft.com/t5/azure-governance-and-management/azure-instance-metadata-service-attested-data-tls-critical/ba-p/2888953)
- [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details#certificate-downloads-and-revocation-lists)

[route-command]: /windows-server/administration/windows-commands/route_ws2008
