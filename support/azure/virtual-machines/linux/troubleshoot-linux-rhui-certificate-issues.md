---
title: Troubleshoot Common Certificate Issues in RHUI
description: Troubleshoot common Red Hat Update Infrastructure certificate issues in Azure that are caused by expired or missing TLS or SSL certificates.
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas-msft, pagienge, navpreetkaur, v-weizhu
editor: v-jsitser
ms.date: 01/08/2025
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---

# Troubleshoot RHUI certificate issues in Azure

**Applies to:** :heavy_check_mark: Linux VMs

This article discusses common issues in the Red Hat Update Infrastructure (RHUI) that are caused by expired or missing Transport Layer Security (TLS) or Secure Sockets Layer (SSL) certificates.

## Prerequisites

- SSH access to the corresponding [Red Hat Enterprise Linux (RHEL) Pay-As-You-Go (PAYG) virtual machine (VM) in Azure](/azure/virtual-machines/workloads/redhat/redhat-rhui)

- Root privileges

> [!IMPORTANT]
> RHUI is intended for only pay-as-you-go images. Are you using custom or golden images (also known as "bring-your-own-subscription (BYOS)") instead? In that case, the system has to be attached to Red Hat Subscription Manager (RHSM) or Satellite in order to receive updates. For more information, see [How to register and subscribe an RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

> [!NOTE]
> - Starting on October 12, 2023, all pay-as-you-go (PAYG) clients have been directed to the RHUI-4 IPs in phases. The RHUI-3 IPs remain available for continued updates, but will be removed in the future. To ensure uninterrupted access to packages and updates, you must update existing routes and rules that allow access to RHUI-3 IPs to include RHUI-4 IP addresses. However, in order to continue receiving updates during this transition period, don't remove RHUI-3 IPs.
> - Starting on January 2020, the new Azure US Government images began using the public IP addresses that were mentioned previously under the Azure Global header.

> [!NOTE]
> Starting June 30, 2024, RHEL 7 reaches the end of the Maintenance Support 2 phase. This maintenance phase is followed by the Extended Life phase. As RHEL 7 transitions out of the full maintenance phases, customers should upgrade to RHEL 8 or 9. If your organization must stay on RHEL 7, we recommended that you install the Red Hat Enterprise Linux Extended Life Cycle Support (ELS) Add-on.
> For more information, see [Extended Life Cycle Support](/azure/virtual-machines/workloads/redhat/redhat-extended-lifecycle-support)


## Cause 1: RHUI client certificate is expired

The Azure RHUI certificates typically expire every two years. If you use an older RHEL VM image, such as RHEL version 7.4 (image URN: `RedHat:RHEL:7.4:7.4.2018010506`), you experience degraded connectivity to RHUI because of a now-expired TLS/SSL client certificate. For example, you might receive one of the following error messages:

> - "SSL peer rejected your certificate as expired"
>
> - "Error: Cannot retrieve repository metadata (*repomd.xml*) for repository:_... Please verify its path and try again"

You have to apply a process to avoid certificate expiration in old images or images that were created just before a certificate expiration date.

### Solution 1: Update the RHUI client package

To access RHEL repositories on pay-as-you-go systems in cloud environments, use RHUI. As a cloud provider, Azure can create and publish newer client configuration RPM versions at any time, such as for the following tasks:

- Providing access to a new repository
- Renewing certificates
- Making any other packaging changes

In this situation, you have to install the new RHUI package in the system. This package has the renewed certificate. To update the RHUI package, run the [yum](https://access.redhat.com/articles/yum-cheat-sheet) command:

```bash
sudo yum update -y --disablerepo='*' --enablerepo='*microsoft-azure*'
```

The `sudo yum update` command might also update the client certificate package (depending on your RHEL version). This is true even if the command output contains the same expired SSL certificate errors that you see for other repositories. If this update is successful, you have to restore normal connectivity to other RHUI repositories so that you can run `sudo yum update` successfully a second time.

If you receive a "404" error when you run `yum update`, try to run the following commands to refresh your yum cache:

```bash
sudo yum clean all
sudo yum makecache
```

## Cause 2: RHUI certificate is missing

The Azure Red Hat Linux VM has the RHUI Azure package already installed. However, the certificate is missing from the */etc/pki/rhui/product/* directory.

If the RHUI certificate was removed from the VM by mistake, the following error message appears when you try to install or update a package:

```output
sudo yum install <package-name>
Red Hat Enterprise Linux X for x86_64 - XXXX  0.0  B/s |   0  B     00:00  
Errors during downloading metadata for repository 'rhel-X-for-x86_64-XXXX-eus-rhui-rpms':  
  - Curl error (58): Problem with the local SSL certificate for https://rhui-3.microsoft.com/pulp/repos/content/eus/rhel8/rhui/X.X/x86_64/XXXXX/os/repodata/repomd.xml [could not load PEM client certificate, OpenSSL error error:02001002:system library:fopen:No such file or directory, (no key found, wrong pass phrase, or wrong file format?)]
```

### Solution 2: Reinstall the EUS, non-EUS, or SAP RHUI package

Reinstall the corresponding RHUI package to regenerate the missing certificates in the correct location.

All the commands in the following steps should be run by using root privileges or by specifying `sudo`:

1. Verify that the `rhui-azure` (`EUS`, `non-EUS`, or `SAP/E4S`) package is installed. To do this, run the following command:

   ```bash
   sudo rpm -qa | grep -i azure
   ```
   ```output
   rhui-azure-rhelX-<>-X.X-XXX.noarch
   ```

   For more information about Extended Update Support (EUS) or non-EUS RHUI packages, see the linked sections of the following articles.

   | Package type | Link |
   |---|---|
   | EUS RHUI packages | [Red Hat images connected to EUS repositories](/azure/virtual-machines/workloads/redhat/redhat-rhui#images-connected-to-eus-repositories) |
   | Non-EUS RHUI packages | [Red Hat images connected to non-EUS repositories](/azure/virtual-machines/workloads/redhat/redhat-rhui#images-connected-to-non-eus-repositories) |
   | Update Services for SAP Solutions subscriptions (SAP/E4S) RHUI packages | [Red Hat images connected to SAP/E4S repositories](/azure/virtual-machines/workloads/redhat/redhat-images#update-services-for-sap) |

2. Verify that the certificate exists:

   ```bash
   sudo ls -l /etc/pki/rhui/product/
   ```

   > [!NOTE]  
   > In this scenario, you discover that the file is missing.

3. Reinstall the corresponding `rhui-azure` package by running the `yum reinstall` command:

   ```bash
   sudo yum reinstall $(rpm -qa | grep -i rhui-azure) --disablerepo=* --enablerepo="*microsoft-azure*"
   ```

4. If the `EUS` or `E4S` repo is installed, lock the `releasever` variable:

   ```bash
   sudo echo $(. /etc/os-release && echo $VERSION_ID) > /etc/yum/vars/releasever
   ```

5. Verify that the certificate exists by running the `ls` command again. The certificate file should be listed now:

   ```bash
   sudo ls -l /etc/pki/rhui/product/
   ```

## Cause 3: RHUI package is missing

The RHUI EUS, non-EUS, or SAP/E4S package is missing from the Red Hat VM, but the repository configuration files still exist in the */etc/yum.repos.d/* directory.

When you try to install or update a package, you receive the following error message:

```output
sudo yum install <package-name>  
Red Hat Enterprise Linux X for x86_64 - XXXX  0.0  B/s |   0  B     00:00  
Errors during downloading metadata for repository 'rhel-X-for-x86_64-XXXX-XXX-rhui-rpms':  
  - Curl error (58): Problem with the local SSL certificate for https://rhui-3.microsoft.com/pulp/repos/content/eus/rhel8/rhui/X.X/x86_64/XXXXX/os/repodata/repomd.xml [could not load PEM client certificate, OpenSSL error error:02001002:system library:fopen:No such file or directory, (no key found, wrong pass phrase, or wrong file format?)]
```

### Solution 3: Install the EUS, non-EUS, or SAP/E4S RHUI package

Install the missing RHUI package for EUS, non-EUS, or SAP/E4S.

All the following commands should be run by using root privileges or by specifying `sudo`.

> [!NOTE]
> Use the table below to determine the correct RHUI package type based on your RHEL version and image type.

| **Image Type**     | **Support Model** | **Applicable Versions**                     | **RHUI Package Prefix**        | **Uses `releasever`?**  |
|--------------------|-------------------|---------------------------------------------|--------------------------------|-------------------------|
| Generic RHEL       | Non-EUS           | 8.10, 9.8, 10.0                              | `rhui-azure-rhelX`             | No                      |
| Generic RHEL       | EUS               | 8.2, 8.4, 8.6, 8.8, 9.2, 9.4, 9.6            | `rhui-azure-rhelX-eus`         | Yes                     |
| `RHEL-SAP-APPS`    | EUS               | 8.6, 8.8, 9.2, 9.4, 9.6                      | `rhui-azure-rhelX-sapapps`     | Yes                     |
| `RHEL-SAP-HA`      | E4S               | 8.6, 8.8, 9.0, 9.2, 9.4, 9.6                 | `rhui-azure-rhelX-sap-ha`      | Yes                     |
| `RHEL-HA`          | Non-EUS or Base   | 7.9, 8.10, 9.6                               | `rhui-azure-rhelX-base-ha`     | No                      |

> 🔹 When the documentation mentions `8.x` or `9.x`, it refers to supported minor versions that fall under EUS or E4S, depending on the image type.  
> 🔹 For complete support timelines, refer to the [Red Hat EUS and E4S lifecycle documentation](https://access.redhat.com/articles/rhel-eus).



#### EUS RHUI package installation


#### [RHEL 8._x_ - EUS](#tab/rhel8-eus)

1. Create a config file by using this command.

   ```bash
   sudo tee rhel8-eus.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8-eus]\nname=Microsoft Azure RPMs for RHEL 8 EUS\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8-eus\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```
   
2. Install the `rhui-azure-rhel8-eus` package by running:

   ```bash
   sudo dnf --config rhel8-eus.config install rhui-azure-rhel8-eus
   ```

3. Lock the `releasever` variable:

   ```bash
   sudo echo $(. /etc/os-release && echo $VERSION_ID) > /etc/dnf/vars/releasever
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist all
   ```
5. Remove the temp file created on step 1.

   ```bash
   sudo rhel8-eus.config
   ```

#### [RHEL 9._x_ - EUS](#tab/rhel9-eus)

1. Create a config file by using this command: 

   ```bash
   sudo tee rhel9-eus.config > /dev/null <<< $'[rhui-microsoft-azure-rhel9-eus]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 9 (rhel9-eus)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel9-eus\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'

   ```
2. Install the `rhui-azure-rhel9-eus` package by running.

   ```bash
   sudo dnf --config rhel9-eus.config install rhui-azure-rhel9-eus
   ```

3. Lock the `releasever` variable:

   ```bash
   sudo echo $(. /etc/os-release && echo $VERSION_ID) > /etc/dnf/vars/releasever
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist all
   ```

5. Remove the temp file created on step 1.

   ```bash
   sudo rhel9-eus.config
   ```

---

> [!NOTE]
> If you're using a proxy in */etc/yum.conf* or */etc/dnf.conf*, the `yum --config rhelX-XX-XX.config` command won't work because it doesn't include your proxy settings. In this case, move the temp file `rhelX-XX-XX.config`  directly in `/etc/yum.repos.d/` as `.repo`
>
> ```bash  
> sudo mv rhelX-XX-XX.config /etc/yum.repos.d/ms.repo
> sudo yum install rhui-azure-rhel-X-X-X
> sudo rm rhelX-XX-XX.config
> ```
>
> Replace `rhelX-XX-XX.config` and `rhui-azure-rhel-X-X-X` with the actual values, as appropriate.

#### Non-EUS RHUI package installation

#### [RHEL 7._9_ - non-EUS](#tab/rhel7-noneus)


1. Remove the releasever file if it exists.

   ```bash
   sudo rm /etc/yum/vars/releasever
   ```

2. Create a config file by using this command:

   ```bash
   sudo tee rhel7-non-eus.config > /dev/null <<< $'[rhui-microsoft-azure-rhel7]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 7 (rhel7)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel7\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

3. Install the `rhui-azure-rhel7` package by running the `yum install` command:

   ```bash
   sudo yum --config rhel7-non-eus.config install rhui-azure-rhel7
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `yum repolist` command:

   ```bash
   sudo yum repolist
   ```
5. Remove the temp file created on step 2.

   ```bash
   sudo rm rhel7-non-eus.config
   ```

#### [RHEL 8.10 - non-EUS](#tab/rhel8-noneus)


1. Remove the releasever file if it exists.

   ```bash
   sudo rm /etc/yum/vars/releasever
   ```

2. Create a config file by using this command:

   ```bash
   sudo tee rhel8-non-eus.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

3. Install the `rhui-azure-rhel8` package by running the `dnf install` command:

   ```bash
   sudo dnf --config rhel8-non-eus.config install rhui-azure-rhel8
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo yum repolist
   ```
5. Remove the temp file created on step 2.

   ```bash
   sudo rm rhel8-non-eus.config
   ```

#### [RHEL 9._x_ - non-EUS](#tab/rhel9-noneus)


1. Remove the releasever file if it exists.

   ```bash
   sudo rm /etc/yum/vars/releasever
   ```

2. Create a config file by using this command:

   ```bash
   sudo tee rhel9-non-eus.config > /dev/null <<< $'[rhui-microsoft-azure-rhel9]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 9 (rhel9)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel9\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

3. Install the `rhui-azure-rhel9` package by running the `dnf install` command:

   ```bash
   sudo dnf --config rhel9-non-eus.config install rhui-azure-rhel9
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo yum repolist
   ```
5. Remove the temp file created on step 2.

   ```bash
   sudo rm rhel9-non-eus.config
   ```

#### [RHEL 10.0  non-EUS](#tab/rhel10-noneus)


1. Create a config file by using this command:

   ```bash
   sudo tee rhel10-non-eus.config > /dev/null <<< $'[rhui-microsoft-azure-rhel10]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 10 (rhel10)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel10\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft-2025.asc\nsslverify=1' 
   ```

2. Install the `rhui-azure-rhel10` package by running the `dnf install` command:

   ```bash
   sudo dnf --config rhel10-non-eus.config install rhui-azure-rhel10
   ```

3. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist
   ```
   
4. Remove the temp file created on step 1.

   ```bash
   sudo rm rhel10-non-eus.config
   ```
   
---

> [!NOTE]
> If you're using a proxy in */etc/yum.conf* or */etc/dnf.conf*, the `yum --config rhelX-XX-XX.config` command won't work because it doesn't include your proxy settings. In this case, move the temp file `rhelX-XX-XX.config`  directly in `/etc/yum.repos.d/` as `.repo`
>
> ```bash  
> sudo mv rhelX-XX-XX.config /etc/yum.repos.d/ms.repo
> sudo yum install rhui-azure-rhel-X-X-X
> sudo rm rhelX-XX-XX.config
> ```
>
> Replace `rhelX-XX-XX.config` and `rhui-azure-rhel-X-X-X` with the actual values, as appropriate.


#### RHEL 7 SAP/E4S/HANA RHUI package installation

Select the tab of an SAP image type to see the corresponding instructions.


#### [RHEL 7.9 - RHEL-SAP-APPS](#tab/rhel79-rhel-sap-apps)


The following steps apply if the OS version is *RHEL 7.9* and the VM was created by using the `RHEL-SAP-APPS` offer image.

1. Remove the releasever file if it exists.

   ```bash
   sudo rm /etc/yum/vars/releasever
   ```

2. Create a config file by using this command:

   ```bash
   sudo tee rhel7-base-sap-apps.config > /dev/null <<< $'[rhui-microsoft-azure-rhel7-base-sap-apps]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 7 (rhel7-base-sap-apps)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel7-base-sap-apps\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

3. Install the `rhui-azure-rhel7-base-sap-apps` package by running the `yum install` command:

   ```bash
   sudo yum --config rhel7-base-sap-apps.config install rhui-azure-rhel7-base-sap-apps
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `yum repolist` command:

   ```bash
   sudo yum repolist
   ```

5. Remove the temp file created on step 2.

   ```bash
   sudo rm rhel7-base-sap-apps.config
   ```

   
#### [RHEL 7.9 - RHEL-SAP-HA](#tab/rhe79-rhel-sap-ha)

The following steps apply if the OS version is *RHEL 7.9* and the VM was created by using the `RHEL-SAP-HA` offer image.

1. Remove the releasever file if it exists.

   ```bash
   sudo rm /etc/yum/vars/releasever
   ```

2. Create a config file by using this command:

   ```bash
   sudo tee rhel7-base-sap-ha.config > /dev/null <<< $'[rhui-microsoft-azure-rhel7-base-sap-ha]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 7 (rhel7-base-sap-ha)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel7-base-sap-ha\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```
   
3. Install the `rhui-azure-rhel7-base-sap-ha` package by running the `yum install` command:

   ```bash
   sudo yum --config rhel7-base-sap-ha.config install rhui-azure-rhel7-base-sap-ha
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `yum repolist` command:

   ```bash
   sudo yum repolist
   ```
   
5. Remove the temp file created on step 2.

   ```bash
   sudo rm rhel7-base-sap-ha.config
   ```

---

> [!NOTE]
> If you're using a proxy in */etc/yum.conf* or */etc/dnf.conf*, the `yum --config rhelX-XX-XX.config` command won't work because it doesn't include your proxy settings. In this case, move the temp file `rhelX-XX-XX.config`  directly in `/etc/yum.repos.d/` as `.repo`
>
> ```bash  
> sudo mv rhelX-XX-XX.config /etc/yum.repos.d/ms.repo
> sudo yum install rhui-azure-rhel-X-X-X
> sudo rm rhelX-XX-XX.config
> ```
> Replace `rhelX-XX-XX.config` and `rhui-azure-rhel-X-X-X` with the actual values, as appropriate.


#### RHEL 8 SAP/E4S/HANA RHUI package installation

Select the tab of an SAP image type to see the corresponding instructions.

#### [RHEL 8._x_ - RHEL-SAP-APPS](#tab/rhel8-rhel-sap-apps)


The following steps apply if the OS version is *earlier than the latest version available* supported by SAP for `RHEL 8.X` and the VM was created by using the `RHEL-SAP-APPS` offer image.

1. Create a config file by using this command:

   ```bash
   sudo tee rhel8-sapapps.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8-sapapps]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sapapps)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8-sapapps\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```
   
2. Install the `rhui-azure-rhel8-sapapps` package by running the [dnf](https://dnf.readthedocs.io/en/latest/command_ref.html) installation command:

   ```bash
   sudo dnf --config rhel8-sapapps.config install rhui-azure-rhel8-sapapps
   ```

3. Lock the `releasever` variable:

   ```bash
   sudo echo $(. /etc/os-release && echo $VERSION_ID) > /etc/dnf/vars/releasever
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist
   ```

5. Remove the temp file created on step 1.

   ```bash
   sudo rm rhel8-sapapps.config
   ```


#### [RHEL 8.10 - RHEL-SAP-APPS](#tab/rhel810-rhel-sap-apps)

The following steps apply if the OS version is *RHEL 8.10* supported by SAP and the VM was created by using the `RHEL-SAP-APPS` offer image.


1. Remove the releasever file if it exists.

   ```bash
   sudo rm /etc/yum/vars/releasever
   ```
   
2. Create a config file by using this command:

   ```bash
   sudo tee rhel8-base-sap-apps.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8-base-sap-apps]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-apps)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8-base-sap-apps\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

