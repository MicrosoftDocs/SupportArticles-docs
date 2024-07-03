# Quick Find does not produce correct results

The most common case of incorrect results on using Quick Find search is the case when the search is not applied on the expected columns (more information on Quick Find search can be found [here](https://community.dynamics.com/blogs/post/?postid=0ffbe287-8d5e-488f-a50d-737c7c5c0732)).

**<u>How to troubleshoot:</u>**

Use the monitoring tool to inspect the fetchXML query that is generated on using the Quick Find search (see Image 6 above). Please also check the "recordsCount" attribute (see image 5 above). The Quick Find filter is marked with "isquickfindfields" attribute.

![Image](images/image23.png)

If the columns from the "isquickfindfields" filters do not seem to be correct, then this is a strong indication that the "Use quick find" org setting is not set correctly:
![Image](images/image24.png)

If the respective org setting is turned off, the search will be performed on all the searchable columns (please see [this document](https://learn.microsoft.com/en-us/power-apps/maker/data-platform/types-of-fields) for more details). If the org setting is enabled, then the search will be performed based on entity's quick find view. Please also note that the entity's quick find view may also contain a filter that will also be applied on search. You should be able to see that filter in the inspected fetchXML data query.