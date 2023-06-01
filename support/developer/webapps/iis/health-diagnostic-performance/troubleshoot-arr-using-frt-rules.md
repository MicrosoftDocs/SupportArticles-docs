---
title: "Using Failed Request Tracing Rules to Troubleshoot Application Request Routing"
author: rick-anderson
description: "Failed Request Tracing Rules is a powerful tool for troubleshooting request-processing failures in IIS 7.0 and above. This topic leads the reader through the..."
ms.date: 07/02/2008
ms.assetid: e648fd47-7885-4dde-a37f-d6fbae2a47ac
msc.legacyurl: /learn/troubleshoot/using-failed-request-tracing/using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr
msc.type: authoredcontent
---
# Using Failed Request Tracing Rules to Troubleshoot Application Request Routing

Failed Request Tracing Rules is a powerful tool for troubleshooting request-processing failures in IIS 7.0 and above. This topic leads the reader through the steps to enable Failed Request Tracing Rules to debug failures and trace steps in Application Request Routing (ARR). For more information about Failed Request Tracing Rules, refer to [this article](troubleshooting-failed-requests-using-tracing-in-iis.md).

## Goal

To configure Failed Request Tracing Rules and to understand what to look for when troubleshooting Application Request Routing.

## Prerequisites

This walkthrough requires the following prerequisites:

- IIS 7.0 or above on Windows 2008 (any SKU) or newer with Tracing role service installed for IIS.
- Microsoft Application Request Routing Version 1 and dependent modules.
- Minimum of two application servers with working sites and applications.

If Application Request Routing Version 1 has not been installed, it is available for download at:

