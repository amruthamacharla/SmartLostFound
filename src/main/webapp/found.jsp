<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report Item Details | Reunited</title>

<script src="https://cdn.tailwindcss.com"></script>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
.preview-card{
transition:all 0.5s cubic-bezier(0.175,0.885,0.32,1.275);
}

.custom-scroll::-webkit-scrollbar{width:4px;}
.custom-scroll::-webkit-scrollbar-thumb{background:#e2e8f0;border-radius:10px;}
</style>
</head>

<body class="min-h-screen bg-gradient-to-br from-sky-50 to-sky-200">
<div class="max-w-7xl mx-auto px-4 py-12">

<div class="flex flex-col lg:flex-row gap-12">

<!-- FORM SECTION -->

<div class="flex-1 animate__animated animate__fadeInLeft">

<div class="mb-10 text-center lg:text-left">

<h1 class="text-4xl font-black text-slate-900 tracking-tight">
Post Found Item
</h1>

<p class="text-slate-500 mt-2">
The more details you give, the faster it finds home.
</p>

</div>

<form action="FoundItemServlet"
method="post"
enctype="multipart/form-data">

<div class="bg-white p-8 md:p-10 rounded-[3rem] shadow-sm border border-slate-100 space-y-6">

<!-- IMAGE -->

<div class="relative group">

<label class="block text-sm font-bold text-slate-700 mb-3 ml-2">
Upload Photo
</label>

<div onclick="document.getElementById('user-photo').click()"
class="h-48 border-2 border-dashed border-slate-200 rounded-[2rem] flex flex-col items-center justify-center cursor-pointer group-hover:border-indigo-400 group-hover:bg-indigo-50 transition-all">

<span id="upload-status" class="text-4xl mb-2">🖼️</span>

<p class="text-slate-400 text-sm font-medium">
Click to select image
</p>

<input type="file"
name="image"
id="user-photo"
class="hidden"
accept="image/*"
onchange="handleImage(event)">

</div>

</div>

<!-- NAME + DATE -->

<div class="grid grid-cols-1 md:grid-cols-2 gap-6">

<div>

<label class="block text-sm font-bold text-slate-700 mb-3 ml-2">
Item Name
</label>

<input type="text"
name="item_name"
id="in-name"
oninput="sync()"
placeholder="Black Wallet, iPhone..."
class="w-full px-6 py-4 rounded-2xl bg-slate-50 border-none outline-none focus:ring-2 focus:ring-indigo-400">

</div>

<div>

<label class="block text-sm font-bold text-slate-700 mb-3 ml-2">
Date Found
</label>

<input type="date"
name="date"
id="in-date"
oninput="sync()"
class="w-full px-6 py-4 rounded-2xl bg-slate-50 border-none outline-none focus:ring-2 focus:ring-indigo-400 text-slate-500">

</div>

</div>

<!-- LOCATION -->

<div>

<label class="block text-sm font-bold text-slate-700 mb-3 ml-2">
Specific Location
</label>

<input type="text"
name="location"
id="in-loc"
oninput="sync()"
placeholder="e.g. Near the Coffee Shop at Terminal 3"
class="w-full px-6 py-4 rounded-2xl bg-slate-50 border-none outline-none focus:ring-2 focus:ring-indigo-400">

</div>

<!-- DESCRIPTION -->

<div>

<label class="block text-sm font-bold text-slate-700 mb-3 ml-2">
Description
</label>

<textarea
name="description"
id="in-desc"
oninput="sync()"
rows="4"
placeholder="Describe unique marks, color, or contents..."
class="w-full px-6 py-4 rounded-2xl bg-slate-50 border-none outline-none focus:ring-2 focus:ring-indigo-400 resize-none">
</textarea>

</div>

<!-- SUBMIT -->

<button type="submit"
class="w-full py-5 bg-slate-900 text-white rounded-[2rem] font-bold text-xl hover:bg-indigo-600 transition-all shadow-xl active:scale-95">

Publish Listing

</button>

</div>

</form>

</div>

<!-- PREVIEW CARD -->

<div class="lg:w-[400px] animate__animated animate__fadeInRight">

<div class="sticky top-10">

<h3 class="text-center font-bold text-slate-400 uppercase tracking-widest text-xs mb-6">
How it will look
</h3>

<div id="p-card" class="bg-white rounded-[3rem] overflow-hidden shadow-2xl preview-card">

<div class="h-64 bg-slate-200 overflow-hidden relative">

<img id="p-img" src="" class="w-full h-full object-cover hidden">

<div id="p-placeholder"
class="absolute inset-0 flex items-center justify-center text-slate-400 font-bold italic p-10 text-center">

No Photo Uploaded

</div>

</div>

<div class="p-8">

<div class="flex justify-between items-start mb-4">

<h2 id="p-name" class="text-2xl font-black text-slate-800 leading-tight">
Item Title
</h2>

<span id="p-date"
class="text-[10px] font-bold bg-indigo-50 text-indigo-500 px-3 py-1 rounded-full whitespace-nowrap">
DATE
</span>

</div>

<p class="flex items-center gap-2 text-slate-400 text-sm mb-4">

<span id="p-loc">Location details...</span>

</p>

<div class="bg-slate-50 p-4 rounded-2xl">

<p class="text-xs font-bold text-slate-400 uppercase mb-2">
Description
</p>

<p id="p-desc"
class="text-slate-600 text-sm leading-relaxed max-h-24 overflow-y-auto custom-scroll">

Full description will appear here as you type...

</p>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

<script>

function handleImage(e){

const reader=new FileReader();

reader.onload=function(){

const img=document.getElementById('p-img');
const placeholder=document.getElementById('p-placeholder');

img.src=reader.result;
img.classList.remove('hidden');
placeholder.classList.add('hidden');

document.getElementById('upload-status').innerText="✅";

}

reader.readAsDataURL(e.target.files[0]);

}

function sync(){

const name=document.getElementById('in-name').value;
const date=document.getElementById('in-date').value;
const loc=document.getElementById('in-loc').value;
const desc=document.getElementById('in-desc').value;

document.getElementById('p-name').innerText=name||"Item Title";
document.getElementById('p-date').innerText=date||"SELECT DATE";
document.getElementById('p-loc').innerText=loc||"Location details...";
document.getElementById('p-desc').innerText=desc||"Full description will appear here as you type...";

const card=document.getElementById('p-card');
card.style.transform="scale(1.02)";
setTimeout(()=>card.style.transform="scale(1)",100);

}

</script>

</body>
</html>