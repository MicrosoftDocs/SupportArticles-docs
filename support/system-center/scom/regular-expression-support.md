---
title: Regular expression support in Operations Manager
description: This article describes regular expression matching in discoveries and groups when you author management packs in System Center Operations Manager.
ms.date: 06/22/2020
---
# Regular expression support in System Center Operations Manager

When you author management packs, you may have to include regular expression matching in discoveries and groups. Regular expressions may also be necessary for pattern matching in expression criteria in monitors and rules.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2702651

Operations Manager supports two different types of regular expressions. You must know which element you are working in to be able to choose the correct expression. Group membership calculation and expression filters use distinctly different syntaxes for pattern matching.

## Group calculation

Group calculation uses `PERL` regular expression syntax. By default, the matching is case-insensitive, however you can specify that an expression must be case-sensitive by using a special attribute in the XML. For more information, see [SimpleCriteriaType](/previous-versions/system-center/developer/hh135104(v=msdn.10)?redirectedfrom=MSDN).

Group calculation is found in your management pack (MP) whenever you use the `Group Calc` module. The `GroupCalc` expression uses the `MatchesRegularExpression` operator to create dynamic group membership based on pattern matching expressions. The implementation of this operator passes the expression that is found in the MP XML to the `dbo.fn_MatchesRegularExpression` SQL call name. If this call returns a value of **0**, the match is false. If it returns a value of **1**, the match is true.

> [!IMPORTANT]
> The `dbo.fn_MatchesRegularExpression` SQL call name itself is case-sensitive, so the `MatchesRegularExpression` operator used in dynamic group membership criteria will be case-sensitive as well.

GroupCalc also supports two special subelements that make abstract expressions of the following common regex style queries.

### GroupCalc special functions

|GroupCalc sub element|MP expression|Regex equivalent|
|---|---|---|
|ContainsSubstring||`^*{O}.*$` (Wherein `{O}` is replaced by the substring)
|MatchesWildcard|`?`|`.`|
|MatchesWildcard|`*`|`.*`|
|MatchesWildcard|`#`|`[0-9]`|

> [!NOTE]
> If either of these two special operators are used, the evaluation is always case-sensitive.

## Expression filter matching criteria

Expression filters that are used in management packs use .NET Framework regex expression syntax. Not all expressions work. However, the following .NET Framework regular expression syntax elements are supported. Expression filters exist in your management pack when you use the Expression Eval module.

### Operations Manager regex syntax

|Construct|Operations Manager regex|
|---|---|
|Any character|. |
|Character in range|[ ] |
|Character not in range|[^ ] |
|Beginning of line|^ |
|End of line|$ |
|Or|\| |
|Group|( ) |
|0 or 1 match|? |
|0 or more matches|* |
|1 or more matches|+ |
|Exactly N matches|{n} |
|At least N matches|{n, } |
|At most N matches|{ , n} |
|N to M Matches|{n, m} |
|New line character|\n |
|Tab character|\t |
  
## Operations Manager regular expression (regex) examples

### Example 1

Search for any matches containing a single string, `string1`:

```perl
^(string1)$
```

### Example 2

Search for any matches containing either of the two strings, `string1` or `string2`:

```perl
^(string1)|^(string2)$
```

### Example 3

Search for any matches to folders located recursively under the two folder paths, (`/var/lib/string1/*` or `/var/lib/string2/*`):

```perl
^(\/var\/lib\/string1\/.*)|^(\/var\/lib\/string2\/.*)$
```

### Example 4

Search for any matches that contain either of the two strings, `Agent1.contoso.com` or `Agent2.contoso.com` (case insensitive):

```perl
^(?i)(agent1.contoso.com)|(?i)(agent2.contoso.com)$
```

Search for any matches that contain `Agent` (case insensitive):

```perl
^(?i)(agent.*)$
```

## Regular expressions via SDK

The Operations Manager SDK has a **Matches** criteria operator for filtering objects. This operator uses the same functionality as `MatchesCriteria` in the GroupCalc case mentioned earlier.

When you use the SDK to construct a criteria expression to find objects in the Operations Manager database, the following syntax elements are valid and useful:

- Comparison operators
- Wildcard characters
- DateTime values
- Integer to XML Enumeration comparisons

### Comparison operators

You can use comparison operators when you construct a criteria expression. The valid operators are described in the following table.

#### SDK comparison operators

