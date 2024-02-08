---
title: Using Failed Request Tracing rules to troubleshoot Application Request Routing
description: Describes the steps to enable Failed Request Tracing rules to debug failures and trace steps in Application Request Routing.
ms.date: 07/02/2008
ms.author: haiyingyu
author: HaiyingYu
ms.reviewer: johnhart, riande
---
# Using Failed Request Tracing rules to troubleshoot Application Request Routing

_Applies to:_ &nbsp; Internet Information Services 7.0 and later versions

Failed Request Tracing is a powerful tool for troubleshooting request-processing failures in IIS 7.0 and later versions. This article provides steps to enable Failed Request Tracing rules to debug failures and trace steps in Application Request Routing. For more information about Failed Request Tracing rules, see [Troubleshoot failed requests using tracing in IIS 8.5](troubleshoot-failed-requests-using-tracing-in-iis-85.md).

## Goal

To configure Failed Request Tracing rules and to understand what to look for when troubleshooting Application Request Routing.

## Prerequisites

This walkthrough requires the following prerequisites:

- IIS 7.0 or above on Windows 2008 (any SKU) or newer with Tracing role service installed for IIS.
- Microsoft Application Request Routing and dependent modules.
- Minimum of two application servers with working sites and applications.

If Application Request Routing hasn't been installed, download it from the [Download Center](https://www.microsoft.com/download/details.aspx?id=47333), and install it by following the steps outlined in [Install Application Request Routing](/iis/extensions/installing-application-request-routing-arr/install-application-request-routing).

Another prerequisite is that you have gone through [Using the Application Request Routing Module](/iis/extensions/planning-for-arr/using-the-application-request-routing-module) and have configured Application Request Routing. Application Request Routing should be in working order before proceeding with the following sections.

## Step 1: Configure Failed Request Tracing rules

Configure the Failed Request Tracing rules for Application Request Routing using the UI or using the command-line.

### How to configure Failed Request Tracing rules using the UI

1. Launch Internet Information Services (IIS) Manager (inetmgr).
1. Select **Default Web Site**.  
    :::image type="content" source="media/troubleshoot-arr-using-frt-rules/site-list-expanded.png" alt-text="Screenshot showing the Sites list expanded. Default Web Site is highlighted.":::
1. In the **Actions** pane, under **Configure**, select **Failed Request Tracing…**.  
    :::image type="content" source="media/troubleshoot-arr-using-frt-rules/failed-request-tracing-in-action-pane.png" alt-text="Screenshot focused on Failed Request Tracing in the Actions pane.":::
1. In the **Edit Web Site Failed Request Tracing Settings** dialog box, select the **Enable** checkbox.  
    :::image type="content" source="media/troubleshoot-arr-using-frt-rules/edit-web-site-frt-settings-dialog.png" alt-text="Screenshot of the Edit Web Site Failed Request Tracing Settings dialog.":::
1. Select **OK** to save changes.  
1. Select **Default Web Site**.
1. Double-click **Failed Request Tracing Rules**.
1. In the **Actions** pane, select **Add…**.  
    :::image type="content" source="media/troubleshoot-arr-using-frt-rules/add-frt-rule-window.png" alt-text="Screenshot of the Add Failed Request Tracing Rule window. All content is selected.":::  
    Select **All content (\*)**, and then select **Next**.
1. Select **Status code(s):** and enter _200-399_.  
    :::image type="content" source="media/troubleshoot-arr-using-frt-rules/add-frt-rule-select-status-code.png" alt-text="Screenshot of the Add Failed Request Tracing Rule. Status code is checked.":::  
    Select **Next**. The above configuration has created a Failed Request Tracing rule that writes traces when the status code falls between 200 and 399.