3. Install the `rhui-azure-rhel8-base-sap-apps` package by running the [dnf](https://dnf.readthedocs.io/en/latest/command_ref.html) installation command:

   ```bash
   sudo dnf --config rhel8-base-sap-apps.config install rhui-azure-rhel8-base-sap-apps
   ```
   
4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist
   ```
5. Remove the temp file created on step 2.

   ```bash
   sudo rm rhel8-base-sap-apps.config
   ```
   
#### [RHEL 8._x_ - RHEL-SAP-HA (E4S)](#tab/rhel8-rhel-sap-ha-e4s)

The following steps apply if the OS version is *earlier than the latest version available* supported by SAP for `RHEL 8._x_` and the VM was created by using the `RHEL-SAP-HA` offer image.

1. Create a config file by using this command:

   ```bash
   sudo tee rhel8-sap-ha.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8-sap-ha]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-sap-ha)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8-sap-ha\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

2. Install the `rhui-azure-rhel8-sap-ha` package by running the [dnf](https://dnf.readthedocs.io/en/latest/command_ref.html) installation command:

   ```bash
   sudo dnf --config rhel8-sap-ha.config install rhui-azure-rhel8-sap-ha
   ```

3. Lock the `releasever` variable:

   ```bash
   sudo echo $(. /etc/os-release && echo $VERSION_ID) > /etc/dnf/vars/releasever
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist
   ```
   
5. Remove the temp file created on step 1.

   ```bash
   sudo rm rhel8-sap-ha.config
   ```

#### [RHEL 8.10 - RHEL-SAP-HA](#tab/rhe810-rhel-sap-ha)

The following steps apply if the OS version is *RHEL 8.10* and the VM was created by using the `RHEL-SAP-HA` offer image.


1. Remove the releasever file if it exists.

   ```bash
   sudo rm /etc/yum/vars/releasever
   ```
   
2. Create a config file by using this command:

   ```bash
   sudo tee rhel8-base-sap-ha.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8-base-sap-ha]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-ha)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8-base-sap-ha\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

3. Install the `rhui-azure-rhel8-base-sap-ha` package by running the [dnf](https://dnf.readthedocs.io/en/latest/command_ref.html) installation command:

   ```bash
   sudo dnf --config rhel8-base-sap-ha.config install rhui-azure-rhel8-base-sap-ha
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist
   ```
   
5. Remove the temp file created on step 2.

   ```bash
   sudo rm rhel8-base-sap-ha.config
   ```

#### [RHEL 8._x_ - RHEL-HA ](#tab/rhel8-rhel-ha)


1. Create a config file by using this command:

   ```bash
   sudo tee rhel8-ha.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8-ha]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-ha)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8-ha\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

