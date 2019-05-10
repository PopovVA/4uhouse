import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart' show ReplaySubject;

import 'date_picker_modal.dart' show DatePickerInput;
import 'picker.dart' show Picker;

import 'constants/months.dart' show MONTHS;
import 'constants/initial_arrays.dart' show INITIAL_D_FULL_ARRAY, INITIAL_M_FULL_ARRAY;
import 'helpers/generate_range_list.dart' show generateRangeList;
import 'helpers/grey_color.dart' show greyColourInclude, greyColourBegin;

class DatePicker extends StatefulWidget {
	DatePicker({
		@required Function this.onDateTimeChanged,
		@required DateTime initialDateTime,
		DateTime minimumDate,
		DateTime maximumDate,
		int minimumYear = 1970,
		int maximumYear = 2030,
	}) {
		assert(
			onDateTimeChanged != null,
			'onDateTimeChanged argument is required!',
		);
		assert(
			minimumDate.isBefore(maximumDate),
			'Minimum date should be before maximum date.',
		);
		
		this.initialDateTime = initialDateTime is DateTime
			? initialDateTime
			: DateTime(2000, 1, 1);
		this.yFullArray = generateRangeList([
			(minimumDate is DateTime)
				? minimumDate.year
				: minimumYear,
			(maximumDate is DateTime)
				? maximumDate.year
				: maximumYear,
		]);
		
		this.dMin = minimumDate.day - 1;
		this.mMin = minimumDate.month - 1;
		this.yMin = 0;
		
		this.dMax = maximumDate.day - 1;
		this.mMax = maximumDate.month - 1;
		this.yMax = this.yFullArray.length - 1;
	}
	
	final Function onDateTimeChanged;
	DateTime initialDateTime;
	
	List<int> yFullArray;
	
	int dMin;
	int mMin;
	int yMin;
	
	int dMax;
	int mMax;
	int yMax;
	
	@override
  State<StatefulWidget> createState() {
		return _DatePickerState();
  }
}

class _DatePickerState extends State<DatePicker> {
	FixedExtentScrollController dayScrollController;
	FixedExtentScrollController monthScrollController;
	FixedExtentScrollController yearScrollController;

	ReplaySubject<int> subject;
	
	int dIndex;
	int mIndex;
	int yIndex;
	
	List<int> dArray = INITIAL_D_FULL_ARRAY;
	List<int> mArray = INITIAL_M_FULL_ARRAY;

	bool isPanning;

	@override
	initState() {
		// Initialize indexes
		dIndex = widget.initialDateTime.day - 1;
		mIndex = widget.initialDateTime.month - 1;
		int indexOfYear = widget.yFullArray.indexOf(widget.initialDateTime.year) ;
		yIndex = indexOfYear != -1 ? indexOfYear : 0;

		dayScrollController = FixedExtentScrollController(initialItem: dIndex);
		monthScrollController = FixedExtentScrollController(initialItem: mIndex);
		yearScrollController = FixedExtentScrollController(initialItem: yIndex);

		// Calc greys
    recalculateIndexes();

//		subject = ReplaySubject<int>();
//		subject
//			.throttle(Duration(milliseconds: 500))
//			.listen(updateValues);
		super.initState();
	}

	void recalculateIndexes() {
		dArray = INITIAL_D_FULL_ARRAY;
		mArray = INITIAL_M_FULL_ARRAY;

		if ([4, 6, 9, 11].contains(mIndex + 1)) {
			dArray = greyColourBegin(dArray, 30);
			if (dIndex > 29) dIndex = 29;
		} else {
			if (mIndex + 1 == 2) {
				if (
					widget.yFullArray[yIndex] % 400 == 0 ||
						(widget.yFullArray[yIndex] % 100 != 0 &&
							widget.yFullArray[yIndex] % 4 == 0)
				) {
					dArray = greyColourBegin(dArray, 29);
					if (dIndex > 28) dIndex = 27;
				}
			} else {
				dArray = greyColourBegin(dArray, 28);
				if (dIndex > 27) dIndex = 27;
			}
		}

		int dMax = widget.dMax;
		int mMax = widget.mMax;
		int yMax = widget.yMax;
		if (yIndex >= yMax) {
			yIndex = yMax;
			mArray = greyColourBegin(mArray, mMax + 1);
			if (mIndex >= mMax) {
				mIndex = mMax;
				dArray = greyColourBegin(dArray, dMax + 1);
				if (dIndex >= dMax) {
					dIndex = dMax;
				}
			}
		}

		int dMin = widget.dMin;
		int mMin = widget.mMin;
		int yMin = widget.yMin;
		if (yIndex <= yMin) {
			yIndex = yMin;
			mArray = greyColourInclude(mArray, mMin);
			if (mIndex <= mMin) {
				mIndex = mMin;
				dArray = greyColourInclude(dArray, dMin);
				if (dIndex <= dMin) {
					dIndex = dMin;
				}
			}
		}
	}

	void updateValues() {
	  recalculateIndexes();
	  widget.onDateTimeChanged(
			DateTime(
				widget.yFullArray[yIndex],
				mArray[mIndex],
				dArray[dIndex],
			).toUtc().millisecondsSinceEpoch,
		);
	}

	Widget buildDayPicker() {
		return Picker(
			animateDuration: 1000,
			controller: dayScrollController,
			index: dIndex,
			onSelectedItemChanged: (int index) {
				setState(() {
					dIndex = index;
					updateValues();
				});
			},
			rangeList: dArray,
		);
	}
	
	Widget buildMonthPicker() {
		return Picker(
			animateDuration: 1000,
			controller: monthScrollController,
			displayFunction: (value) => MONTHS[value - 1],
			index: mIndex,
			onSelectedItemChanged: (int index) {
				setState(() {
					mIndex = index;
					updateValues();
				});
			},
			rangeList: mArray,
		);
	}
	
	Widget buildYearPicker() {
		return Picker(
			controller: yearScrollController,
			index: yIndex,
			rangeList: widget.yFullArray,
			onSelectedItemChanged: (int index) {
				setState(() {
					yIndex = index;
					updateValues();
				});
			},
		);
	}

	@override
	Widget build(BuildContext context) {
		return Row(
			children: [
				buildDayPicker(),
				buildMonthPicker(),
				buildYearPicker(),
			],
		);
	}
}
