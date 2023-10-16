--- 
title: Diagnose common problems that cause your ping tests to fail in Application Insights availability monitoring
description: This article describes how to diagnose common issues that cause ping tests to fail in Application Insights availability monitoring.
ms.date: 09/01/2023
editor: v-jsitser
ms.reviewer: aaronmax, v-leedennis
ms.service: azure-monitor
ms.subservice: application-insights
---

# Diagnose ping test failure in Application Insights availability monitoring

This article discusses how to access the Application Insights troubleshooting report. This report enables you to easily diagnose common problems that cause your ping tests to fail.  

:::image type="content" source="./media/diagnose-ping-test-failure/availability-to-troubleshooter.gif" alt-text="Azure portal animation that shows how to view the end-to-end transaction details to find the troubleshooting report in Application Insights." lightbox="./media/diagnose-ping-test-failure/availability-to-troubleshooter.gif":::

> [!NOTE]
> Many webtest-related issues are caused by stale or outdated DNS records. As a first troubleshooting step, we recommend that you flush the DNS cache on your local computer.
>
> In Windows, run the [ipconfig /flushdns](/windows-server/administration/windows-commands/ipconfig) command. For other operating systems, the equivalent command is different.

## View the Application Insights troubleshooting report

To view the Application Insights troubleshooting report, follow these steps:

1. On the **Availability** page of your Application Insights resource, locate the **Select availability test** heading. Under that heading, either select the name of an individual availability test or select **Overall** to see the combined results of all the test names.

2. Take one of the following actions:

   - In the **Availability results** pane for the test name, locate the **Drill into** heading, and then select the **Failed** button. Then, in the **Click on a sample availability test** pane, select a test run (that represents a particular region and time) for the test name.

   - In the **Availability** graph, select the **Scatter Plot** view, and then select one of the points on the scatter plot graph.

3. In the **End-to-end transaction details** page, select an event, and then select anywhere within the **Availability Properties** table to open the **Troubleshooting Report Summary** section.

4. In the **Troubleshooting Report Summary** section, locate the relevant error name, and then select the **Go to step** link for that item to view the **Troubleshooting Report** details.

## Use the troubleshooting report to determine possible causes of failure

The following table lists the steps, error messages, and possible causes that you might find in the report.

|Step | Error message | Possible cause |
|-----|---------------|----------------|
| Connection reuse | No specific error message is returned for this issue. | The web test step is dependent on a previously established connection. Therefore, no DNS, connection or SSL step is required. |
| DNS resolution | The remote name could not be resolved: "\<your-URL>" | The DNS resolution process fails. This most likely occurred because of misconfigured DNS records or temporary DNS server failures. |
| Connection establishment | A connection attempt failed because the connected party did not properly respond after a period of time. | Your server doesn't respond to the HTTP request. A common cause is that a firewall on your server is blocking our test agents. To test within an Azure Virtual Network, add the Availability service tag to your environment.|
| TLS transport  | The client and server cannot communicate because they do not possess a common algorithm.| Only TLS 1.0, 1.1, and 1.2 are supported. SSL isn't supported. This step doesn't validate SSL certificates, it only establishes a secure connection. This step appears only if an error occurs. |
| Receiving response header | Unable to read data from the transport connection. The connection was closed. | Your server commits a protocol error in the response header. For example, your server closes the connection if the response isn't fully read. |
| Receiving response body | Unable to read data from the transport connection: The connection was closed. | Your server commits a protocol error in the response body. For example, your server closes the connection if the response isn't fully read, or the chunk size is wrong in the chunked response body. |
| Redirect limit validation | This webpage has too many redirects. This loop will be terminated here since this request exceeded the limit for auto redirects. | Redirects are limited to 10 per test. |
| Status code validation | `200 - OK` does not match the expected status `400 - BadRequest`. | The returned status code is counted as a success. The "200" code indicates that a normal web page was returned. |
| Content validation | The required text '\<expected-response-text>' did not appear in the response. | <p>The string isn't an exact case-sensitive match in the response. For example, the string "Welcome!" must be a plain string, without wildcard characters (such as an asterisk). If your page content changes, you might have to update the string. Content match supports only English characters.</p> <p>Content match also fails if the response body is more than 1,000,000 bytes long. After the client reads that number of bytes, it stops reading the response body and drops the connection. Because of this behavior, the server experiences a `ClientConnectionFailure` exception, even if the client returns a success status code.</p> |

> [!NOTE]
> If the connection reuse step is present, then the following steps won't be present:
>
> - DNS resolution
> - Connection establishment
> - TLS transport

## Next steps

- Use [TrackAvailability](xref:Microsoft.ApplicationInsights.TelemetryClient.TrackAvailability%2A) to submit [custom availability tests](/azure/azure-monitor/app/availability-azure-functions).

- Learn about [URL ping tests](/azure/azure-monitor/app/monitor-web-app-availability).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
