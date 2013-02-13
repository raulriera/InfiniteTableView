#InfiniteTableView:
**InfiniteTableView** is a wrapper around a normal `TableView` to enable "infinite" scrolling. Every time you reach the bottom of the tableview it will dispatch an event letting you know, add a `LoadingTableView` and wait for your response to update the content of the `TableView`. 

##Usage:
In your app.coffee (or elsewhere), call:

```coffeecript
# Load the module
InfiniteTableView = require "/InfiniteTableView"

# Create an infinite tableview instance
tableView = new InfiniteTableView(data: [
  title: "Row"
,
  title: "Row"
,
  title: "Row"
])

# Use this method to fetch your new data
onTableViewAtBottom = (e) ->
	
	# Populate your rows here 
	# [populate code, maybe fetching from the server]
	rows = []
	
	# Use the custom `updateData` method to update your rows (pass an array of `TableViewRow` objects)
	tableView.updateData rows

# Listen for when the tableview is at the bottom
tableView.addEventListener "tableViewAtBottom", onTableViewAtBottom
```

In your app.js (or elsewhere), call
```javascript
var InfiniteTableView, onTableViewAtBottom, tableView;

InfiniteTableView = require("/InfiniteTableView");

tableView = new InfiniteTableView({
    data: [{ title: "Row"},
        {title: "Row"},
        {title: "Row"}]
    });

onTableViewAtBottom = function(e) {
  var rows = []
  // So something with `rows` here, make an HTTP request, or something just remember to populate that array with `TableViewRow` objects
  tableView.updateData(rows);
};

tableView.addEventListener("tableViewAtBottom", onTableViewAtBottom);
```

##Methods available

`InfiniteTableView` adds the following methods and events a `TableView`:

* **updateData** (method): pass and array of `TableViewRow` objects to update your tableview
* **tableViewAtBottom** (event): notifies that the `TableView` is at the bottom, passing along a `isAtBottom` boolean property

I also included a `LoadingTableView` feel free to edit that to suit your needs :)

##About:
Created by Raul Riera, [@raulriera](http://twitter.com/raulriera)  
