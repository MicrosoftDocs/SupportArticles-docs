---
title: Write filter must be disabled
description: This article describes that before joining a domain when leaving a domain to join a workgroup, the Write filter must be disabled.
ms.date: 09/07/2020
ms.subservice: general
---
# Write filter must be disabled before joining/leaving domain

This article introduces that before joining a domain when leaving a domain to join a workgroup, the Write filter (EWF or FBWF) must be disabled.

_Original product version:_ &nbsp; Windows Embedded Standard 7, Windows Embedded Standard 2009, Windows Embedded POSReady 2009  
_Original KB number:_ &nbsp; 2527267

## Summary

Before joining a domain or when leaving a domain to join a workgroup, the Write filter (EWF or FBWF) must be disabled.

## More information

Windows Embedded systems referenced in the "Applies to" section of this document provide a Registry Filter to circumvent features of the write filters (EWF or FBWF), which prevent changes to hard drive space.

The Registry Filter monitors identified registry keys for changes to keys and values below them in the hive hierarchy and preserves this data across boots. The Registry Filter is designed to monitor *existing keys* for changes. If a specified key does not exist, then a System Warning event 16 is logged to the event log and changes to the key cannot be monitored or preserved.

One of the registry keys monitored for such changes is a key that captures domain participation information. If this data is not preserved, then the state of domain participation will be lost the next time the system is booted. The domain participation key is created the first time that a domain is joined and deleted when a domain is left to join a workgroup. Since the Registry Filter requires monitored keys to exist, the write filter (EWF or FBWF) must be disabled:

- Prior to joining a domain the first time
- When leaving a domain to join a workgroup

Once the domain participation key has been created and a domain joined, the write filter can be enabled and domain participation state will be monitored and preserved by the Registry Filter.
