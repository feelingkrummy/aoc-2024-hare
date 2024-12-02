use strings;
use fmt;
use strconv;
use sort;
use math;

fn compare(a: const *opaque, b: const *opaque) int = {
	const a = a: *u64;
	const a = *a;
	const b = b: *u64;
	const b = *b;
	if ( a < b ) {
		return -1;
	} else if ( a > b ) {
		return 1;
	} else {
		return 0;
	};
};

export fn solve(text: str) u64 = {
	let lines = strings::split(text, "\n");
	defer free(lines);

	let left: []i64 = [];
	let right: []i64 = [];
	let sum: u64 = 0;

	for (let line .. lines) {
		// Gaurd against empty line
		if ( len(line) == 0 ) {
			break;
		};

		const comma_sep = strings::multireplace(line, ("   ", ","));
		defer free(comma_sep);

		const split = strings::split(comma_sep, ",");
		defer free(split);

		const l = strconv::stoi64(split[0]) as i64;
		const r = strconv::stoi64(split[1]) as i64;
		append(left, l);
		append(right, r);
	};


	sort::sort(left, size(i64), &compare);
	sort::sort(right, size(i64), &compare);

	for (let i = 0z; i < len(left); i += 1) {
		let count: i64 = 0;
		for (let r .. right) {
			if (left[i] == r) {
				count += 1;
			};
		};
		sum += (left[i] * count): u64;
	};

	return sum;
};
