var SleepViewModel = function() {
	var self = this;
	
	// Observables
	self.times = ko.observableArray([]);
	
	// Other variables
	var maxNumberOfTimes = 10 //default value
	
	// Operations
	
	self.updateTimes = function(data) {
		self.times([]);
		$.map($.parseJSON(data), function(item) {
			var itemDatetime = new XDate(item['datetime']);
			item['date'] = itemDatetime.toString('yyyy-MM-dd');
			item['time'] = itemDatetime.toString('HH:mm');
			delete item['datetime'];
			self.times.push(item);
		});
	}
	
	self.getInit = function() {
		$.get(window.location.pathname + '/times' + '/' + maxNumberOfTimes, function(data) {
		self.updateTimes(data);
		});
	}
	
	self.sleepNow = function() {
		$.post(window.location.pathname + '/sleepnow', {"data": ko.toJSON("Jag are en Irlandsk cowboy!")},
			function(data){
				self.updateTimes(data);
			});
	}
	
	self.moreTimes = function() {
		if (maxNumberOfTimes < 20){
			maxNumberOfTimes += 5
			self.getInit()
		}
	}
	
	self.lessTimes = function() {
		if (maxNumberOfTimes > 5) {
			maxNumberOfTimes -= 5
			self.getInit()
		}
	}
	
	// Load initial values from server
	self.getInit()
}

// Activate
ko.applyBindings(new SleepViewModel());