---
title: Troubleshoot Azure IMDS Certificate Chain Failures
description: Learn how to diagnose and fix IMDS attestation certificate chain failures on Linux Azure VMs across major distributions. Follow these steps.
ms.service: azure-virtual-machines
ms.date: 07/10/2026
author: kaushika-msft
ms.author: kaushika
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.reviewer: scotro, jugross, azurevmcptcic
---
# Troubleshoot IMDS certificate chain issues on Linux VMs

**Applies to:** :heavy_check_mark: Linux VMs

## Summary

This article helps you troubleshoot certificate chain problems with the Azure Instance Metadata Service (IMDS) attestation endpoint on Linux VMs. These problems can affect applications that rely on IMDS attested data for VM identity verification, licensing validation, or security token acquisition.

> [!NOTE]
> For Windows VMs, see [IMDS certificate chain issues on Windows](../windows/windows-vm-imds-certissues.md).

## Certificate chain architecture

IMDS attestation uses a four-level certificate chain that's the same across Windows and Linux:

```
DigiCert Global Root G2 (Root CA)
  +-- Microsoft TLS RSA Root G2 (cross-signed intermediate)
        +-- Microsoft TLS G2 RSA CA OCSP xx (OCSP responder intermediate)
              +-- CN=metadata.azure.com (leaf certificate)
```

> [!IMPORTANT]
> **"Microsoft TLS RSA Root G2" isn't a root CA** despite its name. It's a cross-signed intermediate certificate issued by DigiCert Global Root G2.

> [!NOTE]
> **IMDS rotates OCSP intermediates.** Azure uses multiple OCSP responder intermediates numbered 02 through 16. Your VM might use any one of them.

### Key difference from Windows

Unlike Windows, most Linux distributions **don't automatically download** missing intermediate certificates through AIA (Authority Information Access). If an intermediate certificate is missing from the trust store, the chain build fails immediately. This limitation makes the problem more visible on Linux but also means the fix is straightforward: install the missing certificate.

## Symptoms

Applications that query the IMDS attested endpoint fail with certificate or SSL errors. Common symptoms include:

- `curl` to the IMDS attested endpoint returns certificate verification errors
- Python applications raise `ssl.SSLCertVerificationError`
- Java applications report `sun.security.validator.ValidatorException`
- Custom licensing or identity verification fails silently

## How to diagnose

### Step 1: Verify IMDS is reachable

```bash
curl -s -H "Metadata:true" \
  "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | head -c 200
```

If this command returns JSON metadata, IMDS connectivity is working. The issue is specific to the attested endpoint and certificates.

### Step 2: Fetch the attested document and inspect the certificate chain

```bash
# Get the attested document
ATTESTED=$(curl -s -H "Metadata:true" \
  "http://169.254.169.254/metadata/attested/document?api-version=2018-10-01")

# Extract the signing certificate from the PKCS#7 signature
echo "$ATTESTED" | python3 -c "
import json, sys, base64
doc = json.load(sys.stdin)
sig = base64.b64decode(doc['signature'])
with open('/tmp/imds_sig.der', 'wb') as f:
    f.write(sig)
print('Signature saved to /tmp/imds_sig.der')
"

# Extract the certificate from the PKCS#7 envelope
openssl pkcs7 -in /tmp/imds_sig.der -inform DER -print_certs -out /tmp/imds_cert.pem 2>/dev/null

# View the certificate details
openssl x509 -in /tmp/imds_cert.pem -noout -subject -issuer -dates
```

### Step 3: Verify the certificate chain

```bash
# Check if the chain validates against the system trust store
openssl verify -verbose /tmp/imds_cert.pem 2>&1
```

If you see `error 20 at 0 depth lookup: unable to get local issuer certificate`, an intermediate or root certificate is missing from the trust store.

### Step 4: Determine which OCSP intermediate your VM uses

IMDS rotates OCSP intermediates. Before installing certificates, determine which one your VM uses:

