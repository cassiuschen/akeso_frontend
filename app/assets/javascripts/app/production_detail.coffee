define ['jquery', 'navbar', 'pin', 'onePage'], ($, NavBar, pin, onePage) ->
  NavBar.setActive("production")
  $(".detail-nav").pin
    containerSelector: ".page"
  #$('.detail-page').onepage_scroll
#    sectionContainer: 'section'
#    easing: "ease" # Easing options accepts the CSS3 easing animation such "ease", "linear", "ease-in", "ease-out", "ease-in-out", or even cubic bezier value such as "cubic-bezier(0.175, 0.885, 0.420, 1.310)"
#    animationTime: 1000 # AnimationTime let you define how long each section takes to animate
#    pagination: false # You can either show or hide the pagination. Toggle true for show, false for hide.
#    keyboard: true # Should Keyboard navigation be used
#    updateURL: true # Toggle this true if you want the URL to be updated automatically when the user scroll to each page.
#    #beforeMove: $.noop # This option accepts a callback function. The function will be called before the page moves.
#    #afterMove: $.noop # This option accepts a callback function. The function will be called after the page moves.
#    loop: false # You can have the page loop back to the top/bottom when the user navigates at up/down on the first/last page.
#    responsiveFallbackWidth: false # You can fallback to normal page scroll by defining the width of the browser in which you want the responsive fallback to be triggered. For example, set this to 600 and whenever the browser's width is less than 600, the fallback will kick in.
#    responsiveFallbackHeight: false # You can fallback to normal page scroll by defining the height of the browser in which you want the responsive fallback to be triggered. For example, set this to 600 and whenever the browser's height is less than 600, the fallback will kick in.
#    smooth: true # You can set if a direct move to a slide should iterate over the other slides or not (direct jump)
#    #beforeCreate: $.noop # This option accept a callback function. The function will be called before the onepagescroll is created.
#    #afterCreate: $.noop # This option accept a callback function. The function will be called after the onepagescroll is created.
#    #beforeDestroy: $.noop # This option accept a callback function. The function will be called before the onepagescroll is destroyed.
#    #afterDestroy: $.noop #