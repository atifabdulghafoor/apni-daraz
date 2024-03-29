$(document).on('turbolinks:load', function(){
  $("#product_parent_category").change(function(){
    var selectedOption = $(this).find(":selected").val();
    $.ajax({
      url:  "/categories_list",
      type: "post",
      dataType: "json",
      data: {
        parent_id : selectedOption
      },
      success: function(data) { 
        $('#product_category_id').empty();
        $('#product_category_id').append($("<option>Select</option>").val(undefined));
        $.each(data, function($index, $value) {
          $('#product_category_id').append($("<option></option>").val($value.id).html($value.name));
        });
      }
    });
  });
});