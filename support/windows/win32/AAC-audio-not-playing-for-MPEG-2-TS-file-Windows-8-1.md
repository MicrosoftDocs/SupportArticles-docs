---
title: AAC audio isn't playing for MPEG-2 TS file in Windows 8.1
description: This article discusses the problem when AAC audio of an MPEG-2 TS (.mpeg) file isn't playing in Windows 8.1.
ms.date: 03/08/2022
author: Dipesh-Choubisa
ms.author: v-dchoubisa
ms.custom: sap:Graphics and multimedia development
ms.reviewer: soshogoh
ms.technology: windows-dev-apps-graphics-multimedia-dev
---

# AAC audio isn't playing for MPEG-2 TS (.mpeg) file in Windows 8.1

This article helps you fix the issue when an MPEG-2 file is unable to play AAC audio in Windows 8.1.

_Applies to:_ &nbsp; Windows 8.1

## Symptoms

You're playing an MPEG-2 (.ts) file in Windows 8.1 by using Windows Media Player or Media Foundation application. However, the Advanced Audio Coding (AAC) audio of the file isn't playing correctly. You may observe a noise with the AAC audio while playing an MPEG-2 Transport Stream (TS) file in Windows 8.1.
If you play the same (.aac) audio in the MP4 container, the audio plays as expected.

> [!NOTE]
> This problem does not occur in Windows 10 and Windows 11.

## Cause

With the release of Windows 8.1, MPEG-2 parser library was updated to stream AAC audio in certain container formats such as Audio Data Transport Stream (ADTS), Low Overhead Audio Stream (LOAS), and Low Overhead Audio Transport Multiplex (LATM). If the AAC audio in your MPEG-2 TS file isn't the supported format, this problem occurs.

## Workarounds

> [!IMPORTANT]
> The support for Windows 8.1 is in extended phase and Microsoft may not provide hotfix for this problem. We recommend upgrading to Windows 11 or Windows 10.

Follow any of these workarounds to fix the issue in Windows 8.1.

1. Save your (.mpeg) file as an MP4 file. The AAC audio will stream normal in Windows 8.1.

1. If you're using the LATM or LOAS encapsulation of MPEG-2 TS file, switch to raw AAC audio formats. For example, use the .aac or .adts file extension that contains AAC elementary streams with the ADTS frame headers to play audio.

1. If the audio files are encoded by using the MPEG-2 TS encapsulation, re-encode the audio streams as MPEG-2 L1 audio to stream audio correctly in Windows 8.1.
