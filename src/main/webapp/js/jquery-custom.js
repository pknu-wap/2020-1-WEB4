$.fn.getVal = function() {
	var $el = $(this);
	var rValue = "";

	var tagName = $el.prop("tagName");
	var name = $el.prop("name");

	if (tagName === "INPUT" && ($el.data("format") === "date" || $el.data("format") === "yyyy-mm-dd" || $el.data("format") === "date-month" || $el.data("format") === "yyyy-mm")) {
		rValue = getDateValue(checkNull($el.val()));
	} else if ($el.prop("type") === "radio" || $el.prop("type") === "checkbox") {
		rValue = $("input[name='" + name + "']:checked").val();
	} else {
		rValue = checkNull($el.val(), "");
	}

	return rValue;
};

$.fn.setVal = function(value) {
	var $el = $(this);

	var tagName = $el.prop("tagName");
	var name = $el.prop("name");

	if ((tagName === "INPUT" || tagName === "TEXTAREA" || tagName === "SELECT") && $el.prop("type") !== "radio" && $el.prop("type") !== "checkbox") {
		if ($el.data("format") === "date") {
			$el.val(setDateFormat(value));
		} else {
			$el.val(value);
		}
	} else if (tagName === "INPUT" && ($el.prop("type") === "radio" || $el.prop("type") === "checkbox")) {
		$("input:radio[name=" + name + "]:input[value=" + value + "]").attr("checked", true);
	}

	return $el;
}

$.fn.getData = function() {
	var $el = $(this);
	var result = {};

	if ($el.prop("tagName") === "FORM") {
		var $targets = $el.find("[data-field]");

		$targets.each(function(idx, obj) {
			$target = $(obj);

			var field = $target.data("field");
			result[field] = $target.getVal();
		});
	}
};

$.fn.getData = function() {
	var $el = $(this);
	var result = {};

	if ($el.prop("tagName") !== "FORM") {
		return result;
	}

	var $targets = $el.find("[data-field]");

	$targets.each(function(idx, obj) {
		var $target = $(obj);

		var field = $target.data("field");

		result[field] = $target.getVal();
	});

	return result;
};

$.fn.setData = function(data, opts) {
	var $el = $(this);

	if ($el.prop("tagName") !== "FORM") {
		return;
	}

	var $targets = $el.find("[data-field]");

	$targets.each(function(idx, obj) {
		$target = $(obj);

		var field = $target.data("field");

		if (isNull(field)) {
			return;
		} else {
			$target.setVal(checkNull(data[field]), "");
		}
	});
};

$.fn.clear = function() {
	var $el = $(this);

	if ($el.prop("tagName") !== "FORM") {
		return;
	}

	$el.get(0).reset();
};