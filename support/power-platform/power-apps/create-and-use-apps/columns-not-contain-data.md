# Some columns don't contain data

In this situation, data is not displayed at all in certain columns. This issue is often caused by the discrepancies between the fetchXML request (the query for data) and the layoutXML (the column definitions), which may be due to custom code that incorrectly modifies the query. Make sure to follow [these](#steps-to-perform-before-starting-troubleshooting) steps first.

**<u>How to troubleshoot:</u>**

First, you should ensure the issue is not related to insufficient permissions. The easiest way to check this is to navigate to the page but as a user with full administrative privileges. The monitoring tool can also be used to ensure the column data "is readable".
![Image](images/image11.png)

If the issue is not related to insufficient permissions, then please use the monitoring tool to check the query and columns definition as shown in the screenshot below.

![Image](images/image12.png)


Make sure that all the columns listed in the "viewFields" section are present in the "viewFetchXML" query and that the respective columns are not marked as "hidden".

The issue can also be caused by a corrupt view. Re-saving and re-publishing such a view may help address the problem.