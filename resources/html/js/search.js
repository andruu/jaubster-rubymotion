$('#search-btn').on('click', function (e) {
  e.preventDefault();
  console.log('clicked search');
  window.location = "myapp://search/message";
});

$('#save-btn').on('click', function (e) {
  e.preventDefault();
  console.log('clicked save');
  window.location = "myapp://save/message";
});

function initClearQueryLink(query,clearQuery){
  clearQuery.setAttribute("title","Clear");
  clearQuery.style.display="none";
  clearQuery.style.visibility="hidden"
  clearQuery.addEventListener("mousedown",clearQueryBox,true);
  query.addEventListener("keyup",_handleClearQueryLink,false)
}

function _handleClearQueryLink(){
  var query=document.getElementById("search");
  var clearQuery=document.getElementById("clearQuery");
  if(clearQuery)
  if(query.value.length>0){
    clearQuery.style.display="inline";
    clearQuery.style.visibility="visible"
  } else{
    clearQuery.style.display="none";
    clearQuery.style.visibility="hidden"
  }
}

function clearQueryBox(event){
  var query=document.getElementById("search");
  var clearQuery=document.getElementById("clearQuery");
  query.value="";
  clearQuery.style.display="none";
  clearQuery.style.visibility="hidden";
  //// hideSuggest();
  if(event)event.preventDefault()
}

function initClear() {
  var query=document.getElementById("search");
  var clearQuery=document.getElementById("clearQuery")
  initClearQueryLink(query, clearQuery);
}

initClear();