2. Install the `rhui-azure-rhel8-ha` package by running the [dnf](https://dnf.readthedocs.io/en/latest/command_ref.html) installation command:

   ```bash
   sudo dnf --config rhel8-ha.config install rhui-azure-rhel8-ha
   ```

3. Lock the `releasever` variable:

   ```bash
   sudo echo $(. /etc/os-release && echo $VERSION_ID) > /etc/dnf/vars/releasever
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist
   ```

5. Remove the temp file created on step 2.

   ```bash
   sudo rm  rhel8-ha.config
   ```

#### [RHEL 8.10 - RHEL-HA](#tab/rhe810-rhel-base-ha)



1. Remove the releasever file if it exists:

   ```bash
   sudo rm /etc/yum/vars/releasever
   ```
   
2. Remove the client `rhui-azure-rhel8-ha` package by running the `dnf remove` command:

   ```bash
   sudo dnf remove rhui-azure-rhel8-ha
   ```
   
3. Create a config file by using this command:

   ```bash
   sudo tee rhel8-base-ha.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8-base-ha]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-ha)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8-base-ha\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

4. Install the `rhui-azure-rhel8-base-ha` package by running the [dnf](https://dnf.readthedocs.io/en/latest/command_ref.html) installation command:

   ```bash
   sudo dnf --config rhel8-base-ha.config install rhui-azure-rhel8-base-ha
   ```

5. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist
   ```
6. Remove the temp file created on step 3.

   ```bash
   sudo rm  rhel8-base-ha.config
   ```

---


> [!NOTE]
> If you're using a proxy in */etc/yum.conf* or */etc/dnf.conf*, the `yum --config rhelX-XX-XX.config` command won't work because it doesn't include your proxy settings. In this case, move the temp file `rhelX-XX-XX.config`  directly in `/etc/yum.repos.d/` as `.repo`
>
> ```bash  
> sudo mv rhelX-XX-XX.config /etc/yum.repos.d/ms.repo
> sudo yum install rhui-azure-rhel-X-X-X
> sudo rm rhelX-XX-XX.config
> ```
> Replace `rhelX-XX-XX.config` and `rhui-azure-rhel-X-X-X` with the actual values, as appropriate.


#### RHEL 9 SAP/HANA RHUI package installation

Select the tab of an SAP image type to see the corresponding instructions.

#### [RHEL 9._x_ - RHEL-SAP-APPS](#tab/rhel9-rhel-sap-apps)


The following steps apply if the OS version is *earlier than the latest version that's available* that's supported by SAP for `RHEL 9.0`, and if the VM was created by using the `RHEL-SAP-APPS` offer image.

1. Create a config file by using this command:

   ```bash
   sudo tee rhel9-sapapps.config > /dev/null <<< $'[rhui-microsoft-azure-rhel9-sapapps]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 9 (rhel9-sapapps)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel9-sapapps\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

2. Install the `rhui-azure-rhel9-sapapps` package by running the `dnf install` command:

   ```bash
   sudo dnf --config rhel9-sapapps.config  install rhui-azure-rhel9-sapapps
   ```

3. Lock the `releasever` level. Currently, the version must be 9.2 or 9.4.

   ```bash
   sudo sh -c 'echo 9.4 > /etc/dnf/vars/releasever'
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `yum repolist` command:

   ```bash
   sudo dnf repolist all
   ```

5. Remove the temp file created on step 1.

   ```bash
   sudo rm  rhel9-sapapps.config
   ```

#### [RHEL 9._x_ - RHEL-SAP-HA (E4S)](#tab/rhel9-rhel-sap-ha-e4s)



The following steps apply if the OS version is *earlier than the latest version available* that's supported by SAP for `RHEL 9.0`, and if the VM was created by using the `RHEL-SAP-HA` offer image.

1. Create a config file by using this command:

   ```bash
   sudo tee rhel9-sap-ha.config > /dev/null <<< $'[rhui-microsoft-azure-rhel9-sap-ha]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 9 (rhel9-sap-ha)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel9-sap-ha\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

2. Install the `rhui-azure-rhel9-sap-ha` package by running the `dnf install` command:

   ```bash
   sudo dnf --config rhel9-sap-ha.config install rhui-azure-rhel9-sap-ha
   ```

3. Lock the `releasever` level. Currently, the version must be 9.2 or 9.4.

   ```bash
   sudo sh -c 'echo 9.4 > /etc/dnf/vars/releasever'
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist all
   ```

5. Remove the temp file created on step 1.

   ```bash
   sudo rm  rhel9-sap-ha.config
   ```

#### [RHEL 9._x_ - RHEL-HA ](#tab/rhel9-rhel-ha-e4s)

1. Create a config file by using this command:

   ```bash
   sudo tee rhel9-ha.config > /dev/null <<< $'[rhui-microsoft-azure-rhel9-ha]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 9 (rhel9-ha)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel9-ha\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```

2. Install the `rhui-azure-rhel9-ha` package by running the [dnf](https://dnf.readthedocs.io/en/latest/command_ref.html) installation command:

   ```bash
   sudo dnf --config rhel9-ha.config install rhui-azure-rhel9-ha
   ```

3. Lock the `releasever` level. Currently, the version must be 9.2 or 9.4.

   ```bash
   sudo sh -c 'echo 9.4 > /etc/dnf/vars/releasever'
   ```

4. Verify that the corresponding repositories are available and show no errors. To do this, run the `dnf repolist` command:

   ```bash
   sudo dnf repolist
   ```
5. Remove the temp file created on step 1.

   ```bash
   sudo rm rhel9-ha.config
   ```
---

> [!NOTE]
> If you're using a proxy in */etc/yum.conf* or */etc/dnf.conf*, the `yum --config rhelX-XX-XX.config` command won't work because it doesn't include your proxy settings. In this case, move the temp file `rhelX-XX-XX.config`  directly in `/etc/yum.repos.d/` as `.repo`
>
> ```bash  
> sudo mv rhelX-XX-XX.config /etc/yum.repos.d/ms.repo
> sudo yum install rhui-azure-rhel-X-X-X
> sudo rm rhelX-XX-XX.config
> ```
> Replace `rhelX-XX-XX.config` and `rhui-azure-rhel-X-X-X` with the actual values, as appropriate.


## Cause 4: SSL CA certificate is missing

The *ca-bundle.crt* certificate file was manually deleted, was corrupted, or is outdated.

You might receive an error message that resembles the following output when you try to run `yum` commands:

```output
# yum repolist  
Loaded plugins: langpacks, product-id, search-disabled-repos  
rhui-rhel-X-server-dotnet-rhui FAILED  
https://rhui-3.microsoft.com/pulp/repos//content/dist/rhel/rhui/server/X/XServer/x86_64/dotnet/1/os/repodata/70b2edf9a115dffa42d4dd66ba77e77bc3cad45d1143ed02df72ea58c92b59b5-primary.sqlite.bz2: [Errno 14] curl#77 - "Problem with the SSL CA cert (path? access rights?)"
Trying other mirror.
```

### Solution 4: Update or reinstall the CA certificates package

1. Download the latest *ca-certificates-XXXX.X.XX-XX.elX_X.noarch.rpm* package from another VM that has repository access and the same Red Hat version and release. Then, copy the package to the affected VM:

   ```bash
   sudo yumdownloader ca-certificates
   sudo scp ca-certificates-XXXX.X.XX-XX.elX_X.noarch.rpm <user-name>@<affected-VM-IP-address>:/tmp
   ```

   > [!NOTE]  
   > Make sure that you replace the corresponding user and IP address placeholders. Also, make sure that you replace the package name, *ca-certificates-XXXX.X.XX-XX.elX_X.noarch.rpm*, accordingly.

2. Update, install, or reinstall the `ca-certificate` package after it's copied to the affected VM:

   1. Check whether the package is already installed:

      ```bash
      sudo rpm -qa | grep "ca-certificates"
      ```

      - If the package is missing, install it by running the `yum install` command:

        ```bash
        sudo yum install ca-certificates-*.noarch.rpm --disablerepo=*
        ```

      - If the package is still installed, run the `yum reinstall` command to reinstall it:

        ```bash
        sudo yum reinstall ca-certificates-*.noarch.rpm --disablerepo=*
        ```

   1. To regenerate or update the corresponding certificates, run the [update-ca-trust](https://www.systutorials.com/docs/linux/man/8-update-ca-trust/) command:

      ```bash
      sudo update-ca-trust
      ```

---

## Cause 5: Verification error in RHEL version 8 or 9 ("CA certificate key too weak")

The system tries to connect to a server that contains a certificate that's signed by using 2048-bit RSA keys. However, the system has a `FUTURE` policy setting that prohibits that cryptographic algorithm. The following error messages are shown in the */var/log/messages* or */var/log/dnf.log* file:

```output
2023-03-13T19:07:55+0000 DEBUG error: Curl error (60): SSL peer certificate or SSH remote key was not OK for https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel9/rhui/9/x86_64/supplementary/os/repodata/repomd.xml [SSL certificate problem: CA certificate key too weak] (https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel9/rhui/9/x86_64/supplementary/os/repodata/repomd.xml).
```

```output
 - Curl error (58): Problem with the local SSL certificate for https://rhui-2.microsoft.com/pulp/repos/content/e4s/rhel8/rhui/8.4/x86_64/sap/os/repodata/repomd.xml [could not load PEM client certificate, OpenSSL error error:140AB18F:SSL routines:SSL_CTX_use_certificate:ee key too small, (no key found, wrong pass phrase, or wrong file format?)]
```

The default system policy setting is `DEFAULT`. In this scenario, the default setting was changed from `DEFAULT` to `FUTURE` or `CUSTOM`. The `FUTURE` policy disables some algorithms that use 2,048 bits, such as SHA-1, RSA, and Diffie-Hellman. The `CUSTOM` policy might also disable these algorithms. To identify the current policy setting mode, run the following [update-crypto-policies](https://www.systutorials.com/docs/linux/man/8-update-crypto-policies/) command:

```bash
sudo update-crypto-policies --show
```
```output
DEFAULT:FUTURE
```

### Solution 5: Revert to the default cryptographic system policy

Revert the cryptography to the `DEFAULT` system policy setting by following these steps:

1. Change the system policy setting back to `DEFAULT` by running the `update-crypto-policies` command:

   ```bash
   sudo update-crypto-policies --set DEFAULT
   ```

2. Verify that the policy change went through by running the `update-crypto-policies` command again:

   ```bash
   sudo update-crypto-policies --show
   ```

3. Test to make sure that the error is fixed. To do this, run the `dnf install` command:

   ```bash
   sudo dnf install <package-name>
   ```

For more information about cryptographic policy, see [Strong crypto defaults in RHEL 8 and deprecation of weak crypto algorithms](https://access.redhat.com/articles/3642912).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
