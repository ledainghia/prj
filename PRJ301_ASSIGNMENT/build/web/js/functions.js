//LOADER
$(window).on("load", function () {
   "use strict";
   $(".loader").fadeOut(800);
   $("#ex2").slider({});
   $("#pageload-modal").modal("show");


});

jQuery(function ($) {
   "use strict";

   /*Variables for chache $ chaining*/
   var $root = $("html, body");
   var $window = $(window);
   var $wideContainer = $(".container-fluid");


   // ------- Back to Top -------
   $("body").append('<a href="#" class="back-to"><i class="fa fa-angle-up"></i></a>');
   var amountScrolled = 700;
   var backBtn = $("a.back-to");
   $window.on("scroll", function () {
      if ($window.scrollTop() > amountScrolled) {
         backBtn.fadeIn("slow");
      } else {
         backBtn.fadeOut("slow");
      }
   });
   backBtn.on("click", function () {
      $root.animate({
         scrollTop: 0
      }, 700);
      return false;
   });


   /* ----- Smooth Scroll ----- */
   $(".scroll").on("click", function () {
      var menu = $(".navbar.bootsnav").height();
      $root.animate({
         scrollTop: ($($.attr(this, "href")).offset().top - menu)
      }, 700);
      return false;
   });


   /* ------- Add Space around The Wide Container ------- */
   function containersmallspace() {
      if ($("body").hasClass("boxed")) {
         if ($window.width() > 800) {
            $wideContainer.css("padding-left", 30);
            $wideContainer.css("padding-right", 30);
         }
      }
   }

   /*------- Add More Space around The Wide Container -------*/
   function containerSpace() {
      if ($("body").hasClass("home-three")) {
         if ($window.width() > 991) {
            $wideContainer.css("padding-left", 70);
            $wideContainer.css("padding-right", 70);
         }
         else{
            $wideContainer.css("padding-left", 15);
            $wideContainer.css("padding-right", 15);
         }
      }
   }

   /* ------- Full Height Banner BG ------*/
   function resizebanner() {
      $(".fullscreen").css("height", $(window).height());
   }


   /* ----- Calling Functions On Window Resiz ----- */
   $(window).resize(function () {
      containersmallspace();
      containerSpace();
      resizebanner();
   });
   containersmallspace();
   containerSpace();
   resizebanner();



   /*  ------- Login On Click ------- */
   // var $toggleLogin = $(".login_toggle");
   // var $login = $(".login_container");
   // $toggleLogin.on("click", function () {
   // if ($('.login_container').hasClass("active")) {
   //    $login.fadeOut(1000, function () {
   //       $login.removeClass('active');
   //    });
   // } else {
   //    $login.fadeIn(1000, function () {
   //       $login.addClass('active');
   //    });
   //    $(".close_login").on("click", function () {
   //       $login.removeClass("active");
   //    });
   //    return false;
   // }
   // });

   // var $toggleLogin = $(".register_toggle");
   // var $login = $(".login_container");
   // $toggleLogin.on("click", function () {
   // if ($('.login_container').hasClass("active")) {
   //    $login.fadeOut(1000, function () {
   //       $login.removeClass('active');
   //    });
   // } else {
   //    $login.fadeIn(1000, function () {
   //       $login.addClass('active');
   //    });
   //    $(".close_login").on("click", function () {
   //       $login.removeClass("active");
   //    });
   //    return false;
   // }
   // });


   /* ------  Search On Click ----*/
   $(".search_btn").on("click", function (event) {
      event.preventDefault();
      $("#search").addClass("open");
      $("#search > form > input[type='search']").focus();
   });
   $("#search, #search button.close").on("click keyup", function (event) {
      if (event.target == this || event.target.className == "close" || event.keyCode == 27) {
         $(this).removeClass("open");
      }
   });


   /* ----- Change Shop Grid to lists ----- */
   $(".filter-item").on("click", function () {
      if ($(".filter-item").hasClass("active")) {
         var $el = $('.' + this.id).fadeIn(300);
         $(".griders").not($el).fadeOut(300);
      }
      $(this).parent().find("active").removeClass("active");
      $(this).addClass("active");
      return false;
   });


   /* ------ Menu Full ------ */
   $(".togglemenu").on("click", function (event) {
      event.preventDefault();
      $(".emp_menu").slideToggle("slow");
   });


   /* ------- Footer Reveals ------- */
   if ($window.width() > 768) {
      $(".footer").footerReveal();
   }

   /* ------- EQUAL HEIGHT BLOCK ------ */
   $(".equal_parent .equal_inner").matchHeight();



   /* -------- SHOPPING CART ----- */
   var trigger = $(".hamburger"),
      overlay = $(".overlaybody"),
      isClosed = false;
   var bodyadd = $('<div class="overlaybody"></div>');

   if (trigger.length) {
      bodyadd.insertBefore("header");
      trigger.click(function () {
         hamburger_cross();
      });

      function hamburger_cross() {
         if (isClosed == true) {
            overlay.hide();
            trigger.removeClass("is-open");
            trigger.addClass("is-closed");
            isClosed = false;
         } else {
            overlay.show();
            trigger.removeClass("is-closed");
            trigger.addClass("is-open");
            isClosed = true;
         }
      }

      $("[data-toggle='offcanvas']").on("click", function () {
         $(".wrapper").toggleClass("toggled");
      });
      $(".overlaybody").on("click", function () {
            $(".wrapper").removeClass("toggled");
      });
   }



   /* --------- to input quantity (Shop page)*/
   $(".btn-number").on("click", function (e) {
      var fieldName = $(this).attr("data-field");
      var type = $(this).attr("data-type");
      var input = $("input[name='" + fieldName + "']");
      var currentVal = parseInt(input.val());
      if (!isNaN(currentVal)) {
         if (type == "minus") {
            if (currentVal > input.attr("min")) {
               input.val(currentVal - 1).change();
            }
            if (parseInt(input.val()) == input.attr("min")) {
               $(this).attr("disabled", true);
            }

         } else if (type == "plus") {
            if (currentVal < input.attr("max")) {
               input.val(currentVal + 1).change();
            }
            if (parseInt(input.val()) == input.attr("max")) {
               $(this).attr("disabled", true);
            }
         }
      } else {
         input.val(0);
      }
   });
   $(".input-number").focusin(function () {
      $(this).data("oldValue", $(this).val());
   });
   $(".input-number").change(function () {
      var minValue = parseInt($(this).attr("min"));
      var maxValue = parseInt($(this).attr("max"));
      var valueCurrent = parseInt($(this).val());
      var name = $(this).attr("name");
      if (valueCurrent >= minValue) {
         $(".btn-number[data-type='minus'][data-field='" + name + "']").removeAttr("disabled")
      } else {
         alert("Sorry, the minimum value was reached");
         $(this).val($(this).data("oldValue"));
      }
      if (valueCurrent <= maxValue) {
         $(".btn-number[data-type='plus'][data-field='" + name + "']").removeAttr("disabled")
      } else {
         alert("Sorry, the maximum value was reached");
         $(this).val($(this).data("oldValue"));
      }
   });
   //TO prevent on click effect on didderent inputs
   $(".input-number").keydown(function (e) {
      // Allow: backspace, delete, tab, escape, enter and .
      if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
         // Allow: Ctrl+A
         (e.keyCode == 65 && e.ctrlKey === true) ||
         // Allow: home, end, left, right
         (e.keyCode >= 35 && e.keyCode <= 39)) {
         // let it happen, don't do anything
         return;
      }
      // Ensure that it is a number and stop the keypress
      if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
         e.preventDefault();
      }
   });




   // --------  tabbed content On Shop Details Page
   $(".tab_content").hide();
   $(".tab_content:first").show();

   /* if in tab mode */
   $("ul.tabs li").on('click', function () {
      $(".tab_content").hide();
      var activeTab = $(this).attr("rel");
      $("#" + activeTab).fadeIn();

      $("ul.tabs li").removeClass("active");
      $(this).addClass("active");

      $(".tab_drawer_heading").removeClass("d_active");
      $(".tab_drawer_heading[rel^='" + activeTab + "']").addClass("d_active");

   });


   //login
   $(document).ready(function() {
      // Bắt sự kiện click trên các tab
      $('.login_toggle').click(function() {
        // Xóa lớp active cho tất cả các tab
        $('.nav-tabs li').removeClass('active');
        // Thêm lớp active cho tab Login
        $('.login_toggle').closest('li').addClass('active');
    
        // Hiển thị tab và nội dung đã đăng ký
        $('#registered').addClass('in active');
        $('#profile').removeClass('in active');
      });
    
      $('.register_toggle').click(function() {
        // Xóa lớp active cho tất cả các tab
        $('.nav-tabs li').removeClass('active');
        // Thêm lớp active cho tab Register
        $('.register_toggle').closest('li').addClass('active');
    
        // Hiển thị tab và nội dung đăng ký mới
        $('#registered').removeClass('in active');
        $('#profile').addClass('in active');
      });
    });

   /* if in drawer mode on Mobile Version*/
   $(".tab_drawer_heading").on('click', function () {
      $(".tab_content").hide();
      var d_activeTab = $(this).attr("rel");
      $("#" + d_activeTab).fadeIn();

      $(".tab_drawer_heading").removeClass("d_active");
      $(this).addClass("d_active");

      $("ul.tabs li").removeClass("active");
      $("ul.tabs li[rel^='" + d_activeTab + "']").addClass("active");
   });


   /* ----- Filter Products Metas ---- */
   $(".btnfilter").on("click", function () {
      $(".container-select").slideToggle("fast");
   });


   /* ----- Counters -----*/
   if ($(".number-counters").length) {
      $(".number-counters [data-to]").each(function () {
         var e = $(this).attr("data-to");
         $(this).delay(200).countTo({
            from: 1,
            to: e,
            speed: 1500,
            refreshInterval: 50
         })
      })
   }


   /* ----- Toggle DropDown for share buttns ----- */
   $(".emp-share").on("click", function () {
      $(".share-holder").fadeToggle();
   });
      

   /* ----- POPOver ----- */
   $(function () {
      $('[data-toggle="popover"]').popover()
   });


   /* ----- Accordions ----- */
   $(".set > a").on("click", function () {
      if ($(this).hasClass('active')) {
         $(this).removeClass("active");
         $(this).siblings('.content').slideUp(500);
         $(".set > a i").removeClass("d-dot").addClass("s-dot");
      } else {
         $(".set > a i").removeClass("d-dot").addClass("s-dot");
         $(this).find("i").removeClass("s-dot").addClass("d-dot");
         $(".set > a").removeClass("active");
         $(this).addClass("active");
         $('.content').slideUp(500);
         $(this).siblings('.content').slideDown(500);
      }
   });



