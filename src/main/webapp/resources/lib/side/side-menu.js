/**
 * Side : Responsive Menu
 *
 * This file contains all theme JS functions
 *
 * @package Side : Responsive Menu
--------------------------------------------------------------
                   Contents
--------------------------------------------------------------
 * 01 - Navigation
 * 02 - Navigation Scroll Easing
--------------------------------------------------------------

/*--------------------------------------------------------------
          Navigation
--------------------------------------------------------------*/
$(function() {
  $('.sl-menu-button').on('click', function (e) {
      e.preventDefault();
      $(".sl-menu-button").css({"opacity": "0", "left": "-100px"});
      $(".sl-menu-button-close").css({"opacity": "1", "left": "0"});  
      $(".sl-menu-block").addClass('active');    
  });
  $('.sl-menu-button-close').on('click', function (e) {
      e.preventDefault();
      $(".sl-menu-button-close").css({"opacity": "0", "left": "-100px"});
      $(".sl-menu-button").css({"opacity": "1", "left": "0"});
      $(".sl-menu-block").removeClass('active');          
  });
  $('.nav').on('click', function (e) {
      $(".sl-menu-button-close").css({"opacity": "0", "left": "-100px"});
      $(".sl-menu-button").css({"opacity": "1", "left": "0"});
      $(".sl-menu-block").removeClass('active');
      
  });
 });

/*--------------------------------------------------------------
          Navigation Scroll Easing
--------------------------------------------------------------*/
//jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
  $('a.page-scroll').bind('click', function(event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
        scrollTop: $($anchor.attr('href')).offset().top
    }, 1500, 'easeInOutExpo');
    event.preventDefault();
  });
});

/*--------------------------------------------------------------
          Go to Top 
--------------------------------------------------------------*/
$(function(){
  if ($('#go-to-top').length) {
      var scrollTrigger = 500, // px
          backToTop = function () {
              var scrollTop = $(window).scrollTop();
              if (scrollTop > scrollTrigger) {
                  $('#go-to-top').addClass('show');
              } else {
                  $('#go-to-top').removeClass('show');
              }
          };
      backToTop();
      $(window).on('scroll', function () {
          backToTop();
      });
      $('#go-to-top').on('click', function (e) {
          e.preventDefault();
          $('html,body').animate({
              scrollTop: 0
          }, 700);
      });
  }
});

