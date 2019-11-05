$(document).hover(function(){
  $("#product_parent_category").change(function(){
    var selectedOption = $(this).find(":selected").val();
    $.ajax({
      url:  "/products/new",
      dataType: "json",
      success: function(data) { 
        var subcategories = data.filter(function(row){
          return row.parent_id == selectedOption
        })
        // console.log(subcategories)
        var parent_categories = data.filter(function(row){
          return row.parent_id != null
        })
        if(!selectedOption){
          subcategories = parent_categories;
        }
        $('#product_category_id').empty();
        $('#product_category_id').append($("<option>Select</option>").val(undefined));
        $.each(subcategories, function($index, $value) {
          $('#product_category_id').append($("<option></option>").val($value.id).html($value.name));
        });
      }
    });
  });
});
