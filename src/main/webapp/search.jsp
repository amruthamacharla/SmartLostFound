<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Discovery Hub | Global Search</title>

<script src="https://cdn.tailwindcss.com"></script>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>

body{
font-family:'Plus Jakarta Sans',sans-serif;
background:#f8fafc;
color:#0f172a;
overflow:hidden;
}

.sidebar{
background:#0f172a;
color:#ffffff;
}

.nav-link{
transition:0.3s;
color:#94a3b8;
}

.nav-link:hover{
background:rgba(255,255,255,0.1);
color:white;
}

.search-card{
background:white;
border:1px solid #e2e8f0;
transition:0.3s;
}

</style>

</head>



<body class="flex h-screen">

<!-- SIDEBAR -->

<aside class="sidebar w-64 flex flex-col p-6">

<h1 class="text-xl font-black mb-10">
Discovery Hub
</h1>

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



<!-- MAIN -->

<main class="flex-1 overflow-y-auto p-10">

<h2 class="text-3xl font-black mb-2">
Global Registry
</h2>

<p class="text-slate-500 mb-6">
Search lost and found items
</p>



<input type="text"

id="searchInput"

onkeyup="searchItems()"

placeholder="Search item name or location..."

class="w-full max-w-xl px-6 py-4 rounded-2xl shadow">



<!-- RESULTS -->

<div id="resultsGrid"
class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mt-8">

<%
ArrayList<String[]> items =
(ArrayList<String[]>) request.getAttribute("itemsList");

if(items != null && !items.isEmpty()){

for(String item[] : items){

String type = item[0].toLowerCase();

/*
item[0] = type (lost/found)
item[1] = name
item[2] = location
item[3] = description
item[4] = image_path
*/

%>

<div class="search-card p-6 rounded-[2rem] hover:shadow-xl animate__animated animate__fadeIn">

<div class="h-40 rounded-xl mb-4 overflow-hidden">

<img src="uploads/<%= item[4] %>"
class="w-full h-full object-cover">

</div>

<span class="px-3 py-1 text-xs font-bold rounded-full
<%= type.equals("lost")
? "bg-rose-50 text-rose-500"
: "bg-indigo-50 text-indigo-600" %>">

<%= type.toUpperCase() %>

</span>

<h3 class="text-xl font-black mt-2">

<%= item[1] %>

</h3>

<p class="text-slate-400 font-bold">

📍 <%= item[2] %>

</p>

<p class="text-xs text-slate-500 mt-2">

<%= item[3] %>

</p>

</div>

<%

}

}else{

%>

<p class="text-gray-400">

No items found

</p>

<%

}

%>

</div>
</main>



<script>

function searchItems(){

let input =
document.getElementById("searchInput")
.value.toLowerCase();


let cards =
document.querySelectorAll(".search-card");


cards.forEach(card=>{

let text =
card.innerText.toLowerCase();


card.style.display =
text.includes(input)
? "block"
: "none";

});

}

</script>


</body>

</html>