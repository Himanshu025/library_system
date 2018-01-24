$("document").ready(function(){
	$.ajax({
		type: 'GET',
		dataType: 'json',
		url: window.location.href,
	})
	.done(function(data)
	{
		console.log(data);
		var table = $("#book_template").clone();
		$(".header #heading").html(data.book.name);
		table.find("#book_author").html(data.book.author);
		table.find("#book_isbn").html(data.book.isbn);
		table.find("#book_price").html(data.book.price);
		table.find("#book_publication").html(data.book.publication);
		table.find("#book_version").html(data.book.version);
		table.find("#book_no_of_copies").html(data.book.no_of_copies);
		table.find("#library_id").html(data.book.library_id);
		table.find("#category_id").html(data.book.category_id);
		table.removeAttr("hidden");
		$(".table").append(table);
	})
	.fail(function(textStatus)
	{
		console.log(textStatus);
	});
});