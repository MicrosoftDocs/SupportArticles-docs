---
title: Troubleshoot DNS failures in AKS using Advanced Container Networking Services (ACNS)
description: Learn how to diagnose and resolve DNS resolution failures across an Azure Kubernetes Service (AKS) cluster in real-time using Advanced Container Networking Services (ACNS) observability tools.
author: shaifaligargmsft
ms.author: shaifaligarg
ms.service: azure-kubernetes-service
ms.subservice: aks-networking
ms.topic: troubleshooting
ms.date: 09/03/2025
---

# Troubleshoot DNS failures in AKS using Advanced Container Networking Services (ACNS)

This article discusses how to troubleshoot Domain Name System (DNS) failures across an Azure Kubernetes Service (AKS) cluster in real-time using [Advanced Container Networking Services (ACNS)](./advanced-container-networking-services-overview.md) observability tools.

> [!NOTE]
> This article is complementary to the [Basic troubleshooting of DNS resolution problems in AKS](../connectivity/dns/basic-troubleshooting-dns-resolution-problems.md) guide and provides enterprise-grade observability capabilities through ACNS.

## Symptoms

The following table outlines common DNS-related symptoms that you might observe in an AKS cluster and how ACNS can help diagnose them:

| Symptom | Description | ACNS Diagnostic Capability |
|---------|-------------|---------------------------|
| High DNS error rate | DNS queries fail or return unexpected results, affecting application performance and reliability | **DNS Cluster Dashboard**: Monitor cluster-wide DNS error rates and identify problematic nodes/pods |
| Slow DNS resolution | DNS queries take longer than usual to resolve, causing application delays or timeouts | **Container Network Logs**: Analyze DNS latency patterns and response times with detailed KQL queries |
| Service discovery failures | Applications can't locate other services in the cluster due to DNS issues | **DNS Workload Dashboard**: Track internal service resolution patterns and identify misconfigured services |
| External connectivity issues | Applications have trouble accessing external resources due to DNS problems | **Flow Logs Visualization**: Monitor egress DNS traffic and external domain resolution patterns |
| Intermittent DNS failures | DNS resolution works sporadically, often due to network policy restrictions | **Network Policy Correlation**: Analyze dropped DNS packets and policy enforcement decisions |

## Prerequisites

Before you begin, ensure you have:

- **Azure CLI** installed and configured. To install Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).
- **kubectl** configured to connect to your cluster. To install kubectl using Azure CLI, run the `az aks install-cli` command.
- **An AKS cluster with ACNS enabled**. See [Enable Advanced Container Networking Services](./how-to-configure-container-network-logs.md) for setup instructions.
- **Azure Managed Grafana** linked to your cluster for dashboard visualization.
- **Log Analytics workspace** configured for Container Network Logs storage.
- **Basic understanding** of Kubernetes DNS, network policies, and container networking concepts.

## Scenario: Pet store application DNS issues

In this troubleshooting guide, we'll use a realistic scenario involving a pet store application deployed on AKS. The platform consists of multiple microservices:

- **Store front service** (web interface)
- **Product service** (pet product data)
- **Order service** (order management)
- **Rabbit MQ service** (message queuing)
- **MongoDB service** (database)
- **External APIs** (payment gateways, shipping providers)

**Problem scenario**: After implementing strict network security policies, the development team reports that:

1. The store front can't resolve the product service
2. Order processing is failing due to database connectivity issues
3. Some services work intermittently
4. Application logs show various DNS-related errors

Let's use ACNS to systematically diagnose and resolve these issues.

## Step 1: Assess overall DNS health using ACNS dashboards

Start with a high-level assessment of DNS health across your cluster using the ACNS DNS Cluster dashboard.

### Access the DNS Cluster dashboard

1. Open your Azure Managed Grafana instance linked to your AKS cluster.
2. Navigate to **Dashboards** > **Managed Prometheus** > **DNS (Cluster)**.
3. Set the time range to cover the period when DNS issues were reported.

### Analyze cluster-wide DNS patterns

