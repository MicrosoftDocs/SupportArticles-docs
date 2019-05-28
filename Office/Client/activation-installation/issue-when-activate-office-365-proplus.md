---
title: We are unable to connect right now when try to activate Office 365 ProPlus
description: Describes an issue that triggers an error message when users try to activate Office 365 ProPlus. Provides a workaround.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
---

# "We are unable to connect right now" error when users try to activate Office 365 ProPlus

## Symptoms

When you set up your network to block Internet Explorer 6, users discover that they cannot activate Office 365 ProPlus. When users try to activate Office 365 ProPlus, they receive the following error message:

**We are unable to connect right now. Please check your network and try again later.**

## Cause

This issue occurs because the client computer cannot connect to *.microsoftonline-p.net.

## Workaround

To work around this issue, add an explicit "allow" rule that contains "MSOIDCRL"in your firewall or proxy for agents. 

For example, set up the rules to first allow MSOIDCRL and to then deny Internet Explorer 6.

For more info about how to configure firewall rules, see your firewall documentation. 

## More information

For more information about Office 365 activation issues, see the following Microsoft Knowledge Base article: 

[Office 365: Use the Support and Recovery Assistant for Office 365](https://support.office.com/article/unlicensed-product-and-activation-errors-in-office-0d23d3c0-c19c-4b2f-9845-5344fedc4380)

Still need assistance? Ask for help in the [Microsoft Community](https://answers.microsoft.com/).