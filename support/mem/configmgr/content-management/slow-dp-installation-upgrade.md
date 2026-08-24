---
title: DP installations or upgrades take longer than expected
description: Resolve slow distribution point installations or upgrades when all Distribution Manager upgrade threads are in use in Configuration Manager.
ms.topic: troubleshooting-problem-resolution
ms.date: 08/20/2026
ai-usage: ai-assisted
ms.reviewer: kaushika, brianhun, DAVSTEW, mikecure
ms.custom: sap:Content Management\Content Distribution to Distribution Points

#customer intent: As a Configuration Manager administrator, I want to identify why distribution point installations or upgrades are queued so that I can restore the default processing capacity.
---
# Distribution point installations or upgrades take longer than expected in Configuration Manager

**Applies to:** Configuration Manager current branch

## Summary

This article helps you resolve delayed distribution point installations or upgrades when all available Distribution Manager upgrade threads are in use.

## Symptoms

When you install or upgrade many standard or pull distribution points, some distribution points remain queued longer than expected. **DistMgr.log** repeatedly records the following message:

```output
DP upgrade processing thread: No more available threads left to process any more upgrade distribution point notifications. Will wait for existing distribution point upgrades.
```

The log also records the configured limit when Distribution Manager loads its settings:

```output
DP upgrade thread Limit: <thread limit>
```

## Cause

Distribution Manager uses one upgrade-processing thread for each distribution point installation or upgrade. In Configuration Manager current branch, the built-in limit is 50 concurrent threads. When 50 threads are active, Distribution Manager queues additional notifications and records the message shown in the [Symptoms](#symptoms) section.

The `DPUpgradeThreadLimit` site-control property overrides the built-in limit. This property is an embedded property in the `Props` array of the `SMS_DISTRIBUTION_MANAGER` instance of the `SMS_SCI_Component` Windows Management Instrumentation (WMI) class. If an earlier workaround set this property to a value lower than 50, Distribution Manager processes fewer installations or upgrades concurrently.

## Solution

1. In **DistMgr.log**, find the most recent `DP upgrade thread Limit` entry.
1. If the value is 50, don't increase it. Review the installation or upgrade thread entries in **DistMgr.log** to identify distribution points that take a long time or repeatedly fail. For more information about tracing an individual thread, see [Distribution point installation, upgrade, and configuration](dp-installation-upgrade-configuration.md).
1. If the value is lower than 50, check the `Props` array of the `SMS_DISTRIBUTION_MANAGER` instance of `SMS_SCI_Component` for a `DPUpgradeThreadLimit` embedded property.
1. If your organization no longer requires the custom limit, remove the embedded property to restore the built-in limit of 50. If your organization still requires the custom limit, set it according to your organization's tested capacity.
1. Commit the site-control change through the SMS Provider. Distribution Manager refreshes the setting during its normal processing cycle. Confirm that **DistMgr.log** records the expected limit.

> [!CAUTION]
> Incorrect site-control changes can damage a Configuration Manager site. Use the SMS Provider site-control APIs, test the change in a nonproduction environment, and don't set `DPUpgradeThreadLimit` higher than the built-in limit of 50.

## More information

- To understand how Configuration Manager stores site settings, see [About the Configuration Manager site control file](/intune/configmgr/develop/core/understand/about-the-configuration-manager-site-control-file).
- To update a site-control property with a session handle and commit the change, see [Read and write to the Configuration Manager site control file by using WMI](/intune/configmgr/develop/core/understand/how-to-read-and-write-to-the-site-control-file-by-using-wmi).
- For the component class and its `Props` array, see [SMS_SCI_Component server WMI class](/intune/configmgr/develop/reference/core/servers/configure/sms_sci_component-server-wmi-class).
