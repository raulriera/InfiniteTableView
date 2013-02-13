InfiniteTableView = (properties) ->
	CONSTANTS = 
		osname: Titanium.Platform.osname
		isAndroid: Titanium.Platform.osname == "android"
	
	LoadingTableViewRow = require "LoadingTableViewRow"

	self = Titanium.UI.createTableView properties
	
	# hold a reference to the current count of rows
	rows = []
	# lock to prevent multiple fetches
	self.isFetchingData = true
	# these variables helps us in android
	totalItemCount = 0
	firstVisibleItem = 0
	visibleItemCount = 0
	
	# use this method to update/replace the content of the tableview
	self.updateData = (data) ->
		rows.pop() # remove from the last position of the array
		rows = rows.concat data
		self.data = rows
		self.isFetchingData = false

	attachLoadingWidget = ->
		self.isFetchingData = true
		rows.push new LoadingTableViewRow()
		self.data = rows
		self.scrollToIndex rows.length-1

	onTableScrolling = (evt) ->		
		if CONSTANTS.isAndroid		
			totalItemCount = evt.totalItemCount
			firstVisibleItem = evt.firstVisibleItem
			visibleItemCount = evt.visibleItemCount

	onTableFinishedScrolling = (evt) ->	
		if (CONSTANTS.isAndroid and (totalItemCount < firstVisibleItem + visibleItemCount + 1) and not self.isFetchingData) or (CONSTANTS.osname is "iphone" and (evt.contentOffset.y + evt.size.height + 100) > (evt.contentSize.height) and not self.isFetchingData)
			
			# prevent further calls
			attachLoadingWidget()
			
			# fire the event
			self.fireEvent "tableViewAtBottom", isAtBottom:true	
	
	self.addEventListener "scroll", onTableScrolling
	self.addEventListener "scrollEnd", onTableFinishedScrolling	
	
	# make sure we return the tableview
	self
	
module.exports = InfiniteTableView