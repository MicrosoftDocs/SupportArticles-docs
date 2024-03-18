---
title: Troubleshoot Linux VM deployment
description: Troubleshoot Resource Manager deployment issues when you create a new Linux virtual machine in Azure.
services: virtual-machines, azure-resource-manager
documentationcenter: ''

author: srijang
manager: dcscontentpm
tags: top-support-issue, azure-resource-manager
ms.custom: linux-related-content
ms.service: virtual-machines
ms.subservice: vm-deploy
ms.collection: linux
ms.workload: na
ms.tgt_pltfrm: vm-linux
ms.topic: troubleshooting
ms.date: 12/09/2021
ms.author: srijangupta
---
# Troubleshoot Resource Manager deployment issues with creating a new Linux virtual machine in Azure

[!INCLUDE [virtual-machines-troubleshoot-deployment-new-vm-opening](../../includes/azure/virtual-machines-troubleshoot-deployment-new-vm-opening-include.md)]

[!INCLUDE [support-disclaimer](../../includes/support-disclaimer.md)]

## Provisioning Troubleshooting

A typical provisioning failure scenario occurs after you create a custom image, then deploy a VM from it, you then experience unto 40mins where the VM status is showing `creating`, and you see this error message:

```text
Provisioning state Provisioning failed. 

OS Provisioning for VM 'sentilo' did not finish in the allotted time. 

The VM may still finish provisioning successfully. Please check provisioning state later. 

Also, make sure the image has been properly prepared (generalized). * Instructions for Windows: https://azure.microsoft.com/documentation/articles/virtual-machines-windows-upload-image/ * Instructions for Linux: https://azure.microsoft.com/documentation/articles/virtual-machines-linux-capture-image/.
```

Or:

```text
Deployment failed. Correlation ID: f9dcb33a-4e6e-45c5-9c9d-b29dd73da2e0. {
  "status": "Failed",
  "error": {
    "code": "ResourceDeploymentFailure",
    "message": "The resource operation completed with terminal provisioning state 'Failed'.",
    "details": [
      {
        "code": "OSProvisioningInternalError",
        "message": "OS Provisioning failed for VM 'iWishThisWouldCreateVM01' due to an internal error: The VM encountered an error during deployment. Please visit https://aka.ms/linuxprovisioningerror for more information on remediation."
      }
    ]
  }
}

```

You then see the VM state marked as `failed`.

### Why do provisioning failures occur?

Commonly, provisioning failures can happen for multiple reasons, such as:

- Missing provisioning /incorrectly configured agent

  - You will need to ensure an agent is present and is working correctly, you should be using [cloud-init](/azure/virtual-machines/linux/using-cloud-init) or if your image will not support this, you can review these [steps](/azure/virtual-machines/linux/no-agent).

- Incorrect image configuration

  - We have guidance on how images should be set up with cloud-init and other [Azure image requirements](/azure/virtual-machines/linux/create-upload-generic), please check this.

### Troubleshoot provisioning failures

To identify the reason for failed provisioning you will need to start with the serial log, this is available to you by deploying the VM with Azure Boot diagnostics.

You will need to deploy a new VM with [boot diagnostics enabled](/cli/azure/vm/boot-diagnostics) for the VM with the failing image to access provisioning events in the serial log.

```azurecli
# create resource group
resourceGroup=myBrokenImageRG
location=westus2
az group create --name $resourceGroup --location $location

# create storage account

storageacct=mydiagdata$RANDOM

az storage account create \
  --resource-group $resourceGroup \
  --name $storageacct \
  --sku Standard_LRS \
  --location $location

# create VM
vmName=iWishThisWouldCreateVM01
brokenImageName=<ResourceID of brokenImage>
sshPubkeyPath=""

az vm create \
    --resource-group $resourceGroup \
    --name $vmName \
    --image $brokenImageName \
    --admin-username azadmin \
    --ssh-key-value $sshPubkeyPath \
    --boot-diagnostics-storage $storageacct
```

To view the serial log, you can go to the Portal, or run the command below to download the 'serialConsoleLogBlobUri' log:

```azurecli
az vm boot-diagnostics get-boot-log-uris --name $vmName --resource-group $resourceGroup
```

### Understanding the serial log for system events and provisioning events

When the VM is created for the first time, cloud-init will start up and try to mount an ISO, establish network connectivity, set the properties passed during the VM creation, mount the ephemeral disk (on supported VM sizes), and signal back to the Azure platform that the initial OS config has completed.

