$("document").ready(function(){
	$.ajax({
		type: 'GET',
		dataType: 'json',
		url: 'http://localhost:3000/books',
	})
	.done(function(data) 
	{
		$("#add_book").html("<button id='add_book' onclick = 'add_new_book()'>Add Book</button>");
		for (var i = 0; i <data.books.length; i++) 
		{
			var table = $("#book_template").clone();
			table.find("#book_name").html(data.books[i].name);
			table.find("#book_author").html(data.books[i].author);
			table.find("#book_isbn").html(data.books[i].isbn);
			table.find("#book_price").html(data.books[i].price);
			table.find("#book_publication").html(data.books[i].publication);
			table.find("#book_version").html(data.books[i].version);
			table.find("#book_no_of_copies").html(data.books[i].no_of_copies);
			table.find("#show").html("<a id='show_library' href='/books/"+ data.books[i].id+"'>Show</a>");
			table.find("#edit").html("<button id='edit_book' onclick =edit_book(" + data.books[i].id + ") >Edit</button>");
			table.find("#delete").html("<button id='delete_book' onclick = delete_book(" + data.books[i].id +") >Delete</button>");
			table.removeAttr("hidden");
			$(".table").append(table);
		}
	})
	.fail(function(textStatus) 
	{
		alert(textStatus);
	});
});

function add_new_book()
{
	$('#add_book').hide(); 
	var x = document.getElementById("add_new_form");
	x.style.display = "block"
	$('#add_new_form').submit(function(e){
		e.preventDefault();
		$.ajax({
			type : 'POST',
			url : 'http://localhost:3000/books',
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