--- 
title: Troubleshoot Azure Application Insights availability tests
description: This article describes how to troubleshoot web tests in Azure Application Insights and how to get alerts if a website becomes unavailable or responds slowly.
ms.date: 6/22/2022
author: kelleyguiney22
ms.author: v-kegui
editor: v-jsitser
ms.reviewer: aaronmax
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Azure Application Insights user, I want to know how to troubleshoot various problems enabling or viewing the Application Insights Profiler so I can use it effectively.  
---

# Troubleshoot Azure Application Insights availability monitoring

This article provides troubleshooting information for  common issues that might occur when you're using Application Insights availability monitoring. It also covers how to get alerts if a website becomes unavailable or is slow to respond.

## Troubleshooting report steps for ping tests

The Troubleshooting report allows you to easily diagnose common problems that cause your **ping tests** to fail. Follow these steps to see the report.

:::image type="content" source="./media/troubleshoot-availability/availability-to-troubleshooter.gif" alt-text="Animation of navigating from the Availability tab by selecting a failure to the end-to-end transaction details to view the troubleshooting report." lightbox="./media/troubleshoot-availability/availability-to-troubleshooter.gif":::

1. On the **Availability** page of your Application Insights resource, select **Overall**, or select one of the availability tests.

2. Either select **Failed**, and then select a test under **Drill into** on the left, or select one of the points on the scatter plot.

3. On the **End-to-end transaction details** page, select an event, and then, under **Troubleshooting Report Summary**, select **Go to step** to see the troubleshooting report.

    |Step | Error message | Possible cause |
    |-----|---------------|----------------|
    | Connection reuse | N/A | Dependent on a previously established connection, which means the web test step is dependent. So there would be no DNS, connection, or SSL step required. |
    | DNS resolution | The remote name could not be resolved: "your URL" | The DNS resolution process failed, most likely due to misconfigured DNS records or temporary DNS server failures. |
    | Connection establishment | A connection attempt failed because the connected party did not properly respond after a period of time. | In general, it means your server isn't responding to the HTTP request. A common cause is that our test agents are being blocked by a firewall on your server. To test within an Azure Virtual Network, add the Availability service tag to your environment.|
    | TLS transport  | The client and server cannot communicate because they do not possess a common algorithm.| Only TLS 1.0, 1.1, and 1.2 are supported. SSL isn't supported. This step doesn't validate SSL certificates and only establishes a secure connection. This step will only show up when an error occurs. |
    | Receiving response header | Unable to read data from the transport connection. The connection was closed. | Your server committed a protocol error in the response header. For example, the connection is closed by your server when the response isn't fully read. |
    | Receiving response body | Unable to read data from the transport connection: The connection was closed. | Your server committed a protocol error in the response body. For example, the connection is closed by your server when the response isn't fully read, or the chunk size is wrong in the chunked response body. |
    | Redirect limit validation | This webpage has too many redirects. This loop will be terminated here since this request exceeded the limit for auto redirects. | There's a limit of 10 redirects per test. |
    | Status code validation | `200 - OK` does not match the expected status `400 - BadRequest`. | The returned status code is counted as a success. 200 is the code that indicates that a normal web page has been returned. |
    | Content validation | The required text 'hello' did not appear in the response. | The string isn't an exact case-sensitive match in the response, such as the string "Welcome!". It must be a plain string, without wildcard characters (such as an asterisk). If your page content changes, you might have to update the string. Only English characters are supported with content match. |

    > [!NOTE]
    > If the connection reuse step is present, then the following steps won't be present:
    >
    > * DNS resolution
    > * Connection establishment
    > * TLS transport
  
## Common troubleshooting questions

### My site looks OK, but I see test failures. Why is Application Insights alerting me?

* Does your test have **Parse dependent requests** enabled? That results in a strict check on resources such as scripts, images, and more. These types of failures might not be noticeable on a browser. Check all the images, scripts, style sheets, and any other files loaded by the page. If any of them fail, the test is reported as failed, even if the main HTML page loads without issue. To desensitize the test to such resource failures, clear **Parse dependent requests** from the test configuration.

* To reduce odds of noise from transient network blips and other distractions, make sure that **Enable retries for test failures configuration** is selected. You can also test from more locations and manage the alert rule threshold accordingly to prevent location-specific issues causing undue alerts.