```bash
# Extract the OCSP number from the leaf certificate's issuer
OCSP_ISSUER=$(openssl x509 -in /tmp/imds_cert.pem -noout -issuer)
echo "Leaf issuer: $OCSP_ISSUER"
OCSP_NUM=$(echo "$OCSP_ISSUER" | grep -oP 'OCSP \K[0-9]+')
echo "Your VM uses OCSP: $OCSP_NUM"
```

Use this OCSP number in the install commands in the following sections. The examples use `04` but your VM might use a different number (02, 06, 08, 10, 12, 14, or 16).

### Step 5: Check which certificates are in the trust store

```bash
# Check for DigiCert Global Root G2
awk -v cmd='openssl x509 -noout -subject' '/BEGIN/{close(cmd)};{print | cmd}' \
  /etc/ssl/certs/ca-certificates.crt 2>/dev/null | grep -i "DigiCert Global Root G2"

# Check for Microsoft TLS RSA Root G2
awk -v cmd='openssl x509 -noout -subject' '/BEGIN/{close(cmd)};{print | cmd}' \
  /etc/ssl/certs/ca-certificates.crt 2>/dev/null | grep -i "Microsoft TLS"
```

### Step 6: Test connectivity to certificate download endpoints

```bash
# Test AIA endpoints (port 80)
for host in cacerts.digicert.com caissuers.microsoft.com www.microsoft.com; do
    if curl -s --connect-timeout 5 -o /dev/null "http://$host"; then
        echo "[OK] $host"
    else
        echo "[BLOCKED] $host"
    fi
done
```

## Resolution

### Install missing certificates

Download and install the intermediate certificates that are missing from your trust store. You might need to install both the cross-signed intermediate and the OCSP responder intermediate.

> [!IMPORTANT]
> The certificate download URL provides files in **DER format**. Linux trust stores require **PEM format**. Always convert with `openssl x509 -inform DER` before installing.

> [!NOTE]
> IMDS rotates OCSP intermediates (numbered 02 through 16). Check the issuer of your leaf certificate (Step 4) to determine which OCSP intermediate your VM uses. Replace `04` in the download URL below with your VM's actual OCSP number. For example, if your VM uses OCSP 10, change `OCSP%2004` to `OCSP%2010`.

#### [Ubuntu / Debian](#tab/ubuntu)

```bash
# Install the cross-signed intermediate (Microsoft TLS RSA Root G2)
sudo curl -s -o /tmp/microsoft-tls-rsa-root-g2.der \
  "http://caissuers.microsoft.com/pkiops/certs/Microsoft%20TLS%20RSA%20Root%20G2%20-%20xsign.crt"
sudo openssl x509 -in /tmp/microsoft-tls-rsa-root-g2.der -inform DER \
  -out /usr/local/share/ca-certificates/microsoft-tls-rsa-root-g2.crt

# Install the OCSP intermediate (replace 04 with your VM's OCSP number)
sudo curl -s -o /tmp/microsoft-tls-g2-rsa-ca-ocsp.der \
  "https://www.microsoft.com/pkiops/certs/Microsoft%20TLS%20G2%20RSA%20CA%20OCSP%2004.crt"
sudo openssl x509 -in /tmp/microsoft-tls-g2-rsa-ca-ocsp.der -inform DER \
  -out /usr/local/share/ca-certificates/microsoft-tls-g2-rsa-ca-ocsp.crt

# Update the certificate store
sudo update-ca-certificates
```

#### [RHEL / CentOS / Oracle Linux / Azure Linux](#tab/rhel)

