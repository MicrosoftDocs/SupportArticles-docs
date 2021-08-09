---
title: Playback of protected video content fails
description: This article provides a resolution for the problem that occurs when you attempt to play a video containing DRM-protected content.
ms.date: 01/04/2021
ms.prod-support-area-path: 
ms.reviewer: jebishop
ms.topic: troubleshooting
---
# Playback of protected video content can fail and cause an error message to be returned

This article helps you resolve the problem that occurs when you attempt to play a video containing DRM-protected content.

_Applies to:_ &nbsp; Silverlight  
_Original KB number:_ &nbsp; 2477822

## Summary

In some cases, attempting to play a video containing DRM-protected content can occasionally fail and cause an error message to be returned.

Attempting to use Silverlight 4 or earlier to play a video that is DRM-protected can result in playback failing with an error. The failure is not machine configuration or locale dependent. Types of content that can result in playback failure is also unpredictable.

## Cause

This is due to an issue affecting the Silverlight runtime caused by a failure during license acquisition.

## Resolution

This issue has been corrected and the fix will be included in the next Silverlight 4 servicing release. Additionally, the error can be resolved by closing all open browser windows, then restarting the application and attempting to play the video again.