| System Events and Key Information | Serial Log | Notes |
|---|---|---|
| Kernel release and kernel version | `[    0.000000] Linux version 5.4.0-1031-azure (buildd@lcy01-amd64-021) (gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #32~18.04.1-Ubuntu SMP Tue Oct 6 10:03:22 UTC 2020 (Ubuntu 5.4.0-1031.32~18.04.1-azure 5.4.65)` | Appears at the beginning of the serial log. |
| Kernel command-line options | `[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-1031-azure root=UUID=8c0a4742-2f51-40b4-b659-357cfb0bb2a3 ro console=tty1 console=ttyS0 earlyprintk=ttyS0`<br>`[    0.503399] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-1031-azure root=UUID=8c0a4742-2f51-40b4-b659-357cfb0bb2a3 ro console=tty1 console=ttyS0 earlyprintk=ttyS0` | Appears at the beginning of the serial log. Search for `command line:`. |
| Systemd version | `[    8.626739] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)` | Search for `systemd`. |
| Systemd targets reached | `[ [0;32m  OK   [0m] Reached target Swap.`<br>`[ [0;32m  OK   [0m] Reached target User and Group Name Lookups.`<br>`[ [0;32m  OK   [0m] Reached target Slices.`<br>`[ [0;32m  OK   [0m] Reached target Local File Systems (Pre).`<br>`[ [0;32m  OK   [0m] Reached target Local Encrypted Volumes.`<br>`[ [0;32m  OK   [0m] Reached target Local File Systems.`<br>`[ [0;32m  OK   [0m] Reached target System Time Synchronized.`<br>`[ [0;32m  OK   [0m] Reached target Network (Pre).`<br>`[ [0;32m  OK   [0m] Reached target Network.`<br>`[ [0;32m  OK   [0m] Reached target Host and Network Name Lookups.`<br>`[ [0;32m  OK   [0m] Reached target Cloud-config availability.`<br>`[ [0;32m  OK   [0m] Reached target System Initialization`<br>`[ [0;32m  OK   [0m] Reached target Timers.`<br>`[ [0;32m  OK   [0m] Reached target Paths.`<br>`[ [0;32m  OK   [0m] Reached target Network is Online.`<br>`[ [0;32m  OK   [0m] Reached target Remote File Systems (Pre).`<br>`[ [0;32m  OK   [0m] Reached target Remote File Systems.`<br>`[ [0;32m  OK   [0m] Reached target Sockets.`<br>`[ [0;32m  OK   [0m] Reached target Basic System.`<br>`[ [0;32m  OK   [0m] Reached target Login Prompts.` | Search for `Reached target`. |
| Common systemd networking targets across different distros | `[ [0;32m  OK   [0m] Reached target Network (Pre).`<br>`[ [0;32m  OK   [0m] Reached target Network.`<br>`[ [0;32m  OK   [0m] Reached target Network is Online.` | Search for `Reached target Network`. |
| In-depth networking status and networking targets for Ubuntu and distros where system networking is managed by `systemd-network`. | `Starting Network Time Synchronization...`<br>`[ [0;32m  OK   [0m] Started Network Time Synchronization.`<br>`Starting Initial cloud-init job (pre-networking)...`<br>`[ [0;32m  OK   [0m] Started Initial cloud-init job (pre-networking).`<br>`[ [0;32m  OK   [0m] Reached target Network (Pre).`<br>`Starting Network Service...`<br>`[ [0;32m  OK   [0m] Started Network Service.`<br>`Starting Wait for Network to be Configured...`<br>`Starting Network Name Resolution...`<br>`[ [0;32m  OK   [0m] Started Network Name Resolution.`<br>`[ [0;32m  OK   [0m] Reached target Network.`<br>`[ [0;32m  OK   [0m] Reached target Host and Network Name Lookups.`<br>`[ [0;32m  OK   [0m] Started Wait for Network to be Configured.`<br>`[ [0;32m  OK   [0m] Reached target Network is Online.`<br>`Starting Dispatcher daemon for systemd-networkd...`<br>`[ [0;32m  OK   [0m] Started Dispatcher daemon for systemd-networkd.` | Search for `network` or `networkd`. |
| In-depth networking status and networking targets for RHEL/CentOS and distros where system networking is managed by `Network Manager`. | `Starting Read and set NIS domainname from /etc/sysconfig/network...`<br>`[ [32m  OK   [0m] Started Read and set NIS domainname from /etc/sysconfig/network.`<br>`Starting Import network configuration from initramfs...`<br>`[ [32m  OK   [0m] Started Import network configuration from initramfs.`<br>`Starting Initial cloud-init job (pre-networking)...`<br>`[ [32m  OK   [0m] Started Initial cloud-init job (pre-networking).`<br>`[ [32m  OK   [0m] Reached target Network (Pre).`<br>`Starting Network Manager...`<br>`[ [32m  OK   [0m] Started Network Manager.`<br>`Starting Network Manager Wait Online...`<br>`Starting Network Manager Script Dispatcher Service...`<br>`[ [32m  OK   [0m] Started Network Manager Script Dispatcher Service.`<br>`[ [32m  OK   [0m] Started Network Manager Wait Online.`<br>`Starting LSB: Bring up/down networking...`<br>`[ [32m  OK   [0m] Started LSB: Bring up/down networking.`<br>`[ [32m  OK   [0m] Reached target Network.`<br>`[ [32m  OK   [0m] Reached target Network is Online.` | Search for `network` or `Network Manager`. |
| In-depth networking status and networking targets for SUSE/SLES and distros where system networking is managed by `Wicked`. | `Starting Initial cloud-init job (pre-networking)...`<br>`[ [0;32m  OK   [0m] Reached target Host and Network Name Lookups.`<br>`[ [0;32m  OK   [0m] Started Initial cloud-init job (pre-networking).`<br>`[ [0;32m  OK   [0m] Reached target Network (Pre).`<br>`Starting wicked DHCPv6 supplicant service...`<br>`Starting wicked DHCPv4 supplicant service...`<br>`Starting wicked AutoIPv4 supplicant service...`<br>`[ [0;32m  OK   [0m] Started wicked DHCPv6 supplicant service.`<br>`[ [0;32m  OK   [0m] Started wicked DHCPv4 supplicant service.`<br>`[ [0;32m  OK   [0m] Started wicked AutoIPv4 supplicant service.`<br>`Starting wicked network management service daemon...`<br>`[ [0;32m  OK   [0m] Started wicked network management service daemon.`<br>`Starting wicked network nanny service...`<br>`[ [0;32m  OK   [0m] Started wicked network nanny service.`<br>`Starting wicked managed network interfaces...`<br>`[    [0;31m* [0;1;31m* [0m [0;31m* [0m] A start job is running for wicked m…etwork interfaces (22s / no limit)`<br>`[K[   [0;31m* [0;1;31m* [0m [0;31m*  [0m] A start job is running for wicked m…etwork interfaces (28s / no limit)`<br>`[K[  [0;31m* [0;1;31m* [0m [0;31m*   [0m] A start job is running for wicked m…etwork interfaces (32s / no limit)`<br>`[K[ [0;32m  OK   [0m] Started wicked managed network interfaces.`<br>`[ [0;32m  OK   [0m] Reached target Network.`<br>`[ [0;32m  OK   [0m] Reached target Network is Online.` | Search for `network` or `wicked`. |
| Did boot reach far enough for cloud-init to start? | `Starting Initial cloud-init job (pre-networking)...`<br>`Starting Initial cloud-init job (metadata service crawler)...` | Search for `Starting Initial cloud-init job`. |
| Cloud-init version and cloud-init stages reached | `[   22.446387] cloud-init[703]: Cloud-init v. 20.3-2-g371b392c-0ubuntu1~18.04.1 running 'init-local' at Wed, 28 Oct 2020 17:46:30 +0000. Up 21.23 seconds.`<br>`[   28.357120] cloud-init[837]: Cloud-init v. 20.3-2-g371b392c-0ubuntu1~18.04.1 running 'init' at Wed, 28 Oct 2020 17:46:34 +0000. Up 24.52 seconds.`<br>`[   50.421009] cloud-init[1445]: Cloud-init v. 20.3-2-g371b392c-0ubuntu1~18.04.1 running 'modules:config' at Wed, 28 Oct 2020 17:46:57 +0000. Up 48.21 seconds.`<br>`[   51.338792] cloud-init[1541]: Cloud-init v. 20.3-2-g371b392c-0ubuntu1~18.04.1 running 'modules:final' at Wed, 28 Oct 2020 17:47:00 +0000. Up 51.01 seconds.`<br>`[   51.366837] cloud-init[1541]: Cloud-init v. 20.3-2-g371b392c-0ubuntu1~18.04.1 finished at Wed, 28 Oct 2020 17:47:01 +0000. Datasource DataSourceAzure [seed=/dev/sr0].  Up 51.32 seconds` | Search for `Cloud-init v`. |
| Network interfaces (NICs), NIC states (up/down), and NIC IP addresses. Shows if NIC IP addresses were properly configured and assigned. IP address assignment could either be dynamic through DHCP or statically configured. | `[   28.381544] cloud-init[837]: ci-info: ++++++++++++++++++++++++++++++++++++++Net device info+++++++++++++++++++++++++++++++++++++++`<br>`[   28.396781] cloud-init[837]: ci-info: +--------+------+-----------------------------+---------------+--------+-------------------+`<br>`[   28.416501] cloud-init[837]: ci-info: | Device |  Up  |           Address           |      Mask     | Scope  |     Hw-Address    |`<br>`[   28.427493] cloud-init[837]: ci-info: +--------+------+-----------------------------+---------------+--------+-------------------+`<br>`[   28.446544] cloud-init[837]: ci-info: |  eth0  | True |           10.0.0.4          | 255.255.255.0 | global | 00:0d:3a:c6:17:d5 |`<br>`[   28.460031] cloud-init[837]: ci-info: |  eth0  | True | fe80::20d:3aff:fec6:17d5/64 |       .       |  link  | 00:0d:3a:c6:17:d5 |`<br>`[   28.476415] cloud-init[837]: ci-info: |   lo   | True |          127.0.0.1          |   255.0.0.0   |  host  |         .         |`<br>`[   28.487962] cloud-init[837]: ci-info: |   lo   | True |           ::1/128           |       .       |  host  |         .         |`<br>`[   28.498191] cloud-init[837]: ci-info: +--------+------+-----------------------------+---------------+--------+-------------------+` | Search for `ci-info` or `Net device info`. |
| IP routes (IPv4 and IPv6). Shows IP routes for various endpoints such as the VNet subnet, the Azure endpoint (`168.63.129.16`), and Azure Instance Metadata Server/IMDS endpoint (`169.254.169.254`). | `[   28.508190] cloud-init[837]: ci-info: ++++++++++++++++++++++++++++++Route IPv4 info+++++++++++++++++++++++++++++++`<br>`[   28.522189] cloud-init[837]: ci-info: +-------+-----------------+----------+-----------------+-----------+-------+`<br>`[   28.531173] cloud-init[837]: ci-info: | Route |   Destination   | Gateway  |     Genmask     | Interface | Flags |`<br>`[   28.549782] cloud-init[837]: ci-info: +-------+-----------------+----------+-----------------+-----------+-------+`<br>`[   28.562896] cloud-init[837]: ci-info: |   0   |     0.0.0.0     | 10.0.0.1 |     0.0.0.0     |    eth0   |   UG  |`<br>`[   28.571653] cloud-init[837]: ci-info: |   1   |     10.0.0.0    | 0.0.0.0  |  255.255.255.0  |    eth0   |   U   |`<br>`[   28.580192] cloud-init[837]: ci-info: |   2   |  168.63.129.16  | 10.0.0.1 | 255.255.255.255 |    eth0   |  UGH  |`<br>`[   28.587633] cloud-init[837]: ci-info: |   3   | 169.254.169.254 | 10.0.0.1 | 255.255.255.255 |    eth0   |  UGH  |`<br>`[   28.600728] cloud-init[837]: ci-info: +-------+-----------------+----------+-----------------+-----------+-------+`<br>`[   28.611117] cloud-init[837]: ci-info: +++++++++++++++++++Route IPv6 info+++++++++++++++++++`<br>`[   28.619534] cloud-init[837]: ci-info: +-------+-------------+---------+-----------+-------+`<br>`[   28.629292] cloud-init[837]: ci-info: | Route | Destination | Gateway | Interface | Flags |`<br>`[   28.638596] cloud-init[837]: ci-info: +-------+-------------+---------+-----------+-------+`<br>`[   28.647791] cloud-init[837]: ci-info: |   1   |  fe80::/64  |    ::   |    eth0   |   U   |`<br>`[   28.660622] cloud-init[837]: ci-info: |   3   |    local    |    ::   |    eth0   |   U   |`<br>`[   28.670776] cloud-init[837]: ci-info: |   4   |   ff00::/8  |    ::   |    eth0   |   U   |`<br>`[   28.691506] cloud-init[837]: ci-info: +-------+-------------+---------+-----------+-------+` | Search for `ci-info`, `Route IPv4 info`, or `Route IPv6 info`. |
| SSH authorized keys for users on the VM. The `authorized_keys` file in SSH specifies the SSH keys that can be used for logging into the user account for which the file is configured. | `ci-info: ++++++++++++++++++++++++++Authorized keys from /home/azureuser/.ssh/authorized_keys for user azureuser+++++++++++++++++++++++++++`<br>`ci-info: +---------+-------------------------------------------------------------------------------------------------+---------+---------+`<br>`ci-info: | Keytype |                                       Fingerprint (sha256)                                      | Options | Comment |`<br>`ci-info: +---------+-------------------------------------------------------------------------------------------------+---------+---------+`<br>`ci-info: | ssh-rsa | 88:b0:2a:ce:f5:91:49:a2:01:07:a4:e5:db:b3:8c:3e:7e:1f:52:83:53:3c:83:4f:a3:a7:17:13:65:a3:47:e2 |    -    |    -    |`<br>`ci-info: +---------+-------------------------------------------------------------------------------------------------+---------+---------+` | Search for `Authorized keys`. |
| SSH host key generation. A host key is a cryptographic key used for authenticating computers in the SSH protocol. Host keys are key pairs, typically using the RSA, DSA, or ECDSA algorithms. Public host keys are stored on and/or distributed to SSH clients, and private keys are stored on SSH servers. | `Starting OpenSSH Server Key Generation...`<br>`[ [32m  OK   [0m] Started OpenSSH Server Key Generation.`<br>`[   40.437735] cloud-init[837]: Generating public/private rsa key pair.`<br>`[   40.451048] cloud-init[837]: Your identification has been saved in /etc/ssh/ssh_host_rsa_key.`<br>`[   40.473777] cloud-init[837]: Your public key has been saved in /etc/ssh/ssh_host_rsa_key.pub.`<br>`[   40.489730] cloud-init[837]: The key fingerprint is:`<br>`[   40.501705] cloud-init[837]: SHA256:NGxA6sf9EAMtczaFSBSJqiGkafEZuPUykNLxefbXofM root@myVmName`<br>`[   40.686610] cloud-init[837]: Generating public/private dsa key pair.`<br>`[   40.712350] cloud-init[837]: Your identification has been saved in /etc/ssh/ssh_host_dsa_key.`<br>`[   40.721901] cloud-init[837]: Your public key has been saved in /etc/ssh/ssh_host_dsa_key.pub.`<br>`[   40.721966] cloud-init[837]: The key fingerprint is:`<br>`[   40.722011] cloud-init[837]: SHA256:QjoxEw9PNOg0P3LW6wnSZzjsfQQ4vhW8S0dAuNWkWHM root@myVmName`<br>`[   40.722606] cloud-init[837]: Generating public/private ecdsa key pair.`<br>`[   40.722650] cloud-init[837]: Your identification has been saved in /etc/ssh/ssh_host_ecdsa_key.`<br>`[   40.722690] cloud-init[837]: Your public key has been saved in /etc/ssh/ssh_host_ecdsa_key.pub.`<br>`[   40.722734] cloud-init[837]: The key fingerprint is:`<br>`[   40.722774] cloud-init[837]: SHA256:BaFqan71k4blzY8TQrLQOavMWoKHgUDgxEAuB0ouJCo root@myVmName`<br>`[   41.063239] cloud-init[837]: Generating public/private ed25519 key pair.`<br>`[   41.091125] cloud-init[837]: Your identification has been saved in /etc/ssh/ssh_host_ed25519_key.`<br>`[   41.120794] cloud-init[837]: Your public key has been saved in /etc/ssh/ssh_host_ed25519_key.pub.`<br>`[   41.154126] cloud-init[837]: The key fingerprint is:`<br>`[   41.157135] cloud-init[837]: SHA256:KsKfIKjwGpMgbYYved5v5oNE6v6eeUwI4AxeeigXk14 root@myVmName` | Search for `Generating public/private`, `Your identification has been saved in`, `The key fingerprint is:`, or `SHA`. |
| Dump of ssh host key fingerprints. | `<14>Oct 28 17:47:00 ec2: #############################################################`<br>`<14>Oct 28 17:47:00 ec2: -----BEGIN SSH HOST KEY FINGERPRINTS-----`<br>`<14>Oct 28 17:47:00 ec2: 1024 SHA256:QjoxEw9PNOg0P3LW6wnSZzjsfQQ4vhW8S0dAuNWkWHM root@myVmName (DSA)`<br>`<14>Oct 28 17:47:00 ec2: 256 SHA256:BaFqan71k4blzY8TQrLQOavMWoKHgUDgxEAuB0ouJCo root@myVmName (ECDSA)`<br>`<14>Oct 28 17:47:00 ec2: 256 SHA256:KsKfIKjwGpMgbYYved5v5oNE6v6eeUwI4AxeeigXk14 root@myVmName (ED25519)`<br>`<14>Oct 28 17:47:00 ec2: 2048 SHA256:NGxA6sf9EAMtczaFSBSJqiGkafEZuPUykNLxefbXofM root@myVmName (RSA)`<br>`<14>Oct 28 17:47:00 ec2: -----END SSH HOST KEY FINGERPRINTS-----`<br>`<14>Oct 28 17:47:00 ec2: #############################################################` | Search for `BEGIN SSH HOST KEY FINGERPRINTS` and `END SSH HOST KEY FINGERPRINTS`. |
| Dump of ssh host keys. | `-----BEGIN SSH HOST KEY KEYS-----`<br>`ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFzu1pBMlq3g/8ztkQo+ZukigmLzQ02/ogL7Xe8aKjbuM8q4ibo1kWnXB0UuGkGE0DotVyBQsoyUNorTj96G2Xo= root@myVmName`<br>`ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIbGOVk/IMfL+RZBDo6YlfbKncVTIBy7wSrqL5ixX6yZ root@myVmName`<br>`ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDnH5sIIEFi2ne6CMk1jscVQ289i4idOMJt3WwzHR1lOgJf9kPY+WzmFw71Ai9ZEpqSTpYWxgt+z26ujxAE3R1LvOn1QKetlsPLT5FH8oIZESXmYDb/KL/4k81aDelzko1Xipk5SSai8LeX1qglKUEyGevht9S+QQTHK8Ed++UDzNidCk02iAdhpX/0E5d09NE4r+v5wAojOazLnq6JaESYV07SI7rBOGO7hCdSrQwWodYnhyTQRP3FbqjUeNRqBl3uqlH3+rgMAAPsCpToFTCperTRmyBrCbspzpxIpQSEFbf639EL/7Cst/Ff2ND0D0zVAaSdrmFZisYUcO+VRanZ root@myVmName`<br>`-----END SSH HOST KEY KEYS-----` | Search for `BEGIN SSH HOST KEY KEYS` and `END SSH HOST KEY KEYS`. |
| Did the SSH server start? | `Starting OpenBSD Secure Shell server...`<br>`[ [0;32m  OK   [0m] Started OpenBSD Secure Shell server.`<br>`Starting OpenSSH server daemon...`<br>`[ [32m  OK   [0m] Started OpenSSH server daemon.`<br>`Starting OpenSSH Daemon...`<br>`[ [0;32m  OK   [0m] Started OpenSSH Daemon.` | Search for `Secure Shell server`, `OpenSSH server daemon`, or `OpenSSH Daemon`. |
| Are user sessions and user logins permitted? Is the VM showing a user login prompt? | `Starting Accounts Service...`<br>`Starting Permit User Sessions...`<br>`Starting Login Service...`<br>`[ [0;32m  OK   [0m] Started Permit User Sessions.`<br>`[ [0;32m  OK   [0m] Started Login Service.`<br>`[ [0;32m  OK   [0m] Reached target Login Prompts.`<br>`[ [0;32m  OK   [0m] Started Accounts Service.`<br>`Ubuntu 18.04.5 LTS myVmName ttyS0`<br>`myVmName login:` | Search for `Accounts Service`, `Permit User Sessions`, `Login Service`, `Login Prompts`, and `login:`. |
| Did the Azure Linux Agent successfully start? | `[ [0;32m  OK   [0m] Started Azure Linux Agent.`<br>`2020/10/28 17:46:52.082569 INFO Daemon Azure Linux Agent Version:2.2.45` | Search for `Azure Linux Agent`. |
| From the Azure Linux Agent's point of view, did the VM successfully finish provisioning? Was the VM extension handler started by the Azure Linux Agent after provisioning succeeded? The Azure Linux Agent only starts the VM extension handler if it detects VM provisioning succeeded. | `2020/10/28 17:46:52.586765 INFO Daemon Finished provisioning` | Search for `INFO Daemon Finished provisioning`. |
| Were there any errors, failures, or exceptions in the serial log? | Search for `fail`, `error`, `warn`, and `exception` in the serial logs. | |

