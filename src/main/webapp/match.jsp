<%@ page import="java.util.ArrayList" %>
<script src="https://cdn.tailwindcss.com"></script>

<body class="bg-blue-50 min-h-screen p-6">

<h2 class="text-3xl font-bold text-blue-700 mb-6 text-center">
Matching Results
</h2>

<%
ArrayList matches = (ArrayList) request.getAttribute("matches");

if(matches != null && matches.size() > 0){

for(Object o : matches){

String m[] = (String[]) o;

/* SAFE SCORE */
double score = 0;
try{
score = Double.parseDouble(m[4]);
}catch(Exception e){
score = 0;
}
%>

<div class="bg-white shadow-lg rounded-2xl p-6 mb-6 max-w-3xl mx-auto border border-blue-100">

<div class="grid grid-cols-2 gap-6">

<!-- Lost Item -->
<div class="text-center">
<h3 class="text-blue-600 font-bold text-lg mb-2">
 Lost Item
</h3>

<p class="font-semibold mb-3">
<%= m[0] %>
</p>
<img src="uploads/<%= m[2] %>"
class="mx-auto rounded-xl shadow-md border border-gray-200"
width="150">
</div>

<!-- Found -->
<div class="text-center">
<h3 class="text-green-600 font-bold text-lg mb-2">
Found Item
</h3>

<p class="font-semibold mb-3">
<%= m[1] %>
</p>
<img src="uploads/<%= m[3] %>"
class="mx-auto rounded-xl shadow-md border border-gray-200"
width="150">
</div>


</div>

<p class="text-lg font-semibold text-gray-700">
Match Score :
<span class="text-blue-700 text-xl font-bold">
<%= Math.round(Double.parseDouble(m[4]) * 100) %>%
</span>
</p>
<p class="mt-2 text-gray-600">
Found Reported By :
<span class="font-bold text-blue-600">
<%= m[6] %>
</span>
</p>

</div>
</div>

<%
}
}else{
%>

<div class="text-center bg-white p-6 rounded-xl shadow">
<h3>❌ No Matches Found</h3>
</div>

<%
}
%>

</body>