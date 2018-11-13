//= require rails-ujs
//= require_tree ./app
//= require popper
//= require jquery3
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap
//= require jasny-bootstrap


//= require cookies_eu

$(document).on("click", "a.scroll", function(event){
  event.preventDefault();

  $("html, body").animate({
      scrollTop: $( $.attr(this, "href") ).offset().top
  }, 500);
});
