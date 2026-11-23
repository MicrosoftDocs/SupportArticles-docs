---
title: Camera or Microphone Not Working in Microsoft Edge
description: Troubleshoot camera or microphone issues on websites in Microsoft Edge by reviewing permission layers, device conflicts, WebRTC errors, and enterprise policies.
ms.date: 09/10/2026
ms.reviewer: yejxu, dili
ms.custom: 'sap:Web Platform and Development\Graphics and Media: including WebRTC'
ai-usage: ai-assisted
---

# Camera or microphone doesn't work on websites in Microsoft Edge

## Summary

This article explains why a camera or microphone might not work on websites in Microsoft Edge, and which layer of the system controls hardware authorization. Microsoft Edge media capture access is a security and connectivity framework that manages how web applications interact with local hardware cameras and microphones. A capture request must clear operating system privacy settings, Microsoft Edge site permissions, and the hardware device driver before a website receives a stream. Device contention with apps such as Microsoft Teams or Zoom, WebRTC errors such as `NotReadableError` and `NotFoundError`, browser extensions, and enterprise policies such as `AudioCaptureAllowed` and `VideoCaptureAllowed` can also prevent devices from loading. This article describes each of these layers and the diagnostics that help isolate a media capture issue.

## Permission layers that control camera and microphone access

Media capture relies on a multi-tiered permission model to ensure user privacy. Before a website can access a system camera or microphone, it must clear three distinct authorization layers:

1. **Operating system privacy settings**: The host operating system restricts device access on a global level. Configure Windows privacy settings to allow desktop apps, including Microsoft Edge, to access the camera and microphone. For more information, see [Windows camera, microphone, and privacy](https://support.microsoft.com/windows/privacy/windows-camera-microphone-and-privacy).
1. **Microsoft Edge site permissions**: Inside Microsoft Edge, site-specific permissions define which domains can request active media pools. Users can configure permission lists inside `edge://settings/content/camera` and `edge://settings/content/microphone` to block or allow domains.
1. **Hardware driver availability**: The operating system device manager maps the active hardware connection. You need healthy, updated drivers to process WebRTC API requests.

## Device contention and concurrency

Physical media devices, such as USB webcams, generally support only one active capture stream at a time. Concurrency issues occur when a background application locks a device, preventing Microsoft Edge from initializing a stream.

Common applications that lock resources include Microsoft Teams, Zoom, and the native Windows Camera application. When a device is locked by another process, WebRTC APIs typically return error states rather than establishing a connection.

## WebRTC diagnostic errors

Microsoft Edge uses WebRTC protocols to stream media on the web. The internal diagnostics page at `edge://webrtc-internals` tracks active `getUserMedia` calls and logs structural API errors, which can help isolate device connection issues. The following table describes these errors.

| WebRTC error | What the error indicates |
|---|---|
| `NotReadableError` | The hardware device is currently locked or in use by another application. |
| `NotFoundError` | The requested device type can't be detected on the local system. |
| `OverconstrainedError` | The hardware can't meet the specific resolution or frame rate parameters that the website requests. |

## Enterprise policies that block audio and video capture

Corporate environments can enforce security baselines that override user configuration. Administrators can control browser-based media capture by using the following group policies, which are visible under `edge://policy`.

| Microsoft Edge policy | Effect on media capture |
|---|---|
| [AudioCaptureAllowed](/deployedge/microsoft-edge-policies/audiocaptureallowed) and [AudioCaptureAllowedUrls](/deployedge/microsoft-edge-policies/audiocaptureallowedurls) | These policies control whether websites can request access to audio inputs. |
| [VideoCaptureAllowed](/deployedge/microsoft-edge-policies/videocaptureallowed) and [VideoCaptureAllowedUrls](/deployedge/microsoft-edge-policies/videocaptureallowedurls) | These policies control whether websites can request access to video inputs. |

## Extension and profile isolation by using InPrivate mode

Profile corruption and conflicting developer extensions can alter how sites render media permissions. In such instances, using an InPrivate window can provide an isolated testing environment that bypasses existing extensions and uses default profile settings to isolate permission mismatches.

## Data collection for Microsoft Support

If the media capture issues continue to persist, gather the following telemetry before contacting Microsoft support.

- **Microsoft Edge version**: The browser build version from `edge://version`.
- **WebRTC event logs**: Active WebRTC event logs exported from `edge://webrtc-internals`.
- **Enterprise policies**: Current enterprise policy listings from `edge://policy`.

## Related content

- [Microsoft Edge policy reference - Permit or deny screen capture](/deployedge/microsoft-edge-policies#permit-or-deny-screen-capture)
- [Configure Microsoft Edge policy settings on Windows](/deployedge/configure-microsoft-edge)
- [Troubleshoot video playback problems in Microsoft Edge](video-playback-issues.md)
