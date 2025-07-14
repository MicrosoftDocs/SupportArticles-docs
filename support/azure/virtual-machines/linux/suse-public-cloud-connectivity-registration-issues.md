---
title: Troubleshoot connectivity and registration for SUSE SLES VMs
description: Troubleshoot scenarios in which an Azure VM that has a SUSE Linux Enterprise Server image can't connect to the SUSE Subscription Management Tool (SMT) repository.
ms.date: 05/12/2025
author: rnirek
ms.author: hokamath
ms.reviewer: adelgadohell, mahuss, esanchezvela, scotro, v-weizhu, divargas, vkchilak
editor: v-jsitser
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
keywords:
#Customer intent: As a user who wants to set up an Azure virtual machine by using a SUSE Linux Enterprise Server image, I want establish an internet connection to the SUSE Subscription Management Tool repository so that I can successfully register the virtual machine.
---
# Troubleshoot connectivity and registration issues for SUSE Linux Enterprise Server VMs

**Applies to:** :heavy_check_mark: Linux VMs

This article discusses an issue in which a Microsoft Azure Virtual Machine (VM) is set up by using a SUSE Linux Enterprise Server (SLES) image, but the VM can't connect to the SUSE Subscription Management Tool (SMT) repository. This article provides some basic troubleshooting steps and actions to take for specific scenarios (such as failures in the Zypper command-line tool for managing packages in SUSE). Linux specialists at Microsoft assembled this information based on support experience and documentation from SUSE.

It's important to read the output of each command for more clues. We recommend that you save the results and messages for further troubleshooting.

## Prerequisites

