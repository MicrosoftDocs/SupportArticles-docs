---
title: Teams Rooms on Android switches from Large Gallery to Gallery after content sharing stops
description: Learn why Microsoft Teams Rooms on Android returns to Gallery view after content sharing ends in a Teams meeting.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams, Microsoft Teams Rooms for Android
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/17/2026
---

# Teams Rooms on Android switches from Large Gallery to Gallery after content sharing stops

## Summary

This article explains why Microsoft Teams Rooms on Android returns from Large Gallery view to Gallery view after someone stops sharing content in a Microsoft Teams meeting.

## Symptoms

During a Teams meeting on a Microsoft Teams Rooms on Android device, you set the meeting layout to Large Gallery.

When someone starts sharing content, the room display changes to a content-sharing layout.

After content sharing stops, the device returns to Gallery view instead of returning to Large Gallery view.

## Cause

This behavior is expected.

When content sharing starts, the layout switches to Content + people, which is a sub-layout of Gallery. After content sharing stops, the device returns to the parent Gallery layout.

## Resolution

If you want to continue using Large Gallery after content sharing stops, manually switch the meeting layout back to Large Gallery on the Teams Rooms on Android device.

## More information

This behavior is currently expected on Microsoft Teams Rooms on Android.
