---
# Required metadata
		# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
		# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

		title:       # Add a title for the browser tab
description: # Add a meaningful description for search results
author:      rkahng # GitHub alias
ms.author:   ryankahng # Microsoft alias
ms.service:  # Add the ms.service or ms.prod value
# ms.prod:   # To use ms.prod, uncomment it and delete ms.service
ms.topic:    # Add the ms.topic value
ms.date:     04/21/2023
---

# Troubleshoot Code Optimizations

This article provides troubleshooting steps and information for using Azure Application Insights Profiler.
## Make sure your app is connected to an Application Insights resource

[Create an Application Insights resource](/azure/azure-monitor/app/create-workspace-resource) and make sure it's connected to the right app
## Make sure you have the Application Insights Profiler enabled

[Enable the Application Insights Profiler](/azure/azure-monitor/profiler/profiler-overview)
## Keep checking back

If you met all the requirements listed above, keep checking back for insights. In the meantime, our service will continue to analyze your profiles and will provide insights as soon as it detects any issues in your code (after you enable the Application Insights Profiler, it may take a few hours for you to generate profiles and for our service to analyze them).
