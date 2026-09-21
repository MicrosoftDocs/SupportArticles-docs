---
title: Invoke Web Service Proxy Authentication Errors
description: Troubleshoot 407 proxy authentication errors in the Invoke web service action by testing its User-Agent value without weakening security controls.
ms.reviewer: smurkute, ekoulaxis
ms.date: 09/18/2026
ms.custom: sap:Desktop flows\PAD Runtime - Action execution (not browser or UI)
ai-usage: ai-assisted
---

# Invoke web service action fails with a proxy authentication error

_Applies to:_ &nbsp; Power Automate for desktop

## Summary

The [Invoke web service](/power-automate/desktop-flows/actions-reference/web#invokewebservicebase) action in Power Automate for desktop can fail with a **407 Proxy Authentication Required** error while an equivalent request succeeds from a browser or another HTTP client on the same machine. This article covers one specific cause of that error: a proxy rule that inspects the action's default **User agent** value, which identifies a `Firefox/3.6` browser. It provides a controlled test that helps you isolate that value as a factor, without weakening proxy authentication or certificate validation.

Before you run the test, verify that Power Automate for desktop is configured to send any credentials that your proxy requires. For static proxy, PAC script, and proxy credential guidance, see [Configure proxy settings for Power Automate for desktop](/power-automate/desktop-flows/how-to/proxy-settings).

## Symptoms

The **Invoke web service** action fails with a proxy-related error, such as **407 Proxy Authentication Required**, but an equivalent request succeeds from a browser or another HTTP client on the same machine.

## Cause

This article addresses one specific cause of that error: a proxy rule that inspects the action's default **User agent** value.

Different clients can send different HTTP headers. The default **User agent** value of the **Invoke web service** action includes `Firefox/3.6`, which identifies a browser version that's many years old. In some proxy environments, rules that inspect or restrict User-Agent values can reject a request that contains this value.

## Workaround

To isolate the **User agent** value as a factor in the failure, follow these steps in a test flow with your network administrator's approval:

1. Open the **Invoke web service** action and expand **Advanced**.
1. Record the current **User agent** value.
1. Clear the **User agent** field, and then save the action. Keep all other request settings unchanged.
1. Rerun a request that's safe to repeat.
1. Check the **StatusCode** and **WebServiceResponse** variables to confirm that the request returns the expected response. Don't rely only on the action completing.

If the request succeeds, ask your network administrator to review the proxy logs and confirm which rule rejected the original request. Confirm the appropriate User-Agent configuration before you apply the change in production.

If the request still fails, restore the original value and continue investigating the proxy configuration and authentication requirements. To review the proxy configuration options for each Power Automate for desktop component, see [Configure proxy settings for Power Automate for desktop](/power-automate/desktop-flows/how-to/proxy-settings).

> [!IMPORTANT]
> Clearing **User agent** doesn't resolve every proxy error and doesn't replace required proxy credentials. Some services require a User-Agent value. Keep required proxy authentication and certificate-validation controls in place.
