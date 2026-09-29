<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Discovery Hub | Register</title>

<style>

@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600&display=swap');

:root {
--sky-blue:#e0f2fe;
--main-blue:#3b82f6;
--soft-teal:#2dd4bf;
--glass-white:rgba(255,255,255,0.8);
}

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Plus Jakarta Sans',sans-serif;
}

body{
background:linear-gradient(135deg,#f0f9ff,#e0f2fe);
height:100vh;
display:flex;
justify-content:center;
align-items:center;
overflow:hidden;
}

/* ripple background */

.wave-container{
position:absolute;
width:100%;
height:100%;
z-index:-1;
}

.wave{
position:absolute;
top:50%;
left:50%;
width:100px;
height:100px;
background:var(--main-blue);
border-radius:50%;
opacity:0;
transform:translate(-50%,-50%);
animation:ripple 6s infinite;
}

.wave:nth-child(2){
animation-delay:2s;
}

.wave:nth-child(3){
animation-delay:4s;
}

@keyframes ripple{

0%{
width:0;
height:0;
opacity:0.3;
}

100%{
width:1200px;
height:1200px;
opacity:0;
}

}

/* card */

.discovery-card{

background:var(--glass-white);

backdrop-filter:blur(10px);

padding:45px;

border-radius:28px;

width:420px;

box-shadow:0 20px 50px rgba(59,130,246,0.1);

border:1px solid white;

text-align:center;

animation:slideIn 0.8s ease-out;

}

@keyframes slideIn{

from{
opacity:0;
transform:translateY(30px);
}

to{
opacity:1;
transform:translateY(0);
}

}

/* icon */

.icon-box{

width:70px;

height:70px;

background:white;

border-radius:20px;

display:inline-flex;

justify-content:center;

align-items:center;

font-size:32px;

margin-bottom:20px;

box-shadow:0 10px 20px rgba(0,0,0,0.05);

animation:bounce 3s infinite;

}

@keyframes bounce{

0%,100%{
transform:translateY(0);
}

50%{
transform:translateY(-8px);
}

}

h2{
color:#1e293b;
font-weight:600;
margin-bottom:10px;
}

.tagline{
color:#64748b;
font-size:14px;
margin-bottom:30px;
}

/* form */

.field{
margin-bottom:18px;
}

input{

width:100%;

padding:14px 20px;

border:2px solid transparent;

background:#f1f5f9;

border-radius:14px;

font-size:15px;

transition:0.3s;

color:#334155;

}

input:focus{

background:white;

border-color:var(--main-blue);

outline:none;

box-shadow:0 0 15px rgba(59,130,246,0.1);

}

/* button */

button{

width:100%;

padding:16px;

border:none;

border-radius:14px;

background:linear-gradient(135deg,var(--main-blue),var(--soft-teal));

color:white;

font-weight:600;

font-size:16px;

cursor:pointer;

transition:0.4s;

margin-top:10px;

}

button:hover{

transform:scale(1.02);

box-shadow:0 15px 30px rgba(59,130,246,0.3);

}

/* footer */

.footer-text{

margin-top:25px;

font-size:13px;

color:#94a3b8;

}

.footer-text a{

color:var(--main-blue);

text-decoration:none;

font-weight:600;

}

</style>

</head>

<body>

<div class="wave-container">

<div class="wave"></div>

<div class="wave"></div>

<div class="wave"></div>

</div>

<div class="discovery-card">

<div class="icon-box">
</div>

<h2>REGISTER</h2>

<p class="tagline">
Locate. Report. Recover.
</p>

<form action="RegisterServlet" method="post">

<div class="field">

<input type="text"
name="fullname"
placeholder="Fullname"
required>

</div>
<div class="field">
<input type="text" name="username" placeholder="Username" required>
</div>

<div class="field">

<input type="email"
name="email"
placeholder="Email Address"
required>

</div>

<div class="field">

<input type="password"
name="password"
placeholder="Password"
required>

</div>


<button type="submit">

Register

</button>

</form>

<p class="footer-text">

Already have an account?

<a href="login.jsp">
Login
</a>

</p>

</div>

</body>

</html>