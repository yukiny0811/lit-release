


$(".setteiSelectContainer").on("click", function(e){
  $.ajax("/setteipass", {
    type: "POST",
    data:{ismentor: true},
    datatyle: "html"
  }).done(function(){
    window.location.href = "/settei";
  });
});

$(".setteiSelectContainer").css("height", window.innerWidth * 0.2);
$(".setteiSelectContainer").css("top", (window.innerHeight - window.innerWidth * 0.2) / 2);


$("*").css("font-size", window.innerWidth * 0.015 + "px");

console.log($("*").css("font-size"));

$("#homeButton").on("click", function(e){
  window.location.href = "/";
});

$("#homeButtonContainer").css("top", window.innerHeight - window.innerWidth * 0.06 + "px");


let resizeTimer = null;
$(window).on("resize", function(e) {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(function() {
    window.location.href = "/setteipass"
  }, 200);
});
