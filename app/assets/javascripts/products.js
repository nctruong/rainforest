// $(document).on('ready page:load', function() {
$(document).on('ready', function() {
// $(function() {
  console.log("page ready fire!!!")
  // event argument refers to event handler, 'submit' in this case
  $('#search-form').on('submit', function(e) {
    e.preventDefault()
    var searchValue = $('#search').val()

    // response as HTML
    // $.ajax({
    //   url: '/products?search=' + searchValue,
    //   dataType: 'html',
    //   method: 'GET',
    //   success: function(data) {
    //     $('#products').html(data); // data is the response
    //   }
    // });

    // response as Javascript
    // $.ajax({
    //   url: '/products?search=' + searchValue,
    //   dataType: 'script',
    //   method:'GET'
    // });

    $('#products, .pagination').html("")
    $.getScript('/products?search=' + searchValue)
  })

// Pagination procedure:
// 1. When user scrolls near the bottom of the page
  // add a event listener to scroll value

// 2. Send an AJAX request to fetch next set
// 3. Use the response to update the page
// 4. Don't load more if user reaches end of the list
  function distance_from_bottom() {
    var w      = $(window)
    var bottom = w.scrollTop() + w.height()

    return $(document).height() - bottom
  }

  // var nextPageUrl;
  // var currentPageOnLoad = $('.page.current').text();
  // var locked = false
  var locked = false

  $(window).on('scroll', function() {
    if (!locked && distance_from_bottom() <= 100) {
      locked = true

      var url = $('.next > a').attr('href')

      if (url)
        $.getScript(url, function() { locked = false })
      else
        locked = false
    }
  })


    // if (distanceFromBottom <= 100 && nextPageUrl !== proposedNextPage && proposedNextPage !== undefined) {
    //   nextPageUrl = proposedNextPage;

    //   // $.ajax({
    //   //   url: nextPageUrl,
    //   //   method: 'GET',
    //   //   dataType: 'script'
    //   // });

    //   // refactored from above and returned as
    //   $.getScript(nextPageUrl)
    // }

})
