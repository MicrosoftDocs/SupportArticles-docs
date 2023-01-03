--- 
title: Diagnose common problems that cause your ping tests to fail in Application Insights availability monitoring
description: This article describes how to diagnose common issues that cause ping tests to fail in Application Insights availability monitoring.
ms.date: 8/15/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: aaronmax
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Azure Application Insights user, I want to learn how to determine what's causing my ping tests to fail in Application Insights availability monitoring so that I can effectively monitor Azure applications.
---

# Diagnose ping test failure in Application Insights availability monitoring

This article discusses how to access the Application Insights troubleshooting report. This report allows you to easily diagnose common problems that cause your **ping tests** to fail.  

:::image type="content" source="./media/diagnose-ping-test-failure/availability-to-troubleshooter.gif" alt-text="Animation showing how to navigate to the end-to-end transaction details to view the troubleshooting report." lightbox="./media/diagnose-ping-test-failure/availability-to-troubleshooter.gif":::

Follow these steps to see the report:

1. On the **Availability** page of your Application Insights resource, select **Overall**, or select one of the availability tests.

2. Take one of the following actions:

   - Select **Failed**, and then select a test under **Drill into** on the left.
   - Select one of the points on the scatter plot.

3. To see the troubleshooting report, open the **End-to-end transaction details** page, select an event, locate the **Troubleshooting Report Summary** area, and then select **Go to step**.

The following table lists the steps, error messages, and possible causes that you might find in the report.

|Step | Error message | Possible cause |
|-----|---------------|----------------|
| Connection reuse | No specific error message is returned for this issue. | The west test step is dependent on a previously established connection. Therefore, no DNS, connection, or SSL step is required. |
| DNS resolution | The remote name could not be resolved: "your URL" | The DNS resolution process failed. This most likely occurred because of misconfigured DNS records or temporary DNS server failures. |
| Connection establishment | A connection attempt failed because the connected party did not properly respond after a period of time. | Your server isn't responding to the HTTP request. A common cause is that our test agents are being blocked by a firewall on your server. To test within an Azure Virtual Network, add the Availability service tag to your environment.|
| TLS transport  | The client and server cannot communicate because they do not possess a common algorithm.| Only TLS 1.0, 1.1, and 1.2 are supported. SSL isn't supported. This step doesn't validate SSL certificates, it only establishes a secure connection. This step appears only when an error occurs. |
| Receiving response header | Unable to read data from the transport connection. The connection was closed. | Your server committed a protocol error in the response header. For example, the connection is closed by your server if the response isn't fully read. |
| Receiving response body | Unable to read data from the transport connection: The connection was closed. | Your server committed a protocol error in the response body. For example, the connection is closed by your server if the response isn't fully read, or the chunk size is wrong in the chunked response body. |
| Redirect limit validation | This webpage has too many redirects. This loop will be terminated here since this request exceeded the limit for auto redirects. | Redirects are limited to 10 per test. |
| Status code validation | `200 - OK` does not match the expected status `400 - BadRequest`. | The returned status code is counted as a success. "200" is the code that indicates that a normal web page was returned. |
| Content validation | The required text 'hello' did not appear in the response. | The string isn't an exact case-sensitive match in the response. For example, the string "Welcome!" must be a plain string, without wildcard characters (such as an asterisk). If your page content changes, you might have to update the string. Only English characters are supported by content match. |

> [!NOTE]
> If the connection reuse step is present, then the following steps won't be present:
>
> * DNS resolution
> * Connection establishment
> * TLS transport

## Next steps

* Use [TrackAvailability](xref:Microsoft.ApplicationInsights.TelemetryClient.TrackAvailability%2A) to submit [custom availability tests](/azure/azure-monitor/app/availability-azure-functions).

* Learn about [URL ping tests](/azure/azure-monitor/app/monitor-web-app-availability).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
