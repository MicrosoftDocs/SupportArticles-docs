---
title: Fix Copilot Chat loading issues in Edge Sidebar
description: If Copilot Chat isn't loading in the Microsoft Edge sidebar, use these targeted troubleshooting steps to diagnose blank panes, sign-in prompts, and policy-related failures.
ms.date: 04/01/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Experiences and Services\AI Experiences: Copilot and Sidebar'
---

# Troubleshoot Copilot Chat loading problems in the Microsoft Edge sidebar

## Summary

This article helps you troubleshoot [Copilot Chat](/copilot/edge) loading problems in the Microsoft Edge sidebar. Follow this guidance if the Copilot pane opens but shows a blank page, displays a "Refresh," "Sign in," or "Try again" prompt, or if Copilot Chat doesn't load in environments that use the [EdgeSidebarAppUrlHostBlockList](/deployedge/microsoft-edge-browser-policies/edgesidebarappurlhostblocklist) policy.

These troubleshooting checks cover account and platform eligibility, service connectivity, authentication state, and allow list requirements for policy-controlled environments.

If the Copilot icon is missing entirely, see [Copilot icon doesn't appear in Microsoft Edge sidebar](copilot-icon-missing-sidebar.md).

## Symptoms

You experience one or more of the following problems in Edge:

- [The Copilot icon appears, but selecting the icon displays a blank pane](#copilot-pane-shows-a-blank-pane-error-or-refresh-button).
- [The Copilot pane displays an error message that includes a Refresh button](#copilot-pane-shows-a-blank-pane-error-or-refresh-button).
- [The Copilot pane displays a Sign in or Try again button instead of loading the chat interface](#copilot-pane-shows-a-sign-in-or-try-again-button).
- [Copilot Chat doesn't load by having the EdgeSidebarAppUrlHostBlockList policy set](#copilot-chat-doesnt-load-by-having-the-edgesidebarappurlhostblocklist-policy-set).

## Solution

Verify that your account and platform meet the [requirements for Copilot](#account-and-platform-requirements-for-copilot). Then, identify the symptom that you observe, and follow the steps in the corresponding section. Multiple sections might apply. Work through each relevant section.

### Account and platform requirements for Copilot

Copilot in Edge has account-type, region, and platform prerequisites. If your profile doesn't meet these conditions, the Copilot icon is hidden or Copilot Chat doesn't load.

- **Account type and region**: See [Verify regional availability and account type](copilot-icon-missing-sidebar.md#verify-regional-availability-and-account-type) for details.

- **Platform**: The Copilot sidebar requires a desktop edition of Windows (Home, Pro, or Enterprise). Non-desktop SKUs, such as Xbox, aren't supported. Copilot isn't available in PWA or Web App windows.

- **Age group**: Verify that the age group of the signed-in account isn't classified as "Child." Child accounts can't use Copilot.

### Copilot pane shows a blank pane, error, or Refresh button

If the Copilot icon appears, but the sidebar shows a blank pane, an error message, or a **Refresh** button, the Copilot Chat service endpoint might be unreachable.

1. Verify that the device has an active internet connection. If the device is offline, the Copilot pane displays a "No internet" splash screen, and it auto-recovers when connectivity is restored.

1. Check that the Copilot Chat service endpoint is reachable. Consumer accounts use `https://edgeservices.bing.com/edgesvc/shell`. Enterprise or commercial profiles use a configurable MetaOS App Service endpoint. To test connectivity, open a browser tab on the affected device, and go to the endpoint URL. If the page doesn't load, a network issue or firewall rule might be blocking access.

1. If the endpoint is reachable, but Copilot Chat still doesn't load after several retries, the service might be experiencing an outage. Check the [Microsoft 365 Service health status](https://status.cloud.microsoft/) page for outage reports, and retry later.

> [!NOTE]
> After the initial load, the Copilot Chat service sends periodic heartbeat signals approximately every 15 seconds. If no heartbeat is received within the expected interval, the Copilot pane automatically refreshes to recover from a stale or crashed state.

### Copilot pane shows a Sign in or Try again button

If the Copilot pane displays a **Sign in** or **Try again** button, the browser can't get a valid authentication token for the signed-in profile.

1. If you see a **Sign in** button, select it, and complete the sign-in flow.

1. If you see a **Try again** button, authentication failed for a different reason. Follow these steps:
   1. Sign out and sign back in to the Edge profile.
   1. For enterprise (Entra ID) profiles, check that the Bing AAD enrollment cookie is present. If this cookie is missing or changed, the Copilot pane performs a full refresh.

1. If you recently signed in or out, or switched accounts, the Copilot pane should automatically perform a full refresh to re-establish authentication context. If it doesn't, close and reopen the sidebar.

### Copilot Chat doesn't load by having the EdgeSidebarAppUrlHostBlockList policy set

If your environment uses the [EdgeSidebarAppUrlHostBlockList](/deployedge/microsoft-edge-browser-policies/edgesidebarappurlhostblocklist) policy with a wildcard value (`*`) and the [EdgeSidebarAppUrlHostAllowList](/deployedge/microsoft-edge-browser-policies/edgesidebarappurlhostallowlist) policy to selectively allow specific sidebar apps, the allow list must include the internal URLs that Copilot Chat uses. The required URLs changed in Edge 146:

- **Edge 145 and earlier**:  Copilot Chat can load if  `edge://hub-app-store` and `edge://discover-chat` is allowed in the allow list.
- **Edge 146 and later**: Copilot Chat uses two additional internal URLs (`edge://commercial-copilot-chat` and `chrome-untrusted://commercial-copilot-chat`). If these URLs aren't in the allow list, the wildcard block rule prevents Copilot Chat from loading.

To resolve the problem:

1. Open `edge://policy` and check the current values of [EdgeSidebarAppUrlHostBlockList](/deployedge/microsoft-edge-browser-policies/edgesidebarappurlhostblocklist) and [EdgeSidebarAppUrlHostAllowList](/deployedge/microsoft-edge-browser-policies/edgesidebarappurlhostallowlist).

1. If you set [EdgeSidebarAppUrlHostBlockList](/deployedge/microsoft-edge-browser-policies/edgesidebarappurlhostblocklist) to `*` (block all), [EdgeSidebarAppUrlHostAllowList](/deployedge/microsoft-edge-browser-policies/edgesidebarappurlhostallowlist) must contains all the following entries.

   | URL                                          | Notes                      |
   | -------------------------------------------- | -------------------------- |
   | `edge://hub-app-store`                       | Not necessary in Edge 146+ |
   | `edge://discover-chat`                       | Required in all versions   |
   | `edge://commercial-copilot-chat`             | Required in Edge 146+      |
   | `chrome-untrusted://commercial-copilot-chat` | Required in Edge 146+      |

1. If any entries are missing, add them to the [EdgeSidebarAppUrlHostAllowList](/deployedge/microsoft-edge-browser-policies/edgesidebarappurlhostallowlist) policy through Group Policy, Intune, or your mobile device management (MDM) solution.

1. After you update the policy, restart Microsoft Edge, and verify that Copilot Chat loads correctly.

## Related content

- [Configure Microsoft Edge policy settings](/deployedge/configure-microsoft-edge)
- [Manage the sidebar in Microsoft Edge](/deployedge/microsoft-edge-sidebar)
- [Microsoft Edge Enterprise endpoints](/deployedge/microsoft-edge-security-endpoints)
