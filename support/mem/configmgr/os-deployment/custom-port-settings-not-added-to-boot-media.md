---
title: Custom port settings aren't added to boot media
description: Describes an issue in which custom port settings aren't added to boot media in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, brianhun
---
# Custom port settings aren't added to boot media in Configuration Manager

This article describes an issue in which custom port settings aren't added to boot media in System Center 2012 R2 Configuration Manager and later versions.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 2952919

## Symptoms

Boot media that is created at a central administration site (CAS) server in a System Center 2012 R2 Configuration Manager and later versions hierarchy will not contain the custom client communication port numbers of a child site. This occurs with dynamic or site-based media. However, this occurs only when the media is created on a site that has port numbers that are different from the port numbers of the site on which the client will be deployed.

Errors that resemble the following will be recorded in the Smsts.log file on the destination computer. Notice that the port reference will continue to read `:80` instead of the custom port that was previously defined for the site.

> CLibSMSMessageWinHttpTransport::Send: URL: 2012-SP1.corp.contoso.com:80  GET /SMS_MP/.sms_aut?MPLOCATION&ir=192.168.1.1&ip=192.168.1.0
>
> Error. Status code 404 returned

Boot media contains custom port information only for the site at which the media was created. For a site that has different port settings, client computers will not connect to the management point for that site. Media that is created at a stand-alone site is not affected and contains custom port information.

## More information

For more information about how to customize client port settings and boot images, see the following articles:

- [How to Configure Client Communication Port Numbers in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg712276(v=technet.10))
- [How to Deploy Operating Systems by Using Media in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/hh397285(v=technet.10))