- Internet access from the VM
- [Python](https://www.python.org/downloads/) language interpreter
- Client URL ([curl](https://curl.se/download.html)) tool
- [Zypper](https://documentation.suse.com/smart/systems-management/html/concept-zypper/index.html) package manager
- [OpenSSL](https://www.openssl.org/source/) toolkit
- [SUSEConnect](https://github.com/SUSE/connect) tool
- [registercloudguest](https://github.com/SUSE-Enceladus/cloud-regionsrv-client/blob/master/man/man1/registercloudguest.1) tool

> [!Note]
> If your SLES VM is behind a proxy server, we recommend that you review the technical considerations that are discussed in [Accessing the Public Cloud Update Infrastructure via a Proxy](https://www.suse.com/c/accessing-the-public-cloud-update-infrastructure-via-a-proxy/).
> For SLES VMs on Azure, the following conditions apply:
> - Connecting to update servers from a SLES VM relies on hostname resolution that can't be resolved by public DNS servers. Therefore, some Linux/Unix proxy server implementations might require that you manually put a record in */etc/hosts* on the proxy server side so that the "smt-azure" name can be resolved.
>
>    Here's an example record:
>    
>    `52.165.88.13 smt-azure.susecloud.net smt-azure`
>
>    The available IP addresses vary by Azure region. For more information, see the IP address list in [this smt XML file](https://susepubliccloudinfo.suse.com/v1/microsoft/servers/smt.xml).
> 
> - The IP addresses [168.63.129.16](/azure/virtual-network/what-is-ip-address-168-63-129-16) and 169.254.169.254 that are used by the [Instance Metadata Service (IMDS)](/azure/virtual-machines/instance-metadata-service) should bypass proxy access. These special IP addresses can't be accessed through a proxy server, and SLES VMs need information from IMDS to recognize the cloud environment that they're running on and to find an appropriate SUSE update server.
>
>    For example, the `NO_PROXY` variable in */etc/sysconfig/proxy* should be configured on SLES VMs such as the following:
>
>    `NO_PROXY="localhost, 127.0.0.1, 168.63.129.16, 169.254.169.254"  `

## Troubleshooting checklist

### <a id="step1"></a>Step 1: Run a repository diagnostic script

Run the [SUSEcloud repocheck script](https://raw.githubusercontent.com/SUSE/susecloud-repocheck/main/sc-repocheck.py) that's provided by Rich Paredes, a SUSE engineer. This Python script does the following tasks:

1. Check for connectivity to the SUSE public cloud repositories.

2. Try to fix any existing issues.

3. Create a log archive in the `/var/log/` directory, and name it *sc-repocheck_\<YYMMDD_hhmmss>.tar.xzq*. This log might be useful if the connection or registration issues persist.

To start the script, run the following command to transfer the script from its GitHub location to the Python interpreter:

```bash
sudo python3 <(curl --location --silent https://raw.githubusercontent.com/rfparedes/susecloud-repocheck/main/sc-repocheck.py)
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
sudo openssl s_client -connect <IP address>:443
```

After you run this command, the server certificate is displayed. The command also initiates a proper SSL connection.

The following example shows successful command output for the SUSE repository server in the East US 2 region (location code: `eastus2`, IP address: `20.186.112.116`):

```bash
$ echo "" | openssl s_client -connect 20.186.112.116:443
```

```output
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

> [!NOTE]
> To review the support scope of different SUSE versions, see [SUSE Lifeycle](https://www.suse.com/lifecycle).

## Scenario 1: No server certificate or SSL session is shown

The output doesn't show the server certificate or SSL session. 

### Cause

This scenario usually occurs when the command crosses a Network Virtual Appliance (NVA) that performs SSL packet inspection. This inspection causes the NVA to inject its own SSL certificate into the encrypted session.

Because SUSE uses certificate pinning, another injected SSL certificate can break the pinning operation. If the pinning is broken, the SUSE repository will deny the connection.

### Resolution

Make sure that the NVA doesn't do the following:

- Block access to the SUSE repository IP addresses
- Do SSL packet inspection on the secure connection to the SUSE repositories
- Insert the NVA SSL certificate on the server

## Scenario 2: Cloud-regionsrv-client issues and registration failures

To diagnose this scenario, check the state of the installed `cloud-regionsrv-client` package from the Zypper history or the list of installed RPM packages:

- From the Zypper history:

    ```bash
    sudo grep cloud-region /var/log/zypp/history
    ```

    ```output
    2021-07-12 08:20:49 cloud-regionsrv-client.rpm installed ok
    ```

- From the list of installed RPM packages:

    ```bash
    sudo rpm -qa | grep cloud-region
    ```

    ```output
    cloud-regionsrv-client-9.1.5-6.43.1.noarch
    cloud-regionsrv-client-plugin-azure-1.0.1-6.43.1.noarch
    ```

The main client package should be at least version `10.x`.  

As shown in the example, if you retry the manual re-registration or use the repocheck in [Step 1](#step1), the following output is displayed in `/var/log/cloudregister`:

```bash
sudo tail /var/log/cloudregister
```

```output
2025-01-29 20:20:05,876 INFO:Using API: regionInfo
2025-01-29 20:20:05,981 INFO:Region server arguments: ?regionHint=northcentralus
2025-01-29 20:20:05,981 INFO:Getting update server information, attempt 1
2025-01-29 20:20:05,981 INFO:   Using region server: 104.45.31.195
2025-01-29 20:20:06,184 ERROR:  No response from: 104.45.31.195
2025-01-29 20:20:06,184 INFO:   Using region server: 23.100.36.229
2025-01-29 20:20:06,286 ERROR:  No response from: 23.100.36.229
2025-01-29 20:20:06,286 INFO:   Using region server: 52.187.53.250
2025-01-29 20:20:06,915 INFO:No current registration server set.
2025-01-29 20:20:06,917 ERROR:No response from: [('23.101.171.119', '2603:1030:603::2e9'), ('23.101.164.199', '2603:1030:603::625'), ('23.96.231.74', '2603:1030:603::2e6')]
```

The output indicates that a connectivity error exists. However, this is not true. This indication occurs because the error handling process in the registration scripts doesn't show the certificate errors from the old libraries.

The script output might also mistakenly indicate that a certificate for one of the SMT IPs that's displayed in the `sudo tail /var/log/cloudregister` command output can't be found. This is also a library issue, not an issue that affects the CA list on the VM.

### Cause

If instances aren't regularly updated, they can become incompatible with our update infrastructure API. This situation causes failure of the repositories that are required to update an instance.

### Resolution

1. Create a PAYG instance by using the same OS as the that has broken repos.
2. Create a temporary directory:

    ```bash
    sudo mkdir -p /root/packages/rpms
    ```
3. Download the following packages based on SLES versions of the affected virtual machine:

   SLES 12
   ```bash
   sudo zypper --pkg-cache-dir /root/packages/ download cloud-regionsrv-client cloud-regionsrv-client-plugin-azure regionServiceClientConfigAzure python3-azuremetadata python3-cssselect python3-lxml python3-M2Crypto python3-zypp-plugin python3-dnspython suseconnect-ruby-bindings suseconnect-ng
   ```
   SLES 15
   ```bash
   sudo zypper --pkg-cache-dir /root/packages/ download cloud-regionsrv-client cloud-regionsrv-client-plugin-azure regionServiceClientConfigAzure python3-azuremetadata suseconnect-ng python3-cssselect python3-toml python3-lxml python3-M2Crypto python3-zypp-plugin python3-dnspython libsuseconnect suseconnect-ruby-bindings docker docker-bash-completion runc containerd libcontainers-common bash-completion
   ```
4. Run the following commands:

    ```bash
    sudo find /root/packages/ -type f -name "*.rpm" -exec cp {} /root/packages/rpms/ \;
    sudo cd /root/packages
    sudo tar -czvf suse-public-registration.tgz rpms
    ```

5. Transfer `suse-public-registration.tgz` to the broken instance:

    ```bash
    sudo scp /root/packages/suse-public-registration.tgz user@targetip:/tmp
    ```

    > [!NOTE]
    > Replace `user` and `targetip` as appropriate.

6. Sign in to the broken instance to extract and install the packages:

    ```bash
    sudo cd tmp
    sudo tar xvfz suse-public-registration.tgz
    sudo cd rpms
    sudo zypper --no-refresh --no-remote --non-interactive install --force *.rpm
    ```

7. Register the VM again:

    ```bash
    sudo registercloudguest --force-new
    ```
For more information, see [Cloud instance repos fail due to outdated packages](https://www.suse.com/support/kb/doc/?id=000021552).

## Scenario 3: General registration issues

### Cause

Your VM has stale credentials for repository access, or you receive messages that indicate that your system isn't being registered after you try to make updates or installations.

### Resolution

To fix most registration issues, specify the combination of the [SUSEConnect](https://github.com/SUSE/connect/blob/master/SUSEConnect.8.ronn) cleanup command and the [registercloudguest](https://github.com/SUSE-Enceladus/cloud-regionsrv-client/blob/master/man/man1/registercloudguest.1) command by using the `force-new` parameter:

```bash
sudo SUSEConnect --cleanup
sudo registercloudguest --force-new
```

> [!NOTE]
> If the VM is SLES SAP, you can also run the command by using the name of the SLES SAP product:
> 1. Run the `SUSEConnect` command to get the current registration status, including the name of the SLES SAP product:
>    ```bash
>    sudo SUSEConnect --url https://smt-azure.susecloud.net --status-text
>    ```
> 2. Run the `SUSEConnect` command by using the product name to activate the product:
>    ```bash
>    sudo SUSEConnect --url https://smt-azure.susecloud.net --product <SLES-SAP-product-name>
>    ```

If these commands are unsuccessful, clean up all repository information, and then try to register the VM. Any error messages that are related to the certificates and other components should disappear. Run the following commands:

```bash
sudo SUSEConnect --cleanup
sudo rm /etc/zypp/{credentials,services,repos}.d/*
sudo rm --force --recursive /var/cache/zypp/*
sudo rm /var/lib/cloudregister/*
sudo registercloudguest --force-new
```

Finally, verify the VM registration status by running SUSEConnect again:

```bash
sudo SUSEConnect --status
```

In the JSON command output, look for a `"status":"Registered"` entry.

## Scenario 4: No attested data supplied (422)

After you run the [repository diagnostic script](#step1), you might see the following error entry when the script tries to fix issues that affect the `zypper update`:

```output
Error: Activating SLES_SAP 12.5 x86_64 ... Error: Registration server returned 'Instance verification failed: No attested data supplied' (422)
```

### Cause

The VMs can't to connect to SUSE repositories because of outdated SUSE Public Cloud packages.

### Resolution

1. Run the [repository diagnostic script](#step1) again.

2. If the "422" error persists, modify the `/etc/regionserverclnt.cfg` configuration file to match the following text:

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
3. Re-register the VM:

    ```bash
    sudo registercloudguest --force-new
    ```
## Scenario 5: Errors for certain modules when trying to register to the SUSE repositories

When you try to register the VM to the SUSE repositories, you see the following error entries in `/var/log/cloudregister`:

```output
2024-01-31 19:22:44,947 INFO:Registration: /usr/sbin/SUSEConnect --url https://smt-azure.susecloud.net --product sle-module-legacy/12/x86_64 --instance-data /var/cache/cloudregister/0fc8a276-273c-4bd9-838d-6a2a41a637b0
2024-01-31 19:22:45,492 ERROR:  Registration failed: SUSEConnect error: Downloading https://smt-azure.susecloud.net/repo/SUSE/Products/SLE-Module-Legacy/12/x86_64/product.license/directory.yast failed (code: 401): <html>
<head><title>401 Authorization Required</title></head>
<body>
<center><h1>401 Authorization Required</h1></center>
<hr><center>nginx/1.21.5</center>
</body>
</html>
```

### Cause

The issue is caused by a bug in version 1.4.0 of the `suseconnect-ng` package.

These errors occur in the following modules only:

* sle-module-legacy
* sle-module-web-scripting
* sle-module-hpc
* sle-sdk

### Resolution

1. Move the following files from the `/etc/products.d` folder to the `/tmp` folder:

    - sle-module-hpc.prod
    - sle-module-legacy.prod
    - sle-module-web-scripting.prod
    - sle-sdk.prod

    ```bash
    sudo cd /etc/products.d 
    sudo mv sle-module-hpc.prod sle-module-legacy.prod sle-module-web-scripting.prod sle-sdk.prod /tmp 
    ```

2. Register the VM to the SUSE repositories:

    ```bash
    sudo registercloudguest --force-new
    ```

    ```output
    Registration should now be successful.
    ```

3. Refresh the repository cache:

    ```bash
    sudo zypper ref -s  
    ```

4. Update the `suseconnect-ng` package to version 1.6.0 or a later version, if necessary:

    > [!NOTE]
    > To verify the version of `suseconnect-ng`, run the following command:
    > ```bash
    > sudo  rpm -q suseconnect-ng
    > ```
    >
    > ```output
    >  suseconnect-ng-1.4.0~git0.b0f7c25bfdfa-3.3.8.x86_64
    > ```

    ```bash
    sudo zypper up suseconnect-ng
    ```

5. After `suseconnect-ng` is updated, restore the module definition files to `/etc/products.d`:

    ```bash
    sudo cd /tmp  
    sudo mv sle-module-hpc.prod sle-module-legacy.prod sle-module-web-scripting.prod sle-sdk.prod /etc/products.d
    ```

6. Rerun the registration to the repositories:

    ```bash
    sudo registercloudguest --force-new
    ```

    ```output
    Registration Successful
    ```

## Scenario 6: Registration fails with "WARNING:Found unknown entry in credentials file "system_token="" error

A "Found unknown entry in credentials file 'system_token='" warning message is logged in the `/var/log/cloudregister` log, and the VM can't register to the SUSE public cloud repositories:

```output
2023-10-24 17:50:58,140 DEBUG:Starting new HTTPS connection (1): smt-azure.susecloud.net:443
2023-10-24 17:50:58,243 ERROR:Registration with ('52.237.80.2', None) failed. Trying ('52.139.216.51', None)
2023-10-24 17:50:58,244 WARNING:Found unknown entry in credentials file "system_token=
"
2023-10-24 17:50:58,244 INFO:No current registration server set.
2023-10-24 17:50:58,247 INFO:Modified /etc/hosts, added: 52.139.216.51 smt-azure.susecloud.net smt-azure
2023-10-24 17:53:34,841 WARNING:Found unknown entry in credentials file "system_token=
"
```

### Cause

The issue occurs because of a wrong temporary certificate bundle, `ca-bundle.pem.tmp`.  

### Resolution

1. Remove the file, and update the `ca-certificates`:

    ```bash
    sudo registercloudguest --clean
    sudo rm /var/lib/ca-certificates/ca-bundle.pem.tmp
    ```
2. Update the certificates:

    ```bash
    sudo update-ca-certificates
    ```
3. Register the VM successfully:

    ```bash
    sudo registercloudguest --force-new
    ```

## Scenario 7: VM doesn't connect to SMT because of an azuremetadata error

When `/var/log/cloudregister` is checked, the following azuremetadata error message is displayed:

```bash
sudo tail -10 /var/log/cloudregister
```

```output
2020-10-30 22:47:43,200 INFO:No current registration server set.
2020-10-30 22:47:43,222 INFO:Modified /etc/hosts, added: 52.147.176.11 smt-azure.susecloud.net smt-azure

2020-10-30 22:48:03,358 ERROR:Data collected from stderr for instance data collection "b'An error occurred when fetching metadata:\ntimed out\nAn error occurred when fetching metadata:\ntimed out\nusage: azuremetadata [-h] [-x] [-j] [-o OUTPUT] [-a API] [--device [DEVICE]]\n [--attestedData [ATTESTEDDATA]]\n [--billingTag [BILLINGTAG]]\nazuremetadata: error: unrecognized arguments: --subscriptionId\n'"
2020-10-30 22:48:04,519 INFO:Writing SMT rootCA: /usr/share/pki/trust/anchors
2020-10-30 22:48:04,526 INFO:Updating CA certificates: update-ca-certificates
2020-10-30 22:48:06,569 INFO:No credentials entry for "*smt-azure_susecloud_net"
2020-10-30 22:48:06,608 ERROR:Unable to obtain product information from server "52.147.176.11,None"
Unprocessable Entity
{"type":"error","error":"The requested product 'SUSE Linux Enterprise Server for SAP Applications 15 SP2 x86_64' is not activated on this system.","localized_error":"The requested product 'SUSE Linux Enterprise Server for SAP Applications 15 SP2 x86_64' is not activated on this system."}
Unable to register modules, exiting.
```

Because of the azuremetadata error, the VM  can't connect to the Azure SUSE Cloud repository, as shown in the following output:

```bash
sudo  SUSEConnect -s
```

```output
Error: Invalid system credentials, probably because the registered system was deleted in SUSE Customer Center. Check https://scc.suse.com whether your system appears there. If it does not, please call SUSEConnect --cleanup and re-register this system.
```

```bash
sudo zypper repos
```

```output
Warning: There are no enabled repositories defined. Use 'zypper addrepo' or 'zypper modifyrepo' commands to add or enable repositories.
```

### Cause 1

The `--subscriptionId` entry is present in the configuration file `/etc/regionserverclnt.cfg`. This causes an error in the `azuremetadata` command:

```bash
sudo cat /etc/regionserverclnt.cfg
```
```output
[server]
api = regionInfo

certLocation = /var/lib/regionService/certs
regionsrv = 23.100.36.229,40.121.202.140,52.187.53.250,104.45.31.195,191.237.254.253

[instance]
dataProvider = /usr/bin/azuremetadata --api 2019-08-15 --subscriptionId --billingTag --xml
instanceArgs = msftazure
```

### Resolution 1

1. Remove `--subscriptionId` in the configuration file `/etc/regionserverclnt.cfg`:

    ```bash
    sudo sed -i "s/--subscriptionId //" regionserverclnt.cfg
    ```
2.  Re-register the VM: 

    ```bash
    sudo SUSEConnect --cleanup
    sudo rm -f /etc/SUSEConnect
    sudo rm -rf /etc/zypp/credentials.d/\*
    sudo rm /var/lib/cloudregister/*
    sudo rm /var/cache/zypp/*
    sudo sed -i '/^# Added by SMT reg/,+1d' /etc/hosts
    sudo registercloudguest --force-new
    ````

### Cause 2

When you register the SUSE server to the repo by using the `/usr/sbin/registercloudguest --force-new` command, an error occurs. The command output doesn't indicate that the registration succeeded because the `/etc/zypp/credentials.d/SCCcredentials` file was corrupted.

### Resolution 2

1. Move the `/etc/zypp/credentials.d` folder to a temporary folder:

    ```bash
    sudo mv /etc/zypp/credentials.d /tmp
    ```
2.  Re-register the VM:

    ```bash
    sudo SUSEConnect --cleanup
    sudo rm -f /etc/SUSEConnect
    sudo rm -rf /etc/zypp/credentials.d/\*
    sudo rm /var/lib/cloudregister/*
    sudo rm /var/cache/zypp/*
    sudo sed -i '/^# Added by SMT reg/,+1d' /etc/hosts
    sudo registercloudguest --force-new
    ````
## Scenario 8: SUSE registration fails because of compatibility issues with Python 3.11 in SLES 15 SP5

When you run the SUSE repo check script, *screpocheck.py*, a `ModuleNotFoundError: No module named 'cloudregister'` error message is displayed:

```bash
sudo python3 sc-repocheck.py
```

```output
2024-08-07 13:53:29,261 INFO:sc-repocheck 1.3.1 
2024-08-07 13:53:29,291 INFO: Checking package versions. 2024-08-07 13:53:29,307 INFO: Package versions OK. 2024-08-07 13:53:29,312 INFO: Checking baseproduct.
2024-08-07 13:53:29,316 INFO: SLES baseproduct OK.
2024-08-07 13:53:29,321 INFO: Checking /etc/hosts for multiple records. 2024-08-07 13:53:29,325 WARNING: No rmt records exist.
2024-08-07 13:53:29,325 INFO: Checking metadata access.
2024-08-07 13:53:29,360 INFO: Metadata OK.
2024-08-07 13:53:29,364 INFO: Checking regionserver access.
2024-08-07 13:53:31,160 INFO: Region server access OK.
2024-08-07 13:53:31,165 INFO: Checking RMT server entry is for correct region.
2024-08-07 13:53:31,241 ERROR: Cannot get IP of RMT server entry.
2024-08-07 13:53:31,252 INFO: http check unnecessary.
2024-08-07 13:53:31,246 INFO: Checking http port access to RMT servers.
2024-08-07 13:53:31,257 INFO: Checking https port access to RMT servers.
2024-08-07 13:53:31,337 INFO: https access OK.
2024-08-07 13:53:31,342 INFO: Checking https access using RMT certs.
2024-08-07 13:53:31,442 INFO: An exception of type ConnectionError occurred. Disregarding.
2024-08-07 13:53:31,449 INFO: EVERYTHING OK.
2024-08-07 13:53:31,453 INFO: Collecting debug data. Please wait 1-2 minutes maybe longer, depending on machine type. Traceback (most recent call last):
File "/usr/bin/azuremetadata", line 11, in <module>
from azuremetadata import azuremetadatautils, azuremetadata
ModuleNotFoundError: No module named 'azuremetadata'
2024-08-07 13:53:31,565 ERROR: PROBLEM: Issue with azuremetadata output. Check metadata access. Traceback (most recent call last):
File "/usr/sbin/registercloudguest", line 43, in <module>
import cloudregister.registerutils as utils
ModuleNotFoundError: No module named 'cloudregister'
2024-08-07 13:53:34,656 INFO: Check repositories. An attempt was made to fix.
2024-08-07 13:53:34,659 INFO: Debug data location: /var/log/sc-repocheck_240807_135331.tar.xz
2024-08-07 13:53:34,671 INFO: Report bugs to https://github.com/SUSE/susecloud-repocheck/issues
```

### Cause

No supported modules are available together with Python 3.11.

### Workaround

According to SUSE, the package doesn't yet support Python 3.11 on SLES15 SP5. Don't use Python 3.11 as the default `python3` interpreter on existing SLES systems because it's currently unsupported in all SLES systems.

For more information, see [incompatible-changes-ahead-for-public-cloud-sdks](https://www.suse.com/c/incompatible-changes-ahead-for-public-cloud-sdks/).

To work around the issue, set the VM to use the default Python version 3.6: 

1. Point the Python version to `3.6.x`:

    ```bash
    sudo unlink /usr/bin/python3
    sudo ln -s /usr/bin/python3.6 /usr/bin/python3
    ```

2. Verify the `python3` version in the VM:

    ```bash
    sudo python3 --version
    ```

    ```output
    Python 3.6.15
    ```

3. Re-register the VM:

    ```bash
    sudo /usr/sbin/registercloudguest --force-new
    ```

    ```output
    Registration succeeded
    ```

4. Verify that the VM is successfully registered:

    ```bash
    sudo SUSEConnect -s 
    ```

    ```output
    [{"identifier":"SLES", "version":"15.5","arch":"x86_64","status":"Registered"},{"identifier": "sle-module-basesystem", "version":"15.5","arch":"x86_6
    ,"status":"Registered"},{"identifier": "sle-module-containers", "version":"15.5","arch":"x86 64","status":"Registered"},{"identifier": "sle-module-de top-applications","version":"15.5","arch":"x86 64","status":"Registered"},{"identifier": "sle-module-development-tools","version":"15.5"," 64","status":"Registered"},{"identifier":"sle-module-public-cloud", "version":"15.5","arch":"x86 64","status":"Registered"},{"identifier": "sle-modu -python3","version":"15.5","arch":"x86 64","status":"Registered"},{"identifier": "sle-module-server-applications","version":"15.5","arch":"x86 64",
    tatus":"Registered"}, {"identifier": "sle-module-web-scripting", "version":"15.5","arch":"x86 64","status":"Registered"}]
    ```

## Next steps

If your issue isn't resolved, [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot), and attach a copy of the `sc-repocheck_\<YYMMDD_hhmmss>.tar.xzq` log for further troubleshooting. 

## More information

For more information about [Endorsed Linux distributions](/azure/virtual-machines/linux/endorsed-distros) and open-source technologies in Azure, see [Support for Linux and open source technology in Azure](support-linux-open-source-technology.md).

## Third-party information disclaimer

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

## Third-party contact information disclaimer

Microsoft provides third-party contact information to help you find additional information about this topic. This contact information may change without notice. Microsoft does not guarantee the accuracy of third-party contact information.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