* Select any of the red dots from the availability scatter plot experience, or any availability failure from the **Search results**, to see the details of why we reported the failure. The test result, along with the correlated server-side telemetry (if enabled), should help you understand why the test failed. Common causes of transient issues are network or connection issues.

* Did the test time-out? We abort tests after two minutes. If your ping or multi-step test takes longer than two minutes, we'll report it as a failure. Consider breaking the test into multiple ones that can complete in shorter durations.

* Did all locations report failure, or only some of them? If only some locations reported failures, it may be due to network or content delivery network (CDN) issues. Again, selecting any of the red dots from the availability scatter plot experience should help you understand why the location reported failures.

### I didn't get an email when the alert triggered, or resolved, or both

Check the alerts' action group configuration to confirm that your email is directly listed, or a distribution list you're on is configured to receive notifications. If the distribution list is set up for notifications, then check the distribution list configuration to confirm it can receive external emails. Also, check to see if your mail administrator has policies configured that might cause this issue.

### I didn't receive the webhook notification

Make sure the application receiving the webhook notification is available, and that it successfully processes the webhook requests. For more information, see [Webhook actions for log alert rules](/azure/azure-monitor/alerts/alerts-log-webhook).

### I'm getting  403 Forbidden errors. What does this mean?

This error indicates that you need to add firewall exceptions to allow the availability agents to test your target URL. For a full list of agent IP addresses to allow, see the [IP exception article](/azure/azure-monitor/app/ip-addresses#availability-tests).

### Intermittent test failure with a protocol violation error?

The error "protocol violation...CR must be followed by LF" indicates an issue with the server or with dependencies. This error occurs when malformed headers are set in the response. It can be caused by load balancers or CDNs. Specifically, some headers might not be using CRLF to indicate end of line, which violates the HTTP specification and therefore fail validation at the .NET WebRequest level. Inspect the response and look for headers that might be violating this HTTP specification.

> [!NOTE]
> The URL might not fail on browsers that have a relaxed validation of HTTP headers. For a detailed explanation of this issue, see the blog post titled [A tale of debugging - the LinkedIn API, .NET and HTTP protocol violations](http://mehdi.me/a-tale-of-debugging-the-linkedin-api-net-and-http-protocol-violations/).

### I don't see any related server-side telemetry to diagnose test failures

This scenario can occur if you have Application Insights set up for your server-side application and [sampling](/azure/azure-monitor/app/sampling) is in operation. Select a different availability result.

### Can I call code from my web test?

No. The steps of the test must be in the .webtest file. And you can't call other web tests or use loops. But there are several plug-ins that you might find helpful.

### Is there a difference between "web tests" and "availability tests"?

The two terms may be used interchangeably. "Availability tests" is a more generic term that includes the single URL ping tests in addition to the multi-step web tests.

### I'd like to use availability tests on our internal server that runs behind a firewall.

There are two possible solutions:

* Configure your firewall to permit incoming requests from the [IP addresses of our web test agents](/azure/azure-monitor/app/ip-addresses).

* Write your own code to periodically test your internal server. Run the code as a background process on a test server behind your firewall. Your test process can send its results to Application Insights by using the [TrackAvailability](xref:Microsoft.ApplicationInsights.TelemetryClient.TrackAvailability%2A) API in the core SDK package. Your test server must have outgoing access to the Application Insights ingestion endpoint, but that's a much smaller security risk than the alternative of permitting incoming requests. The results will appear in the availability web tests blades. The experience will be slightly simplified from what's available for tests created through the portal. Custom availability tests will also appear as availability results in Analytics, Search, and Metrics.

### Uploading a multi-step web test fails

This failure might occur for the following reasons:

* There's a size limit of 300 K.
* Loops aren't supported.
* References to other web tests aren't supported.
* Data sources aren't supported.

### My multi-step test doesn't complete

There's a limit of 100 requests per test. Also, the test is stopped if it runs longer than two minutes.

### Can I run a test with client certificates?

No. This type of test isn't currently supported.

## Next steps

* Use [TrackAvailability](xref:Microsoft.ApplicationInsights.TelemetryClient.TrackAvailability%2A) to submit [custom availability tests](/azure/azure-monitor/app/availability-azure-functions).

* Learn about [URL ping tests](/azure/azure-monitor/app/monitor-web-app-availability).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
