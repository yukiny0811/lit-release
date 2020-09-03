$(".selectContainer").each(function(i, e) {
  $(e).css("height", window.innerWidth * 0.222);
});



$("*").css("font-size", window.innerWidth * 0.015 + "px");

let resizeTimer = null;
$(window).on("resize", function(e) {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(function() {
    window.location.href = "/seasonsettei"
  }, 200);
});


$(".selectContainer").on("mouseenter", function(e) {
  $(".selectButton").each(function(i, e) {
    $(e).css("width", "80%");
  });
  $(this).children(".selectButton").css("width", "100%");
});
$(".selectContainer").on("mouseleave", function(e) {
  $(".selectButton").each(function(i, e) {
    $(e).css("width", "80%");
  });
});

$.ajax("/seasonsettei", {
  type: "POST",
  dataType: "html"
}).done(function(res){
  let tempID = res;
  $(".selectContainer").children("#" + tempID).css("fill", "rgb(255, 199, 32)");
});

$(".selectContainer").on("click", function(e){
  let id = $(this).attr("id");
  $(".selectButton").css("fill", "lightgray");
  $(this).children(".selectButton").css("fill", "rgb(255, 199, 32)");
  $.ajax("/seasonsettei", {
    type: "POST",
    data:{seasonsetteiid: id},
    dataType: "html"
  }).done(function(res){
  });
});

$("#homeButton").on("click", function(e){
  window.location.href = "/settei";
});

$("#homeButtonContainer").css("top", window.innerHeight - window.innerWidth * 0.06 + "px");
