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
* You enter the full screen mode in the Remote Desktop Protocol (RDP) session.
* You press Ctrl + Win + L to start Live Caption.
* You release Ctrl and L first, and then finally release the Win key.
* You minimize or exit full screen mode of the RDP session and return to the local desktop.

In this scenario, the Win key is still held in the local session.

## Cause

This behavior is by designed because of security. When you use the Win key, there are certain key combos locked to prevent malicious use.

## Workaround

We recommend changing the order in which the three keys are released. That is, after pressing Ctrl + Win + L, release the L or Win key before Ctrl.
