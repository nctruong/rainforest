$(document).on('ready', function() {
  $('#search-form').on('submit', function(e) {
    e.preventDefault();
    var searchValue = $('#search').val();

    // response as HTML
    // $.ajax({
    //   url: '/products?search=' + searchValue,
    //   dataType: 'html',
    //   method: 'GET',
    //   success: function(data) {
    //     $('#products').html(<tr>data</tr>); // data is the response
    //   }
    // });

    // response as Javascript
    $.ajax({
      url: '/products?search=' + searchValue,
      dataType: 'script',
      method:'GET'
    })

    // refactored from above
    // $.getScript('/products?search=' + searchValue);
  });
});