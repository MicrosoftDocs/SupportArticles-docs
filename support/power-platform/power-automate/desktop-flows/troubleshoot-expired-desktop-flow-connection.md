---
title: ExpiredDesktopFlowConnection When Using or Testing a Desktop Flow Connection
description: Resolves an error when using or testing a desktop flow connection that hasn't been used since the target machine or group renewed its key in Microsoft Power Automate.
ms.reviewer: padib，aartigoyle, johndund, quseleba
ms.date: 12/23/2024
ms.custom: sap:Desktop flows\Unattended flow runtime errors
---
# "ExpiredDesktopFlowConnection" error when using or testing a desktop flow connection

This article provides a resolution for the `ExpiredDesktopFlowConnection` error that might occur when you use or test a desktop flow connection in Microsoft Power Automate.

## Symptoms

You receive the following error message when using or testing a [desktop flow connection](/power-automate/desktop-flows/desktop-flow-connections):

```json
  {
      "error":{
          "code": "ExpiredDesktopFlowConnection",
          "message": "The connection is no longer valid and needs to be updated. [...]"
      }
  }
```

## Cause

The contents of the connection are encrypted using its target group or machine certificate. If the certificate is renewed and the connection isn't used during this period, the connection will expire because the certificate required for decryption is outdated due to the renewal.

A connection in this state can't be automatically recovered and must be manually updated.

## Resolution

To resolve the issue, follow these steps:

1. Sign in to [Power Automate](https://make.powerautomate.com/).
2. In the left navigation pane, select **Data** > **Connections**.
3. Find the expired connection, select it, and then select **Edit** to reenter the necessary information.

## More information

[Machine group certificate renewal for admins](/power-automate/desktop-flows/machine-group-certificates-admins)