**Key metrics to examine:**

1. **DNS Requests Missing Response %**
   - **Normal**: < 5%
   - **Warning**: 5-15%
   - **Critical**: > 15%

   High percentages indicate upstream DNS server issues or network connectivity problems.

2. **DNS Error Rate by Type**
   - `NXDOMAIN`: Domain doesn't exist (check for typos in service names)
   - `SERVFAIL`: DNS server configuration or upstream connectivity issues
   - `REFUSED`: DNS policy restrictions or security configurations
   - `TIMEOUT`: Network connectivity or DNS server overload

3. **Top DNS Queries**
   - Identify which domains are queried most frequently
   - Look for unexpected or malicious domain queries
   - Verify legitimate service names are being resolved

:::image type="content" source="../media/acnsdnstroubleshooting/DNS-cluster-snapshot.png" alt-text="DNS Cluster dashboard overview showing request patterns and error rates." lightbox="../media/acnsdnstroubleshooting/DNS-cluster-snapshot.png":::

### Identify problematic pods and namespaces

Scroll down to the **Top Pods with DNS Errors** section to identify:

- Which specific pods are generating the most DNS errors
- The namespaces where errors are concentrated
- Whether errors are isolated to specific workloads

:::image type="content" source="../media/acnsdnstroubleshooting/top-pods-with-dns-errors.png" alt-text="Top pods with DNS errors across all namespaces." lightbox="../media/acnsdnstroubleshooting/top-pods-with-dns-errors.png":::-in-all-namespaces

**For the pet store scenario**, you might observe:
- High error rates in the `pets` namespace
- Store front and order service pods showing the highest DNS error counts
- Spikes in `NXDOMAIN` errors coinciding with network policy changes

## Step 2: Deep-dive into workload-specific DNS behavior

Use the DNS Workload dashboard for detailed analysis of specific services experiencing DNS issues.

### Configure the DNS Workload dashboard

1. Navigate to **Dashboards** > **Managed Prometheus** > **DNS (Workload)**.
2. Filter by:
   - **Namespace**: `pets`
   - **Workload**: `store-front` (or the problematic workload identified in Step 1)
3. Set the time range to match your cluster analysis.

### Analyze workload-specific DNS patterns

**1. Request and Response Trends**

Monitor the **DNS Requests** and **DNS Responses** sections:

:::image type="content" source="../media/acnsdnstroubleshooting/workload-dns-requests-and-responses.png" alt-text="DNS requests and responses trends for specific workload." lightbox="../media/acnsdnstroubleshooting/workload-dns-requests-and-responses.png":::

- **Sudden drops in response rates**: Indicates upstream DNS server issues
- **High "Requests Missing Response %"**: Suggests DNS query blocking or connectivity problems
- **Request spikes without corresponding responses**: Often indicates network policy restrictions

**2. Error Analysis by Type**

Examine the **DNS Errors by Type** graph:

:::image type="content" source="../media/acnsdnstroubleshooting/types-of-dns-error-responses.png" alt-text="DNS error types breakdown showing specific failure patterns." lightbox="../media/acnsdnstroubleshooting/types-of-dns-error-responses.png":::

**Common patterns in the pet store scenario**:
- **NXDOMAIN for internal services**: `product-service.pets.svc.cluster.local` not found
- **SERVFAIL for external APIs**: Payment gateway DNS resolution failures
- **Query Refused**: Network policies blocking DNS traffic

**3. Query Pattern Analysis**

Review **Top DNS Queries** to understand traffic patterns:

:::image type="content" source="../media/acnsdnstroubleshooting/top-dns-queries-requests.png" alt-text="Top DNS queries showing most frequently requested domains." lightbox="../media/acnsdnstroubleshooting/top-dns-queries-requests.png":::

**Expected queries for pet store**:
- `product-service.pets.svc.cluster.local`
- `order-service.pets.svc.cluster.local`
- `rabbitmq.pets.svc.cluster.local`
- `mongodb.pets.svc.cluster.local`
- `payment-gateway.external.com`
- `shipping-api.logistics.com`

