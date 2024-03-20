---
title: Troubleshoot connectivity and registration for SUSE SLES VMs
description: Troubleshoot scenarios in which an Azure VM that has a SUSE Linux Enterprise Server image can't connect to the SUSE Subscription Management Tool (SMT) repository.
ms.date: 04/29/2023
author: DennisLee-DennisLee
ms.author: hokamath
ms.reviewer: adelgadohell, mahuss, esanchezvela, scotro
editor: v-jsitser
ms.service: virtual-machines
ms.subservice: vm-cannot-connect
ms.custom: linux-related-content
keywords:
#Customer intent: As a user who wants to set up an Azure virtual machine by using a SUSE Linux Enterprise Server image, I want establish an internet connection to the SUSE Subscription Management Tool repository so that I can successfully register the virtual machine.
---
# Troubleshoot connectivity and registration issues for SUSE Linux Enterprise Server VMs

This article addresses a situation in which an Azure virtual machine (VM) is set up by using a SUSE Linux Enterprise Server (SLES) image, but the VM can't connect to the SUSE Subscription Management Tool (SMT) repository. The article describes some basic troubleshooting steps, and it outlines actions to take for specific scenarios (such as failures in Zypper, which is the SUSE command-line tool for managing packages). Linux specialists at Microsoft assembled this information based on support experience and documentation from SUSE.

It's important to read the output of each command for more clues. We recommend that you save the results and messages for further troubleshooting.

## Prerequisites