|Operator|Description|Example(s)|
|---|---|---|
|=, ==|Evaluates to **true** if the left and right operands are equal.| `Name = 'mymachine.contoso.com'` |
|!=, <>|Evaluates to **true** if the left and right operands are unequal.| `Name != 'mymachine.contoso.com'` |
|>|Evaluates to **true** if the left operand is greater than the right operand.| `Severity > 0` |
|<|Evaluates to **true** if the left operand is less than the right operand.| `Severity < 2` |
|>=|Evaluates to **true** if the left operand is greater than or equal to the right operand.| `Severity >= 1` |
|<=|Evaluates to **true** if the left operand is less than or equal to the right operand.| `Severity <= 3` |
|LIKE|Evaluates to **true** if the left operand matches the pattern that is defined by the right operand. Use the characters in the [wildcard](#wildcard-operators-used-with-like-operator) table to define the pattern.| `Name 'LIKE SQL%'`<br/>Evaluates to **true** if the `Name` value is **SQLEngine**. <br/><br/>`Name LIKE '%SQL%'`<br/>Evaluates to **true** if the `Name` value is **MySQLEngine**. |
|MATCHES|Evaluates to **true** if the left operand matches the regular expression defined by the right operand.| `Name MATCHES 'SQL*05'`<br/> Evaluates to **true** if the `Name` value is **SQL2005**. |
|IS NULL|Evaluates to **true** if the value of the left operand is null.| `ConnectorId IS NULL`<br/> Evaluates to **true** if the `ConnectorId` property doesn't contain a value. |
|IS NOT NULL|Evaluates to **true** if the value of the left operand isn't null.| `ConnectorId IS NOT NULL`<br/> Evaluates to **true** if the `ConnectorId` property contains a value. |
|IN|Evaluates to **true** if the value of the left operand is in the list of values defined by the right operand.<br/><br/>**Note** The **IN** operator is valid for use only with properties of type [Guid](/dotnet/api/system.guid).|`Id IN ('080F192C-52D2-423D-8953-B3EC8C3CD001', '080F192C-53B2-403D-8753-B3EC8C3CD002')`<br/>Evaluates to **true** if the value of the `Id` property is one of the two globally unique identifiers provided in the expression. |
|AND|Evaluates to **true** if the left and right operands are both true.|`Name = 'SQL%' AND Description LIKE 'MyData%'` |
|OR|Evaluates to **true** if either the left or right operand is true.|`Name = 'SQL%' OR Description LIKE 'MyData%'` |
|NOT|Evaluates to **true** if the right operand isn't true.|`NOT (Name = 'IIS' OR Name = 'SQL')` |
  
### Wildcards

The following table defines the wildcard characters that you can use to construct a pattern when you use the `LIKE` operator.

#### Wildcard operators used with LIKE operator

|Wildcard|Description|Example|
|---|---|---|
|%|A wildcard that matches any number of characters.| `Name LIKE 'SQL%'` <br/>Evaluates to **true** if the `Name` value is **SQLEngine**. <br/><br/>`Name LIKE '%SQL%'`<br/> Evaluates to **true** if the `Name` value is **MySQLEngine**. |
|\_|A wildcard that matches a single character.| `Name LIKE 'SQL200_'`<br/> Evaluates to **true** for the following `Name` values: <br/><br/>**SQL2000**<br/>**SQL2005**<br/><br/>**Note**: The expression evaluates to **false** for **SQL200** because the symbol \_ must match exactly one character in the `Name` value. |
|[]|A wildcard that matches any one character that is enclosed in the character set.<br/><br/>**Note** Brackets are also used when qualifying references to [MonitoringObject](/previous-versions/system-center/developer/bb465607(v=msdn.10)?redirectedfrom=MSDN) properties. For more information, see [Defining Queries for Monitoring Objects](/previous-versions/system-center/developer/bb437594(v=msdn.10)?redirectedfrom=MSDN). |`Name LIKE 'SQL200[05]'`<br/>Evaluates to **true** for the following `Name` values:<br/><br/>**SQL2000**<br/>**SQL2005**<br/><br/>The expression evaluates to **false** for **SQL2003**.|
|[^]|A wildcard that matches any one character that isn't enclosed in the character set.|`Name LIKE 'SQL200[^05]'`<br/>Evaluates to **true** for **SQL2003**.<br/><br/>The expression evaluates to **false** for **SQL2000** and **SQL2005**. |
  
### DateTime comparisons

When you use a [DateTime](/dotnet/api/system.datetime) value in a query expression, use the general DateTime format (**G**) to convert the `DateTime` value to a string value. For example:

```csharp
string qStr = "TimeCreated <= '" + myInstant.ToString("G") + "'";
ManagementPackCriteria mpCriteria = new ManagementPackCriteria(qStr);
```

Convert all date values to the **G format (GMT)** to make valid string comparisons.

### Integer value comparison to enumerations

When you use an integer enumeration value in a query expression, cast the enumeration value to an integer.

For example:

```csharp
string qStr = "Severity > " + (int)ManagementPackAlertSeverity.Warning;
MonitoringAlertCriteria alertCriteria = new MonitoringAlertCriteria(qStr);
```

## More information

- [System Center Operations Manager troubleshooting](welcome-scom.yml)
- [Troubleshoot gray agent states in System Center Operations Manager](troubleshoot-gray-agent-states.md)