### Common Errors

#### UDF driver Blocklisted

**Error**: In the serial log:

```text
[   10.855501] cloud-init[732]: Cloud-init v. 20.4.1-0ubuntu1~18.04.1 running 'init-local' at Thu, 28 Jan 2021 23:43:02 +0000. Up 10.68 seconds.
[   10.869581] cloud-init[732]: 2021-01-28 23:43:03,097 - azure.py[WARNING]: /dev/sr0 was not mountable
[   10.875608] cloud-init[732]: 2021-01-28 23:43:03,106 - azure.py[ERROR]: No Azure metadata found
[   10.885776] cloud-init[732]: 2021-01-28 23:43:03,107 - azure.py[ERROR]: Could not crawl Azure metadata: No Azure metadata found
[   14.634117] cloud-init[732]: 2021-01-28 23:43:06,876 - azure.py[WARNING]: Reported failure to Azure fabric.
```

In waagent.log:

```text
"UDF driver Blocklisted 2020/09/11 19:16:40.240016 ERROR Daemon Provisioning failed: [ProtocolError] [CopyOvfEnv] Error mounting dvd: [OSUtilError] Failed to mount dvd deviceInner error: [mount -o ro -t udf,iso9660 /dev/sr0 /mnt/cdrom/secure] returned 32: mount: /mnt/cdrom/secure: wrong fs type, bad option, bad superblock on /dev/sr0, missing codepage or helper program, or other error."
```

