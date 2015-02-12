$(document).ready(function () {

      // Grab the iFrame from above
      var the_iframe = $("iframe#preview");

      // Function to resize iFrame we grabbed
      function resize_iframe () {
        var viewportHeight = $(window).height();
        // Subtract height of "top bar"
        the_iframe.css({ height : viewportHeight - 80 })
      }

      // Resize the iFrame when the page loads
      resize_iframe();

      // Also, resize iFrame when the window is resized
      $(window).resize(resize_iframe);

      // #########################
      // ##### Begin Content #####
      // #########################

      // Proxy Server
      // Change this to whatever you like
      // A local copy on your current computer
      // or a global one on a domain
      var proxy_host = url_to(root);
});
