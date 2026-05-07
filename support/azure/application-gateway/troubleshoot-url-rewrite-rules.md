---
title: Troubleshoot rewrite rules in Azure Application Gateway
description: Troubleshoot rewrite rules in Azure Application Gateway v2. Learn to fix issues that affect regex, routing, and headers, and use logs to verify changes.
ms.date: 04/22/2026
ms.author: lalbadarneh
ms.editor: v-jsitser
ms.reviewer: giverm
ms.service: azure-application-gateway
---

# Troubleshoot rewrite rules in Azure Application Gateway

## Summary

This article helps you troubleshoot common issues that occur when you configure HTTP header and URL rewrite rules in Azure Application Gateway v2.

## Prerequisites

- Rewrite rules are available only for the Microsoft Azure Application Gateway v2 SKU (Standard_v2 and WAF_v2). If you're using the v1 SKU, we recommend that you [migrate to v2](/azure/application-gateway/migrate-v1-v2).
- You should be familiar with the concepts that are presented in [Rewrite HTTP headers and URL with Application Gateway](/azure/application-gateway/rewrite-http-headers-url).
- [Diagnostic logging](/azure/application-gateway/application-gateway-diagnostics#diagnostic-logging) must be enabled for your application gateway so that you can verify rewrite behavior by using access logs.

### Symptom 1: Rewrite rule doesn't take effect

You configured a rewrite rule, but requests and responses pass through Application Gateway without any modification.

### Cause 1: Rewrite rule set is attached to the wrong scope

When you use a path-based routing rule, you can attach rewrite rule sets at two levels:

- The URL path map default back end. This level applies only when no path rule matches.
- Individual path rules (for example, `/api/*`, `/images/*`). This level applies when the specific path matches.

A common mistake is to attach the rewrite rule set only to the default back end while a catch-all path rule such as `/*` exists. Because `/*` matches all incoming requests, traffic never falls through to the default back end, and the rewrite rule never runs.

### Solution

To make sure that the rewrite rule set is attached to the correct scope, follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to your Application Gateway, and select **Rewrites**.
1. Verify which routing rule or path rule the rewrite rule set is associated with.
1. If you use a path-based routing rule that uses a catch-all path such as `/*`, attach the rewrite rule set directly to that path rule instead of (or in addition to) the default back end.

### Cause 2: Rewrite rules aren't supported on redirect configurations

Rewrite rules don't run if the routing rule or path rule is configured to use a redirect action instead of a back-end pool. This behavior is a [known limitation](/azure/application-gateway/rewrite-http-headers-url#limitations).

### Solution

If you need both rewrite and redirect behavior, consider using the rewrite rule itself to set a `Location` response header and return a redirect status code from the back end instead of using the Application Gateway's built-in redirect feature.

## Symptom 2: Regex condition doesn't match expected requests

The rewrite rule is correctly attached, but the condition you configured doesn't match incoming requests. Therefore, the rewrite action is skipped.

### Cause 1: Leading or trailing spaces in the regex pattern

A common but hard-to-spot mistake is having extra white space in the regex pattern. For example, consider a condition to match the `Origin` header for Cross-Origin Resource Sharing (CORS), as in the following example:

- ❌ `( ^https://mysite\.com$)` - Leading space before `^` prevents the pattern from matching.
- ✅ `(^https://mysite\.com$)` - Correct pattern without leading space produces a match.

The Azure portal input fields might not visually highlight leading or trailing spaces. This condition makes this issue difficult to detect.

### Solution

To verify and correct any leading or trailing spaces in your regex pattern, follow these steps:

1. Copy the regex pattern from your rewrite rule configuration.
1. Paste it into a regex testing tool, such as [regex101.com](https://regex101.com/) to validate the pattern.
1. Trim any leading or trailing spaces from the pattern.
1. If you configure rewrite rules through Azure Resource Manager templates, Azure CLI, or Azure PowerShell, inspect the raw `JSON` for extra white space.

### Cause 2: Using literal characters instead of regex metacharacters

When you match dynamic values such as port numbers or IP addresses, make sure that you use regex metacharacters instead of literal characters.

For example, to match a port number in a URL such as `https://mysite.com:8443/path`:

- ❌ `(https://mysite\.com):dddd(.*)` - `dddd` matches the literal string "dddd", not any four digits.
- ✅ `(https://mysite\.com):\d{4}(.*)` - `\d{4}` correctly matches any four-digit number.

> [!NOTE]
> If you configure rewrite rules through Resource Manager templates or REST API, remember that backslashes in regex must be escaped to work in a `JSON` string. For example, `\d{4}` becomes `\\d{4}` in a JSON string.

### Solution

Use proper regex syntax for character classes, as in the following table.

| Intent | Correct regex | Common mistake |
|---|---|---|
| Match any digit | `\d` or `[0-9]` | `d` (literal) |
| Match any word character | `\w` or `[a-zA-Z0-9_]` | `w` (literal) |
| Match any character | `.` | (none) |
| Match a literal dot | `\.` | `.` (matches anything) |

### Cause 3: Missing capture groups in the condition

If your rewrite action references a captured value (for example, `{http_resp_Set-Cookie_1}`), but your condition regex doesn't contain *capture groups* (in parentheses), the referenced variable is empty.

For example, to append `SameSite=Strict` to a `Set-Cookie` response header, refer to the following rewrite condition and action:

- ❌ Condition pattern: `.*` - No capture group. Therefore, `{http_resp_Set-Cookie_1}` is empty.
- ✅ Condition pattern: `(.*)` - Captures the full cookie value into group 1.

### Solution

To make sure that your capture groups are correctly configured, follow these steps:

1. Make sure that your condition regex includes parentheses, `()`, around the portion that you want to capture.
2. Reference the captured value by using `{variable_name_N}`, where `N` is the capture group number (starting from 1).
3. To verify that the capture groups work, test the regex with your expected input at [regex101.com](https://regex101.com/).

> [!TIP]
> A quick way to verify: If your action value contains `_1}`, `_2}`, and so on, check that your condition regex has at least that many pairs of parentheses.

## Symptom 3: Server variable returns empty or unexpected value

Your rewrite action uses a [server variable](/azure/application-gateway/rewrite-http-headers-url#server-variables), but the resulting header or URL contains an empty string or an unexpected value.

### Cause 1: Using the wrong server variable name

Application Gateway provides multiple server variables that look similar but serve different purposes, such as in the following table.

| Variable | Value | Example for `https://contoso.com/app/hello?id=1` |
|---|---|---|
| `{var_uri_path}` | URL path only | `/app/hello` |
| `{var_request_uri}` | Full URI with query string | `/app/hello?id=1` |
| `{var_host}` | Host header value | `contoso.com` |

A common mistake is using `{var_request_uri}` when you need only the path (that unexpectedly includes the query string), or vice versa.

### Solution

To make sure that you're using the correct server variable, follow these steps:

1. Review the [full list of supported server variables](/azure/application-gateway/rewrite-http-headers-url#server-variables).
1. Verify that the variable that you chose returns the expected component of the request.
1. To verify the actual values, use the Application Gateway [access logs](#how-to-verify-rewrite-behavior-using-access-logs).

### Cause 2: Double slash from variable concatenation

When you build a URL path by using server variables, be aware that `{var_uri_path}` already includes a leading forward slash, `/`. Concatenating it to create a prefix that ends in a slash, `/`, produces a double slash, `//`.

For example, to prepend `/apim` to the original path, refer to the following action values:

- ❌ Action value: `/apim/{var_uri_path}` - Produces `/apim//original-path` because `{var_uri_path}` is `/original-path`.
- ✅ Action value: `/apim{var_uri_path}` - Produces `/apim/original-path`.

### Solution

When you concatenate server variables into a URL path, don't add a trailing slash before a variable that already starts in one.

## Symptom 4: URL is rewritten correctly but traffic routes to the wrong back-end pool

The URL path is modified as expected. However, the request is still sent to the original back-end pool instead of the back-end pool that's associated with the rewritten path.

### Cause 3: Re-evaluate path map isn't enabled

By default, a URL rewrite modifies the path but doesn't re-evaluate the path map. The request continues to route to the back-end pool that's determined by the original URL. To route based on the rewritten URL, you have to enable the **Re-evaluate path map** option on the rewrite rule.

### Solution

To enable **Re-evaluate path map** for your rewrite rule, follow these steps:

1. In the Azure portal, go to **Rewrites**, select your rewrite rule set, and then select the rule.
2. In the action section, select the **Re-evaluate path map** checkbox.
3. Select **Save**, and wait for the configuration update to finish.

> [!CAUTION]
> Infinite loop risk: If the rewritten URL matches the same path rule that triggers the rewrite, and **Re-evaluate path map** is enabled, an infinite evaluation loop occurs. Application Gateway detects this condition, and returns a **500** error to the client. To prevent this condition, take the following actions:
> - Use a conditional rewrite to avoid matching already-rewritten URLs.
> - Make sure that the rewritten path maps to a different path rule than the one that triggered the rewrite.

## Symptom 5: Response header rewrite doesn't appear in the response

You configured a rewrite rule to add or modify a response header, but the header is missing or unchanged when the client receives the response.

### Cause 1: Header name contains unsupported characters

Application Gateway v2 allows only alphanumeric characters and hyphens in request header names. Headers that include other characters (such as periods, `.`, or underscores, `_`) are silently dropped.

For example, a custom header that's named `X-Custom.Header` or `X_Custom_Header` in the request is stripped by Application Gateway before it reaches the back end.

> [!NOTE]
> This behavior applies to request headers that are forwarded to the back end. It's documented in the [Application Gateway FAQ](/azure/application-gateway/application-gateway-faq#are-characters-allowed-in-the-header-names).

### Solution

Rename custom headers to use only alphanumeric characters and hyphens. For example, use `X-Custom-Header` instead of `X-Custom.Header`.

### Cause 2: Back-end server overrides the header

If both Application Gateway and the back-end application set the same response header, the back end's value may override the value that's set by the rewrite rule, depending on the order of processing.

### Solution

To determine whether the back end is overriding the header that's set by Application Gateway, follow these steps:

1. Use the [access logs](#how-to-verify-rewrite-behavior-using-access-logs) to verify whether Application Gateway applied the rewrite.
2. Check whether the back-end application also sets the same header.
3. If both applications set the header, consider using a different header name or coordinating with the back-end team to remove the duplicate.

### Cause 3: Response is generated by Application Gateway itself

Rewrite rules don't apply to **4xx and 5xx error responses** that Application Gateway generates internally (for example, "502 Bad Gateway" when the back end is unreachable, or "403" from WAF). These responses bypass the rewrite pipeline.

This behavior is a [known limitation](/azure/application-gateway/rewrite-http-headers-url#limitations).

### Solution

For error responses that are generated by Application Gateway, consider using the [custom error pages](/azure/application-gateway/custom-error) feature instead of rewrite rules.

## How to verify rewrite behavior using access logs

Application Gateway access logs provide two key fields for verifying URL rewrites, as shown in the following table.

| Field | Description |
|---|---|
| `originalRequestUriWithArgs` | The original URL as received from the client |
| `requestUri` | The URL after rewrite rules are applied |

If both fields show the same value, the rewrite rule didn't run or didn't match.

### Step 1: Enable diagnostic logging

If diagnostic settings aren't already enabled, configure the settings to send **ApplicationGatewayAccessLog** to a Log Analytics workspace. For more information, see [Application Gateway diagnostics](/azure/application-gateway/application-gateway-diagnostics#diagnostic-logging).

### Step 2: Query access logs

To compare original and rewritten URLs, run the following Kusto query in your Log Analytics workspace:

```kusto
AzureDiagnostics
| where ResourceType == "APPLICATIONGATEWAYS"
| where Category == "ApplicationGatewayAccessLog"
| where TimeGenerated > ago(1h)
| project TimeGenerated, 
          originalRequestUriWithArgs_s, 
          requestUri_s, 
          httpMethod_s,
          host_s,
          clientIP_s,
          httpStatus_d
| where originalRequestUriWithArgs_s != requestUri_s
| order by TimeGenerated desc
```

If the query returns no results, this situation confirms that no rewrite rule was applied during the time range.

### Step 3: Verify response headers

To verify response header rewrites, use `curl` and the following verbose output:

```bash
curl -v https://your-appgw-url/path
```

To verify that the expected header is present and has the correct value, examine the response headers in the output.

## References

- [Rewrite HTTP headers and URL with Application Gateway](/azure/application-gateway/rewrite-http-headers-url)
- [Rewrite HTTP headers and URL - Azure portal](/azure/application-gateway/rewrite-http-headers-portal)
- [Rewrite HTTP headers and URL - Azure PowerShell](/azure/application-gateway/rewrite-url-portal)
- [Troubleshoot backend health issues in Application Gateway](/troubleshoot/azure/application-gateway/application-gateway-backend-health-troubleshooting)
- [Application Gateway FAQ](/azure/application-gateway/application-gateway-faq)
