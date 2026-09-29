<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Report Lost Item | Finder</title>

<script src="https://cdn.tailwindcss.com"></script>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>

.lost-gradient{
background:linear-gradient(
135deg,
#f0f9ff 0%,
#e0f2fe 100%);
}

.preview-card-lost{
border-top:6px solid #0ea5e9;
transition:all 0.4s ease;
}

.custom-textarea::-webkit-scrollbar{
width:4px;
}

.custom-textarea::-webkit-scrollbar-thumb{
background:#7dd3fc;
border-radius:10px;
}

</style>

</head>


<body class="lost-gradient min-h-screen font-sans">

<div class="max-w-7xl mx-auto px-6 py-12">

<div class="flex flex-col lg:flex-row gap-12">




<!-- FORM SECTION -->

<div class="flex-1 animate__animated animate__fadeIn">

<div class="mb-10">

<span class="text-sky-600 font-bold tracking-widest uppercase text-sm">
Action Required
</span>

<h1 class="text-4xl font-black text-slate-900 mt-2">
I Lost Something
</h1>

<p class="text-slate-500">
Fill out these details so the community can help you find it.
</p>

</div>



<form action="LostItemServlet"
method="post"
enctype="multipart/form-data">

<div class="bg-white p-8 md:p-10 rounded-[3rem] shadow-xl shadow-sky-100/50 space-y-6">



<!-- PHOTO -->

<div>

<label class="block text-sm font-bold text-slate-700 mb-3">
Do you have a photo of the item?
</label>

<div onclick="document.getElementById('lost-photo').click()"

class="h-40 border-2 border-dashed border-sky-200 rounded-[2rem]
flex flex-col items-center justify-center cursor-pointer
hover:bg-sky-50 hover:border-sky-400 transition-all">

<span id="status-icon"
class="text-3xl mb-1">
🔍
</span>

<p class="text-sky-400 text-xs font-bold uppercase">
Upload reference photo
</p>

<input type="file"
name="image"
id="lost-photo"
class="hidden"
accept="image/*"
onchange="previewLostImage(event)">

</div>

</div>



<!-- ITEM NAME + DATE -->

<div class="grid grid-cols-1 md:grid-cols-2 gap-6">


<div>

<label class="block text-sm font-bold text-slate-700 mb-2">
Item Name
</label>

<input type="text"

name="item_name"

id="l-name"

onkeyup="liveUpdate()"

placeholder="e.g. Sony Headphones"

class="w-full px-6 py-4 rounded-2xl bg-slate-50 border-none
focus:ring-2 focus:ring-sky-400 outline-none">

</div>



<div>

<label class="block text-sm font-bold text-slate-700 mb-2">
Date Last Seen
</label>

<input type="date"

name="date"

id="l-date"

onchange="liveUpdate()"

class="w-full px-6 py-4 rounded-2xl bg-slate-50 border-none
focus:ring-2 focus:ring-sky-400 outline-none text-slate-500">

</div>

</div>




<!-- LOCATION -->

<div>

<label class="block text-sm font-bold text-slate-700 mb-2">
Last Known Location
</label>

<input type="text"

name="location"

id="l-loc"

onkeyup="liveUpdate()"

placeholder="e.g. Near the food court or Gate B"

class="w-full px-6 py-4 rounded-2xl bg-slate-50 border-none
focus:ring-2 focus:ring-sky-400 outline-none">

</div>




<!-- DESCRIPTION -->

<div>

<label class="block text-sm font-bold text-slate-700 mb-2">
Detailed Description
</label>

<textarea

name="description"

id="l-desc"

onkeyup="liveUpdate()"

rows="4"

placeholder="Describe marks, stickers, scratches..."

class="w-full px-6 py-4 rounded-2xl bg-slate-50 border-none
focus:ring-2 focus:ring-sky-400 outline-none resize-none custom-textarea">

</textarea>

</div>




<!-- SUBMIT BUTTON -->

<button type="submit"

class="w-full py-5 bg-sky-500 text-white rounded-[2rem]
font-bold text-xl hover:bg-sky-600 transition-all
shadow-lg shadow-sky-200 active:scale-95">

Post Missing Item

</button>



</div>

</form>

</div>






<!-- PREVIEW CARD -->

<div class="lg:w-[380px] animate__animated animate__fadeInUp">

<div class="sticky top-10">

<h3 class="text-center font-bold text-sky-300 uppercase
tracking-widest text-xs mb-6">

Missing Item Preview

</h3>



<div id="card-wrap"

class="bg-white rounded-[2.5rem] overflow-hidden shadow-2xl preview-card-lost">



<div class="h-56 bg-slate-100 relative overflow-hidden">

<img id="view-img"

src=""

class="w-full h-full object-cover hidden">



<div id="view-placeholder"

class="absolute inset-0 flex flex-col items-center
justify-center p-8 text-center">

<div class="w-16 h-16 border-4 border-sky-50
border-t-sky-200 rounded-full animate-spin mb-4">

</div>

<p class="text-slate-400 text-sm italic font-medium">

Waiting for photo...

</p>

</div>

</div>





<div class="p-8">

<div class="flex justify-between items-start mb-4">

<h2 id="view-name"

class="text-2xl font-black text-slate-800 leading-tight">

Missing Item

</h2>


<span id="view-date"

class="text-[10px] font-bold bg-sky-50 text-sky-500
px-3 py-1 rounded-full uppercase tracking-tighter">

DATE

</span>

</div>




<p class="flex items-center gap-2 text-slate-400
text-sm mb-5 font-medium">

<span id="view-loc">

Location...

</span>

</p>




<div class="border-t border-slate-50 pt-5">

<p class="text-[10px] font-black text-slate-300 uppercase mb-2">

Description Preview

</p>



<p id="view-desc"

class="text-slate-600 text-sm leading-relaxed italic">

Your detailed description will appear here...

</p>

</div>

</div>

</div>

</div>

</div>

</div>

</div>





<script>


function previewLostImage(event){

const reader = new FileReader();

reader.onload = function(){

const img =
document.getElementById('view-img');

const placeholder =
document.getElementById('view-placeholder');

img.src = reader.result;

img.classList.remove('hidden');

placeholder.classList.add('hidden');

document.getElementById('status-icon').innerText="📸";

}

reader.readAsDataURL(event.target.files[0]);

}




function liveUpdate(){

const name =
document.getElementById('l-name').value;

const date =
document.getElementById('l-date').value;

const loc =
document.getElementById('l-loc').value;

const desc =
document.getElementById('l-desc').value;



document.getElementById('view-name').innerText =
name || "Missing Item";



document.getElementById('view-date').innerText =
date || "DATE";



document.getElementById('view-loc').innerText =
loc || "Location...";



document.getElementById('view-desc').textContent =
desc
? '"' + desc + '"'
: "Your detailed description will appear here...";

}


</script>



</body>

</html>