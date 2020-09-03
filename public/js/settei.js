let resizeTimer = null;
$(window).on("resize", function(e) {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(function() {
    window.location.href = "/settei"
  }, 200);
});
let allContainerHeight = parseFloat($("#allContainer").css("height"));

let allContainerPosition = (window.innerHeight - allContainerHeight) / 2;
if(allContainerPosition > 0){
  $("#allContainer").css("top", allContainerPosition);
}



$(".setteiSelectContainer").on("click", function(e){
  let id = $(this).children(".setteiButton").attr("id");
  if(id == "seasonSettei"){
    window.location.href = "/seasonsettei"
  } else if (id == "dbSettei"){
    window.location.href = "/dbsettei"
  } else if (id == "toukeiSettei"){
    window.location.href = "/toukeisettei"
  }
});


$("*").css("font-size", window.innerWidth * 0.015 + "px");

console.log($("*").css("font-size"));

$("#homeButton").on("click", function(e){
  window.location.href = "/";
});

$("#homeButtonContainer").css("top", window.innerHeight - window.innerWidth * 0.06 + "px");
