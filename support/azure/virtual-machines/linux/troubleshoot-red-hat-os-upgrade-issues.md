---
title: Troubleshoot common issues involving the leapp upgrade process
description: Learn how to resolve common troubleshooting issues that involve the leapp upgrade process on Red Hat operating systems.
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas
ms.service: azure-virtual-machines
ms.collection: linux
ms.topic: troubleshooting-general
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.date: 02/26/2025
---
# Troubleshooting Red Hat OS upgrade issues

**Applies to:** :heavy_check_mark: Linux VMs

Doing a major upgrade on Red Hat Enterprise Linux (RHEL) involves transitioning from one major version to another major version, such as from RHEL 7 to RHEL 8 or from RHEL 8 to RHEL 9. Major upgrades bring significant changes, including new features, enhancements, and improvements in security and performance. The process can be complex, but Red Hat provides tools and guidance to simplify and streamline the upgrade process. 

One example is the Leapp tool. The Leapp tool is designed to automate the upgrade process of RHEL systems to the next major version. It performs checks, provides recommendations, and helps to resolve any issues that occur during the upgrade. This article discusses how to troubleshoot common issues that occur when you use the Leapp tool during a major upgrade of a Red Hat operating system.

> [!CAUTION]
>On June 30, 2024, Red Hat Enterprise Linux 7 reached the end of maintenance support 2 phase. The maintenance phase is followed by the Extended Life Phase. As Red Hat Enterprise Linux 7 transitions out of the Full and Maintenance phases, you should upgrade to Red Hat Enterprise Linux 8 or 9. If you must stay on Red Hat Enterprise Linux 7, we recommend that you add the [Red Hat Enterprise Linux Extended Life Cycle Support (ELS) Add-On](/azure/virtual-machines/workloads/redhat/redhat-extended-lifecycle-support).

## Recommendations before you upgrade

Before you begin the Leapp preupgrade and upgrade process, make sure that you take the following actions:

- Make a backup of the virtual machine (VM) or a snapshot of the OS disk.

- Clear enough space in `/var/lib/leapp` to accommodate the upgrade. A best practice is to have at least 2-5 GB of free space available.

- Set up access to the serial console.

After you complete these tasks, you can start the Leapp preupgrade and upgrade processes through the serial console.

## Inhibitor problems and errors

*Inhibitor problems* are specific issues that are identified during the preupgrade assessment that prevent the upgrade from proceeding. These issues are critical and must be resolved before you can move on to the upgrade. You have to eliminate inhibitor issues to maintain the system's stability and functionality during and after the upgrade.

*Errors* refers to issues that can occur during the upgrade process that potentially cause interruptions or failures. These errors can occur at different stages, both during the preupgrade checks and during the actual upgrade.

### Common types of inhibitors

| Inhibitor type        | Description                                                                                                                  |
|-----------------------|------------------------------------------------------------------------------------------------------------------------------|
| Unsupported packages  | Packages installed on the current system that are unavailable or unsupported in the target version                           |
| Incompatible hardware | Hardware components that are unsupported in the target version                                                               |
| Configuration issues  | System configurations that are incompatible with the new version and require adjustments                                     |
| Third-party software  | Non-Red Hat software that might interfere with the upgrade process                                                           |
| File system layout    | Issues that involve the OS file system layout, such as partitioning schemes that are unsupported in the target version |
| Networking changes    | Network configurations that have to be updated to align with the new version's networking stack                              |
| Custom scripts        | Custom scripts or cron jobs that might be incompatible with the new version                                                  |

### Common types of errors

| Error type            | Description                                                                        |
|-----------------------|------------------------------------------------------------------------------------|
| Installation failures | Errors that occur while you install packages during the upgrade                    |
| Service failures      | Services that don't start or stop correctly during the upgrade process           |
| File system issues    | Problems that involve disk space, file corruption, or mount points                 |
| Network issues        | Network connectivity problems that affect the download or installation of packages |

### Find inhibitors or errors in the Leapp report

The Leapp report is located at `/var/log/leapp/leapp-report.txt`. Open the report and look for sections that are marked as inhibitors. These sections list issues that must be resolved.

For each inhibitor, the report typically provides detailed remediation steps. These steps can include commands to run, packages to install, or configuration changes to make.

The following list contains common occurrences of output that describes an inhibitor and its remediation:

- Inhibitor output 1

  ```output
  Inhibitor: Missing package 'pkg_name' required for upgrade.
  Remediation: Install the missing package by running:
  [command] sudo yum install pkg_name
  ```

- Inhibitor output 2

  ```output
  Risk Factor: high (inhibitor)
  Title: Possible problems with remote login using root account
  Summary: OpenSSH configuration file does not explicitly state the option PermitRootLogin in sshd_config file, which will default in RHEL8 to "prohibit-password".
  Remediation: [hint] If you depend on remote root logins using passwords, consider setting up a different user for remote administration or adding "PermitRootLogin yes" to sshd_config. If this change is ok for you, add explicit "PermitRootLogin prohibit-password" to your sshd_config to ignore this inhibitor
  ```

- Inhibitor output 3

  ```output
  Risk Factor: high (inhibitor)
  Title: Missing required answers in the answer file
  Summary: One or more sections in answerfile are missing user choices: remove_pam_pkcs11_module_check.confirm
  For more information consult https://red.ht/leapp-dialogs.
  Remediation: [hint] Please register user choices with leapp answer cli command or by manually editing the answerfile.
  [command] leapp answer --section remove_pam_pkcs11_module_check.confirm=True
  ```

