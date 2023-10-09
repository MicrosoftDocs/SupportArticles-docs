---
title: Troubleshoot generic errors displayed on the POS
description: Lists the steps you can take to investigate a generic error displayed on the POS in Dynamics 365 Commerce.
author: bstorie
ms.author: brstor
ms.date: 10/09/2023
---
# Troubleshoot generic errors displayed on the POS

Encountering a generic error message like "Something went wrong" on the Point of Sale (POS) can be frustrating as it doesn't provide specific details about the underlying issue. However, before reaching out to Microsoft Support for more information, you can sign in to [Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index) to review the telemetry data related to this failure. This might provide more insight into the problem.

## Prerequisites

First, collect the following details from the POS:

1. The date and time when the error occurred.
2. The Application Session ID.
3. The User Session ID.
4. The actions that led to the error so you can follow the flow.

> [!NOTE]
> Including these details in your support ticket would be helpful if you need further assistance with the issue.

## Troubleshooting steps

1. Sign in to [Lifecycle Services (LCS)](https://lcs.dynamics.com/Logon/Index) using your company account. Navigate to **Monitoring** > **Environment monitoring** > **Activity**.

2. Configure the following fields:

     - **Query name**: Set this to **Retail Channel events**.
     - **Date/time in UTC**: Enter the specific time of the failure. You can adjust the timeframe as necessary until you find the error.

       For example, if the specific error occurred on the POS at **2023-07-15 01:07:34 UTC**, you should:

       - Set the **Start Time** to: 2023/07/15 01:07:00  
       - Set the **End time** to: 2023/07/15 01:08:00

     - **Log Source**: Select either **Retail Cloud POS** or **Retail Modern POS**.
     - **Search terms**: Enter a part of the error message to narrow down the search, or leave it blank for a broader search result.
     - **AppSessionID**: Input an ID.
     - **UserSessionID**: Input an ID.
     - **Show options** > **Row limit**: Set this to 500.

3. Select **Search**.
4. Order the results by the **Event time**.
5. Review logs results for your error.

If you find some requests in the POS logs that were sent to the RCSU (Retail Server) and you want to investigate them (since the error could have originated from the RCSU), follow these steps:

1. In the POS log search results, find the value in the **requestId** column and copy it.
2. Change the **Log Source** to **Retail Cloud Scale Unit**.
3. Clear the App and User session fields.
4. Paste the copied value in the **Request ID** field. This returns the start/finish of this request ID. To see more details, locate the **Activity ID** column and copy its value.
5. Paste the **Activity ID** into the left search **Activity ID** field. Remember to clear the **Request ID** field.
6. Select **Search**.
7. You can now review the RCSU search result logs as shown below.

![Image showing Environment Monitoring Search results](Example-of-environment-monitoring-search-results.png)
