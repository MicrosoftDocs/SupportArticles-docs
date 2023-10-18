---
title: Troubleshoot generic errors displayed on the POS
description: Lists the steps you can take to investigate a generic error displayed on the POS in Dynamics 365 Commerce.
author: bstorie
ms.author: brstor
ms.date: 10/12/2023
---
# Troubleshoot generic errors displayed on the POS

Encountering a generic error message like "Something went wrong" on the Point of Sale (POS) can be frustrating as it doesn't provide specific details about the underlying issue. However, before reaching out to Microsoft Support for more information, you can sign in to [Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index) to review the telemetry data related to this failure. This might provide more insight into the problem.

## Prerequisites

First, collect the following details from the POS:

1. The date and time when the error occurred.
2. The Application session ID.
3. The User session ID.
4. The actions that led to the error so that you can follow the flow.

## Troubleshooting steps

1. Sign in to [Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index) using your company account. Navigate to **Monitoring** > **Environment monitoring** > **Activity**.

2. Configure the following fields:

     - **Query name**: Set this to **Retail Channel events**.
     - **Date/time in UTC**: Enter the specific time of the failure. You can adjust the timeframe as necessary until you find the error.

       For example, if the specific error occurred on the POS at **2023-07-15 01:07:34 UTC**, you should:

       - Set the **Start Time** to: 2023/07/15 01:07:00  
       - Set the **End time** to: 2023/07/15 01:08:00

     - **Log Source**: Select either **Retail Cloud POS** or **Retail Modern POS**.
     - **Search terms**: Enter part of the error message to narrow the search, or leave it blank for a broader search result.
     - **AppSessionID**: Enter the ID.
     - **UserSessionID**: Enter the ID.
     - **Show options** > **Row limit**: Set this to 500.

3. Select **Search**.
4. Order the results by **Event time**.
5. Review the log results for your error.

If you find some requests that were sent to the RCSU (Retail Server) in the POS logs and you want to investigate them (since the error might originate from the RCSU), follow these steps:

1. In the POS log search results, find the value in the **requestId** column and copy it.
2. Change **Log Source** to **Retail Cloud Scale Unit**.
3. Clear the App and User session fields.
4. Paste the copied value into the **Request ID** field. This returns the start/end of this request ID. To see more details, locate the **Activity ID** column and copy its value.
5. Paste the copied Activity ID into the **Activity ID** field. Remember to clear the **Request ID** field.
6. Select **Search**.
7. You can now review the RCSU search result logs as shown below.

   :::image type="content" source="media/troubleshoot-generic-error-in-pos/example-of-environment-monitoring-search-results.png" alt-text="Screenshot that shows the environment monitoring search results." lightbox="media/troubleshoot-generic-error-in-pos/example-of-environment-monitoring-search-results.png":::

## Engaging Microsoft Support

When opening a support ticket for issues on the POS, include the details listed in the [Prerequisites](#prerequisites) section of this document to help speed up the troubleshooting process.
