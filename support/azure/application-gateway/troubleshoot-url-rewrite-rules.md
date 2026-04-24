---
title: Troubleshoot rewrite rules in Azure Application Gateway
description: Helps troubleshoot common issues with HTTP header and URL rewrite rules in Azure Application Gateway v2.
ms.date: 04/22/2026
ms.service: azure-application-gateway
ms.reviewer: 
---

# Troubleshoot rewrite rules in Azure Application Gateway

This article helps you troubleshoot common issues when configuring HTTP header and URL rewrite rules in Azure Application Gateway v2.

## Prerequisites

- Rewrite rules are only available on the **Application Gateway v2 SKU** (Standard_v2 and WAF_v2). If you use the v1 SKU, [migrate to v2](/azure/application-gateway/migrate-v1-v2) first.
- You're familiar with the concepts in [Rewrite HTTP headers and URL with Application Gateway](/azure/application-gateway/rewrite-http-headers-url).
- [Diagnostic logging](/azure/application-gateway/application-gateway-diagnostics#diagnostic-logging) is enabled for your Application Gateway so you can verify rewrite behavior using access logs.

## Symptom 1: Rewrite rule doesn't take effect

You've configured a rewrite rule, but requests and responses pass through Application Gateway without any modification.

### Cause 1: Rewrite rule set is attached to the wrong scope

When you use a **path-based routing rule**, you can attach rewrite rule sets at two levels:

- The **URL path map default** backend: applies only when no path rule matches.
- Individual **path rules** (for example, `/api/*`, `/images/*`): applies when the specific path matches.

A common mistake is attaching the rewrite rule set only to the **default** backend while a catch-all path rule such as `/*` exists. Because `/*` matches all incoming requests, traffic never falls through to the default backend, and the rewrite rule never executes.

**Resolution:**

1. In the Azure portal, navigate to your Application Gateway and select **Rewrites**.
2. Verify which routing rule or path rule the rewrite rule set is associated with.
3. If you use a path-based routing rule with a catch-all path like `/*`, attach the rewrite rule set directly to that path rule instead of (or in addition to) the default backend.

:::image type="content" source="./screenshot1-rule attachment.png


### Cause 2: Rewrite rules aren't supported on redirect configurations

Rewrite rules don't execute when the routing rule or path rule is configured to use a **redirect** action instead of a backend pool. This is a [known limitation](/azure/application-gateway/rewrite-http-headers-url#limitations).

**Resolution:**

If you need both rewrite and redirect behavior, consider using the rewrite rule itself to set a `Location` response header and return a redirect status code from the backend, rather than using the Application Gateway's built-in redirect feature.

## Symptom 2: Regex condition doesn't match expected requests

The rewrite rule is correctly attached, but the condition you configured doesn't match incoming requests, so the rewrite action is skipped.

### Cause 1: Leading or trailing spaces in the regex pattern

A common but hard-to-spot mistake is having extra whitespace in the regex pattern. For example, consider a condition to match the `Origin` header for CORS:

- ❌ `( ^https://mysite\.com$)` — leading space before `^` causes the pattern to never match.
- ✅ `(^https://mysite\.com$)` — correct pattern without leading space.

The Azure portal input fields may not visually highlight leading or trailing spaces, making this issue difficult to detect.

**Resolution:**

1. Copy the regex pattern from your rewrite rule configuration.
2. Paste it into a regex testing tool such as [regex101.com](https://regex101.com/) to validate the pattern.
3. Trim any leading or trailing spaces from the pattern.
4. If you configure rewrite rules through ARM templates, Azure CLI, or PowerShell, inspect the raw JSON for extra whitespace.

### Cause 2: Using literal characters instead of regex metacharacters

When matching dynamic values such as port numbers or IP addresses, make sure you use regex metacharacters instead of literal characters.

For example, to match a port number in a URL like `https://mysite.com:8443/path`:

- ❌ `(https://mysite\.com):dddd(.*)` — `dddd` matches the literal string "dddd", not four digits.
- ✅ `(https://mysite\.com):\d{4}(.*)` — `\d{4}` correctly matches any four-digit number.

> [!NOTE]
> If you configure rewrite rules through ARM templates or REST API, remember that backslashes in regex must be escaped for JSON. For example, `\d{4}` becomes `\\d{4}` in a JSON string.

**Resolution:**

Use proper regex syntax for character classes:

| Intent | Correct regex | Common mistake |
|---|---|---|
| Match any digit | `\d` or `[0-9]` | `d` (literal) |
| Match any word character | `\w` or `[a-zA-Z0-9_]` | `w` (literal) |
| Match any character | `.` | (none) |
| Match a literal dot | `\.` | `.` (matches anything) |

### Cause 3: Missing capture groups in the condition

If your rewrite action references a captured value (for example, `{http_resp_Set-Cookie_1}`), but your condition regex doesn't contain **capture groups** (parentheses), the referenced variable is empty.

For example, to append `SameSite=Strict` to a `Set-Cookie` response header:

- ❌ Condition pattern: `.*` — no capture group, so `{http_resp_Set-Cookie_1}` is empty.
- ✅ Condition pattern: `(.*)` — captures the full cookie value into group 1.

**Resolution:**

1. Ensure your condition regex includes parentheses `()` around the portion you want to capture.
2. Reference the captured value using `{variable_name_N}` where `N` is the capture group number (starting from 1).
3. Test the regex with your expected input at [regex101.com](https://regex101.com/) to confirm the capture groups work.

> [!TIP]
> A quick way to verify: if your action value contains `_1}`, `_2}`, etc., check that your condition regex has at least that many pairs of parentheses.

## Symptom 3: Server variable returns empty or unexpected value

Your rewrite action uses a [server variable](/azure/application-gateway/rewrite-http-headers-url#server-variables), but the resulting header or URL contains an empty string or an unexpected value.

### Cause 1: Using the wrong server variable name

Application Gateway provides multiple server variables that look similar but serve different purposes:

| Variable | Value | Example for `https://contoso.com/app/hello?id=1` |
|---|---|---|
| `{var_uri_path}` | URL path only | `/app/hello` |
| `{var_request_uri}` | Full URI with query string | `/app/hello?id=1` |
| `{var_host}` | Host header value | `contoso.com` |

A common mistake is using `{var_request_uri}` when you only need the path (which includes the query string unexpectedly), or vice versa.

**Resolution:**

1. Review the [full list of supported server variables](/azure/application-gateway/rewrite-http-headers-url#server-variables).
2. Verify that the variable you chose returns the expected component of the request.
3. Use the Application Gateway [access logs](#how-to-verify-rewrite-behavior-using-access-logs) to confirm the actual values.

### Cause 2: Double slash from variable concatenation

When building a URL path using server variables, be aware that `{var_uri_path}` already includes a leading forward slash `/`. Concatenating it with a prefix that ends with `/` produces a double slash `//`.

For example, to prepend `/apim` to the original path:

- ❌ Action value: `/apim/{var_uri_path}` — produces `/apim//original-path` because `{var_uri_path}` is `/original-path`.
- ✅ Action value: `/apim{var_uri_path}` — produces `/apim/original-path`.

**Resolution:**

When concatenating server variables into a URL path, don't add a trailing slash before a variable that already starts with one.

## Symptom 4: URL is rewritten correctly but traffic routes to the wrong backend pool

The URL path is modified as expected, but the request is still sent to the original backend pool instead of the backend pool associated with the rewritten path.

### Cause: "Re-evaluate path map" isn't enabled

By default, URL rewrite modifies the path but doesn't re-evaluate the path map. The request continues to route to the backend pool determined by the **original** URL. To route based on the **rewritten** URL, you must enable the **Re-evaluate path map** option on the rewrite rule.

**Resolution:**

1. In the Azure portal, go to **Rewrites** > select your rewrite rule set > select the rule.
2. In the action section, select the **Re-evaluate path map** checkbox.
3. Select **Save** and wait for the configuration update to complete.

[TODO: screenshot - Re-evaluate path map checkbox in Portal]

> [!CAUTION]
> **Infinite loop risk:** If the rewritten URL matches the same path rule that triggers the rewrite, and **Re-evaluate path map** is enabled, an infinite evaluation loop occurs. Application Gateway detects this and returns a **500** error to the client. To prevent this:
> - Use a **conditional rewrite** to avoid matching already-rewritten URLs.
> - Ensure the rewritten path maps to a **different** path rule than the one that triggered the rewrite.

## Symptom 5: Response header rewrite doesn't appear in the response

You've configured a rewrite rule to add or modify a response header, but the header is missing or unchanged when the client receives the response.

### Cause 1: Header name contains unsupported characters

Application Gateway v2 allows only **alphanumeric characters and hyphens** in request header names. Headers with other characters (such as periods `.` or underscores `_`) are silently dropped.

For example, a custom header named `X-Custom.Header` or `X_Custom_Header` in the request is stripped by Application Gateway before reaching the backend.

> [!NOTE]
> This behavior applies to **request** headers forwarded to the backend. It's documented in the [Application Gateway FAQ](/azure/application-gateway/application-gateway-faq#are-characters-allowed-in-the-header-names).

**Resolution:**

Rename custom headers to use only alphanumeric characters and hyphens. For example, use `X-Custom-Header` instead of `X-Custom.Header`.

### Cause 2: Backend server overrides the header

If both Application Gateway and the backend application set the same response header, the backend's value may override the value set by the rewrite rule, depending on the order of processing.

**Resolution:**

1. Use the [access logs](#how-to-verify-rewrite-behavior-using-access-logs) to confirm whether Application Gateway applied the rewrite.
2. Check whether the backend application also sets the same header.
3. If both set the header, consider using a **different header name** or coordinating with the backend team to remove the duplicate.

### Cause 3: Response is generated by Application Gateway itself

Rewrite rules don't apply to **4xx and 5xx error responses** that Application Gateway generates internally (for example, 502 Bad Gateway when the backend is unreachable, or 403 from WAF). These responses bypass the rewrite pipeline.

This is a [known limitation](/azure/application-gateway/rewrite-http-headers-url#limitations).

**Resolution:**

For error responses generated by Application Gateway, consider using the [custom error pages](/azure/application-gateway/custom-error) feature instead of rewrite rules.

## How to verify rewrite behavior using access logs

Application Gateway access logs provide two key fields for verifying URL rewrites:

| Field | Description |
|---|---|
| `originalRequestUriWithArgs` | The original URL as received from the client |
| `requestUri` | The URL after rewrite rules are applied |

If both fields show the same value, the rewrite rule didn't execute or didn't match.

### Step 1: Enable diagnostic logging

If not already enabled, configure diagnostic settings to send **ApplicationGatewayAccessLog** to a Log Analytics workspace. For more information, see [Application Gateway diagnostics](/azure/application-gateway/application-gateway-diagnostics#diagnostic-logging).

### Step 2: Query access logs

Run the following Kusto query in your Log Analytics workspace to compare original and rewritten URLs:

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

If the query returns no results, it confirms that no rewrite rule was applied during the time range.

### Step 3: Verify response headers

To verify response header rewrites, use `curl` with verbose output:

```bash
curl -v https://your-appgw-url/path
```

Examine the response headers in the output to confirm the expected header is present and has the correct value.

## Related content

- [Rewrite HTTP headers and URL with Application Gateway](/azure/application-gateway/rewrite-http-headers-url)
- [Rewrite HTTP headers and URL - Azure portal](/azure/application-gateway/rewrite-http-headers-portal)
- [Rewrite HTTP headers and URL - Azure PowerShell](/azure/application-gateway/rewrite-url-portal)
- [Troubleshoot backend health issues in Application Gateway](/troubleshoot/azure/application-gateway/application-gateway-backend-health-troubleshooting)
- [Application Gateway FAQ](/azure/application-gateway/application-gateway-faq)
