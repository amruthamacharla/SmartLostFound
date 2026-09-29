<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
/* get values from session */

String name = (String)session.getAttribute("fullname");
String email = (String)session.getAttribute("email");
String phone = (String)session.getAttribute("phone");

Integer contributions = (Integer)session.getAttribute("contributions");
String status = (String)session.getAttribute("status");

/* defaults */

if(name==null) name="New User";
if(email==null) email="Not available";
if(phone==null) phone="Not provided";
if(contributions==null) contributions=0;
if(status==null) status="Active";

/* success popup after register */

String msg = (String)session.getAttribute("msg");

if(msg != null){
%>

<script>
alert("<%= msg %>");
</script>

<%
session.removeAttribute("msg");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Discovery Hub | User Details</title>

<script src="https://cdn.tailwindcss.com"></script>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&display=swap');

body{
font-family:'Plus Jakarta Sans',sans-serif;
background-color:#f0f9ff;
background-image:radial-gradient(at 0% 0%, #e0f2fe 0, transparent 50%),
radial-gradient(at 100% 0%, #f5f3ff 0, transparent 50%);
color:#1e293b;
overflow:hidden;
}

.glass-card{
background:rgba(255,255,255,0.6);
backdrop-filter:blur(10px);
border:1px solid rgba(255,255,255,0.7);
box-shadow:0 10px 30px rgba(14,165,233,0.05);
}

.sidebar{background:white;border-right:1px solid #e2e8f0;}

.nav-link{
transition:all 0.3s ease;
color:#64748b;
}

.nav-link:hover,.nav-link.active{
background:#f0f9ff;
color:#0ea5e9;
border-left:4px solid #0ea5e9;
}

.profile-gradient{
background:linear-gradient(135deg,#0ea5e9 0%,#6366f1 100%);
}

input:disabled{
background:transparent;
border:none;
padding:0;
color:inherit;
}

.edit-input{
background:white;
border:1px solid #e2e8f0;
padding:4px 8px;
border-radius:8px;
outline-color:#0ea5e9;
}
</style>
</head>

<body class="flex h-screen w-screen relative">

<aside class="sidebar w-64 flex-shrink-0 flex flex-col p-6 z-50">

<div class="flex items-center gap-3 mb-12">
<div class="w-10 h-10 bg-sky-400 rounded-xl flex items-center justify-center text-white font-black text-xl shadow-md">D</div>
<h1 class="text-xl font-black tracking-tighter text-slate-800">Discovery <span class="text-sky-500">Hub</span></h1>
</div>

<nav class="space-y-2 flex-grow">
<a href="DashboardServlet" class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm">📊 Dashboard</a>
<a href="SearchServlet" class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm">🔍 Global Search</a>
<a href="lost.jsp" class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm">📍 Report Loss</a>
<a href="found.jsp" class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm">✅ Report Find</a>
<a href="ProfileStatsServlet" class="nav-link active flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm">
<span>👤</span> User Details
</a>
</nav>

</aside>

<main class="flex-grow p-10 overflow-y-auto">

<header class="mb-10 flex justify-between items-end animate__animated animate__fadeIn">

<div>
<h2 class="text-4xl font-extrabold text-slate-800 tracking-tight">User Details</h2>
<p class="text-slate-500 font-medium">Manage your community profile.</p>
</div>

<button id="editBtn"
onclick="toggleEdit()"
class="px-6 py-3 bg-white border border-sky-200 text-sky-600 font-bold rounded-2xl hover:bg-sky-50 transition-all shadow-sm">
Edit Profile
</button>

</header>

<div class="max-w-4xl">

<div class="glass-card p-8 rounded-[3rem] flex items-center gap-8 mb-8 animate__animated animate__fadeInUp">

<div id="initials"
class="w-32 h-32 profile-gradient rounded-[2.5rem] flex items-center justify-center text-white text-5xl font-black shadow-lg">
<%= name != null && name.length()>0 
? name.substring(0,1).toUpperCase() 
: "U" %>
</div>

<div class="flex-grow">

<form action="UpdateProfileServlet" method="post">

<input type="text"
name="name"
id="userName"
disabled
value="<%=name%>"
class="text-3xl font-black text-slate-800 block w-full mb-1">

<p class="text-sky-500 font-bold">Verified Community Member</p>

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-6">

<div class="bg-white/40 p-4 rounded-2xl border border-white">
<label class="text-[10px] uppercase font-black text-slate-400 block mb-1">Email Address</label>

<input type="email"
name="email"
id="userEmail"
disabled
value="<%=email%>"
class="font-bold text-slate-600 w-full">

</div>

<div class="bg-white/40 p-4 rounded-2xl border border-white">

<label class="text-[10px] uppercase font-black text-slate-400 block mb-1">Phone Number</label>

<input type="text"
name="phone"
id="userPhone"
disabled
value="<%=phone%>"
class="font-bold text-slate-600 w-full">

</div>

</div>

<button type="submit"
id="saveBtn"
class="hidden mt-6 px-6 py-3 bg-sky-500 text-white rounded-xl">
Save Changes
</button>

</form>

</div>
</div>
</div>
<div class="grid grid-cols-1 md:grid-cols-2 gap-6 animate__animated animate__fadeInUp" style="animation-delay: 0.1s">

    <!-- Total Contributions -->
    <div class="glass-card p-8 rounded-[2.5rem]">
        <p class="text-slate-400 font-bold uppercase text-xs tracking-widest mb-2">
            Total Contributions
        </p>

        <h4 class="text-4xl font-black text-slate-800">
            <%= contributions %>
        </h4>
    </div>

    <!-- Account Status -->
    <div class="glass-card p-8 rounded-[2.5rem]">
        <p class="text-slate-400 font-bold uppercase text-xs tracking-widest mb-2">
            Account Status
        </p>

        <h4 class="text-4xl font-black text-emerald-500">
            <%= status %>
        </h4>
    </div>

</div>
</main>

<script>

let isEditing=false;

function toggleEdit(){

isEditing=!isEditing;

const btn=document.getElementById("editBtn");
const save=document.getElementById("saveBtn");

const inputs=["userName","userEmail","userPhone"];

if(isEditing){

btn.innerText="Cancel";
save.classList.remove("hidden");

inputs.forEach(id=>{
const el=document.getElementById(id);
el.disabled=false;
el.classList.add("edit-input");
});

}else{

btn.innerText="Edit Profile";
save.classList.add("hidden");

inputs.forEach(id=>{
const el=document.getElementById(id);
el.disabled=true;
el.classList.remove("edit-input");
});

}

}

</script>

</body>
</html>