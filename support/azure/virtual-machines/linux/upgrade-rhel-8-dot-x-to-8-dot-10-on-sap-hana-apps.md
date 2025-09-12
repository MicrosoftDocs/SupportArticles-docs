---
title: Upgrade RHEL-SAP-HANA and RHEL-SAP-APPS PAYG VMs from 8.x to 8.10
description: Provides steps to help you upgrade RHEL-SAP-HANA and RHEL-SAP-APPS pay-as-you-go virtual machines from 8.x to 8.10.
ms.reviewer: divargas, msaenzbo, v-weizhu
ms.date: 09/14/2024
ms.topic: how-to
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---

# How to upgrade RHEL-SAP-HANA and RHEL-SAP-APPS pay-as-you-go virtual machines from 8.x to 8.10

**Applies to:** :heavy_check_mark: Linux VMs

While Red Hat Enterprise Linux (RHEL) for SAP 8.*x* (where *x* isn't equal to 10) can be accessed in Extended Update Services for SAP Solutions (E4S) and Extended Update Support (EUS), RHEL for SAP 8.10 follows a different approach. In this case, the related content is available in unversioned repositories. As a result, updating a RHEL 8.*x* system running SAP to RHEL 8.10 requires several manual steps.

This article provides the steps to upgrade Linux virtual machines (VMs) that use RHEL-SAP-HANA or RHEL-SAP-APPS pay-as-you-go (PAYG) images from 8.*x* to 8.10.

> [!IMPORTANT]
> Red Hat Update Infrastructure (RHUI) is intended only for PAYG images. If you use custom or golden images (also known as bring-your-own-subscription (BYOS)), you must attach the system to Red Hat Subscription Manager (RHSM) or Satellite to receive updates. For more information, see [How to register and subscribe a RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information about performing the upgrade process on custom, golden, and PAYG images provided by Red Hat, see:

- [How to update RHEL from 8.x to 8.10 on Cloud images with the "RHEL for SAP with High Availability and Update Services" subscription](https://access.redhat.com/articles/7071393)
- [More recommendations for HA cluster nodes using the RHEL HA add-on](https://access.redhat.com/articles/7071393#cluster)
- [Recommended Practices for Applying Software Updates to a RHEL High Availability or Resilient Storage Cluster](https://access.redhat.com/articles/2059253#pacemaker)

> [!NOTE] 
> RHEL 8.10 is the final RHEL 8 release, and maintenance is defined by the [Maintenance Support 2 Phase policy](https://access.redhat.com/support/policy/updates/errata#Maintenance_Support_2_Phase).

## Prerequisites

- Make a backup of the Linux VM or a snapshot of the operating system (OS) disk.
- Set up access to the Serial Console.
- Stop the SAP process during the OS update process.
- Run the commands in this article with root privileges.
- Before upgrading production systems to 8.10, verify that this release is compatible with the required SAP software. For more information, see [SAP Software on Linux: General information - SAP note 2369910](https://launchpad.support.sap.com/#/notes/2369910).

## Upgrade RHEL-SAP-HANA PAYG images from 8.x to 8.10

> [!IMPORTANT]  
> RHEL 8.10 isn't currently certified to run SAP High-performance ANalytic Appliance (HANA). This certification is in process. For more information, see [Overview Product Availability Matrix for SAP on Red Hat](https://access.redhat.com/articles/6966927#support-matrix-for-sap-hana-on-intel-64-rhel-5).

1. Remove the RHUI E4S package installed or updated on the VM:

    ```bash
    sudo dnf remove $(rpm -qa | grep -i rhui)
    ```

2. Remove the version lock file:

    ```bash
    sudo rm /etc/yum/vars/releasever
    ```

3. Create a config file by using this command:

   ```bash
   sudo tee rhel8-base-sap-ha.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8-base-sap-ha]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-ha)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8-base-sap-ha\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```
   
4. Install the *rhui-azure-rhel8-base-sap-ha* package:

    ```bash
    sudo dnf --config rhel8-base-sap-ha.config install rhui-azure-rhel8-base-sap-ha
    ```

5. Verify that the corresponding repositories are available and show no errors:

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

    > [!IMPORTANT]
    > A single host can accommodate both SAP HANA and other SAP applications, such as NetWeaver. In this case, all the preceding repositories are required. Optionally, you can modify the */etc/yum.repos.d/rh-cloud-base-sap-ha.repo* file based on your system's specific requirements.

6. Upgrade the system to RHEL 8.10:

    ```bash
    sudo dnf update
    ```

7. Reboot the VM to complete the upgrade:

    ```bash
    sudo reboot 
    ```

## Upgrade RHEL-SAP-APPS PAYG images from 8.x to 8.10

1. Remove the RHUI EUS-SAP package installed:

    ```bash
    sudo dnf remove $(rpm -qa | grep -i rhui)
    ```

2. Remove the version lock file:

    ```bash
    sudo rm /etc/yum/vars/releasever
    ```
3. Create a config file by using this command:

    ```bash
    sudo tee rhel8-base-sap-apps.config > /dev/null <<< $'[rhui-microsoft-azure-rhel8-base-sap-apps]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 8 (rhel8-base-sap-apps)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel8-base-sap-apps\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
    ```
    
4. Install the *rhui-azure-rhel8-base-sap-apps* package:

    ```bash
    sudo dnf --config rhel8-base-sap-apps.config install rhui-azure-rhel8-base-sap-apps
    ```

5. Verify that the corresponding repositories are available and show no errors:

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

6. Upgrade the system to RHEL 8.10:

    ```bash
    sudo dnf update
    ```

7. Reboot the VM to complete the upgrade:

    ```bash
    sudo reboot 
    ```

## Next steps

If your next target is to move to RHEL 9 for SAP environments, see [How to upgrade SAP-HANA and SAP-APPS PAYG virtual machines from RHEL 8.x to RHEL 9.x using Leapp](leapp-upgrade-rhel-8dotx-to-9dotx-saphana-sapapps.md) for more details.


[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