```bash
# Install the cross-signed intermediate
sudo curl -s -o /tmp/microsoft-tls-rsa-root-g2.der \
  "http://caissuers.microsoft.com/pkiops/certs/Microsoft%20TLS%20RSA%20Root%20G2%20-%20xsign.crt"
sudo openssl x509 -in /tmp/microsoft-tls-rsa-root-g2.der -inform DER \
  -out /etc/pki/ca-trust/source/anchors/microsoft-tls-rsa-root-g2.crt

# Install the OCSP intermediate (replace 04 with your VM's OCSP number)
sudo curl -s -o /tmp/microsoft-tls-g2-rsa-ca-ocsp.der \
  "https://www.microsoft.com/pkiops/certs/Microsoft%20TLS%20G2%20RSA%20CA%20OCSP%2004.crt"
sudo openssl x509 -in /tmp/microsoft-tls-g2-rsa-ca-ocsp.der -inform DER \
  -out /etc/pki/ca-trust/source/anchors/microsoft-tls-g2-rsa-ca-ocsp.crt

# Update the certificate store
sudo update-ca-trust
```

#### [SUSE / openSUSE](#tab/suse)

```bash
# Install the cross-signed intermediate
sudo curl -s -o /tmp/microsoft-tls-rsa-root-g2.der \
  "http://caissuers.microsoft.com/pkiops/certs/Microsoft%20TLS%20RSA%20Root%20G2%20-%20xsign.crt"
sudo openssl x509 -in /tmp/microsoft-tls-rsa-root-g2.der -inform DER \
  -out /usr/share/pki/trust/anchors/microsoft-tls-rsa-root-g2.crt

# Install the OCSP intermediate (replace 04 with your VM's OCSP number)
sudo curl -s -o /tmp/microsoft-tls-g2-rsa-ca-ocsp.der \
  "https://www.microsoft.com/pkiops/certs/Microsoft%20TLS%20G2%20RSA%20CA%20OCSP%2004.crt"
sudo openssl x509 -in /tmp/microsoft-tls-g2-rsa-ca-ocsp.der -inform DER \
  -out /usr/share/pki/trust/anchors/microsoft-tls-g2-rsa-ca-ocsp.crt

# Update the certificate store
sudo update-ca-certificates
```

---

### Verify the fix

After installing the certificates, verify the chain validates:

```bash
# Re-fetch and verify
curl -s -H "Metadata:true" \
  "http://169.254.169.254/metadata/attested/document?api-version=2018-10-01" \
  | python3 -c "import json,sys,base64; d=json.load(sys.stdin); open('/tmp/imds_sig.der','wb').write(base64.b64decode(d['signature']))"

openssl pkcs7 -in /tmp/imds_sig.der -inform DER -print_certs -out /tmp/imds_cert.pem 2>/dev/null
openssl verify -verbose /tmp/imds_cert.pem
```

A successful output shows:

```output
/tmp/imds_cert.pem: OK
```

> [!TIP]
> You can also use the `--autofix` flag with the [verification tool](linux-vm-imds-tool.md) to automate the download, conversion, installation, trust store update, and re-validation in one step.

## Additional scenarios

### Clock skew causing validation failure

**Symptom:** `openssl verify` fails with `certificate is not yet valid` or `certificate has expired`, even though the certificates should be current.

**Cause:** The VM's system clock is significantly off. Certificate validation checks `notBefore` and `notAfter` against the local clock.

**How to detect:**

```bash
# Check current time vs NTP
date -u
chronyc tracking 2>/dev/null || ntpq -p 2>/dev/null
```

**Resolution:**

```bash
# Force time sync (chrony)
sudo chronyc makestep

# Or force time sync (ntpd)
sudo ntpdate time.windows.com
```

After syncing the clock, rerun `openssl verify /tmp/imds_cert.pem`.

### Expired intermediate certificate

**Symptom:** The intermediate certificate is present in the trust store, but `openssl verify` still fails. The certificate's `notAfter` date is in the past.

**How to detect:**

```bash
# Check expiry of the OCSP intermediate
openssl x509 -in /tmp/imds_cert.pem -noout -issuer -dates
```

**Resolution:** Download the fresh certificate and reinstall it by using the distro-specific commands in the preceding Resolution section. The verification tool's `--autofix` flag handles this step automatically.

