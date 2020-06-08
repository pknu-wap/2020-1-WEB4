(function(jsGrid) {

	jsGrid.locales.ko = {
		grid: {
			noDataContent: "데이터가 존재하지 않습니다.",
			deleteConfirm: "삭제하시겠습니까??",
			pagerFormat: "페이지: {first} {prev} {pages} {next} {last} &nbsp;&nbsp; {pageIndex} / {pageCount}",
			pagePrevText: "이전",
			pageNextText: "다음",
			pageFirstText: "처음",
			pageLastText: "마지막",
			loadMessage: "조회중...",
			invalidMessage: "잘못된 자료가 존재합니다.!"
		},

		loadIndicator: {
			message: "조회중..."
		},

		fields: {
			control: {
				searchModeButtonTooltip: "Switch to searching",
				insertModeButtonTooltip: "Switch to inserting",
				editButtonTooltip: "Edit",
				deleteButtonTooltip: "Delete",
				searchButtonTooltip: "Search",
				clearFilterButtonTooltip: "Clear filter",
				insertButtonTooltip: "Insert",
				updateButtonTooltip: "Update",
				cancelEditButtonTooltip: "Cancel edit"
			}
		},

		validators: {
			required: {message: "Field is required"},
			rangeLength: {message: "Field value length is out of the defined range"},
			minLength: {message: "Field value is too short"},
			maxLength: {message: "Field value is too long"},
			pattern: {message: "Field value is not matching the defined pattern"},
			range: {message: "Field value is out of the defined range"},
			min: {message: "Field value is too small"},
			max: {message: "Field value is too large"}
		}
	};

}(jsGrid, jQuery));