1. Deselect **ASP**,**ASPNET**, and **ISAPI Extension**. After selecting **WWW Server**, deselect everything under **Areas:**, except for **Rewrite** and **RequestRouting**. Because Application Request Routing relies on the URL Rewrite Module to inspect incoming requests, it's recommended that you enable the traces for both Application Request Routing (**RequestRouting**) and URL Rewrite Module (**Rewrite**).  
    :::image type="content" source="media/troubleshoot-arr-using-frt-rules/edit-frt-rule-window.png" alt-text="Screenshot of the Edit Failed Request Tracing Rule window. W W W server is selected in the Providers section.":::  
    For additional information about URL Rewrite Module traces, see [Using Failed Request Tracing to Trace Rewrite Rules](/iis/extensions/url-rewrite-module/using-failed-request-tracing-to-trace-rewrite-rules) .
1. Select **Finish**.

### How to configure Failed Request Tracing rules using the command-line

1. Open a command prompt with administrator privileges.
1. Navigate to `%windir%\system32\inetsrv`.
1. To enable Failed Request Tracing on the Default Web Site, run the following command:

    ```console
    appcmd set site "Default Web Site" -traceFailedRequestsLogging.enabled:"true" /commit:apphost
    ```

1. To configure the Failed Request Tracing Rules as shown in the UI above, run the following commands:  

    ```console
    appcmd.exe set config "Default Web Site" -section:system.webServer/tracing/traceFailedRequests /+"[path='*']"
    ```

    ```console
    appcmd.exe set config "Default Web Site" -section:system.webServer/tracing/traceFailedRequests /+"[path='*'].traceAreas.[provider='WWW Server',areas='Rewrite,RequestRouting',verbosity='Verbose']"
    ```

    ```console
    appcmd.exe set config "Default Web Site" -section:system.webServer/tracing/traceFailedRequests /[path='*'].failureDefinitions.statusCodes:"200-399"
    ```

## Step 2: Analyze Failed Request Tracing Logs

In this step, you'll send requests to Application Request Routing and analyze Failed Request Tracing logs.

### To view Failed Request Tracing logs

1. Navigate to the directory where the Failed Request Tracing logs are written. By default, the location is `%SystemDrive%\inetpub\Logs\FailedReqLogFiles\`.
1. Change the directory to the folder that matches the **Default Web Site**. By default, it's _W3SVC1_. If you're unsure, select the **Default Web Site** in IIS Manager, and then select **Advanced Settings…** in the **Actions** pane. The value of the **ID** indicates the corresponding folder. (For example, ID _1_ corresponds to _W3SVC1_).
1. If there are any XML files, remove them by typing:  

    ```console
    del *.xml
    ```

1. Send a request to Application Request Routing. If Application Request Routing is functioning correctly, it results in a 200 response, which falls within the 200 to 399 range that is specified in [Step 1](#step-1-configure-failed-request-tracing-rules). Therefore, the logs are written to the location above.  
1. List the files in the directory to confirm that new XML files are written.
1. Open the XML file. Select **Request Details**. Select **Complete Request Trace**, and then Select **Expand All**. The following image is an example of a Failed Request Tracing log for Application Request Routing:  
    :::image type="content" source="media/troubleshoot-arr-using-frt-rules/request-diagnostics-for-sample.png" alt-text="Screenshot of a browser window showing the Request Diagnostics for the example website in a tab.":::
1. Pay closer attention to the following sections:

    - **GENERAL\_REQUEST\_HEADERS:**  

        - **Headers**: Shows the HTTP header that Application Request Routing has received.

    - **ARR\_REQUEST\_ROUTED:**  

        - **WebFarm**: Indicates the name of the server group where the request is routed.
        - **Server**: Indicates the destination server where the request is routed.
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
        - **ARR\_RESPONSE\_HEADERS\_START**
        - **ARR\_RESPONSE\_HEADERS\_END**
        - **ARR\_RESPONSE\_ENTITY\_START**
        - **ARR\_RESPONSE\_ENTITY\_END**
        - **ARR\_RESPONSE\_ENTITY\_START**
        - **ARR\_RESPONSE\_ENTITY\_END**

If you're collecting the Failed Request Tracing logs on server core, copy the logs with _freb.xsl_ stylesheet to a computer where a browser is available.

## Summary

You have now successfully configured Failed Request Tracing rules for Application Request Routing. Failed Request Tracing rules can be used to troubleshoot and debug Application Request Routing, as well as understand the routing decisions, including load balance algorithms, that it has made in selecting the destination server for a given request.
