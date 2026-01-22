---
title: Troubleshooting Tool for Linux Guest Agent - VM assist
description: Provides script-based tool to help diagnose and resolve Azure Guest Agent issues on Azure virtual machines running Linux.
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.date: 12/04/2025
ms.reviewer: v-jsitser, scotro, v-ryanberg
ms.service: azure-virtual-machines
ms.custom: sap:VM Extensions not operating correctly
---
#  Troubleshooting Tool for Linux Guest Agent - VM assist

**Applies to:** :heavy_check_mark: Linux VMs

## Overview

The Microsoft Azure Linux VM Agent is a secure, lightweight process that manages virtual machine (VM) interaction with the Azure fabric controller. The Azure Linux VM Agent has a primary role in enabling and running Azure VM extensions. VM extensions enable post-deployment configuration of VMs, such as installing and configuring software. VM extensions also enable recovery features, such as resetting the administrative password of a VM. Without the Azure Linux VM Agent, you can't run VM extensions.

## Purpose  
The Linux version of VM assist is composed of bash and Python scripts that are used to detect potential issues that affect the guest agent in a Linux VM. It also examines other issues that are related to the general health of the VM. Output is intended to be viewed in the serial console. It provides pointers to solve well-known issues and certain deviations from best practice that can affect VM availability. The intention is for engineers to provide this script to customers through GitHub. However, it's possible and acceptable that a customer uses the script on their own and provides data through a service request.

Because the output of this script is designed to be viewed in a worst-case scenario of the Azure serial console, the information that's displayed is minimal and condensed. Details are provided through online resources that are accessed through a link that's provided in the output. See [VM assist for Linux](https://aka.ms/vmassistlinux).

VM assist is delivered in two functional scripts (one in bash and one in python3) plus an optional 'downloader' script.

The bash script performs some basic checks and determines whether running the Python script is possible or necessary.

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

If no issues are discovered during the base checks by using bash, the Python script is called to perform a deeper analysis that includes the following tasks:

- Find the source (package) for the guest agent executable and the Python passed from bash
- Optionally check any service or package statuses (this is currently a proof-of-concept inside the script)  
  - Only SSH is checked for the PoC
- Provide source information for all checked files and services
- Do configuration checks for the Guest Agent
- Connectivity checks for requirements of the guest agent
- Basic system configuration and status checks (#Guest best practices)

## Prerequisites

- The VM must start to the full OS (not emergency or maintenance mode).
- Root-level access must be available through either sudo or direct login/sudo -i

## How to run the tool

Go to the following GitHub location and follow the instructions there to [download, install, and run the tool](https://github.com/Azure/azure-support-scripts/blob/master/vmassist/linux/README.md). Subsequently, you can run the bash script directly: `vmassist.sh` as root or by using `sudo`.

If you open a support request, please include both of these files to aid the support agent who assists you.

## Known issues

- Don't try to run VM assist on appliances. Appliances don't run on general purpose operating systems, and the guest agent might not run at all.
- Distributions outside PAYG versions of RedHat or SUSE, or any Ubuntu or Mariner or Azure Linux, might display false positive warnings about repository names. This situation requires a more careful reading because even official repositories might not match strict pattern matching. This condition is true because we don't build cases for all distributions.
- Ubuntu 24.04 has a different architecture of the SSH service. It might flag the service even if the service is operating well.

 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