- Inhibitor output 4

  ```output
  Risk Factor: high (inhibitor)
  Title: Use of CIFS detected. Upgrade can't proceed
  Summary: CIFS is currently not supported by the inplace upgrade.
  Remediation: [hint] Comment out CIFS entries to proceed with the upgrade.
  ```

- Inhibitor output 5
  
  ```output
  Risk Factor: high (inhibitor)
  Title: Detected loaded kernel drivers which have been removed in RHEL 8. Upgrade cannot proceed.
  Summary: Support for the following RHEL 7 device drivers has been removed in RHEL 8: 
   pata_acpi
   floppy
  Remediation: blocklist modules that are unsupported in RHEL 8 (floppy and pata_acpi) or unload the modules by running [command] sudo rmmod floppy pata_acpi
  ```

- Inhibitor output 6
  
  ```output
  Risk Factor: high (inhibitor)
  Title: Btrfs has been removed from RHEL8
  Summary: The Btrfs file system was introduced as Technology Preview with the initial release of Red Hat Enterprise Linux 6 and Red Hat Enterprise Linux 7. As of versions 6.6 and 7.4 this technology has been deprecated and removed in RHEL8.
  Remediation:
  If filesystem is currently  mounted with BTRFS proceed with fresh reinstallation as it is no longer supported on Red Hat Enterprise Linux 8
  If any btrfs is not currently in use by any filesystem, remove the btrfs module using the [command] modprobe -rv btrfs
  ```

- Inhibitor output 7

  ```output
  Inhibitor: Newest installed kernel not in use
  Remediation:
  If the system is having the latest RHEL7 kernel installed, take a reboot and boot the system from the latest kernel.
  If the system is NOT having the latest RHEL7 kernel installed, install it using [command] yum install <latest kernel package>
  ```

- Inhibitor output 8

  ```output
  Risk Factor: high (inhibitor)
  Title: Multiple devel kernels installed
  Summary: DNF cannot produce a valid upgrade transaction when multiple kernel-devel packages are installed.
  Remediation: [hint] Remove all but one kernel-devel packages before running Leapp again.
  [command] yum -y remove kernel-devel-X.XX.X-XXX.XXX kernel-devel-X.XX.X-XXXX.XXX.X.XXX
  ```

- Inhibitor output 9

  ```output
  Risk Factor: medium (inhibitor)
  Title: A YUM/DNF repository defined multiple times
  Summary: The following repositories are defined multiple times inside the "upgrade" container:
      - repo-id
  Remediation: [hint] Remove the duplicate repository definitions or change repoids of conflicting repositories on the system to prevent the conflict
  ```

- Inhibitor output 10

  ```output
  Risk Factor: high (inhibitor)
  Title: Firewalld Configuration AllowZoneDrifting Is Unsupported
  Summary: Firewalld has enabled configuration option "AllowZoneDrifiting" which has been removed in RHEL-9. New behavior is as if "AllowZoneDrifiting" was set to "no".
  Related links:
      - Changes in firewalld related to Zone Drifting: https://access.redhat.com/articles/4855631
  Remediation: [hint] Set AllowZoneDrifting=no in /etc/firewalld/firewalld.conf
  [command] sed -i s/^AllowZoneDrifting=.*/AllowZoneDrifting=no/ /etc/firewalld/firewalld.conf
  ```

> [!NOTE]
> Examine the whole preupgrade report carefully, even if it doesn't list any inhibitors. The report provides recommended actions to take before you upgrade so that the system operates correctly afterward.

After you fix all the inhibitors, run the preupgrade check again to make sure that all issues are resolved.

## Leapp Preupgrade common issues

### Preupgrade symptom 1: Corrupted or missing urllib3 library

 A corrupted or missing *urllib3* library in Python generates the following error message:

```output
Traceback (most recent call last):
  File "/bin/leapp", line 9, in <module>
    load_entry_point('leapp==0.16.0', 'console_scripts', 'leapp')()
  File "/usr/lib/python2.7/site-packages/leapp/cli/__init__.py", line 43, in main
    _load_commands(cli.command)
  File "/usr/lib/python2.7/site-packages/leapp/cli/__init__.py", line 27, in _load_commands
    package = pkgutil.get_loader(package_name).load_module(package_name)
  File "/usr/lib64/python2.7/pkgutil.py", line 246, in load_module
    mod = imp.load_module(fullname, self.file, self.filename, self.etc)
  File "/usr/lib/python2.7/site-packages/leapp/cli/commands/list_runs/__init__.py", line 6, in <module>
    from leapp.cli.commands.upgrade.util import fetch_all_upgrade_contexts
  File "/usr/lib/python2.7/site-packages/leapp/cli/commands/upgrade/__init__.py", line 9, in <module>
    from leapp.logger import configure_logger
  File "/usr/lib/python2.7/site-packages/leapp/logger/__init__.py", line 10, in <module>
    from leapp.utils.actorapi import get_actor_api, RequestException
  File "/usr/lib/python2.7/site-packages/leapp/utils/actorapi.py", line 4, in <module>
    import requests
  File "/usr/lib/python2.7/site-packages/requests/__init__.py", line 58, in <module>
    from . import utils
  File "/usr/lib/python2.7/site-packages/requests/utils.py", line 32, in <module>
    from .exceptions import InvalidURL
  File "/usr/lib/python2.7/site-packages/requests/exceptions.py", line 10, in <module>
    from urllib3.exceptions import HTTPError as BaseHTTPError
ImportError: No module named urllib3.exceptions
```

