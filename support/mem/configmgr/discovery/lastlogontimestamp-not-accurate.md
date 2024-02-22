---
title: lastLogonTimestamp is not accurate
description: Describes a problem in which the lastLogonTimestamp attribute may not be accurate in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi, brshaw
---
# The lastLogonTimestamp attribute in System Center 2012 Configuration Manager may not be accurate

This article describes a by design behavior that the `lastLogonTimestamp` attribute may not be updated as expected in Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2679653

## Symptoms

Consider the following scenario in System Center 2012 Configuration Manager:

- Active Directory User Discovery is enabled in Configuration Manager.
- You use the `lastLogonTimestamp` attribute to determine the last logon for a user.

In this scenario, the exact time at which a particular user last logged on may not be accurate.

## Cause

This behavior occurs because the design and default configuration of Active Directory may result in the value of the `lastLogonTimestamp` attribute being updated only when the current value in Active Directory is 9 to 14 days older than the time of logon.

## References

For more information about the `lastLogonTimestamp` attribute, see the following articles:

- [Last-Logon-Timestamp attribute](/windows/win32/adschema/a-lastlogontimestamp)
- ["The LastLogonTimeStamp Attribute" - "What it was designed for and how it works"](/archive/blogs/askds/the-lastlogontimestamp-attribute-what-it-was-designed-for-and-how-it-works)
