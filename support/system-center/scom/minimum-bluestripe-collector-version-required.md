---
title: Minimum BlueStripe Collector version required
description: Describes the minimum version of the BlueStripe Collector required for a particular OS version.
ms.date: 08/13/2020
ms.custom: linux-related-content
---
# BlueStripe Collector support by operating system

The tables in this article show the minimum version of the BlueStripe Collector required for a particular operating system (OS) version. If your operating system version is not listed, contact BlueStripe support for assistance.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134883

If the collector isn't started after an upgrade, check the service.logs in the `Unix Collector/log` directory or wrapper.log in the `Windows Collector\logs` directory.

## IBM® AIX®

|OS version TechLevel|Service Pack|Minimum collector version| Maximum collector version|Notes|
|---|---|---|---|---|
|AIX 7.1|||||
|TL0|Up to SP10|7.3.0|current||
|TL1|Up to SP8|7.3.0|current||
||SP9|7.5.0|current||
||SP10|8.0.0|current||
|TL2|Up to SP3|7.3.0|current||
||SP4|7.5.1|current||
||SP5|8.0.0|current||
||SP6|8.1.0|current||
|TL3|Up to SP1|7.5.0|current||
||SP2|7.5.1|current||
||SP3|8.0.0|current||
||SP4|8.0.1|current||
||SP5|8.1.0|current||
| AIX 6.1|||||
|Up to TL5||5.6.0|current||
|TL6|Up to SP5|5.6.0|current||
||SP6 - SP9|7.0.1|current||
||SP10 - SP11|7.1.0|current||
||SP12|7.3.0|current||
|TL7|Up to SP3|6.0.3|current||
||SP4 - SP5|7.0.1|current||
||SP6 - SP7|7.1.0|current||
||SP8|7.3.0|current||
||SP9 - SP10|8.0.0|current||
|TL8|Up to SP2|7.2.0|current||
||SP3|7.3.0|current||
||SP4|7.5.0|current||
||SP5|8.0.0|current||
||SP6|8.1.0|current||
|TL9|Up to SP1|7.5.0|current||
||SP2|7.5.1|current||
||SP3|8.0.0|current||
||SP4|8.0.1|current||
||SP5|8.1.0|current||

## Linux

The BlueStripe Collector support is based on Red Hat Enterprise Linux and other distributions that are derivatives and fully compatible running on x86 family processors (32-bit and 64-bit unless otherwise noted).

BlueStripe Collector is not supported on Itanium (ia64), PowerPC (ppc64), zLinux (s390).

Starting with the 8.0.3 collector, there are now two installers for Linux, a 32 bit (InstallBlueStripeCollector-Linux32.bin), and a 64 bit (InstallBlueStripeCollector-Linux64.bin). So make sure you pick the correct one for your installation.

### Red Hat® Enterprise Linux and CentOS Linux

- Only default and SMP Linux kernel releases are supported.

  - Non-standard kernel releases, such as PAE and Xen, aren't supported for any Linux distribution. For example, a system with the release string of _2.6.16.21-0.8-xen_ isn't supported.
  - Custom kernels, including recompiles of standard kernels, aren't supported.

- Centos Plus kernel isn't supported.

When upgrading a Linux operating system with an installed collector, you must rerun the collector installation to reinstall the correct kernel module.