#### Preupgrade solution 1: Reinstall the python-urllib3 package

Reinstall the *python-urllib3* package by running the following commands:

```bash
sudo mv /usr/lib/python2.7/site-packages/urllib3 /tmp/ 
sudo yum reinstall python-urllib3
```

### Preupgrade symptom 2: Connection timed out after 30,001 milliseconds
 
A communication block to Red Hat Update Infrastructure (RHUI) IP addresses generates the following error message:

```output
Risk Factor: high (error)
Title: Actor rpm_scanner unexpectedly terminated with exit code: 1
Summary: Traceback (most recent call last):
  File "/usr/lib/python2.7/site-packages/leapp/repository/actor_definition.py", line 74, in _do_run
    actor_instance.run(*args, **kwargs)
  File "/usr/lib/python2.7/site-packages/leapp/actors/__init__.py", line 289, in run
    self.process(*args)
  File "/usr/share/leapp-repository/repositories/system_upgrade/common/actors/rpmscanner/actor.py", line 20, in process
    rpmscanner.process()
  File "/usr/share/leapp-repository/repositories/system_upgrade/common/actors/rpmscanner/libraries/rpmscanner.py", line 110, in process
    pkg_repos = get_package_repository_data()
  File "/usr/share/leapp-repository/repositories/system_upgrade/common/actors/rpmscanner/libraries/rpmscanner.py", line 77, in get_package_repository_data
    return _get_package_repository_data_yum()
  File "/usr/share/leapp-repository/repositories/system_upgrade/common/actors/rpmscanner/libraries/rpmscanner.py", line 31, in _get_package_repository_data_yum
    for pkg in yum_base.doPackageLists().installed:
  File "/usr/lib/python2.7/site-packages/yum/__init__.py", line 2981, in doPackageLists
    avail = self.pkgSack.returnNewestByNameArch(patterns=patterns,
  File "/usr/lib/python2.7/site-packages/yum/__init__.py", line 1075, in <lambda>
    pkgSack = property(fget=lambda self: self._getSacks(),
  File "/usr/lib/python2.7/site-packages/yum/__init__.py", line 778, in _getSacks
    self.repos.populateSack(which=repos)
  File "/usr/lib/python2.7/site-packages/yum/repos.py", line 347, in populateSack
    self.doSetup()
  File "/usr/lib/python2.7/site-packages/yum/repos.py", line 157, in doSetup
    self.retrieveAllMD()
  File "/usr/lib/python2.7/site-packages/yum/repos.py", line 88, in retrieveAllMD
    dl = repo._async and repo._commonLoadRepoXML(repo)
  File "/usr/lib/python2.7/site-packages/yum/yumRepo.py", line 1482, in _commonLoadRepoXML
    result = self._getFileRepoXML(local, text)
  File "/usr/lib/python2.7/site-packages/yum/yumRepo.py", line 1259, in _getFileRepoXML
    size=102400) # setting max size as 100K
  File "/usr/lib/python2.7/site-packages/yum/yumRepo.py", line 1042, in _getFile
    raise e
NoMoreMirrorsRepoError: failure: repodata/repomd.xml from rhel-7-server-ansible-2-rhui-rpms: [Errno 256] No more mirrors to try.
https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: [Errno 12] Timeout on https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: (28, 'Connection timed out after 30001 milliseconds')
https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: [Errno 12] Timeout on https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: (28, 'Connection timed out after 30001 milliseconds')
https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: [Errno 12] Timeout on https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: (28, 'Connection timed out after 30001 milliseconds')
https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: [Errno 12] Timeout on https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: (28, 'Connection timed out after 30001 milliseconds')
https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: [Errno 12] Timeout on https://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel/rhui/server/7/7Server/x86_64/ansible/2/os/repodata/repomd.xml: (28, 'Connection timed out after 30001 milliseconds')
```

#### Preupgrade solution 2: Allow RHUI connectivity

Allow connectivity to RHUI. For more information, see [Linux RHUI connectivity issues](linux-rhui-connectivity-issues.md).

### Preupgrade symptom 3: A subscription-manager command didn't run

If you run the Leapp upgrade that has Red Hat Subscription Manager on a pay-as-you-go (PayGo) image, you might receive the following error message:

```output
[ERROR] Actor: scan_subscription_manager_info
Message: 
Summary:
    Details: Command ['subscription-manager', 'release'] failed with exit code 1.
    Stderr: This system is not yet registered. Try 'subscription-manager register --help' for more information.
    Hint: Please ensure you have a valid RHEL subscription and your network is up. If you are using proxy for Red Hat subscription-manager, please make sure it is specified inside the /etc/rhsm/rhsm.conf file. Or use the --no-rhsm option when running leapp, if you do not want to use subscription-manager for the in-place upgrade and you want to deliver all target repositories by yourself or using RHUI on public cloud.
```

#### preupgrade solution 3: Bypass the subscription-manager tool

 When you use a PayGo image on Azure, you can't run the `subscription-manager` tool because the system is designed to use RHUI instead. You have to specify the `--no-rhsm` flag to bypass `subscription-manager` during the upgrade.

### preupgrade symptom 4: The Leapp preupgrade doesn't install RHEL 8 userspace packages ("execv() failed: No such file or directory")

