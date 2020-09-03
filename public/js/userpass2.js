$("#allContainer").css("height", window.innerHeight);

$("#userButton").on("click", function (e) {
  window.location.href = "/userpass";
});

$("#userButtonContainer").css("top", window.innerHeight - window.innerWidth * 0.06 + "px");

$(".selectContainer").on("click", function(e){
  let id = $(this).attr("id");
  $.ajax("/usermain", {
    type: "POST",
    data: {
      memberid: id
    },
    datatyle: "html"
  }).done(function(){
    window.location.href = "/usermain"
  });
});

$("#h").css("font-size", window.innerWidth * 0.04);


let resizeTimer = null;
$(window).on("resize", function(e) {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(function() {
    window.location.href = "/userpass2"
  }, 200);
});
