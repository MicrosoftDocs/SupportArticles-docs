---
title: Format message strings by EvtFormatMessage
description: This article discusses obtaining formatted strings associated with an event using EvtFormatMessage and handling errors that may occur if the formatted strings can't be retrieved.
ms.date: 04/29/2020
ms.custom: sap:System services development
ms.reviewer: davean, franki
ms.technology: windows-dev-apps-system-services-dev
---
# Use EvtFormatMessage to obtain formatted strings for an event

This article discusses obtaining formatted strings for an event by using `EvtFormatMessage` and handling errors that may occur if the formatted strings can't be retrieved.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 2435556

## Message strings that EvtFormatMessage can get from an event

An event can contain localized message strings that you can format for display. To get a message string from the event, call the `EvtFormatMessage` function. An event can contain the following message strings:

- A message string for the event itself.
- A message string that describes the level value assigned to the event.
- A message string that describes the task value assigned to the event.
- A message string that describes the opcode value assigned to the event.
- A message string that describes the keyword values assigned to the event.
- A message string that describes the channel value assigned to the event.

In order for `EvtFormatMessage` to format the requested text, the metadata provider associated with the event must be available and contains metadata for the specified event. The `EvtFormatMessage` function may fail if the metadata provider is not available or if metadata is not available for the specified event.

## How to handle errors when formatted strings can't be retrieved

A sample application that demonstrates using the `EvtFormatMessage` function is included in [Formatting Event Messages](/windows/win32/wes/formatting-event-messages). The sample demonstrates handling the errors that may occur when there's no metadata available for the specified event (`ERROR_EVT_MESSAGE_NOT_FOUND`) or the event ID can't be found (`ERROR_EVT_MESSAGE_ID_NOT_FOUND`), but doesn't provide any implementation for handling the errors.

The calling application defines the strings that are displayed, if any, when a call to `EvtFormatMessage` fails to retrieve the requested message string. For example, Windows Event Viewer on English systems displays **None** when `EvtFormatMessage` fails to retrieve the task value assigned to the event when the task ID is zero or the task ID in parenthesis when the task ID is non-zero. The Eventing Command Line Utility (wevtutil.exe) displays **N/A** when `EvtFormatMessage` fails to retrieve the task value assigned to the event.
