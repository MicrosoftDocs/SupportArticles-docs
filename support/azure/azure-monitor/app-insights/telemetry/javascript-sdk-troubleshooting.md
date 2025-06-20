---
title: Troubleshoot issues that involve the App Insights JavaScript SDK
description: Learn how to troubleshoot SDK load failure for JavaScript web applications, Azure Application Insights for web pages, and source map support for JavaScript apps.
ms.date: 06/24/2024
editor: v-jsitser
ms.service: azure-monitor
ms.devlang: javascript
ms.custom: sap:Missing or Incorrect data after enabling Application Insights in Azure Portal, devx-track-js
ms.reviewer: mmcc, toddfous, aaronmax, v-leedennis
---

# Application Insights JavaScript SDK troubleshooting

This article discusses how to troubleshoot various issues that involve the [Application Insights JavaScript SDK](https://github.com/Microsoft/ApplicationInsights-JS). The subjects in this article include SDK load failure for JavaScript web apps and source map support for JavaScript apps.

[!INCLUDE [Azure Help Support](../../../../includes/azure/application-insights-sdk-support.md)]

<!-- 
Editor's Note: This link name above "SDK Load Failure" has a direct references by https://go.microsoft.com/fwlink/?linkid=2128109 which is embedded in the snippet and from the JavaScript Page. If you change this text you MUST also update these references.
-->

## Troubleshoot SDK load failure for JavaScript web apps

The following sections discuss the symptoms, causes, and solutions for a specific SDK load failure scenario for JavaScript web apps.

### Symptoms

In the \<head> element of the web page that you're monitoring, the [JavaScript snippet][snippet-based-setup] (version 3 or a later version) creates and reports the following exception when it detects that the SDK script didn't download or initialize:

> SDK LOAD Failure: Failed to load Application Insights SDK script (See stack for details)

This message indicates that the user's client (browser) can't download the Application Insights SDK or initialize from the identified hosting page. Therefore, you don't see any telemetry or events.

:::image type="content" source="./media/javascript-sdk-troubleshooting/overview.png" alt-text="Azure portal screenshot of the exception titled 'SDK LOAD Failure: Failed to load Application Insights SDK script (See stack for details).'" lightbox="./media/javascript-sdk-troubleshooting/overview.png":::

> [!NOTE]
> This exception is supported on all major browsers that support the `fetch()` API or `XMLHttpRequest`. These browser versions exclude Microsoft Internet Explorer 8 and earlier versions. Therefore, those browsers will not report this type of exception unless your environment includes a fetch polyfill.

:::image type="content" source="./media/javascript-sdk-troubleshooting/exception.png" alt-text="Azure portal screenshot of the 'SDK LOAD Failure' exception. Details include the call stack, event time, message, exception type, and failed method." lightbox="./media/javascript-sdk-troubleshooting/exception.png":::

The stack details include the basic information about the URLs that are being used by the user.

| Name                 | Description                                                     |
|----------------------|-----------------------------------------------------------------|
| \<CDN&nbsp;Endpoint> | The URL that was used (and failed) to download the SDK.         |
| \<Help&nbsp;Link>    | A URL that links to troubleshooting documentation (this page).  |
| \<Host&nbsp;URL>     | The complete URL of the page that the user was using.       |
| \<Endpoint&nbsp;URL> | The URL that was used to report the exception. This value might help identify whether the public internet or a private cloud accessed the hosting page. |

The following list contains the most common reasons why this exception occurs:

- Intermittent network connectivity failure

- Application Insights Content Delivery Network (CDN) outage

- SDK initialization failure after loading the script

- Blockage of the Application Insights JavaScript CDN

[Intermittent network connectivity failure](#cause-1-intermittent-network-connectivity-failure) is the most common reason for this exception, especially in mobile roaming scenarios.

The following sections discuss how to troubleshoot each potential root cause of this error.

> [!NOTE]  
> Some of these steps assume that your application has direct control of the [Snippet \<script /> tag][snippet-based-setup] and its configuration that's returned as part of the hosting HTML page. If these conditions don't apply to your scenario, these steps also don't apply.

### Cause 1: Intermittent network connectivity failure

If the user experiences intermittent network connectivity failures, there are fewer possible solutions than for other causes. However, this failure usually resolves itself quickly. For example, if the user refreshes the page to reload your site, the files eventually get downloaded and cached locally until the release of an updated version.

#### Solution 1a: Download an updated version of the SDK

To minimize intermittent network connectivity failure, we implemented `Cache-Control` headers on all the CDN files. After the user's browser downloads the current version of the SDK, it doesn't have to download it again because it reuses the previously obtained copy. (See [how caching works](/azure/cdn/cdn-how-caching-works).) If the caching check fails or there's a new release available, the user's browser has to download the updated version. Therefore, you might see a background level of *"noise"* in the check failure scenario. Or, you might see a temporary spike when a new release occurs and becomes generally available (deployed to the CDN).

#### Solution 1b: Use npm packages to embed the SDK together with the application in a single bundle

Is the SDK load failure exception persistent, and does it occur for many users together with a reduction in normal client telemetry? In this case, intermittent network connectivity issues probably aren't the true cause of the problem, and you should explore other possible causes.

> [!NOTE]  
> A common indication that this failure occurs for multiple users is that the exception is reported at a rapid and sustained level.

In this situation, hosting the SDK on your own CDN is unlikely to provide or reduce the occurrences of this exception. The same issue affects your own CDN and it occurs also if you use the SDK through an npm package solution. Failure of the latter scenario occurs especially if Application Insights is included in a different [bundle](/aspnet/mvc/overview/performance/bundling-and-minification) from that of the application that's being monitored, because the failure is guaranteed to occur in at least one of those bundles. From the user's perspective, when this exception occurs, your entire application fails to load or initialize, not just the telemetry SDK (that users don't see). Therefore, users will probably continue to refresh your site until it loads completely.

You can try to [use npm packages to embed the Application Insights SDK](#solution-4b3-use-npm-packages-to-embed-the-application-insights-sdk) together with the monitored application in a single bundle. Although an intermittency failure might still occur in this scenario, a combined bundle does offer a real chance of fixing the problem.

### Cause 2: Application Insights CDN outage

To verify that there's an Application Insights CDN outage, try to access the CDN endpoint directly from the browser from a different location than that of your users. For example, you can try accessing <https://js.monitor.azure.com/scripts/b/ai.2.min.js> from your own development computer. (This assumes that your organization hasn't blocked this domain.)

#### Solution 2: Create a support ticket

If you verify that an outage exists, you can [create a new support ticket][support-ticket].

### Cause 3: SDK didn't initialize after loading the script

If the SDK doesn't initialize, the \<script /> is still successfully downloaded from the CDN, but it fails during initialization. This failure occurs because of missing or invalid dependencies, or because of some form of JavaScript exception.

#### Solution 3: Check for a successful SDK download or JavaScript exceptions, or enable browser debugging

##### Step 1: Check for a successful SDK download

Check whether the SDK downloaded successfully. If no script download occurred, this scenario isn't the cause of the SDK load failure exception. Use a browser that supports developer tools. Select F12 to view the developer tools, and then select the **Network** tab. Verify that the script that's defined in the [src snippet configuration][snippet-configuration-options] was downloaded. To do this, check for response code `200` (success) or `304` (not changed). To review the network traffic, you can also use a web debugging tool such as [Fiddler](https://www.telerik.com/fiddler).

If the SDK didn't download successfully, review the following table to understand the different reporting options.

| Scenario | Cause | Action |
|---|---|---|
| The issue affects only a few users and a specific browser version or a subset of browser versions. (Check the details on the reported exception.) | The issue is likely only if specific users or environments require your application to provide extra `polyfill` implementations. | [File an issue on GitHub][github-issue]. |
| The issue affects your entire application and all your users. | It's a release-related issue. | [Create a new support ticket][support-ticket]. |

If the SDK downloaded successfully, review the following sections to help fix the SDK initialization problem.

##### Step 2: Check for JavaScript exceptions

Check for JavaScript exceptions. Use a browser that supports developer tools. Select F12 to view the developer tools, load the page, and then check whether any exceptions occurred. Does the SDK script (for example, in *ai.2.min.js*) causes exceptions? In this case, one of the following scenarios occurred:

- The configuration that's passed to the SDK contains an unexpected configuration.

- The configuration that's passed to the SDK is missing a required configuration.

- A faulty release was deployed to the CDN.

To check for a faulty configuration, change the configuration that's passed to the snippet (if you haven't already done this) so that it includes only your instrumentation key as a string value. The following code shows an example snippet configuration change.

> [!NOTE]  
> Support for instrumentation key ingestion ends on March 31, 2025. Instrumentation key ingestion will continue to work, but we'll no longer provide updates or support for the feature. See [Transition to connection strings](/azure/azure-monitor/app/migrate-from-instrumentation-keys-to-connection-strings) to take advantage of [new capabilities](/azure/azure-monitor/app/migrate-from-instrumentation-keys-to-connection-strings#new-capabilities).

```js
<script type="text/javascript">
...
src: "https://js.monitor.azure.com/scripts/b/ai.2.min.js",
cfg: {
    instrumentationKey: "<instrumentation-key-guid>"
}});
</script>
```

When you use this minimal configuration, if you still see a JavaScript exception in the SDK script, [create a new support ticket][support-ticket]. To fix the issue, you must roll back the faulty build. This is because a newly deployed version is probably the cause of the issue.

If the exception disappears, a type mismatch or unexpected value is probably causing the issue. Start troubleshooting by restoring your configuration options one by one, and test after each change until the exception occurs again. Next, check the documentation for the item that causes the issue. If the documentation is unclear, or if you need assistance, [file an issue on GitHub][github-issue].

Was your configuration previously deployed and working, but is now reporting this exception? In this case, there might be an issue that affects a newly deployed version. Check whether the exception affects only a small set of your users or browsers. Either [file an issue on GitHub][github-issue] or [create a new support ticket][support-ticket].

##### Step 3: Enable browser console debugging

If no thrown exceptions occurred, you should enable console debugging by adding the [loggingLevelConsole setting][snippet-configuration-fields] to the configuration, as shown in the following snippet configuration example. This change sends all initialization errors and warnings to the browser's console. (To view the browser console, select F12 to open the developer tools, and then select the **Console** tab.) Any reported errors should be self-explanatory. If you need further assistance, [file an issue on GitHub][github-issue].

```js
<script type="text/javascript">
...
src: "https://js.monitor.azure.com/scripts/b/ai.2.min.js",
cfg: {
    instrumentationKey: "<instrumentation-key-guid>",
    loggingLevelConsole: 2
}});
</script>
```

> [!NOTE]
> During initialization, the SDK does some basic checks for known major dependencies. If the current runtime doesn't provide these checks, the runtime reports the failures as warning messages to the console (but only if the `loggingLevelConsole` setting value is greater than zero).

If the SDK still doesn't initialize, try enabling the [enableDebug configuration setting][snippet-configuration-fields]. After you make this change, all internal errors get thrown as exceptions. This causes a loss of telemetry. Because this setting is for developers only, it probably causes more exceptions to be thrown because of internal checks. Review each exception to determine which issue is causing the SDK to fail. Use the unminified version of the script (by changing the file name extension from *.min.js* to just *.js*). Otherwise, the exceptions are unreadable. The following code shows the example snippet configuration changes.

> [!WARNING]  
> This developer-only setting should NEVER be enabled in a full production environment because doing this causes you to lose telemetry.

```js
<script type="text/javascript">
...
src: "https://js.monitor.azure.com/scripts/b/ai.2.js",
cfg:{
    instrumentationKey: "<instrumentation-key-guid>",
    enableDebug: true
}});
</script>
```

If this action still doesn't provide any insights, you should [file an issue on GitHub][github-issue] by providing the details and an example site, if you use one. Include the browser version, operating system, and JavaScript framework details to help identify the issue.

### Cause 4: Blockage of the Application Insights JavaScript CDN

A CDN blockage is possible if an Application Insights JavaScript SDK CDN endpoint is reported or identified as unsafe. In this situation, the endpoint is publicly blocklisted, and consumers of these lists start to block all access.

To resolve this issue, the owner of the CDN endpoint should work with the blocklisting entity that marked the endpoint as unsafe. Then, the blocklisting entity can remove the endpoint from the relevant list.

Check the following internet security websites to learn whether they identify the CDN endpoint as unsafe:

- [Google Transparency Report](https://transparencyreport.google.com/safe-browsing/search)
- [VirusTotal](https://www.virustotal.com/gui/home/url)
- [Sucuri SiteCheck](https://sitecheck.sucuri.net/)

It might take a long time to resolve this issue. Users or corporate IT departments might have to force an update or explicitly allow the CDN endpoints. The total amount of time that's required to resolve this issue depends on the frequency that's required by the application, firewall, or environment to update their local copies of the lists.

If the CDN endpoint is identified as unsafe, [create a support ticket][support-ticket] to resolve the issue as soon as possible.

The following sections outline more specifically how a blockage can occur, and how to fix the blockage.

#### Cause 4a: User blockage (browser, installed blocker, or personal firewall)

Check whether your users have taken any of the following configuration actions:

- Installed a browser plug-in (typically in the form of an ad, malware, or popup blocker)

- Blocked or disallowed the Application Insights CDN endpoints in their browser or proxy

- Configured a firewall rule that causes a blockage of the CDN domain for the SDK (or a failure to resolve the DNS entry)

##### Solution 4a: Add blocklist exceptions for CDN endpoints

If your users took any of the listed configuration actions, work with them (or provide documentation) to allow the CDN endpoints.

Users might have installed plug-ins that use the public blocklist. If not, they're probably using another manually configured solution, or the plug-ins are using a private domain blocklist.

Tell your users to allow the downloading of scripts from the Application Insights CDN endpoints by including the endpoints in their browser's plug-in or firewall rule exception list. These lists vary based on the user environment.

Here's an example of this situation that shows how to [configure Google Chrome to allow or block access to websites](https://support.google.com/chrome/a/answer/7532419?hl=en).

#### Cause 4b: Corporate firewall blockage

If your users are on a corporate network, the corporate firewall is likely the source of the CDN blockage. The corporate IT department has probably implemented some form of internet filtering system.

##### Solution 4b1: Add exceptions for CDN endpoints for corporations

> [!IMPORTANT]  
> Do your users use a [private cloud](https://azure.microsoft.com/overview/what-is-a-private-cloud/), and do they not have access to the public internet? In this case, you have to either [use the Application Insights npm packages to embed the SDK](#solution-4b3-use-npm-packages-to-embed-the-application-insights-sdk), or [host the Application Insights SDK on your own CDN](#solution-4b2-host-the-sdk-on-your-own-cdn).

Work with your company's IT department to allow the necessary rules for your users. This solution is similar to [adding exceptions for users](#solution-4a-add-blocklist-exceptions-for-cdn-endpoints). Have the IT department configure the Application Insights CDN endpoints for download by including (or removing) them in any domain blocklisting or allowlisting services.

##### Solution 4b2: Host the SDK on your own CDN

Instead of having users download the Application Insights SDK from the public CDN, you can host the Application Insights SDK on your own CDN endpoint. We recommend that you use a specific version (*ai.2.#.#.min.js*) of the SDK to make it easier to identify which version you're using. Also, update the SDK regularly to the current version (*ai.2.min.js*) so that you can use any bug fixes and new features that become available.

##### Solution 4b3: Use npm packages to embed the Application Insights SDK

Instead of using the [snippet][snippet-based-setup] and [adding public CDN endpoints](#solution-4a-add-blocklist-exceptions-for-cdn-endpoints), you can use the [npm packages](https://www.npmjs.com/package/applicationinsights) to include the SDK as part of your own JavaScript files. The SDK becomes just another package within your own scripts. For more information, see the [npm-based setup][npm-based-setup] section of the Application Insights JavaScript SDK GitHub page.

> [!NOTE]  
> We recommend that when you use npm packages, you should also use some form of [JavaScript bundler](https://www.bing.com/search?q=javascript+bundler) to help you to do code splitting and minification.

As with the snippet, the same blocking issues that appear here might affect your own scripts (with or without using the SDK npm packages). Depending on your application, your users, and your framework, you might consider implementing something similar to the logic in the snippet to detect and report these issues.

## Troubleshoot source map support for JavaScript applications

The following table explains certain issues that involve [source map support for JavaScript applications](/azure/azure-monitor/app/source-map-support), and it offers strategies to help fix these issues.

| Issue | Description |
|---|---|
| Required Azure role-based access control (Azure RBAC) settings on your blob container | Any user on the portal who uses this feature must be assigned at least a [Storage Blob Data Reader](/azure/role-based-access-control/built-in-roles#storage-blob-data-reader) role for your blob container. You must assign this role to anyone who wants to use the source maps through this feature. Depending on how the container was created, this role might not have been automatically assigned to you or your team. |
| Source map not found | To fix this issue, take the following actions: <ol> <li>Verify that the corresponding source map is uploaded to the correct blob container.</li> <li>Verify that the source map file gets its name from the JavaScript file that it maps to, and that it has a *.map* file name extension. For example, */static/js/main.4e2ca5fa.chunk.js* searches for the blob that's named *main.4e2ca5fa.chunk.js.map*.</li> <li>Check your browser's console to learn whether it's logging any errors. Include this output in any support ticket.</li> </ol> |

## Fix the "Click Event rows with no parentId value" warning

When you use Application Insights and the [Click Analytics Auto-Collection plug-in](/azure/azure-monitor/app/javascript-feature-extensions) in the application, the following telemetry warning might appear in the application insights workbook: "Click Event rows with no parentId value."

### Cause

This issue can occur if the parent ID isn't specified in the parent HTML element. This condition causes the event to be triggered on all of its parent elements.

### Solution

To fix this issue, add the `data-parentid` or `data-<customPrefix>-parentid` attribute to the parent HTML element. Here's an example of the HTML code:

```html
<div data-heart-id="demo Header" data-heart-parentid="demo.Header" data-heart-parent-group="demo.Header.Group">
```

## Next steps

- [Get more help by filing an issue on GitHub][github-issue]
- [Monitor web page usage][app-insights-web-pages]

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]

[app-insights-web-pages]: /azure/azure-monitor/app/javascript
[github-issue]: https://github.com/Microsoft/ApplicationInsights-JS/issues
[npm-based-setup]: /azure/azure-monitor/app/javascript?tabs=snippet#npm-based-setup
[snippet-based-setup]: /azure/azure-monitor/app/javascript?tabs=snippet#snippet-based-setup
[snippet-configuration-fields]: /azure/azure-monitor/app/javascript?tabs=snippet#configuration
[snippet-configuration-options]: /azure/azure-monitor/app/javascript?tabs=snippet#snippet-configuration-options
[support-ticket]: https://azure.microsoft.com/support/create-ticket/
