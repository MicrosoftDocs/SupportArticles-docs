---
title: '"200 OK" message received but not the SIP OPTIONS'
ms.author: v-todmc
author: mccoybot
manager: dcscontentpm
ms.date: 11/5/2020
audience: Admin
ms.topic: article
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 124780
- CSSTroubleshoot 
ms.reviewer: mikebis
description: Resolves an issue where the 200 OK message is received, but not the SIP OPTIONS. 
---

# SBC receives "200 OK," but not SIP OPTIONS

## Summary

The SBC receives the “200 OK” message, but doesn't receive the SIP OPTIONS that's returned by the Teams SIP proxy.

## Resolution

Although the “200 OK” message is returned by using the same connection that the SIP OPTIONS sent from SBC used, when the SIP proxy sends the SIP OPTIONS back to SBC it uses the FQDN from the **Record-Route** header (if it exists) or from the **Contact** header. To resolve this issue, make sure that the domain name is correct and that the FQDN DNS resolves to the correct IP address. 

Another possible cause of this issue is that the firewall rules don't allow an incoming connection from outside. Check the firewall rules to make sure that they allow incoming connections.


## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).