use regex;
use fmt;
use strings;
use strconv;

export fn solve(input: str) i64 = {
	const pattern: str = `mul\([0-9]+,[0-9]+\)`;
	const re = match (regex::compile(pattern)) {
	case let re: regex::regex => 
		yield re;
	case regex::error =>
		fmt::fatalf("Error: could not compile patter \"{}\"");
	};
	defer regex::finish(&re);

	const results = regex::findall(&re, input);
	defer regex::result_freeall(results);

	let sum: i64 = 0;

	for (let result .. results) {
		for ( let capture .. result ) {
			let mult_str = strings::dup(capture.content);
			// defer free(mult_str);
			mult_str = strings::trimprefix(mult_str, "mul(");
			mult_str = strings::trimsuffix(mult_str, ")");

			let nums = strings::split(mult_str, ",");
			defer free(nums);

			let pair: (i64, i64) = (0, 0);
			pair.0 = strconv::stoi64(nums[0]) as i64;
			pair.1 = strconv::stoi64(nums[1]) as i64;

			sum += pair.0 * pair.1;
		};
	};

	return sum;
};
