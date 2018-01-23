$("document").ready(function(){
	$.ajax({
		type: 'GET',
		dataType: 'json',
		url: window.location.href,
	})
	.done(function(data)
	{
		var table = $("#template").clone();
		$(".header #heading").html(data.library.name);
		table.find("#address").html(data.library.address);
		table.find("#phone").html(data.library.phone);
		$(".table").append(table);
		getbooks(data.library.id)
	})
	.fail(function(textStatus)
	{
		console.log(textStatus);
	});
});

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
			if(data1.books[i].library_id == id) 
			  var table1 = $("#book_template").clone();
			  table1.find("#book_name").html(data1.books[i].name);
			  table1.find("#book_author").html(data1.books[i].author);
			  table1.find("#book_isbn").html(data1.books[i].isbn);
			  table1.find("#book_price").html(data1.books[i].price);
			  table1.find("#book_publication").html(data1.books[i].publication);
			  table1.find("#book_version").html(data1.books[i].version);
			  table1.find("#book_no_of_copies").html(data1.books[i].no_of_copies);
			  $(".book").append(table1);
		}
	})
	.fail(function(textStatus) 
	{
		alert("this is failed");
	});
}