|OS version|Kernel version|Minimum collector version|Maximum collector version|Notes|
|---|---|---|---|---|
|RHEL 7||||64-bit only|
|7.0|3.10.0-123|8.0.3|current||
|7.1|3.10.0-229|8.1.0|current||
|RHEL 6|||||
|6.0|2.6.32-71|5.6.0|current||
|6.1|2.6.32-131|5.6.0|current||
|6.2|2.6.32-220|6.0.0|current||
|6.3|2.6.32-279|7.0.0|current||
|6.4|2.6.32-358|7.1.0|current||
|6.5|2.6.32-431|7.3.2|current||
|6.6|2.6.32-504|8.0.0|current||
|6.7|2.6.32-573|8.1.0|current||
|RHEL 5|||||
|5.0|2.6.18-8|5.6.0|8.0.2||
|5.1|2.6.18-53|5.6.0|8.0.2||
|5.2|2.6.18-92|5.6.0|8.0.2||
|5.3|2.6.18-128|5.6.0|8.0.2||
|5.4|2.6.18-164|5.6.0|8.0.2||
|5.5|2.6.18-194|5.6.0|8.0.2||
|5.6|2.6.18-238|5.6.0|8.0.2||
|5.7|2.6.18-274|5.6.0|8.0.2||
|5.8|2.6.18-308|6.0.0|current||
|5.9|2.6.18-348|7.0.3|current||
|5.10|2.6.18-371|7.3.2|current||
|5.11|2.6.18-398|8.0.0|current||
|2.6.18-400|8.0.2|current|||
|2.6.18-402|8.0.3|current|||
|2.6.18-404|8.0.5|current|||
|2.6.18-406|8.1.0|current|||

## Oracle® Enterprise Linux

The BlueStripe Collector is fully supported for Oracle Enterprise Linux when booted to the Red Hat compatible kernel, with limited support for the unbreakable Enterprise kernel. See the table below.

- The Red Hat kernel with Oracle fixes isn't supported.
- Only default and SMP Linux kernel releases are supported.

When upgrading a Linux operating system with an installed collector, you must rerun the collector installation to reinstall the correct kernel module.

|OS version|Kernel version|Minimum collector version|Maximum collector version|Notes|
|---|---|---|---|---|
|Oracle Linux 7||||64 bit only|
|7.0|Oracle 3.8.13 (UEK R3)|not supported|not supported||
|Red Hat 3.10.0-123|8.0.3|current|||
|7.1|Oracle 3.8.13-55 (UEK R3)|not supported|not supported||
|Red Hat 3.10.0-229|8.1.0|current|||
| Oracle Linux 6|||||
|6.0|Oracle 2.6.32-100 (UEK R1)|not supported|not supported||
|Red Hat 2.6.32-71|5.6.0|current|||
|6.1|Oracle 2.6.32-100 (UEK R1)|not supported|not supported||
|Red Hat 2.6.32-131|5.6.0|current|||
|6.2|Oracle 2.6.32-300 (UEK R1)|8.0.1|current|64 bit only|
|Red Hat 2.6.32-220|6.0.0|current|||
|6.3|Oracle 2.6.39-200 (UEK R2)|8.0.1|current|64 bit only|
|Red Hat 2.6.32-279|7.0.0|current|||
|6.4|Oracle 2.6.39-400 (UEK R2)|8.0.1|current|64 bit only|
|Red Hat 2.6.32-358|7.1.0|current|||
|6.5|Oracle 2.6.39-400 (UEK R2 i386)|not supported|not supported||
|Oracle 3.8.13-16 (UEK R3 x86_64)|not supported|not supported|||
|Red Hat 2.6.32-431|7.3.2|current|||
|6.6|Oracle 2.6.39-400 (UEK R2 i386)|not supported|not supported||
|Oracle 3.8.13-44 (UEK R3 x86_64)|not supported|not supported|||
|Red Hat 2.6.32-504|8.0.0|current|||
|6.7|Oracle 2.6.39-400 (UEK R2 i386)|not supported|not supported||
|Oracle 3.8.13-44 (UEK R3 x86_64)|not supported|not supported|||
|Red Hat 2.6.32-567|8.1.0|current|||
| Oracle Linux 5|||||
|5.0|Red Hat 2.6.18-8|5.6.0|8.0.2||
|5.1|Red Hat 2.6.18-53|5.6.0|8.0.2||
|5.2|Red Hat 2.6.18-92|5.6.0|8.0.2||
|5.3|Red Hat 2.6.18-128|5.6.0|8.0.2||
|5.4|Red Hat 2.6.18-164|5.6.0|8.0.2||
|5.5|Red Hat 2.6.18-194|5.6.0|8.0.2||
|5.6|Oracle 2.6.32-100 (UEK R1)|not supported|not supported||
|Red Hat 2.6.18-238|5.6.0|8.0.2|||
|5.7|Oracle 2.6.32-200 (UEK R1)|not supported|not supported||
|Red Hat 2.6.18-274|5.6.0|8.0.2|||
|5.8|Oracle 2.6.32-300 (UEK R1)|7.5.1|current|64 bit only|
|Red Hat 2.6.18-308|6.0.0|current|||
|5.9|Oracle 2.6.39-300 (UEK R2)|7.5.1|current|64 bit only|
|Red Hat 2.6.18-348|7.0.3|current|||
|5.10|Oracle 2.6.39-400 (UEK R2)|7.5.1|current|64 bit only|
|Red Hat 2.6.18-371|7.3.2|current|||
|5.11|Oracle 2.6.39-400 (UEK R2)|8.0.0|current|64 bit only|
|Red Hat 2.6.18-398|8.0.0|current|||
|Red Hat 2.6.18-400|8.0.2|current|||
|Red Hat 2.6.18-402|8.0.3|current|||
|Red Hat 2.6.18-404|8.0.5|current|||
|Red Hat 2.6.18-406|8.1.0|current|||

