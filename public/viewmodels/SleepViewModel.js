var SleepViewModel = function() {
    var self = this;
    
    // Observables
    self.times = ko.observableArray([]);
    
    // Other variables
    var maxNumberOfTimes = 20,
        minNumberOfTimes = 5,
        incrDecrBy = 5;
    
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
    
    self.getTimes = function(numberOfTimes) {
        $.get(window.location.pathname + '/times' + '/' + numberOfTimes, function(data) {
            self.updateTimes(data);
        });
    }
    
    self.sleepNow = function() {
        $.post(window.location.pathname + '/sleepnow', {"data": ko.toJSON("Jag are en Irlandsk cowboy!")},
            function(data){
                self.updateTimes(data);
            });
    }

	self.isDecrementable = function () {
		if (self.times().length > minNumberOfTimes + incrDecrBy) {
			return true;
		}
		else {
			return false;
		}
	};
	
	self.isIncrementable = function() {
		if (self.times().length < maxNumberOfTimes - incrDecrBy) {
			return true;
		}
		else {
			return false;
		}
	}
    
    self.moreTimes = function() {
        if (self.isIncrementable()){
            self.getTimes(self.times().length + incrDecrBy);
        }
    }
    
    self.lessTimes = function() {
        if (self.isDecrementable()) {
            self.getTimes(self.times().length - incrDecrBy);
        }
    }
    
    // Load initial values from server
    self.getTimes()
}

// Activate
ko.applyBindings(new SleepViewModel());