If you run the Leapp preupgrade, you might receive the following "Unable to install RHEL 8 userspace packages" error message:

```output
Risk Factor: high
Title: Unable to install RHEL 8 userspace packages.
Summary: {"details": "DNF failed to install userspace packages, likely due to the proxy config
uration detected in a repository configuration file.", "stderr": "Failed to create directory /
var/lib/leapp/scratch/mounts/root_/system_overlay//sys/fs/selinux: Read-only file system
Failed to create directory /var/lib/leapp/scratch/mounts/root_/system_overlay//sys/fs/selinux:
 Read-only file system
Host and machine ids are equal (35e06890bn8g56f798g8904356fsd5f8): refusing to link journals
execv() failed: No such file or directory
```

You might also receive the following "Cannot obtain data about the DNF configuration" error message:

```output
Risk Factor: high
Title: Cannot obtain data about the DNF configuration
Summary: {"stderr": "Failed to retrieve machine ID: No such file or directory\n", "stdout": ""}
Key: b41a40f4129e340f05c6b14d1a850b626c4185d1
```

#### preupgrade solution 4: Install the dnf package

Make sure that the *dnf* package is installed and that no issues or corrupted files are associated with that package:

```bash
sudo package-cleanup --problems
```

```output 
Package leapp-upgrade-el7toel8-deps-0.18.0-1.el7_9.noarch has missing requires of dnf >= ('0', '4', None)
```

```bash
sudo yum reinstall leapp\*
```

```bash
sudo rpm -Va dnf\* leapp\*   
```

```output
.M.......  g /var/log/dnf.librepo.log
.M.......  g /var/log/dnf.log
.M.......  g /var/log/dnf.rpm.log
.M.......  g /var/log/hawkey.log
```

### preupgrade symptom 5: /var/lib/leapp/el8userspace', '/bin/bash', '-c', 'su - -c update-ca-trust'] failed with exit code 1

If you run Leapp preupgrade, you might receive the following "Actor target_userspace_creator unexpectedly terminated" error message:

```output
Factor: high error
Title: Actor target_userspace_creator unexpectedly terminated with exit code: 1
Summary: Traceback most recent call last:  File '/usr/lib/python2.7/site-packages/leapp/repository/actor_definition.py',
line 74, in _do_run    actor_instance.run*args, **kwargs  File '/usr/lib/python2.7/site-packages/leapp/actors/__init__.py', line 289, in run
self.process*args  File '/usr/share/leapp-repository/repositories/system_upgrade/common/actors/targetuserspacecreator/actor.py', line 58, in process    userspacegen.perform  File '/usr/lib/python2.7/site-packages/leapp/utils/deprecation.py', line 42, in process_wrapper    return target_item*args, **kwargs  File '/usr/share/leapp-repository/repositories/system_upgrade/common/actors/targetuserspacecreator/libraries/userspacegen.py',
line 1246, in perform    _create_target_userspacecontext, indata, indata.packages, indata.files, target_repoids  File '/usr/share/leapp-repository/repositories/system_upgrade/common/actors/targetuserspacecreator/libraries/userspacegen.py',
line 1108, in _create_target_userspace    _prep_repository_accesscontext, target_path  File '/usr/share/leapp-repository/repositories/system_upgrade/common/actors/targetuserspacecreator/libraries/userspacegen.py',
line 629, in _prep_repository_access    run['chroot', target_userspace, '/bin/bash', '-c', 'su - -c update-ca-trust']  File '/usr/lib/python2.7/site-packages/leapp/libraries/stdlib/__init__.py', line 192, in run    result=resultCalledProcessError: Command ['chroot', '/var/lib/leapp/el8userspace', '/bin/bash', '-c', 'su - -c update-ca-trust'] failed with exit code 1
```

#### preupgrade solution 5: Reinstall CA certificates and update the CA trust

An issue occurred within the existing *ca-certificates* package that caused the `update-ca-trust` command to fail. To fix this issue, reinstall the *ca-certificates* package and run the `update-ca-trust` command:

```bash
sudo yum reinstall ca-certificates
sudo update-ca-trust
```

### preupgrade symptom 6: FileNotFoundError: [Errno 2] No such file or directory: '/etc/leapp/repos.d/system_upgrade/common/files/rhui/azure-XX/content-XX.crt'

If you try to run `leapp preupgrade` on `RHEL` 8 for `SAP-HANA` or `SAPApps` that have the `leapp` tool version `lapp-rhui-azure-sap-1.0.0-14.el8.noarch`, or on base Red Hat images that have version `leapp-rhui-azure-1.0.0-14.el8.noarch`, the following error message is generated:

