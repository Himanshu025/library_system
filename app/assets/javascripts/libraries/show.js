$("document").ready(function(){
	$.ajax({
		type: 'GET',
		dataType: 'json',
		url: window.location.href,
	})
	.done(function(data)
	{
		console.log(data);
		var table = $("#template").clone();
		$(".header #heading").html(data.library.name);
		table.find("#address").html(data.library.address);
		table.find("#phone").html(data.library.phone);
		table.removeAttr("hidden");
		$(".table").append(table);
		getbooks(data.library.id)
	})
	.fail(function(textStatus)
	{
		console.log(textStatus);
	});
});

$("#add_book").html("<button id='add_library' onclick = 'add_new_book()'>Add Book</button>");

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
				alert("Book added!")
				window.location.href='http://localhost:3000/libraries';
			},
			error: function(textStatus)
			{
				console.log(textStatus.responseText);
			}
		});
	});
}

function getbooks(id)
{
	$.ajax({
		type: 'GET',
		dataType: 'json',
		url: '/books'
	})
	.done(function(data1)
	{

		for (var i = 0; i <data1.books.length; i++) 
		{ 
			console.log(id);
			if(data1.books[i].library_id == id){
				var table1 = $("#book_template").clone();
				table1.find("#book_name").html(data1.books[i].name);
				table1.find("#book_author").html(data1.books[i].author);
				table1.find("#book_isbn").html(data1.books[i].isbn);
				table1.find("#book_price").html(data1.books[i].price);
				table1.find("#book_publication").html(data1.books[i].publication);
				table1.find("#book_version").html(data1.books[i].version);
				table1.find("#book_no_of_copies").html(data1.books[i].no_of_copies);
				table1.removeAttr("hidden");
				$(".book").append(table1);
			}
		}
	})
	.fail(function(textStatus) 
	{
		alert("this is failed");
	});
}