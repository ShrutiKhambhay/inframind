
var html =""
function getInfo(data) {
   data.forEach(doc => {
      var info = doc.data();
      html +=" <li class=\"collection-item\">";
      html += "<div>Blood Pressure:  " + info.bloodpressure+"<br>Body Temperature: "+ info.bodytemperature +"<br>Cholesterol: "+ info.cholesterol+"<br>Glucose: "+info.glucose+"<br>Heart Rate: "+ info.heartrate+"<br>Respiratory Rate: "+info.respiratoryrate+"</div>";
      html += "</li>";
   });
   document.getElementById("user-list").innerHTML = html;
}
db.collection('data').get().then((snapshot) => {
    getInfo(snapshot.docs)
});
