---
title: WritePrinter API with RAW data can't print
description: Fail with Terminal Services Easy Print when you call to the WritePrinter() API to write RAW data directly to a printer.
ms.date: 03/09/2020
ms.custom: sap:Graphics and multimedia development
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# WritePrinter() with RAW data fails to print with TS Easy Print

This article helps you resolve the failure with Terminal Services Easy Print when you call to the `WritePrinter()` API to write RAW data directly to a printer.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 2827141

## Symptoms

Calls to the `WritePrinter()` API to write RAW data directly to a printer will fail with Terminal Services Easy Print.

## Cause

This is because the Terminal Services Easy Print feature creates an XPS document that is sent to the client, and the client must add data to this document. But XPS doesn't support RAW data, so the call will fail. This behavior is a by design limitation in the Terminal Services Easy Print feature. Terminal Services Easy Print can't be used to write RAW data to a printer.

## Resolution

Disabling Terminal Services Easy Print with the following group policy option will avoid this limitation:

`Computer Configuration\Administrative Templates\Windows Components\Remote Desktop Services\Remote Desktop Session Host\Printer Redirection\Use Terminal Services Easy Print printer driver first`
