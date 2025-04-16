---
title: Win key remains held in local session after pressing Ctrl + Win + L in a remote session
description: Addresses a problem with AVD. When using Ctrl + Win + L for Live Caption in a remote session, the Win key remains held in the local session.
ms.date: 04/14/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: jordanm,ievtushenkoa
ms.custom: 
- sap:Azure Virtual Desktop\Remote Desktop Clients\Redirecting resources via the client
- pcy:wincomm-user-experience
---
# Win key remains held in local session after pressing Ctrl + Win + L in a remote session

This article addresses a problem with Azure Virtual Desktop (AVD). After you press Ctrl + Win + L for Live Caption in a remote session, the Win key remains held in the local session.

## Symptom

Consider the following scenario:

* You connect to a Windows 11 based remote computer by using either MSRDC or Windows App.
* You enter the full screen mode in the remote session.
* You press Ctrl + Win + L to start Live Caption.
* You release Ctrl and L first, and then finally release the Win key.
* You minimize or exit full screen mode of the remote session and return to the local desktop.

In this scenario, the Win key is still held in the local session. If you press another key, Windows interprets it as if you are pressing the Win key along with that key. For example, if you press "I" at that moment, the Settings app will open.

## Cause

This behavior is due to known limitation related to Windows protection against the attempts to override Win + L combination. When you use the Win key, there are certain key combos locked to prevent malicious use.

## Workaround

We recommend using one of the following workaround:

* Change the order in which the three keys are released. That is, after pressing Ctrl + Win + L, release the L or Win key before Ctrl.
* Start Live Caption from start menu. You can just press and release Win button to open the start menu.
