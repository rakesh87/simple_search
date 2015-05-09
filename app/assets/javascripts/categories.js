$(function(){
  // $("#category_search input").keyup(function(e){
  //   e.preventDefault();
  //   $.get($("#category_search").attr('action'), $("#category_search").serialize(), null, 'script');
  // });

  $("#category_search_form").submit(function(e){
    e.preventDefault();
    $.get(this.action, $(this).serialize(), null, 'script');
  });

  $( "#category_search" ).autocomplete({
    source: $('#category_search').data('autocomplete-source'),
    minLength: 2
  });
});
