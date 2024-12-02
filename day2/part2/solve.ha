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

	for (let row .. data) {
		let increasing_safe = check_increasing(row);
		let decreasing_safe = check_decreasing(row);
		if ( increasing_safe == 1 || decreasing_safe == 1 ) {
			num_of_safe += 1;
			continue;
		};

		let variations: [][]i64 = [];
		append(variations, row);
		for (let to_skip = 0z; to_skip < len(row); to_skip += 1 ) {
			let var: []i64 = [];
			for (let i = 0z; i < len(row); i += 1) {
				if ( i != to_skip ) {
					append(var, row[i]);
				};
			};
			append(variations, var);
		};
		increasing_safe = 0;
		decreasing_safe = 0;
		for (let var..variations) {
			increasing_safe += check_increasing(var);
			decreasing_safe += check_decreasing(var);
		};

		if ( increasing_safe > 0 || decreasing_safe > 0 ) {
			num_of_safe += 1;
			continue;
		};
	};

	return num_of_safe;
};

fn check_increasing(row: []i64) i64 = {
	for (let i = 1z; i < len(row); i += 1) {
		const diff = row[i] - row[i-1];
		if ( diff <= 0 || diff > 3 ) {
			// Test failed do not count
			return 0;
		};
	};
	return 1;
};

fn check_decreasing(row: [] i64) i64 = {
	// Decreasing
	for (let i = 1z; i < len(row); i += 1) {
		const diff = row[i-1] - row[i];
		if ( diff <= 0 || diff > 3 ) {
			// Test failed do not count
			return 0;
		};
	};
	return 1;
};

fn dump_slice(s: []i64) void = {
	for (let i .. s) {
		fmt::printf("{}, ", i)!;
	};
	fmt::print("\n")!;
};