/*------- OWL Carousel -------*/

   /*for TWO PRoducts*/
   $(".owltwo.owl-carousel").owlCarousel({
      loop: true,
      margin: 30,
      dots: true,
      items: 2,
   });

   /*Best Sellers Products*/
   $("#best_sellers.owl-carousel").owlCarousel({
      loop: true,
      margin: 15,
      nav: true,
      navText: ["<i class='fa fa-long-arrow-left'></i>", "<i class='fa fa-long-arrow-right'></i>"],
      responsiveClass: true,
      responsive: {
         0: {
            items: 1,
            nav: true
         },
         600: {
            items: 3,
            nav: false
         },
         1000: {
            items: 5,
            nav: true,
            loop: false,
            margin: 20
         }
      }
   });

   /*Product Detail one */
   $("#single_product.owl-carousel").owlCarousel({
      items: 1,
      stagePadding: 50,
      loop: true,
      margin: 10,
      smartSpeed: 450,
      dotData: true,
   });

   /*thumbnail slider*/
   $("#detail_slide.owl-carousel").owlCarousel({
      loop: true,
      items: 1,
      dotsData: true,
      nav: false,
      responsiveClass: true,
   });

   /*Product Detail & Partners Slider*/
   $(".partner_slider.owl-carousel, #single_detail.owl-carousel").owlCarousel({
      loop: true,
      items: 1,
      dots: false,
      nav: true,
      navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
      responsiveClass: true,
   });

   /*Home columns layout*/
   $("#column_slider.owl-carousel").owlCarousel({
      loop: true,
      items: 1,
      dots: false,
      nav: true,
      animateOut: 'fadeOut',
      navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
      responsiveClass: true,
   });

   /*Clients */
   $("#our_clients.owl-carousel").owlCarousel({
      loop: true,
      margin: 0,
      dots: true,
      items: 1,
   });



 /*------- Revolution Slider -------*/

   /*Main Slider Home*/
   $("#rev_digit").show().revolution({
      sliderType: "standard",
      sliderLayout: "fullwidth",
      delay: 4000,
      navigation: {
         keyboardNavigation: "on",
         keyboard_direction: "horizontal",
         mouseScrollNavigation: "off",
         onHoverStop: "on",
         touch: {
            touchenabled: "on",
            swipe_threshold: 75,
            swipe_min_touches: 1,
            swipe_direction: "horizontal",
            drag_block_vertical: false
         },
         arrows: {
            enable: false,

         },
         tabs: {
            style: "",
            enable: true,
            width: 26,
            height: 26,
            min_width: 20,
            wrapper_padding: 0,
            wrapper_color: "transparent",
            wrapper_opacity: "0",
            tmp: '<div class="tp-tab-title">{{title}}</div>',
            visibleAmount: 3,
            hide_onmobile: true,
            hide_under: 993,
            hide_onleave: false,
            hide_delay: 200,
            direction: "horizontal",
            span: false,
            position: "inner",
            space: 10,
            h_align: "center",
            v_align: "bottom",
            h_offset: 0,
            v_offset: 50
         }
      },
      viewPort: {
         enable: true,
         outof: "pause",
         visible_area: "80%"
      },
      responsiveLevels: [1240, 1024, 778, 480],
      gridwidth: [1280, 992, 767, 480],
      gridheight: [860, 760, 400, 380],
      disableProgressBar: "off",
      spinner: "off",
      parallax: {
         type: "mouse",
         origo: "slidercenter",
         speed: 9000,
         levels: [2, 3, 4, 5, 6, 8, 7, 12, 16, 10, 50],
      },
   });


   // ------- with ARROWS -------
   $("#rev_arrows").show().revolution({
      sliderType: "standard",
      sliderLayout: "auto",
      delay: 4000,
      navigation: {
         keyboardNavigation: "on",
         keyboard_direction: "horizontal",
         mouseScrollNavigation: "off",
         onHoverStop: "on",
         touch: {
            touchenabled: "on",
            swipe_threshold: 75,
            swipe_min_touches: 1,
            swipe_direction: "horizontal",
            drag_block_vertical: false
         },
         arrows: {
            style: "",
            enable: true,

         },
      },
      viewPort: {
         enable: true,
         outof: "pause",
         visible_area: "80%"
      },
      responsiveLevels: [1240, 1024, 778, 480],
      gridwidth: [1280, 992, 767, 480],
      gridheight: [750, 650, 500, 380],
      disableProgressBar: "off",
      spinner: "off",
      parallax: {
         type: "mouse",
         origo: "slidercenter",
         speed: 9000,
         levels: [2, 3, 4, 5, 6, 8, 7, 12, 16, 10, 50],
      },
   });



   /* ------- Product Gallery Main ------- */
   $("#projects").cubeportfolio({
      filters: "#project-filter",
      loadMore: "#loadMore-gallery",
      loadMoreAction: "click",
      layoutMode: "mosaic",
      defaultFilter: "*",
      animationType: "slideDelay",
      gapHorizontal: 30,
      gapVertical: 30,
      gridAdjustment: "responsive",
      mediaQueries: [{
         width: 1500,
         cols: 5
   }, {
         width: 1100,
         cols: 4
   }, {
         width: 800,
         cols: 3
   }, {
         width: 480,
         cols: 2
   }, {
         width: 320,
         cols: 1
   }],
      lightboxDelegate: ".cbp-lightbox",
      lightboxGallery: true,
   });

   /*IntagramGrid Cubefolio*/
   $("#instagram-grid").cubeportfolio({
      layoutMode: "mosaic",
      gapHorizontal: 30,
      gapVertical: 30,
      gridAdjustment: "responsive",
   });

   /*Blog Grid*/
   $("#blog_grid").cubeportfolio({
      layoutMode: "grid",
      gapHorizontal: 50,
      gapVertical: 90,
      gridAdjustment: "responsive",
      mediaQueries: [{
         width: 1500,
         cols: 4
   }, {
         width: 1100,
         cols: 3
   }, {
         width: 800,
         cols: 2
   }, {
         width: 480,
         cols: 2
   }, {
         width: 320,
         cols: 1
   }],
   });


   /*Shop 5 Columns*/
   $("#shop_one").cubeportfolio({
      filters: "#project-filter",
      loadMore: "#loadMore-gallery",
      loadMoreAction: "click",
      layoutMode: "mosaic",
      defaultFilter: "*",
      animationType: "slideDelay",
      gapHorizontal: 30,
      gapVertical: 30,
      gridAdjustment: "responsive",
      mediaQueries: [{
         width: 1500,
         cols: 5
   }, {
         width: 1100,
         cols: 5
   }, {
         width: 800,
         cols: 3
   }, {
         width: 480,
         cols: 2
   }, {
         width: 320,
         cols: 1
   }],
      lightboxDelegate: ".cbp-lightbox",
      lightboxGallery: true,
   });

   /*Shop 4 Columns*/
   $("#shop_two").cubeportfolio({
      filters: "#project-filter",
      loadMore: "#loadMore-gallery",
      loadMoreAction: "click",
      layoutMode: "mosaic",
      defaultFilter: "*",
      animationType: "slideDelay",
      gapHorizontal: 30,
      gapVertical: 30,
      gridAdjustment: "responsive",
      mediaQueries: [{
         width: 1500,
         cols: 4
   }, {
         width: 1100,
         cols: 4
   }, {
         width: 800,
         cols: 4
   }, {
         width: 480,
         cols: 2
   }, {
         width: 320,
         cols: 1
   }],
      lightboxDelegate: ".cbp-lightbox",
      lightboxGallery: true,
   });


   /*Shop 3 Columns*/
   $("#shop_three").cubeportfolio({
      filters: "#shop-filter",
      loadMore: "#loadMore-gallery",
      loadMoreAction: "click",
      layoutMode: "mosaic",
      defaultFilter: "*",
      animationType: "slideDelay",
      gapHorizontal: 30,
      gapVertical: 30,
      gridAdjustment: "responsive",
      mediaQueries: [{
         width: 1500,
         cols: 3
   }, {
         width: 1100,
         cols: 3
   }, {
         width: 800,
         cols: 3
   }, {
         width: 480,
         cols: 2
   }, {
         width: 320,
         cols: 1
   }],
      lightboxDelegate: ".cbp-lightbox",
      lightboxGallery: true,
   });



   /*Shop Recent 3 Columns*/
   $("#shop_recent_one").cubeportfolio({
      filters: "#shop-filter",
      loadMore: "#loadMore-gallery",
      loadMoreAction: "click",
      layoutMode: "mosaic",
      defaultFilter: "*",
      animationType: "slideDelay",
      gapHorizontal: 30,
      gapVertical: 30,
      gridAdjustment: "responsive",
      mediaQueries: [{
         width: 1500,
         cols: 3
   }, {
         width: 1100,
         cols: 3
   }, {
         width: 800,
         cols: 3
   }, {
         width: 480,
         cols: 1
   }, {
         width: 320,
         cols: 1
   }],
      lightboxDelegate: ".cbp-lightbox",
      lightboxGallery: true,
   });


   /*Shop Recent 3 Columns*/
   $("#shop_recent_mosaic").cubeportfolio({
      filters: "#project-filter",
      loadMore: "#loadMore-gallery",
      loadMoreAction: "click",
      layoutMode: "mosaic",
      defaultFilter: "*",
      animationType: "slideDelay",
      gapHorizontal: 30,
      gapVertical: 30,
      gridAdjustment: "responsive",
      mediaQueries: [{
         width: 1500,
         cols: 2
   }, {
         width: 1100,
         cols: 2
   }, {
         width: 800,
         cols: 2
   }, {
         width: 480,
         cols: 2
   }, {
         width: 320,
         cols: 1
   }],
      lightboxDelegate: ".cbp-lightbox",
      lightboxGallery: true,
   });


});