**4. Protocol-specific Issues**

Review the **DNS Response Table** for detailed analysis:

:::image type="content" source="../media/acnsdnstroubleshooting/dns-response-table.png" alt-text="DNS response table showing detailed response codes and query types." lightbox="../media/acnsdnstroubleshooting/dns-response-table.png":::

Look for:
- Differences between IPv4 (A) and IPv6 (AAAA) record success rates
- Specific query types failing consistently
- Response code patterns indicating policy restrictions

## Step 3: Analyze DNS traffic with Container Network Logs

For detailed packet-level analysis, use Container Network Logs to examine individual DNS requests and identify root causes.

### Access your Log Analytics workspace

1. Navigate to your Log Analytics workspace in the Azure portal.
2. Go to the **Logs** section.
3. Run the following KQL queries to analyze DNS traffic patterns.

### Query 1: Identify blocked DNS requests

This query helps identify DNS requests that are being dropped due to network policies:

```kusto
RetinaNetworkFlowLogs
| where TimeGenerated > ago(1h)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53
| where SourceNamespace == "pets"
| where Verdict == "DROPPED"
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSQuery = tostring(Layer7_DNS.query)
| extend AdditionalFlowData_Summary = tostring(parse_json(AdditionalFlowData).Summary)
| project TimeGenerated, SourcePodName, DNSQuery, Verdict, TrafficDirection, AdditionalFlowData_Summary
| summarize DroppedCount = count() by SourcePodName, DNSQuery
| order by DroppedCount desc
```

**Expected results for pet store scenario**:

:::image type="content" source="../media/acnsdnstroubleshooting/query1results.png" alt-text="Result of Query 1." lightbox="../media/acnsdnstroubleshooting/query1results.png":::-in-all-namespaces

### Query 2: Analyze DNS response patterns

This query examines DNS responses to identify successful vs. failed resolutions:

```kusto
RetinaNetworkFlowLogs
| where TimeGenerated > ago(1h)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.source_port == 53
| where DestinationNamespace == "pets"
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSRCode = tostring(Layer7_DNS.rcode)
| extend DNSQuery = tostring(Layer7_DNS.query)
| project TimeGenerated, DestinationPodName, DNSQuery, DNSRCode, Verdict
| summarize 
    TotalResponses = count(),
    SuccessfulResponses = countif(DNSRCode == "NOERROR"),
    FailedResponses = countif(DNSRCode != "NOERROR")
    by DestinationPodName, DNSQuery
| extend SuccessRate = (SuccessfulResponses * 100.0) / TotalResponses
| order by SuccessRate asc
```

**Expected results for pet store scenario**:
:::image type="content" source="../media/acnsdnstroubleshooting/query2results.png" alt-text="Result of Query 2." lightbox="../media/acnsdnstroubleshooting/query2results.png":::-in-all-namespaces

### Query 3: DNS latency analysis

This query identifies slow DNS resolution patterns:

```kusto
RetinaNetworkFlowLogs
| where TimeGenerated > ago(1h)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53 or Layer4_UDP.source_port == 53
| where SourceNamespace == "pets" or DestinationNamespace == "pets"
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSQuery = tostring(Layer7_DNS.query)
| extend Layer7_Type = tostring(parse_json(Layer7).type)
| extend RequestTime = iff(Layer7_Type == "REQUEST", TimeGenerated, datetime(null))
| extend ResponseTime = iff(Layer7_Type == "RESPONSE", TimeGenerated, datetime(null))
| summarize 
    FirstRequest = min(RequestTime),
    LastResponse = max(ResponseTime)
    by DNSQuery, bin(TimeGenerated, 1m)
| extend LatencyMs = datetime_diff('millisecond', LastResponse, FirstRequest)
| where LatencyMs > 0
| project TimeGenerated, DNSQuery, LatencyMs
| order by LatencyMs desc
```

