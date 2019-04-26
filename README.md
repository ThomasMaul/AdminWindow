# AdminWindow

### A rewritten 4D Server Administrator Window

Call with: Monitor_Start

In addition to the standard dialog it contains two more pages. One shows an overview of currently locked records, the other an overview for query operations. Use list box header to sort by count of operations or total time needed.
You might want to use this dialog to find missing index or optimize queries.
For details about the displayed content see Get Database Measures

The page Real Time Monitor behaves different, it shows always with peak time (operations needing more than half a second). Additionally to the currently running operations, it shows the previous slowest operations. Recording only when page is opened, no history.

![alt text](https://github.com/ThomasMaul/AdminWindow/Docu/image011.png "Screenshot")

Note: project requires 4D v17 R5 or newer.