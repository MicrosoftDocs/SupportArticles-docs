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

After you AI-enable your Cloud PC, background processes might run for 24-48 hours before the supported AI features are ready to use.

If AI-enabled features aren't available after this time, restart your Cloud PC and check for Windows updates.

## Sparkles missing from Windows search box after you install a Windows update

After you install a Windows update, the sparkles might disappear from the magnifying glass icon.

To restore the icon, select the Windows search box. If the sparkles are still missing, restart your Cloud PC.

## AI features missing after you install a Windows update

After you install a Windows update, AI features might not be available.

To restore all AI-enabled features, restart your Cloud PC.

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

## Click‑to‑Do keyboard shortcut may not work in certain scenarios

In some environments, the Click‑to‑Do keyboard shortcut may not launch the Click‑to‑Do experience as expected. 

This can occur when:
- Using a Cloud PC in Windowed mode
- Accessing a Cloud PC from the Mac Client

You can still use Click‑to‑Do by manually launching it from the Start menu. Select Start, search for Click‑to‑Do, and open the app from search results.

## Thumbnail previews may not appear in search result

In some cases, thumbnail previews may not appear for files returned in AI‑enabled search experiences on Cloud PCs. This issue may occur when system performance settings are configured to display icons instead of thumbnails.

**Workaround: **
To restore thumbnail previews:
1. Select **Start** and Open **Settings.**

1. Go to **System > Performance.** 
1. Select **Visual Effects**. 

1. Turn on **Show thumbnails instead of icons**.
1. Restart your Cloud PC.

## Additional help for AI-enabled Cloud PC issues

If you're experiencing issues that aren't covered in this article, you can contact Microsoft Support by submitting a support request through the Microsoft 365 admin center. [Get support – Microsoft 365 admin](/microsoft-365/admin/get-help-support?view=o365-worldwide)