```output
====> * target_userspace_creator
        Initializes a directory to be populated as a minimal environment to run binaries from the target system.
Process Process-408:
Traceback (most recent call last):
  File "/usr/lib64/python3.6/multiprocessing/process.py", line 258, in _bootstrap
    self.run()
  File "/usr/lib64/python3.6/multiprocessing/process.py", line 93, in run
    self._target(*self._args, **self._kwargs)
  File "/usr/lib/python3.6/site-packages/leapp/repository/actor_definition.py", line 74, in _do_run
    actor_instance.run(*args, **kwargs)
  File "/usr/lib/python3.6/site-packages/leapp/actors/__init__.py", line 289, in run
    self.process(*args)
  File "/etc/leapp/repos.d/system_upgrade/common/actors/targetuserspacecreator/actor.py", line 58, in process
    userspacegen.perform()
  File "/usr/lib/python3.6/site-packages/leapp/utils/deprecation.py", line 42, in process_wrapper
    return target_item(*args, **kwargs)
  File "/etc/leapp/repos.d/system_upgrade/common/actors/targetuserspacecreator/libraries/userspacegen.py", line 774, in perform
    target_repoids = _gather_target_repositories(context, indata, prod_cert_path)
  File "/etc/leapp/repos.d/system_upgrade/common/actors/targetuserspacecreator/libraries/userspacegen.py", line 714, in _gather_target_repositories
    rhui.copy_rhui_data(context, indata.rhui_info.provider)
  File "/etc/leapp/repos.d/system_upgrade/common/libraries/rhui.py", line 259, in copy_rhui_data
    context.copy_to(os.path.join(data_dir, path_[0]), path_[1])
  File "/etc/leapp/repos.d/system_upgrade/common/libraries/mounting.py", line 232, in copy_to
    shutil.copy2(src, self.full_path(dst))
  File "/usr/lib64/python3.6/shutil.py", line 263, in copy2
    copyfile(src, dst, follow_symlinks=follow_symlinks)
  File "/usr/lib64/python3.6/shutil.py", line 120, in copyfile
    with open(src, 'rb') as fsrc:
FileNotFoundError: [Errno 2] No such file or directory: '/etc/leapp/repos.d/system_upgrade/common/files/rhui/azure-sap-ha/content-sap-ha.crt'
```

SAP-HA images generate:

```output
FileNotFoundError: [Errno 2] No such file or directory:'/etc/leapp/repos.d/system_upgrade/common/files/rhui/azure-sap-ha/content-sap-ha.crt'
```

SAPApps images generate:

```output
FileNotFoundError: [Errno 2] No such file or directory:'/etc/leapp/repos.d/system_upgrade/common/files/rhui/azure-sap-apps/content-sapapps.crt'
```

Base images generate:

```output
FileNotFoundError: [Errno 2] No such file or directory: '/etc/leapp/repos.d/system_upgrade/common/files/rhui/azure/content.crt'
```

#### preupgrade solution 6

The workaround for this issue is to downgrade the version of `leapp-rhui-azure-sap` to `leapp-rhui-azure-sap-1.0.0-10.el8.noarch` for SAP images, and the version of `leapp-rhui-azure` to `leapp-rhui-azure-1.0.0-10.el8.noarch` for Red Hat base images.

SAP images:

```bash
sudo dnf downgrade leapp-rhui-azure-sap 
```

Base images:

```bash
sudo dnf downgrade leapp-rhui-azure
```

After you resolve all the inhibitors, run the preupgrade again, and make sure that all issues are resolved.

## Leapp upgrade common issues

After the preupgrade report shows no errors or inhibitors and everything is marked as resolved, continue to the Leapp upgrade. In this report, the output is typically shown in green or yellow, indicating that it's safe to run the Leapp upgrade.

The following symptoms indicate some common errors that are reported during the Leapp upgrade process.

### Upgrade symptom 1: Not enough space available on /var/lib/leapp/scratch

If you run the Leapp upgrade, you might receive the following "Not enough space available" error message:

```output
2024-06-14 19:31:45.552155 [ERROR] Actor: dnf_dry_run
Message: Not enough space available on /var/lib/leapp/scratch: Needed at least 1224 MiB.
Summary:
    Detail: The file system hosting the /var/lib/leapp/scratch directory does not contain enough free space to proceed all parts of the in-place upgrade. Note the calculated required free space is the minimum derived from upgrades of minimal systems and the actual needed free space could be higher.
            Needed at least: 1224 MiB.
            Suggested free space: 2224 MiB (or more).
```

#### Upgrade solution 1: Extend the file system

Extend the file system on which `/var/lib/leapp` is mounted. Typically, the mounting is on */dev/mapper/rootvg-varlv*.

Typically, the output is shown in green or yellow, indicating that you can safely do the Leapp upgrade.

### Upgrade symptom 2: The openssl-libs-1:1.1.1k-12.el8_9.x86_64 conflicts with file from package openssl11-libs-1:1.1.1k-7.el7.x86_64

A conflict exists between libraries from the following sources:
- The *openssl11-libs* package from the Extra Packages for Enterprise Linux (EPEL) repository
- The *openssl* and *openssl-libs* packages for RHEL 8 that are provided by Red Hat (required for the in-place upgrade)

In this situation, you receive the following error message:

