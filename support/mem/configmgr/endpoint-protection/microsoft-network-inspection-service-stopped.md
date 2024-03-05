---
title: Microsoft Network Inspection service is stopped
description: Describes a problem in which the Microsoft Network Inspection service may be stopped by Active Directory Group Policy.
ms.date: 12/05/2023
ms.reviewer: kaushika, ErinWi, prakask, keiththo, brshaw
---
# Microsoft Network Inspection service started by Configuration Manager may be stopped by AD Group Policy

This article describes a by-design behavior where the Microsoft Network Inspection service may be stopped by Active Directory Group Policy.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2688238

## Symptoms

Consider the following scenario:

- A Microsoft System Center 2012 Configuration Manager administrator sets the **Enable protection against network-based exploits** option to **True** and then deploys the policy to a collection of devices. This option is part of the real-time protection item on the **Antimalware** tab for the Microsoft Forefront Endpoint Protection (FEP) policies in the Configuration Manager console.
- Then, the Configuration Manager client sets the start of the Microsoft Network Inspection service to **Automatic** on all devices in the target collection.
- An Active Directory administrator configures Group Policy to set the start for the Microsoft Network Inspection service to **Disabled**.

In this scenario, when the Group Policy settings are applied, the Microsoft Network Inspection service is stopped, and the start of the service is set to **Disabled**. When the Configuration Manager client evaluates client health and determines that the service is disabled, it remediates the problem by setting the start of the service to **Automatic** and starts the service again. However, the service soon stops again because the service is stopped by the Active Directory Group Policy.

## Status

This behavior is by design. Group Policy settings to disable services should be carefully evaluated together with the Configuration Manager group or the System Center 2012 Endpoint Protection group to make sure that these settings don't disable services for required functionalities.
