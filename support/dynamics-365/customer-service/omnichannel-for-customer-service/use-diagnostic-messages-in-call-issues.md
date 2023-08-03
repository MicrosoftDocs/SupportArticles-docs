---
title: Use diagnostic messages to troubleshoot issues in voice calls
description: Learn about how to interpret the error and warning messages when you face issues on a voice call.
ms.author: araghunath
ms.reviewer: nenellim 
ms.topic: troubleshooting
ms.collection: 
ms.date: 08/03/2023
ms.custom: bap-template
---

# Use diagnostic messages to troubleshoot issues in voice calls

When your agents are in a voice call, sometimes, they might see warning and error messages on the communication panel. These messages will help them understand the issues that are affecting their call experience. The messages are informative so that the agents can self diagnose and resolve the issues themselves. For example, if agents mute their mic and speak, a message appears to let them know to remove themselves from mute.

## Troubleshoot network issues

The following table lists the warning messages that appear when your agents face network issues in their voice calls. These messages help agents diagnose the problem and take actions to resolve them. Use the network value to look up for information in Azure Communication Services.

| Message| Description| Network value |
| -------- | -------- |-----------|
|  Your network is causing poor call quality. Try switching to a better network, or moving closer to a WiFi access point.  | Appears when the network connection is lost and the system tries to reconnect to the network.  | networkReconnect |
| Your network is causing poor call quality. Try switching to a better network, or moving closer to a WiFi access point.  | Appears when the incoming streaming quality is poor.  | networkReceiveQuality |
| Your network is causing poor call quality. Try switching to a better network, or moving closer to a WiFi access point  | Appears when the outgoing streaming quality is poor. | networkSendQuality |

## Troubleshoot device issues

The following table lists the messages that appear when your agents face issues with their audio device in the voice calls. Your agents can use the information to take actions and resolve the problem. Use the audio value to look up for information in Azure Communication Services.

| Message| Description| Audio value |
| -------- | -------- |-----------|
| No speakers detected. Try connecting one to receive call audio. | Appears when audio output device or speaker isn't detected on the user's system.  | noSpeakerDevicesEnumerated |
| You are muted.  | Appears when the agent is speaking while on mute. | speakingWhileMicrophoneIsMuted |
| No microphone detected. Try connecting one so that others can hear you. | Appears when a microphone isn't detected on the agent’s system.  | noMicrophoneDevicesEnumerated |
|Your microphone is not working. Connect to a different device or try reconnecting this one. | Appears when microphone is muted unexpectedly or stops working.  | microphoneMuteUnexpectedly |

### See also

[Azure Communication Services user-facing diagnostics](/azure/communication-services/concepts/voice-video-calling/user-facing-diagnostics)  
[How to avoid calls from being disconnected](/customer-service/voice-channel-agent-experience#how-to-avoid-call-disconnection)
