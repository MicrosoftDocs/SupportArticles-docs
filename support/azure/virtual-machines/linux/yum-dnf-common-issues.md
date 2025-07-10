---
title: Troubleshoot common issues in the yum and dnf package managers
description: Learn how to resolve common troubleshooting issues involving the yum and dnf package management tools for Linux.
author: msaenzbosupport
ms.author: msaenzbo
editor: v-jsitser
ms.reviewer: divargas, adelgadohell
ms.service: azure-virtual-machines
ms.collection: linux
ms.topic: troubleshooting-general
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.custom: linux-related-content
ms.date: 07/10/2025
#customer intent: As an Azure Linux VM administrator, I want troubleshoot issues in the yum and dnf tools so that I can successfully install or update applications on my VMs.
---
# Troubleshoot common issues in the yum and dnf package management tools for Linux

**Applies to:** :heavy_check_mark: Linux VMs

This article discusses and resolves common issues that you might experience when you use `yum` and `dnf` package management tools to install or update applications on Microsoft Azure virtual machines (VMs).

> [!CAUTION]
> This article references CentOS, a Linux distribution that has reached its support end of life (EOL). Consider your use and planning accordingly. For more information, see the [CentOS End Of Life guidance](/azure/virtual-machines/workloads/centos/centos-end-of-life).

## Overview