## SUSE Linux Enterprise Server

SUSE Linux is only supported for 64-bit.

|OS version|Kernel version|Minimum collector version|Maximum collector version|Notes|
|---|---|---|---|---|
|SLE 11|||||
|11.0|2.6.27|7.0.0|current||
|SP1|2.6.32|7.0.0|current||
|SP2|3.0.13|8.1.0|current||
|SP3|3.0.76|8.1.0|current||
|SP4|3.0.101|8.1.0|current||

## Sun® Solaris®

Solaris 11 is currently not supported.

|OS version|SPARC kernel patch ID|x86 Kernel patch ID|Minimum collector version|Maximum collector version|Notes|
|---|---|---|---|---|---|
|Solaris 10|32-bit Solaris support discontinued with Collector Version 8.1.0|||||
|Up to Solaris 10 8/11 (Update 10)|144500|144501|5.6.0|current||
||147440|147441|7.2.0|current||
|Solaris 10 1/13 (Update 11)|147147|147148|7.2.0|current||
||148888|148889|7.2.0|current||
||150400|150401|7.2.2|current||

## Microsoft® Windows®

- Starting with v8.0.1 on Windows Server 2008 R2 or a later version, a reboot isn't required for a new install or when upgrading from a v8.0.1 collector. When upgrading from a collector version before v8.0.1, a reboot is still required to complete the upgrade installation to activate the collector.
- On Windows Server 2003 and Windows 2008, a reboot is always required to activate the collector after a new install or upgrade.

Windows Server Core is supported for Windows Server 2008 R2 and a later version.

|OS version|Minimum collector version|Maximum collector version|Notes|
|---|---|---|---|
|Windows Server||||
|Windows Server 2012 R2|7.3.2|current||
|Windows Server 2012|7.2.0|current||
|Windows Server 2008 R2|5.6.0|current||
|SP1|5.6.0|current||
|Windows Server 2008|5.6.0|current||
|SP1|5.6.0|current||
|SP2|5.6.0|current||
|Windows Server 2003 R2|5.6.0|current||
|Windows Server 2003|5.6.0|current||
|SP1|5.6.0|current||
|SP2|5.6.0|current||
| Windows Desktop||||
|Windows 8.1|7.3.2|current||
|Windows 8|7.2.0|current||
|Windows 7|5.6.0|current||
|SP1|5.6.0|current||
|Windows XP|5.6.0|7.5.x||
