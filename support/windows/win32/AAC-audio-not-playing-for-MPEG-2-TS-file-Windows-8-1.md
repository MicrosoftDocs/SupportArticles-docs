---
title: AAC audio isn't playing for MPEG-2 TS file in Windows 8.1
description: This article discusses a problem when the AAC audio of an MPEG-2 TS file doesn't play in Windows 8.1.
ms.date: 03/10/2022
author: HaiyingYu
ms.author: haiyingyu
ms.custom: sap:Graphics and multimedia development
ms.reviewer: soshogoh
ms.technology: windows-dev-apps-graphics-multimedia-dev
---

# AAC audio doesn't play for MPEG-2 TS file in Windows 8.1

This article helps you fix the problem that occurs when an MPEG-2 file can't play Advanced Audio Coding (AAC) audio in Windows 8.1.

_Applies to:_ &nbsp; Windows 8.1

## Symptoms

You play an MPEG-2 Transport Stream (TS) file in Windows 8.1 by using the Windows Media Player or Media Foundation application. However, the AAC audio of the file doesn't play correctly.

You might experience noise in the AAC audio when you play an MPEG-2 TS file in Windows 8.1. If you play the same AAC audio in the MP4 container, the audio plays as expected.

> [!NOTE]
> This problem does not occur in Windows 11 or Windows 10.

## Cause

The MPEG-2 parser library was updated in Windows 8.1 to stream AAC audio in certain container formats such as Audio Data Transport Stream (ADTS), Low Overhead Audio Stream (LOAS), and Low Overhead Audio Transport Multiplex (LATM). If the AAC audio in your MPEG-2 TS file isn't in the supported format, this problem occurs.

## Workaround

> [!IMPORTANT]
> Windows 8.1 is in extended support. Therefore, Microsoft might not provide a hotfix to resolve this problem. We recommend that you upgrade to Windows 11 or Windows 10.

To fix the problem in Windows 8.1, use any of the following methods:

- Save your .ts file as .mp4 file. Then, the AAC audio will stream correctly in Windows 8.1.

- If you're using the LATM or LOAS encapsulation of MPEG-2 TS file, switch to raw AAC audio formats. For example, use the .aac or .adts file extension that contains AAC elementary streams with the ADTS frame headers to play audio.

- If the audio file encoding uses MPEG-2 TS encapsulation, re-encode the audio streams as MPEG-2 L1 audio to stream audio correctly in Windows 8.1.
