---
title: Upgrade RHEL-SAP-HANA and RHEL-SAP-APPS PAYG VMs from 7.x to 7.9
description: Provides steps to help you upgrade RHEL-SAP-HANA and RHEL-SAP-APPS pay-as-you-go virtual machines from 7.x to 7.9.
ms.reviewer: divargas, msaenzbo, v-weizhu
ms.topic: how-to
ms.date: 09/14/2024
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
---
# How to upgrade RHEL-SAP-HANA and RHEL-SAP-APPS pay-as-you-go virtual machines from 7.x to 7.9

**Applies to:** :heavy_check_mark: Linux VMs

While Red Hat Enterprise Linux (RHEL) for SAP 7.*x* (where *x* isn't equal to 9) can be accessed in Update Services for SAP Solutions (E4S) and Extended Update Support (EUS), RHEL for SAP 7.9 follows a different approach. In this case, the related content is available in unversioned repositories. As a result, updating a RHEL 7.*x* system running SAP to RHEL 7.9 requires several manual steps.

This article provides the steps to upgrade Linux virtual machines (VMs) that use RHEL-SAP-HANA or RHEL-SAP-APPS pay-as-you-go (PAYG) images from 7.*x* to 7.9.

> [!IMPORTANT]
> Red Hat Update Infrastructure (RHUI) is intended only for PAYG images. If you use custom or golden images (also known as bring-your-own-subscription (BYOS)), you must attach the system to Red Hat Subscription Manager (RHSM) or Satellite to receive updates. For more information, see [How to register and subscribe a RHEL system to the Red Hat Customer Portal using RHSM](https://access.redhat.com/solutions/253273).

For more information about performing the upgrade process on custom, golden, or PAYG images provided by Red Hat, see:

- [How to update RHEL from 7.x to 7.9 on Cloud Images with the "RHEL for SAP with High Availability and Update Services" subscription](https://access.redhat.com/articles/5805571)

- [Recommended Practices for Applying Software Updates to a RHEL High Availability or Resilient Storage Cluster](https://access.redhat.com/articles/2059253#pacemaker)

> [!NOTE] 
> RHEL 7.9 is the final RHEL 7 release, and maintenance is defined by the [Maintenance Support 2 Phase policy](https://access.redhat.com/support/policy/updates/errata#Maintenance_Support_2_Phase).

## Prerequisites

- Make a backup of the Linux VM or a snapshot of the operating system (OS) disk.
- Set up access to the Serial Console.
- Stop the SAP process during the OS update process.
- Run the commands in this article with root privileges.

## Upgrade RHEL-SAP-HANA PAYG images from 7.x to 7.9

1. Remove the RHUI E4S package installed or updated on the VM:

    ```bash
    sudo yum remove $(rpm -qa | grep -i rhui)
    ```

2. Remove the version lock file:

    ```bash
    sudo rm /etc/yum/vars/releasever
    ```
3. Create a config file by using this command:

   ```bash
   sudo tee rhel7-base-sap-ha.config > /dev/null <<< $'[rhui-microsoft-azure-rhel7-base-sap-ha]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 7 (rhel7-base-sap-ha)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel7-base-sap-ha\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```
4. Install the *rhui-azure-rhel7-base-sap-ha* package:

    ```bash
    sudo yum --config rhel7-base-sap-ha.config install rhui-azure-rhel7-base-sap-ha
    ```
    
5. Verify that the corresponding repositories are available and show no errors:

    ```bash
    sudo yum repolist
    ```

    ```output
    Loaded plugins: langpa cks, product-id, search-disabled-repos, yum_rhui_plugin
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

    > [!IMPORTANT]
    > A single host can accommodate both SAP HANA and other SAP applications, such as NetWeaver. In this case, all the preceding repositories are required. Optionally, you can modify the */etc/yum.repos.d/rh-cloud-base-sap-ha.repo* file based on your system's specific requirements.

6. Upgrade the system to RHEL 7.9:

    ```bash
    sudo yum update
    ```
7. Reboot the VM to complete the upgrade:

    ```bash
    sudo reboot 
    ```

## Upgrade RHEL-SAP-APPS PAYG images from 7.x to 7.9

1. Remove the RHUI EUS-SAP package installed:

    ```bash
    sudo yum remove $(rpm -qa | grep -i rhui)
    ```
2. Remove the version lock file:

    ```bash
    sudo rm /etc/yum/vars/releasever
    ```
3. Create a config file by using this command:

   ```bash
   sudo tee rhel7-base-sap-apps.config > /dev/null <<< $'[rhui-microsoft-azure-rhel7-base-sap-apps]\nname=Microsoft Azure RPMs for Red Hat Enterprise Linux 7 (rhel7-base-sap-apps)\nbaseurl=https://rhui4-1.microsoft.com/pulp/repos/unprotected/microsoft-azure-rhel7-base-sap-apps\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nsslverify=1'
   ```
   
4. Install the *rhui-azure-rhel7-base-sap-apps* package:

    ```bash
    sudo yum --config rhel7-base-sap-apps.config install rhui-azure-rhel7-base-sap-apps
    ```

5. Verify that the corresponding repositories are available and show no errors:

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

6. Upgrade the system to RHEL 7.9:

    ```bash
    sudo yum update
    ```

7. Reboot the VM to complete the upgrade:

    ```bash
    sudo reboot
    ```

## Next steps

If your next target is to move to RHEL 8 for SAP environments, see [How to upgrade SAP-HANA and SAP-APPS PAYG virtual machines from RHEL 7.9 to RHEL 8.x using Leapp](leapp-upgrade-rhel7dot9-to-8dotx-saphana-sapapps.md) for details.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]





