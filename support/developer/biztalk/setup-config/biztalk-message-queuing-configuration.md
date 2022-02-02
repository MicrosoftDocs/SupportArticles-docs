---
title: Configuration options can't be changed
description: Explains that the BizTalk Message Queuing Configuration options that you specify the first time can't be changed unless you remove and reinstall BizTalk Server 2004.
ms.date: 03/16/2020
ms.custom: sap:BizTalk Server Setup and Configuration
---
# BizTalk Message Queuing Configuration options can't be changed after initial setup

This article describes the issue where the BizTalk Message Queuing Configuration options can't be changed after initial setup.

_Original product version:_ &nbsp; BizTalk Server 2004  
_Original KB number:_ &nbsp; 836487

## Set configuration options

The first time that you run the **Configuration Framework Wizard** for Microsoft BizTalk Message Queuing, you set the configuration options. You can't change these configuration options by unconfiguring the current configuration of your Microsoft BizTalk Server installation and then running the **Configuration Framework Wizard** again.

You can set the following configuration options for BizTalk Message Queuing when you run the **Configuration Framework Wizard**:

- IP Address

    You can select whether to bind BizTalk Message Queuing to all IP addresses on the server or to bind BizTalk Message Queuing to a specified IP address.
- DNS Registration

    You can select whether to register the server in DNS in the current domain.
- Active Directory Integration

    You can select whether to register the server in Microsoft Active Directory in the current domain.

## Change configuration options

Verify that you've selected the appropriate configuration options for BizTalk Message Queuing when you run the **Configuration Framework Wizard** for the first time. If you must change one or more of these configuration options, you must remove and then reinstall BizTalk Server 2004.

To start the **Configuration Framework Wizard**, double-click the **Configframework.exe** file. By default, the **Configframework.exe** file is located in the `C:\Program Files\Microsoft BizTalk Server 2004\` folder.

To start the **Configuration Framework Wizard** in unconfigure mode from a command prompt, switch to the directory that contains the **Configframework.exe** file, type `configframework /u`, and then press **ENTER**.
