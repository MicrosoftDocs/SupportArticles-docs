---
title: Support Policy for NIC Teaming with Hyper-V
description: Describes the Microsoft Support Policy for Network Adapter Teaming when used in conjunction with Hyper-V.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installation-and-configuration-of-hyper-v, csstroubleshoot
---
# Microsoft support policy for NIC Teaming with Hyper-V

This article describes the Microsoft Support Policy for Network Adapter Teaming when used in conjunction with Hyper-V.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 968703

## Introduction

Network Adapter Teaming is a third-party Technology that provides fault tolerance for multiple Network Adapters.

Since Network Adapter Teaming is only provided by Hardware Vendors, Microsoft does not provide any support for this technology through Microsoft Product Support Services. As a result, Microsoft may ask that you temporarily disable or remove Network Adapter Teaming software when troubleshooting issues where the teaming software is suspect.

If the problem is resolved by the removal of Network Adapter Teaming software, then further assistance must be obtained through the Hardware Vendor.

## More information

Common symptoms exhibited due to improperly configured NIC Teaming software:

- After a live migration of a virtual machine (VM) is performed, the VM loses network connectivity

- Virtual machines intermittently lose network connectivity

- The following event is logged in the System event log on the Hyper-V server:

    > Log Name: System  
    Source: VMSMP  
    Event ID: 28  
    Level: Warning  
    Description: Port '97B1A2BA-D679-4290-AD9B-262DE33C16D6' was prevented from using MAC address '00-15-D5-04-F8-0C' because it is pinned to port 'BFA4D592-1F9D-8484-8ABF-9EDA1534529E'.