The [yum](http://yum.baseurl.org) command-line package management tool is used in Linux distributions that employ the RPM Package Manager. The tool name is an acronym for "Yellowdog Updater Modified" and was originally developed for Yellow Dog Linux. The `yum` tool has gained widespread usage, particularly in RPM-based distributions such as Red Hat Enterprise Linux (RHEL), CentOS, Oracle Linux, Mariner, and Fedora.

The [dnf](https://rpm-software-management.github.io) command-line package management tool, or "Dandified Yum," is a modernized and enhanced package manager tool for RPM-based Linux distributions.

## Scenario 1: Repository access issue

You experience errors that apply to certificates or network connectivity.

### Run a validation script

Azure provides the Red Hat Update Infrastructure (RHUI) repository check script on GitHub. This Python script includes the following features: 

- Validates the RHUI client certificate.
- Validates RHUI rpm consistency.
- Checks consistency between Extended Update Support (EUS) and non-EUS repository configurations and their requirements.
- Validates connectivity to the RHUI repositories.
- Reports successful repository connectivity if no errors are detected.
- Verifies SSL connectivity to the RHUI repositories.
- Focuses exclusively on the RHUI repositories.
- Verifies a found error by using the defined conditions and provides recommendations for a fix.

#### Supported Red Hat images

This version of the check script currently supports only the following Red Hat VMs that are deployed from the Azure Marketplace image:

- RHEL 7._x_ PAYG VMs
- RHEL 8._x_ PAYG VMs
- RHEL 9._x_ PAYG VMs
- RHEL 10._x_ PAYG VMs

#### How to run the RHUI check script

To run the check script, enter the following shell commands on a Red Hat VM:

#### [Red Hat 7.x](#tab/rhel7)

1. If the VM has internet access, run the script directly from the VM by using the following command:

    ```bash
    curl -sL https://raw.githubusercontent.com/Azure/azure-support-scripts/refs/heads/master/Linux_scripts/rhui-check/rhui-check.py | sudo python2 -
    ```

2. If the VM doesn't have direct internet access, download the script from the following URL: [RHUI check script](https://raw.githubusercontent.com/Azure/azure-support-scripts/refs/heads/master/Linux_scripts/rhui-check/rhui-check.py), transfer the script to the VM, and then run the following command:

    ```bash
    sudo python2 ./rhui-check.py 
    ```
3. The script generates a report that includes any issues that are found. The script output is also saved in `/var/log/rhuicheck.log` after you run it. 

#### [Red Hat 8.x, 9.x, and 10.x](#tab/rhel8910)

1. If the VM has internet access, run the script directly from the VM by using the following command:

    ```bash
    curl -sL https://raw.githubusercontent.com/Azure/azure-support-scripts/refs/heads/master/Linux_scripts/rhui-check/rhui-check.py | sudo python3 -
    ```

2.  If the VM doesn't have direct internet access, download the script from the following URL: [RHUI check script](https://raw.githubusercontent.com/Azure/azure-support-scripts/refs/heads/master/Linux_scripts/rhui-check/rhui-check.py), transfer the script to the VM, and then run the following command:

    ```bash
    sudo python3 ./rhui-check.py 
    ```
    
    > [!IMPORTANT]
    > Replace python3 with `/usr/libexec/platform-python` in case the `python3` command is not found.

3. The script generates a report that includes any issues that are found. The script output is also saved in `/var/log/rhuicheck.log` after you run it. 

---

### Solution 1

For an RHEL system, see [Troubleshoot Red Hat RHUI certificate issues in Azure](./troubleshoot-linux-rhui-certificate-issues.md) or [Troubleshoot Red Hat RHUI connectivity issues in Azure](./linux-rhui-connectivity-issues.md).

For other Linux distributions, make sure that communication to the corresponding repository is allowed through port 443. Additionally, make sure that the operating system uses a valid certificate if a valid certificate is required.

## Scenario 2: Dependency issue

You might experience any of several errors when you encounter a dependency conflict during an update. The following subsections display the output symptoms of typical dependency errors.

### Symptom 2a

```output
Error: 
 Problem: package leapp-0.16.0-2.el8.noarch requires python3-leapp = 0.16.0-2.el8, but none of the providers can be installed
  - package python2-leapp-0.16.0-1.el7_9.noarch conflicts with python3-leapp provided by python3-leapp-0.16.0-2.el8.noarch
  - package python3-leapp-0.16.0-2.el8.noarch conflicts with python2-leapp provided by python2-leapp-0.16.0-1.el7_9.noarch
  - cannot install the best update candidate for package leapp-0.16.0-1.el7_9.noarch
  - problem with installed package python2-leapp-0.16.0-1.el7_9.noarch
(try to add '--allowerasing' to command line to replace conflicting packages or '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)
```

### Symptom 2b

```output
Error: 
 Problem 1: package systemd-udev-239-78.el8.x86_64 requires systemd(x86-64) = 239-78.el8, but none of the providers can be installed
  - cannot install the best update candidate for package systemd-udev-239-74.el8_8.5.x86_64
  - package systemd-239-78.el8.x86_64 is filtered out by exclude filtering
 Problem 2: package systemd-container-239-78.el8.x86_64 requires systemd(x86-64) = 239-78.el8, but none of the providers can be installed
  - cannot install the best update candidate for package systemd-container-239-74.el8_8.5.x86_64
  - package systemd-239-78.el8.x86_64 is filtered out by exclude filtering
 Problem 3: package systemd-pam-239-78.el8.x86_64 requires systemd = 239-78.el8, but none of the providers can be installed
  - cannot install the best update candidate for package systemd-pam-239-74.el8_8.5.x86_64
  - package systemd-239-78.el8.i686 is filtered out by exclude filtering
  - package systemd-239-78.el8.x86_64 is filtered out by exclude filtering
 Problem 4: systemd-libs-239-74.el8_8.5.i686 has inferior architecture
  - package systemd-239-74.el8_8.5.x86_64 requires systemd-libs = 239-74.el8_8.5, but none of the providers can be installed
  - cannot install both systemd-libs-239-78.el8.x86_64 and systemd-libs-239-74.el8_8.5.x86_64
  - cannot install the best update candidate for package systemd-libs-239-74.el8_8.5.x86_64
  - problem with installed package systemd-239-74.el8_8.5.x86_64
(try to add '--allowerasing' to command line to replace conflicting packages or '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)
```

### Solution 2

When you encounter a dependency issue, start by identifying the specific combination of package and version that's missing or incompatible. The `yum` error message typically indicates which package-version combination is required but isn't available.

#### Solution for symptom 2a: Delete the older package

For Symptom 2a, `yum` rejects a transaction and returns an error message. The error is caused by nn incompatibility between the `python2-leapp` package from an older release and the latest release.

To fix this error, you must remove the older package that causes the conflict (in this case, *python2-leapp-0.16.0-1.el7_9.noarch*) by running the following `yum remove` command:

```bash
sudo yum remove python2-leapp-0.16.0-1.el7_9.noarch
```

Then, you can continue the update or installation of the required package.

#### Solution for symptom 2b: Remove the package exclusion from the configuration file

For symptom 2b, `yum` rejects a transaction and returns an error message. An exclusion filter causes the error.

To fix this error so that you can resume updating or installing the required package, make sure that the `systemd` package isn't excluded in either the */etc/yum.conf* or */etc/dnf.conf* configuration file. To check whether the `systemd` package exclusion is occurring, run a command such as the following `cat`/`grep` combination:

```bash
sudo cat /etc/yum.conf | grep -i exclude
```

If the `systemd` package is excluded, the following output appears:

```output
exclude=systemd
```

To end this package exclusion, use a text editor (such as `vi`, `vim`, or `nano`) to remove or comment out the entry for the "exclude" line in the */etc/yum.conf* or */etc/dnf.conf* file.

## Scenario 3: Wrong version of Python

The `yum`, `dnf`, and `rpm` tools are written in Python and depend on the Python interpreter to operate correctly. Specifically, they rely on certain features and libraries that the Python interpreter provides to run their code and interact with the system. Changing the default version of Python that's installed on the system can cause issues within `yum` or `dnf` because of a dependency on specific Python versions and configurations.

For example, you might experience one of the following errors if you don't have the correct version of Python installed:

- "Invalid syntax"

  ```output
  yum list all
    File "/usr/bin/yum", line 30
      except KeyboardInterrupt, e:
                              ^
  SyntaxError: invalid syntax
  ```

- "No module named yum"

  ```output
  yum repolist
  There was a problem importing one of the Python modules
  required to run yum. The error leading to this problem was:
  
     No module named yum
  ```

- "Bad interpreter: No such file or directory"

  ```output
  bash: /usr/bin/yum: /usr/bin/pythonX.X: bad interpreter: No such file or directory
  ```

### Solution 3

By consulting the official documentation for your Linux distribution, you can confidently verify the default Python version and compare it against the version that's installed on your system. This process helps to ensure consistency and compatibility between software dependencies and system configurations.

After you identify the default version of Python for your Linux distribution, you can determine the currently installed version by running one of the following commands:

```bash
sudo ls -al `which python`
```

```bash
sudo ls -lrth /usr/bin/python*
```

```bash
sudo rpm -V python
```

If you verify that an unsupported version of Python is in use, you have several options to fix this issue.

### Solution 3a: Fix the symlink

Remove the symlink to the unsupported version of Python and create a symlink to the supported version of Python by running the following commands:

```bash
sudo cd /usr/bin
sudo unlink python
sudo ln -s python2.7 python  # Modify if necessary.
```

### Solution 3b: Reinstall Python by using RPM

Reinstall the Python package by running the following `rpm` command:

```bash
sudo rpm -ivh python-<release>.<arch>.rpm --replacepkgs --replacefiles
```

### Solution 3c: Reinstall Python from a rescue VM

Reinstall the Python package from a rescue VM. For instructions, see [Missing important system core libraries and packages](./kernel-related-boot-issues.md#attempted-tokill-init-missinglibraries).

## Scenario 4: Duplicate packages

If an interruption occurs while `yum` is updating, `yum` might retain the old package versions alongside the new packages that it's installing. Duplicate packages can cause confusion in system operations during subsequent use of the tool and eventually cause "protected multilib" errors or misleading dependency issues.

The following scenarios are typical:

- Running `yum update` over Secure Shell (SSH) and experiencing connectivity disruptions during the update process

- Sending a `SIGINT` and a `kill -2` signal to the `yum` process, or selecting <kbd>Ctrl</kbd>+<kbd>C</kbd> to terminate the `yum` process while it's actively running

- Experiencing a system restart midway through the update process

### Solution 4

There are two possible solutions: Try to complete the transaction, or manually remove the duplicate packages. The steps to complete these approaches differ depending on the distribution and version of your Linux installation.

#### Solution 4a: Try to complete the transaction
 
##### [RHEL/Centos/Oracle Linux 7._x_](#tab/rhel7-a)

1. Try to complete the transaction by running the following [yum-complete-transaction](https://linux.die.net/man/8/yum-complete-transaction) command:

   ```bash
   sudo yum-complete-transaction
   ```

   If the operation is successful without leaving any more duplicates, go to step 2.

2. If duplicates are present, resolve this transaction by specifying the `--cleanup-only` parameter in the `yum-complete-transaction` command:

   ```bash
   sudo yum-complete-transaction --cleanup-only
   ```

##### [RHEL/Centos/Oracle Linux 8._x_ and 9._x_](#tab/rhel89)

1. Try to complete the transaction by running the following [yum history](http://yum.baseurl.org/wiki/YumHistory.html) command:

   ```bash
   sudo yum history redo last
   ```

2. Remove older versions of duplicated packages by running the following `yum remove` command. To maintain the integrity of the system, this command reinstalls the newest package:

   ```bash
   sudo yum remove --duplicates
   ```

---

#### Solution 4b: Manually remove duplicates

##### [RHEL/Centos/Oracle Linux 7._x_](#tab/rhel7-b)

1. Remove the duplicate packages manually by running the following commands. The `yum check` command might require a lot of time, but obtaining its output is crucial to proceed with these steps:

   ```bash
   sudo tar -cjf /tmp/rpm_dbbkp.tar.bz2 /var/lib/{rpm,yum}
   sudo yum check &> /tmp/yumcheck
   grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep -v "\:" > /tmp/duplicaterpms
   grep "duplicate" /tmp/yumcheck | awk '{ print $NF }' | egrep ":" | awk -F':' '{ print $NF }' >> /tmp/duplicaterpms
   for i in $(cat /tmp/duplicaterpms); do sudo rpm -e --justdb --nodeps $i; done
   sudo yum update
   ```

2. After the duplicates are removed, if a new kernel was included in the failed transaction, reinstall the kernel to make sure that the correct generation of Grand Unified Bootloader (GRUB) entries, the initial RAM disk (initrd), and the initial RAM file system (initramfs) are installed.

   ```bash
   sudo yum remove kernel-<newversion>-<release>.<arch>
   sudo yum install kernel-<newversion>-<release>.<arch>
   ```

##### [RHEL/Centos/Oracle Linux 8._x_ and 9._x_](#tab/rhel89)

1. Back up the */var/lib/dnf* and */etc/dnf\** directories by running the following commands:

   ```bash
   sudo tar cjf /tmp/rpm_dbbkp.tar.bz2 /var/lib/{rpm,dnf} /etc/{dnf*,os-release} /usr/lib/os-release
   sudo dnf repoquery --duplicates --latest-limit=-1 -q &> /tmp/duplicateolder
   for i in `cat /tmp/duplicateolder`; do sudo rpm -ev --justdb --nodeps $i; done
   sudo yum update
   ```

2. After the duplicates are removed, if a new kernel was included in the failed transaction, reinstall the kernel to make sure that the correct generation of Grand Unified Bootloader (GRUB) entries, the initial RAM disk (initrd), and the initial RAM file system (initramfs) are installed.

   ```bash
   sudo dnf remove kernel-core-<newversion>-<release>.<arch> kernel-<newversion>-<release>.<arch>
   sudo dnf install kernel-core-<newversion>-<release>.<arch> kernel-<newversion>-<release>.<arch>
   ```

---

## Scenario 5: Yum doesn't work and shows a '404 Not Found' error

A "404 Not Found" error message in the `yum` output indicates that `yum` couldn't find the package or resource on the server. This issue typically occurs if `yum` tries to download or access a package from a repository, but the package file or metadata that's associated with it is missing or unavailable on the server. This scenario has various causes, including the following:

- The package or resource was removed from the repository.

- The repository URL or configuration is incorrect.

- Network issues prevent `yum` from accessing the repository server.

- There was temporary server downtime or maintenance.

Examples of this error are shown in sample output for various Linux distributions.

##### [RHEL](#tab/rhel)

```output
Red Hat Enterprise Linux 9 for x86_64 - Supplem  46  B/s |  14  B     00:00    
Errors during downloading metadata for repository 'rhel-9-for-x86_64-supplementary-rhui-rpms':
  - Status code: 404 for https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel9/rhui/9.1/x86_64/supplementary/os/repodata/repomd.xml (IP: 52.142.4.99)
Error: Failed to download metadata for repo 'rhel-9-for-x86_64-
```

##### [Oracle Linux](#tab/ol)

```output
Oracle Linux 8 BaseOS Latest (x86_64)           0.0  B/s |   0  B     00:00    
Errors during downloading metadata for repository 'ol8_baseos_latest':
  - Curl error (6): Couldn't resolve host name for https://yumiad.oracle.com/repo/OracleLinux/OL8/baseos/latest/x86_64/repodata/repomd.xml [Could not resolve host: yumiad.oracle.com]
Error: Failed to download metadata for repo 'ol8_baseos_latest': Cannot download repomd.xml: Cannot download repodata/repomd.xml: All mirrors were tried
```

##### [CentOS](#tab/centos)

```bash
http://olcentgbl.trafficmanager.net/centos/7.9/extras/x86_64/repodata/repomd.xml: [Errno 14] HTTP Error 404 - Not Found
Trying other mirror.
http://olcentgbl.trafficmanager.net/centos/7.9/updates/x86_64/repodata/repomd.xml: [Errno 14] HTTP Error 404 - Not Found
Trying other mirror.
http://olcentgbl.trafficmanager.net/openlogic/7.9/openlogic/x86_64/repodata/repomd.xml: [Errno 14] HTTP Error 404 - Not Found
Trying other mirror.
repolist: 0
```

---

#### Solution 5

The following possible solutions apply to various Linux distributions.

##### [RHEL](#tab/rhel)

Make sure that you follow the correct process when you switch between Extended Update Support (EUS) lifecycle repositories and non-EUS repositories, or from non-EUS to EUS. For more information, see [Image update behavior](/azure/virtual-machines/workloads/redhat/redhat-rhui?tabs=rhel7#image-update-behavior).

If the error typically occurs because an incorrect value is used for */etc/yum/vars/releasever* and */etc/dnf/vars/releasever*, or because the value should be absent (for non-EUS repositories), follow these steps:

1. Check whether your system uses EUS or non-EUS repositories. To do this, run the following `rpm`/`grep` command combination:

   ```bash
   sudo rpm -qa | grep -i rhui
   ```

   The file name format that the command produces depends on the repository type, as shown in the following table.

   | Repository type | File name format                                            |
   |-----------------|-------------------------------------------------------------|
   | EUS             | ***rhui-azure-rhelX-eus**-\<new-version>-\<release>.noarch* |
   | non-EUS         | ***rhui-azure-rhelX**-\<new-version>-\<release>.noarch*     |

2. Determine the current value for the release version by running the following `cat` command.

   | RHEL version | Command                             |
   |--------------|-------------------------------------|
   | RHEL 7       | `sudo cat /etc/yum/vars/releasever` |
   | RHEL 8 and 9 | `sudo cat /etc/dnf/vars/releasever` |

3. Modify and use the correct value for the release version:

   - If your system is using EUS repositories, make sure that the appropriate version lock is applied. In the following example, the version lock is added for RHEL 9.2 because `RHUI EUS` repositories are used:

     ```bash
     sudo sh -c 'echo 9.2 > /etc/dnf/vars/releasever'
     ```

     > [!NOTE]
     > Support for RHEL7 EUS ended on August 30, 2021. We recommend that you no longer use EUS repositories in RHEL7.
     >
     > RHEL 8._x_ versions for EUS are available. These versions include RHEL 8.8, 8.6, 8.4, 8.2, and 8.1.
     >
     > RHEL 9._x_ versions for EUS are available. Currently, these versions include RHEL 9.2 and 9.0.
     >
     > For more information about version availability, see [Red Hat Enterprise Linux Life Cycle](https://access.redhat.com/support/policy/updates/errata).

   - If your system is using non-EUS repositories, make sure that you remove the version lock for the */etc/yum/vars/releasever* or */etc/dnf/vars/releasever* file by running the following command.

     | RHEL version | Command                                   |
     |--------------|-------------------------------------------|
     | RHEL 7       | `sudo echo "" > /etc/yum/vars/releasever` |
     | RHEL 8 and 9 | `sudo echo "" > /etc/dnf/vars/releasever` |

##### [Oracle Linux](#tab/ol)

If you're using Oracle Linux (OL) pay-as-you-go (`PAYG`) images, the images are preconfigured to access the Oracle-managed [Public yum](https://public-yum.oracle.com).

Oracle Linux in Azure doesn't require the *ociregion* file to be used because Oracle Linux is preconfigured to use public `yum` repositories.

Make sure that the *ociregion* file doesn't have any content. To do this, follow these steps:

1. Verify the current content by running the `cat` command:

   ```bash
   sudo cat /etc/yum/vars/ociregion
   ```

2. Clear the content in the *ociregion* file:

   ```bash
   sudo echo "" > /etc/yum/vars/ociregion
   ```

##### [CentOS](#tab/centos)

CentOS images are provided by third-party vendor OpenLogic. For more information, see [Openlogic-Azure-Images](https://www.openlogic.com/solutions/enterprise-linux-support/azure-images).

Make sure that the */etc/yum/vars/releasever* file doesn't exist on your CentOS VM in Azure. To do this, follow these steps:

1. Check whether the *releasever* file exists. To do this, run the `cat` command:

   ```bash
   sudo cat /etc/yum/vars/releasever
   ```

2. Remove the *releasever* file by running the `rm` command:

   ```bash
   sudo rm -f /etc/yum/vars/releasever 
   ```

---

## Scenario 6: RPM database issue

The following errors appear if you run the `rpm`, `up2date`, `yum`, `dnf`, or `tdnf` command:

```output
error: rpmdb: BDB0113 Thread/process 24669/140693557245760 failed: BDB1507 Thread died in Berkeley DB library
error: db5 error(-30973) from dbenv->failchk: BDB0087 DB_RUNRECOVERY: Fatal error, run database recovery
error: cannot open Packages index using db5 - (-30973)
error: cannot open Packages database in /var/lib/rpm
CRITICAL:yum.main:
```

These errors might occur for any of the following reasons:

- Broken RPM databases
- Another application using the database
- Insufficient space in the */var/lib/rpm* directory

### Solution 6

Rebuild the RPM database by following these steps:

> [!IMPORTANT]
> Before you do these steps, make sure that enough free disk space is available.

1. Create a backup of the */var/lib/rpm* directory by running the `tar` command:

   ```bash
   sudo tar zcvf /var/lib/rpm-backup.tar.gz /var/lib/rpm
   ```

2. To avoid stale locks, remove the *__db\** files and verify the integrity of the *Packages* file:

   ```bash
   sudo cd /var/lib/rpm
   sudo rm -f __db.*
   sudo /usr/lib/rpm/rpmdb_verify Packages
   ```

3. Rebuild the RPM database by running the `rpm` command:

   ```bash
   sudo rpm -vv --rebuilddb
   ```

## Scenario 7: Yum command fails and returns '[Errno 14] HTTPS Error 403 --Forbidden'

The following errors appear if you run the `yum` command on a Red Hat 7._x_ VM that's connected to RHUI.

```output
https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/rh-common/os/repodata/repomd.xml: [Errno 14] HTTPS Error 403 - Forbidden
```

### Solution 7

1. Check whether a third-party curl package is installed on your VM: 

   ```bash
   sudo rpm -qa | grep -i curl
   ```
  
   ```bash
   rpm -q --queryformat '%{VENDOR}\n' curl libcurl
   ```
  
    ```output
    curl-7.73.0-2.0.cf.rhel7.x86_64 
    libcurl-7.73.0-2.0.cf.rhel7.x86_64
    libcurl-devel-7.73.0-2.0.cf.rhel7.x86_64 
    ```
  
    ```output
    city-fan.org repo http://www.city-fan.org/ftp/contrib/
    ```

    If any third-party package is installed, go to step 2.

    >[!IMPORTANT]
    >The curl packages from third-party sources are provided together with their own binaries and certificates that are not recognized by Red Hat. This incompatibility causes yum to experience issues.

2. Use either of the following methods to dowload the latest version of the `curl`, `libcurl`, and `libcurl-devel` packages that are provided for RHEL 7.9:

   - Download the packages manually by logging on to [Red Hat Download](https://access.redhat.com/downloads/), and then upload the rpms files to the affected VM.

   - Log on to a working RHEL 7.9 VM `(PAYGO)`, download the required packages by using the `yumdownloader` command, and then copy the rpms files to the affected VM:

      ```bash
      sudo yumdownloader curl.x86_64 libcurl.x86_64 libcurl-devel.x86_64
      ```
 
3. Downgrade the curl packages by using the rpms files from step 2:

   ```bash
   sudo cd /path/location/of/rpms/downloaded
   sudo yum downgrade curl-X.XX.0-XX.el7_9.X.x86_64.rpm libcurl-X.XX.X-XX.el7_9.X.x86_64.rpm libcurl-devel-X.XX.X-XX.el7_9.X.x86_64.rpm --disablerepo=*
   ```

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
