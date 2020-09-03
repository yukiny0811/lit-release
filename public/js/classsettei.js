
let add = false;
$("#addForm").on("click", function(e){
  if (add == false){
    $("#addForm").css("z-index", 0);
    $("#addForm").css("opacity", 0);
  }
});
$("#textCon").on("mouseenter", function(e){
  console.log("test");
  add = true;
});
$("#subCon").on("mouseenter", function(e){
  add = true;
});
$("#textCon").on("mouseleave", function(e){
  add = false;
});
$("#subCon").on("mouseleave", function(e){
  add = false;
});
$(".selectContainer").each(function(i, e){
  $(e).css("height", window.innerWidth * 0.222);
});

$("#addButton").on("click", function(e){
  $("#addForm").css("z-index", 100);
  $("#addForm").css("opacity", 1);
});



let saveSeasonButtonContainerWidth = parseFloat($("#seasonButtonContainer").css("width"));

$("*").css("font-size", window.innerWidth * 0.015 + "px");

let resizeTimer = null;
$(window).on("resize", function(e) {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(function() {
    window.location.href = "/classsettei"
  }, 200);
});

$(".selectContainer").on("mouseenter", function(e) {
  $(".selectButton").each(function(i, e) {
    $(e).css("width", "80%");
  });
  $(".deleteButton").each(function(i, e) {
    $(e).remove();
  });
  $(this).children(".selectButton").css("width", "100%");
  $(this).append('<svg class="deleteButton" data-name="temp" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 605 605"><rect class="cls-1" x="0.5" y="0.5" width="604" height="604" rx="129.61"/><polygon class="cls-2" points="468.67 94.32 302.5 260.49 136.33 94.32 93.9 136.74 260.07 302.91 95.32 467.67 137.74 510.1 302.5 345.34 467.26 510.1 509.68 467.67 344.93 302.91 511.1 136.74 468.67 94.32"/></svg>');
  $(this).children(".deleteButton").css("width", "20%");
  $(".deleteButton").on("click", function(e) {
    console.log("test");
    let id = $(this).parent().attr("id");
    $(this).parent().remove();
    $.ajax("/classsettei", {
      type: "POST",
      data: {
        classid: id
      },
      datatyle: "html"
    });
  });
});
$(".selectContainer").on("mouseleave", function(e) {
  $(".selectButton").each(function(i, e) {
    $(e).css("width", "80%");
  });
  $(".deleteButton").each(function(i, e) {
    $(e).remove();
    $(e).css("width", "20%");
  });
});

$(".selectContainer").on("click", function(e){
  let id = $(this).attr("id");
  $.ajax("/classsettei", {
    type: "POST",
    data:{classselectid: id},
    datatyle: "html"
  }).done(function(){
    window.location.href = "/teamsettei"
  });
});

$("#addButtonContainer").css("top", window.innerHeight - window.innerWidth * 0.06 + "px");
$("#backButtonContainer").css("top", window.innerHeight - window.innerWidth * 0.06 + "px");

$("#seasonButtonContainer").on("mouseenter", function(e) {
  console.log(parseFloat($("#seasonButtonContainer").css("width")) * 1.3 + "px");
  $("#seasonButtonContainer").css("width", saveSeasonButtonContainerWidth * 1.3 + "px");
});

$("#seasonButtonContainer").on("mouseleave", function(e) {
  $("#seasonButtonContainer").css("width", saveSeasonButtonContainerWidth + "px");
});


$("#seasonButtonContainer").on("click", function(e) {
  window.location.href = "/dbsettei";
});

$("#backButton").on("click", function(e){
  window.location.href = "/dbsettei";
});

$("#homeButton").on("click", function(e){
  window.location.href = "/settei";
});

$("#textCon").css("top", window.innerHeight * 0.45);
$("#subCon").css("top", window.innerHeight * 0.55);
