# Application Gateway Documentation Updates

**Date**: March 4, 2026
**Basis**: Factcheck report (`factcheck-report-application-gateway-customer-feedback-2026-02-17-140000`)

## Summary of Changes

| # | File | What | How | Why |
|---|------|------|-----|-----|
| 1 | `http-response-codes.md` | Fixed 303 response code description | Changed "HTTP 302" to "HTTP 303" in the 303 See Other section | Factual error: section described 303 but referenced 302 |
| 2 | `http-response-codes.md` | Fixed "storage blog" typo and grammar | Changed "storage blog" to "storage blob"; fixed "endpoint is in different region" to "endpoint are in a different region" | Typo and grammar correction per Microsoft style guide |
| 3 | `http-response-codes.md` | Added missing 503 - Service Unavailable section | Inserted new section between 502 and 504 with common causes and troubleshooting steps | Critical gap: 503 is a recognized Application Gateway error code but had no documentation. Customer feedback explicitly cited 503 errors. |
| 4 | `http-response-codes.md` | Updated `ms.date` | `05/26/2025` to `03/04/2026` | Content modified; date must reflect update |
| 5 | `log-analytics.md` | Fixed "WAK SKU" typo | Changed "WAK SKU" to "WAF SKU" in prerequisites | "WAK" is not a valid SKU; correct product name is WAF (Web Application Firewall) |
| 6 | `log-analytics.md` | Updated `ms.date` | `09/16/2024` to `03/04/2026` | Content modified; date must reflect update |
| 7 | `create-gateway-internal-load-balancer-app-service-environment.md` | Fixed incorrect `ms.service` metadata | Changed `azure-vpn-gateway` to `azure-application-gateway` | Article covers Application Gateway with ILB ASE, not VPN Gateway |
| 8 | `create-gateway-internal-load-balancer-app-service-environment.md` | Updated `ms.date` | `06/10/2022` to `03/04/2026` | Content modified; date must reflect update |
| 9 | `application-gateway-key-vault-common-errors.md` | Updated `ms.date` | `07/26/2022` to `03/04/2026` | Article was 3.5 years stale; refreshed during review |
| 10 | `ingress-controller-troubleshoot.md` | Fixed Kubernetes Ingress YAML for `networking.k8s.io/v1` | Added `service:` wrapper around backend name/port; changed `backend:` to `defaultBackend:` with correct nested structure | YAML used v1 apiVersion but deprecated v1beta1 field format; fails validation on Kubernetes 1.22+ |
| 11 | `ingress-controller-troubleshoot.md` | Updated `ms.date` | `01/31/2024` to `03/04/2026` | Content modified; date must reflect update |
| 12 | `http-response-codes.md` | Added TLS handshake failure note to Summary | Inserted NOTE callout after summary explaining TLS version mismatches (TLS 1.0/1.1 deprecated Aug 2025) cause connection failures before any HTTP response, with links to TLS policy overview and configuration docs | CSS issue: SSL/TLS certificate setup issues — customers see connection errors with no HTTP code when TLS version or cipher suite is incompatible |
| 13 | `http-response-codes.md` | Added WAF false positive troubleshooting to 403 section | Inserted 5-step numbered list: enable WAF diagnostic logs, use Detection mode, create exclusions, disable individual rules, links to official WAF troubleshoot and best practices docs | CSS issue: WAF policy false positives — 403 section identified WAF as cause but previously had zero remediation steps |
| 14 | `http-response-codes.md` | Updated `ms.date` | `03/04/2026` to `03/05/2026` | Content modified; date must reflect update |

## Files Modified

- `http-response-codes.md` (7 changes)
- `log-analytics.md` (2 changes)
- `create-gateway-internal-load-balancer-app-service-environment.md` (2 changes)
- `application-gateway-key-vault-common-errors.md` (1 change)
- `ingress-controller-troubleshoot.md` (2 changes)

## Files Reviewed - No Changes Needed

- `application-gateway-backend-health-troubleshooting.md`
- `application-gateway-troubleshooting-502.md`
- `mutual-authentication-troubleshooting.md`
- `disabled-listeners.md`
- `how-to-troubleshoot-application-gateway-session-affinity-issues.md`
- `resource-health-overview.md`
- `troubleshoot-app-service-redirection-app-service-url.md`
- `error-codes/application-gateway-frontend-ip-cannot-have-public-ip-subnet-error.md`
- `error-codes/applicationgatewayskunotspecified.md`
- `toc.yml`
- `welcome-app-gateway.yml`

## Verification Sources

| Source | URL |
|--------|-----|
| HTTP response codes in Application Gateway | https://learn.microsoft.com/azure/application-gateway/http-response-codes |
| Application Gateway custom error pages | https://learn.microsoft.com/azure/application-gateway/custom-error |
| Backend health troubleshooting | https://learn.microsoft.com/troubleshoot/azure/application-gateway/application-gateway-backend-health-troubleshooting |
| Azure WAF on Application Gateway | https://learn.microsoft.com/azure/web-application-firewall/ag/ag-overview |
| Kubernetes Ingress v1 API reference | https://kubernetes.io/docs/reference/kubernetes-api/service-resources/ingress-v1/ |
| Azure Blob Storage network security | https://learn.microsoft.com/azure/storage/common/storage-network-security |
| Application Gateway TLS policy overview | https://learn.microsoft.com/azure/application-gateway/application-gateway-ssl-policy-overview |
| Configure TLS policy versions and cipher suites | https://learn.microsoft.com/azure/application-gateway/application-gateway-configure-ssl-policy-powershell |
| Troubleshoot WAF for Application Gateway | https://learn.microsoft.com/azure/web-application-firewall/ag/web-application-firewall-troubleshoot |
| WAF exclusion lists | https://learn.microsoft.com/azure/web-application-firewall/ag/application-gateway-waf-configuration |
| WAF best practices for Application Gateway | https://learn.microsoft.com/azure/web-application-firewall/ag/best-practices |

## CSS Issue Coverage Verification

| CSS Issue | Covered By | Gap Addressed |
|-----------|-----------|---------------|
| Frequent 5xx errors (502/503) due to backend or health probe misconfiguration | `application-gateway-troubleshooting-502.md`, `http-response-codes.md` (502 + new 503 section), `application-gateway-backend-health-troubleshooting.md` | 503 section added in prior edit (change #3) |
| SSL/TLS certificate setup issues (handshake failures, unsupported TLS versions) | `application-gateway-key-vault-common-errors.md`, `mutual-authentication-troubleshooting.md`, `application-gateway-backend-health-troubleshooting.md` (CN mismatch, expired cert, missing intermediate, etc.), `application-gateway-troubleshooting-502.md` (upstream SSL) | TLS handshake failure note added (change #12) — covers TLS 1.0/1.1 deprecation and version/cipher mismatch |
| WAF policy false positives blocking legitimate traffic | `http-response-codes.md` (403 section), `log-analytics.md` (WAF log queries) | WAF false positive troubleshooting steps added (change #13) — 5-step remediation with links to official WAF troubleshoot and exclusion docs |
