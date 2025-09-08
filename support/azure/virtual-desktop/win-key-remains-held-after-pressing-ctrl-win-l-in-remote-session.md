---
title: Win Key Remains Held in Local Session After Pressing Ctrl+Win+L in a Remote Session
description: Addresses a problem with AVD where the Windows key remains held in the local session when using Ctrl+Win+L for live captions in a remote session.
ms.date: 04/21/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: jordanm,ievtushenkoa
ms.custom: 
- sap:Azure Virtual Desktop\Remote Desktop Clients\Redirecting resources via the client
- pcy:wincomm-user-experience
---
# Windows key remains held in the local session after pressing Ctrl+Win+L in a remote session

This article addresses a problem with Azure Virtual Desktop (AVD). After you press <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>L</kbd> for live captions in a remote session, the Windows key remains held in the local session.

## Symptoms

Consider the following scenario:

* You connect to a Windows 11-based remote computer by using the Microsoft Remote Desktop Client (MSRDC) or Windows App.
* You enter full screen mode in the remote session.
* You press <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>L</kbd> to start live captions.
* You release <kbd>Ctrl</kbd> and <kbd>L</kbd> first and then release the <kbd>Win</kbd> key.
* You minimize or exit full screen mode of the remote session and return to the local desktop.

In this scenario, the <kbd>Win</kbd> key is still held in the local session. If you press another key, Windows interprets it as you pressing the <kbd>Win</kbd> key along with that key. For example, if you press <kbd>I</kbd> at that moment, the **Settings** app opens.

## Cause

This behavior is due to a known limitation in Windows that is designed to prevent attempts to override the <kbd>Win</kbd>+<kbd>L</kbd> combination. When you use the <kbd>Win</kbd> key, certain key combinations are locked to prevent malicious use.

## Workaround

We recommend using one of the following workarounds:

* Change the order in which the three keys are released. That is, after pressing <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>L</kbd>, release the <kbd>L</kbd> or <kbd>Win</kbd> key before the <kbd>Ctrl</kbd> key.
* Start live captions from the **Start** menu. You can just press and release the <kbd>Win</kbd> button to open the **Start** menu.
