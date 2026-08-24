---
title: Migrating a driver package fails because the SMS Provider has insufficient permissions
description: Resolves an issue where you can't migrate a driver package because the SMS Provider doesn't have read, write, and delete permissions on the driver package source path.
ms.date: 08/21/2026
ms.reviewer: kaushika, marcoh, erinwi, jarrettr
ai-usage: ai-assisted
ms.custom: sap:Operating Systems Deployment (OSD)\Driver Management and Installation
---
# Migrating a driver package fails because the SMS Provider has insufficient permissions

## Summary

This article helps you resolve an issue where you can't migrate a driver package because the SMS Provider doesn't have read, write, and delete permissions on the driver package source path.

## Symptoms

While attempting to migrate a driver package between Configuration Manager hierarchies, the action fails and shows the following error in the `migmctrl.log` file:

> SMS provider doesn't have read, write, or delete permission to the package source path

## Cause

This problem can occur if the SMS Provider doesn't have sufficient permissions on the driver package source path (NTFS or share permissions).

## Resolution

Grant the SMS Provider full control permissions on the driver package source path.

## More information

During migration, the error only shows for driver packages because Migration Manager needs to process some content in the source path, so it fails during the migration itself. If you migrate a regular software package, the migration succeeds regardless of whether the destination site has access to the source path. However, `SMS_DISTRIBUTION_MANAGER` (`distmgr.log`), which starts to process this package, fails due to insufficient permissions on the package source path.

For more information, see [Manage drivers in Configuration Manager](/mem/configmgr/osd/get-started/manage-drivers).