**Expected results for pet store scenario**:
:::image type="content" source="../media/acnsdnstroubleshooting/query3results.png" alt-text="Result of Query 3." lightbox="../media/acnsdnstroubleshooting/query3results.png":::-in-all-namespaces

### Query 4: Correlate DNS failures with network policies

This query correlates DNS failures with network policy enforcement:

```kusto
RetinaNetworkFlowLogs
| where TimeGenerated > ago(1h)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53
| where SourceNamespace == "pets"
| where Verdict == "DROPPED"
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSQuery = tostring(Layer7_DNS.query)
| extend AdditionalFlowData_Summary = tostring(parse_json(AdditionalFlowData).Summary)
| project TimeGenerated, SourcePodName, DNSQuery, Verdict, AdditionalFlowData_Summary
| summarize FirstDropped = min(TimeGenerated), LastDropped = max(TimeGenerated), DropCount = count() by SourcePodName, DNSQuery, AdditionalFlowData_Summary
| order by DropCount desc
```

**Example results showing policy enforcement**:
:::image type="content" source="../media/acnsdnstroubleshooting/query4results.png" alt-text="Result of Query 4." lightbox="../media/acnsdnstroubleshooting/query4results.png":::-in-all-namespaces

## Step 4: Identify specific DNS failure patterns

Based on your ACNS analysis, classify the DNS issues into specific categories:

### Pattern 1: Internal service discovery failures

**Symptoms**:
- `NXDOMAIN` errors for internal Kubernetes services
- High drop rates for queries to `*.svc.cluster.local` domains
- Services can't locate each other within the same namespace

**ACNS indicators**:
- DNS Workload dashboard shows high error rates for internal service queries
- Container Network Logs show dropped packets for intra-cluster DNS traffic
- Flow logs indicate blocked traffic between pods and CoreDNS

**Root cause analysis using ACNS**:
```kusto
// Check for internal service resolution failures
RetinaNetworkFlowLogs
| where TimeGenerated > ago(30m)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53
| where SourceNamespace == "pets"
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSQuery = tostring(Layer7_DNS.query)
| extend DNSRCode = tostring(Layer7_DNS.rcode)
| where DNSQuery contains "svc.cluster.local"
| where Verdict == "DROPPED" or DNSRCode == "NXDOMAIN"
| summarize count() by DNSQuery, Verdict, DNSRCode
```

### Pattern 2: External domain resolution failures

**Symptoms**:
- `SERVFAIL` or `TIMEOUT` errors for external APIs
- Applications can't reach payment gateways, shipping APIs, etc.
- Intermittent connectivity to external services

**ACNS indicators**:
- DNS Cluster dashboard shows high upstream DNS server latency
- External traffic dashboard shows blocked egress DNS queries
- High "Missing Response %" for external domains

**Root cause analysis using ACNS**:
```kusto
// Analyze external domain resolution issues
RetinaNetworkFlowLogs
| where TimeGenerated > ago(30m)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53
| where SourceNamespace == "pets"
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSQuery = tostring(Layer7_DNS.query)
| extend DNSRCode = tostring(Layer7_DNS.rcode)
| where DNSQuery !contains "cluster.local" and DNSQuery !contains "."
| summarize 
    TotalQueries = count(),
    FailedQueries = countif(DNSRCode != "NOERROR" or Verdict == "DROPPED")
    by DNSQuery
| extend FailureRate = (FailedQueries * 100.0) / TotalQueries
| order by FailureRate desc
```

### Pattern 3: Network policy-induced DNS blocking

**Symptoms**:
- DNS worked before policy changes
- Intermittent failures depending on traffic patterns
- Specific pods affected while others work fine

**ACNS indicators**:
- Clear correlation between policy application time and DNS failure spikes
- Container Network Logs show "DROPPED" verdicts with policy information
- Heatmaps show specific pods with high drop rates

