$(document).ready(function() {

	$("#selectize").selectize({
		placeholder: "Please select an option",
		options: [],
		valueField: "value",
		labelField: "text",
		searchField: "text",
		sortField: [
		{
			field: "text",
			direction: "asc"
		},
		{
			field: "$score"
		}],
		render: {
			// option: function(data, escape) {
			// 	return "<div class = 'is-size-6'>" + escape(data.text) + "</div>";

			// },
			item: function(data, escape) {
				return "<div class = 'tag is-link is-light m-1 pt-1 is-medium'>" + escape(data.text)+ "</div>";
			}
		}
	});

	Shiny.addCustomMessageHandler("load_options", function(message) {

		// Create an array of key/value JSON pairs
		let options = message.map(function(option) {
			return {"value": option, "text": option}
		});

		console.log(options);

		let selectize_input = $("#selectize")[0].selectize;
		selectize_input.addOption([options]);
	})
})
