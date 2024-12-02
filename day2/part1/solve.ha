use strings;
use fmt;
use types;
use strconv;
use math;

export fn solve(input: str) i64 = {
	let lines = strings::split(input, "\n");
	defer free(lines);

	let data: [][]i64 = [];
	let num_of_safe: i64 = 0;

	for (let line .. lines) {
		let row: []i64 = [];
		if ( len(line) == 0 ) {
			break;
		};
		let cols = strings::split(line, " ");
		defer free(cols);
		for (let col .. cols) {
			const num = strconv::stoi64(col) as i64;
			append(row, num);
		};
		append(data, row);
	};

	for : outer (let row .. data) {
		if ( row[0] - row[1] < 0 ) {
			// Increasing
			for (let i = 1z; i < len(row); i += 1) {
				const diff = row[i] - row[i-1];
				if ( diff <= 0 || diff > 3 ) {
					// Test failed do not count
					continue: outer;
				};
			};
			num_of_safe += 1;
		} else if ( row[0] - row[1] > 0 ) {
			// Decreasing
			for (let i = 1z; i < len(row); i += 1) {
				const diff = row[i-1] - row[i];
				if ( diff <= 0 || diff > 3 ) {
					// Test failed do not count
					continue: outer;
				};
			};
			num_of_safe += 1;
		} else {
			continue: outer;
		};
	};

	return num_of_safe;
};
