<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Finder | Interactive Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: #f0f9ff; 
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            perspective: 1000px;
        }

        /* Animated Mesh Background */
        .bg-animate {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(45deg, #e0f2fe, #bae6fd, #7dd3fc, #e0f2fe);
            background-size: 400% 400%;
            z-index: -1;
            animation: gradientBG 15s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Floating Decorative Icons */
        .floating-icon {
            position: absolute;
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(5px);
            padding: 15px;
            border-radius: 50%;
            color: #3b82f6;
            font-size: 20px;
            border: 1px solid rgba(255,255,255,0.8);
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            animation: orbit 20s linear infinite;
        }

        @keyframes orbit {
            from { transform: rotate(0deg) translateX(280px) rotate(0deg); }
            to { transform: rotate(360deg) translateX(280px) rotate(-360deg); }
        }

        /* Glassmorphism Card */
        .card {
            background: rgba(255, 255, 255, 0.7);
            border: 1px solid rgba(255, 255, 255, 1);
            backdrop-filter: blur(20px);
            padding: 40px;
            border-radius: 30px;
            width: 420px;
            text-align: center;
            box-shadow: 0 25px 50px rgba(59, 130, 246, 0.15);
            transition: transform 0.1s ease;
            animation: cardEntrance 1s ease-out;
        }

        @keyframes cardEntrance {
            from { opacity: 0; transform: scale(0.8) translateY(50px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }

        h2 { color: #1e293b; font-weight: 800; font-size: 2rem; margin-bottom: 5px; letter-spacing: -1px; }
        p#subtitle { color: #64748b; margin-bottom: 30px; font-size: 0.9rem; }

        /* Modern Inputs */
        .input-box { position: relative; margin-bottom: 25px; width: 100%; }
        .input-box input {
            width: 100%;
            padding: 15px;
            background: transparent;
            border: none;
            border-bottom: 2px solid rgba(0, 0, 0, 0.1);
            outline: none;
            color: #334155;
            font-size: 1rem;
            transition: 0.4s;
        }

        .input-box span {
            position: absolute;
            left: 0;
            padding: 15px 0;
            pointer-events: none;
            color: #94a3b8;
            transition: 0.4s;
        }

        .input-box input:focus ~ span,
        .input-box input:valid ~ span {
            color: #3b82f6;
            font-size: 0.8rem;
            transform: translateY(-25px);
        }

        .input-box input:focus { border-bottom: 2px solid #3b82f6; }

        /* Neon Button */
        .btn {
            position: relative;
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 50px;
            background: linear-gradient(135deg, #3b82f6, #2dd4bf);
            color: white;
            font-weight: 700;
            font-size: 16px;
            cursor: pointer;
            overflow: hidden;
            transition: 0.4s;
            margin-top: 10px;
            box-shadow: 0 10px 20px rgba(59, 130, 246, 0.2);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(59, 130, 246, 0.4);
            letter-spacing: 2px;
        }

        /* Footer links */
        .card-footer {
            margin-top: 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            color: #64748b;
        }

        .card-footer a {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
            cursor: pointer;
        }

        .card-footer a:hover {
            text-decoration: underline;
            opacity: 0.8;
        }

        /* Transition States */
        .hidden { display: none; }
        
        #forgotForm {
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateX(20px); }
            to { opacity: 1; transform: translateX(0); }
        }

</style>

</head>
<body>

    <div class="bg-animate"></div>

 

    <div class="card">
        <h2 id="formTitle">LOGIN</h2>
        <p id="subtitle">Login to your smart portal</p>

       <form id="loginForm" action="<%=request.getContextPath()%>/LoginServlet" method="post">

    <div class="input-box">
        <input type="text" name="username" required>
        <span>Email or Username</span>
    </div>

    <div class="input-box">
        <input type="password" name="password" required>
        <span>Password</span>
    </div>

    <button type="submit" class="btn">LOGIN</button>
            
            <div class="card-footer">
                <a onclick="showForgot()">Forgot Password?</a>
                <span>New here? <a href="register.jsp">Register</a></span>
            </div>
        </form>

        <form id="forgotForm" class="hidden">
            <div class="input-box">
                <input type="email" required>
                <span>Registered Email</span>
            </div>
            <p style="font-size: 0.75rem; margin-bottom: 20px; text-align: left;">We'll send a recovery link to your inbox.</p>
            <button type="submit" class="btn">SEND RESET LINK</button>
            
            <div class="card-footer" style="justify-content: center;">
                <a onclick="showLogin()"> Back to Login</a>
            </div>
        </form>
    </div>

    <script>
        const card = document.querySelector('.card');
        const loginForm = document.getElementById('loginForm');
        const forgotForm = document.getElementById('forgotForm');
        const formTitle = document.getElementById('formTitle');
        const subtitle = document.getElementById('subtitle');

        // Toggle to Forgot Password
        function showForgot() {
            loginForm.classList.add('hidden');
            forgotForm.classList.remove('hidden');
            formTitle.innerText = "Recover Key";
            subtitle.innerText = "Restore access to your portal";
        }

        // Toggle back to Login
        function showLogin() {
            forgotForm.classList.add('hidden');
            loginForm.classList.remove('hidden');
            formTitle.innerText = "LOGIN";
            subtitle.innerText = "Login to your smart portal";
        }

        // Interactive Tilt Effect
        document.addEventListener('mousemove', (e) => {
            let xAxis = (window.innerWidth / 2 - e.pageX) / 30;
            let yAxis = (window.innerHeight / 2 - e.pageY) / 30;
            card.style.transform = `rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
        });

        // Login Handle
        loginForm.onsubmit = function () {
    const btn = loginForm.querySelector('button');
    btn.innerText = "VERIFYING...";
};

        // Forgot Handle
        forgotForm.onsubmit = (e) => {
            e.preventDefault();
            const btn = e.target.querySelector('button');
            btn.innerText = "SENDING...";
            setTimeout(() => {
                btn.style.background = "#10b981";
                btn.innerText = "LINK SENT!";
                setTimeout(showLogin, 1500); // Send them back to login after success
            }, 1000);
        };
    </script>

</body>
</html>
