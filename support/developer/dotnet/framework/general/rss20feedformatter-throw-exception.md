---
title: RSS20FeedFormatter throws exception
description: This article describes that you might receive an error message when you use the SyndicationFeed.Load method to read from an RSS source.
ms.date: 05/06/2020
ms.reviewer: hongmeig, vinelap, pradnyad, tvish
---
# RSS20FeedFormatter throws exception when trying to read some DateTime formats

This article provides information about the `System.Xml.XmlException` when you use the `SyndicationFeed.Load` method to read date formats from an RSS source.

_Original product version:_ &nbsp; Microsoft .NET Framework  
_Original KB number:_ &nbsp; 2020488

## Symptoms

When you use the `SyndicationFeed.Load` method to read from an RSS source, you may receive an error message that resembles the following:

> System.Xml.XmlException: Error in line 7 position 47. An error was encountered when parsing the feed's XML. Refer to the inner exception for more details.  
> String was not recognized as a valid DateTime.

Some feeds function may correctly while other feeds function incorrectly.

## Cause

This problem occurs because of the date format that is used in the feed.  The `SyndicationFeed.Load` method expects to receive feeds that are in standard format. The following is an example of standard format:

`Mon, 05 Oct 2009 08:00:06 GMT`

However, some feeds use a different format. For example, some feeds may use the following format:

`Wed Oct 07 08:00:07 GMT 2009`

## Resolution

To work around this problem, create a custom XML reader that recognizes different date formats. The following is an example of a custom XML reader:

```csharp
XmlReader r = new MyXmlReader(url);
SyndicationFeed feed = SyndicationFeed.Load(r);

Rss20FeedFormatter rssFormatter = feed.GetRss20Formatter();
XmlTextWriter rssWriter = new XmlTextWriter("rss.xml", Encoding.UTF8);
rssWriter.Formatting = Formatting.Indented;
rssFormatter.WriteTo(rssWriter);
rssWriter.Close();

class MyXmlReader : XmlTextReader
{
    private bool readingDate = false;
    const string CustomUtcDateTimeFormat = "ddd MMM dd HH:mm:ss Z yyyy"; // Wed Oct 07 08:00:07 GMT 2009
    public MyXmlReader(Stream s) : base(s) { }
    public MyXmlReader(string inputUri) : base(inputUri) { }

    public override void ReadStartElement()
    {
        if (string.Equals(base.NamespaceURI, string.Empty, StringComparison.InvariantCultureIgnoreCase) &&
        (string.Equals(base.LocalName, "lastBuildDate", StringComparison.InvariantCultureIgnoreCase) ||
        string.Equals(base.LocalName, "pubDate", StringComparison.InvariantCultureIgnoreCase)))
        {
            readingDate = true;
        }
        base.ReadStartElement();
    }

    public override void ReadEndElement()
    {
        if (readingDate)
        {
            readingDate = false;
        }
        base.ReadEndElement();
    }

    public override string ReadString()
    {
        if (readingDate)
        {
            string dateString = base.ReadString();
            DateTime dt;
            if (!DateTime.TryParse(dateString, out dt))
                dt = DateTime.ParseExact(dateString, CustomUtcDateTimeFormat, CultureInfo.InvariantCulture);
            return dt.ToUniversalTime().ToString("R", CultureInfo.InvariantCulture);
        }
        else
        {
            return base.ReadString();
        }
    }
}
```
