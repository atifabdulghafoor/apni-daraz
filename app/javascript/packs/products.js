$(document).on('turbolinks:load', function(){
  function showImage(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#profile-pic')
          .attr('src', e.target.result)
      };
      reader.readAsDataURL(input.files[0]);
    }
  };

  $('#user_image').on('change', function() {
    showImage(this);
  });

  $("#product_category_id").prop('disabled', true)
  $("#product_parent_category").change(function(){
    var selectedOption = $(this).find(":selected").val();
    if(selectedOption) {
      $("#product_category_id").prop('disabled', false)
    } 
    else {
      $("#product_category_id").prop('disabled', true)
    }
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