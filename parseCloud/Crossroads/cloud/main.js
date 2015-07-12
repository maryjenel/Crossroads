

Parse.Cloud.job("deleteOldOffering", function(request, status) {



var time = new Date();
time.setTime(time.getTime()-1800000);

var offering = Parse.Object.extend("Offering");
var query = new Parse.Query(offering);

query.lessThan("createdAt", time);

    query.find({
            success:function(results) {
                for (var i = 0, len = results.length; i < len; i++) {
                    var result = results[i];
                    result.destroy({});
                    console.log("Destroy: "+result);

                }   
            status.success("Delete successfully.");             
            },
            error: function(error) {
            console.log("Fail");         
            }
    })

});


Parse.Cloud.job("deleteOldRequest", function(request, status) {



var time = new Date();
time.setTime(time.getTime()-3600000);

var requestClass = Parse.Object.extend("Request");
var query = new Parse.Query(requestClass);

query.lessThan("createdAt", time);

    query.find({
            success:function(results) {
                for (var i = 0, len = results.length; i < len; i++) {
                    var result = results[i];
                    result.destroy({});
                    console.log("Destroy: "+result);

                }   
            status.success("Delete successfully.");             
            },
            error: function(error) {
            console.log("Fail");         
            }
    })

});