### Proxy blocks AIA but not IMDS

**Symptom:** IMDS is reachable (Step 1 passes), but certificate download endpoints are blocked (Step 6 fails).

**Cause:** IMDS uses a link-local address (`169.254.169.254`) that bypasses proxy settings. Certificate download URLs go through the configured proxy. If the proxy blocks the AIA endpoints, certificate downloads fail.

**How to detect:**

```bash
# Check proxy settings
echo "http_proxy=$http_proxy"
echo "https_proxy=$https_proxy"
env | grep -i proxy
```

**Resolution:** Add the AIA and CRL endpoints to the `no_proxy` environment variable:

```bash
export no_proxy="$no_proxy,caissuers.microsoft.com,www.microsoft.com,cacerts.digicert.com,crl3.digicert.com,crl4.digicert.com,ocsp.digicert.com,oneocsp.microsoft.com"
```

To make this change permanent, add the `export` line to `/etc/environment` or `/etc/profile.d/proxy.sh`.

### Preinstalled certificates approaching expiry

**Symptom:** IMDS works for months, then suddenly starts failing. All AIA endpoints are blocked (firewall policy). The VM relies on preinstalled certificates.

**Cause:** If you block AIA, preinstall all intermediate certificates. These certificates have expiration dates. When they expire, the chain fails and the VM can't autoload replacements.

**How to detect:**

```bash
# Check expiry of installed Microsoft TLS certs
for cert in /usr/local/share/ca-certificates/microsoft-*.crt \
             /etc/pki/ca-trust/source/anchors/microsoft-*.crt \
             /usr/share/pki/trust/anchors/microsoft-*.crt; do
    [ -f "$cert" ] && echo "$(openssl x509 -in "$cert" -noout -enddate 2>/dev/null) $cert"
done
```

**Resolution:**

1. Download fresh certificates from the [Azure Certificate Authority Details](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains) page.
1. To prevent future expiry issues when AIA is blocked, preinstall **all** OCSP intermediate variants (02 through 16). This way the VM survives OCSP rotation without needing to download anything:

   ```bash
   for NUM in 02 04 06 08 10 12 14 16; do
       curl -s -o "/tmp/ocsp-${NUM}.der" \
           "https://www.microsoft.com/pkiops/certs/Microsoft%20TLS%20G2%20RSA%20CA%20OCSP%20${NUM}.crt"
       openssl x509 -in "/tmp/ocsp-${NUM}.der" -inform DER \
           -out "/usr/local/share/ca-certificates/microsoft-tls-g2-rsa-ca-ocsp-${NUM}.crt"
   done
   sudo update-ca-certificates
   ```

   > [!NOTE]
   > The cert install path shown is for Ubuntu/Debian. For RHEL, use `/etc/pki/ca-trust/source/anchors/` and `update-ca-trust`. For SUSE, use `/usr/share/pki/trust/anchors/` and `update-ca-certificates`.

## Firewall considerations

If your VM's firewall blocks outbound HTTP (port 80), you can't download certificates from AIA endpoints. Ensure the following endpoints are accessible:

| Purpose | Endpoints |
|---|---|
| **AIA** (certificate download) | `cacerts.digicert.com`, `caissuers.microsoft.com`, `www.microsoft.com` |
| **CRL** (revocation lists) | `crl3.digicert.com`, `crl4.digicert.com` |
| **OCSP** (online validation) | `ocsp.digicert.com`, `oneocsp.microsoft.com` |

For more information, see [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details#certificate-downloads-and-revocation-lists).

## Additional resources

- [Azure Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service)
- [IMDS certificate chain issues on Windows](../windows/windows-vm-imds-certissues.md)
- [Azure Certificate Authority Details](/azure/security/fundamentals/azure-ca-details?tabs=certificate-authority-chains)
- [Certificate downloads and revocation lists](/azure/security/fundamentals/azure-ca-details#certificate-downloads-and-revocation-lists)
