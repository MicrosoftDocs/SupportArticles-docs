---
title: Task sequence fails with error 0x87d01004
description: Fixes a problem in which task sequence execution fails when using a stand-alone media (USB flash drive or CD/DVD) in System Center 2012 Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi, adoyle, monsee
ms.custom: sap:Operating Systems Deployment (OSD)\Task Sequence Media (all types)
---
# Task sequence fails when using stand-alone media in Configuration Manager

This article helps you resolve a problem in which task sequence fails to install applications with error 0x87d01004 when using a stand-alone media in System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2716946

## Symptoms

In System Center 2012 Configuration Manager, task sequence execution fails when using a stand-alone media (USB flash drive or CD/DVD). The task sequence fails to install applications, and the SMSTS.log contains an error similar to the following:

> Failed to invoke Execution Manager to Install Software for PackageID='*CAS0002C*' ProgramID='*setup*' AdvertID='*{00A2B6FB-8E61-47B6-9702-BBDEAD7FBE8A}*'**hr=0x87d01004**  

Items in *italics* above are based on the environment so will not be consistent but the **hr code (in bold)** will be.

## Cause

This problem occurs because the Software Distribution Agent isn't enabled since the client hasn't yet received policy.

## Resolution

To resolve the issue and enable the Software Distribution Agent, add the following **Run Command Line** step earlier in the task sequence, before any **Install Package** steps:

`WMIC /namespace:\\root\ccm\policy\machine\requestedconfig path ccm_SoftwareDistributionClientConfig CREATE ComponentName="Enable SWDist", Enabled="true", LockSettings="TRUE", PolicySource="local", PolicyVersion="1.0", SiteSettingsKey="1" /NOINTERACTIVE`
