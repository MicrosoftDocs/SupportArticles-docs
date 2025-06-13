---
title: Japanese Handwritten Characters Aren't Recognized by Microsoft.Ink.Recognizer
description: Describes an issue where Japanese handwritten characters aren't recognized using Microsoft.Ink.Recognizer on Windows 11 version 24H2 and Windows Server 2025.
ms.date: 06/11/2025
ms.reviewer: soshogoh, hirotoh, davean, v-sidong
ms.custom: sap:Desktop app UI development\User interaction (keyboard, mouse, pen and touch)
---
# Japanese handwritten characters aren't recognized using Microsoft.Ink.Recognizer

## Symptoms

When using `Microsoft.Ink.Recognizer` as the recognition engine on Windows 11 version 24H2 and Windows Server 2025, you might encounter the following issues:

- Issue 1

  The Japanese handwritten characters aren't recognized correctly.

  For example, when you handwrite Japanese `カスイ`, the result is `カイ`, which isn't expected.

- Issue 2

  When you perform character recognition with specified stroke data, the specified character range isn't correctly applied.

  For example, when you handwrite `あいう`, specify the character range as `ラ リ ル レ ロ`, and then execute handwritten character recognition, the actual result is `あいう`. However, the expected result is `ロロラ`.

## Status

Microsoft has confirmed this is a problem in Windows 11 version 24H2 and Windows Server 2025.