- Download Microsoft Application Request Routing Version 1 for IIS 7 (x86) [here](https://iis-umbraco.azurewebsites.net/downloads).
- Download Microsoft Application Request Routing Version 1 for IIS 7 (x64) [here](https://iis-umbraco.azurewebsites.net/downloads).

Follow the steps outlined in [Install Application Request Routing](../../extensions/installing-application-request-routing-arr/install-application-request-routing.md) document to install Application Request Routing.

Another prerequisite is that the reader has gone through the other [walkthroughs](../../extensions/planning-for-arr/using-the-application-request-routing-module.md) and has configured Application Request Routing. Application Request Routing should be in working order before proceeding with this walkthrough.

## Step 1 – Configure Failed Request Tracing Rules

In this step, the Failed Request Tracing Rules are defined for Application Request Routing.

### To configure Failed Request Tracing Rules using the UI

1. Launch IIS Manager (inetmgr).
2. Select the **Default Web Site**.  
    ![Screenshot showing the Sites list expanded. Default Web Site is highlighted.](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/_static/image1.jpg)
3. In the **Actions** pane, under **Configure**, select **Failed Request Tracing…**.  
    ![Screenshot focused on Failed Request Tracing in the Actions pane.](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/_static/image3.jpg)
4. In the **Edit Web Site Failed Request Tracing Settings** dialog box, check the **Enable** checkbox.  
    ![Screenshot of the Edit Web Site Failed Request Tracing Settings dialog.](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/_static/image5.jpg)
5. Click **OK** to save changes.  
6. Select the **Default Web Site**.
7. Double-click **Failed Request Tracing Rules**.
8. In the **Actions** pane, click **Add…**.  
    ![Screenshot of the Add Failed Request Tracing Rule window. All content is selected.](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/_static/image7.jpg)  
    Select **All content (\*)**, and then click **Next**.
9. Select **Status code(s):** and enter 200-399.  
    ![Screenshot of the Add Failed Request Tracing Rule. Status code is checked.](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/_static/image9.jpg)  
    Click **Next**. The above configuration has created a Failed Request Tracing Rule that writes traces when the status code falls between 200 and 399.
10. Deselect **ASP**,**ASPNET**, and **ISAPI Extension**. After selecting **WWW Server**, deselect everything under **Areas:**, except for **Rewrite** and **RequestRouting**. Since Application Request Routing relies on the URL Rewrite Module to inspect incoming requests, it is recommended that you enable the traces for both Application Request Routing (**RequestRouting**) and URL Rewrite Module (**Rewrite**).  
    ![Screenshot of the Edit Failed Request Tracing Rule window. W W W server is selected in the Providers section. ](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/_static/image11.jpg)  
    For additional information about URL Rewrite Module traces, refer to [Using Failed Request Tracing to Trace Rewrite Rules](../../extensions/url-rewrite-module/using-failed-request-tracing-to-trace-rewrite-rules.md) .
11. Click **Finish.**

### To configure Failed Request Tracing Rules using the command-line

1. Open a command prompt with **administrator** privileges.
2. Navigate to `%windir%\system32\inetsrv`.
3. To enable Failed Request Tracing on the Default Web Site, enter:

    [!code-console[Main](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/samples/sample1.cmd)]

4. To configure the Failed Request Tracing Rules as shown in the UI above, enter:  

    [!code-console[Main](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/samples/sample2.cmd)]

    [!code-console[Main](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/samples/sample3.cmd)]

    [!code-console[Main](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/samples/sample4.cmd)]

## Step 2 – Analyze Failed Request Tracing Logs

In this step, you will send requests to Application Request Routing and analyze Failed Request Tracing logs.

### To view Failed Request Tracing logs

1. Navigate to the directory where the Failed Request Tracing logs are written. By default, the location is `%SystemDrive%\inetpub\Logs\FailedReqLogFiles\`.
2. Change directory to the folder that matches the **Default Web Site**. By default, this is **W3SVC1**. If you are unsure, select the **Default Web Site** in IIS Manager, and then select **Advanced Settings…** in the **Actions** pane. The value of the **ID** indicates the corresponding folder. (ie. ID 1 corresponds to W3SVC1).
3. If there are any xml files, remove them by typing:  

    [!code-console[Main](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/samples/sample5.cmd)]
4. Send a request to Application Request Routing. If Application Request Routing is functioning correctly, it results in a 200 response, which falls within the 200 to 399 range that was specified in Step 1. Therefore, the logs are written to the location above.  
5. List the files in the directory to confirm that new xml files are written.
6. Open the xml file. Click **Request Details**. Select **Complete Request Trace**, and then click **Expand All**. Below is an example of a Failed Request Tracing log for Application Request Routing:  
    ![Screenshot of a browser window showing the Request Diagnostics for the example website in a tab.](using-failed-request-tracing-rules-to-troubleshoot-application-request-routing-arr/_static/image13.jpg)
7. Pay closer attention to the following sections:  

    - **GENERAL\_REQUEST\_HEADERS:**  

        - **Headers**: Shows the HTTP header that Application Request Routing has received.

    - **ARR\_REQUEST\_ROUTED:**  

        - **WebFarm**: Indicates the name of the server group to where the request is routed.
        - **Server**: Indicates the destination server to where the request is routed.
        - **Algorithm**: Indicates which load balance algorithm is used.
        - **RoutingReason**: Indicates the decision behind why the server is selected.

    - **ARR\_SERVER\_STATS**:  

        - **State**: Availability of the destination server.
        - **TotalRequests**: Runtime statistic on how many requests have been sent to this server.
        - **CurrentRequests**: Runtime statistic on the concurrent number of HTTP requests to this server.
        - **BytesSent**: Runtime statistic on how much data in KB have been sent to this server.
        - **BytesReceived**: Runtime statistic on how much data in KB have been received from this server.
        - **ResponseTime**: Runtime statistic on the responsiveness in ms of this server.

    - **GENERAL\_RESPONSE\_HEADERS**  

        - **Headers**: Shows the response HTTP header from the destination server.

    - **GENERAL\_RESPONSE\_ENTITY\_BUFFER**  

        - **Buffer**: Shows the response entity from the destination server.

    - The following have been added with the timestamps to indicate the start and end times of corresponding events to profile the performance of Application Request Routing:  

        - **ARR\_REQUEST\_HEADERS\_START**
        - **ARR\_REQUEST\_HEADERS\_END**
        - **ARR\_RESPOSE\_HEADERS\_START**
        - **ARR\_RESPONSE\_HEADERS\_END**
        - **ARR\_RESPONSE\_ENTITY\_START**
        - **ARR\_RESPONSE\_ENTITY\_END**
        - **ARR\_RESPONSE\_ENTITY\_START**
        - **ARR\_RESPONSE\_ENTITY\_END**

If you are collecting the Failed Request Tracing logs on server core, you must copy the logs with freb.xsl stylesheet to a computer where a browser is available.

## Summary

You have now successfully configured Failed Request Tracing Rules for Application Request Routing. Failed Request Tracing Rules can be used to troubleshoot and debug Application Request Routing, as well as understand the routing decisions, including load balance algorithms, that it has made in selecting the destination server for a given request.
