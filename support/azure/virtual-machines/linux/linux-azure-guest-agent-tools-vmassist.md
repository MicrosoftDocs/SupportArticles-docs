---
title: Troubleshooting Tool for Linux Guest Agent - VM assist
description: Provides script-based tool to help diagnose and resolve Azure Guest Agent issues on Azure virtual machines running Linux.
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.date: 10/24/2025
ms.reviewer: v-jsitser, scotro, v-ryanberg
ms.service: azure-virtual-machines
ms.custom: sap:zzzz
---
#  Troubleshooting Tool for Linux Guest Agent - VM assist

**Applies to:** :heavy_check_mark: Linux VMs

## Overview

The Microsoft Azure Linux VM Agent is a secure, lightweight process that manages virtual machine (VM) interaction with the Azure fabric controller. The Azure Linux VM Agent has a primary role in enabling and executing Azure virtual machine extensions. VM extensions enable post-deployment configuration of VMs, such as installing and configuring software. VM extensions also enable recovery features such as resetting the administrative password of a VM. Without the Azure Linux VM Agent, you can't run VM extensions.

## Purpose  
The Linux version of VM assist is comprised of bash and Python scripts used to detect potential issues with the Guest Agent in a Linux VM in addition to other issues related to the general health of the VM. Output is intended to be viewed in the serial console and provide pointers to solve well-known issues, as well as certain deviations from best practice which can affect VM availability. The intention is for engineers to provide this script to customers via GitHub, but it is possible and acceptable that a customer uses the script on their own and provides data through an SR.

Given that the output of this script is designed to be viewed in a worst-case scenario of the Azure serial console, the information displayed is minimal and condensed, with detail provided through online resources accessed via an link provided in that output - [VM assist for Linux](https://aka.ms/vmassistlinux)

VM assist is delivered in two functional scripts - one in bash and one in python3, and an optional 'downloader' script.

The bash script will perform some basic checks and determine if running the Python script is possible and/or necessary.

## Key features

### Bash checks

The following checks are run in bash today:

- OS family detection
- Identify the Guest Agent service
- Identify the path of Python called from the service - this will be used for running the Python script
- Display the package and package repository for the agent and the Python called from the agent
- Basic connectivity checks to the wire server and IMDS

> If the bash script finds a python2 system the script will exit and display the information it has gathered.

### Python analysis

If there are no issues uncovered during the base checks using bash, the Python script is called to perform a deeper analysis:

- Find the source (package) for the Guest Agent executable and the Python passed from bash
- Optionally check any service or package statuses, which is currently a proof-of-concept inside the script  
  - Only SSH is checked for the PoC
- Provide source information for all checked files and services
- Do configuration checks for the Guest Agent
- Connectivity checks for requirements of the Guest Agent
- Basic system configuration and status checks (#Guest best practices)


## Prerequisites

- VM needs to be booting to the full OS, i.e. not emergency or maintenance mode.
- root-level access either through sudo or direct login/sudo -i

## How to run the tool

The VM assist scripting is run initially from the above documentation. Subsequent runs can be done by running the bash script directly - `vmassist.sh` as root or using `sudo`.

If you open a support request, please include both of the above files to aid your support representative in helping you.

## Known issues
- Do not attempt to run VM assist on appliances - these are not general purpose operating systems, and the Guest Agent may not run at all.
- Distributions outside of PAYG versions of RedHat or SUSE, or any Ubuntu or Mariner/Azure Linux may display false positive warnings about repository names. This will require a more careful reading as the repositories may be official but do not match strict pattern matching as we do not build cases for all distributions.
- Ubuntu 24.04 has a differing architecture of the SSH service, and may flag the service even though it is operating fine.


[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]





