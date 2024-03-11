---
title: Autoscale is not triggered for FileUploader role
description: Provides information about troubleshooting issues in which autoscale is not triggered for FileUploader role although CPU utilization in one of the instances always stays at 100%.
ms.date: 09/26/2022
ms.reviewer: 
author: genlin
ms.author: genli
ms.service: cloud-services
ms.subservice: troubleshoot-dev
---
# Autoscale is not triggered for FileUploader role

This article provides information about troubleshooting issues in which autoscale is not triggered for FileUploader role although CPU utilization in one of the instances always stays at 100%.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464899

> [!NOTE]
> Refer to the article on [Azure Cloud Service Troubleshooting Series](https://support.microsoft.com/help/4466645), this is the third scenario of the lab. Make sure you have followed the lab setup instructions for **Compressor** application as per [this](https://github.com/prchanda/compressor), to recreate the problem.

## Symptoms

One of the FileUploader role instances (FileUploader_IN_1) is consuming 100% CPU, whereas in the other two instances CPU utilization is normal. As per the lab instruction, you have created an autoscale rule for **FileUploader** role based on "Percentage CPU" metric but it is not triggering for some reason.

CPU utilization from all the instances:

:::image type="content" source="media/scenario-3-autoscale-not-trigger-fileuploader/cpu-utilization-fileuploader-0.png" alt-text="Screenshot of CPU utilization showing FileUploader_IN_0 instance is consuming 3% CPU.":::

:::image type="content" source="media/scenario-3-autoscale-not-trigger-fileuploader/cpu-utilization-fileuploader-1.png" alt-text="Screenshot of CPU utilization showing FileUploader_IN_1 instance is consuming 100% CPU.":::

:::image type="content" source="media/scenario-3-autoscale-not-trigger-fileuploader/cpu-utilization-fileuploader-2.png" alt-text="Screenshot of CPU utilization showing FileUploader_IN_2 instance is consuming 3% CPU.":::

## Troubleshoot steps

If you carefully look into the autoscale rule that we have configured, it says the rule will get triggered only if the average CPU utilization of all the role instances is greater than 90, which is not happening in this case.

```xml
{
   "properties": {
      "name": "Autoscale based on CPU metric",
      "enabled": true,
      "targetResourceUri": "/subscriptions/{subscription-id}/resourceGroups/cloudservicelab/providers/Microsoft.ClassicCompute/domainNames/cloudservicelabs/slots/Production/roles/FileUploader",
      "profiles": [
         {
            "name": "Auto created scale condition",
            "capacity": {
               "minimum": "1",
               "maximum": "4",
               "default": "1"
            },
            "rules": [
               {
                  "scaleAction": {
                     "direction": "Increase",
                     "type": "ChangeCount",
                     "value": "1",
                     "cooldown": "PT10M"
                  },
                  "metricTrigger": {
                     "metricName": "Percentage CPU",
                     "metricNamespace": "",
                     "metricResourceUri": "/subscriptions/{subscription-id}/resourceGroups/cloudservicelab/providers/Microsoft.ClassicCompute/domainNames/cloudservicelabs/slots/Production/roles/FileUploader",
                     "operator": "GreaterThan",
                     "statistic": "Average",
                     "threshold": 90,
                     "timeAggregation": "Average",
                     "timeGrain": "PT5M",
                     "timeWindow": "PT30M"
                  }
               }
            ]
         }
      ],
      "notifications": [],
      "targetResourceLocation": "southcentralus"
   }
}
```

[Set up diagnostics for Azure Cloud Services](/azure/vs-azure-tools-diagnostics-for-cloud-services-and-virtual-machines) and check the CPU utilization of each role instance from **WADPerformanceCountersTable**. You can also fetch metric data for the cloud service role using [this REST API](/rest/api/monitor/metrics/list) or [PowerShell](https://gallery.technet.microsoft.com/How-to-use-PowerShell-to-bc7aab03) as well.

You can also monitor the average CPU utilization of FileUploader role from **Metrics** tab in your cloud service resource. So as you can see from the below graph the average CPU utilization is around 33.35% that is quite below the threshold.

:::image type="content" source="media/scenario-3-autoscale-not-trigger-fileuploader/average-cpu-utilization.png" alt-text="Screenshot of the average CPU utilization of FileUploader role.":::

So the bottom line is autoscaling rules that use a detection mechanism based on a measured trigger attribute (such as CPU usage) use an aggregated value over time, rather than instantaneous values, to trigger an autoscaling action. By default, the aggregate is an average of the values across all the instances of the role. So, in case of multiple instances, each PaaS VM reports a number for percentage CPU. To consolidate these, the cloud service role calculates the "statistic" across all of the instances. For instance, if there were three instances in a cloud service role, one running at 30% CPU, second one at 60% and another running at 90% CPU, the role would emit an average CPU utilization of 60%.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
