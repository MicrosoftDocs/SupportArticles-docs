---
title: Clients can't connect and get the Class not registered error
description: Troubleshoot "Class not registered" error with remote desktop connection.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rklemen, v-lianna
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---

# Clients can't connect and get the "Class not registered" error

When you try to connect to a remote computer using a client running Windows 10, version 1709 or later, the client may not connect while the Remote Desktop Session Host server reports a message that contains the "Class not registered (0x80040154)" error code.

This issue occurs when the user who's trying to connect has a mandatory user profile. To resolve this issue, install the [July 24, 2018-KB4338817 (OS Build 16299.579)](https://support.microsoft.com/help/4338817) Windows 10 update.