```output
Error: Transaction test error:
              file /usr/lib64/.libcrypto.so.1.1.1k.hmac from install of openssl-libs-1:1.1.1k-12.el8_9.x86_64 conflicts with file from package openssl11-libs-1:1.1.1k-7.el7.x86_64
              file /usr/lib64/.libssl.so.1.1.1k.hmac from install of openssl-libs-1:1.1.1k-12.el8_9.x86_64 conflicts with file from package openssl11-libs-1:1.1.1k-7.el7.x86_64
              file /usr/lib64/engines-1.1/afalg.so from install of openssl-libs-1:1.1.1k-12.el8_9.x86_64 conflicts with file from package openssl11-libs-1:1.1.1k-7.el7.x86_64
              file /usr/lib64/engines-1.1/capi.so from install of openssl-libs-1:1.1.1k-12.el8_9.x86_64 conflicts with file from package openssl11-libs-1:1.1.1k-7.el7.x86_64
              file /usr/lib64/engines-1.1/padlock.so from install of openssl-libs-1:1.1.1k-12.el8_9.x86_64 conflicts with file from package openssl11-libs-1:1.1.1k-7.el7.x86_64
              file /usr/lib64/libcrypto.so.1.1.1k from install of openssl-libs-1:1.1.1k-12.el8_9.x86_64 conflicts with file from package openssl11-libs-1:1.1.1k-7.el7.x86_64
              file /usr/lib64/libssl.so.1.1.1k from install of openssl-libs-1:1.1.1k-12.el8_9.x86_64 conflicts with file from package openssl11-libs-1:1.1.1k-7.el7.x86_64
    Hint: If there was a problem reaching remote content (see stderr output) and proxy is configured in the YUM/DNF configuration file, the proxy configuration is likely causing this error. Make sure the proxy is properly configured in /etc/dnf/dnf.conf. It's also possible the proxy settings in the DNF configuration file are incompatible with the target system. A compatible configuration can be placed in /etc/leapp/files/dnf.conf which, if present, it will be used during some parts of the upgrade instead of original /etc/dnf/dnf.conf. In such case the configuration will also be applied to the target system. Note that /etc/dnf/dnf.conf needs to be still configured correctly for your current system to pass the early phases of the upgrade process.
```

#### Upgrade solution 2: Remove the openssl11-\* package

Verify that the *openssl11-\** package was installed for a third-party vendor. If that package came from a third-party vendor, remove it, as shown in the following commands.

> [!NOTE]
> This conflict error message might be generated if you use any other third-party package manager. In this example, the conflict was with openssl11.

```bash
sudo yum list installed | grep -i openssl11
sudo yum remove openssl11 openssl11-libs 
```

```output
openssl11.x86_64            1:1.1.1k-7.el7         @epel                        
openssl11-libs.x86_64       1:1.1.1k-7.el7         @epel 
```

```output
===============================================================================
 Package               Arch          Version                 Repository    Size
================================================================================
Removing:
 openssl11             x86_64        1:1.1.1k-7.el7          @epel        1.0 M
 openssl11-libs        x86_64        1:1.1.1k-7.el7          @epel        3.6 M
Removing for dependencies:
 nodejs                x86_64        1:16.20.2-1.el7         @epel        290 k
 nodejs-libs           x86_64        1:16.20.2-1.el7         @epel         50 M
```

> [!WARNING]
> If other packages, such as *nodejs* and *nodejs-libs* from the EPEL repository, are removed because of the dependency issues that are shown in the previous output, back up the related configuration files and reinstall the same packages manually after the in-place upgrade.

### Upgrade symptom 3: Problem with installed package ansible-2.9.27-1.el7ae.noarch and ansible-test-2.9.27-1.el7ae.noarch

If you run the Leapp upgrade, you might receive the following "DNF execution failed with non zero exit code" error message:

```output
Risk Factor: high (error)
Title: DNF execution failed with non zero exit code.
Summary: {"hint": "If there was a problem reaching remote content (see stderr output) and proxy is configured in the YUM/DNF configuration file, the proxy configuration is likely causing this error. Make sure the proxy is properly configured in /etc/dnf/dnf.conf. It's also possible the proxy settings in the DNF configuration file are incompatible with the target system. A compatible configuration can be placed in /etc/leapp/files/dnf.conf which, if present, it will be used during some parts of the upgrade instead of original /etc/dnf/dnf.conf. In such case the configuration will also be applied to the target system. Note that /etc/dnf/dnf.conf needs to be still configured correctly for your current system to pass the early phases of the upgrade process.", "STDERR": "No matches found for the following disable plugin patterns: subscription-manager\nFailed loading plugin \"dnf_rhui_plugin\": No module named 'requests'\nWarning: Package marked by Leapp to upgrade not found in repositories metadata: gpg-pubkey leapp-upgrade-el7toel8 leapp python2-leapp\nTransaction check: \n\n Problem: problem with installed package ansible-2.9.27-1.el7ae.noarch\n  - cannot install the best update candidate for package ansible-2.9.27-1.el7ae.noarch\n  - problem with installed package ansible-test-2.9.27-1.el7ae.noarch\n  - cannot install the best update candidate for package ansible-test-2.9.27-1.el7ae.noarch\n  - package ansible-test-2.9.0-2.el8.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.0-2.el8, but none of the providers can be installed\n  - package ansible-test-2.9.1-1.el8.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.1-1.el8, but none of the providers can be installed\n  - package ansible-test-2.9.2-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.2-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.4-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.4-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.5-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.5-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.6-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.6-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.7-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.7-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.9-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.9-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.10-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.10-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.11-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.11-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.13-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.13-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.14-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.14-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.15-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.15-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.16-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.16-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.17-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.17-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.18-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.18-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.19-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.19-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.20-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.20-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.21-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.21-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.22-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.22-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.23-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.23-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.24-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.24-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.25-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.25-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.9.26-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms requires ansible = 2.9.26-1.el8ae, but none of the providers can be installed\n  - package ansible-test-2.12.2-3.1.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms requires ansible-core = 2.12.2-3.1.el8, but none of the providers can be installed\n  - package ansible-test-2.12.2-4.el8_6.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms requires ansible-core = 2.12.2-4.el8_6, but none of the providers can be installed\n  - package ansible-test-2.13.3-1.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms requires ansible-core = 2.13.3-1.el8, but none of the providers can be installed\n  - package ansible-test-2.13.3-2.el8_7.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms requires ansible-core = 2.13.3-2.el8_7, but none of the providers can be installed\n  - package ansible-test-2.14.2-3.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms requires ansible-core = 2.14.2-3.el8, but none of the providers can be installed\n  - package ansible-test-2.14.2-4.el8_8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms requires ansible-core = 2.14.2-4.el8_8, but none of the providers can be installed\n  - package ansible-test-2.15.3-1.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms requires ansible-core = 2.15.3-1.el8, but none of the providers can be installed\n  - package ansible-test-2.16.3-2.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms requires ansible-core = 2.16.3-2.el8, but none of the providers can be installed\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.0-2.el8.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.1-1.el8.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.2-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.4-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.5-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.6-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.7-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.9-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.10-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.11-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.13-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.14-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.15-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.16-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.17-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.18-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.19-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.20-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.21-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.22-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.23-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.24-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.25-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - cannot install both ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms and ansible-2.9.26-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - package ansible-core-2.12.2-3.1.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms conflicts with ansible < 2.10.0 provided by ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - package ansible-core-2.12.2-4.el8_6.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms conflicts with ansible < 2.10.0 provided by ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - package ansible-core-2.13.3-1.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms conflicts with ansible < 2.10.0 provided by ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - package ansible-core-2.13.3-2.el8_7.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms conflicts with ansible < 2.10.0 provided by ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - package ansible-core-2.14.2-3.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms conflicts with ansible < 2.10.0 provided by ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - package ansible-core-2.14.2-4.el8_8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms conflicts with ansible < 2.10.0 provided by ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - package ansible-core-2.15.3-1.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms conflicts with ansible < 2.10.0 provided by ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - package ansible-core-2.16.3-2.el8.x86_64 from rhel-8-for-x86_64-appstream-rhui-rpms conflicts with ansible < 2.10.0 provided by ansible-2.9.27-1.el8ae.noarch from ansible-2-for-rhel-8-x86_64-rhui-rpms\n  - ansible-test-2.9.27-1.el7ae.noarch from @System  does not belong to a distupgrade repository\n  - ansible-2.9.27-1.el7ae.noarch from @System  does not belong to a distupgrade repository\n", "STDOUT": "Last metadata expiration check: 0:02:18 ago on Fri Jun 14 18:01:34 2024.\n"}
```

