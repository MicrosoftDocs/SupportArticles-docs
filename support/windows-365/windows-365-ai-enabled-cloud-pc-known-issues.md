---
title: AI-enabled Cloud PC Known Issues
description: Describes how to resolve issues that are known to affect AI-enabled Cloud PCs
manager: dcscontentpm
ms.date: 02/12/2026
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:Configuration and Management
- pcy:WinComm User Experience
appliesto:
- ✅ <a href=https://learn.microsoft.com/lifecycle/products/windows-365target=_blank>Supported versions of Windows 365</a>
---

# AI-enabled Cloud PC known issues

If your Cloud PC isn't working correctly, first make sure that you've satisfied all the [minimum requirements for artificial intelligence (AI) features](/windows-365/enterprise/ai-enabled-cloud-pcs#requirements). If your account and your device meet those requirements, review the following topics to learn whether your issue is documented.

## AI-enabled status activation time

After you AI-enable your Cloud PC, background processes might run for up to 48 hours before the supported AI features are ready to use.

## Sparkles missing from Windows search box after you install a Windows update

After you install a Windows update, the sparkles might disappear from the magnifying glass icon.

To restore the icon, select the Windows search box. If the sparkles are still missing, restart your Cloud PC.

## AI features missing after you install a Windows update

After you install a Windows update, AI features might not be available.

To restore all AI-enabled features, restart your Cloud PC.

## "Click to Do" mouse cursor appears to lag

While you use Click to Do, or after you dismiss the Click to Do feature, your Cloud PC cursor might appear to lag.

To restore the cursor's responsiveness, restart your Cloud PC.

## Semantic Search results don't appear in the Windows search "All" tab

Search results might take time to load in the **All** tab of the Windows search box.

If search results don't appear on your first search attempt, repeat the search. You might have to repeat the search multiple times to see the full results.

## Semantic File Search doesn't work on a Cloud PC that uses nested virtualization

If Semantic File Search isn't working, make sure that the Cloud PC doesn't use nested virtualization.

To check this setting, and disable it if it's necessary, follow these steps:

1. Press Windows logo key+R, and then enter **control panel**.

1. In the Control Panel search bar, enter **Turn Windows features on or off**.

1. Make sure that the following features aren't selected. If any of them are selected, clear their checkboxes.

   - Virtual Machine Platform
   - Windows Hypervisor Platform
   - Hyper-V
   - Hyper-V Management Tools
   - Hyper-V GUI Management Tools
   - Hyper-V Module for Windows PowerShell
   - Hyper-V Platform
   - Hyper-V Hypervisor
   - Hyper-V Services

1. To apply the changes, select **OK**, and then restart your Cloud PC.

## Click to Do doesn't work when Cloud PC is in windowed mode

Click to Do might not work if your Cloud PC isn't in full-screen mode. Try maximizing your Cloud PC window (to full screen) before you use Click to Do.

## Additional help for AI-enabled Cloud PC issues

For issues that aren't covered by this article, Windows Insider Program members can go to [Get more help](/windows-insider/troubleshooting#get-more-help) in the Windows Insider Program "Troubleshooting" article.
