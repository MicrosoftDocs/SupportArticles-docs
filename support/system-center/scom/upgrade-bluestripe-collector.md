---
title: Upgrade BlueStripe Collector
description: Describes how to upgrade BlueStripe Collector.
ms.date: 08/13/2020
---
# How to upgrade BlueStripe Collector

This article describes how to upgrade BlueStripe Collector.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134892

## Upgrade collectors

Collectors can be upgraded by running the installation program for a newer version. For AIX, Linux and Solaris, execute the following scripts to start the upgrade. In Windows, execute the EXE.

- AIX: `sh InstallBlueStripeCollector-AIX.bin`
- Linux: `sh InstallBlueStripeCollector-Linux.bin`
- Solaris: `sh InstallBlueStripeCollector-Solaris.bin`
- Windows: `InstallBlueStripeCollector-Windows.exe`

## Upgrade and Replace options

There are two upgrade options: **Upgrade** and **Replace**.

- Upgrade preserves configuration and storage files while installing to the same base directory location.

- Replace won't preserve configuration and storage files, but it can install into a new base directory location.

If you would like to make configuration changes to the collector as part of the upgrade process, you can create a txt file containing the lines of config that you want to add, and then pass the file to the installer using the `--config` flag as follows:

```console
sh InstallBlueStripeCollector-Solaris.bin --config adjustHeap.txt
```
