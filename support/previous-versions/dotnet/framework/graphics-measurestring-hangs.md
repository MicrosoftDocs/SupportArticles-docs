---
title: Calling Graphics.MeasureString hangs
description: The Calling MeasureString method of gdiplus module with a large right-to-left string may cause a hang problem.
ms.date: 05/11/2020
ms.prod-support-area-path:
---
# Graphics.MeasureString hangs with a large right-to-left string

This article describes the problem that calling the `Graphics.MeasureString` method with a long string in Arabic OTL font may cause a hang problem.

_Original product version:_ &nbsp; .NET Framework 3.5, 4.0  
_Original KB number:_ &nbsp; 2290718

## Symptoms

Calling the `Graphics.MeasureString` method with a long string in Arabic OTL font may cause a hang problem. The problem only occurs with right-to-left fonts.

## Cause

It's a bug in the `MeasureString` method of Microsoft .NET Framework 3.5 and 4.0.

You can repro the issue with following code:

```csharp
class Program
{
    static void Main(string[] args)
    {
        Bitmap b = new Bitmap(10, 10);
        Graphics g = Graphics.FromImage(b);
        Font objFont = new Font("Arial", 10);
        for (int i = 2000; i < 2500; i++)
        {
            string ss = new string('ش', i);
            Console.WriteLine("Testing " + i.ToString());
            SizeF oSize = g.MeasureString(ss, objFont);
            Console.WriteLine("Size = " + oSize.Width);
         }
    }
}
```

When a string is with a repetition of right-to-left Arabic font and the length is smaller than 2046, the `MeasureString` method works properly. It hangs if the length is greater than 2047. The problem doesn't occur with normal left-to-right characters.

## Status

Currently, no workaround exists for this issue. Microsoft has confirmed that it's a bug in the Microsoft products.
