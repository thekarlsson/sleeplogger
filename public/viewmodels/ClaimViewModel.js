var ClaimViewModel = function() {
	var self = this;
	
	// Observables
	
	// Operations
	
	self.layClaim = function(data) {
		$.post(window.location.pathname + '/claim', {"data": ko.toJSON("Jag are en Irlandsk cowboy!")},
			function(data){
				window.location.reload();
			});
	}
	
}

// Activate
ko.applyBindings(new SleepViewModel());