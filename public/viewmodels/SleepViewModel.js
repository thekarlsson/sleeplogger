var SleepViewModel = function() {
	var self = this;
	
	// Observables
	self.confirmation = ko.observable("");
	self.times = ko.observableArray([]);
	
	
	// Operations
	
	self.updateTimes = function(data) {
		self.times([]);
		$.map($.parseJSON(data), function(item) {
			self.times.push(item);
		});
	}
	
	self.getInit = function() {
		$.get(window.location.pathname + '/times', function(data) {
		self.updateTimes(data);
		});
	}
	
	self.sleepNow = function() {
		$.post(window.location.pathname + '/sleepnow', {"data": ko.toJSON("Jag are en Irlandsk cowboy!")},
			function(data){
				self.updateTimes(data);
			});
	}
	
	// Load initial values from server
	self.getInit()
}

// Activate
ko.applyBindings(new SleepViewModel());















