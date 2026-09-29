<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>

<%
session.setAttribute("user","User");
%>

<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard</title>

<script src="https://cdn.tailwindcss.com"></script>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>

@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700;800&display=swap');

body{
font-family:'Plus Jakarta Sans', system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
background-color:#f0f9ff;
background-image:
radial-gradient(at 0% 0%, #e0f2fe 0, transparent 50%),
radial-gradient(at 100% 0%, #f5f3ff 0, transparent 50%);
color:#1e293b;
overflow:hidden;
}

.glass-card{
background:rgba(255,255,255,0.6);
backdrop-filter:blur(10px);
border:1px solid rgba(255,255,255,0.7);
box-shadow:0 10px 30px rgba(14,165,233,0.05);
transition:all .4s;
cursor:pointer;
}

.glass-card:hover{
background:rgba(255,255,255,0.9);
transform:translateY(-8px);
box-shadow:0 20px 40px rgba(14,165,233,0.1);
}

.sidebar{
background:white;
border-right:1px solid #e2e8f0;
}

.nav-link{
transition:.3s;
color:#64748b;
}

.nav-link:hover,
.nav-link.active{
background:#f0f9ff;
color:#0ea5e9;
border-left:4px solid #0ea5e9;
}

.custom-scroll::-webkit-scrollbar{
width:5px;
}

.custom-scroll::-webkit-scrollbar-thumb{
background:#bae6fd;
border-radius:10px;
}

</style>
</head>

<body class="flex h-screen w-screen">

<!-- SIDEBAR -->

<aside class="sidebar w-64 flex-shrink-0 flex flex-col p-6">

<div class="flex items-center gap-3 mb-12">
<div class="w-10 h-10 bg-sky-400 rounded-xl flex items-center justify-center text-white font-black text-xl">
D
</div>

<h1 class="text-xl font-black">
Discovery <span class="text-sky-500">Hub</span>
</h1>
</div>

<nav class="space-y-2 flex-grow">

<a href="DashboardServlet" class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm"><span>📊</span> Dashboard</a>

<a href="SearchServlet" class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm"><span>🔍</span> Global Search</a>

<a href="lost.jsp" class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm"><span>📍</span> Report Loss</a>

<a href="found.jsp" class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm"><span>✅</span> Report Find</a>

<a href="ProfileStatsServlet" class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm">
<span>👤</span> User Details
</a>

<a href="MatchServlet"
class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm">
<span>🔗</span> Find Matches
</a>

<a href="NotificationServlet"
class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm">
<span>🔔</span> Notifications
</a>

<a href="LogoutServlet"
class="nav-link flex items-center gap-4 px-4 py-3 rounded-xl font-bold text-sm">
<span>🚪</span> Logout
</a>

</nav>

</aside>


<!-- MAIN CONTENT -->

<main class="flex-grow p-10 overflow-y-auto">

<!-- HEADER WITH NOTIFICATION BELL -->

<header class="mb-12 animate__animated animate__fadeIn flex justify-between items-start">

<div>

<span class="text-sky-500 font-bold text-xs uppercase tracking-widest mb-2 block">
System Status: Active
</span>

<h2 class="text-5xl font-extrabold text-slate-800 tracking-tight">

Hello, <%= session.getAttribute("username") %> 👋

</h2>

<p class="text-slate-500 mt-2 font-medium">
Here is what's happening in your community today.
</p>

</div>


<!-- BELL ICON -->

<div class="relative">

<a href="NotificationServlet"
class="text-4xl">

🔔

<span
class="absolute -top-2 -right-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded-full">

<%= request.getAttribute("count")==null?0:request.getAttribute("count") %>

</span>

</a>

</div>

</header>


<!-- STATS -->

<div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">

<div onclick="openDrawer('lost')" class="glass-card p-10 rounded-[3rem]">

<div class="flex justify-between items-center mb-6">

<div class="w-14 h-14 bg-rose-100 rounded-2xl flex items-center justify-center text-3xl">
📍
</div>

<span class="text-[10px] font-black text-rose-500 bg-rose-50 px-4 py-1 rounded-full">
Lost Items
</span>

</div>

<h3 class="text-7xl font-black mb-2">
<%= request.getAttribute("lostCount")==null?0:request.getAttribute("lostCount") %>
</h3>

<p class="text-slate-400 font-bold uppercase text-xs">
Awaiting Discovery
</p>

</div>


<div onclick="openDrawer('found')" class="glass-card p-10 rounded-[3rem]">

<div class="flex justify-between items-center mb-6">

<div class="w-14 h-14 bg-sky-100 rounded-2xl flex items-center justify-center text-3xl">
📦
</div>

<span class="text-[10px] font-black text-sky-500 bg-sky-50 px-4 py-1 rounded-full">
Safe Items
</span>

</div>

<h3 class="text-7xl font-black mb-2">
<%= request.getAttribute("foundCount")==null?0:request.getAttribute("foundCount") %>
</h3>

<p class="text-slate-400 font-bold uppercase text-xs">
Ready for Pickup
</p>

</div>

</div>


<!-- CTA -->

<section>

<div class="bg-gradient-to-r from-sky-400 to-indigo-400 p-10 rounded-[3rem] text-white flex justify-between items-center">

<div>

<h4 class="text-2xl font-bold">
Help someone today
</h4>

<p class="opacity-90 mt-1">
Found an item? Report it and we'll handle the rest.
</p>

</div>

<a href="found.jsp"
class="bg-white text-sky-500 px-8 py-4 rounded-2xl font-black hover:scale-105 transition">

Submit Report

</a>

</div>

</section>

</main>


<script>

function openDrawer(type){

window.location =
"DashboardServlet?type=" + type;

}

</script>

</body>
</html>