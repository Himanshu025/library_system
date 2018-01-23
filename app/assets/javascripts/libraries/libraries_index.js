$("document").ready(function(){
	$.ajax({
		type: 'GET',
		dataType: 'json',
		url: 'http://localhost:3000/libraries',
	})
	.done(function(data) 
	{
		$("#add_library").html("<button id='add_library' onclick = 'add_new_library()'>Add Library</button>");
		for (var i = 0; i <data.libraries.length; i++) 
		{
			var table = $("#template").clone();
			table.find("#name").html(data.libraries[i].name);
			table.find("#address").html(data.libraries[i].address);
			table.find("#phone").html(data.libraries[i].phone);
			table.find("#show").html("<a id='show_library' href='/libraries/"+ data.libraries[i].id+"'>Show</a>");
			table.find("#edit").html("<button id='edit_library' onclick =edit_library(" + data.libraries[i].id + ") >Edit</button>");
			table.find("#delete").html("<button id='delete_library' onclick = delete_library(" + data.libraries[i].id +") >Delete</button>");
			$(".table").append(table);
		}
	})
	.fail(function(textStatus) 
	{
		alert(textStatus);
	});
});

function delete_library(id) 
{      
	$.ajax({
		type: 'POST',
		url: 'http://localhost:3000/libraries/' + id,
		dataType: 'json',
		data: {'_method':'delete'}
	});
	window.location.reload();
}

function add_new_library()
{ 
	$('#add_library').hide(); 
	var x = document.getElementById("add_new_form");
	x.style.display = "block"
	$('#add_new_form').submit(function(e){
		e.preventDefault();
		$.ajax({
			type : 'POST',
			url : 'http://localhost:3000/libraries',
			dataType : 'json',
			data : $('#add_new_form').serialize(),
			success: function(response)
			{
				window.location.reload();
			},
			error: function(textStatus)
			{
				console.log(textStatus.responseText);
			}
		});
	});
}

function edit_library(id)
{
	$('#add_library').hide(); 
	var x = document.getElementById("add_new_form");
	x.style.display = "block",
	$.ajax({
		type: 'GET',
		dataType: 'json',
		url: 'http://localhost:3000/libraries/'+id,
	})
	.done(function(data) 
	{
		document.getElementById('name').value = data.library.name ,
		document.getElementById('address').value = data.library.address,
		document.getElementById('phone').value = data.library.phone
		edit_function(id)
  })
	.fail(function(textStatus) 
	{
		alert(textStatus);
	});
}

function edit_function(id){
$('#add_new_form').submit(function(e){
	e.preventDefault();
		$.ajax({
			url: '/libraries/'+id,
			type: 'PATCH',
			dataType: 'json',
			data : $('#add_new_form').serialize(),
			success: function (data, textStatus, xhr) {
				window.location.reload();
			},
			error: function (xhr, textStatus, errorThrown) {
				console.log('Error in Operation');
			}
		});
	});
}