- Internet access from the VM.
- The [Python](https://www.python.org/downloads/) language interpreter.
- The Client URL ([curl](https://curl.se/download.html)) tool.
- The [Zypper](https://documentation.suse.com/smart/systems-management/html/concept-zypper/index.html) package manager.
- The [OpenSSL](https://www.openssl.org/source/) toolkit.
- The [SUSEConnect](https://github.com/SUSE/connect) tool.
- The [registercloudguest](https://github.com/SUSE-Enceladus/cloud-regionsrv-client/blob/master/man/man1/registercloudguest.1) tool.

## Troubleshooting checklist

### Step 1: Run a repository diagnostic script

Run the [SUSEcloud repocheck script](https://github.com/rfparedes/susecloud-repocheck) that's provided by Rich Paredes, a SUSE engineer. This Python script does the following tasks:

1. Check for connectivity to the SUSE public cloud repositories.

1. Try to fix any existing issues.

1. Create a log archive in the */var/log/* directory, and name it *sc-repocheck_\<YYMMDD_hhmmss>.tar.xzq*. This log might be useful if the connection or registration issues persist.

To start the script, run the following command to transfer the script from its GitHub location onto the Python interpreter:

```bash
python3 <(curl --location --silent https://raw.githubusercontent.com/rfparedes/susecloud-repocheck/main/sc-repocheck.py)
```

To run successfully, the command requires internet access from the VM. Otherwise, you have to download the script first, and then modify the command so that it runs.

### Step 2: Check connectivity to server IP addresses on port 443

The VM must be able to open a TCP connection on port 443 to the SUSE repository server `smt-azure.susecloud.net` (based on the region where the VM is located) together with the region servers. The list of IP addresses for the repository server and the region servers can be found at the following locations.

| IP address type | URL containing the IP address list |
| --------------- | ---------------------------------- |
| SMT server IP addresses for all the regions | <https://susepubliccloudinfo.suse.com/v1/microsoft/servers/smt.xml> |
| Region server IP addresses | <https://susepubliccloudinfo.suse.com/v1/microsoft/servers/regionserver.xml> |

To check the repository server and region server connections for your region, use the [OpenSSL s_client command](https://www.openssl.org/docs/man3.0/man1/openssl-s_client.html) for Secure Sockets Layer (SSL) and Transport Layer Security (TLS) clients. Insert the appropriate IP address for the placeholder into the following syntax:

```bash
openssl s_client -connect <IP address>:443
```

After you run this command, the server certificate is displayed. The command also initiates a proper SSL connection.

The following example shows successful command output for the SUSE repository server in the East US 2 region (location code `eastus2`, IP address `20.186.112.116`):

```console
$ echo "" | openssl s_client -connect 20.186.112.116:443
CONNECTED(00000003)
Can't use SSL_get_servername
depth=1 C = DE, ST = Bavaria, L = Nuremberg, O = SUSE, OU = CSM, CN = SUSE, emailAddress = suse-public-cloud@susecloud.net
verify return:1
depth=0 C = DE, ST = Bavaria, L = Nuremberg, O = SUSE, OU = Public Cloud, CN = Update server certificate (smt-azure.susecloud.net), emailAddress = suse-public-cloud@susecloud.net
verify return:1
---
Certificate chain
 0 s:C = DE, ST = Bavaria, L = Nuremberg, O = SUSE, OU = Public Cloud, CN = Update server certificate (smt-azure.susecloud.net), emailAddress = suse-public-cloud@susecloud.net
   i:C = DE, ST = Bavaria, L = Nuremberg, O = SUSE, OU = CSM, CN = SUSE, emailAddress = suse-public-cloud@susecloud.net
---
Server certificate
-----BEGIN CERTIFICATE-----
<64-character lines of printable ASCII characters>
    .
    .
    .
-----END CERTIFICATE-----
subject=C = DE, ST = Bavaria, L = Nuremberg, O = SUSE, OU = Public Cloud, CN = Update server certificate (smt-azure.susecloud.net), emailAddress = suse-public-cloud@susecloud.net

issuer=C = DE, ST = Bavaria, L = Nuremberg, O = SUSE, OU = CSM, CN = SUSE, emailAddress = suse-public-cloud@susecloud.net

---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS
Server Temp Key: X25519, 253 bits
---
SSL handshake has read 2538 bytes and written 373 bytes
Verification: OK
---
New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
Server public key is 4096 bit
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---
DONE
```

## Cause 1: No server certificate or SSL session shown

The output doesn't show the server certificate or SSL session. This scenario often occurs if the command traverses a network virtual appliance (NVA) that does SSL packet inspection. This inspection causes the NVA to inject its own SSL certificate into the encrypted session. Because SUSE uses certificate pinning, another injected SSL certificate can break the pinning operation. If pinning is broken, the SUSE repository denies the connection.

### Action 1: Fix the network virtual appliance configuration

Make sure that the network virtual appliance doesn't do the following:

- Block access to the SUSE repository IP addresses.
- Do SSL packet inspection on the secure connection to the SUSE repositories.
- Insert the NVA SSL certificate on the server.

## Cause 2: Outdated cloud infrastructure information

SUSE made a [public cloud infrastructure update](https://www.suse.com/support/kb/doc/?id=000019633) on June 1, 2020. This change might cause connectivity issues for older VMs or for VMs that are newly deployed from older marketplace images.

### Action 2: Update the SUSE public cloud infrastructure

1. On a problematic VM, you have to download and extract an Azure offline update, and then use Zypper to update the packages manually. Run the following commands by replacing the `<SLE-base>` placeholder with the version of the SLES that's used on the VM (either `SLE12` or `SLE15`):

   ```bash
   archiveFileName=late_instance_offline_update_azure_<SLE-base>.tar.gz
   wget --no-check-certificate https://52.188.224.179/$archiveFileName
   sha1sum $archiveFileName
   tar --extract --file=$archiveFileName
   cd x86_64
   zypper --no-refresh --no-remote --non-interactive install *.rpm
   ```

1. Rerun the [diagnostic script](#step-1-run-a-repository-diagnostic-script) to fix the repository issues.

## Cause 3: Unprocessable entity errors

SUSE now requires that VMs use attested data when they connect to the SUSE public cloud infrastructure. Otherwise, the following error is logged in the */var/log/cloudregister* file:

>2021-06-22 17:27:33,950 ERROR: Unable to obtain product information from server "52.157.241.14,None"
>
>Unprocessable Entity
>
>{  
> "type": "error",  
> "error": "The requested product 'SUSE Linux Enterprise Server for SAP Applications 15 SP1 x86_64' is not activated on this system.",  
> "localized_error": "The requested product 'SUSE Linux Enterprise Server for SAP Applications 15 SP1 x86_64' is not activated on this system."  
>}
>
>Unable to register modules, exiting.

### Action 3: Update to the latest Azure and Azure Hybrid Benefit packages

If you install the public cloud infrastructure update and Azure Hybrid Benefit, your VM uses attested data and avoids unprocessable entity errors. To do this, follow these steps:

1. Make sure that you install the [Azure offline update for the SUSE public cloud infrastructure](#action-2-update-the-suse-public-cloud-infrastructure) from Cause 2.

1. Run the following commands on the VM to install the [Azure Hybrid Benefit for SUSE Linux Enterprise](https://www.suse.com/c/suse-linux-enterprise-and-azure-hybrid-benefit/). Again, replace the `<SLE-base>` placeholder with the VM SLES version (`SLE12` or `SLE15`):

    ```bash
    ahbFileName=late_instance_offline_ahb_<SLE-base>.tar.gz
    wget --no-check-certificate https://52.188.224.179/$ahbFileName
    sha1sum $ahbFileName
    tar --extract --file=$ahbFileName
    cd late_update
    zypper --no-refresh --no-remote --non-interactive install *.rpm
    ```

1. Rerun the [diagnostic script](#step-1-run-a-repository-diagnostic-script) to fix the repository issues.

## Cause 4: General registration issues

Your VM has stale credentials for repository access, or you get messages about your system not being registered after you try to make updates or installations.

### Action 4: Force registration

To fix most registration issues, specify the combination of the [SUSEConnect](https://github.com/SUSE/connect/blob/master/SUSEConnect.8.ronn) cleanup command and the [registercloudguest](https://github.com/SUSE-Enceladus/cloud-regionsrv-client/blob/master/man/man1/registercloudguest.1) command by using the **force-new** parameter:

```bash
SUSEConnect --cleanup
registercloudguest --force-new
```

If those commands don't fix the registration, try running the following SUSEConnect command to get the current registration status, including the name of the SLES SAP product:

```bash
SUSEConnect --url https://smt-azure.susecloud.net --status-text
```

Using that product name, run this SUSEConnect command to activate the product:

```bash
SUSEConnect --url https://smt-azure.susecloud.net --product <SLES-SAP-Product-name>
```

If those commands are unsuccessful, clean up all repository information, and then try to register the VM. Then, any errors that are related to the certificates and other components should disappear. Run the following commands:

```bash
SUSEConnect --cleanup
rm /etc/zypp/{credentials,services,repos}.d/*
rm --force --recursive /var/cache/zypp/*
rm /var/lib/cloudregister/*
registercloudguest --force-new
```

Finally, verify the VM registration status by running SUSEConnect again:

```bash
SUSEConnect --status
```

In the JSON command output, look for a `"status":"Registered"` entry.

## Cause 5: No attested data supplied (422)

After you run the [repository diagnostic script](#step-1-run-a-repository-diagnostic-script), you might experience the following error while the script tries to fix issues that affect the Zypper update:

> Error: Activating SLES_SAP 12.5 x86_64 ... Error: Registration server returned 'Instance verification failed: No attested data supplied' (422)

### Action 5: Fix the Zypper update issue

1. If you haven't already done this, [update the SUSE public cloud infrastructure](#action-2-update-the-suse-public-cloud-infrastructure), as described in Cause 2.

1. Run the [diagnostic script](#step-1-run-a-repository-diagnostic-script) again.

1. If the "422" error persists, modify the */etc/regionserverclnt.cfg* configuration file to resemble the following text:

    ```config
    [server]
    api = regionInfo
    certLocation = /var/lib/regionService/certs
    regionsrv = 23.100.36.229,40.121.202.140,52.187.53.250,104.45.31.195,191.237.254.253
    
    [instance]
    dataProvider = /usr/bin/azuremetadata --api latest --subscriptionId --billingTag --attestedData --signature --xml
    instanceArgs = msftazure
    httpsOnly = true
    ```

## Next steps

If you require further help, see [Support and troubleshooting for Azure VMs](/azure/virtual-machines/vm-support-help). That article can also help you file an Azure support incident, if necessary. As you follow the instructions, keep a copy of the *sc-repocheck_\<YYMMDD_hhmmss>.tar.xzq* log archive because it might be requested for inspection by the support engineer.

## More information

For more information about [Endorsed Linux distributions](/azure/virtual-machines/linux/endorsed-distros) and open-source technologies in Azure, see [Support for Linux and open source technology in Azure](../../cloud-services-classic/support-linux-open-source-technology.md).

## Third-party information disclaimer

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
