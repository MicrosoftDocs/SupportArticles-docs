---
title: Filter Fiddler Traffic Using Domain Names and Client Processes
description: Introduces how to filter traffic that's captured by Fiddler using domain/host names owned by Microsoft Entra and client processes.
ms.service: entra-id
ms.topic: how-to
ms.date: 04/07/2025
ms.reviewer: bachoang, v-weizhu
ms.custom: sap:Enterprise Applications
---
# Filter Fiddler traffic using domain names and client processes

This article explains how to filter traffic that's captured by Fiddler using domain/host names owned by Microsoft Entra and client processes.

## Prerequisites

Before filtering, ensure that Fiddler is configured to capture traffic for all processes. In the lower-left corner of the Fiddler window, you can select **All processes** to change the selection.

 :::image type="content" source="media/filter-fiddler-traffic-using-domain-name-client-process/all-processes.png" alt-text="Screenshot that shows the 'All processes' button.":::

## Filter traffic using Fiddler's built-in filter feature

To filter traffic using Fiddler's built-in filter feature, follow these steps:

1. Open Fiddler and navigate to the right panel.
2. Select the **Filters** tab, and then select the **Use Filters** checkbox.
3. Under the **Hosts** section, select **Show only the following Hosts**.
4. In the text box, enter the host name list you want to filter on, separated by semicolons, for example, `localhost;login.microsoftonline.com;graph.microsoft.com`.

    > [!NOTE]
    > This text box will display a yellow background while editing the list, indicating unsaved changes.
5. Select the **Actions** button to save the list. The background color will change to white, confirming the list is saved.

 :::image type="content" source="media/filter-fiddler-traffic-using-domain-name-client-process/show-only-the-following-hosts.png" alt-text="Screenshot that shows how to filter traffic based on host names.":::

Under the **Client Process** section, you can also select a specific process to filter on. This is particularly useful for filtering a standalone application. It might be less effective for capturing browser traffic because multiple processes with the same name can make it difficult to identify the correct one.

## Filter traffic using JavaScript code in the OnBeforeRequest function

> [!NOTE]
> This option is used especially for browser-based applications.

1. In Fiddler, go to **Rules** > **Customize Rules**. This action will open the **CustomRules.js** file in the FiddlerScript editor.
2. Locate the **OnBeforeRequest** function in the FiddlerScript editor.
3. Insert the following JavaScript code at the beginning of the function:

    ```javascript
    // begin filter
    
    // set this to false to disable filter and true to enable filter
    var filterOn = true;
    
    if (filterOn)
    {
        // hide all requests by default
        oSession["ui-hide"] = "true";
        
        // list of domain names to filter on
        var host = ["localhost", "login.microsoftonline.com", "graph.microsoft.com"];
        
        // list of processes to filter on
        var processlist = ["chrome", "microsoftedgecp", "iisexpress", "powershell"];
    
        for (var j = 0; j < processlist.length; j++)
        {
            if (oSession.LocalProcess.Contains(processlist[j]))
            {
                for (var i = 0; i < host.length; i++)
                {
                    if (oSession.HostnameIs(host[i]))
                    {
                        oSession["ui-hide"] = null;
                    }
                }
            }
        }
    }
    
    // end filter
    ```

    :::image type="content" source="media/filter-fiddler-traffic-using-domain-name-client-process/add-javascript-code-onbeforerequest-function.png" alt-text="Screenshot that shows the JavaScript code added in the OnBeforeRequest function." lightbox="media/filter-fiddler-traffic-using-domain-name-client-process/add-javascript-code-onbeforerequest-function.png":::

    Here are the explanations of some variables in the JavaScript code:

    - `filterOn`: Set it to `true` to enable the filter and `false` to disable it.
    - `host`: Contains the list of domain names to filter on.
    - `processlist`: Contains the list of process names to filter on.

4. Save the changes to the **CustomRules.js** file.

## References

- [Modifying a Request or Response](http://docs.telerik.com/fiddler/KnowledgeBase/FiddlerScript/ModifyRequestOrResponse)
- [FiddlerScript Cookbook](http://fiddlerbook.com/Fiddler/dev/ScriptSamples.asp)
- [Understanding FiddlerScript](https://www.telerik.com/blogs/understanding-fiddlerscript)

[!INCLUDE [Azure Help Support](../../../includes/third-party-disclaimer.md)]
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]