$(document).on('ajax:error', function(event) {
  var details = event.detail;
  var response = details[0], status = details[1], xhr = details[2];
  if (xhr.status == 401) {
    alert('User not Logged in!')
    $('#login')[0].click(); 
  }
})
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
  $("#product_category_id").prop('disabled', true);
  $("#product_parent_category").change(function(){
    var selectedOption = $(this).find(":selected").val();
    if(selectedOption) {
      $("#product_category_id").prop('disabled', false)
      $.ajax({
        url:  "/categories_list",
        type: "POST",
        data: {
          parent_id : selectedOption
        },
        success: function(data) { 
          console.log(data)
          $('#product_category_id').empty();
          $('#product_category_id').append($("<option>Select</option>").val(undefined));
          $.each(data.subcategories, function($index, $value) {
            $('#product_category_id').append($("<option></option>").val($value[0]).html($value[1]));
          });
        }
      });
    } 
    else {
      $("#product_category_id").prop('disabled', true)
    }
  });
});