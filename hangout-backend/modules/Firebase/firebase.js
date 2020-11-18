var app_fireBase = {};
(function(){
        
        // Your web app's Firebase configuration
        // For Firebase JS SDK v7.20.0 and later, measurementId is optional
        var firebaseConfig = {
            apiKey: "AIzaSyDDX6PY_AgBBGnqWAuoFGxyzGVn6kRsw-g",
            authDomain: "virtualhangout-51cb8.firebaseapp.com",
            databaseURL: "https://virtualhangout-51cb8.firebaseio.com",
            projectId: "virtualhangout-51cb8",
            storageBucket: "virtualhangout-51cb8.appspot.com",
            messagingSenderId: "498160131755",
            appId: "1:498160131755:web:777108d4dbf1f2f81ae1ee",
            measurementId: "G-0SGKR2R26S"
        };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
        firebase.analytics();
        
        app_fireBase = firebase;
})()
