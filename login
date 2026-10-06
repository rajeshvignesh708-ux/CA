/html code 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Register & Login</title>

    <link rel="stylesheet" href="style.css">
</head>

<body>

    <div class="container">

        <!-- Register -->
        <div id="registerForm" class="form-panel active">

            <h2>Register</h2>

            <input
                type="text"
                id="name"
                placeholder="Enter Name"
            >

            <input
                type="email"
                id="registerEmail"
                placeholder="Enter Email"
            >

            <input
                type="password"
                id="registerPassword"
                placeholder="Enter Password"
            >

            <button onclick="register()">
                Register
            </button>

            <p>
                Already have an account?
                <a href="#" onclick="showLogin()">Login</a>
            </p>

        </div>


        <!-- Login -->
        <div id="loginForm" class="form-panel">

            <h2>Login</h2>

            <input
                type="email"
                id="loginEmail"
                placeholder="Enter Email"
            >

            <input
                type="password"
                id="loginPassword"
                placeholder="Enter Password"
            >

            <button onclick="login()">
                Login
            </button>

            <p>
                Don't have an account?
                <a href="#" onclick="showRegister()">Register</a>
            </p>

        </div>

        <p id="message"></p>

    </div>

    <script type="module" src="script.js"></script>

</body>
</html>


/ CSS code
body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    background: #f3f3f3;
    color: #111;
}

.container {
    width: 100%;
    max-width: 900px;
    margin: 20px 0 0 20px;
}

.form-panel {
    display: none;
    margin-top: 20px;
}

.form-panel.active {
    display: block;
}

h2 {
    margin: 0 0 18px;
    font-size: 46px;
    font-weight: 700;
    line-height: 1.2;
}

input {
    width: 220px;
    height: 38px;
    margin-right: 12px;
    margin-bottom: 12px;
    padding: 0 10px;
    font-size: 18px;
    border: 1px solid #9a9a9a;
    box-sizing: border-box;
    background: #f5f5f5;
}

button {
    width: 110px;
    height: 38px;
    font-size: 18px;
    border: 1px solid #8a8a8a;
    background: #e5e5e5;
    cursor: pointer;
}

p {
    margin: 18px 0 0;
    font-size: 22px;
}

p a {
    color: #7a1aa5;
    text-decoration: none;
    font-weight: 600;
}

#message {
    margin-top: 18px;
    font-size: 18px;
    color: #111;
}


/ script code
// Firebase imports

import { initializeApp }
    from "https://www.gstatic.com/firebasejs/12.19.0/firebase-app.js";

import {
    getAuth,
    createUserWithEmailAndPassword,
    signInWithEmailAndPassword
}
    from "https://www.gstatic.com/firebasejs/12.19.0/firebase-auth.js";


// Your Firebase configuration

const firebaseConfig = {

    apiKey: "YOUR_API_KEY",

    authDomain: "YOUR_PROJECT.firebaseapp.com",

    projectId: "YOUR_PROJECT_ID",

    storageBucket: "YOUR_STORAGE_BUCKET",

    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",

    appId: "YOUR_APP_ID"
};


// Initialize Firebase

const app = initializeApp(firebaseConfig);


// Initialize Authentication

const auth = getAuth(app);


// --------------------------------
// SHOW LOGIN
// --------------------------------

window.showLogin = function () {

    document.getElementById("registerForm").style.display = "none";

    document.getElementById("loginForm").style.display = "block";

    document.getElementById("message").innerText = "";
};


// --------------------------------
// SHOW REGISTER
// --------------------------------

window.showRegister = function () {

    document.getElementById("registerForm").style.display = "block";

    document.getElementById("loginForm").style.display = "none";

    document.getElementById("message").innerText = "";
};

showRegister();


// --------------------------------
// REGISTER
// --------------------------------

window.register = async function () {

    const name =
        document.getElementById("name").value;

    const email =
        document.getElementById("registerEmail").value;

    const password =
        document.getElementById("registerPassword").value;


    if (name === "" || email === "" || password === "") {

        document.getElementById("message").innerText =
            "Please fill all fields.";

        return;
    }


    try {

        const userCredential =
            await createUserWithEmailAndPassword(
                auth,
                email,
                password
            );


        const user = userCredential.user;


        console.log("User created:", user);


        document.getElementById("message").innerText =
            "Registration successful!";


        // Clear fields

        document.getElementById("name").value = "";

        document.getElementById("registerEmail").value = "";

        document.getElementById("registerPassword").value = "";


        // Go to login

        setTimeout(showLogin, 1000);


    } catch (error) {

        console.error(error);


        document.getElementById("message").innerText =
            error.message;
    }
};


// --------------------------------
// LOGIN
// --------------------------------

window.login = async function () {

    const email =
        document.getElementById("loginEmail").value;

    const password =
        document.getElementById("loginPassword").value;


    if (email === "" || password === "") {

        document.getElementById("message").innerText =
            "Please enter email and password.";

        return;
    }


    try {

        const userCredential =
            await signInWithEmailAndPassword(
                auth,
                email,
                password
            );


        const user = userCredential.user;


        console.log("Logged in user:", user);


        document.getElementById("message").innerText =
            "Login successful!";


    } catch (error) {

        console.error(error);


        document.getElementById("message").innerText =
            "Invalid email or password.";
    }
};
