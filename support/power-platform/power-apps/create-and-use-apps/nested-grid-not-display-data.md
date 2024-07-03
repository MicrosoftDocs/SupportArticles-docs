# Nested grid does not display data

This applies to cases when the nested grid does not display any data. The most common issue is in incorrect relationship used or incorrect view applied.

**<u>How to troubleshoot:</u>**

First, let's make sure the nested grid is configured with a correct relationship.
![Image](images/image25.png)
The "Child Items Parent Id" parameter in the screenshot above must be set to a Lookup type field from the entity that is assigned to the parent grid (Accounts in the screenshot above). The Lookup field should point to the nested grid entity. Please make sure this is a standard Lookup type with a standard N:1 (many-to-one) relationship.

The next thing to check is the view that is assigned to the nested grid (My Active Accounts in the example above) to make sure it does not contain any unintended filters.

Finally, use the monitoring tool to inspect the data for the nested grid (see image below).

![Image](images/image26.png)

Note the "childRecordsCount" attribute that should display the number of records in the nested dataset. If that attribute shows 0 records then this is a strong indication of an incorrect relationship specified, the presence of extra filters in the nested grid view, or no records in the nested dataset (ChildItems). If that number shows a greater than zero value and your nested grid still does not display any records, then the issue is most likely with the extra filtering present in the nested grid view or with no related records to the row that is expanded from the parent grid. Please check the "childViewFetchXML" and "ChildViewFields" and make sure all the filters are correct and all the column definitions match the ones specified in "childViewFetchXML".