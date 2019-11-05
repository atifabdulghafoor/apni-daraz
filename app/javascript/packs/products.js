$(document).hover(function(){
  $("#product_parent_category_id").change(function(){
    var selectedOption = $(this).find(":selected").val();
    if(selectedOption) {
      $('#product-subcategory').removeClass('hide').addClass('show');
    }
    else { 
      $('#product-subcategory').removeClass('show').addClass('hide');
    }
    $.ajax({
      url:  "/products/new",
      dataType: "json",
      success: function(data) { 
        var subcategories = data.filter(function(row){
          return row.parent_id == selectedOption
        })
        // console.log(subcategories)
        $('#product_category_id').empty();
        $('#product_category_id').append($("<option>Select</option>").val(undefined));
        $.each(subcategories, function($index, $value) {
          $('#product_category_id').append($("<option></option>").val($value.id).html($value.name));
        });
      }
    });
  });
});