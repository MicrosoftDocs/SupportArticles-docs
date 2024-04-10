---
title: Check BlueStripe Collector version
description: Describes how to check the BlueStripe Collector version.
ms.date: 08/13/2020
ms.custom: linux-related-content
---
# How to check the BlueStripe Collector version

This article describes how to check the BlueStripe Collector version.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134878

## Windows

To check the BlueStripe Collector version, run the following command:

```console
C:\Program Files\BlueStripe\Collector\bin\BlueStripeCollector.exe --version
```

For example, the command returns the following result:

> BlueStripeCollector: Release=7.3.0, Revision=33577

## Linux

To check the BlueStripe Collector version, run the following command:

```console
rpm -qa bluestripe-collector
```

For example, the command returns the following result:

> bluestripe-collector-7.2.0-1.x86_64

## Solaris

To check the BlueStripe Collector version, run the following command:

```console
pkginfo -l BSSWcoll
```

For example, the command returns the following result:

> PKGINST: BSSWcoll  
> NAME: BlueStripe Collector  
> CATEGORY: system  
> ARCH: sparc  
> VERSION: 7.5.1  
> BASEDIR: /  
> VENDOR: BlueStripe  
> PSTAMP: 35224  
> INSTDATE: Jun 18 2014 14:42  
> EMAIL: \<Email address>  
> STATUS: completely installed  
> FILES: 324 installed pathnames  
> 3 shared pathnames  
> 52 directories  
> 104 executables  
> 48965 blocks used (approx)

## AIX

To check the BlueStripe Collector version, run the following command:

```console
lslpp -R /banktools -L bluestripe.collector.rte [-R User Specified Install Location only needed if installed in base_dor]
```

For example, the command returns the following result:

> Fileset Level State Type Description (Uninstaller)  
> \-----------------------------------------------------------  
> bluestripe.collector.rte 7.5.1.0 C F Gathers data about system and
network activity