#### Upgrade solution 3: Remove Ansible packages

The in-place upgrade is unsupported for systems that have any Ansible products. For more information, see [Upgrading_from_rhel_7_to_rhel_8](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/upgrading_from_rhel_7_to_rhel_8/index). To remove Ansible packages, run the following command:

```bash
sudo yum remove ansible ansible-test
```

### Upgrade symptom 4: ImportError: /lib64/libk5crypto.so.3: undefined symbol

There's a mismatch or missing symbol in the OpenSSL library that *libk5crypto* requires, as shown in the following output:

```output
[ 1895.402427] upgrade[557]: ImportError: /lib64/libk5crypto.so.3: undefined symbol: EVP_KDF_ctrl, version OPENSSL_1_1_1b
```

#### Upgrade solution 4: Remove or rename the file in conflict, and update the dynamic linker

A custom OpenSSL library path in */etc/ld.so.conf.d/openssl-1.1.1d.conf* causes the issue:

```bash
sudo cat /etc/ld.so.conf.d/openssl-1.1.1d.conf
/usr/local/ssl/lib
```

To resolve the conflict, remove or rename this file. Then, update the dynamic linker run-time bindings by running `ldconfig`:

```bash
sudo mv /etc/ld.so.conf.d/openssl-1.1.1d.conf /tmp
sudo ldconfig
```

The `ldconfig` command updates the symlinks and rebuilds the cache to make sure that the newly installed library is correctly linked and available for use by other groups.

This action makes sure that the system uses the correct versions of the OpenSSL and libk5crypto libraries. Additionally, this action should fix the ImportError that's related to the undefined symbol `EVP_KDF_ctrl`.

### Upgrade symptom 5: Leapp upgrade doesn't mount a device during the upgrade

If you run the Leapp upgrade, you might receive the following device mounting error message:

```output
[    4.509104] upgrade[569]: Mounting /usr with -o defaults,ro
[    4.590197] upgrade[596]: Spawning container sysroot on /sysroot.
[    4.608522] upgrade[596]: Press ^] three times within 1s to kill container.
[    4.909441] upgrade[599]: mount: can't find UUID=c044351a-93a0-45f5-afs3-d361181215b8 
[   44.830831] upgrade[638]: ==> Processing phase `InitRamStart`
[   44.843736] upgrade[638]: ====> * remove_upgrade_boot_entry
[   44.863656] upgrade[638]:         Remove boot entry for Leapp provided initramfs.
[   47.734944] upgrade[1155]: Process Process-230:
[   47.745684] upgrade[1155]: Traceback (most recent call last):
[   47.756230] upgrade[1155]:   File "/usr/lib64/python2.7/multiprocessing/process.py", line 258, in _bootstrap
[   47.764584] upgrade[1155]:     self.run()
```

#### Upgrade solution 5: Restore the VM and remove the UUID

1. Restore the virtual machine (VM) from the snapshot or backup.

1. Check whether the UUID from the error message exists on the VM. If the UUID exists, comment it out or remove it from the */etc/fstab* file.

   ```bash
   sudo blkid
   ```

   ```bash
   sudo cat /etc/fstab
   ```