**Root cause analysis using ACNS**:
```kusto
// Identify network policy impacts on DNS
RetinaNetworkFlowLogs
| where TimeGenerated > ago(1h)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53
| where SourceNamespace == "pets"
| where Verdict == "DROPPED"
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSQuery = tostring(Layer7_DNS.query)
| extend AdditionalFlowData_Summary = tostring(parse_json(AdditionalFlowData).Summary)
| project TimeGenerated, SourcePodName, DNSQuery, AdditionalFlowData_Summary
| summarize DropCount = count() by AdditionalFlowData_Summary, bin(TimeGenerated, 5m)
| order by TimeGenerated desc
```

## Step 5: Resolve DNS issues using ACNS insights

Based on your ACNS analysis, implement targeted solutions:

### Solution 1: Fix internal service discovery

**Problem identified**: Network policies blocking DNS traffic to CoreDNS.

**Resolution**: Create DNS-allowing network policy:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-dns-access
  namespace: pets
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          name: kube-system
    - podSelector:
        matchLabels:
          k8s-app: kube-dns
    ports:
    - protocol: UDP
      port: 53
    - protocol: TCP
      port: 53
```

**Verification using ACNS**:
```bash
# Apply the policy
kubectl apply -f dns-allow-policy.yaml

# Monitor improvement in real-time
# Check DNS Workload dashboard for reduced error rates
# Run Container Network Logs query to verify FORWARDED verdicts
```

### Solution 2: Enable external domain access

**Problem identified**: Network policies blocking external DNS resolution.

**Resolution**: Update network policy to allow external DNS:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-external-dns
  namespace: pets
spec:
  podSelector:
    matchLabels:
      app: order-service
  policyTypes:
  - Egress
  egress:
  - to: []
    ports:
    - protocol: UDP
      port: 53
    - protocol: TCP
      port: 53
  - to: []
    ports:
    - protocol: TCP
      port: 443
    - protocol: TCP
      port: 80
```

### Solution 3: Optimize CoreDNS for high load

**Problem identified**: CoreDNS overwhelmed by high query volume.

**Resolution**: Scale and optimize CoreDNS:

```bash
# Scale CoreDNS deployment
kubectl scale deployment coredns -n kube-system --replicas=3

# Optimize CoreDNS configuration for caching
kubectl patch configmap coredns -n kube-system --patch='
data:
  Corefile: |
    .:53 {
        errors
        health {
           lameduck 5s
        }
        ready
        kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           fallthrough in-addr.arpa ip6.arpa
           ttl 30
        }
        prometheus :9153
        cache 300
        loop
        reload
        loadbalance
        forward . /etc/resolv.conf {
           max_concurrent 1000
        }
    }
'
```

## Step 6: Monitor DNS recovery with ACNS

After implementing fixes, use ACNS to verify resolution effectiveness:

### Real-time monitoring

1. **DNS Cluster Dashboard**: Monitor overall error rate reduction
2. **DNS Workload Dashboard**: Verify specific service improvements
3. **Flow Logs**: Confirm FORWARDED verdicts for previously blocked traffic

### Verification queries

**Check resolution improvement**:
```kusto
RetinaNetworkFlowLogs
| where TimeGenerated > ago(15m)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53
| where SourceNamespace == "pets"
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSQuery = tostring(Layer7_DNS.query)
| extend DNSRCode = tostring(Layer7_DNS.rcode)
| summarize 
    TotalQueries = count(),
    SuccessfulQueries = countif(Verdict == "FORWARDED" and DNSRCode == "NOERROR"),
    DropgedQueries = countif(Verdict == "DROPPED")
    by bin(TimeGenerated, 1m)
| extend SuccessRate = (SuccessfulQueries * 100.0) / TotalQueries
| project TimeGenerated, SuccessRate, TotalQueries, DropgedQueries
| order by TimeGenerated desc
```

**Monitor latency improvements**:
```kusto
RetinaNetworkFlowLogs
| where TimeGenerated > ago(15m)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53 or Layer4_UDP.source_port == 53
| where SourceNamespace == "pets" or DestinationNamespace == "pets"
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSQuery = tostring(Layer7_DNS.query)
| extend DNSLatency = toreal(parse_json(Layer7).latency_ns) / 1000000.0  // Convert to milliseconds
| summarize AvgLatency = avg(DNSLatency) by bin(TimeGenerated, 1m)
| where isnotnull(AvgLatency)
| order by TimeGenerated desc
```

