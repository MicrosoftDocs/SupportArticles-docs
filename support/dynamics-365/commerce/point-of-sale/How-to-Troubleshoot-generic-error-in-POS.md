Receiving a generic error in POS such as "*Something went wrong*" is not very helpful determining what the underlying issue is when you encounter the error. Before opening a support case for more details behind this error, customers do have the ability log into LCS to review Telemetry data on this failure.

 

First, gather the following details from POS:

1.  Date/time that this occurred

2.  Application Session ID

3.  User Session ID

4.  Awareness of what was being done to encounter this error so you can follow the flow

 

These same details are great to provide in a support ticket if you need additional assistance on the issue.

 

Go to: LCS &gt; \*yourcompany\* &gt; Monitoring &gt; Environment monitoring &gt; Activity

Query name: Retail Channel events

Date/time in UTC: (this is the specific time of the failure, can expand out the timeframe as needed once you locate the error)

   If the specific error occurred on POS at **2023-07-15 01:07:34 UTC**  to set a starting point of search

   2023/07/15 01:07:00

   2023/07/15 01:08:00

Log Source: Retail Cloud POS or Retail Modern POS

Search terms: you can enter part of the error message to help narrow the search, or leave it blank for a general search result

AppSessionID:   enter ID

UserSessionID:  enter ID

Show options &gt; Row limit: 500

Click Search

Order by the Event time

Review logs

 

 

If you find any requests that were sent to the RCSU that you want to view as the error could have come from there, you would:

1\. Find the value in the **requestId** column (copy it)

2\. Change the **Log Source to Retail Cloud Scale Unit**

3\. Clear the App and User session fields

4\. Enter the copied value into the **Request ID** field

5\. This returns the start/finish of this Request ID, to see more details, obtain the Activity ID

6\. Paste the Activity ID into the left search Activity ID field (Clear the Request ID field)

7\. Click search

** **

![A screenshot of a computer Description automatically generated](media/image1.png)
