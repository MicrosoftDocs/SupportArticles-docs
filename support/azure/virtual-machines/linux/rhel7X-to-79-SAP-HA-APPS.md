---
title:   How to update RHEL from 7.7* to 7.9 on Azure with "RHEL for SAP with High Availability or SAP APPS on PAYGO images.
description: Guide with step by step procedure to do a OS update frm RHEL 7.X to 7.9
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas-msft
editor: 
ms.date: 09/02/2024
ms.service: virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---

# How to update RHEL from 7.7* to 7.9 on Azure with "RHEL for SAP with High Availability or SAP APPS on pay-as-you-go (PAYGO) images.

**Applies to:** :heavy_check_mark: Linux VMs

While RHEL for SAP 7.x (where x is not equal to 9) can be accessed in E4S and/or EUS, RHEL for SAP 7.9 follows a different approach. In this case, the related content is found in unversioned repositories. As a result, updating a system that operates SAP on RHEL 7.x to RHEL 7.9 requires several manual steps.

This article will provide the correct steps to update to 7.9 for SAP-HANA or SAPAPPS pay-as-you-go (PAYGO) images.

> [!IMPORTANT]
> RHUI is intended for only pay-as-you-go images. Are you using custom or golden images (also known as "bring-your-own-subscription (BYOS)") instead? In that case, the system has to be attached to Red Hat Subscription Manager (RHSM) or Satellite in order to receive updates. For more information, see [How to register and subscribe an RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information on performing the update process on custom or golden images, and pay-as-you-go (PAYGO) images provided by Red Hat, see:

[How to update RHEL from 7.* to 7.0 on Cloud Images with the "RHEL for SAP with HA and Update Services":](https://www.bing.com/ck/a?!&&p=5ce48fc498f647bbJmltdHM9MTcyMjU1NjgwMCZpZ3VpZD0yZWZiYTY4Yi03MTE1LTZmNjgtMWRlMS1iMjM0NzAxNDZlYjImaW5zaWQ9NTIxMg&ptn=3&ver=2&hsh=3&fclid=2efba68b-7115-6f68-1de1-b23470146eb2&psq=rehl+7+to+7%2c9+on+sap&u=a1aHR0cHM6Ly9hY2Nlc3MucmVkaGF0LmNvbS9hcnRpY2xlcy81ODA1NTcx&ntb=1)

[Recommended Practices for Applying Software Updates to a RHEL High Availability or Resilient Storage Cluster](https://access.redhat.com/articles/2059253#pacemaker)


[!NOTE] Please notice that RHEL 7.9 is the final RHEL 7 release and maintenance is defined by the [Maintenance Support 2 Phase policy](https://access.redhat.com/support/policy/updates/errata#Maintenance_Support_2_Phase).

## Prerequisites

- Make a backup of the virtual machine or a snapshot of the OS disk.
- Set up access to the serial console
- SAP process must be stopped during the OS update process.
- Root privileges.

## Process to upgrade from RHEL 7.X to RHEL 7.9 on SAP HA or SAPAPPS pay-as-you-go (PAYGO) images.


#### [RHEL 7.x to 7.9 on SAP-HA](#tab/rhel7x-rhel79ha)


1. Remove the RHUI(E4S) package installed or updated on the VM.

```bash
sudo yum remove $(rpm -qa | grep -i rhui)
```

2. Remove the version lock file.

```bash
 rm /etc/yum/vars/releasever
```

3. Install the `rhui-azure-rhel7-base-sap-ha` package by running the yum install command

```bash
sudo yum --config='https://rhelimage.blob.core.windows.net/repositories/rhui-microsoft-azure-rhel7-base-sap-ha.config' install rhui-azure-rhel7-base-sap-ha
```
4. Verify that the corresponding repositories are available and show no errors. To do this, run the yum repolist command

```bash
sudo yum repolist
```

```output
Loaded plugins: langpacks, product-id, search-disabled-repos, yum_rhui_plugin
repo id                                              repo name            status
rhel-7-server-ansible-2-rhui-rpms/x86_64             Red Hat Ansible Engi    103
rhel-7-server-rhui-extras-rpms/x86_64                Red Hat Enterprise L  1,488
rhel-7-server-rhui-optional-rpms/7Server/x86_64      Red Hat Enterprise L 24,422
rhel-7-server-rhui-rh-common-rpms/7Server/x86_64     Red Hat Enterprise L    243
rhel-7-server-rhui-rpms/7Server/x86_64               Red Hat Enterprise L 34,484
rhel-7-server-rhui-supplementary-rpms/7Server/x86_64 Red Hat Enterprise L    517
rhel-sap-for-rhel-7-server-rhui-rpms/7Server/x86_64  Red Hat Enterprise L    147
rhel-server-rhui-rhscl-7-rpms/7Server/x86_64         Red Hat Software Col 14,708
rhui-microsoft-azure-rhel7-base-sap-apps             Microsoft Azure RPMs      6
repolist: 76,118
```

>[!IMPORTANT]
>A single host can accommodate both SAP HANA and other SAP applications, such as NetWeaver. In this scenario, all the mentioned repositories are required. Optionally, you can modify the `/etc/yum.repos.d/rh-cloud-base-sap-ha.repo` file based on your system's specific requirement


5. Update to RHEL 7.9

```bash
sudo yum update
```
6. Reboot the Virtual Machine

```bash
sudo reboot 
```

#### [RHEL 7.x to 7.9 on SAPAPPS](#tab/rhel7x-rhel79sapapps)

1. Remove the RHUI(EUS-SAP) package installed.

```bash
sudo yum remove $(rpm -qa | grep -i rhui)
```
2. Remove the version lock file.

```bash
 rm /etc/yum/vars/releasever
```
3. Install the `rhui-azure-rhel7-base-sap-apps` package by running the yum install command

```bash
sudo yum --config='https://rhelimage.blob.core.windows.net/repositories/rhui-microsoft-azure-rhel7-base-sapapps.config' install rhui-azure-rhel7-base-sap-apps
```
4. Verify that the corresponding repositories are available and show no errors. To do this, run the yum repolist command

```bash
sudo yum repolist
```

```output
Loaded plugins: langpacks, product-id, search-disabled-repos, yum_rhui_plugin
repo id                                                  repo name        status
rhel-7-server-ansible-2-rhui-rpms/x86_64                 Red Hat Ansible     103
rhel-7-server-rhui-extras-rpms/x86_64                    Red Hat Enterpri  1,488
rhel-7-server-rhui-optional-rpms/7Server/x86_64          Red Hat Enterpri 24,422
rhel-7-server-rhui-rh-common-rpms/7Server/x86_64         Red Hat Enterpri    243
rhel-7-server-rhui-rpms/7Server/x86_64                   Red Hat Enterpri 34,484
rhel-7-server-rhui-supplementary-rpms/7Server/x86_64     Red Hat Enterpri    517
rhel-ha-for-rhel-7-server-rhui-rpms/7Server/x86_64       Red Hat Enterpri    872
rhel-sap-for-rhel-7-server-rhui-rpms/7Server/x86_64      Red Hat Enterpri    147
rhel-sap-hana-for-rhel-7-server-rhui-rpms/7Server/x86_64 Red Hat Enterpri    115
rhel-server-rhui-rhscl-7-rpms/7Server/x86_64             Red Hat Software 14,708
rhui-microsoft-azure-rhel7-base-sap-ha                   Microsoft Azure       6
repolist: 77,105
```

5. Update to RHEL 7.9

```bash
sudo yum update
```

6. Reboot the Virtual Machine

```bash
sudo reboot 
```

---

> [!IMPORTANT]
> If your next target is to move to RHEL 8 for SAP environments refer to: [NEW LINK WORKINPROGRESS]