### Test application functionality

Verify that the pet store application components can now communicate:

```bash
# Test internal service resolution
kubectl exec -n pets -it deployment/store-front -- nslookup product-service.pets.svc.cluster.local

# Test database connectivity
kubectl exec -n pets -it deployment/order-service -- nslookup mongodb.pets.svc.cluster.local

# Test message queue connectivity  
kubectl exec -n pets -it deployment/product-service -- nslookup rabbitmq.pets.svc.cluster.local

# Check application health
kubectl get pods -n pets
kubectl logs -n pets deployment/store-front --tail=50
```

## Step 7: Implement preventive monitoring

Set up ongoing DNS health monitoring using ACNS to prevent future issues:

### Configure alerting rules

**High DNS error rate alert**:
```kusto
RetinaNetworkFlowLogs
| where TimeGenerated > ago(5m)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53
| extend Layer7_DNS = parse_json(Layer7).dns
| extend DNSRCode = tostring(Layer7_DNS.rcode)
| summarize 
    TotalQueries = count(),
    ErrorQueries = countif(DNSRCode != "NOERROR" or Verdict == "DROPPED")
    by bin(TimeGenerated, 1m)
| extend ErrorRate = (ErrorQueries * 100.0) / TotalQueries
| where ErrorRate > 15
```

**DNS latency alert**:
```kusto
RetinaNetworkFlowLogs
| where TimeGenerated > ago(5m)
| extend Layer4_UDP = parse_json(Layer4).UDP
| where Layer4_UDP.destination_port == 53 or Layer4_UDP.source_port == 53
| extend DNSLatency = toreal(parse_json(Layer7).latency_ns) / 1000000.0  // Convert to milliseconds
| summarize AvgLatency = avg(DNSLatency) by bin(TimeGenerated, 1m)
| where AvgLatency > 1000
```

### Best practices for DNS health

1. **Regular dashboard reviews**: Schedule weekly reviews of DNS Cluster dashboard
2. **Automated policy validation**: Test DNS connectivity after network policy changes
3. **Capacity monitoring**: Track CoreDNS resource usage and scale proactively
4. **External dependency monitoring**: Monitor external DNS provider health
5. **Documentation**: Maintain DNS troubleshooting runbooks based on ACNS insights

## Troubleshooting checklist

Use this checklist for systematic DNS troubleshooting with ACNS:

- [ ] **Check DNS Cluster dashboard** for overall cluster health
- [ ] **Analyze DNS Workload dashboard** for specific service issues
- [ ] **Query Container Network Logs** for detailed packet analysis
- [ ] **Verify service existence** (`kubectl get svc`, `kubectl get endpoints`)
- [ ] **Review network policies** for DNS traffic restrictions
- [ ] **Check CoreDNS health** (`kubectl get pods -n kube-system`)
- [ ] **Test DNS resolution** from within affected pods
- [ ] **Monitor external connectivity** using Flow Logs dashboards
- [ ] **Correlate timing** with recent policy or configuration changes
- [ ] **Validate fixes** using ACNS real-time monitoring

## Additional resources

- [Advanced Container Networking Services overview](./advanced-container-networking-services-overview.md)
- [Container Network Observability setup guide](./container-network-observability-how-to.md)
- [Container Network Logs reference](./container-network-observability-logs.md)
- [Basic DNS troubleshooting in AKS](../connectivity/dns/basic-troubleshooting-dns-resolution-problems.md)
- [Network policies in AKS](./use-network-policies.md)

## Contact us for help

If you have questions or need help, [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot), or ask [Azure community support](https://learn.microsoft.com/en-us/answers/products/azure?product=all). You can also submit product feedback to [Azure feedback community](https://feedback.azure.com/d365community).