1. Run the Leapp upgrade command again.

### Upgrade symptom 6: Failed to mount n/a on /sys/fs/cgroup on RHEL 7.9

If you run the Leapp upgrade, you might receive the following "Failed to mount" error message:

```output
[ 4.815758]  upgrade[599]: Failed to mount n/a on /sys/fs/cgroup (MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_STRICTATIME "mode=755"): Invalid argument
[ 4.812413]  kernel: cgroup2: Unknown parameter 'mode'
```

The mounting failure occurs because version 2 of the control group (cgroup v2) is unsupported on RHEL 7. For more information, see [\[IPU 7>8\] Leapp fails with cgroup v2 that is unsupported](https://issues.redhat.com/browse/RHEL-24854).

#### Upgrade solution 6: Remove the systemd.unified_cgroup_hierarchy parameter

1. Restore the VM from the snapshot or a backup.

1. Before you run the Leapp upgrade, verify whether the parameter `systemd.unified_cgroup_hierarchy=1` is located in */proc/cmdline* or */etc/default/grub*.

1. If that parameter is in one of those files, remove the parameter from the file, and then run the Leapp upgrade process again.

### Upgrade symptom 7: Leapp upgrade doesn't continue after reboot, and VM boots into RHEL 8.10 instead

If you run the Leapp upgrade from RHEL 8.10 to 9.4 or 9.5, the upgrade process might not continue after the required reboot. Instead, the VM boots back into RHEL 8.10 without loading the special upgrade initramfs.

The following setting in `/etc/default/grub` might cause this issue:

```config
GRUB_DEFAULT=0
```

Since `GRUB_DEFAULT=0` forces the system to always boot the first menu entry in GRUB, it skips the Leapp upgrade entry and continues booting into the existing RHEL 8.10 environment.


#### Upgrade solution 7: Modify GRUB to use the saved entry

1. Change `GRUB_DEFAULT=0` to `GRUB_DEFAULT=saved`:

    > [!NOTE]
    > In this example, `GRUB_DEFAULT` is set to `0`, but in your environment, it might be `1` or another number. Ensure that you replace it accordingly in the `sed` command.


    ```bash
    sudo sed -i 's/^GRUB_DEFAULT=0/GRUB_DEFAULT=saved/' /etc/default/grub
    ```

2. Regenerate the GRUB configuration:

    - **GEN 1:**

        ```bash
        sudo grub2-mkconfig -o /boot/grub2/grub.cfg
        ```

    - **GEN 2:**

        ```bash
        grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
        ```

3. Reboot the VM using the serial console:

    ```bash
    sudo reboot
    ```

    After the reboot, if the fix is applied correctly, the VM will boot into the Leapp upgrade initramfs, and you should see an output similar to the following lines in the serial console:

    ```output
    [  OK  ] Reached target Remote File Systems.
            Starting dracut pre-mount hook...
    [  OK  ] Finished dracut pre-mount hook.
            Starting File System Check on /dev/mapper/rootvg-rootlv...
    [  OK  ] Finished File System Check on /dev/mapper/rootvg-rootlv.
            Mounting /sysroot...
    [  OK  ] Mounted /sysroot.
    [  OK  ] Reached target Initrd Root File System.
    [  OK  ] Reached target System Upgrade.
            Starting dracut pre-pivot and cleanup hook...
            Starting System Upgrade...
    [    6.507621] upgrade[677]: starting upgrade hook
    [    6.531079] upgrade[677]: /bin/upgrade: line 20: /sysroot/var/tmp/system-upgrade.state: No such file or directory
    [    6.543603] upgrade[677]: Storage initialisation: Attempt 0 of 11. Wait 15 seconds.
    [    6.608365] dracut-pre-pivot[703]: 6.605850 | /etc/multipath.conf does not exist, blocklisting all devices.
    [    6.620246] dracut-pre-pivot[703]: 6.608599 | You can run "/sbin/mpathconf --enable" to create
    [    6.630208] dracut-pre-pivot[703]: 6.608921 | /etc/multipath.conf. See man mpathconf(8) for more details
    [  OK  ] Finished dracut pre-pivot and cleanup hook.
    [   21.555427] upgrade[714]:   5 logical volume(s) in volume group "rootvg" now active
    [   21.581296] upgrade[677]: Mounting /usr with -o defaults,ro
    ```

    This output indicates that the Leapp upgrade process has continued successfully. After completion, the VM should boot into RHEL 9.*x*.

> [!IMPORTANT]
> If the Leapp upgrade still fails without an obvious reason (such as when upgrading from version 7.9 to version 8.10 or from version 8.10 to version 9.5), don't upgrade to the latest version. Instead, try to upgrade to an intermediate version (such as from version 7.9 to version 8.8 or version 8.10 to version 9.4) by specifying the `--target x.y` flag. After the intermediate upgrade is successful, you can try to upgrade to the latest release.

## Related content

- [Upgrading from RHEL 7 to RHEL 8](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/upgrading_from_rhel_7_to_rhel_8/index)

- [Upgrading from RHEL 8 to RHEL 9](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/upgrading_from_rhel_8_to_rhel_9/index)

- [Leapp upgrade FAQ (Frequently Asked Questions)](https://access.redhat.com/articles/7013172)

- [The best practices and recommendations for performing RHEL Upgrade using Leapp](https://access.redhat.com/articles/7012979)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
