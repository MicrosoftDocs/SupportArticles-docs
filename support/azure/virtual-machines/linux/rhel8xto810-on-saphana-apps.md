---
title: How to update RHEL from 8.x to 8.10 on Azure with RHEL for SAP with High Availability or SAP APPS on PAYG images.
description: Guide with step by step procedure to do an OS update frm RHEL 8.x to 8.10
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas-msft
editor: 
ms.date: 08/21/2024
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---

# How to update RHEL from 8.x to 8.10 on Azure with RHEL for SAP with High Availability or SAP APPS on (PAYG) virtual machines.

**Applies to:** :heavy_check_mark: Linux VMs

While RHEL for SAP 8.x (where x isn't equal to 10) can be accessed in `E4S` and/or `EUS`, RHEL for SAP 8.10 follows a different approach. In this case, the related content is found in unversioned repositories. As a result, updating a system that operates SAP on RHEL 8.x to RHEL 8.10 requires several manual steps.

This article provides the correct steps to update from 8.x to 8.10 for SAP-HANA or SAPAPPS pay-as-you-go (PAYG) images.

> [!IMPORTANT]
> RHUI is intended for only pay-as-you-go images. Are you using custom or golden images (also known as "bring-your-own-subscription (BYOS)") instead? In that case, the system has to be attached to Red Hat Subscription Manager (RHSM) or Satellite in order to receive updates. For more information, see [How to register and subscribe an RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information on performing the update process on custom or golden images, and pay-as-you-go (PAYG) images provided by Red Hat, see:

- [How to update RHEL from 8.* to 8.10 on Cloud images with the "RHEL for SAP with High Availability and Update Services](https://access.redhat.com/articles/7071393)

- [Recommended Practices for Applying Software Updates to a RHEL High Availability or Resilient Storage Cluster](https://access.redhat.com/articles/2059253#pacemaker)

> [!NOTE] 
> Notice that RHEL 8.10 is the final RHEL 8 release and maintenance defines its [Maintenance Support 2 Phase policy](https://access.redhat.com/support/policy/updates/errata#Maintenance_Support_2_Phase).

## Prerequisites

- Make a backup of the virtual machine or a snapshot of the OS disk.
- Set up access to the serial console.
- SAP process must be stopped during the OS update process.
- Run the commands in this article with root privileges.

## Process to upgrade from RHEL 8.x to RHEL 8.10 on SAP HANA or SAPAPPS pay-as-you-go (PAYG) virtual machines.

- Before updating production systems to 8.10, **verify that this release is compatible with the required SAP software**. For more details, refer to SAP Software on Linux: General Information - [SAP NOTE 2369910](https://launchpad.support.sap.com/#/notes/2369910)

- Further suggestions for HA cluster nodes utilizing the RHEL HA Add-On,  [Recommended Practices for Applying Software Updates to a RHEL High Availability or Resilient Storage Cluster](https://access.redhat.com/articles/2059253#pacemaker)

#### [RHEL 8.x to 8.10 on SAP-HANA](#tab/rhel8x-rhel810ha)

> [!IMPORTANT]  
> RHEL 8.10 isn't certified for running SAP HANA currently. It is in process. For more information, see: [Overview Product Availability Matrix for SAP on Red Hat.](https://access.redhat.com/articles/6966927#support-matrix-for-sap-hana-on-intel-64-rhel-5)

1. Remove the RHUI(E4S) package installed or updated on the VM.

```bash
sudo dnf remove $(rpm -qa | grep -i rhui)
```

2. Remove the version lock file.

```bash
sudo rm /etc/yum/vars/releasever
```

3. Install the `rhui-azure-rhel8-base-sap-ha` package by running the dnf install command.

```bash
sudo dnf --config='https://rhelimage.blob.core.windows.net/repositories/rhui-microsoft-azure-rhel8-base-sap-ha.config' install rhui-azure-rhel8-base-sap-ha
```

4. Verify that the corresponding repositories are available and show no errors. To do this task, run the `dnf repolist` command.

```bash
sudo dnf repolist
```

```output
repo id                                      repo name
ansible-2-for-rhel-8-x86_64-rhui-rpms        Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
packages-microsoft-com-prod                  packages-microsoft-com-prod
rhel-8-for-x86_64-appstream-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - AppStream from RHUI (RPMs)
rhel-8-for-x86_64-baseos-rhui-rpms           Red Hat Enterprise Linux 8 for x86_64 - BaseOS from RHUI (RPMs)
rhel-8-for-x86_64-highavailability-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - High Availability (RPMs) from RHUI
rhel-8-for-x86_64-sap-netweaver-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver (RPMs) from RHUI
rhel-8-for-x86_64-sap-solutions-rhui-rpms    Red Hat Enterprise Linux 8 for x86_64 - SAP Solutions (RPMs) from RHUI
rhui-microsoft-azure-rhel8-base-sap-ha       Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-ha)
```

>[!IMPORTANT]
> A single host can accommodate both SAP HANA and other SAP applications, such as NetWeaver. In this scenario, all the mentioned repositories are required. Optionally, you can modify the `/etc/yum.repos.d/rh-cloud-base-sap-ha.repo` file based on your system's specific requirement.


5. Update to RHEL 8.10.

```bash
sudo dnf update
```

6. Reboot the Virtual Machine.

```bash
sudo reboot 
```

#### [RHEL 8.x to 8.10 on SAPAPPS](#tab/rhel8x-rhel819sapapps)

1. Remove the RHUI(EUS-SAP) package installed.

```bash
sudo dnf remove $(rpm -qa | grep -i rhui)
```

2. Remove the version lock file.

```bash
sudo rm /etc/yum/vars/releasever
```

3. Install the `rhui-azure-rhel8-base-sap-apps` package by running the dnf install command.

```bash
sudo dnf --config='https://rhelimage.blob.core.windows.net/repositories/rhui-microsoft-azure-rhel8-base-sapapps.config' install rhui-azure-rhel8-base-sap-apps
```

4. Verify that the corresponding repositories are available and show no errors. To do this task, run the `dnf repolist` command.

```bash
sudo dnf repolist
```

```output
repo id                                   repo name
ansible-2-for-rhel-8-x86_64-rhui-rpms     Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs) from RHUI
packages-microsoft-com-prod               packages-microsoft-com-prod
rhel-8-for-x86_64-appstream-rhui-rpms     Red Hat Enterprise Linux 8 for x86_64 - AppStream from RHUI (RPMs)
rhel-8-for-x86_64-baseos-rhui-rpms        Red Hat Enterprise Linux 8 for x86_64 - BaseOS from RHUI (RPMs)
rhel-8-for-x86_64-sap-netweaver-rhui-rpms Red Hat Enterprise Linux 8 for x86_64 - SAP NetWeaver (RPMs) from RHUI
rhui-microsoft-azure-rhel8-base-sap-apps  Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-apps)
```

5. Update to RHEL 8.10.

```bash
sudo dnf update
```

6. Reboot the Virtual Machine.

```bash
sudo reboot 
```

---
<!-- PLEASE DONT DELETE THE FOLLOWING LINES, IT WILL BE ADDED ONCE THE OTHER DOC IS READY
> [!IMPORTANT]
> If your next target is to move to RHEL 9 for SAP environments refer to: [NEW LINK WORKINPROGRESS]
-->