**Cause**: The UDF driver is not loaded in the kernel, this is required for the VM to provision, see [image requirements](/azure/virtual-machines/linux/create-upload-generic).

When a VM is first provisioned on Azure, the Azure host presents a 'provisioning cdrom iso disk' to the VM. This provisioning disk is usually presented to the VM through /dev/sr0. Within the provisioning disk, there is a provisioning manifest which contains a VM's provisioning information. The in-VM provisioning agent is expected to mount the provisioning disk, read the provisioning manifest, and provision the VM accordingly

Since the provisioning disk is a `cdrom iso disk`, the Linux UDF driver is required by the kernel in order to successfully mount this disk. This is referenced in Microsoft [documentation on Linux images](/azure/virtual-machines/linux/create-upload-generic). For this VM, logs indicate that the provisioning disk failed to mount, which caused VM provisioning to fail. The most likely reason is due to missing or blocked UDF drivers.

**Solution**: Ensure the UDF driver is configured to be loaded in the kernel.

A common way for UDF drivers to be blocked is through configs within `/etc/modprobe.d/`. Please work with the customer/image owner to ensure that Linux UDF drivers are present and not blocked. Please consult [this article on blocking/unblocking kernel drivers](https://linux.die.net/man/5/modprobe.d).

#### Unicode characters in VM tags issue

**Error**: In cloud-init.log:

```text
  File "/usr/lib/python2.7/site-packages/cloudinit/sources/DataSourceAzure.py", line 1316, in _get_metadata_from_imds
    except json.decoder.JSONDecodeError:
AttributeError: 'module' object has no attribute 'JSONDecodeError'
```

**Cause**: This happens because VM tags have non-ascii characters and the version of cloud-init is older than 20.3.

**Solution**: Either use or ensure your image supports cloud-init 20.3 or newer, or remove non-ascii characters from the VM tags.

### Password with unicode characters

**Error**: In cloud-init.log:

```text
File "/usr/lib/python2.7/site-packages/cloudinit/sources/DataSourceAzure.py", line 1153, in encrypt_pass
    return crypt.crypt(password, salt_id + util.rand_str(strlen=16))
  File "/usr/lib64/python2.7/crypt.py", line 55, in crypt
    return _crypt.crypt(word, salt)
UnicodeEncodeError: 'ascii' codec can't encode characters in position 10-11: ordinal not in range(128)
```

**Cause**: This happens because the provided password has unsupported characters (non-ascii).

**Solution**: Provide a password that only has ascii characters.

#### Dhclient permission

**Error**: In cloud-init.log:

```text
Command: ['/var/tmp/cloud-init/cloud-init-dhcp-yd8mvxud/dhclient', '-1', '-v', '-lf', '/var/tmp/cloud-init/cloud-init-dhcp-yd8mvxud/dhcp.leases', '-pf', '/var/tmp/cloud-init/cloud-init-dhcp-yd8mvxud/dhclient.pid', 'eth0', '-sf', '/bin/true']
Exit code: -
Reason: [Errno 13] Permission denied: b'/var/tmp/cloud-init/cloud-init-dhcp-yd8mvxud/dhclient'
```

**Cause**: Older versions of cloud-init (before version 20.3) perform DHCP by copying and executing `dhclient` within `/var/tmp`. If `/var/tmp` is mounted as `noexec` (no execution) by the VM, then DHCP will fail due to `dhclient` not having permissions to execute within `/var/tmp`.

Cloud-init versions >= 20.3 contain a fix which falls back and executes `dhclient` "as-is" (by not copying and executing it in `/var/tmp` if there are permissions issues).

**Solution**: For VMs running cloud-init older than version 20.3, configure the VM so that `/var/tmp` is not mounted as `noexec`. Alternatively, upgrade the VM's cloud-init package to a version >= 20.3.

### Getting more logs

If you find that you need more logs from the VM to understand the issues, you maybe can SSH into the VM using the [serial console](/azure/virtual-machines/troubleshooting/serial-console-linux) using a user that is baked into the image. If you do not have a user baked in, then you can either recreate the image with a user, or use the [AZ VM Repair tool](/cli/azure/vm/repair#az-vm-repair-create) which will mount the OS disk of the VM that failed to provision, to another VM.

```azurecli
az vm repair create  \
    --resource-group $resourceGroup \
    --name $vmName \
    --repair-username repairadm \
    --repair-password AnotherPassword123! \
    --repair-vm-name repairVM \
    --verbose
```

### Understanding the cloud-init.log

When you have access to the cloud-init logs, review the [cloud-init troubleshooting documentation](/azure/virtual-machines/linux/cloud-init-troubleshooting).

### Getting Support

If you have referred to the guidance, and still cannot troubleshoot your issue, you can open a support case. When doing so, please select right product and support topic, doing this will engage the correct support team.

Selecting the case product:

```bash
Product Family: Azure
Product: Virtual Machine Running (Window\Linux)
Support Topic: <COMPLETE>
Support Subtopic: <COMPLETE>
```

## Collect activity logs

To start troubleshooting, collect the activity logs to identify the error associated with the issue. The following links contain detailed information on the process to follow.

[View deployment operations](/azure/azure-resource-manager/templates/deployment-history)

[View activity logs to manage Azure resources](/azure/azure-resource-manager/management/view-activity-logs)

[!INCLUDE [virtual-machines-troubleshoot-deployment-new-vm-issue1](../../includes/azure/virtual-machines-troubleshoot-deployment-new-vm-issue1-include.md)]

[!INCLUDE [virtual-machines-linux-troubleshoot-deployment-new-vm-table](../../includes/azure/virtual-machines-linux-troubleshoot-deployment-new-vm-table.md)]

**Y:** If the OS is Linux generalized, and it is uploaded and/or captured with the generalized setting, then there won't be any errors. Similarly, if the OS is Linux specialized, and it is uploaded and/or captured with the specialized setting, then there won't be any errors.

### Upload Errors

**N<sup>1</sup>:** If the OS is Linux generalized, and it is uploaded as specialized, you will get a provisioning timeout error because the VM is stuck at the provisioning stage.

**N<sup>2</sup>:** If the OS is Linux specialized, and it is uploaded as generalized, you will get a provisioning failure error because the new VM is running with the original computer name, username and password.

### Resolution - Upload Error

To resolve both these errors, upload the original VHD, available on premises, with the same setting as that for the OS (generalized/specialized). To upload as generalized, remember to run -deprovision first.

### Capture Errors

**N<sup>3</sup>:** If the OS is Linux generalized, and it is captured as specialized, you will get a provisioning timeout error because the original VM is not usable as it is marked as generalized.

**N<sup>4</sup>:** If the OS is Linux specialized, and it is captured as generalized, you will get a provisioning failure error because the new VM is running with the original computer name, username and password. Also, the original VM is not usable because it is marked as specialized.

### Resolution - Capture Error

To resolve both these errors, delete the current image from the portal, and [recapture it from the current VHDs](/azure/virtual-machines/linux/capture-image) with the same setting as that for the OS (generalized/specialized).

## Issue: Custom/ gallery/ marketplace image; allocation failure

This error arises in situations when the new VM request is pinned to a cluster that either cannot support the VM size being requested, or does not have available free space to accommodate the request.

### Cause 1

The cluster cannot support the requested VM size.

### Resolution 1

- Retry the request using a smaller VM size.

- If the size of the requested VM cannot be changed:

  - Stop all the VMs in the availability set.
    Click **Resource groups** > *your resource group* > **Resources** > *your availability set* > **Virtual Machines** > *your virtual machine* > **Stop**.
  - After all the VMs stop, create the new VM in the desired size.
  - Start the new VM first, and then select each of the stopped VMs and click **Start**.

### Cause 2

The cluster does not have free resources.

### Resolution 2

- Retry the request at a later time.
- If the new VM can be part of a different availability set
  - Create a new VM in a different availability set (in the same region).
  - Add the new VM to the same virtual network.

## Top issues

[!INCLUDE [support-disclaimer](../../includes/azure/virtual-machines-linux-troubleshoot-deploy-vm-top.md)]

### The cluster cannot support the requested VM size

- Retry the request using a smaller VM size.
- If the size of the requested VM cannot be changed:
  - Stop all the VMs in the availability set. Click **Resource groups** > your resource group > **Resources** > your availability set > **Virtual Machines** > your virtual machine > **Stop**.
  - After all the VMs stop, create the VM in the desired size.
  - Start the new VM first, and then select each of the stopped VMs and click Start.

### The cluster does not have free resources

- Retry the request later.
- If the new VM can be part of a different availability set
  - Create a VM in a different availability set (in the same region).
  - Add the new VM to the same virtual network.

## FAQ

### How do I activate my monthly credit for Visual studio Enterprise (BizSpark)

To activate your monthly  credit, see this [article](https://azure.microsoft.com/offers/ms-azr-0064p/).

### Why can I not install the GPU driver for an Ubuntu NV VM?

Currently, Linux GPU support is only available on Azure NC VMs running Ubuntu Server 16.04 LTS. For more information, see [Set up GPU drivers for N-series VMs running Linux](/azure/virtual-machines/linux/n-series-driver-setup).

### My drivers are missing for my Linux N-Series VM

Instructions to install drivers for Linux-based VMs are located [here](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

### I can't find a GPU instance within my N-Series VM

To take advantage of the GPU capabilities of Azure N-series VMs, you must install graphics drivers on each VM after deployment. Driver setup information is available [here](/azure/virtual-machines/sizes-gpu#supported-operating-systems-and-drivers).

### Are N-Series VMs available in my region?

You can check the availability from the [Products available by region table](https://azure.microsoft.com/regions/services), and pricing [here](https://azure.microsoft.com/pricing/details/virtual-machines/series/#n-series).

### I''m not able to see VM Size family that I want when resizing my VM

When a VM is running, it is deployed to a physical server. The physical servers in Azure regions are grouped in clusters of common physical hardware. Resizing a VM that requires the VM to be moved to different hardware clusters is different depending on which deployment model was used to deploy the VM.

- VMs deployed in Classic deployment model, the cloud service deployment must be removed and redeployed to change the VMs to a size in another size family.

- VMs deployed in Resource Manager deployment model, you must stop all VMs in the availability set before changing the size of any VM in the availability set.

### The listed VM size is not supported while deploying in Availability Set

Choose a size that is supported on the availability set's cluster. It is recommended when creating an availability set to choose the largest VM size you think you need, and have that be your first deployment to the Availability set.

### What Linux distributions/versions are supported on Azure?

You can find the list at Linux on [Azure-Endorsed Distributions](/azure/virtual-machines/linux/endorsed-distros).

### Can I add an existing Classic VM to an availability set?

Yes. You can add an existing classic VM to a new or existing Availability Set. For more information see [Add an existing virtual machine to an availability set](/previous-versions/azure/virtual-machines/windows/classic/configure-availability-classic#addmachine).

[!INCLUDE [classic-vm-deprecation](../../includes/azure/classic-vm-deprecation.md)]

## Next steps

- [Supportability of adding Azure VMs to an existing availability set](../virtual-machines-windows/virtual-machines-availability-set-supportability.md)
- [Redeploy Linux virtual machine to new Azure node](redeploy-to-new-node-linux.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
