LoadingTableViewRow = (message) ->
	row = Titanium.UI.createTableViewRow
		height: '70dp'
		touchEnabled: false
		selectedBackgroundColor: "transparent"
			
	indicator = Titanium.UI.createActivityIndicator
		width: 'auto'
		height: '30dp'
		color: "#665b5b"
		message: message
		style: 2 # android is a picky thing, it won't display anything here
	
	# show the indicator
	indicator.show()
	# add it to the row
	row.add indicator
	
	# make sure we always return this
	row
	
	

module.exports = LoadingTableViewRow